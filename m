Return-Path: <linux-pci+bounces-38178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF7BDD743
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BFF94E3B80
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC130649F;
	Wed, 15 Oct 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxiAAhcy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F922A4DA;
	Wed, 15 Oct 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517562; cv=none; b=kUXsH+Q8C6vlDWyKZGAJuEUoBL0de05JCuKafnbItHE77a+9ftJjRkDYjOizyOGk0Xqqxg4Uc8t5jhtnEDLjLL6Q9NJwzdXHTMeH9IBeA79QPJmz6GwI5R5PvSMfCiBw3sHg++zufWjFd934qJGrkpdWpB0jEB0g0XjfZMF9j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517562; c=relaxed/simple;
	bh=4J3LNLN7r+YJT0cz094SwztV9zdCRdVmFZ6/oEC3bjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOd2VIjFgkyUclJz9OlhDgip7qCpVZaF0gvtDMR5/B55zgydrIxZSkaGbRJwdCA5xvgipv5hq2g9rqtVvSiYNahoRDXWeQg+/bYyqjlh0maOTdZILJpxKI9zvBvhgm+FkJbVr2rIjh+cym8jzyD8OmvP+gYBjdw2z0Md8+RoPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxiAAhcy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760517561; x=1792053561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4J3LNLN7r+YJT0cz094SwztV9zdCRdVmFZ6/oEC3bjE=;
  b=nxiAAhcycll3bIf3/UFJQyMEW7L1mrt35XCHzsvH6B9RnoIe0hCu0tu1
   RDokqEzWMJ3Fs29hvVoB/YOdrTaL0q5Lc/xdMrBJSey1LsblD4PHENsyn
   FN7JMw1Ei8XQ+F+z7/o0KNdjA2A9AtGNA7rde9uCz6/9CO02GKre/+bal
   u6wU4mMW56Y/W3CicaPTHpAH0qFWoM22E6EcHITYF78gM0qDSMRIdFdy8
   8JAR2u2jHoGXrji/N4jqrZAlub8MVwbDdeaWPLPD0/PVS0ZRkc9hrNVcv
   8uFrEK5eGX/qrC5DQA6toZuQDDnzZ7ox0oKr0fFOzQAC4ryTZWe2IEJus
   g==;
X-CSE-ConnectionGUID: 7pY7x7J3R/OLewY2/h5+JQ==
X-CSE-MsgGUID: BQoCth3gRKeaxKm3hSNCWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62597162"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62597162"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:39:20 -0700
X-CSE-ConnectionGUID: 4WloK+3WTNClHtruns9I6w==
X-CSE-MsgGUID: N5/8nY5hR/aG4FPUZJKBiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182100449"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:39:17 -0700
Date: Wed, 15 Oct 2025 10:39:14 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com, varun.gupta@intel.com,
	ville.syrjala@linux.intel.com, uma.shankar@intel.com,
	karthik.poosa@intel.com
Subject: Re: [PATCH v5 08/12] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Message-ID: <aO9dsvZ-SmGlEh4T@black.igk.intel.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
 <20251015080710.1468409-9-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015080710.1468409-9-badal.nilawar@intel.com>

On Wed, Oct 15, 2025 at 01:37:06PM +0530, Badal Nilawar wrote:
> From: Anshuman Gupta <anshuman.gupta@intel.com>
> 
> Add xe_d3_state enum to add support for VRAM Self Refresh
> d3cold state.
> 
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>

...

> @@ -787,7 +787,8 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>  			goto out;
>  	}
>  
> -	xe_i2c_pm_resume(xe, xe->d3cold.allowed);
> +	if (xe->d3cold.target_state != XE_D3HOT)
> +		xe_i2c_pm_resume(xe, true);

Does this require an if condition?

Raag

