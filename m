Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C71C79441A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 21:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbjIFT7i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 15:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243609AbjIFT7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 15:59:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6F1990
        for <linux-pci@vger.kernel.org>; Wed,  6 Sep 2023 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694030367; x=1725566367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FHS+1rm/tgjf9zLqXYysPaxSpms+hyqG9O4qNjZdT4M=;
  b=EsMZgXSonj7/MoTWDIpQ1LU1tEoISdu24O8Nl+wqSzpzJfj70IV5UVTB
   b3wgDNDaBQzpIGiI88F1UqeHvKeg73i5Ks+HhLSaC9xukJqyxRb/vgyZo
   8JvUaIt7FMHYI/Nh1jpbh2DrfA/ORC6O6Er7UIXvZEK/7MLQ4cTdounBO
   QW6J34Ulx0Qi1K6Bt75AxAtf3rMV9xnf+BBUK11vbMcFLEg0Zfj72sYgE
   vkeJFW1UykwQ/jRudn8wUa8QsZjZS0OZ/RZ2DfSG6kN+cewsawuM7aqVd
   AN4pA88vakP0H5rcM3TXOMK4K+tf+OpcbB22YhvwOIChae+X4YGqp7l0n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="443556541"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="443556541"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 12:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="735197719"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="735197719"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 12:59:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qdygK-00791Q-1u;
        Wed, 06 Sep 2023 22:59:20 +0300
Date:   Wed, 6 Sep 2023 22:59:20 +0300
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
Message-ID: <ZPjaGJ/BWiijSwUj@smile.fi.intel.com>
References: <20230816172115.1375716-3-bartosz.pawlowski@intel.com>
 <20230906190623.GA234852@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906190623.GA234852@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 06, 2023 at 02:06:23PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 16, 2023 at 05:21:15PM +0000, Bartosz Pawlowski wrote:

...

> > +/*
> > + * Intel IPU E2000 revisions before C0 implement incorrect endianness
> > + * in ATS Invalidate Request message body. Although there is existing software
> > + * workaround for this issue, it is not functionally complete (no 5-lvl paging
> > + * support) and it requires changes in all IOMMU implementations supporting
> > + * ATS. Therefore, disabling ATS seems to be more reasonable.
> 
> Can we reference the commit that added the existing software
> workaround?

See below.

> It sounds like systems that (a) don't require 5-level paging and (b)
> use an IOMMU implementation that include the appropriate changes might
> still be able to use ATS?  Is there a way for them to do that?
> 
> > + */
> > +static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
> > +{

> > +	if (pdev->revision < 0x20)

Isn't it the answer to your question?

> > +		quirk_no_ats(pdev);
> > +}

-- 
With Best Regards,
Andy Shevchenko


