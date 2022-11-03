Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979FF61870E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 19:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKCSFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 14:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKCSEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 14:04:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A026375;
        Thu,  3 Nov 2022 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498521; x=1699034521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yb2Mq3fbpPtLAnjCVdV2BEIMFU/XQ1cYRIu5k0HafqM=;
  b=l5Hr56ToEJs+/CdNN7Zywr/zrd1fxLDUPoQCFG/B9iGuOzEjjvmRuRqJ
   4YBKXfi//cNu1ha6Gpn7s7C9Gk/ytC+jm6tEctcha4YEs4w/ui6Q5pM+6
   WsqkD7TWduTuJJ7n6zsDKQqh0RuMYT2TbwVNDLLkZaldHd0nFlgYyNRBj
   THatTJGf5qwAUJ2i7M/uJe3kDI5Ar8VZO3HGKPI/eXSLCZ/LDWI9cH3Su
   D659FUND4L7Ha7sJsCkNS1pjrmpgIPN3nGk4UooVymOPidGWXStBzo6md
   O7Shjcgyz4pMQj/L7o8g5AOaHkLbaiH+P3mImGVPaK3VcPcZY/UvsUNjQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290150790"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="290150790"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 11:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="740290898"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="740290898"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2022 11:01:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqeWy-006xtO-3D;
        Thu, 03 Nov 2022 20:01:33 +0200
Date:   Thu, 3 Nov 2022 20:01:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH v2 4/4] pcmcia: Convert to use
 pci_bus_for_each_resource_p()
Message-ID: <Y2QB/BxfKCjckaaU@smile.fi.intel.com>
References: <20221103164644.70554-1-andriy.shevchenko@linux.intel.com>
 <20221103164644.70554-5-andriy.shevchenko@linux.intel.com>
 <Y2P0XCNJvTVuziO7@owl.dominikbrodowski.net>
 <Y2P2ja26ikNecTsv@smile.fi.intel.com>
 <Y2P5mRt//Pp6XTLT@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2P5mRt//Pp6XTLT@owl.dominikbrodowski.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 06:25:45PM +0100, Dominik Brodowski wrote:
> Am Thu, Nov 03, 2022 at 07:12:45PM +0200 schrieb Andy Shevchenko:
> > On Thu, Nov 03, 2022 at 06:03:24PM +0100, Dominik Brodowski wrote:

...

> > Considering this is done, can you issue your conditional tag so I will
> > incorporate it in v3?
> 
> Certainly, feel free to add
> 
> 	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko


