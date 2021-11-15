Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31D2450290
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 11:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhKOKga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 05:36:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:35783 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhKOKg3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 05:36:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="319627643"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="319627643"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 02:33:34 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="585185435"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 02:33:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmZIi-0071pM-Tq;
        Mon, 15 Nov 2021 12:33:24 +0200
Date:   Mon, 15 Nov 2021 12:33:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI: probe: Use pci_find_vsec_capability() when
 looking for TBT devices
Message-ID: <YZI3dJ59DxE0GWWv@smile.fi.intel.com>
References: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
 <YZCDHxOwogxPpuWy@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZCDHxOwogxPpuWy@rocinante>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 14, 2021 at 04:31:43AM +0100, Krzysztof Wilczyński wrote:
> Hi Andy,
> 
> Nice find!  There might one more driver that leverages the vendor-specific
> capabilities that seems to be also open coding pci_find_vsec_capability(),
> as per:
> ...
> Do you think that it would be worthwhile to also update this other driver
> to use pci_find_vsec_capability() at the same time?  I might be nice to rid
> of the other open coded implementation too.

You mean https://lore.kernel.org/linux-fpga/20211109154127.18455-1-andriy.shevchenko@linux.intel.com/T/#u?

It seems a bit hard to explain HW people how the Linux kernel development
process is working. (Yes, shame on me that I haven't compiled that one)

...

> > Currently the set_pcie_thunderbolt() opens code pci_find_vsec_capability().
> 
> I would write it as "open codes" in the above.

Hmm... Is anybody among us a native speaker (me — no)? :-)
But if you think it's better like this I'll definitely change.
(I admit I'm lost in a morphological analysis of the above two
 words)

...

> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


