Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1668B34FF5D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 13:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhCaLSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 07:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235112AbhCaLSK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 07:18:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1AE16195D;
        Wed, 31 Mar 2021 11:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617189489;
        bh=v3eG55/hlOS59mgBTQuADs9f/DhtPcykdyJ7RJxRUr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iM1Nxe1stsGRQT0Wf0GSpO/N6lEOUObaYi2CCsaUYgNlSxLO0EJUdJleD0921lf+G
         +vKFtEo9IAs37vr2MW1lXm9GRdVbXaXURxR+ZEMHQLeWsdCgqGg5QDmhhHuA+8DBoh
         yBTS0sU3Z+KW2iyQgziSWI/UrDUjQDY+V6+EdHcqori+W9evk16F2S/mIN9lOXr5fF
         fHhm5ymRgupjDDH8B4Za0qDyIS1H3k7uUEHAnmzP8GvyPHKVTEQplOVxY68fAoxr6a
         C9oRqx6yyMVvXCEsR/imb6BcH/MF71INalE2cf/9LUTg+J4H19HZJQ7Wef+df+bxK9
         s60mW6YCwFOjQ==
Received: by pali.im (Postfix)
        id 1C638AF7; Wed, 31 Mar 2021 13:18:07 +0200 (CEST)
Date:   Wed, 31 Mar 2021 13:18:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: Interrupts in pci-aardvark
Message-ID: <20210331111806.jilkh5wjxuk5lfqg@pali>
References: <20210328140912.k33qqfpkizdtlrcp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210328140912.k33qqfpkizdtlrcp@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 28 March 2021 16:09:12 Pali Rohár wrote:
> 
>                                      GIC
>                                       |
>                                       v
>                                  Aardvark TOP
>                                  |    |    |
>                                  v    |    v
>                                 ...   |   ...
>                                       |
>                                       v
>              +----+----+----+-- Aardvark CORE --+----+----+----+----+-- ...
>              |    |    |    |    |    |    |    |    |    |    |
>              v    v    v    v    v    v    v    v    |    v    v
>             PME  ERR INTA INTB INTC INTD Link  Hot   |   ...  ...
>                                          Down Reset  |
>                                                      |
>                                                      v
>                                                 Aardvark MSI

I have another question about PME, ERR, HP and Link interrupts.

Normally kernel sees a real PCIe Root Bridge device on PCIe bus and this
Root Bridge implements lot of functionality with INTx or MSI interrupts
which are triggered when some PME, ERR, HP or other action happens. When
INTx/MSI interrupts happens then pcie kernel drivers read from more PCIe
status registers which action happened (PME, ERR, etc...).

PCIe controller on Armada 37xx does not see any PCIe Root Bridge on the
bus, there is directly only endpoint or upstream part of packet switch.
Instead Armada 37xx provides registers which can be used to implement
virtual/emulated PCIe Root Bridge.

And now the issue is, when PME, ERR or any other action happens, GIC
triggers interrupts and from aardvark CORE bits can be read which action
happens.

But because kernel pcie drivers for AER, PME or HP expects INTx/MSI
interrupt, it is required to convert aardvark PME/ERR/... into INTA
interrupt (because emulated bridge supports only INTx). Which means that
specific action (e.g. ERR for AER) is now shared with all INTA
interrupts and kernel needs to in chain call all drivers which uses
shared INTA interrupt on IRQ domain for INTA. Which obviously degrades
performance.

Is there any way how to solve this issue without performance
degradation? E.g. it is possible to allocate special IRQ INTx domain
just for one particular PCIe device (that emulated PCIe Root Bridge)? So
when PME or ERR interrupt happens, aardvark interrupt handler would
convert it to INTA interrupt just for one device = Root Bridge.
