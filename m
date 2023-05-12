Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C555700613
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 12:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbjELK4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 06:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbjELK4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 06:56:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA1CFE;
        Fri, 12 May 2023 03:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683889004; x=1715425004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aTme5qDkFV7Mcp0uaOboKBbeV5ze/dqrLO9cBA/tElE=;
  b=RXB9WXpjC1DvMlJbCHHDAAU+YudODiVQi5nCUUCI8S6qBwG2alUG5t0G
   FdgMNayGjwIxKv9jVzWaNRENfLBuDWbpR155MyDVLlNqhaae6Xvb9Zet2
   ICNJZIQgOBm8M2kKwWMOtUkoxyr2TVlS/2f/HRsBgcjSCAuTYpYba913/
   LayD8z/z5D1/vsIUbnTyeVGyaWtX6iIsWsMTtL8+DNppjRUtf64y3cGxj
   3JWBvpumkJ25j99MM8FHwtsxdC/LpZQ8ElKNva092BJ5SVlJ4Fe2+bnpw
   4HaILCrxhJT82KnW2H6sapvFdku/lJop06VVALUZWmbO+u0kgzTzEEPvi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="414132446"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="414132446"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="812041055"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="812041055"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2023 03:56:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pxQRq-0004Zv-0i;
        Fri, 12 May 2023 13:56:30 +0300
Date:   Fri, 12 May 2023 13:56:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>, sparclinux@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-acpi@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
        Anatolij Gustschin <agust@denx.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v8 0/7] Add pci_dev_for_each_resource() helper and update
 users
Message-ID: <ZF4bXaz2r75dlA5g@smile.fi.intel.com>
References: <20230404161101.GA3554747@bhelgaas>
 <20230509182122.GA1259567@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509182122.GA1259567@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 09, 2023 at 01:21:22PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 04, 2023 at 11:11:01AM -0500, Bjorn Helgaas wrote:
> > On Thu, Mar 30, 2023 at 07:24:27PM +0300, Andy Shevchenko wrote:
> > > Provide two new helper macros to iterate over PCI device resources and
> > > convert users.
> 
> > Applied 2-7 to pci/resource for v6.4, thanks, I really like this!
> 
> This is 09cc90063240 ("PCI: Introduce pci_dev_for_each_resource()")
> upstream now.
> 
> Coverity complains about each use,

It needs more clarification here. Use of reduced variant of the macro or all of
them? If the former one, then I can speculate that Coverity (famous for false
positives) simply doesn't understand `for (type var; var ...)` code.

>	sample below from
> drivers/pci/vgaarb.c.  I didn't investigate at all, so it might be a
> false positive; just FYI.
> 
> 	  1. Condition screen_info.capabilities & (2U /* 1 << 1 */), taking true branch.
>   556        if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
>   557                base |= (u64)screen_info.ext_lfb_base << 32;
>   558
>   559        limit = base + size;
>   560
>   561        /* Does firmware framebuffer belong to us? */
> 	  2. Condition __b < PCI_NUM_RESOURCES, taking true branch.
> 	  3. Condition (r = &pdev->resource[__b]) , (__b < PCI_NUM_RESOURCES), taking true branch.
> 	  6. Condition __b < PCI_NUM_RESOURCES, taking true branch.
> 	  7. cond_at_most: Checking __b < PCI_NUM_RESOURCES implies that __b may be up to 16 on the true branch.
> 	  8. Condition (r = &pdev->resource[__b]) , (__b < PCI_NUM_RESOURCES), taking true branch.
> 	  11. incr: Incrementing __b. The value of __b may now be up to 17.
> 	  12. alias: Assigning: r = &pdev->resource[__b]. r may now point to as high as element 17 of pdev->resource (which consists of 17 64-byte elements).
> 	  13. Condition __b < PCI_NUM_RESOURCES, taking true branch.
> 	  14. Condition (r = &pdev->resource[__b]) , (__b < PCI_NUM_RESOURCES), taking true branch.
>   562        pci_dev_for_each_resource(pdev, r) {
> 	  4. Condition resource_type(r) != 512, taking true branch.
> 	  9. Condition resource_type(r) != 512, taking true branch.
> 
>   CID 1529911 (#1 of 1): Out-of-bounds read (OVERRUN)
>   15. overrun-local: Overrunning array of 1088 bytes at byte offset 1088 by dereferencing pointer r. [show details]
>   563                if (resource_type(r) != IORESOURCE_MEM)
> 	  5. Continuing loop.
> 	  10. Continuing loop.
>   564                        continue;

-- 
With Best Regards,
Andy Shevchenko


