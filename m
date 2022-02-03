Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B48A4A87EF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 16:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351918AbiBCPrk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 10:47:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41336 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351926AbiBCPrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 10:47:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBF12B834D2
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 15:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77575C340E8;
        Thu,  3 Feb 2022 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643903250;
        bh=PXLqvkQiOcFX3SGpz/kjqGN/om0pwSDneq0oLgTzQb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dSCReD3uds1M+0E2nFjI8Be3K8/s5NnRRbo8iE3WzLBWwAIuLkR8/q6zxESTI3E60
         U4Scw/41pm/R9kfNLy+4W7YCOi++qcDn3Oy6jQIru6pzVvO4a8RaNGSiCMk6RJzL0o
         4xaTPZFYxYiueTo5Lzzq/sDVoCK6IBZ7uyaFJ5Mj3YGWT1WrBjh/atd+FrqqagaKfP
         efKIF/uer81BqtKUnsVmtGW8HKzAtW0s6tZjXNvJf6kgQpJeseHJom71AHAgEm3Ul/
         h4flK3giiF3em6lUsCRsML91AcEyUHoWvturqvepe8BP5q+7tkdP4BOwHa20W5Sfmc
         /dbF6i2O86cAA==
Date:   Thu, 3 Feb 2022 09:47:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Jan Palus <jpalus@fastmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [Bug 215540] New: mvebu: no pcie devices detected on turris
 omnia (5.16.3 regression)
Message-ID: <20220203154728.GA96160@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203125528.s5ct2mtwyil2ggmj@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo, beginning of thread:
https://lore.kernel.org/r/20220127234917.GA150851@bhelgaas]

On Thu, Feb 03, 2022 at 01:55:28PM +0100, Pali Rohár wrote:
> On Thursday 03 February 2022 13:26:42 Pali Rohár wrote:
> > On Thursday 27 January 2022 17:49:17 Bjorn Helgaas wrote:
> > > On Thu, Jan 27, 2022 at 10:52:43PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=215540
> > > > 
> > > >             Bug ID: 215540
> > > >            Summary: mvebu: no pcie devices detected on turris omnia
> > > >                     (5.16.3 regression)
> > > >            Product: Drivers
> > > >            Version: 2.5
> > > >     Kernel Version: 5.16.3
> > > >           Hardware: ARM
> > > >                 OS: Linux
> > > >               Tree: Mainline
> > > >             Status: NEW
> > > >           Severity: normal
> > > >           Priority: P1
> > > >          Component: PCI
> > > >           Assignee: drivers_pci@kernel-bugs.osdl.org
> > > >           Reporter: jpalus@fastmail.com
> > > >         Regression: No
> > > > 
> > > > After kernel upgrade from 5.16.1 to 5.16.3 Turris Omnia (Armada 385)
> > > > no longer detects pcie devices (wifi/msata). Haven't tried 5.16.2
> > > > but it doesn't seem to have any relevant changes, while 5.16.3
> > > > carries a few.
> 
> I found another issue: Into stable tree was backported "modified" patch.
> I'm not sure it is is source of this issue but looks like it is related.
> 
> If you open mentioned problematic commit in web ui:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.16.y&id=7cde9bf0731688896831f90da9fe755f44a6d5e0
> 
> And compare it with patch which is on "Link:" line from commit message:
> https://lore.kernel.org/r/20211125124605.25915-12-pali@kernel.org
> 
> You will see that diffs are different. In my original patch (which I
> sent to ML) is:
> 
>  		mvebu_pcie_setup_hw(port);
>  		mvebu_pcie_set_local_dev_nr(port, 1);
> +		mvebu_pcie_set_local_bus_nr(port, 0);
> 
> But in git web ui is:
> 
>  		mvebu_pcie_setup_hw(port);
> -		mvebu_pcie_set_local_dev_nr(port, 1);
> +		mvebu_pcie_set_local_dev_nr(port, 0);
> 
> I do not know how it could happen. But local **device** number must be
> always set to 1 (see comment above code for explanation) and default
> value of local **bus** number should be 0 (as is in my original patch).
> 
> So above patch in stable tree is broken.

I think current mainline is broken, too, isn't it?  See below.

> Bjorn & Greg: How do you want to handle this situation? Should I prepare
> special patch for stable which fix it? Or something else?
> 
> Anyway, do you know how it could happen that patch was incorrectly
> auto-backported into stable? Differences between original and
> wrongly-modified patch looks very similar (both "bus" and "dev" keywords
> have same number of characters) and it was hard for me to see that there
> are differences. So probably overlooking could happen or maybe git or
> patch tools could do such small changes when doing backports?

Your patch on the mailing list [1] contains:

        mvebu_pcie_setup_hw(port);
        mvebu_pcie_set_local_dev_nr(port, 1);
  +     mvebu_pcie_set_local_bus_nr(port, 0);

91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus of PCIe Root
Port via emulated bridge") [2] appeared in v5.17-rc1 and contains:

        mvebu_pcie_setup_hw(port);
  -     mvebu_pcie_set_local_dev_nr(port, 1);
  +     mvebu_pcie_set_local_dev_nr(port, 0);

And this is the current state of mainline [3].

91a8d79fc797 was backported to v5.16.3 as 7cde9bf07316 [4], which also
contains:

        mvebu_pcie_setup_hw(port);
  -     mvebu_pcie_set_local_dev_nr(port, 1);
  +     mvebu_pcie_set_local_dev_nr(port, 0);

So I think the problem was a merge error when we first applied this
for mainline, and we just need to make a patch for mainline, apply it
for v5.17, and mark it for stable.

Bjorn

[1] https://lore.kernel.org/r/20211125124605.25915-12-pali@kernel.org
[2] https://git.kernel.org/linus/91a8d79fc797
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-mvebu.c?id=v5.17-rc2#n1323
[4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.16.y&id=7cde9bf07316
