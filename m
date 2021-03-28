Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3AA34BC8B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhC1OJe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 10:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhC1OJP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Mar 2021 10:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C00996193A;
        Sun, 28 Mar 2021 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616940555;
        bh=DHwJSTtuCKRKmPj4HNFhZMEWl63yFpOKo19nx3Oh+3s=;
        h=Date:From:To:Cc:Subject:From;
        b=Hrva6G+Q2NIAGwKa+PmxeE0rKif0gKF2H7q7deh9rjIqAEVlG1MvFvssQFhgVpemG
         k4YYw6Cwi/geTcwp/uTlIswoSWytbfagefbGEBL0i/4WOGaPAfOpH0wC92yf6iK+Hl
         h54/uKPrkS2bKtaYipkKQcyenK0WgJ37LtYNvxbh95ZyfWolkTglOVBmxU76lWD8BQ
         U13afxkgfd+YAyrNwZhQxbcSTKO/A//JpiDTtfX6P8iroNGaH5so4NOtF9I467DHPh
         1xFfocDEpuK1EI7qdMg5j0ldudrMEG/EHYzceytl8MwDO7ghLQIWg9y92Mat5UJOO0
         ZQJ1X5KhtFrJw==
Received: by pali.im (Postfix)
        id 5BB5656D; Sun, 28 Mar 2021 16:09:12 +0200 (CEST)
Date:   Sun, 28 Mar 2021 16:09:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Interrupts in pci-aardvark
Message-ID: <20210328140912.k33qqfpkizdtlrcp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

I need some help with fixing interrupt handling in pci-aardvark.c
driver. If my understanding of HW is correct then whole interrupt
hierarchy for aardvark PCIe controller looks like this tree diagram:

                                     GIC
                                      |
                                      v
                                 Aardvark TOP
                                 |    |    |
                                 v    |    v
                                ...   |   ...
                                      |
                                      v
             +----+----+----+-- Aardvark CORE --+----+----+----+----+-- ...
             |    |    |    |    |    |    |    |    |    |    |
             v    v    v    v    v    v    v    v    |    v    v
            PME  ERR INTA INTB INTC INTD Link  Hot   |   ...  ...
                                         Down Reset  |
                                                     |
                                                     v
                 +----------------------------- Aardvark MSI ----------- ... ---------------+
                 |                                   |                                      |
                 v                                   v                                      v
   +------+- MSI bit0 --+- .. -+       +------+- MSI bit1 --+- .. -+          +------+- MSI bit31 -+- .. -+
   |      |      |      |      |       |      |      |      |      |          |      |      |      |      |
   v      v      v      v      v       v      v      v      v      v          v      v      v      v      v
  MSI    MSI    MSI    ...    MSI     MSI    MSI    MSI    ...    MSI        MSI    MSI    MSI    ...    MSI
0x0000 0x0020 0x0040        0xFFE0  0x0001 0x0021 0x0041        0xFFE1     0x001F 0x003F 0x005F        0xFFFF


Aardvark TOP interrupt is handled by advk_pcie_irq_handler() which then
calls advk_pcie_handle_int() for processing aardvark CORE interrupts and
then if summary MSI bit is set is called also advk_pcie_handle_msi().

When GIC triggers summary aardvark TOP interrupt then from aardvark HW I
can read which particular bits were set and therefore it is possible
that more interrupt happened. E.g. PME, ERR, INTB and MSI bit 4,5,8 can
be set at the same time. But for each MSI bit can be set only one final
16bit MSI interrupt number. So in interrupt handler I need to issue
callbacks for all those interrupts after mapping them to linux interrupt
numbers.

Aardvark HW allows to mask summary TOP, summary CORE, individual CORE
(PME, ERR, INTA, INTB, ...), summary MSI and individual MSI bits
interrupts, but not final 16 bit MSI interrupt number. MSI bits are low
5 bits of 16 bit interrupt number. So it is not possible to mask or
unmask MSI interrupt number X. It is possible to only mask/unmask all
MSI interrupts which low 5 bits is specific value.

Also aardvark HW allows to globally enable / disable processing of MSI
interrupts. Masking summary MSI interrupt just cause that GIC does not
trigger it but from registers I can read it (e.g. when GIC calls
aardvark interrupt handler for other non-MSI interrupt).

And I would like to ask, what is in this hierarchy from kernel point of
view "bottom part of MSI" and what is the "upper part of MSI"? As in
above diagram there are 3 MSI layers.

And which irq enable/disable/mask/unmask/ack callbacks I need to
implement for legacy irq, bottom MSI and upper MSI domains?

And where should I add code which globally enable/disable receiving of
aardvark MSI interrupts? Currently it is part of aardvark driver probe
function.
