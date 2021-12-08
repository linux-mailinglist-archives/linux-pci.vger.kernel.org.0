Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2D46DA79
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 18:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbhLHR6L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 12:58:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:30482 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238314AbhLHR6L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Dec 2021 12:58:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218575907"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="218575907"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 09:47:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="580668623"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2021 09:47:27 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 06BF55807B4;
        Wed,  8 Dec 2021 09:47:27 -0800 (PST)
Message-ID: <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from
 MFD to Auxiliary Bus
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Wed, 08 Dec 2021 09:47:26 -0800
In-Reply-To: <YbDbql39x7Kw6iAC@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
         <20211208015015.891275-4-david.e.box@linux.intel.com>
         <YbDbql39x7Kw6iAC@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
> On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box wrote:
> > +static struct pci_driver intel_vsec_pci_driver = {
> > +       .name = "intel_vsec",
> > +       .id_table = intel_vsec_pci_ids,
> > +       .probe = intel_vsec_pci_probe,
> > +};
> 
> So when the PCI device is removed from the system you leak resources and
> have dangling devices?

No.

> 
> Why no PCI remove driver callback?

After probe all resources are device managed. There's nothing to explicitly clean up. When the PCI
device is removed, all aux devices are automatically removed. This is the case for the SDSi driver
as well.

David

> 
> thanks,
> 
> greg k-h


