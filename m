Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E456B9EEF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 19:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCNSp5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 14:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNSpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 14:45:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC56B6D3A;
        Tue, 14 Mar 2023 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678819522; x=1710355522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HcDoA6lnkNndAAvLyrmktLzn4ToTWYKaGtwl/HFFUFk=;
  b=KPUTQdnCkD5ypddDXopgGnyQFn2g/Ffkpt9rh9jtiA+WfCKtJN9nDtSP
   YAxWpzCCC6/13YybF9jCNf95omwQhm+NICCritGKvJJ6ycKCB/RVhO7DJ
   k+igcf2l29y1dQcZH6lZXvH/ro0r5N8yeW4XFjtOx9S7evzUjCkGFRu+C
   8t2ZWL31nR6B7ctO/SrI56MSbAvbnV2q4leF9ViDPDPfklu7KsZqSgpJn
   uoyC98AK20Mpx1Q2PxaR9nkt12jAzrSYEsaVR0hh8JmNgawdDTlpZ46fn
   l7J8jwlDIpleosq0wsFHqx0OHkrohvWKVP/+6lfOCVn83+qMlqFMl7ngk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="365185424"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="365185424"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 11:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="802973476"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="802973476"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 14 Mar 2023 11:43:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pc9cO-003NLi-0Q;
        Tue, 14 Mar 2023 20:43:28 +0200
Date:   Tue, 14 Mar 2023 20:43:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 1/4] PCI: Introduce pci_dev_for_each_resource()
Message-ID: <ZBDAT4MJO+fBy61n@smile.fi.intel.com>
References: <20230310171416.23356-2-andriy.shevchenko@linux.intel.com>
 <d057ac5c-5947-41e1-abc7-9428fbd2fbe2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d057ac5c-5947-41e1-abc7-9428fbd2fbe2@kili.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 11, 2023 at 04:54:32PM +0300, Dan Carpenter wrote:

> 059b4a086017fb Mika Westerberg 2023-03-10  246  			unsigned long type = resource_type(r);
> 999ed65ad12e37 Rene Herman     2008-07-25  247  
> 059b4a086017fb Mika Westerberg 2023-03-10 @248  			if (type != IORESOURCE_IO || type != IORESOURCE_MEM ||
>                                                                                                   ^^
> This || needs to be &&.  This loop will always hit the continue path
> without doing anything.
> 
> 059b4a086017fb Mika Westerberg 2023-03-10  249  			    resource_size(r) == 0)
> 0509ad5e1a7d92 Bjorn Helgaas   2008-03-11  250  				continue;

Thanks, I'll fix in v5.

-- 
With Best Regards,
Andy Shevchenko


