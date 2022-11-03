Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D42618820
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKCTBa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 15:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiKCTBU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 15:01:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30C18349;
        Thu,  3 Nov 2022 12:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667502079; x=1699038079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sNkpjDaE4wFtOA2SWrBA99Yi2yLtSUQQFYkHqzgZpY0=;
  b=ZXt1L7pOhqi5WlmhDXsXmtPvPzFNWctwy1R7Q4Nq9odpGkclZS16RZoK
   yr0pKTMTKNTuyGMD6FHVYJOdygkVad7sglNjs8Cr+jWptpVC3Xwwtk4+F
   wO3FLNwQ/TLABvyu1b0tslvcUXYyVUlQkCnKntZMzTDTMWwE2/SceXpTY
   7wCgLODK9awyPzQKPB8raMf32pF09qwtXXyOTcdW1z/qPCLfmMwO9lIoT
   T2ELTsBsjnab3bY7pmSLFcT1xOCGowIq+91pOv0FIQn4SQz6OYOwB1JqE
   +PiauyijoaYM/9M+J4/4FGsVZqfBSZXyX18MCHUPeBquk8DHiDMz6Kf9p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="336475095"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="336475095"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 12:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="629452994"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="629452994"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2022 12:01:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqfSd-006zXu-1O;
        Thu, 03 Nov 2022 21:01:07 +0200
Date:   Thu, 3 Nov 2022 21:01:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
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
Message-ID: <Y2QP8yrZ7/9fpUQQ@smile.fi.intel.com>
References: <20221103164644.70554-1-andriy.shevchenko@linux.intel.com>
 <20221103164644.70554-5-andriy.shevchenko@linux.intel.com>
 <Y2P0XCNJvTVuziO7@owl.dominikbrodowski.net>
 <Y2P2ja26ikNecTsv@smile.fi.intel.com>
 <Y2QImB0OLakzz1+F@rocinante>
 <Y2QKjzL+nH6Zabg7@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2QKjzL+nH6Zabg7@owl.dominikbrodowski.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 07:38:07PM +0100, Dominik Brodowski wrote:
> Am Fri, Nov 04, 2022 at 03:29:44AM +0900 schrieb Krzysztof Wilczyński:

...

> > That said, Dominik is the maintainer of PCMCIA driver, so his is the last
> > word, so to speak. :)
> > 
> > > Considering this is done, can you issue your conditional tag so I will
> > > incorporate it in v3?
> > 
> > No need, really.  Again, unless Dominik thinks otherwise.
> 
> Ah, thanks for the correction. Then v2 is perfectly fine.

I'm fine with either, thanks!

-- 
With Best Regards,
Andy Shevchenko


