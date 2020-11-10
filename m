Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AC2ADDC0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 19:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKJSHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 13:07:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:56468 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgKJSHA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 13:07:00 -0500
IronPort-SDR: 0zA6zNcxjRvIP9M/4krLs9m7neNw04/+fTgIKdBKSaXViF9b+dMJqsxOPiGTbERfAf0vWlOzEc
 6lR0o25MobfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="234189632"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="234189632"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 10:06:53 -0800
IronPort-SDR: /nfePAnqjQMI6cF0FnQ+JBblmL1nP/m91B+IUFee3M202qcuN6NkaC3M+Qu5UeYCMuh2ZRuiBn
 qeJw7PPWPwCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="356252584"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2020 10:06:53 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 86B9F58088D;
        Tue, 10 Nov 2020 10:06:53 -0800 (PST)
Message-ID: <c8b880d6ff609c79b18afd3d0b5a317b6d36f05f.camel@linux.intel.com>
Subject: Re: [PATCH V8 2/5] mfd: Intel Platform Monitoring Technology support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>, andy@infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alexey.budankov@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Nov 2020 10:06:53 -0800
In-Reply-To: <CAMuHMdXPMNGtnvZKRVofQ7KhuveTadfp+V0Q73YOWkdTgr0aZQ@mail.gmail.com>
References: <20201003013123.20269-1-david.e.box@linux.intel.com>
         <20201003013123.20269-3-david.e.box@linux.intel.com>
         <CAMuHMdXPMNGtnvZKRVofQ7KhuveTadfp+V0Q73YOWkdTgr0aZQ@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

On Tue, 2020-11-10 at 11:39 +0100, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Sat, Oct 3, 2020 at 3:32 AM David E. Box <
> david.e.box@linux.intel.com> wrote:
> > Intel Platform Monitoring Technology (PMT) is an architecture for
> > enumerating and accessing hardware monitoring facilities. PMT
> > supports
> > multiple types of monitoring capabilities. This driver creates
> > platform
> > devices for each type so that they may be managed by capability
> > specific
> > drivers (to be introduced). Capabilities are discovered using PCIe
> > DVSEC
> > ids. Support is included for the 3 current capability types,
> > Telemetry,
> > Watcher, and Crashlog. The features are available on new Intel
> > platforms
> > starting from Tiger Lake for which support is added. This patch
> > adds
> > support for Tiger Lake (TGL), Alder Lake (ADL), and Out-of-Band
> > Management
> > Services Module (OOBMSM).
> > 
> > Also add a quirk mechanism for several early hardware differences
> > and bugs.
> > For Tiger Lake and Alder Lake, do not support Watcher and Crashlog
> > capabilities since they will not be compatible with future product.
> > Also,
> > fix use a quirk to fix the discovery table offset.
> > 
> > Co-developed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com
> > >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Thanks for your patch, which is now commit 4f8217d5b0ca8ace ("mfd:
> Intel
> Platform Monitoring Technology support") in the mfd/for-mfd-next.
> 
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -670,6 +670,16 @@ config MFD_INTEL_PMC_BXT
> >           Register and P-unit access. In addition this creates
> > devices
> >           for iTCO watchdog and telemetry that are part of the PMC.
> > 
> > +config MFD_INTEL_PMT
> > +       tristate "Intel Platform Monitoring Technology (PMT)
> > support"
> > +       depends on PCI
> 
> Does this need a "depend on X86 || COMPILE_TEST", to prevent the
> question from showing up on platforms where the PMT cannot be
> present?

Though not currently available on non X86 hardware it is not
restricted. The use of PCIE Designated Vendor Specific Capability
(DVSEC) was to specifically allow use of this IP by other vendors.

> 
> I see the TGL and ADL PCI IDs are also referenced from
> drivers/platform/x86/intel_pmt_telemetry.c, which suggests this is
> X86-only.
> Perhaps the OOBMSM is a PCI device that can be used on non-X86
> platforms?

TGL and AGL are only referenced in this driver because they require
quirks.

Thanks

David

