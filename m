Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6441626C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbhIWPvU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 11:51:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:33993 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242288AbhIWPvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Sep 2021 11:51:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="309431278"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="309431278"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 08:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="455159545"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 23 Sep 2021 08:44:17 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 52936580890;
        Thu, 23 Sep 2021 08:44:17 -0700 (PDT)
Message-ID: <49c93d8b83d668873fbe6dd5798db7a7e9fb5b61.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Add general DVSEC/VSEC support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, lee.jones@linaro.org,
        bhelgaas@google.com, andy.shevchenko@gmail.com
Cc:     mgross@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Thu, 23 Sep 2021 08:44:17 -0700
In-Reply-To: <da8d9c79-d041-b7fa-6ee3-3abfcfcb0ef6@redhat.com>
References: <20210922213007.2738388-1-david.e.box@linux.intel.com>
         <da8d9c79-d041-b7fa-6ee3-3abfcfcb0ef6@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-09-23 at 11:04 +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/22/21 11:30 PM, David E. Box wrote:
> > This patch enables general support for Intel defined PCIe VSEC and DVSEC
> > capabilities in the Intel Platform Monitoring Technology (PMT) driver.
> > Though the driver was written exclusively for PMT capabilities, newer DVSEC
> > and VSEC IDs for other capabilities can exist on the same device requiring
> > that the driver handle them.
> > 
> > V3 is mostly a resend of V2. It drops a platform/x86 patch that was picked
> > up separately by Hans in the last cycle. It also adds a new patch to
> > support an upcoming capability.
> > 
> > David E. Box (5):
> >   PCI: Add #defines for accessing PCIE DVSEC fields
> >   MFD: intel_pmt: Support non-PMT capabilities
> >   MFD: intel_pmt: Add support for PCIe VSEC structures
> >   MFD: intel_pmt: Add DG2 support
> >   MFD: intel_extended_cap: Add support for Intel SDSi
> 
> Since this mostly touches drivers/mfd/intel_pmt.c, I assume this is
> going to get merged through the MFD trees.

Yes. Thanks.

> 
> For the few small drivers/platform/x86 changes:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> > 
> >  drivers/mfd/intel_pmt.c                    | 258 +++++++++++++++------
> >  drivers/platform/x86/intel/pmt/class.c     |   2 +
> >  drivers/platform/x86/intel/pmt/crashlog.c  |   2 +-
> >  drivers/platform/x86/intel/pmt/telemetry.c |   2 +-
> >  include/uapi/linux/pci_regs.h              |   4 +
> >  5 files changed, 191 insertions(+), 77 deletions(-)
> > 
> 


