Return-Path: <linux-pci+bounces-43780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBCCE5629
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 20:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6532B301226F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF1225485A;
	Sun, 28 Dec 2025 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diCEtYWo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCA239E76;
	Sun, 28 Dec 2025 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766949219; cv=none; b=fbyES3LiGqBbHbsyVCDzuMvKeKAVpkJYY/1D1zoqVN1F8sgZtKrFSQObR13x3flEfpNd4NTo10rmezm3K/JmFwKCQ+3xMvDr+J6xt0DDdYaYf6WSZjMK5R6/RhjC56aH3dSaHiLjL3+mtX0SSxrdST7Mt0OpkhS1AKYThUwb9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766949219; c=relaxed/simple;
	bh=KZV++mJZo2JR7iVN6hyupyVx5WG6zS1ZQXElyakNkmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsoRWDYLy23tJcJOmkvJnR90WzYanzn2lCas90lPiUKpIwKyr5zILTG2WYAx9X+AVUCIopTEsRfWLZUXgPdmipIcdyxKEMawyM2cOzMBltZB9otanq8ylVl3yPhJsXaUjrEMjPdm3AhY3BfIgJZM+OIg3+ORsjSfpqVDfUkdAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diCEtYWo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766949217; x=1798485217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZV++mJZo2JR7iVN6hyupyVx5WG6zS1ZQXElyakNkmM=;
  b=diCEtYWopLfNjIi+omqdNWPyetKdJhTMoKXFGyYCCpLhGGTkxuf/kbVF
   tRfYPBCCKquGZtHbn974BsTTVKvlnq2kxp/pRTyohn0rqyNsQd5XiCjL+
   inqIZ1nBXr35IIaO370YDbK0daUDxupi4BDR87mU/mukQE6xfOIi2Z1q3
   qDNcmcojh1m6hDIG+QMqHIF2NOOP53EI7qINIzlvHXDscr5oGN5peSo94
   EmqaVD6S4ZyNyH48xJzvnJHlqqeA2tofhV0QkuMZ0P94Auv2sDaFaV51h
   DEX6SCBRJyQsNc2a1JuxIlk9MgN1Mk9WrWFR+PUqcwWpTUSZKaLz12CZ2
   Q==;
X-CSE-ConnectionGUID: PhS8xVirSriBbiPZgkMxug==
X-CSE-MsgGUID: 8nE8xq/+REShHCOz4kCmPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="67786812"
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="67786812"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 11:13:37 -0800
X-CSE-ConnectionGUID: ZSsKGQllSAmZYG1UhJC3DQ==
X-CSE-MsgGUID: eRVn7RDJTiabck8zBUuGMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="201226404"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 11:13:34 -0800
Date: Sun, 28 Dec 2025 21:13:31 +0200
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
Subject: Re: [PATCH v1 2/4] platform/x86/intel/hid: Stop creating a platform
 device
Message-ID: <aVGBW4UcRAaxtbCX@smile.fi.intel.com>
References: <7888874.EvYhyI6sBW@rafael.j.wysocki>
 <6115868.MhkbZ0Pkbq@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6115868.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 15, 2025 at 02:35:05PM +0100, Rafael J. Wysocki wrote:
> 
> Now that "system" devices are represented as platform devices, they
> are not claimed by the PNP ACPI scan handler any more and the Intel
> HID platform devices should be created by the ACPI core, so the
> driver does not need to attempt to create a platform device by
> itself.
> 
> Accordingly, make it stop doing so.
> 
> No intentional functional impact.

...

>  	.remove = intel_hid_remove,
>  };

>  

This blank line now can also be removed as the module_platform_driver() coupled
with the above structure initialiser.

> -/*
> - * Unfortunately, some laptops provide a _HID="INT33D5" device with
> - * _CID="PNP0C02".  This causes the pnpacpi scan driver to claim the
> - * ACPI node, so no platform device will be created.  The pnpacpi
> - * driver rejects this device in subsequent processing, so no physical
> - * node is created at all.
> - *
> - * As a workaround until the ACPI core figures out how to handle
> - * this corner case, manually ask the ACPI platform device code to
> - * claim the ACPI node.
> - */
> -static acpi_status __init
> -check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
> -{
> -	const struct acpi_device_id *ids = context;
> -	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
> -
> -	if (dev && acpi_match_device_ids(dev, ids) == 0)
> -		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
> -			dev_info(&dev->dev,
> -				 "intel-hid: created platform device\n");
> -
> -	return AE_OK;
> -}
> -
> -static int __init intel_hid_init(void)
> -{
> -	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> -			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
> -			    (void *)intel_hid_ids, NULL);
> -
> -	return platform_driver_register(&intel_hid_pl_driver);
> -}
> -module_init(intel_hid_init);
> -
> -static void __exit intel_hid_exit(void)
> -{
> -	platform_driver_unregister(&intel_hid_pl_driver);
> -}
> -module_exit(intel_hid_exit);
> +module_platform_driver(intel_hid_pl_driver);

-- 
With Best Regards,
Andy Shevchenko



