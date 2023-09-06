Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0D7944DC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 22:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjIFU5U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 16:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFU5U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 16:57:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A09180
        for <linux-pci@vger.kernel.org>; Wed,  6 Sep 2023 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694033837; x=1725569837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yXD5PGRTYSVZtCbnmUS+zqyioAE6yILbvZkwLM+PRK0=;
  b=Hn8LimXSs11YJ3hHGfs0b6ZulLSVW0fmlMdpdXR5l7pe9/7Vz/bPbBcZ
   eg5/bFZgKXwCxXexMf1sU6Ie9kzzqRRyYnVSAD9USJSgsvfSVv4rFwYco
   ZfQtrMOi24YO4+PYHh1GuCPlhfFMT2NliSt8RMOjS3tnH7s3d+M4IM+eN
   BjpRvUkJs9jgLvNtbFZGCIYVJfAeY2oJM/vi6hWAuBuTjhIeCkZKlqIh4
   tFLjMIU35bRlVta1EHAMnqqf28xIeFut41rRda3u/rCBwRB1mIv3Cp2C/
   WAKTMrp123rGsSCvtjWww6UgaNtZSlSbYkHcJhkfiNGrLUPMD9LTZCiEx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357494942"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="357494942"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="770961635"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="770961635"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:56:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qdzZT-0079df-1y;
        Wed, 06 Sep 2023 23:56:19 +0300
Date:   Wed, 6 Sep 2023 23:56:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZPjnc+glWm+caXxY@smile.fi.intel.com>
References: <ZPjaU2czatpVm9Xs@smile.fi.intel.com>
 <20230906201329.GA237399@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906201329.GA237399@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 06, 2023 at 03:13:29PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 06, 2023 at 11:00:19PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 06, 2023 at 10:59:20PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 06, 2023 at 02:06:23PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Aug 16, 2023 at 05:21:15PM +0000, Bartosz Pawlowski wrote:

...

> > > > > +/*
> > > > > + * Intel IPU E2000 revisions before C0 implement incorrect endianness
> > > > > + * in ATS Invalidate Request message body. Although there is existing software
> > > > > + * workaround for this issue, it is not functionally complete (no 5-lvl paging
> > > > > + * support) and it requires changes in all IOMMU implementations supporting
> > > > > + * ATS. Therefore, disabling ATS seems to be more reasonable.
> > > > 
> > > > Can we reference the commit that added the existing software
> > > > workaround?
> > 
> > > See below.
> > 
> > Oh, I meant the second question here, i.e.
> > 
> > > > It sounds like systems that (a) don't require 5-level paging and (b)
> > > > use an IOMMU implementation that include the appropriate changes might
> > > > still be able to use ATS?  Is there a way for them to do that?
> > 
> > ^^^ this one.
> 
> Sorry, I'm missing your point here.
> 
> The comment mentions an existing partial software workaround.
> Presumably that was added by some commit, and it would be helpful to
> know which one.
> 
> The comment also suggests that if the software workaround were
> completed (or if a system didn't require 5-level paging) and it had
> related changes to its IOMMU driver, we could still use ATS even on
> hardware with this defect.
> 
> So I'm wondering if there's a way for an IOMMU driver that has the
> required changes and can tell that we're not using 5-level paging can
> override this quirk that disables ATS.
> 
> Maybe we want to unconditionally disable ATS on these broken devices.
> In that case, I think we should just completely drop the comments
> about the software workaround and IOMMU driver changes because they
> wouldn't be relevant.

I see now what you are for. Yes, I agree that if we can't provide a workaround
then probably comment is a bit bogus.

> > > > > + */
> > > > > +static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
> > > > > +{
> > > 
> > > > > +	if (pdev->revision < 0x20)
> > > 
> > > Isn't it the answer to your question?
> > > 
> > > > > +		quirk_no_ats(pdev);
> > > > > +}

-- 
With Best Regards,
Andy Shevchenko


