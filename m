Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374593DE9EF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 11:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhHCJqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 05:46:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:54698 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235113AbhHCJqh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 05:46:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="235578551"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="235578551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 02:45:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="584669785"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 02:45:51 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 03 Aug 2021 12:45:49 +0300
Date:   Tue, 3 Aug 2021 12:45:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, bhelgaas@google.com,
        YehezkelShB@gmail.com, Basavaraj.Natikar@amd.com,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Add AMD USB4 host router device IDs
Message-ID: <YQkQTWxWK3YzFYeJ@lahna>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-2-git-send-email-Sanju.Mehta@amd.com>
 <YQgLX2CukV8oc8eW@lahna>
 <8578079b-76f1-b596-db3c-e02618724ba7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8578079b-76f1-b596-db3c-e02618724ba7@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I have one more comment, see below.

On Mon, Aug 02, 2021 at 11:39:32PM +0530, Sanjay R Mehta wrote:
> 
> 
> On 8/2/2021 8:42 PM, Mika Westerberg wrote:
> > [CAUTION: External Email]
> > 
> > On Mon, Aug 02, 2021 at 07:58:17AM -0500, Sanjay R Mehta wrote:
> >> From: Sanjay R Mehta <sanju.mehta@amd.com>
> >>
> >> This patch enables support for AMD USB4 host router.
> >>
> >> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> >> ---
> >>  drivers/thunderbolt/nhi.c | 4 ++++
> >>  include/linux/pci_ids.h   | 2 ++
> >>  2 files changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> >> index fa44332..d7d9c4b 100644
> >> --- a/drivers/thunderbolt/nhi.c
> >> +++ b/drivers/thunderbolt/nhi.c
> >> @@ -1338,6 +1338,10 @@ static struct pci_device_id nhi_ids[] = {
> >>       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_NHI1),
> >>         .driver_data = (kernel_ulong_t)&icl_nhi_ops },
> >>
> >> +     /* AMD USB4 host */
> >> +     { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA0) },
> >> +     { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA1) },
> >> +

I wonder if AMD USB4 controller exposes the USB4 PCI class ID? If that's
the case and you don't need any special quirking like Intel does then we
don't need to add any PCI IDs here and allow the below line to match.

This is actually what I hope we get eventually in Intel HW too.

> >>       /* Any USB4 compliant host */
> >>       { PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_USB4, ~0) },
