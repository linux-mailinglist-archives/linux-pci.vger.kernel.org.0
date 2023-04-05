Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AFD6D76EC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjDEIag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 04:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbjDEIaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 04:30:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC8A1FF9;
        Wed,  5 Apr 2023 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680683434; x=1712219434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o2D+LfXhLk+QrH3a0th/mLBmSHhjZTr2yV97vm5EWfI=;
  b=FEU+acUl60xzaexBT4lEK/sOyrPml79xYWAAMKYJv6+bVdHv/HsJt1kt
   m58JUrDb29h11muh4ZzNEnHV74xZpQNqntEwQGiKuYCXgN/zIBZmKgR+Y
   JjFAOLUo0OxSsZqoTQZPsXpy2G+RdGT+jKJgmNmFvmKlim3Lwab9nFlO6
   dFqUc6FUgyrYHaTqS0IFrcrPMTlWf5DtgQxCF+BFZUehd9gnL2SymL3KH
   fLP6GucbReryfzQfL4hulmNKm28fC60WC0FGkjXOjPIHDnowHbWLXyCl1
   XispgM/9/Z26IZN/bEdNrRJFOPk2heJGydKDJGlOi9r+zg2BxhqWbtmmm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="322058589"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="322058589"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="860894821"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="860894821"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2023 01:30:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pjyX4-00Ckbm-35;
        Wed, 05 Apr 2023 11:30:18 +0300
Date:   Wed, 5 Apr 2023 11:30:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
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
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v8 7/7] pcmcia: Convert to use less arguments in
 pci_bus_for_each_resource()
Message-ID: <ZC0xmk71jQrx3AeH@smile.fi.intel.com>
References: <20230330162434.35055-1-andriy.shevchenko@linux.intel.com>
 <20230330162434.35055-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330162434.35055-8-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 07:24:34PM +0300, Andy Shevchenko wrote:

...

> @@ -960,12 +960,9 @@ static int nonstatic_autoadd_resources(struct pcmcia_socket *s)
>  	 */
>  	if (s->cb_dev->bus->number == 0)
>  		return -EINVAL;
> -
> -	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> -		res = s->cb_dev->bus->resource[i];
> -#else
> -	pci_bus_for_each_resource(s->cb_dev->bus, res, i) {
>  #endif
> +
> +	pci_bus_for_each_resource(s->cb_dev->bus, res) {
>  		if (!res)
>  			continue;

As pointed out in the reply to Bjorn's email this hunk needs to be revisited,
since I wrote the documentation for the above call I have started understanding
the deal behind this special treatment for X86 case.

-- 
With Best Regards,
Andy Shevchenko


