Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCC046DBD4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhLHTNY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:13:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:1990 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232974AbhLHTNY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Dec 2021 14:13:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="237716644"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="237716644"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 11:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="580693494"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2021 11:09:49 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id E7AA05807B4;
        Wed,  8 Dec 2021 11:09:48 -0800 (PST)
Message-ID: <a70956e1c4da10603e29087e893cbae62ce82631.camel@linux.intel.com>
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
Date:   Wed, 08 Dec 2021 11:09:48 -0800
In-Reply-To: <YbD1NsYHbU8FvtTN@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
         <20211208015015.891275-4-david.e.box@linux.intel.com>
         <YbDbql39x7Kw6iAC@kroah.com>
         <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
         <YbD1NsYHbU8FvtTN@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2021-12-08 at 19:11 +0100, Greg KH wrote:
> On Wed, Dec 08, 2021 at 09:47:26AM -0800, David E. Box wrote:
> > On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
> > > On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box wrote:
> > > > +static struct pci_driver intel_vsec_pci_driver = {
> > > > +       .name = "intel_vsec",
> > > > +       .id_table = intel_vsec_pci_ids,
> > > > +       .probe = intel_vsec_pci_probe,
> > > > +};
> > > 
> > > So when the PCI device is removed from the system you leak resources and
> > > have dangling devices?
> > 
> > No.
> > 
> > > 
> > > Why no PCI remove driver callback?
> > 
> > After probe all resources are device managed. There's nothing to explicitly clean up. When the
> > PCI
> > device is removed, all aux devices are automatically removed. This is the case for the SDSi
> > driver
> > as well.
> 
> Where is the "automatic cleanup" happening?  As this pci driver is bound
> to the PCI device, when the device is removed, what is called in this
> driver to remove the resources allocated in the probe callback?
> 
> confused,

devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux, auxdev)

intel_vsec_remove_aux() gets called when the PCI device is removed. It calls auxiliary_device_unit()
which in turn calls the auxdev release() function that cleans up resources.

When the auxdev is removed, all resources that were dev_m added by the SDSi driver are released too
which is why it has no remove() either. I'll add the tests that check this.

David

> 
> greg k-h


