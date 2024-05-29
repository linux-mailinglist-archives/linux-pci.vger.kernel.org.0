Return-Path: <linux-pci+bounces-7950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3E8D292D
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 02:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192651C23737
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 00:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7C2140374;
	Wed, 29 May 2024 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqravWHR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBB13FD92;
	Wed, 29 May 2024 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940805; cv=none; b=e8D+5lUxvFRinvxhfZVbbbCbMq8CPxrvG0azxyhbinHx9hXnIV1+OcZgokohtAwli8MLuBQAmTIpTjxPsle9Ay/yEd0mc+5sBL/YiHQ5Qc7j/iJQFVRuoLTOAm9ZmUL1ClmeYoRpif/ld4JNrNeSmB6syw80ptQrDzOF80RUwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940805; c=relaxed/simple;
	bh=aM+phMkkluGc/O/MwbayhMFcLAIXn4h8FEOvJEC3LAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DudkoUZYOcgDXjIFUBqBJ+cxSFWBSpt7VBwFTUWP8Xo9bJ4pZMWAgB+SNTIILDqNKV5gMnTIpiYFlFrVuX8buCHky/vd0wmjP+VdbRGU6jtAurdkln8AYXeW1KkHwwKI3yXDtwVo7F1I2jXiA9mn8hYQ43WRHYToZLi27YEi2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqravWHR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716940804; x=1748476804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aM+phMkkluGc/O/MwbayhMFcLAIXn4h8FEOvJEC3LAI=;
  b=PqravWHRiNBL/134gU3UrYzmcERWY/x79armXGvf11nT3mBXxZaJo9Lv
   exvPP+5C36xkooBrYVGovWpQNhaxwQY/36Zo1A3dF74boAxTDkeFLWKwW
   P/XxfmitryseVSyuJe4x/zW4nfqtN3oiJOcOChyU8WFJcrFtw7OrMM5EM
   FC+oEPY+LiODL/3+6yVwoUo0oxWz8jYPcrCvgbtpA3l297cWjkF60+cdG
   nrITQ3JA8Z+Y8B5mnkf9SBOrv04mP/TyIL3uoqHYkRfupdaWvbyEeraku
   +l7y32bT+YaV3Fur3JwESJzmTfgW9SbqcUEZhLYkGJr8f2kIQQprCl8w3
   Q==;
X-CSE-ConnectionGUID: rHYFi5juSn2AJtNPrcpksA==
X-CSE-MsgGUID: 9lLnACUrS2Sf6PKe/J6N9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13139003"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13139003"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 17:00:04 -0700
X-CSE-ConnectionGUID: YnTbqMd0TIaFwuGkUzwptQ==
X-CSE-MsgGUID: 7tOAxpo+TBq5k2P+HKHGhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="35261842"
Received: from gtryonx-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.99.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 17:00:03 -0700
Date: Tue, 28 May 2024 17:00:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: bhelgaas@google.com, Jani Saarinen <jani.saarinen@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Make PCI cfg_access_lock lockdep key a singleton
Message-ID: <ZlZwATgdPtw1tr6G@aschofie-mobl2>
References: <171693842964.1298616.14265420982007939967.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171693842964.1298616.14265420982007939967.stgit@dwillia2-xfh.jf.intel.com>

On Tue, May 28, 2024 at 04:22:59PM -0700, Dan Williams wrote:
> The new lockdep annotation for cfg_access_lock naively registered a new
> key per device. This is overkill and leads to warnings on hash
> collisions at dynamic registration time:
> 
>  WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:1226 lockdep_register_key+0xb0/0x240
>  RIP: 0010:lockdep_register_key+0xb0/0x240
>  [..]
>  Call Trace:
>   <TASK>
>   ? __warn+0x8c/0x190
>   ? lockdep_register_key+0xb0/0x240
>   ? report_bug+0x1f8/0x200
>   ? handle_bug+0x3c/0x70
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? lockdep_register_key+0xb0/0x240
>   pci_device_add+0x14b/0x560
>   ? pci_setup_device+0x42e/0x6a0
>   pci_scan_single_device+0xa7/0xd0
>   p2sb_scan_and_cache_devfn+0xc/0x90
>   p2sb_fs_init+0x15f/0x170
> 
> Switch to a shared static key for all instances.
> 
> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> Reported-by: Jani Saarinen <jani.saarinen@intel.com>
> Closes: https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_14834/bat-apl-1/boot0.txt
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 

