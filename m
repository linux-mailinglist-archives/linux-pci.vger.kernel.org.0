Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C68176F9E2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 08:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjHDGMY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 02:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjHDGMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 02:12:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6384215;
        Thu,  3 Aug 2023 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691129533; x=1722665533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Kl1i+A5awabTUfe8tYIHXn96XCE6cyMXDjxlzhLB2A=;
  b=IHpbpjltc3bWOLvW9svgPleqgf6iZS+1xM58O3U8oHhER6McoojGTzo5
   CfaD0MXmTyYkgSEfami5c2Nx/HKqLqVBdQ3M0Vj392my6e4B934KR8SQy
   EZaRCv+jj0CnNdkIRDhOoTQjFVQDnYEKheZyag5pDR8VRAm31iSDFR0s9
   0evuQQop2hSXe65XTnI4IcHvi+PaHQeHlC6+gLFk9JmTSVTP4o7pSL9SL
   Iv9LVjBCvWr7eCpIN9WETf1W5M2LTA8h8GypPHj6SwrD20WwLXjvhkUmq
   Z7xYjA1izkqX8Q+MvUxt3vuqZV5ucumRtqSwHNsYLJOk5ADnwFacrgJKc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433927906"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="433927906"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="799889585"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="799889585"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2023 23:12:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRo2h-00D2qt-1y;
        Fri, 04 Aug 2023 09:12:07 +0300
Date:   Fri, 4 Aug 2023 09:12:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates
 to opt devices into D3
Message-ID: <ZMyWt4JD1TjoLk8w@smile.fi.intel.com>
References: <20230802201013.910-1-mario.limonciello@amd.com>
 <20230802201013.910-3-mario.limonciello@amd.com>
 <20230803050118.GV14638@black.fi.intel.com>
 <06cf76ba-de5f-caaa-d1c4-9d34adf15a52@amd.com>
 <20230803151454.GZ14638@black.fi.intel.com>
 <208afe43-2539-156b-971f-89233598b687@amd.com>
 <20230804060743.GA14638@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804060743.GA14638@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 09:07:43AM +0300, Mika Westerberg wrote:
> On Thu, Aug 03, 2023 at 10:18:07AM -0500, Mario Limonciello wrote:

...

> Some of them, at least the Apollo Lake ones were used in IVI systems
> that did not run Windows IIRC.

And if it matters, they even don't have EFI complaint BIOS.

-- 
With Best Regards,
Andy Shevchenko


