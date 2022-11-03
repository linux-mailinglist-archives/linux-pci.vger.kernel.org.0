Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6C6185F2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 18:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiKCRNv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 13:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiKCRNe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 13:13:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8981EEC6;
        Thu,  3 Nov 2022 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667495577; x=1699031577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7YpyRAArYVbF9WNy66xCFId6MSUjEg0Z+IBgztnk6pE=;
  b=OP2WWRVrzCQUsW25oYzoM1bPLb/DH5cvAgGftZdTKFTf38AY12WbVody
   0ur29kF0xe53bTfiA+U6YrXxetSRAv7QmOe/mockPigLckHzLV+LkPaXy
   M4m0uGtvBGYT/F2KdB/18qFP1MRSrquyBKUvQVPtDoAXgmButYnQUoDS3
   HAgb5jTUu7aXbTx/DM3e1DciDXThbxAC6/fzsz6dyqNVCDvREoN6OdQr7
   7n8hILlG0oKlLFiHSPkArh70Ut8mxDmke1f+woq8JLBKzz263i0YsMBe7
   s5BmSbrcuI2y+rPgaGkzVufEdrYxPlNSISVSm9cqIhBgslMfcKr8qOX92
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="311480553"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="311480553"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="666046647"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="666046647"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2022 10:12:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqdlm-006wiw-0o;
        Thu, 03 Nov 2022 19:12:46 +0200
Date:   Thu, 3 Nov 2022 19:12:45 +0200
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
Message-ID: <Y2P2ja26ikNecTsv@smile.fi.intel.com>
References: <20221103164644.70554-1-andriy.shevchenko@linux.intel.com>
 <20221103164644.70554-5-andriy.shevchenko@linux.intel.com>
 <Y2P0XCNJvTVuziO7@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2P0XCNJvTVuziO7@owl.dominikbrodowski.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 06:03:24PM +0100, Dominik Brodowski wrote:
> Am Thu, Nov 03, 2022 at 06:46:44PM +0200 schrieb Andy Shevchenko:

...

> > -
> > -	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> > -		res = s->cb_dev->bus->resource[i];
> > -#else
> > -	pci_bus_for_each_resource(s->cb_dev->bus, res, i) {
> >  #endif
> > +
> > +	pci_bus_for_each_resource_p(s->cb_dev->bus, res) {
> >  		if (!res)
> >  			continue;
> 
> Doesn't this remove the proper iterator for X86? Even if that is the right
> thing to do, it needs an explict explanation.

I dunno what was in 2010, but reading code now I have found no differences in
the logic on how resources are being iterated in these two pieces of code.

But fine, I will add a line to a commit message about this change.

Considering this is done, can you issue your conditional tag so I will
incorporate it in v3?

-- 
With Best Regards,
Andy Shevchenko


