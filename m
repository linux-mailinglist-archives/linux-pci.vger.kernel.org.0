Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3C29E104
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbgJ2BvB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 21:51:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:29254 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbgJ2BuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 21:50:16 -0400
IronPort-SDR: NLXl/uXU5rXfatNKBQZ+IkJVFGAhFrb90s2PEsn0baIqkp6nqcDsyPaiIyQLMdh6dktnsPszeu
 P25Pe8J16n+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="148223352"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="148223352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 18:50:16 -0700
IronPort-SDR: a/1YpQpkjMfBOpev4qFBdcqtkHKgowerUWj6XMMgryi8Z36+NdWLLaUlJPP+eTLsvl+HIaKXp6
 mHYRP20rMCbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="334942495"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 28 Oct 2020 18:50:16 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 37581580718;
        Wed, 28 Oct 2020 18:50:16 -0700 (PDT)
Message-ID: <bc5f059c5bae957daebde699945c80808286bf45.camel@linux.intel.com>
Subject: Re: [PATCH V8 0/5] Intel Platform Monitoring Technology
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexey.budankov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Wed, 28 Oct 2020 18:50:16 -0700
In-Reply-To: <2f17db4b-2988-7f0d-fd0e-9e5b621d24ec@redhat.com>
References: <20201003013123.20269-1-david.e.box@linux.intel.com>
         <2f17db4b-2988-7f0d-fd0e-9e5b621d24ec@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-10-27 at 12:28 +0100, Hans de Goede wrote:
> Hi,
> 
> On 10/3/20 3:31 AM, David E. Box wrote:
> > Intel Platform Monitoring Technology (PMT) is an architecture for
> > enumerating and accessing hardware monitoring capabilities on a
> > device.
> > With customers increasingly asking for hardware telemetry,
> > engineers not
> > only have to figure out how to measure and collect data, but also
> > how to
> > deliver it and make it discoverable. The latter may be through some
> > device
> > specific method requiring device specific tools to collect the
> > data. This
> > in turn requires customers to manage a suite of different tools in
> > order to
> > collect the differing assortment of monitoring data on their
> > systems.  Even
> > when such information can be provided in kernel drivers, they may
> > require
> > constant maintenance to update register mappings as they change
> > with
> > firmware updates and new versions of hardware. PMT provides a
> > solution for
> > discovering and reading telemetry from a device through a hardware
> > agnostic
> > framework that allows for updates to systems without requiring
> > patches to
> > the kernel or software tools.
> > 
> > PMT defines several capabilities to support collecting monitoring
> > data from
> > hardware. All are discoverable as separate instances of the PCIE
> > Designated
> > Vendor extended capability (DVSEC) with the Intel vendor code. The
> > DVSEC ID
> > field uniquely identifies the capability. Each DVSEC also provides
> > a BAR
> > offset to a header that defines capability-specific attributes,
> > including
> > GUID, feature type, offset and length, as well as configuration
> > settings
> > where applicable. The GUID uniquely identifies the register space
> > of any
> > monitor data exposed by the capability. The GUID is associated with
> > an XML
> > file from the vendor that describes the mapping of the register
> > space along
> > with properties of the monitor data. This allows vendors to perform
> > firmware updates that can change the mapping (e.g. add new metrics)
> > without
> > requiring any changes to drivers or software tools. The new mapping
> > is
> > confirmed by an updated GUID, read from the hardware, which
> > software uses
> > with a new XML.
> > 
> > The current capabilities defined by PMT are Telemetry, Watcher, and
> > Crashlog.  The Telemetry capability provides access to a continuous
> > block
> > of read only data. The Watcher capability provides access to
> > hardware
> > sampling and tracing features. Crashlog provides access to device
> > crash
> > dumps.  While there is some relationship between capabilities
> > (Watcher can
> > be configured to sample from the Telemetry data set) each exists as
> > stand
> > alone features with no dependency on any other. The design
> > therefore splits
> > them into individual, capability specific drivers. MFD is used to
> > create
> > platform devices for each capability so that they may be managed by
> > their
> > own driver. The PMT architecture is (for the most part) agnostic to
> > the
> > type of device it can collect from. Software can determine which
> > devices
> > support a PMT feature by searching through each device node entry
> > in the
> > sysfs class folder. It can additionally determine if a particular
> > device
> > supports a PMT feature by checking for a PMT class folder in the
> > device
> > folder.
> > 
> > This patch set provides support for the PMT framework, along with
> > support
> > for Telemetry on Tiger Lake.
> 
> The entire series looks good to me, so you may add my:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks. I did send out a V9 after rebasing and noticing that I
accidentally dropped a change in the MFD driver between V7 and V8. This
was added back. I also took the opportunity to get rid of a nuisance
dev_warn.

David

