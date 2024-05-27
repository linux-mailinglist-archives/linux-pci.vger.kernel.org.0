Return-Path: <linux-pci+bounces-7860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569B8D0809
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300F82A8EB6
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2538FB9;
	Mon, 27 May 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhN+Upbx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2D26ACC;
	Mon, 27 May 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826449; cv=none; b=i8+iBV1suxEZdjL9FlOFSYfsjU2BWDPNQVMcjGAulA7sFq7svhw1KHweyxrBWZ3243sgZ/HCZT20FmvfVF9WtgZddECDvzMwZATP0ppjDmx3eK3KDgn5iERZgAhUpy9Q+a5Jj7MAmLAGSn3Do/zI9BeCCAxTVj2ZR7wVbwNf2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826449; c=relaxed/simple;
	bh=QPrw8v5oiECiQO1YuKcA45PIH9PAQOCn3cbaoRZpgYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXVU4JNXQx16rzYb01FSAQqrDNCo8VyTo3bcepaz2M0NVjp/oOgym9nSTRaC7fjoJCkrGkYcbPk+0sCyb+19oEOBghGyteewZBVwzyODrTGtIoup1wI9KGkVuCyNXf3NmbMUvziH0IIC425hE39PHjr3pMtLmRRw11scUM9KIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhN+Upbx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826448; x=1748362448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QPrw8v5oiECiQO1YuKcA45PIH9PAQOCn3cbaoRZpgYw=;
  b=UhN+UpbxYrncfoNK54cJykC44mza6SWo9mYuPifdQD3NNCx/3XmT9FoD
   P1GFApQ5xEQgsuduUEaLIcF6Df+DpMdJ5s+flLsqVihHQ1/fPSnHKKJdz
   du/BI3RJ71TiW7hJhNtLWrj1yiFWt1FmZXE4A8sGv09LfEqkED8IF3WSa
   KZ8X8pgOHSRjJt/yR800Pb3ChgSopQpFHClAwLmjJpm4JMciJHqvxszGg
   wmRqBnF1j9RJk+n1spoUsjQxK1jD0RquuGw48yhh4nO5A/3EnM7Upjvkx
   Fc01hVgmd3A6k4vSD2WAvf7sl4nl0Mom3MMwdmo7xCE/2QKGRzkN6Q1XW
   Q==;
X-CSE-ConnectionGUID: tXQbHrgtRSyhSM56EabZOg==
X-CSE-MsgGUID: CCgiFtWDTB+6XpQnc/zcJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16943372"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="16943372"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:14:07 -0700
X-CSE-ConnectionGUID: xoYtQbIjSxKmqmVpcnFMkQ==
X-CSE-MsgGUID: 51xVZ1ebRXux+wD1YnPhFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="39650545"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:14:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sBcz3-0000000BJmk-3UXd;
	Mon, 27 May 2024 19:14:01 +0300
Date: Mon, 27 May 2024 19:14:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/pci/intel_mid_pci: Fix PCIBIOS_* return code
 handling
Message-ID: <ZlSxSVUu4zxYh82g@smile.fi.intel.com>
References: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
 <20240527125538.13620-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527125538.13620-2-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 27, 2024 at 03:55:36PM +0300, Ilpo Järvinen wrote:
> intel_mid_pci_irq_enable() uses pci_read_config_byte() that returns
> PCIBIOS_* codes. The error handling, however, assumes the codes are
> normal errnos because it checks for < 0.
> 
> intel_mid_pci_irq_enable() also returns the PCIBIOS_* code back to the
> caller but the function is used as the (*pcibios_enable_irq) function
> which should return normal errnos.
> 
> Convert the error check to plain non-zero check which works for
> PCIBIOS_* return codes and convert the PCIBIOS_* return code using
> pcibios_err_to_errno() into normal errno before returning it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



