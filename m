Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD71F7B7223
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 21:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjJCT7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 15:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjJCT7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 15:59:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D00D9E;
        Tue,  3 Oct 2023 12:59:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD9FC433C8;
        Tue,  3 Oct 2023 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696363190;
        bh=poFBeksTBFLl6HJHjXoPqrt53LjbHt/SI93iE0rlrbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HubK4OR0QvzUQYl4qzTJa5Ml/wnGhVxflFifB+5/sk2mdDdDTJFGPSX8sUTIg/Xnm
         idJi1nOjmwt9LoSh9YDvyJXZn2HkugsWxqLaRgdWNEbwdEVRN50esVednz0yMFvYFx
         ssJCXQcQgdL1mcgNFp8f6xJteT8qTbfG/x5dHVHc5DY0UMdgiIsbnlabOP6cUDFYjP
         LssSuZi3bTqzms8PWwqjYAXlAsDQrXgdAy1Muy9nMCTsLS36ub1x4Vqjl+GHx5gCwm
         bV2Zni7UhWEPVkbsY000FBCyQm04HxB9W299toDBCERnOkahfbryaa6fsh3/+88S4y
         72J+IQsVwbPjg==
Date:   Tue, 3 Oct 2023 14:59:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231003195947.GA685849@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215fbc3b-e7ed-4100-808f-ce5df292039f@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 03, 2023 at 02:24:26PM -0500, Mario Limonciello wrote:
> On 10/3/2023 14:16, Bjorn Helgaas wrote:
> > On Tue, Oct 03, 2023 at 01:37:34PM -0500, Mario Limonciello wrote:
> > > On 10/3/2023 13:31, Bjorn Helgaas wrote:
> ...

> > > > That's one thing I liked about the v20 iteration -- instead of
> > > > pci_d3cold_disable(), we changed dev->pme_support, which should mean
> > > > that we only avoid D3hot/D3cold if we need PMEs while in those states,
> > > > so I assumed that we *could* use D3 when we don't need the wakeups.
> > > 
> > > If you think it's worth spinning again for this optimization I think a
> > > device_may_wakeup() check on the root port can achieve the same result as
> > > the v20 PME solution did, but without the walking of a tree in the quirk.
> > 
> > Why would we use device_may_wakeup() here?  That seems like too much
> > assumption about the suspend path,
> 
> Because that's what pci_target_state() passes as well to determine if a
> wakeup is needed.

That's exactly what I mean about having too many assumptions here
about other parts of the kernel.  I like pme_support because it's the
most specific piece of information about the issue and we don't have
to know anything about how pci_target_state() works to understand it.

> > and we already have the Root Port
> > pci_dev, so rp->pme_support is available.  What about something like
> > this:
> 
> It includes the round trip to config space which Lukas called out as
> negative previously but it should work.

True.  But I can't get too excited about one config read in the resume
path.

> > +	rp = pcie_find_root_port(dev);
> > +	if (!rp->pm_cap)
> > +		return;
> > +
> > +	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
> > +				    PCI_PM_CAP_PME_SHIFT);

Is it actually necessary to look up the Root Port here?  Would it be
enough if we removed D3 from the xHCI devices (0x162e, 0x162f, 0x1668,
0x1669), e.g., just do this:

  dev->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
                              PCI_PM_CAP_PME_SHIFT);

I assume that if we knew the xHCI couldn't generate wakeups from D3,
we would leave the xHCI in D0, and that would mean we'd also leave the
Root Port in D0?

Or is the desired behavior that we put the xHCI in D3hot/cold and only
leave the the Root Port in D0?

Bjorn
