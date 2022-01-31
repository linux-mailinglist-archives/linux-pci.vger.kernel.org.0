Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C884A4794
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 13:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376924AbiAaMxr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 07:53:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38502 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359418AbiAaMxr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 07:53:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA353B82ABF;
        Mon, 31 Jan 2022 12:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43299C340E8;
        Mon, 31 Jan 2022 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643633624;
        bh=h3la7j1QtcrcPE/wQkK1VY9pk3tHq37N0v65H1pzACk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7iTi3x0++h4cEnppzOoO0o06msLL0wg9f21sId/vlmNiUHnUWZEsjitTTDIuR7pZ
         2HxeJXjY4psy+tXpnP9Tynjqp7ZmzFsJa9g4ksd6mvKcphwJyTbX0Fq8ZXmqCIKtDh
         zWYRLpjoOzizsLp8BvP23Q6aFHLLcvkC06paOWDgVSekzlwvaj+oFiDRK6Z9evtLBD
         A16VTCjWQW9HHwOxeMKUFOU+oUV/JxVkw5wVe/NW8rHxQWs74QDbenmcSM6E1Neb5X
         dkZiE+X2ZidReII4tc4EA9jQtt3y7JbMHH74X4jxRHnN3RmuTmkhuB/Sy8I6oNfC2H
         wVf6EUjMgrQDw==
Received: by pali.im (Postfix)
        id D59C17B6; Mon, 31 Jan 2022 13:53:41 +0100 (CET)
Date:   Mon, 31 Jan 2022 13:53:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which
 triggered an exception
Message-ID: <20220131125341.7jzckjihz3cwrxg3@pali>
References: <20220122221554.196311-1-marek.vasut@gmail.com>
 <20220122221554.196311-2-marek.vasut@gmail.com>
 <20220123153147.sv6eoayxqvqbaa66@pali>
 <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
 <20220123164936.cmzvkkkuw5chz3ek@pali>
 <9d89314c-8757-8965-0f5d-14fd95669320@gmail.com>
 <20220124093752.l2kpenot6wj76753@pali>
 <65a09af0-f09d-cf46-3d04-d7c9d2750227@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65a09af0-f09d-cf46-3d04-d7c9d2750227@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 29 January 2022 05:39:40 Marek Vasut wrote:
> On 1/24/22 10:37, Pali Rohár wrote:
> > On Monday 24 January 2022 06:46:47 Marek Vasut wrote:
> > > On 1/23/22 17:49, Pali Rohár wrote:
> > > 
> > > Hi,
> > > 
> > > [...]
> > > 
> > > > > > I must admit that this patch from its initial version evolved into giant hack...
> > > > > > https://lore.kernel.org/linux-pci/20210514200549.431275-1-marek.vasut@gmail.com/
> > > > > > 
> > > > > > During review of the previous patch I have asked some important
> > > > > > questions but I have not got any answer to them. So I'm reminding it:
> > > > > > https://lore.kernel.org/linux-pci/20210805183024.ftdwknkttfwwogks@pali/
> > > > > > 
> > > > > > So could please answer what happens when PCIe controller is in some
> > > > > > non-L* state and either MMIO happen or config read happens or config
> > > > > > write happens?
> > > > > 
> > > > > What kind of non-L state ?
> > > > 
> > > > E.g. Hot Reset, Detect, Polling, Configuration or Recovery.
> > > > 
> > > > > Do you have some specific test which fails ?
> > > > 
> > > > Yes, by putting PCIe controller into one of those states. I have already
> > > > wrote you in some previous email to trigger hot reset as this is the
> > > > easiest test and can be done also by userspace (setpci).
> > > > 
> > > > Link goes to Recovery state automatically when doing link retraining
> > > > (e.g. by setting RT bit in PCIe Root Port config space) and from
> > > > Recovery to Configuration or directly back to L0. So testing this path
> > > > needs precise timing and repeating it more times to trigger.
> > > > 
> > > > So the easiest test is really via PCIe Hot Reset by setting Secondary
> > > > Bus Reset bit in Bridge Control register of PCIe Root Port. After this
> > > > is link in Hot Reset and does not go back to L0 until you clear that
> > > > bit. So in this state you can do all these operations which cause
> > > > aborts, like calling that kernel function which is reading from config
> > > > space which belongs to device on the other end of the PCIe link or doing
> > > > MMIO read / write operation of mapped memory which again belongs to
> > > > other end of PCIe link.
> > > > 
> > > > Or instead of Hot Reset, you can set link disable bit in config space of
> > > > PCIe Root Port. Then link also would not be in L0 state (until you clear
> > > > that bit), so again you have lot of time to do same tests.
> > > 
> > > Can you give me the exact setpci invocation ? If so, then I can test this
> > > for you on the hardware.
> > 
> > Call "setpci -s $bdf_root_port BRIDGE_CONTROL" with address of the PCIe
> > Root Port device (parent of selected device). This will print value of
> > bridge control register. Logical OR it with value 0x20 (Secondary Bus
> > Reset Bit) and call "setpci -s $bdf_root_port BRIDGE_CONTROL=$new_value".
> > After this call is link in the Hot Reset state and you can do any test.
> > To bring link back, call setpci again with cleared 0x20 bit mask.
> > 
> > Similar test you can done also with setting Link Disable bit (bit 4) in
> > PCIe Link Control register. Offset to this register is not static and
> > you can figure it out from lspci -s $bdf_root_port -vv output.
> > Retrain Link is bit 5 in the same register.
> 
> Flipping either bit makes no difference, suspend/resume behaves the same and
> the link always recovers.

Ok, perfect! And what happens without suspend/resume (just in normal
conditions)? E.g. during active usage of some PCIe card (wifi, sata, etc..).
