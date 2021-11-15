Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173B0450749
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 15:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhKOOnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 09:43:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:50718 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236756AbhKOOmi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 09:42:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233695263"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233695263"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:39:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="548027586"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:39:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmd8m-0077T3-1r;
        Mon, 15 Nov 2021 16:39:24 +0200
Date:   Mon, 15 Nov 2021 16:39:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
Message-ID: <YZJxG7JFAfIqr1/f@smile.fi.intel.com>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
 <94d3f4e5-a698-134c-8264-55d31d3eafa6@arm.com>
 <CAHp75VeJ8ZiD=qQVfeahUjGZduFRJJ5683hn8f4810JYEzsCyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeJ8ZiD=qQVfeahUjGZduFRJJ5683hn8f4810JYEzsCyw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 04:14:21PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 4:01 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > On 2021-11-15 11:20, Andy Shevchenko wrote:
> > > Use BIT() as __GENMASK() is for internal use only. The rationale
> > > of switching to BIT() is to provide better generated code. The
> > > GENMASK() against non-constant numbers may produce an ugly assembler
> > > code. On contrary the BIT() is simply converted to corresponding shift
> > > operation.
> >
> > FWIW, If you care about code quality and want the compiler to do the
> > obvious thing, why not specify it as the obvious thing:
> >
> >         u32 val = ~0 << msi->legacy_shift;
> 
> Obvious and buggy (from the C standard point of view)? :-)

Forgot to mention that BIT() is also makes it easy to avoid such mistake.

> > Personally I don't think that abusing BIT() in the context of setting
> > multiple bits is any better than abusing __GENMASK()...
> 
> No, BIT() is not abused here, but __GENMASK().
> 
> After all it's up to you, folks, consider that as a bug report.

-- 
With Best Regards,
Andy Shevchenko


