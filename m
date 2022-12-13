Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3264AF70
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 06:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiLMFt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 00:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiLMFt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 00:49:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC521A225
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 21:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670910564; x=1702446564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tX0TjaslqXNz096f6RtxjkBPGQzyxRVVQU5TzPEmr20=;
  b=Q97qrTqiAF2JiUWUk9oekB1q8TwFTpqQJbf2TSt4sZfpX8zts1EwAZcR
   5SZBE/KUACuKFJhrtWkXxDD8AJXHSRlhbWhHx6xeeeLgDMlXqfJ2Cbxit
   4pyb+up9g/izKukGjxjrKefo+BJnOZiA42h7S6PZ3q3Gty92HadtDCIeB
   AoBU4kG0T0pYo9/wfTEeJMM/myByztII+4wNE+jQ36vqZwOOFVWX+x7SN
   3SFGNU54ILR3WRqThcSBzYrgvRFXOpS/z8AKDIvEjo4VWTeWGNdQJ2yNM
   VfC/EhpDzuEnlcTg0oeM+REbba1JJ+IK58ErOfFbxy02O39ePpFNooC03
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="315687191"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="315687191"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 21:49:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="790773490"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="790773490"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2022 21:49:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BE8D9179; Tue, 13 Dec 2022 07:49:48 +0200 (EET)
Date:   Tue, 13 Dec 2022 07:49:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alexander Motin <mav@ixsystems.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Nick Wolff <nwolff@ixsystems.com>,
        Bjorn Helgaas <bjorn@helgaas.com>, linux-pci@vger.kernel.org
Subject: Re: pci_bus_distribute_available_resources() is wrong?
Message-ID: <Y5gSfJd0H4rKXe9H@black.fi.intel.com>
References: <2ec11223-edb3-5f5c-62cd-3532d92de0a4@ixsystems.com>
 <CAErSpo7WrAg5D4xyv0SycoDc1etSspU_TL6XMAK4STYrXDrGNQ@mail.gmail.com>
 <6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Dec 12, 2022 at 04:10:16PM -0500, Alexander Motin wrote:
> On 12.12.2022 15:32, Bjorn Helgaas wrote:
> > On Mon, Dec 12, 2022 at 1:36 PM Alexander Motin <mav@ixsystems.com> wrote:
> > > Hi,
> > > 
> > > I am writing to you three as the authors of Linux
> > > drivers/pci/setup-bus.c pci_bus_distribute_available_resources()
> > > function.  Trying to debug PCI hot-plug issue on passive side of AMD NTB
> > > I hit this function, behavior of which I looks very suspicious to me,
> > > which I believe cause resource allocation problems we observe.
> > > 
> > > As I see, this function distributes extra size of parent memory window
> > > of hot-plug PCI bridge between memory windows of child bridges.  It
> > > probably makes some sense, but I see a problem in the fact that the
> > > function only looks on children bridge memory windows, but not any other
> > > resources (of bridges or other devices that may be there).

Right the idea was that we allocate the spare resources for the possible
hotplug downstream ports so that it is possible to extend that topology
without running out of resources. This is mostly used with
Thunderbolt/USB4 PCIe tunneling.

However, like many have noticed, it does not handle the more generic PCI
case well. Sorry about that.

> > > In my AMD NTB case PCI topology looks this way:
> > > 
> > > +-[0000:80]-+-00.0
> > > |           +-01.1-[81-83]----00.0-[82-83]----00.0-[83]--+-00.0 Dummy
> > > |           |                                            \-00.1 NTB
> > > 
> > > 80:01.1 is the root bridge where the hot-plug happens.  The 81:00.0
> > > bridge in addition to memory windows has small 16KB BAR.  But since it
> > > is the only bridge on the bus, the function passes all available
> > > resources down to its children.  As result, that BAR fails to allocate.
> > >    And while that BAR seems not really needed, in some cases the
> > > allocation error makes whole memory window to be disabled, that ends up
> > > in NTB device driver attach failure.

Just out of the curiosity, is this PCIe or PCI topology?

> > Mika is working on what sounds like the same problem.  His current
> > patch series is at
> > https://lore.kernel.org/linux-pci/20221130112221.66612-1-mika.westerberg@linux.intel.com/
> > 
> > We would appreciate your comments and testing as that series is developed.
> 
> Thank you, Bjorn.  This definitely looks related, but as you've already
> noted in your review there, present patch does not handle BARs of the bridge
> itself, that I have in my case.  I'd be happy to test the updated patch.
> Please keep me in a loop.
> 
> I also agree with your comment that the same should be done in case of
> multiple bridges.  I am generally not sure the cases of single bridge or not
> having hot-plug on this level should be any specific.

Yeah, I'm working on a new version of the patch series that should take
these into consideration. The challenge is that the code has been used
with the Thunderbolt/USB4 PCIe tunneling for some time already and we
don't want to break that either.

I'm also more than happy to test any patches regarding this if someone
else wants to work on it ;-)
