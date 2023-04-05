Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E166D7BF8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 13:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbjDELvL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbjDELvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 07:51:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80654203;
        Wed,  5 Apr 2023 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680695464; x=1712231464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CNsMJe3NJRh194M0JTRSE7YPi2b+rJpnYVMeT8Rmlsg=;
  b=Lu3tYDLRXv9qwqJIg+37k1wYWQG7yvee8VxkjgZeKlxj/+CA9vN1eNhh
   4LAmNkIWIDNrb9vstLnoW6u3bSbou3j4Y7ZA4ZfkBREEtiBzmc05ikxVQ
   aN0KDmrvCy55qbgK4yQjoNCmpLkZqvbT5WMZTbJQGnppVCFfsWEGs4kQP
   hASFK/q4xHXz0yAPx3fgzPhGC0ojPUMy2HYQlLros+KWfTc6jqVacYLv5
   ATWKoQvfF0xlB7TbwH1eEQZKX/WoG5DTEt0sINIe0ta7cYmzv3hF8hlAb
   rgGA8B9BR6g0nU30KfnHGe7zaPAuISO0qOwGC1HzZEqtH66xNaE5H4X3Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="405207773"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="405207773"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 04:51:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="797887729"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="797887729"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2023 04:50:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pk1f5-00ColQ-2n;
        Wed, 05 Apr 2023 14:50:47 +0300
Date:   Wed, 5 Apr 2023 14:50:47 +0300
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
Subject: Re: [PATCH v8 5/7] PCI: Allow pci_bus_for_each_resource() to take
 less arguments
Message-ID: <ZC1glzw4F9F8zCK+@smile.fi.intel.com>
References: <20230330162434.35055-1-andriy.shevchenko@linux.intel.com>
 <20230330162434.35055-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330162434.35055-6-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 07:24:32PM +0300, Andy Shevchenko wrote:
> Refactor pci_bus_for_each_resource() in the same way as it's done in
> pci_dev_for_each_resource() case. This will allow to hide iterator
> inside the loop, where it's not used otherwise.
> 
> No functional changes intended.

Bjorn, this has wrong author in your tree:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=resource&id=46dbad19a59e0dd8f1e7065e5281345797fbb365

Or did I misinterpret something?

-- 
With Best Regards,
Andy Shevchenko


