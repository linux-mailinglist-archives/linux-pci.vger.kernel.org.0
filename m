Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D345072283B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjFEOIU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 10:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjFEOH7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 10:07:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8F2E5C;
        Mon,  5 Jun 2023 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685974071; x=1717510071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zjA9XYetqLmj2er7YOpXmYqZcR8z8Fh+g5Flt9xdytk=;
  b=O96WqxzlUCNQyd33mgmV+U+gO7Lgr+/55QF6BKqVKFY53MIvHhzdcl4N
   xdGbsU6vvWdH65EhEc1Dup08XLUzSGM/ENIdjVfI38q1DmbrtZ7RqIXSU
   XFhU8HQpR0b9EMsblU4xIi2zBUPnZaOK6MXv7t6Th5nf7GVtcKncqMWRs
   2pA+rVgzMjtJx8OUe2PgpIprtmvCUcz6OINPgM06ruHWparvphAN7ftf2
   GODvFHSgy+5VSlcBcv7oGKlEdMT2nWOvsjhUn0zTnzNTLi57F2vd8qIMa
   fuMqRNsqppppAcn0BAHJHrQ7FODn+RVT8PBKus4oetqfPBskfYs5StpT2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="335993888"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="335993888"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 07:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="882915325"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="882915325"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 05 Jun 2023 07:04:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6AoX-001O9h-1D;
        Mon, 05 Jun 2023 17:04:05 +0300
Date:   Mon, 5 Jun 2023 17:04:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
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
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-mips@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-alpha@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v8 0/7] Add pci_dev_for_each_resource() helper and update
 users
Message-ID: <ZH3rVcSr+m8DHmo9@smile.fi.intel.com>
References: <CAOiHx==5YWhDiZP2PyHZiJrmtqRzvqCqoSO59RwuYuR85BezBg@mail.gmail.com>
 <ZHe8dKb3f392MfBO@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHe8dKb3f392MfBO@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 31, 2023 at 04:30:28PM -0500, Bjorn Helgaas wrote:
> On Wed, May 31, 2023 at 08:48:35PM +0200, Jonas Gorski wrote:

...

> > Looking at the code I understand where coverity is coming from:
> > 
> > #define __pci_dev_for_each_res0(dev, res, ...)                         \
> >        for (unsigned int __b = 0;                                      \
> >             res = pci_resource_n(dev, __b), __b < PCI_NUM_RESOURCES;   \
> >             __b++)
> > 
> >  res will be assigned before __b is checked for being less than
> > PCI_NUM_RESOURCES, making it point to behind the array at the end of
> > the last loop iteration.
> > 
> > Rewriting the test expression as
> > 
> > __b < PCI_NUM_RESOURCES && (res = pci_resource_n(dev, __b));
> > 
> > should avoid the (coverity) warning by making use of lazy evaluation.
> > 
> > It probably makes the code slightly less performant as res will now be
> > checked for being not NULL (which will always be true), but I doubt it
> > will be significant (or in any hot paths).
> 
> Thanks a lot for looking into this!  I think you're right, and I think
> the rewritten expression is more logical as well.  Do you want to post
> a patch for it?

Gimme some time, I was on a long leave and now it's a pile to handle.

-- 
With Best Regards,
Andy Shevchenko


