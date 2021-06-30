Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372613B8A0F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 23:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhF3VOW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 17:14:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:4366 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235470AbhF3VOI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jun 2021 17:14:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195720895"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="195720895"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 14:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="447630144"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2021 14:11:39 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.174])
        by linux.intel.com (Postfix) with ESMTP id EE3C4580279;
        Wed, 30 Jun 2021 14:11:38 -0700 (PDT)
Message-ID: <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
Subject: Re: [PATCH 2/4] MFD: intel_pmt: Remove OOBMSM device
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Jun 2021 14:11:38 -0700
In-Reply-To: <YNxENGGctLXmifzj@dell>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
         <20210617215408.1412409-3-david.e.box@linux.intel.com>
         <YNxENGGctLXmifzj@dell>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2021-06-30 at 11:15 +0100, Lee Jones wrote:
> On Thu, 17 Jun 2021, David E. Box wrote:
> 
> > Unlike the other devices in intel_pmt, the Out of Band Management
> > Services
> > Module (OOBMSM) is actually not a PMT dedicated device. It can also
> > be used
> > to describe non-PMT capabilities. Like PMT, these capabilities are
> > also
> > enumerated using PCIe Vendor Specific registers in config space. In
> > order
> > to better support these devices without the confusion of a
> > dependency on
> > MFD_INTEL_PMT, remove the OOBMSM device from intel_pmt so that it
> > can be
> > later placed in its own driver. Since much of the same code will be
> > used by
> > intel_pmt and the new driver, create a new file with symbols to be
> > used by
> > both.
> > 
> > While performing this split we need to also handle the creation of
> > platform
> > devices for the non-PMT capabilities. Currently PMT devices are
> > named by
> > their capability (e.g. pmt_telemetry). Instead, generically name
> > them by
> > their capability ID (e.g. intel_extnd_cap_2). This allows the IDs
> > to be
> > created automatically.  However, to ensure that unsupported devices
> > aren't
> > created, use an allow list to specify supported capabilities.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  MAINTAINERS                                |   1 +
> >  drivers/mfd/Kconfig                        |   4 +
> >  drivers/mfd/Makefile                       |   1 +
> >  drivers/mfd/intel_extended_caps.c          | 208
> > +++++++++++++++++++++
> 
> Please consider moving this <whatever this is> out to either
> drivers/pci or drivers/platform/x86.

None of the cell drivers are in MFD, only the PCI drivers from which
the cells are created. I understood that these should be in MFD. But
moving it to drivers/platform/x86 would be fine with me. That keeps the
code together in the same subsystem. Comment from Hans or Andy? 

> 
> I suggest Andy should also be on Cc.
> 
> >  drivers/mfd/intel_extended_caps.h          |  40 ++++
> >  drivers/mfd/intel_pmt.c                    | 198 ++---------------
> > ---
> >  drivers/platform/x86/intel_pmt_crashlog.c  |   2 +-
> >  drivers/platform/x86/intel_pmt_telemetry.c |   2 +-
> >  8 files changed, 270 insertions(+), 186 deletions(-)
> >  create mode 100644 drivers/mfd/intel_extended_caps.c
> >  create mode 100644 drivers/mfd/intel_extended_caps.h
> 


