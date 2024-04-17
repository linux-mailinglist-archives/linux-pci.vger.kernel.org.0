Return-Path: <linux-pci+bounces-6347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D38A7E9C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45509282153
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A815127E15;
	Wed, 17 Apr 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtnHhhYt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91AA5D8F6;
	Wed, 17 Apr 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343641; cv=none; b=lCa2bPg97ePSksnKr7K4EJLTiAbe2Qrr8gcTv+kOisu4L0lh7B4/CcFOhydDl4JovWUJX7NxFrqxU0Au/DtvsrZsqlszQpajaEhrmEyPjEWsAv+VB4nSGlfp+AohSLfOCTRy+9Q7pU3prLrsh1PNjDJ0hWcN7bajLTOzT6vTc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343641; c=relaxed/simple;
	bh=A5ttHuzOe/HMJsBE4szfcXeW6bosf6khB8tSfgYBqUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCrjCR1rI3bPsZwAZuiZWIzgVaGDfYzt817bJS8TIy0Ki2+7RmqpWkfPbzFh2yKB3Wo3evkdNXyC+9+9Av1Xrhsz1lATFc9PxKTB7be/F5yEDo+yDdozC+k+FEUXNZERX2kWHm1XpioaBk+AylMkQEuG8RyNzxS2tlxRyNxX0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtnHhhYt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713343640; x=1744879640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A5ttHuzOe/HMJsBE4szfcXeW6bosf6khB8tSfgYBqUc=;
  b=XtnHhhYtYNbnP7TDIdHKTkZdYpuXA2B0tErxWuqfF6ZViWO7zx1WWEDS
   qHJ/Q+m2MIvGl/6WPgLn6J5wY/eikuzIf+UjNwvHbAe1EYY1tZ9lS3C6m
   TtaU65wpTUw3yb8lDjzqcDsH8y/lI2gfnDBD9oMGEa1QHX5A4M0PRBbOo
   fvzQroLFpklxsWoKBJOwVEJJUkjp82DXhduLCr11hcRsizOf24ppfF8dl
   45m5+HSJmNiwgRY0owlibrp5MJnd/mcVqlpEReEdl76jWPosECzIG3AKL
   pXhrZbp2f3ZXDe4C/O3gxC1MP9ceEun/DNmdKHwf6FT9JWwKPNC0hczWi
   g==;
X-CSE-ConnectionGUID: GgfWlV72TgaNmKPrmYb2PQ==
X-CSE-MsgGUID: J+FIwNUXRNSK5xK63VJ8tA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="11766169"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="11766169"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:47:19 -0700
X-CSE-ConnectionGUID: 1linExoaQLywdjNzzQ9S8g==
X-CSE-MsgGUID: NQUFbEeBTP+ECIGwdkj68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22627863"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:47:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rx0wl-00000004y2U-0XuF;
	Wed, 17 Apr 2024 11:47:15 +0300
Date: Wed, 17 Apr 2024 11:47:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v3 52/74] x86/cpu/vfm: Update drivers/pci/pci-mid.c
Message-ID: <Zh-Mks49D2az47xT@smile.fi.intel.com>
References: <20240416212219.9643-1-tony.luck@intel.com>
 <20240416213813.GA171111@bhelgaas>
 <SJ1PR11MB608361540C2BE3D9A68FB7C2FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608361540C2BE3D9A68FB7C2FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 09:51:43PM +0000, Luck, Tony wrote:

...

> > I guess "vfm" is
> > some kind of a hint, but I don't know what it means.  I suppose it is
> > for "vendor, family, model".
> 
> Yes. vfm is indeed vendor-family-model.  Agreed the commit comment
> is lacking details without the context of the cover letter and the other
> patches in this series.

You see, TLAs are cryptic, that's why I internally proposed different naming.

-- 
With Best Regards,
Andy Shevchenko



