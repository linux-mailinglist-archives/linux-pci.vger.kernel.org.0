Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E37A77894E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 10:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjHKI4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 04:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjHKI4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 04:56:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A16E73;
        Fri, 11 Aug 2023 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691744164; x=1723280164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PRCujPROghrmLeghjVhgHGy2YMG22n3tlRGeYg0AUkU=;
  b=MGQsrfMeOBDU9BuQeGeL2pEEzOLdY0K6Qnbd+9GMi0KEFDjPQro18YEH
   FqTNeAHdachlcyZk+SDSYhAh/eieg0iq+S7xuM5Jxl6k2FyT2y30TPQ9y
   WIJpiF2uEAPIwBX5LMlDkDrflFwpOAXRmdgst6T56yJ7/FyrBfzt48cEP
   xQl9aFnz+LuuidVlOErHiZNg5MXHu5jXALg6/IcvXgTa70NDMXAvjHnN8
   H4SVP5M89zD2ttwnG7sTswrY53uV3qCktdftGtCnoGketgmM4ZTuHCvwD
   lRA4ettE7ILpji505dgQYzNzlPXqnIhh99ZiDuYvSUhgNcChWFn6PHnQm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361773366"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361773366"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876087666"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 11 Aug 2023 01:56:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUNw7-007Qxt-2q;
        Fri, 11 Aug 2023 11:55:59 +0300
Date:   Fri, 11 Aug 2023 11:55:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v11 8/9] PCI: Split PME state selection into a local
 static function
Message-ID: <ZNX3n5rHBHkN4kZy@smile.fi.intel.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
 <20230809185453.40916-9-mario.limonciello@amd.com>
 <ZNUOo+OKEv6zfPSY@smile.fi.intel.com>
 <c07aba63-6ca0-4889-aa98-30248f86c313@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c07aba63-6ca0-4889-aa98-30248f86c313@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 11:29:49AM -0500, Limonciello, Mario wrote:
> On 8/10/2023 11:21 AM, Andy Shevchenko wrote:
> > On Wed, Aug 09, 2023 at 01:54:52PM -0500, Mario Limonciello wrote:

...

> > > +static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
> > > +{
> > > +	pci_power_t state = PCI_D3hot;
> > > +
> > > +	while (state && !(dev->pme_support & (1 << state)))
> > > +		state--;
> > > +
> > > +	return state;
> > 
> > Sparse won't be happy about this code (with CF=-D__CHECK_ENDIAN__).
> > 
> > Basically it's something like
> > 
> > 	return (__force pci_power_t)fls(dev->pme_support & GENMASK(PCI_D3hot, 0));
> > 
> > (but double check and test the logic).
> > 
> > > +}
> > 
> > ...
> > 
> > Yeah, I see that is the existing code, perhaps amend it first?
> > 
> 
> Are you sure?

Yes.

Just the original code

drivers/pci/pci.c:2711:60: warning: restricted pci_power_t degrades to integer
drivers/pci/pci.c:2712:30: warning: restricted pci_power_t degrades to integer

                /*
                 * Find the deepest state from which the device can generate
                 * PME#.
                 */
2711 ==>         while (state && !(dev->pme_support & (1 << state)))
2712 ==>                state--;

How is yours different?

> I actually double checked the sparse output using this
> command before I sent it.
> 
> make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' drivers/pci/pci.o
> 
> I didn't see anything related to the line numbers for this function.

Just in case...

$ gcc --version
gcc (Debian 12.3.0-5) 12.3.0

$ sparse --version
0.6.4 (Debian: 0.6.4-3)

$ make --version
GNU Make 4.3
Built for x86_64-pc-linux-gnu

-- 
With Best Regards,
Andy Shevchenko


