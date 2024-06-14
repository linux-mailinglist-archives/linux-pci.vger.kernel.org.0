Return-Path: <linux-pci+bounces-8839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCF908DE5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BD71C228E7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318AFC132;
	Fri, 14 Jun 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDU4D1ca"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D64C96;
	Fri, 14 Jun 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376880; cv=none; b=ovj+TT/xbKt9EJFdmgAmXQK4EbSlf1XzK+eMsEmLYo663sNbNaiCsgjAriUzxgG7m/RWIHP7vQ3whZS6hiPORqpF6/Z9cMr5slqrtTE850tSelR6+DxrBPC2ggZsgWVAP4SrVIodv7F5Wprju+kiGAp0AjRL1Hmsq8TVsixGvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376880; c=relaxed/simple;
	bh=OzFYerauOBqolouxgkZVxe0lW7TOcqR6/DYM51DUUMo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AzQfkfWaX2ahNHp6im6qnGuFe+Av1KzQY5eM0CDe1/akiK68RUUXPyefivBP2Q/RdSYaXoJcNe97UceDkFe/1CP81Q8mViUJ3zzdyCagCxeGevbfC5/anrIjlsBF8mxGbnGgRQcG2oeDD05lzMPnsFfAqiCzK+WQPlMd2PMq1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDU4D1ca; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718376879; x=1749912879;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OzFYerauOBqolouxgkZVxe0lW7TOcqR6/DYM51DUUMo=;
  b=eDU4D1caGHUBMAtXm+zvBgM1Vq7PPFTR3SFgHDDrBnVjpcRBQoKIGrEJ
   EeN6QzwLWc/nFf+0I6G8CyTu2HdAVBYe/nQDJdNfPEadVWy+ttXH31wuJ
   sDGT7rB5HXqcz97RtfOwCK8z5yZ0D2A0iPVc0MRKQzwS6HUHlRHfdQUxS
   PXi+c2ASyNzSpAAHEu4oOk7MCCEkF7asJUmDw4uwNaJDn5xEwphDdWsay
   IH+AsakVfo0zMW4Mz/fpK4xpgqy1pKj4goKXshBHMYH7QArGuEoBby/sb
   QJf3OjmY1fZpD1CKvEaG+5+91jrjd34PIEhq4sd7nVidpBVxL+hkb78Qi
   g==;
X-CSE-ConnectionGUID: VIBWGouGRuKMyKNfwSIgtg==
X-CSE-MsgGUID: xS3bVmX9TWWH4m8FuMSe2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="14997210"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="14997210"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:54:38 -0700
X-CSE-ConnectionGUID: +PcahY8mTLKwdfa1YAsVXw==
X-CSE-MsgGUID: Wz+fHa1oRq2VAKHfFneYkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="78002414"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:54:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 17:54:30 +0300 (EEST)
To: Li zeming <zeming@nfschina.com>
cc: jgross@suse.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
    xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: =?ISO-8859-7?Q?Re=3A_=5BPATCH=5D_x86=3A_pci=3A_xen=3A_Remove_?=
 =?ISO-8859-7?Q?unnecessary_=A10=A2_values_from_ret?=
In-Reply-To: <20240612092406.39007-1-zeming@nfschina.com>
Message-ID: <b1c91d7e-9701-c93c-d336-3729be33f67e@linux.intel.com>
References: <20240612092406.39007-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Jun 2024, Li zeming wrote:

> ret is assigned first, so it does not need to initialize the assignment.

While the patch seems fine, this description and the shortlog are
confusing.

-- 
 i.

> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  arch/x86/pci/xen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 652cd53e77f6..67cb9dc9b2e7 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -267,7 +267,7 @@ static bool __read_mostly pci_seg_supported = true;
>  
>  static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
> -	int ret = 0;
> +	int ret;
>  	struct msi_desc *msidesc;
>  
>  	msi_for_each_desc(msidesc, &dev->dev, MSI_DESC_NOTASSOCIATED) {
> @@ -353,7 +353,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  
>  bool xen_initdom_restore_msi(struct pci_dev *dev)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	if (!xen_initial_domain())
>  		return true;
> 


