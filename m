Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF7419E71
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhI0SmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 14:42:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:45371 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236238AbhI0SmQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 14:42:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="204029831"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="204029831"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 11:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="586882043"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2021 11:40:37 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 9239A580677;
        Mon, 27 Sep 2021 11:40:37 -0700 (PDT)
Message-ID: <d540894d3d8c05722bd924c21bd9dd9c2b9def53.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/5] MFD: intel_pmt: Support non-PMT capabilities
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, bhelgaas@google.com,
        andy.shevchenko@gmail.com, mgross@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Mon, 27 Sep 2021 11:40:37 -0700
In-Reply-To: <YVIBI6TQrD/rehli@kroah.com>
References: <20210922213007.2738388-1-david.e.box@linux.intel.com>
         <20210922213007.2738388-3-david.e.box@linux.intel.com>
         <YVIBI6TQrD/rehli@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2021-09-27 at 19:36 +0200, Greg KH wrote:
> On Wed, Sep 22, 2021 at 02:30:04PM -0700, David E. Box wrote:
> > Intel Platform Monitoring Technology (PMT) support is indicated by presence
> > of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
> > structures may also be used by Intel to indicate support for other
> > capabilities unrelated to PMT.  OOBMSM is a device that can have both PMT
> > and non-PMT capabilities. In order to support these capabilities it is
> > necessary to modify the intel_pmt driver to handle the creation of platform
> > devices more generically.
> 
> I said this on your other driver submission, but why are you turning a
> PCIe device into a set of platform devices and craming it into the MFD
> subsystem?
> 
> PCIe devices are NOT platform devices.

But they *are* used to create platform devices when the PCIe device is multi-functional, which is
what intel_pmt is.

> 
> Why not use the auxiliary bus for this thing if you have individual
> drivers that need to "bind" to the different attributes that this single
> PCIe device is exporting.

It wasn't clear in the beginning how this would evolve. MFD made sense for the PMT (platform
monitoring technology) driver. PMT has 3 related but individually enumerable devices on the same IP,
like lpss. But the same IP is now being used for other features too like SDSi. We could work on
converting this to the auxiliary bus and then covert the cell drivers.

> 
> Or why not just fix the hardware to report individual PCIe devices, like
> a sane system would do?

We have some systems with 1000+ PCIe devices. Each PCIe device adds cost to HW. So increasingly
VSEC/DVSEC is used to expose features which are handled by the same micro-controller in the HW.

>   Has this shipped in any devices yet?  If not,
> can that be fixed first?  It's just a firmware change, right?

PMT has been shipped for over a year. It's not just a firmware change.

David 
> 
> thanks,
> 
> greg k-h


