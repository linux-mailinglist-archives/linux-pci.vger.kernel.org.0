Return-Path: <linux-pci+bounces-43779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7316DCE561A
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 20:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E504E3013E82
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF62472A5;
	Sun, 28 Dec 2025 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUIFoLk2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A92459C6;
	Sun, 28 Dec 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766949117; cv=none; b=anuk5TQBXhbuoZVng9NxnXYlmnevOd0IFyiZ/Ftn3m9NIXBPG9MnjNqlLkEv4CqApDhMsv6szGGuXHdW3WiDkw68IX0gdrxRsQlTSd83cMFy0SmfdDH8bddvcu5vlU4b8z09n6M0MslH42r5CBmLZcoj1QBxoAdm2ywyWkcpF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766949117; c=relaxed/simple;
	bh=r/FdII+oIL6/rzaPqfN6eS2BnsuVliSTUInw2p4u9Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnRa5H8MZoYZuvZtx7e1upa5CgugXCEKTFu2v8ejZmtNsmsh+Yxkb4LF/8ipjH3Ryb9hj25Pn0ThZUVxhQ+K5LOXcwHlsp+n7C7uWQLpbpYEbYbONxpN0lYjdoCAv9cGCXoXOCQz9Ov2zsdzbfAnoKOP8DkAWvBIiDmSed68bDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUIFoLk2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766949115; x=1798485115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r/FdII+oIL6/rzaPqfN6eS2BnsuVliSTUInw2p4u9Wg=;
  b=IUIFoLk2Gmn2sSzgWCKfE82PLFwV+ZtB6SloQhLK1Tsy+xN6TnwOm0GA
   sk1DUrl/6o9wkiPfoDRrX7ux1iPKFfs21mIhX2p6NAQ1WuYT+AgTZUz2g
   V/tlkq0ltpimvBZ/DHJ33QRUvGh2cU7Wmccmi6MtrXh7zySTqOQYP2aVV
   ORt5/cSrYmRsico0ijih/oMvVqrGkU3v4B3ujMQ0p6W5wOmE+dSgFPHl5
   ca9kychHgIXxOwRVJVr/yvygqFAoz5TV2BWhDXkkvfkMXgYfuqTEhVxya
   +fjo+8eIV5wF7b7VTk0sdoOzQ869Ebqczh9gHYBy4XRnG5PSehafmeMnt
   Q==;
X-CSE-ConnectionGUID: u650zCn6S2avcCGETWmEwQ==
X-CSE-MsgGUID: pBDcLNb0Tua9PsBqhkr0hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="68743994"
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="68743994"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 11:11:55 -0800
X-CSE-ConnectionGUID: EoAN8NPGQtKs22FytW6B+A==
X-CSE-MsgGUID: PWPbLFyETbKwem1f5oqb/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="201053259"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 11:11:51 -0800
Date: Sun, 28 Dec 2025 21:11:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v1 1/4] ACPI: PNP: Drop PNP0C01 and PNP0C02 from
 acpi_pnp_device_ids[]
Message-ID: <aVGA9Mgwht_4nlPD@smile.fi.intel.com>
References: <7888874.EvYhyI6sBW@rafael.j.wysocki>
 <9550709.CDJkKcVGEf@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9550709.CDJkKcVGEf@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 15, 2025 at 02:34:06PM +0100, Rafael J. Wysocki wrote:

> There is a long-standing problem with ACPI device enumeration that
> if the given device has a compatible ID which is one of the generic
> system resource device IDs (PNP0C01 and PNP0C02), it will be claimed
> by the PNP scan handler and it will not be represented as a platform
> device, so it cannot be handled by a platform driver.
> 
> Drivers have been working around this issue by "manually" creating
> platform devices that they can bind to (see the Intel HID driver for
> one example) or adding their device IDs to acpi_nonpnp_device_ids[].
> None of the above is particularly clean though and the only reason why
> the PNP0C01 and PNP0C02 device IDs are present in acpi_pnp_device_ids[]
> is to allow the legacy PNP system driver to bind to those devices and
> reserve their resources so they are not used going forward.
> 
> Obviously, to address this problem PNP0C01 and PNP0C02 need to be
> dropped from acpi_pnp_device_ids[], but doing so without making any
> other changes would be problematic because the ACPI core would then
> create platform devices for the generic system resource device objects
> and that would not work on all systems for two reasons.  First, the
> PNP system driver explicitly avoids reserving I/O resources below the
> "standard PC hardware" boundary, 0x100, to avoid conflicts in that range
> (one possible case when this may happen is when the CMOS RTC driver is
> involved), but the platform device creation code does not do that.
> Second, there may be resource conflicts between the "system" devices and
> the other devices in the system, possibly including conflicts with PCI
> BARs.  Registering the PNP system driver via fs_initcall() helps to
> manage those conflicts, even though it does not make them go away.
> Resource conflicts during the registration of "motherboard resources"
> that occur after PCI has claimed BARs are harmless as a rule and do
> not need to be addressed in any specific way.
> 
> To overcome the issues mentioned above, use the observation that it
> is not actually necessary to create any device objects in addition
> to struct acpi_device ones in order to reserve the "system" device
> resources because that can be done directly in the ACPI device
> enumeration code.
> 
> Namely, modify acpi_default_enumeration() to add the given ACPI device
> object to a special "system devices" list if its _HID is either PNP0C01
> or PNP0C02 without creating a platform device for it.  Next, add a new
> special acpi_scan_claim_resources() function that will be run via
> fs_initcall() and will walk that list and reserve resources for each
> device in it along the lines of what the PNP system driver does.
> 
> Having made the above changes, drop PNP0C01 and PNP0C02 from
> acpi_pnp_device_ids[] which will allow platform devices to be created
> for ACPI device objects whose _CID lists contain PNP0C01 or PNP0C02,
> but the _HID is not in acpi_pnp_device_ids[].

...

> +static const char * const acpi_system_dev_ids[] = {
> +	"PNP0C01", /* Memory controller */
> +	"PNP0C02", /* Motherboard resource */
> +	NULL
> +};

...

> +	if (match_string(acpi_system_dev_ids, -1, acpi_device_hid(device)) >= 0) {

Using -1 makes sense when we have no direct visibility of the mentioned array.
Here we have it visible and statically defined, hence the ARRAY_SIZE() is more
appropriate.

> +		struct acpi_scan_system_dev *sd;
> +
> +		/*
> +		 * This is a generic system device, so there is no need to
> +		 * create a platform device for it, but its resources need to be
> +		 * reserved.  However, that needs to be done after all of the
> +		 * other device objects have been processed and PCI has claimed
> +		 * BARs in case there are resource conflicts.
> +		 */
> +		sd = kmalloc(sizeof(*sd), GFP_KERNEL);
> +		if (sd) {
> +			sd->adev = device;
> +			list_add_tail(&sd->node, &acpi_scan_system_dev_list);
> +		}
> +	} else {
> +		/* For a regular device object, create a platform device. */
> +		acpi_create_platform_device(device, NULL);
> +	}
> +	acpi_device_set_enumerated(device);
>  }

...

> +static void acpi_scan_claim_resources(struct acpi_device *adev)
> +{
> +	struct list_head resource_list = LIST_HEAD_INIT(resource_list);
> +	struct resource_entry *rentry;
> +	unsigned int count = 0;
> +	const char *regionid;

> +	if (acpi_dev_get_resources(adev, &resource_list, NULL, NULL) <= 0)
> +		return;

Strictly speaking the acpi_dev_free_resource_list() still needs to be called
on 0 return as it's called only for the error cases.

I think this is the first and the only time I see a combined comparison <= 0
for the acpi_dev_get_resources().

> +	regionid = kstrdup(dev_name(&adev->dev), GFP_KERNEL);
> +	if (!regionid)
> +		goto exit;
> +
> +	list_for_each_entry(rentry, &resource_list, node) {
> +		struct resource *res = rentry->res;
> +		struct resource *r;
> +
> +		/* Skip disabled and invalid resources. */
> +		if ((res->flags & IORESOURCE_DISABLED) || res->end < res->start)
> +			continue;

> +		if (res->flags & IORESOURCE_IO) {

We have resource_type() helper.

And I believe the direct comparison in this case is better.

> +			/*
> +			 * Follow the PNP system driver and on x86 skip I/O
> +			 * resources that start below 0x100 (the "standard PC
> +			 * hardware" boundary).
> +			 */
> +			if (IS_ENABLED(CONFIG_X86) && res->start < 0x100) {
> +				dev_info(&adev->dev, "Skipped %pR\n", res);
> +				continue;
> +			}
> +			r = request_region(res->start, resource_size(res), regionid);
> +		} else if (res->flags & IORESOURCE_MEM) {
> +			r = request_mem_region(res->start, resource_size(res), regionid);
> +		} else {
> +			continue;
> +		}
> +
> +		if (r) {
> +			r->flags &= ~IORESOURCE_BUSY;
> +			dev_info(&adev->dev, "Reserved %pR\n", r);
> +			count++;
> +		} else {
> +			dev_info(&adev->dev, "Could not reserve %pR\n", res);
> +		}
> +	}
> +
> +	if (!count)
> +		kfree(regionid);
> +
> +exit:
> +	acpi_dev_free_resource_list(&resource_list);
> +}

-- 
With Best Regards,
Andy Shevchenko



