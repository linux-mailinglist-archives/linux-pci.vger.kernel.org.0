Return-Path: <linux-pci+bounces-28080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F81ABD399
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7261A3A365A
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E44B259C92;
	Tue, 20 May 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEwbOQc2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84073647;
	Tue, 20 May 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733989; cv=none; b=Wkc5oxdMiZUpxle3qb17EUvBqXurAbhP9E35b7gBKjusNkgHNGtxWtEE1QhJhmx9hi58TA6tyy4VismW03u2EgbLF3TOMzoWpCv4G/S2aRpa9Yieh3WNHwhqBNEq3ivlFzYotBdAqTvcz9E6CNXalQRRYDsi+qX5mkmB/FogHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733989; c=relaxed/simple;
	bh=u/A3R66/AiZgaNe8EdDX++XVMrmF2Eqz2dGvezybjTw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rOU11xZ3XD5r8MVTgYEmROX7W6iI0/CzcWVHfWW7WC2PSYIwOujRYn2TUIxZYI0hQCDUgJCcgbR7fvZYVPJEcwUHcdE/Dyh58BeGncfLRYnWUgzYnfI+jf+pIinjZ8zHYI/mdy3FMLb6HUDkzuXd52+HMHwGZG35tw7Dq3y8iok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEwbOQc2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747733988; x=1779269988;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=u/A3R66/AiZgaNe8EdDX++XVMrmF2Eqz2dGvezybjTw=;
  b=UEwbOQc2UXn2nlnBm9nc+5cNj9yVMw0GWDEvR7cOWvwhvQohWcxoEjTs
   MY4XnxBEmQQ0KF4NxGcx3HexjhjeZk3s8FRY67A7vjbyd4ISXOFHjedAS
   HZfockvBoUr9/cJd4bjZp/jKEjH3rd9R2DP8PjRJQ6bJB0mOI7+M1y6wy
   JvER5PLdzm8Yx93RqC9APtbvrBzj7WcRLVYPL7lEtjkHO/peUqTYwg0y5
   jSbeZEMYgFjYyTeleBxIbM2vKlJfMmFZHmrO4D845ulaSbN74fG+HIjz5
   1banKFADbY1bmnOn+oQMtyU6Sf/ng/QI1f+v3b0zLwar1/keCAmuL6IX4
   w==;
X-CSE-ConnectionGUID: jM0cxRaxRiChXCqtecQrzA==
X-CSE-MsgGUID: zqQfCi14Ss68O3QDE2wfbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="59888043"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="59888043"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 02:39:31 -0700
X-CSE-ConnectionGUID: JcBi3AQcSYOXwRfGd83kXA==
X-CSE-MsgGUID: xPtR0gzgQ7eMCAxgxUDKMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139671159"
Received: from johunt-mobl9.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 02:39:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 12:39:18 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 01/16] PCI/DPC: Initialize aer_err_info before using
 it
In-Reply-To: <20250519213603.1257897-2-helgaas@kernel.org>
Message-ID: <218ec0eb-93a9-ba14-ea6b-742d0d274b84@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously the struct aer_err_info "info" was allocated on the stack
> without being initialized, so it contained junk except for the fields we
> explicitly set later.
> 
> Initialize "info" at declaration so it starts as all zeroes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/dpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index df42f15c9829..fe7719238456 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -258,7 +258,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>  void dpc_process_error(struct pci_dev *pdev)
>  {
>  	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
> -	struct aer_err_info info;
> +	struct aer_err_info info = { 0 };

= {}; is enough to initialize it, no need to add those zeros.

>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> 

-- 
 i.


