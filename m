Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938A045468A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 13:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhKQMpf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 07:45:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:53571 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233710AbhKQMpf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 07:45:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="231414855"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="231414855"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 04:42:36 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="593340140"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 04:42:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mnKGf-007n8z-Te;
        Wed, 17 Nov 2021 14:42:25 +0200
Date:   Wed, 17 Nov 2021 14:42:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
Message-ID: <YZT4sdwf25XV6pKu@smile.fi.intel.com>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
 <41b85802-6118-33a6-692a-043d74b82d8e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b85802-6118-33a6-692a-043d74b82d8e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 16, 2021 at 12:38:39PM -0800, Florian Fainelli wrote:
> On 11/15/21 3:20 AM, Andy Shevchenko wrote:
> > Use BIT() as __GENMASK() is for internal use only. The rationale
> > of switching to BIT() is to provide better generated code. The
> > GENMASK() against non-constant numbers may produce an ugly assembler
> > code. On contrary the BIT() is simply converted to corresponding shift
> > operation.
> 
> The code is not necessarily any different on ARMv8 as far as I can tell,
> before:
> 
> static void brcm_msi_set_regs(struct brcm_msi *msi)
> {
>         u32 val = __GENMASK(31, msi->legacy_shift);
>       84:       b9406402        ldr     w2, [x0,#100]
>       88:       d2800021        mov     x1, #0x1
> // #1
>       8c:       9ac22021        lsl     x1, x1, x2
>       90:       4b0103e1        neg     w1, w1
> 
> 
> after:
> 
> static void brcm_msi_set_regs(struct brcm_msi *msi)
> {
>         u32 val = ~(BIT(msi->legacy_shift) - 1);
>       84:       b9406402        ldr     w2, [x0,#100]
>       88:       d2800021        mov     x1, #0x1
> // #1
>       8c:       9ac22021        lsl     x1, x1, x2
>       90:       4b0103e1        neg     w1, w1
> 
> and the usage of BIT() does not make this any clearer.

While I disagree on the conclusion it's good that assembly isn't bad.
Last time I have tried to compile just GENMASK() excerpts for arm32
the non-constant variants were quite bad. And it was obvious win for
BIT() over GENMASK().

Actually it maybe that I have tested something like

  `GENMASK(C1 + var, C2 + var)` vs. `GENMASK(C1, C2) << var`

that time.

-- 
With Best Regards,
Andy Shevchenko


