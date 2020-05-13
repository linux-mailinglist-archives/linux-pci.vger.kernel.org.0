Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D491D18F6
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgEMPTc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 11:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbgEMPTc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 11:19:32 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F3D205ED;
        Wed, 13 May 2020 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589383172;
        bh=WbLqL/5eymtO9GLVJ9qlG2jFrw93tztcfcV1wQd+XnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AJK+XI8OUUOjjldXakTkNBBUJc5oExYahTtrlCdOhvYLDGsoQWZ8SjtyFoZSXcliy
         GkTCoRM/5sgzfdQKCNOFoWDlXy5MMh9t6vY0TF/xMXMSfCTsflDKESO+RzFG1oyRBM
         O3htetDWa/+z3IvyNjdTut8eSOVnNZHQPMWckkNw=
Date:   Wed, 13 May 2020 10:19:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200513151929.GA38418@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christian (bolt maintainer), Alex, Joerg (IOMMU folks)]

On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> Hi,
> 
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
> 
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

We definitely have some problems in this area.

- Thunderbolt has similar security issues, and "bolt"
  (https://gitlab.freedesktop.org/bolt/bolt) provides a user interface
  for authorizing devices.  Bolt is device-oriented (and specifically
  for Thunderbolt), not driver-oriented, and I have no idea what
  kernel interfaces it uses, but I wonder if there's some overlap with
  this proposal.  It seems like both bolt and this proposal could
  ultimately be part of the same user interface.

- ATS allows PCIe endpoints to cache address translations so they
  can generate DMAs with translated addresses (TLP Address Type 10b,
  see PCIe r5.0, sec 10.2.1).  These DMAs can potentially bypass
  the IOMMU.

  AFAICT, amd_iommu always turns on ATS when possible.  It looks
  like intel-iommu and arm-smmu-v3 turn it on except for "untrusted"
  (external) devices.

  There's nothing to prevent a malicious external device from
  generating DMA with translated addresses even if we haven't
  enabled ATS.

  I think all three IOMMUs have mechanisms to block TLPs with
  translated addresses, but I can't tell whether they all *use*
  them.

- ACS is an optional capability, but if implemented at all, downstream
  ports (including root ports) are required to implement Translation
  Blocking.  When enabled, this blocks upstream memory requests with
  non-default AT fields.

  Linux currently never enables Translation Blocking.  Maybe the IOMMU
  protection is sufficient, but I think we should consider enabling TB
  by default and disabling it only when required to enable ATS.  That
  may catch malicious TLPs closer to the source and help when there is
  no IOMMU at all.
