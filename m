Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9743C7A6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhJ0KaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 06:30:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:4474 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231643AbhJ0KaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 06:30:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="316334146"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="316334146"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 03:27:42 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="597312127"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 03:27:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfg9P-001R57-CT;
        Wed, 27 Oct 2021 13:27:19 +0300
Date:   Wed, 27 Oct 2021 13:27:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: brcmstb: Use GENMASK() as __GENMASK() is for
 internal use only
Message-ID: <YXkphydcdD9giKqs@smile.fi.intel.com>
References: <20211027093433.4832-1-andriy.shevchenko@linux.intel.com>
 <YXkjMO0ULRGqZPbr@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXkjMO0ULRGqZPbr@rocinante>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 27, 2021 at 12:00:16PM +0200, Krzysztof Wilczyński wrote:
> > Use GENMASK() as __GENMASK() is for internal use only.
> 
> To add, for posterity, that using __GENMASK() bypasses the
> GENMASK_INPUT_CHECK() macro that adds extra validation.

In general, yes, but here we have a variable...

> > -	u32 val = __GENMASK(31, msi->legacy_shift);
> > +	u32 val = GENMASK(31, msi->legacy_shift);

...which make me thing that the whole construction is ugly
(and I truly believe the code is very ugly here, because
 the idea behind GENMASK() is to be used with constants).

So, what about

	u32 val = ~(BIT(msi->legacy_shift) - 1);

instead?

> Thank you!
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


