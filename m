Return-Path: <linux-pci+bounces-43781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7147CE5638
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 20:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F543018944
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C32571A0;
	Sun, 28 Dec 2025 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8OFqJqq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2FB2475CE;
	Sun, 28 Dec 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766949249; cv=none; b=f53hTLu90sBAF5/EuCR+9yCyGlR20ao0if7LJJUWtKMTbY0YzQ0r433Z6yDHzhA5XMEOnp+xZlo3t8UgeUxTjbNn0+gO+ZLP1JIEmru+BILZdG8oDuOeTyU5g98f3i8f9+aWVEqMP/ipfGIuTGnyKBmz5WPix8zkuAKjS8ivxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766949249; c=relaxed/simple;
	bh=HzMwpb56qSvnqkpHGC/UD2h1wKNMQR/JCeNGnS6Irg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOQUKaaMV89XjOzgmUqPFIlW5+GSnVVS34ERh3VGFL/C/qb1fTAQI7SMfQGPRCJg51/Q1l+/cMJ1lzoBWracyg6+cLSfhPlXILw9ALPnxcBF1WjeAugwiyfbR7o0qvWsjBoRKG6Jq+BPhKwqo0U/G3RaAyGMu6fmKIpgAA6a6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8OFqJqq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766949248; x=1798485248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HzMwpb56qSvnqkpHGC/UD2h1wKNMQR/JCeNGnS6Irg8=;
  b=K8OFqJqquvwJw+e+vJmhpe80hA/U3DtheOaYRB64xou9gaXWXo/0R79/
   DTh3FFNEQkJAKPfFKJjExCRM6kQXZXw7wbXoARpZh0I3JGgA76039ZHT1
   DprLutwMag3Mm4W2BC+lATM7Zil1Tab0/c5aE5cLgA2+2kifz0RK2sFME
   6l805cXMXRCoxU4F7PYYwBEGEQEbpsVfFOtkzlrK8222QFoLk6XslO2H9
   i+ztnVJKVmlBRR1iMBih4/T5z4yLwR9YnMeuEsqG2YM8AaI5LgEATSebk
   fzzfani3CuSSYytuuhoP8mjuVmtriI0ctrdWqtaJL2cQes5o4jzE7j9WI
   w==;
X-CSE-ConnectionGUID: qTzGsfdkTxyvphqEeipMJQ==
X-CSE-MsgGUID: HXhH1T4iSkCIPOLjckOzaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="67786826"
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="67786826"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 11:14:05 -0800
X-CSE-ConnectionGUID: d7g1EE3DRKyOZ7YDJoRttQ==
X-CSE-MsgGUID: trLKylj4QlybDA7F+8oCdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="201226452"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 11:14:03 -0800
Date: Sun, 28 Dec 2025 21:14:00 +0200
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
Subject: Re: [PATCH v1 3/4] platform/x86/intel/vbtn: Stop creating a platform
 device
Message-ID: <aVGBeBT3TKxgn_lu@smile.fi.intel.com>
References: <7888874.EvYhyI6sBW@rafael.j.wysocki>
 <8661724.NyiUUSuA9g@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8661724.NyiUUSuA9g@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 15, 2025 at 02:35:44PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Now that "system" devices are represented as platform devices, they
> are not claimed by the PNP ACPI scan handler any more and the Intel
> virtual button array platform devices should be created by the ACPI
> core, so the driver does not need to attempt to create a platform
> device by itself.
> 
> Accordingly, make it stop doing so.
> 
> No intentional functional impact.

...

>  	.remove = intel_vbtn_remove,
>  };
>  

Same comment about this blank line.

-- 
With Best Regards,
Andy Shevchenko



