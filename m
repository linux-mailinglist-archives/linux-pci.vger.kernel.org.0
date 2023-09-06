Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD42879444E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 22:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjIFUNf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjIFUNf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 16:13:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25AE19A3
        for <linux-pci@vger.kernel.org>; Wed,  6 Sep 2023 13:13:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A88C433C7;
        Wed,  6 Sep 2023 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694031211;
        bh=gHK4cuqeEr0qqZCPDMATuZlQ0W24zB9lYpOMm94q+Bc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fBd8krmhVLSH1YiWjjyMRaFqUYnbm7GGMHofP5vSJHKDYqUridOPD13zQCe5MYU7i
         N1YT67abIC8olvpILjyxsqNSSz4pzfSBKQJg/JXbAgS0B0ioQqofBGZe3cJ5aazwyR
         RoMmUspGucci7zylddml/09h0pNFx8CvwkvgmNa00cS1Cr6adMLaRp+u9iTkDRFcI5
         5L0F/5NFZp/OYkWxZW/Ebso5FCrzdLuaEia54/V8/Nm7erCfLilcJWEHNFhR0Xrabh
         mDOC+2vx8EPZASUhB4FBw8Yst5qTrLGcd6taEyRV8PUfTfZaitXj8s7guvFhDkHfbP
         mKXqtu6etNm7A==
Date:   Wed, 6 Sep 2023 15:13:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Sheena Mohan <sheenamo@google.com>,
        Aahil Awatramani <aahila@google.com>,
        Justin Tai <justai@google.com>, joel.a.gibson@intel.com,
        emil.s.tantilov@intel.com, gaurav.s.emmanuel@intel.com,
        mike.conover@intel.com, shaopeng.he@intel.com,
        anthony.l.nguyen@intel.com, pavan.kumar.linga@intel.com,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH 2/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Message-ID: <20230906201329.GA237399@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPjaU2czatpVm9Xs@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 06, 2023 at 11:00:19PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 06, 2023 at 10:59:20PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 06, 2023 at 02:06:23PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 16, 2023 at 05:21:15PM +0000, Bartosz Pawlowski wrote:
> 
> ...
> 
> > > > +/*
> > > > + * Intel IPU E2000 revisions before C0 implement incorrect endianness
> > > > + * in ATS Invalidate Request message body. Although there is existing software
> > > > + * workaround for this issue, it is not functionally complete (no 5-lvl paging
> > > > + * support) and it requires changes in all IOMMU implementations supporting
> > > > + * ATS. Therefore, disabling ATS seems to be more reasonable.
> > > 
> > > Can we reference the commit that added the existing software
> > > workaround?
> 
> > See below.
> 
> Oh, I meant the second question here, i.e.
> 
> > > It sounds like systems that (a) don't require 5-level paging and (b)
> > > use an IOMMU implementation that include the appropriate changes might
> > > still be able to use ATS?  Is there a way for them to do that?
> 
> ^^^ this one.

Sorry, I'm missing your point here.

The comment mentions an existing partial software workaround.
Presumably that was added by some commit, and it would be helpful to
know which one.

The comment also suggests that if the software workaround were
completed (or if a system didn't require 5-level paging) and it had
related changes to its IOMMU driver, we could still use ATS even on
hardware with this defect.

So I'm wondering if there's a way for an IOMMU driver that has the
required changes and can tell that we're not using 5-level paging can
override this quirk that disables ATS.

Maybe we want to unconditionally disable ATS on these broken devices.
In that case, I think we should just completely drop the comments
about the software workaround and IOMMU driver changes because they
wouldn't be relevant.

> > > > + */
> > > > +static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
> > > > +{
> > 
> > > > +	if (pdev->revision < 0x20)
> > 
> > Isn't it the answer to your question?
> > 
> > > > +		quirk_no_ats(pdev);
> > > > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
