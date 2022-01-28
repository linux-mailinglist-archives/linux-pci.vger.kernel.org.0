Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCB049F4B8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 08:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347042AbiA1Hs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 02:48:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:13161 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243077AbiA1Hsv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 02:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643356131; x=1674892131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yA9I1TVBAWLRwxa+kG83/UciNiFWOt5jTTLojABMHJc=;
  b=Hhu+Kw+mPXfXIHz19qz9thMoPF0gyxQP4SpeBcZG4THqproq5YZPF4ks
   qDf9fhpvonXqMdct9BXAZRJQlCxIMtETgFycaEmQfnxMyfKfchyziHHWa
   vUdF3gGylf/YZ70PPH/Omqpz4ekYVfbLyKDoIEdJUk3WT0oZkXYzhmDuN
   N87GOhzAJBxe4ZCJe1czyrq16coK2W8iMlzVDxECKdVyRyB8URWStTE1U
   /3p4BvzGav3Msl8RWkLBoxbavzu1cedbORNhSKzrE97IeXt4WjNlpLKti
   h2GRuVpY36hhuZeWoInJ6kSdav+C/U8cQ4IAlEMbPA7CWWi/iuPi/kbER
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="245912884"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245912884"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:48:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="581776906"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:48:43 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 28 Jan 2022 09:48:41 +0200
Date:   Fri, 28 Jan 2022 09:48:41 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as
 untrusted
Message-ID: <YfOf2X7Snm7cvDRV@lahna>
References: <20220120000409.2706549-1-rajatja@google.com>
 <20220121214117.GA1154852@bhelgaas>
 <Ye5GvQbFKo+CFtRb@lahna>
 <Ye/X7E2dKb+zem34@lahna>
 <Ye/btvA1rLB2rp02@kroah.com>
 <Ye/zTHR5aCG58z87@lahna>
 <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
 <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jan 27, 2022 at 02:26:07PM -0800, Rajat Jain wrote:
> Hello Rafael, Bjorn, Mika, Dmitry, Greg,
> 
> Thanks a lot for your comments.
> 
> On Tue, Jan 25, 2022 at 6:45 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jan 25, 2022 at 1:55 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Tue, Jan 25, 2022 at 12:15:02PM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Jan 25, 2022 at 12:58:52PM +0200, Mika Westerberg wrote:
> > > > > On Mon, Jan 24, 2022 at 08:27:17AM +0200, Mika Westerberg wrote:
> > > > > > > > This patch introduces a new "UntrustedDevice" property that can be used
> > > > > > > > by the firmware to mark any device as untrusted.
> > > > > >
> > > > > > I think this new property should be documented somewhere too (also
> > > > > > explain when to use it instead of ExternalFacingPort). If not in the
> > > > > > next ACPI spec or some supplemental doc then perhaps in the DT bindings
> > > > > > under Documentation/devicetree/bindings.
> > > > >
> > > > > Actually Microsoft has similar already:
> > > > >
> > > > > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> > > > >
> > > > > I think we should use that too here.
> 
> But because this property also applies to a root port (only), it only
> helps if the device is downstream a PCIe root port. In our case, we
> have an internal (wifi) device 00:14.3 (sits on the internal PCI bus
> 0), so cannot use this.

Right. I wonder if we can expand it to cover all internal devices, not
just PCIe root ports? We anyways need to support that property so does
not make much sense to me to invent yet another that does pretty much
the same thing.
