Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D49B1C557C
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgEEMdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 08:33:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:62727 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgEEMdM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 08:33:12 -0400
IronPort-SDR: 7px5wkjSNyePEMPMdHDj0lDWC82F5ZoU6nTIjSMFV9WF2hoiouZNmycxFD3eGUZJmk5Bg6GA2B
 iWFRvaNhc8eg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 05:33:11 -0700
IronPort-SDR: O//FIgO1QeU78Ic4Kwn2UYwljPtMBfnZpf9xCjsm0mnQKb7sZf+PP9SJWmGzBkwggcAYmpvgZ5
 O6TkQwRijObw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="369398624"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 May 2020 05:33:06 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 05 May 2020 15:33:06 +0300
Date:   Tue, 5 May 2020 15:33:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, jean-philippe@linaro.org,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Keany, Bernie" <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200505123306.GC487496@lahna.fi.intel.com>
References: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> Hi,

Hi,

> Currently, the PCI subsystem marks the PCI devices as "untrusted", if
> the firmware asks it to:
> 
> 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> 9cb30a71acd4 ("PCI: OF: Support "external-facing" property")
> 
> An "untrusted" device indicates a (likely external facing) device that
> may be malicious, and can trigger DMA attacks on the system. It may
> also try to exploit any vulnerabilities exposed by the driver, that
> may allow it to read/write unintended addresses in the host (e.g. if
> DMA buffers for the device, share memory pages with other driver data
> structures or code etc).
> 
> High Level proposal
> ===============
> Currently, the "untrusted" device property is used as a hint to enable
> IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
> go a step further, and allow the administrator to build a list of
> whitelisted drivers for these "untrusted" devices. This whitelist of
> drivers are the ones that he trusts enough to have little or no
> vulnerabilities. (He may have built this list of whitelisted drivers
> by a combination of code analysis of drivers, or by extensive testing
> using PCIe fuzzing etc). We propose that the administrator be allowed
> to specify this list of whitelisted drivers to the kernel, and the PCI
> subsystem to impose this behavior:
> 
> 1) The "untrusted" devices can bind to only "whitelisted drivers".
> 2) The other devices (i.e. dev->untrusted=0) can bind to any driver.
> 
> Of course this behavior is to be imposed only if such a whitelist is
> provided by the administrator.
> 
> Details
> ======
> 
> 1) A kernel argument ("pci.impose_driver_whitelisting") to enable
> imposing of whitelisting by PCI subsystem.

In addition this could be a Kconfig option, I think.

> 2) Add a flag ("whitelisted") in struct pci_driver to indicate whether
> the driver is whitelisted.
> 
> 3) Use the driver's "whitelisted" flag and the device's "untrusted"
> flag, to make a decision about whether to bind or not in
> pci_bus_match() or similar.
> 
> 4) A mechanism to allow the administrator to specify the whitelist of
> drivers. I think this needs more thought as there are multiple
> options.
> 
> a) Expose individual driver's "whitelisted" flag to userspace so a
> boot script can whitelist that driver. There are questions that still
> need answered though e.g. what to do about the devices that may have
> already been enumerated and rejected by then? What to do with the
> already bound devices, if the user changes a driver to remove it from
> the whitelist. etc.
> 
>       b) Provide a way to specify the whitelist via the kernel command
> line. Accept a ("pci.whitelist") kernel parameter which is a comma
> separated list of driver names (just like "module_blacklist"), and
> then use it to initialize each driver's "whitelisted" flag as the
> drivers are registered. Essentially this would mean that the whitelist
> of devices cannot be changed after boot.
> 
> To me (b) looks a better option but I think a future requirement would
> be the ability to remove the drivers from the whitelist after boot
> (adding drivers to whitelist at runtime may not be that critical IMO)

What about adding "module.whitelisted" parameter in the same way than we
have for example "module.dyndbg"? Then you can pass these in the command
line, during module load time and also trough /sys/module/.
