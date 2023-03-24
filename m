Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510206C7B2B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 10:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjCXJV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Mar 2023 05:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCXJVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2023 05:21:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C75233DE;
        Fri, 24 Mar 2023 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679649689; x=1711185689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Zv6p5PxBUIwRGR/FQTKCtRGfcJDPVTzeoNo7mhbkHhY=;
  b=PxRGiXTN6YBrH7uOleNvHOd8rB72J+4Q2yPZ0B6bIgU1pGI5oLsKcUnR
   N8IOmGHHOzoifXTutOmGi93xQUOT2/R+WV60Xut0UN4taXyZosJPESPnx
   RIBj3kthGQNoGA2XQ0l/LEIYhzaXATqBcBP5Z37Bkqu+DhStx4R6x5Y+R
   vQYOuMU26Moz8COz9eXSflZGu2AARC54Cy0MFqjFZACGV+J1TnXsSoN/h
   iIF2aCYzgknrrPEyrK0/hlFrLCM4+9iMUeNskvxgqzhni2j7pRGRax60L
   8CLYisxfLm85EmrzhZJVJvbRcmJnjb4WLuDDQUl0cRPM46Yx6vAmE4byS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="320129732"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="320129732"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 02:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="771814725"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="771814725"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Mar 2023 02:20:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfdbS-007qWb-1l;
        Fri, 24 Mar 2023 11:20:54 +0200
Date:   Fri, 24 Mar 2023 11:20:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH v7 6/6] PCI: Make use of pci_resource_n()
Message-ID: <ZB1rdkOgwwSC2Pxf@smile.fi.intel.com>
References: <20230323173610.60442-1-andriy.shevchenko@linux.intel.com>
 <20230323173610.60442-7-andriy.shevchenko@linux.intel.com>
 <1722e75c-bc06-4a34-5e12-fa3622ed86a3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1722e75c-bc06-4a34-5e12-fa3622ed86a3@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 24, 2023 at 10:08:39AM +0100, Philippe Mathieu-Daudé wrote:
> On 23/3/23 18:36, Andy Shevchenko wrote:
> > Replace open-coded implementations of pci_resource_n() in pci.h.

...

> >   #define pci_resource_n(dev, bar)	(&(dev)->resource[(bar)])
> > -#define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
> > -#define pci_resource_end(dev, bar)	((dev)->resource[(bar)].end)
> > -#define pci_resource_flags(dev, bar)	((dev)->resource[(bar)].flags)
> > -#define pci_resource_len(dev,bar) \
> > -	((pci_resource_end((dev), (bar)) == 0) ? 0 :	\
> > -							\
> > -	 (pci_resource_end((dev), (bar)) -		\
> > -	  pci_resource_start((dev), (bar)) + 1))
> > +#define pci_resource_start(dev, bar)	(pci_resource_n(dev, bar)->start)
> > +#define pci_resource_end(dev, bar)	(pci_resource_n(dev, bar)->end)
> > +#define pci_resource_flags(dev, bar)	(pci_resource_n(dev, bar)->flags)
> > +#define pci_resource_len(dev,bar)					\
> > +	(pci_resource_end((dev), (bar)) ? 				\
> > +	 resource_size(pci_resource_n((dev), (bar))) : 0)
> 
> Seems (to me) more logical to have this patch as "PCI: Introduce
> pci_resource_n()" ordered before your patch #2 "PCI: Introduce
> pci_dev_for_each_resource()".

Either way works for me. Bjorn, what do you like?

> Here as #6 or as #2:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


