Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1F6D941C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjDFKbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbjDFKbc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 06:31:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DBC1BC1;
        Thu,  6 Apr 2023 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680777085; x=1712313085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ceVcmjc6Ptm9PzaLBlyJdk3QXqcq40nfjFwb4WczVs=;
  b=kOgwiJmMD8Ijg1BxIDiKzJGlnfh06c4u/a+t6pG62SWIfHGF43vwVcn1
   l6kS+CWjI97tH1JSPZkOsacTF0JAUvep3W1ya7BUNjaWtSu7hvUBsFwJz
   BlQ2tzA8zaxvzXb1oiwO6NBUu4WDqTE/TetiEy6DMDrGtz8beNGL74wJD
   dCyJbcd2nE9qI2kCe1NPga9pgkYVvDi8lCXHSDtjgFmEp3jJFueV16xhT
   SBGxffan6xHWIQQumEr51X4IvgROVSWHITRTO8w1ZsICins7XqX5z2WvK
   xY5dytToTv+c5r1i6cuzWbUECnfKoYXigdPJ/pjWqzQorPBjnWriHCQw7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="341435058"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="341435058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 03:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="719666156"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="719666156"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2023 03:31:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pkMtX-00DJOA-0t;
        Thu, 06 Apr 2023 13:31:07 +0300
Date:   Thu, 6 Apr 2023 13:31:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
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
Subject: Re: [PATCH v8 0/7] Add pci_dev_for_each_resource() helper and update
 users
Message-ID: <ZC6fa1vJGOOI7t8a@smile.fi.intel.com>
References: <ZC0xK4YJrKga7akk@smile.fi.intel.com>
 <20230405201832.GA3638070@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405201832.GA3638070@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 05, 2023 at 03:18:32PM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 05, 2023 at 11:28:27AM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 04, 2023 at 11:11:01AM -0500, Bjorn Helgaas wrote:
> > > On Thu, Mar 30, 2023 at 07:24:27PM +0300, Andy Shevchenko wrote:

...

> > > I omitted
> > > 
> > >   [1/7] kernel.h: Split out COUNT_ARGS() and CONCATENATE()"
> > > 
> > > only because it's not essential to this series and has only a trivial
> > > one-line impact on include/linux/pci.h.
> > 
> > I'm not sure I understood what exactly "essentiality" means to you, but
> > I included that because it makes the split which can be used later by
> > others and not including kernel.h in the header is the objective I want
> > to achieve. Without this patch the achievement is going to be deferred.
> > Yet, this, as you have noticed, allows to compile and use the macros in
> > the rest of the patches.
> 
> I haven't followed the kernel.h splitting, and I try to avoid
> incidental changes outside of the files I maintain, so I just wanted
> to keep this series purely PCI and avoid any possible objections to a
> new include file or discussion about how it should be done.

Okay, fair enough :-) Thank you for elaboration, I will send the new version of
patch 7 separately.

-- 
With Best Regards,
Andy Shevchenko


