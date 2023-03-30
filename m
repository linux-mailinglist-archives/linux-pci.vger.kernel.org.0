Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902946D09E1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjC3Pja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjC3Pj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 11:39:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF1DC176;
        Thu, 30 Mar 2023 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680190749; x=1711726749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2y+Qd+RESrzEa/F9wmN52tzUziPss+ZxjSltCa9P/hk=;
  b=XUaJ54oMztjo5zzZAkUUI/cSufWKwCGk+SyH47VZs38IDrlrmW3ZKHva
   d8mrCiGnHwlU15WMqeXtQPbsHokH70DPzWNsrSSPjMZshuD2s7OZrmWk/
   pyn1QvXDiS3PaLGXT1/WqAIbH8AUaq8X9WAEkH5+T6DjYthBwUq7uczGS
   s9hd8Xfemsao9ZYhuJ+76SsdxN2A5eulLFlOpPxJuoQJGqrxqbIHzVuPb
   n/LwNNKYiRkILgJC4y03jcTttlmIvNg2WLzqrDdoqsUU4VDdGuLaOZ5D5
   EFf+sM5VEQhKstIf42nlzAagMYyu+km6IvzlCl+uFN3EXbo3iq202khQL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="368984331"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="368984331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 08:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="678241953"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="678241953"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 30 Mar 2023 08:38:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phuMV-00AURJ-0P;
        Thu, 30 Mar 2023 18:38:51 +0300
Date:   Thu, 30 Mar 2023 18:38:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v7 3/6] PCI: Allow pci_bus_for_each_resource() to take
 less arguments
Message-ID: <ZCWtCpQBAM7oR6ra@smile.fi.intel.com>
References: <20230323173610.60442-4-andriy.shevchenko@linux.intel.com>
 <202303302009.55848372-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303302009.55848372-oliver.sang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 09:24:21PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed various errors such like
>     "i40e: probe of 0000:3d:00.0 failed with error -12"
> due to commit (built with gcc-11):
> 
> commit: d23d5938fd7ced817d6aa1ff86cd671ebbaebfc2 ("[PATCH v7 3/6] PCI: Allow pci_bus_for_each_resource() to take less arguments")
> url: https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/kernel-h-Split-out-COUNT_ARGS-and-CONCATENATE/20230324-013857
> base: https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git next
> patch link: https://lore.kernel.org/all/20230323173610.60442-4-andriy.shevchenko@linux.intel.com/
> patch subject: [PATCH v7 3/6] PCI: Allow pci_bus_for_each_resource() to take less arguments
> 
> in testcase: boot
> 
> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202303302009.55848372-oliver.sang@intel.com

Thanks, that is useful test!

-- 
With Best Regards,
Andy Shevchenko


