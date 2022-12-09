Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1742064888E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 19:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLISmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 13:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLISmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 13:42:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F035B59C;
        Fri,  9 Dec 2022 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670611351; x=1702147351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n0tWGGZDbd5iBdvKg5QC1cQ6LSUj5SaZ5KFci2+KPTE=;
  b=Z9cOOdps1fvgaAwdT+4OrAqcSqf/OD4M6ih2CDAkXuR7TGDXm/x9OY6Q
   iAunoxPoK9B+EFGCp5J6Q22q4ecKXnk5LMXKWjZH5jLfS1LhtELZIqgXL
   mOwsw1yL696INgrZ+zb0xkEf6iaZwoBw2T9sBkuZOqE2exi1a2nH8wjhP
   GjqnV8c3x5dpZHVqy7kqVuAZbtCS4YY4d/BF8wvEWqoEaQiFNUEPpyq9j
   T3grapRFgDY1xB8XbVDvczr7TwHyfNRvQCP+s7EFd3lWM27vAg5/FOvvS
   Rynk7GlI+OY51uyrmgahfP1Zc27Vigi8MTNdhsxGScWr5mcrEiG6i5+GK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="403779567"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="403779567"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 10:42:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647488707"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="647488707"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2022 10:42:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1p3iJz-0077mF-0r;
        Fri, 09 Dec 2022 20:42:07 +0200
Date:   Fri, 9 Dec 2022 20:42:06 +0200
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
Message-ID: <Y5OBfjKXFc5d88i1@smile.fi.intel.com>
References: <20221208190341.1560157-1-helgaas@kernel.org>
 <20221208190341.1560157-4-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208190341.1560157-4-helgaas@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 08, 2022 at 01:03:40PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> These messages:
> 
>   clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffffffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]
> 
> aren't as useful as they could be because (a) the resource is often
> IORESOURCE_UNSET, so we print the size instead of the start/end and (b) we
> print the available resource even if it is empty after removing the E820
> entry.
> 
> Print the available space by hand to avoid the IORESOURCE_UNSET problem and
> only if it's non-empty.  No functional change intended.

...

> +			if (avail->end > avail->start)
> +				pr_info("resource: remaining [mem %#010llx-%#010llx] available\n",
> +					(unsigned long long) avail->start,
> +					(unsigned long long) avail->end);

Is there any point why we do not use %pa for resource_size_t parameters?

-- 
With Best Regards,
Andy Shevchenko


