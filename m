Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31343B989F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 00:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhGAWnf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 18:43:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:50271 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232637AbhGAWnf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 18:43:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="230294423"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="230294423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 15:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="426317852"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 Jul 2021 15:41:03 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.138])
        by linux.intel.com (Postfix) with ESMTP id 258E858072C;
        Thu,  1 Jul 2021 15:41:03 -0700 (PDT)
Message-ID: <9145724ab16d9cdf10f755fd52150d8dcb9ac057.camel@linux.intel.com>
Subject: Re: [PATCH 2/4] MFD: intel_pmt: Remove OOBMSM device
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     mgross@linux.intel.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 01 Jul 2021 15:41:03 -0700
In-Reply-To: <YN2lmdDAOaykCvHK@dell>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
         <20210617215408.1412409-3-david.e.box@linux.intel.com>
         <YNxENGGctLXmifzj@dell>
         <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
         <e734a968-818a-380d-0ae5-fee41b3db246@redhat.com> <YN2lmdDAOaykCvHK@dell>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-07-01 at 12:23 +0100, Lee Jones wrote:
> On Thu, 01 Jul 2021, Hans de Goede wrote:
> 
> > Hi,
> > 
> > On 6/30/21 11:11 PM, David E. Box wrote:
> > > On Wed, 2021-06-30 at 11:15 +0100, Lee Jones wrote:
> > > > On Thu, 17 Jun 2021, David E. Box wrote:
> > > > 
> > > > > Unlike the other devices in intel_pmt, the Out of Band
> > > > > Management
> > > > > Services
> > > > > Module (OOBMSM) is actually not a PMT dedicated device. It
> > > > > can also
> > > > > be used
> > > > > to describe non-PMT capabilities. Like PMT, these
> > > > > capabilities are
> > > > > also
> > > > > enumerated using PCIe Vendor Specific registers in config
> > > > > space. In
> > > > > order
> > > > > to better support these devices without the confusion of a
> > > > > dependency on
> > > > > MFD_INTEL_PMT, remove the OOBMSM device from intel_pmt so
> > > > > that it
> > > > > can be
> > > > > later placed in its own driver. Since much of the same code
> > > > > will be
> > > > > used by
> > > > > intel_pmt and the new driver, create a new file with symbols
> > > > > to be
> > > > > used by
> > > > > both.
> > > > > 
> > > > > While performing this split we need to also handle the
> > > > > creation of
> > > > > platform
> > > > > devices for the non-PMT capabilities. Currently PMT devices
> > > > > are
> > > > > named by
> > > > > their capability (e.g. pmt_telemetry). Instead, generically
> > > > > name
> > > > > them by
> > > > > their capability ID (e.g. intel_extnd_cap_2). This allows the
> > > > > IDs
> > > > > to be
> > > > > created automatically.  However, to ensure that unsupported
> > > > > devices
> > > > > aren't
> > > > > created, use an allow list to specify supported capabilities.
> > > > > 
> > > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > > ---
> > > > >  MAINTAINERS                                |   1 +
> > > > >  drivers/mfd/Kconfig                        |   4 +
> > > > >  drivers/mfd/Makefile                       |   1 +
> > > > >  drivers/mfd/intel_extended_caps.c          | 208
> > > > > +++++++++++++++++++++
> > > > 
> > > > Please consider moving this <whatever this is> out to either
> > > > drivers/pci or drivers/platform/x86.
> > > 
> > > None of the cell drivers are in MFD, only the PCI drivers from
> > > which
> > > the cells are created. I understood that these should be in MFD.
> > > But
> > > moving it to drivers/platform/x86 would be fine with me. That
> > > keeps the
> > > code together in the same subsystem. Comment from Hans or Andy? 
> > 
> > I'm fine with moving everything to drivers/platform/x86, but AFAIK
> > usually the actual code which has the MFD cells and creates the
> > child devices usually lives under drivers/mfd
> 
> Correct.  It must.
> 
> No MFD API users outside of drivers/mfd please.
> 

No problem. But these patches are not child device drivers. They take
the existing intel_pmt MFD code and split it from the device driver
(similar to how intel-lpss core code is split from the acpi and pci bus
drivers). There are 2 drivers now, PMT-only and OOBMSM, that use a
common MFD API. This is why they all reside in MFD in this patchset.
But I could move the API callers to platform/x86.

But I'd like feedback on whether this split is even needed. I'm trying
to manage the fact that one of the devices in intel_pmt will now need
support for new, non-PMT, child devices. So there would be a mismatch
between what the driver and Kconfig are named vs what it actually
supports. I considered adding all the new cells to intel_pmt and
renaming the driver to something more generic, but I understand this
will be messy for OSVs managing Kconfig options. Thanks.

David

