Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4177349B48D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348779AbiAYNCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 08:02:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:51283 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1573866AbiAYNAG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jan 2022 08:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643115603; x=1674651603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yzsKhozAAf7/ioiWYX2kSFAetWf23UwLpvHuHDWhI9Q=;
  b=NR//p5kdFiAZh6yjNHLWilqU/esPUsLI97gCAJQO46Znm7s9P582cdZV
   CsUMdUhwdKSpo66axky/dVc2slTqkCtDACYv6mVrPLQcGU+AhjPC8y47U
   Gl4+ivl6Ppcrr+J6/fS4sEzSKpKjU61hXQOEJmhQU6GRqtuYhRIWTjxZx
   9HV7taQQHtJBH0OL3BZ69x5uyz984UzlZBVMO7wlt7hBrY3SGYMJo9MFz
   GBCjR6Pa+1qmN0FgiY6McsxvNi9Tpz8Rx9oUJaOLGqyUhtBO3DqXCRua0
   ynfu1a/iILtlO8LlN9X15kqPLudy0QPCBjlZJ9b73LmuPqJX8GFgvDZqq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="229866371"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="229866371"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 04:55:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="695823077"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 04:55:42 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jan 2022 14:55:40 +0200
Date:   Tue, 25 Jan 2022 14:55:40 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        dtor@google.com, jsbarnes@google.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as
 untrusted
Message-ID: <Ye/zTHR5aCG58z87@lahna>
References: <20220120000409.2706549-1-rajatja@google.com>
 <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna>
 <Ye/X7E2dKb+zem34@lahna>
 <Ye/btvA1rLB2rp02@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye/btvA1rLB2rp02@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 25, 2022 at 12:15:02PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 25, 2022 at 12:58:52PM +0200, Mika Westerberg wrote:
> > On Mon, Jan 24, 2022 at 08:27:17AM +0200, Mika Westerberg wrote:
> > > > > This patch introduces a new "UntrustedDevice" property that can be used
> > > > > by the firmware to mark any device as untrusted.
> > > 
> > > I think this new property should be documented somewhere too (also
> > > explain when to use it instead of ExternalFacingPort). If not in the
> > > next ACPI spec or some supplemental doc then perhaps in the DT bindings
> > > under Documentation/devicetree/bindings.
> > 
> > Actually Microsoft has similar already:
> > 
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> > 
> > I think we should use that too here.
> 
> But we do not have "dma protection" for Linux, so how will that value
> make sense?

Yes I think we do - IOMMU. That's the same thing what we do now for
"External Facing Ports". This one just is for internal ones.

> And shouldn't this be an ACPI standard?

Probably should or some supplemental doc but not sure how easy these
"properties" can be added there to be honest.

Some of these that we use in Linux too are from that same page:

https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports

Namely these: HotPlugSupportInD3, ExternalFacingPort, usb4-host-interface,
usb4-port-number and StorageD3Enable.
