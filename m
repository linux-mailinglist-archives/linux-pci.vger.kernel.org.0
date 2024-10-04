Return-Path: <linux-pci+bounces-13809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8043F99002D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03001C23A3A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A314659B;
	Fri,  4 Oct 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGarFTol"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6313AA26
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035140; cv=none; b=a06ZmhFkvsOwy7BUUaJV7huY9rTZzx0WTY/oaDzLG87VKwm+SPinyIaTOG8PupkBU1CwUuZHUeminHcX3F8ozgANoYXT9KOXVI3bIEe3gyiuLXDMDZBe3QoUiIBG36EWi0zKiNQtVRjV7LM7YYDkfmN1P1Xwrl7FDtajprR0o/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035140; c=relaxed/simple;
	bh=Ya1UyDsj4h3upP/ESGvmgCdC994NCO57syiBn+Tg+ao=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HCYNJ6ppUYQnUwdElNstE6kfGwaflgKnHUJIytS3Ae5CCINSMuUW38fn4xz/CjXXjpRG65A/mCrG0dPc0xXyu9V7iXOl9LxwPevXIkb1KTqSqfsfWNT0gBq5i0uwghj+NWqPM2eQiNy0lOWyxJf0hL0LLHqHE2ahWOwIf5EfjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGarFTol; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728035139; x=1759571139;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ya1UyDsj4h3upP/ESGvmgCdC994NCO57syiBn+Tg+ao=;
  b=JGarFTolmI1WL9gWuUXnKShzdLVocPGb071XAXLzvjP9+8llt5OVNQjD
   oViHgIE/gxLtBKHtcjrZJYGfo6elL2ZyXWjfY5oJWKVPjMFYunokEWu1l
   cOMFFTIx+WPGrEXLmlW7FIaL8olqA2b2aVAwyYzZhQQRRwC39FeOL7I/3
   Z8c1WNMWgCLMwvrNtiFdsyJZcdSdQvFHa5zBdUYO0WHmro2WAYyG5c0+T
   pFM40UZ0shSYwRGxxtBVvgRne4eAMvhHVWUrHTfD1J+V912zeUpEAbHeN
   B792t+9kDJ2FriiZaB85Oq3X/ccKl1KZ0njl5ZFZorBUumytaq9Gn3QaL
   g==;
X-CSE-ConnectionGUID: xI0AVuhXRImJHEDlreWUaw==
X-CSE-MsgGUID: i5nxskOPQy2mUy9LFYqAHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27382684"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27382684"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:45:39 -0700
X-CSE-ConnectionGUID: SsQredsVSiaj+Kfrn5GGrQ==
X-CSE-MsgGUID: SirmTde4S4+qc4zbP0uSpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74976651"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:45:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Oct 2024 12:45:32 +0300 (EEST)
To: Sakari Ailus <sakari.ailus@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Masahiro Yamada <masahiroy@kernel.org>, 
    Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 32/51] PCI/portdrv: Switch to
 __pm_runtime_put_autosuspend()
In-Reply-To: <20241004094134.113895-1-sakari.ailus@linux.intel.com>
Message-ID: <060ec19e-bf73-8195-c32b-a5f123e28e1b@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com> <20241004094134.113895-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Oct 2024, Sakari Ailus wrote:

> pm_runtime_put_autosuspend() will soon be changed to include a call to
> pm_runtime_mark_last_busy(). This patch switches the current users to
> __pm_runtime_put_autosuspend() which will continue to have the
> functionality of old pm_runtime_put_autosuspend().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 6af5e0425872..53f48065cc82 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -711,7 +711,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  		pm_runtime_set_autosuspend_delay(&dev->dev, 100);
>  		pm_runtime_use_autosuspend(&dev->dev);
>  		pm_runtime_mark_last_busy(&dev->dev);
> -		pm_runtime_put_autosuspend(&dev->dev);
> +		__pm_runtime_put_autosuspend(&dev->dev);

Eh?

This call is preceeded by pm_runtime_mark_last_busy() so why all the 
extra churn when you really only want to remove that 
pm_runtime_mark_last_busy() call from above when it gets put inside the 
autosuspend call, no? Is extra last busy marking even dangerous so it 
could removed after the API change?

-- 
 i.


