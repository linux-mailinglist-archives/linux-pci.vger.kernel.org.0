Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AAD497332
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jan 2022 17:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbiAWQtn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 11:49:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53928 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiAWQtl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jan 2022 11:49:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B43BF60F9D;
        Sun, 23 Jan 2022 16:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4962C340E5;
        Sun, 23 Jan 2022 16:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642956580;
        bh=YVXpwoinBAgFzYgroJ4edcwA9fi1zpD4CNhaWjyAp5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+LSJ8piSnq+1s4W/LpG2yc9gLwkPGLXLtyXY9KRk3BHoo5cMHHeuEPl1w0Ggg1nV
         H8iVOY43S/1TC3Bd0FJ93h2TFSdMn4gl1DBLIIWFlj6LKCbJlhPVH2zXRD3ME1UCZG
         sSeFq1S37T/itj6gibFqUuGV/AwhmXaQZRb+28CaK/kEY+XsLJPa6WJgbYKCHZaItK
         VeI35mNIlFb21Fap2haw8tMjY4H/nl+KHUIL+3I/6tYdyPcNfS22nrwhdIyIE0dKvZ
         EBDnx37tfXge9Ks3FH/ncEAV9eZH2HWKe4NpPgI7kmfErhQpzforkcL3et/u6yrcZ4
         8JU4sTb0QUcHg==
Received: by pali.im (Postfix)
        id 28AAA777; Sun, 23 Jan 2022 17:49:37 +0100 (CET)
Date:   Sun, 23 Jan 2022 17:49:37 +0100
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
Message-ID: <20220123164936.cmzvkkkuw5chz3ek@pali>
References: <20220122221554.196311-1-marek.vasut@gmail.com>
 <20220122221554.196311-2-marek.vasut@gmail.com>
 <20220123153147.sv6eoayxqvqbaa66@pali>
 <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 23 January 2022 17:31:28 Marek Vasut wrote:
> On 1/23/22 16:31, Pali Rohár wrote:
> > On Saturday 22 January 2022 23:15:54 marek.vasut@gmail.com wrote:
> > > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > 
> > > In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> > > any read/write access to PCIECDR triggers asynchronous external abort. This
> > > is because the transition to L1 link state must be manually finished by the
> > > driver. The PCIe IP can transition back from L1 state to L0 on its own.
> > 
> > Hello!
> > 
> > I must admit that this patch from its initial version evolved into giant hack...
> > https://lore.kernel.org/linux-pci/20210514200549.431275-1-marek.vasut@gmail.com/
> > 
> > During review of the previous patch I have asked some important
> > questions but I have not got any answer to them. So I'm reminding it:
> > https://lore.kernel.org/linux-pci/20210805183024.ftdwknkttfwwogks@pali/
> > 
> > So could please answer what happens when PCIe controller is in some
> > non-L* state and either MMIO happen or config read happens or config
> > write happens?
> 
> What kind of non-L state ?

E.g. Hot Reset, Detect, Polling, Configuration or Recovery.

> Do you have some specific test which fails ?

Yes, by putting PCIe controller into one of those states. I have already
wrote you in some previous email to trigger hot reset as this is the
easiest test and can be done also by userspace (setpci).

Link goes to Recovery state automatically when doing link retraining
(e.g. by setting RT bit in PCIe Root Port config space) and from
Recovery to Configuration or directly back to L0. So testing this path
needs precise timing and repeating it more times to trigger.

So the easiest test is really via PCIe Hot Reset by setting Secondary
Bus Reset bit in Bridge Control register of PCIe Root Port. After this
is link in Hot Reset and does not go back to L0 until you clear that
bit. So in this state you can do all these operations which cause
aborts, like calling that kernel function which is reading from config
space which belongs to device on the other end of the PCIe link or doing
MMIO read / write operation of mapped memory which again belongs to
other end of PCIe link.

Or instead of Hot Reset, you can set link disable bit in config space of
PCIe Root Port. Then link also would not be in L0 state (until you clear
that bit), so again you have lot of time to do same tests.

> This patch addresses the case where the link transition to L1 state has to
> be completed manually. If the CPU accesses the config space before that
> happened, you get an imprecise data abort.

Yes, I see. But it does not have to complete and the question how is
handled this case... And that is why is needed to know what happens in
such cases.

And IIRC you cannot go from L1 state directly to L0, but only via
Recovery state. And from Recovery you may end up in Detect state.
(e.g. after hot unplug or if some buggy card with kernel quirk is used)

> > It is really important to know this fact.
> > 
> > I'm in impression that this patch still is not enough as similar issues
> > are also in other PCIe controllers which I know...
> 
> Do you have a suggestion for a patch which would be enough on this hardware
> ?

I do not have enough information.
