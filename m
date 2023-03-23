Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EE06C6BFD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 16:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjCWPMt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCWPMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 11:12:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1A1298F9;
        Thu, 23 Mar 2023 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679584343; x=1711120343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTI3sfGhxuNt+eJ92X/zV2v4CxfKcZ1sf1RhNp36ij0=;
  b=VbJ+jeUUPtbfIJVah3l5bMjlknrA4fMoJQERYl/KBk7p0Ka+FbggX2ku
   uC94mWBiUeYVqeeKso06aXK5DLmeoChTk+UKL2ajM4N3rTbukWzVRkW+A
   UsZ+ziQqstgxuPwyrAlqppaC/S/SJ5geUat5yX2NDimGcNga0c+LLTWR6
   R0gPSZ6ECeUbE6G2tyDL6/QYDnWR8h8XJ7wKJvGWTaUSy81rIlnENooqA
   beSut6QYqTfXQmwIuuFIequ1Pz2OAcuTqYHrZiasYTAwBQneRVXCFQUfN
   De66VgFyZC/HoI5tIZQPlZYtr+ArY7b0xdZVBa62oooMx+izq3uV4BeGo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="404419881"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="404419881"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 08:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="793046100"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="793046100"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2023 08:08:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfMYZ-007YBs-1j;
        Thu, 23 Mar 2023 17:08:47 +0200
Date:   Thu, 23 Mar 2023 17:08:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v6 1/4] PCI: Introduce pci_dev_for_each_resource()
Message-ID: <ZBxrfy83MRjnReAs@smile.fi.intel.com>
References: <ZBxiaflGTeK8Jlgx@smile.fi.intel.com>
 <20230323150238.GA2550157@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323150238.GA2550157@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 23, 2023 at 10:02:38AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 23, 2023 at 04:30:01PM +0200, Andy Shevchenko wrote:

...

> I poked around looking for similar patterns elsewhere with:
> 
>   git grep "#define.*for_each_.*_p("
>   git grep "#define.*for_each_.*_idx("
> 
> I didn't find any other "_p" iterators and just a few "_idx" ones, so
> my hope is to follow what little precedent there is, as well as
> converge on the basic "*_for_each_resource()" iterators and remove the
> "_idx()" versions over time by doing things like the
> pci_claim_resource() change.

The p is heavily used in the byte order conversion helpers.

> What do you think?  If it seems like excessive churn, we can do it
> as-is and still try to reduce the use of the index variable over time.

I think _p has a precedent as well. But I can think about it a bit, maybe
we can come up with something smarter.

-- 
With Best Regards,
Andy Shevchenko


