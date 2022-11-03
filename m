Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53633618815
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 19:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKCS7q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 14:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKCS7p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 14:59:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1B7FD3C;
        Thu,  3 Nov 2022 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667501985; x=1699037985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iDzJkwIYDgDj9s9QyYyQqMun6Fj8NrFnD6UKX0fcnAs=;
  b=U1Umt9qku3GYocruQL5t/15455Rny7EXR4FHjNANVPsZL25YbnUAmdw7
   qIzTFjDWCpBgRXNs3Vbg1eHClJd1/n5Wa49RgzySMT3ePursA7PQg7cXD
   sLjdAwNydWb/Vt1ChnQmxLcAQf95L6jvAT4KX6UtC4kwn8aujIzJrWwQS
   bKdewFI+vEeeGUC9VHlUrHdjxCqn0dn86Rca8THquoXv8VgMtdbmbVFFA
   w1kxOgKcc3YhgFBkK3NoJ0GO4PBXfg2QNkTCPW9PFJjwIfH5yf9PfE5vf
   IVlV/x38M2FJ9Zjdqc1379zmLj14WK/LfvvHm6CIVsSp/Xex+l6bFwfEf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="293099746"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="293099746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 11:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="724055696"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="724055696"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Nov 2022 11:59:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqfR8-006zVP-0o;
        Thu, 03 Nov 2022 20:59:34 +0200
Date:   Thu, 3 Nov 2022 20:59:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
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
Message-ID: <Y2QPlZ0mhLvKw7X5@smile.fi.intel.com>
References: <20221103164644.70554-1-andriy.shevchenko@linux.intel.com>
 <20221103164644.70554-5-andriy.shevchenko@linux.intel.com>
 <Y2P0XCNJvTVuziO7@owl.dominikbrodowski.net>
 <Y2P2ja26ikNecTsv@smile.fi.intel.com>
 <Y2QImB0OLakzz1+F@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2QImB0OLakzz1+F@rocinante>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 04, 2022 at 03:29:44AM +0900, Krzysztof Wilczyński wrote:

> > > > -
> > > > -	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> > > > -		res = s->cb_dev->bus->resource[i];
> > > > -#else
> > > > -	pci_bus_for_each_resource(s->cb_dev->bus, res, i) {
> > > >  #endif
> > > > +
> > > > +	pci_bus_for_each_resource_p(s->cb_dev->bus, res) {
> > > >  		if (!res)
> > > >  			continue;
> > > 
> > > Doesn't this remove the proper iterator for X86? Even if that is the right
> > > thing to do, it needs an explict explanation.
> > 
> > I dunno what was in 2010, but reading code now I have found no differences in
> > the logic on how resources are being iterated in these two pieces of code.
> 
> This code is over a decade old (13 years old to be precise) and there was
> something odd between Bjorn's and Jesse's patches, as per:
> 
>   89a74ecccd1f ("PCI: add pci_bus_for_each_resource(), remove direct bus->resource[] refs")
>   cf26e8dc4194 ("pcmcia: do not autoadd root PCI bus resources")

Yeah, thanks for pointing out to the other patch from the same 2010 year.
It seems the code was completely identical that time, now it uses more
sophisticated way of getting bus resources, but it's kept the same for
the resources under PCI_BRIDGE_RESOURCE_NUM threshold.

> > But fine, I will add a line to a commit message about this change.
> 
> I wouldn't, personally.  The change you are proposing is self-explanatory
> and somewhat in-line with what is there already - unless I am also reading
> the current implementation wrong.

But it wouldn't be harmful either.

> That said, Dominik is the maintainer of PCMCIA driver, so his is the last
> word, so to speak. :)
> 
> > Considering this is done, can you issue your conditional tag so I will
> > incorporate it in v3?
> 
> No need, really.  Again, unless Dominik thinks otherwise.

I think that what is wanted to have to get his tag.

Thanks for review, both of you, guys!

-- 
With Best Regards,
Andy Shevchenko


