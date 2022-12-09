Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3395648A17
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 22:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLIVdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 16:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIVdM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 16:33:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA81572B;
        Fri,  9 Dec 2022 13:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670621591; x=1702157591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eGoeiXR1p93X5YrzuAODssrWSeub6r/Gldo3L3agRqU=;
  b=gdky48IUoqHkza2gs6Abjg1FCDP+TQjIj5T8QgowDL9F+upZRInPLuq5
   Vwrn8L0QWActDffDfBl9/XprQQiFLDOm5lf7vhrTeJj0LxEycrwftASIR
   J8H7rxuKMArwMxxnlnb/yNgEyYnXbsQBeei+jA99xdsUCv8LkYr6pUoZN
   D/UmGLxBzRsx4dJ+LhbR23q4vYLcpoR/sehRnNFoag9eV8w4bkm2ZIV5i
   g9/ONF0vJ49p2pWsqsbRUjObllDohzlGH4SsaZDTq/+KxxNlSrnD+N1oA
   I9N/uaYzQJ4V6OhfYcpxwagux3VizoyWBfITH9J9NoM+kYDnAz57ln72i
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="318704344"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="318704344"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="892805570"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="892805570"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2022 13:33:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1p3kzQ-007C8N-2r;
        Fri, 09 Dec 2022 23:33:04 +0200
Date:   Fri, 9 Dec 2022 23:33:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/4] x86/PCI: Tidy E820 removal messages
Message-ID: <Y5OpkCs3HjIz1ghq@smile.fi.intel.com>
References: <Y5OBfjKXFc5d88i1@smile.fi.intel.com>
 <20221209203428.GA1721600@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209203428.GA1721600@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 02:34:28PM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 09, 2022 at 08:42:06PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 08, 2022 at 01:03:40PM -0600, Bjorn Helgaas wrote:

...

> > > +			if (avail->end > avail->start)
> > > +				pr_info("resource: remaining [mem %#010llx-%#010llx] available\n",
> > > +					(unsigned long long) avail->start,
> > > +					(unsigned long long) avail->end);
> > 
> > Is there any point why we do not use %pa for resource_size_t parameters?
> 
> Only my ignorance :)  Thanks for pointing that out; I changed it to
> this and added a comment about why:

> +			pr_info("resource: avoiding allocation from e820 entry [mem %#010Lx-%#010Lx]\n",
> +				e820_start, e820_end);
> +			if (avail->end > avail->start)
> +				/*
> +				 * Use %pa instead of %pR because "avail"
> +				 * is typically IORESOURCE_UNSET, so %pR
> +				 * shows the size instead of addresses.
> +				 */
> +				pr_info("resource: remaining [mem %pa-%pa] available\n",
> +					&avail->start, &avail->end);

LGTM, thanks!

-- 
With Best Regards,
Andy Shevchenko


