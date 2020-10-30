Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EA52A0320
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 11:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJ3Kpz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 30 Oct 2020 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ3Kpy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 06:45:54 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D02C0613CF
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2020 03:45:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id CD9FF140835;
        Fri, 30 Oct 2020 11:45:51 +0100 (CET)
Date:   Fri, 30 Oct 2020 11:45:44 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= 
        <toke@redhat.com>, vtolkm@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201030114544.0df96939@nic.cz>
In-Reply-To: <20201030100807.74r3vp4kyw44kcwp@pali>
References: <871rhhmgkq.fsf@toke.dk>
        <20201029193022.GA476048@bjorn-Precision-5520>
        <20201029215853.6ccce4e0@nic.cz>
        <20201030100807.74r3vp4kyw44kcwp@pali>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 30 Oct 2020 11:08:07 +0100
Pali Rohár <pali@kernel.org> wrote:

> On Turris Omnia (with pci-mvebu) PERST# pin from wifi card is connected
> to MCU and it asserts/deasserts this pin only after board reset. Also it
> is shared line across all mPCIe slots and also with other peripherals.
> 
> So we cannot issue reset via PERST# signal on Turris Omnia. But there
> are other ways how to issue fundamental reset, via in band signaling.

We can code this into MCU code, AFAIK it is upgradable from main CPU
via I2C :) I wanted to try this because of LEDs anyway...

But I think that all 3 PCIe slots have their PERST# signal connected to
just one GPIO on the MCU...
