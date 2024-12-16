Return-Path: <linux-pci+bounces-18513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A508F9F3529
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A66C16310C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81C11D696;
	Mon, 16 Dec 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUZH13Nm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083217591;
	Mon, 16 Dec 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364894; cv=none; b=gOPcGZt4lQ8eBe5zw7mwSLzgUWqtBKN+eosLtNCQRmR8AFfftAk4UVcn4t2XSZ51he+8H2Qi3LdWtsMZhf4E+9f6v8r8mw5YgUysz+BrwRf0hTM1OCANxLzIpYSkNCQTKGSiU86GFCBSuMbrOZy1n8goze40gDldZz3TQTVjsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364894; c=relaxed/simple;
	bh=lEX9N+/EdEZGwnBqSmWoKk8wnmnP4cylfr/1FvUxUxw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d4sI5QRV6OI1ZGPwaiotTGfXQ2zVDe2ZoCZmmRAC6FpehMjnoYxSuDnApTkttn/ytpkg5L58tfx46JywJC/t+4k2caCo2PS4E3ttGiV0wYQbEb16fWBDDVB/CqiWvNEaCV5uqQVzbJ7tUexC8GukvFQZKjqP+IBG1VYo+q8xMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUZH13Nm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734364893; x=1765900893;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lEX9N+/EdEZGwnBqSmWoKk8wnmnP4cylfr/1FvUxUxw=;
  b=UUZH13NmTZiS3N57XcPWog0KAUN201uBcLx0jNhstuBKj54gze/WE/k6
   SIwuKZ0KSMCLCR0Unca6HYuFJXda/ZmS5lG3tISRwdscgwexQSL95DBd3
   uBtqnJd/KbehPNFghKay1HUTdV1vrPRSvvtUmvuk2pLacwCsYOm7W05KT
   HWUweuXKs9WgpcSqV8nQgnD8d0tI6Irg2V2m+okP0iAZPwUdA1FUbK9JD
   bfpOxzqwyYpo6mgpYyaaUZTOkg/uhvh6WPuAc2xNyCHBnIKoZSPCFynSN
   6e/yinpPXq4X8rpvNXV/DsOv2sZY8OLBbjGVPITVynwAVnbCyuj6ZMoIx
   g==;
X-CSE-ConnectionGUID: QKVLmNuBQH2SKtor/QDlaw==
X-CSE-MsgGUID: 88j7ErqDQWCCRfBZUsdfJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38530718"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="38530718"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:01:32 -0800
X-CSE-ConnectionGUID: uLkk7swzS6GLSPySWw/2SQ==
X-CSE-MsgGUID: D/ks+nPYQiGn83aWcOEg/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97468225"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:01:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Dec 2024 18:01:27 +0200 (EET)
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI : Fix pcie_flag_reg in set_pcie_port_type
In-Reply-To: <20241213070241.3334854-1-gthiagarajan@marvell.com>
Message-ID: <5047c4a8-dfce-a081-e4fa-c6da731eb01d@linux.intel.com>
References: <20241213070241.3334854-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 13 Dec 2024, Gowthami Thiagarajan wrote:

> When an invalid PCIe topology is detected, the set_pcie_port_type function 
> does not set the port type correctly. This issue can occur in 
> configurations such as:
> 
> 	Root Port ---> Downstream Port ---> Root Port
> 
> In such cases, the topology is identified as invalid and due to the incorrect 
> port type setting, the extended configuration space of the child device becomes 
> inaccessible.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
> v1->v2:
> 	Updated commit description
> 
>  drivers/pci/probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..263ec21451d9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1596,7 +1596,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		if (pcie_downstream_port(parent)) {
>  			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
>  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM << 4;

Use FIELD_PREP() please.

-- 
 i.

>  		}
>  	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
>  		/*
> @@ -1607,7 +1607,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
>  			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
>  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM << 4;
>  		}
>  	}
>  }
> 


