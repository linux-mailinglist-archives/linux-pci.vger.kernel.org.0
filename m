Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC8E465273
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 17:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhLAQIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 11:08:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:36796 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbhLAQH5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 11:07:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="223716561"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="223716561"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:02:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="654828841"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 08:02:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msS3H-0012Uu-9X;
        Wed, 01 Dec 2021 18:01:47 +0200
Date:   Wed, 1 Dec 2021 18:01:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
Message-ID: <YaecakqeoSPoqq4k@smile.fi.intel.com>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
 <163837398126.3058.11030158077196581603.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163837398126.3058.11030158077196581603.b4-ty@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01, 2021 at 03:53:21PM +0000, Lorenzo Pieralisi wrote:
> On Mon, 15 Nov 2021 13:20:00 +0200, Andy Shevchenko wrote:
> > Use BIT() as __GENMASK() is for internal use only. The rationale
> > of switching to BIT() is to provide better generated code. The
> > GENMASK() against non-constant numbers may produce an ugly assembler
> > code. On contrary the BIT() is simply converted to corresponding shift
> > operation.
> > 
> > Note, it's the only user of __GENMASK() in the kernel outside of its own realm.
> > 
> > [...]
> 
> Applied to pci/brcmstb, thanks!
> 
> [1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for internal use only
>       https://git.kernel.org/lpieralisi/pci/c/6ec6eb949d

Thanks, but there is another patch which changes the logic a bit and cleans up
more.

  From: Florian Fainelli <f.fainelli@gmail.com>
  Subject: [PATCH] PCI: brcmstb: Do not use __GENMASK

-- 
With Best Regards,
Andy Shevchenko


