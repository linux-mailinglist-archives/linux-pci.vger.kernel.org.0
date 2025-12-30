Return-Path: <linux-pci+bounces-43840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A215FCE988C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 12:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E841301D642
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F8E2DCBF8;
	Tue, 30 Dec 2025 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbEL0XGr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312C28135D;
	Tue, 30 Dec 2025 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767094118; cv=none; b=azX1ApyBqDZUxlxzQBT2qQQKzQmE1mK8r7S+CypbyljlsOcVQwvFBZf+HYy/n3T/cD1YbnaeGCJed6GyNwCvGCJkEEn7teSpatifGfsXeSHyxSsf59vubIzACy5x0Nqw4EEyPWlBcu/GvZ6HRi4kYaD0cm2ph5yoDY3ycK54m6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767094118; c=relaxed/simple;
	bh=K7lLyfcUHXbaLJYCSwQJizOkuqiu/G8kSEq3MzHqlb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ujb/IPivHURQAy8M48UleXfRsAamRLs15EJ+LcwtRHpBa0MzJRSxOS60wsxnVDFO1u6wlvR4+G1GnjfIeVQF84jpGN5GkwBrfiNP0b+8jcaQLjIzm5dg7A9mndXjUvA3LAPf7vdVNNifiR1hY/fdlzfGLhAEcJ2H7Tt0H9FGynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbEL0XGr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767094116; x=1798630116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K7lLyfcUHXbaLJYCSwQJizOkuqiu/G8kSEq3MzHqlb0=;
  b=AbEL0XGruGIzVtRB2DPeCQBbMKOQu4kNq4GTDojdy6DZsn6dNpKEIQrl
   q+F3+4AUfna9GQtuqIpGYYrL1ly3D9Hz4ASdA7RUoqNR69K8JTdyPuPwD
   JtYjEijMcnWLC0s6ClHiKbNKw9d+QUw7JkU3frsGIvWITR2+V4/kBFD8q
   zbrGCGuSXeRSmm3vIHs69jC3bV4/Fmpbfdh7WaOrsfBGseKAZm4tykV79
   +KVHW8GcTgmaQYzq1yZrDLQgsRC4wlvFELGGDjZegwswbASzkIIMWDYOz
   S99d87guI5YqFjec57VVRI3NJobrioT4wqwu2USKd6wik3NeRBKLFP4ih
   w==;
X-CSE-ConnectionGUID: tHNyTwc+TJub8hEmzVS/0g==
X-CSE-MsgGUID: S39f1f7MQ8y1/uLcwDSPqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="94150505"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="94150505"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 03:28:35 -0800
X-CSE-ConnectionGUID: OrDRp9gQTr2RavtAMJnd2g==
X-CSE-MsgGUID: 9J60oO6jSk+UuU79+l75Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="206076938"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.103])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 03:28:32 -0800
Date: Tue, 30 Dec 2025 13:28:30 +0200
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
Subject: Re: [PATCH v1] ACPI: scan: Use resource_type() for resource type
 checking
Message-ID: <aVO3Xsl4MbBHrkEV@smile.fi.intel.com>
References: <12814730.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12814730.O9o76ZdvQC@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 30, 2025 at 10:57:34AM +0100, Rafael J. Wysocki wrote:

> To follow a well-established existing pattern, use resource_type() for
> resource type checking in acpi_scan_claim_resources().
> 
> No intentional functional impact.

Thanks for this!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko



