Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2C4B2DEA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 20:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiBKTni (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 14:43:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiBKTnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 14:43:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7613413A
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 11:43:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E5461FBE
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 19:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1C1C340E9;
        Fri, 11 Feb 2022 19:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644608614;
        bh=NFU1PytHprwVtNjWt/0OwPgIAhFKWgBAwrQywl6Cv4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxsf62KTvG9fSKzSGdcgt1ztsCsmOjEp3fN2g8FeqpTROUfUt0w0iRHk34FfVWHVK
         JM1PajDcNgb4lXwwZieqVC2C4QfzkS3/794FDNCRQIL8+ZpgAf4PDZL/JZqKZqNXuI
         l9mE+WRJqYadXtDwzdOajxQt2/Hg+ROETFQquIS3aGDcrmltdIeX9ZiN5tvmYTFGuL
         6c8ei30tq+lCnosnrvqT7PX9ByOk8+BEzoeZTuN2kFSBMHHraR9X2/eCWsJNxiXDQG
         tsl3FG+CHnX6lc/doVZA1Mkjyy2Pmet+Ce6lsKpBJAq41OzAvBV23B2w7Lth83jyzr
         6HelolHWpesRw==
Received: by pali.im (Postfix)
        id 22FE013A8; Fri, 11 Feb 2022 20:43:31 +0100 (CET)
Date:   Fri, 11 Feb 2022 20:43:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Jan Palus <jpalus@fastmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [Bug 215540] New: mvebu: no pcie devices detected on turris
 omnia (5.16.3 regression)
Message-ID: <20220211194330.siiwntko6b3lldw4@pali>
References: <20220203125528.s5ct2mtwyil2ggmj@pali>
 <20220203154728.GA96160@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203154728.GA96160@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 03 February 2022 09:47:28 Bjorn Helgaas wrote:
> [+cc Lorenzo, beginning of thread:
> https://lore.kernel.org/r/20220127234917.GA150851@bhelgaas]
> 
> On Thu, Feb 03, 2022 at 01:55:28PM +0100, Pali Rohár wrote:
> > On Thursday 03 February 2022 13:26:42 Pali Rohár wrote:
> > > On Thursday 27 January 2022 17:49:17 Bjorn Helgaas wrote:
> > > > On Thu, Jan 27, 2022 at 10:52:43PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=215540
> > > > > 
> > > > >             Bug ID: 215540
> > > > >            Summary: mvebu: no pcie devices detected on turris omnia
> > > > >                     (5.16.3 regression)
> > > > >            Product: Drivers
> > > > >            Version: 2.5
> > > > >     Kernel Version: 5.16.3
> > > > >           Hardware: ARM
> > > > >                 OS: Linux
> > > > >               Tree: Mainline
> > > > >             Status: NEW
> > > > >           Severity: normal
> > > > >           Priority: P1
> > > > >          Component: PCI
> > > > >           Assignee: drivers_pci@kernel-bugs.osdl.org
> > > > >           Reporter: jpalus@fastmail.com
> > > > >         Regression: No
> > > > > 
> > > > > After kernel upgrade from 5.16.1 to 5.16.3 Turris Omnia (Armada 385)
> > > > > no longer detects pcie devices (wifi/msata). Haven't tried 5.16.2
> > > > > but it doesn't seem to have any relevant changes, while 5.16.3
> > > > > carries a few.
> > 
> > I found another issue: Into stable tree was backported "modified" patch.
> > I'm not sure it is is source of this issue but looks like it is related.
> > 
> > If you open mentioned problematic commit in web ui:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.16.y&id=7cde9bf0731688896831f90da9fe755f44a6d5e0
> > 
> > And compare it with patch which is on "Link:" line from commit message:
> > https://lore.kernel.org/r/20211125124605.25915-12-pali@kernel.org
> > 
> > You will see that diffs are different. In my original patch (which I
> > sent to ML) is:
> > 
> >  		mvebu_pcie_setup_hw(port);
> >  		mvebu_pcie_set_local_dev_nr(port, 1);
> > +		mvebu_pcie_set_local_bus_nr(port, 0);
> > 
> > But in git web ui is:
> > 
> >  		mvebu_pcie_setup_hw(port);
> > -		mvebu_pcie_set_local_dev_nr(port, 1);
> > +		mvebu_pcie_set_local_dev_nr(port, 0);
> > 
> > I do not know how it could happen. But local **device** number must be
> > always set to 1 (see comment above code for explanation) and default
> > value of local **bus** number should be 0 (as is in my original patch).
> > 
> > So above patch in stable tree is broken.
> 
> I think current mainline is broken, too, isn't it?  See below.

I see, it is.

> > Bjorn & Greg: How do you want to handle this situation? Should I prepare
> > special patch for stable which fix it? Or something else?
> > 
> > Anyway, do you know how it could happen that patch was incorrectly
> > auto-backported into stable? Differences between original and
> > wrongly-modified patch looks very similar (both "bus" and "dev" keywords
> > have same number of characters) and it was hard for me to see that there
> > are differences. So probably overlooking could happen or maybe git or
> > patch tools could do such small changes when doing backports?
> 
> Your patch on the mailing list [1] contains:
> 
>         mvebu_pcie_setup_hw(port);
>         mvebu_pcie_set_local_dev_nr(port, 1);
>   +     mvebu_pcie_set_local_bus_nr(port, 0);
> 
> 91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus of PCIe Root
> Port via emulated bridge") [2] appeared in v5.17-rc1 and contains:
> 
>         mvebu_pcie_setup_hw(port);
>   -     mvebu_pcie_set_local_dev_nr(port, 1);
>   +     mvebu_pcie_set_local_dev_nr(port, 0);
> 
> And this is the current state of mainline [3].
> 
> 91a8d79fc797 was backported to v5.16.3 as 7cde9bf07316 [4], which also
> contains:
> 
>         mvebu_pcie_setup_hw(port);
>   -     mvebu_pcie_set_local_dev_nr(port, 1);
>   +     mvebu_pcie_set_local_dev_nr(port, 0);
> 
> So I think the problem was a merge error when we first applied this
> for mainline, and we just need to make a patch for mainline, apply it
> for v5.17, and mark it for stable.

Should I prepare and send fixup patch?

> Bjorn
> 
> [1] https://lore.kernel.org/r/20211125124605.25915-12-pali@kernel.org
> [2] https://git.kernel.org/linus/91a8d79fc797
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-mvebu.c?id=v5.17-rc2#n1323
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.16.y&id=7cde9bf07316
