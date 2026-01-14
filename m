Return-Path: <linux-pci+bounces-44833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65BD20F9C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6585130392AD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90888340DA4;
	Wed, 14 Jan 2026 19:08:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5734106F;
	Wed, 14 Jan 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417711; cv=none; b=szOWMkpGTPqOUKDb86/yU0x7zeVfS92+OV8NA8gTu0HGzgyOlcwyKsJzV5JMy0qt2yp87GNWFrRcG9e4dYclhLJxNyjq7//7RQ7Y/UHEfSaK4rRAN1yP5aHbI6qFoffxDH704AVmmTbkfp40WlFiz92pyuWo6XC4CP/vcuxmgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417711; c=relaxed/simple;
	bh=i9T+F2c86n8TF2pW39NtLzUBdcAwdFABrXLU1mwxTBA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5w/EQHkDUvf0ZFhTnk/r/G1jb04vAsA8LG+ma/fiHFuj2by8ctdXnpSE5N0QVJAmWvOHCjvAzUaGNddmhb5SjTRNtkuORQEjoNqxIXamuRpXE4o5V9TZDGEfiHrNr78rt8Y9rX3ZeG2fXKZnJwIVWUfKOCyGR66sOzUjcis/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drwcK3NhbzHnGh0;
	Thu, 15 Jan 2026 03:08:01 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E3D6640086;
	Thu, 15 Jan 2026 03:08:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 19:08:20 +0000
Date: Wed, 14 Jan 2026 19:08:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Message-ID: <20260114190818.00004112@huawei.com>
In-Reply-To: <20260114182055.46029-11-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-11-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:31 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER driver includes significant logic for handling CXL protocol errors.
> The AER driver will be updated in the future to separate the AER and CXL
> logic.
> 
> Rename the is_internal_error() function to is_aer_internal_error() as it
> gives a more precise indication of the purpose. Make is_aer_internal_error()
> non-static to allow for other PCI drivers to access.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Hi Terry,

I don't see it as sensible to have is_aer_internal_error()
return false if CXL is not built. That question has nothing to
do with CXL.  Hence if we are doing generic naming, I think we
should just always have the function available.  Gating on CXL
belongs at whatever called it.  Which is the case already for
cxl_rch_handle_error() which has a stub that doesn't call this for
when CXL stuff isn't built.

Should just be a case of moving out of if the ifdef in aer.c
as part of this patch.

Jonathan

> 
> ---
> 
> Changes in v13->v14:
> - New patch
> ---
>  drivers/pci/pcie/aer.c     | 4 ++--
>  drivers/pci/pcie/portdrv.h | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 63658e691aa2..2527e8370186 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1166,7 +1166,7 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
>  	return true;
>  }
>  
> -static bool is_internal_error(struct aer_err_info *info)
> +bool is_aer_internal_error(struct aer_err_info *info)
>  {
>  	if (info->severity == AER_CORRECTABLE)
>  		return info->status & PCI_ERR_COR_INTERNAL;
> @@ -1211,7 +1211,7 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  	 * device driver.
>  	 */
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_internal_error(info))
> +	    is_aer_internal_error(info))
>  		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>  }
>  
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index bd29d1cc7b8b..e7a0a2cffea9 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -123,4 +123,13 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>  #endif /* !CONFIG_PCIE_PME */
>  
>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
> +
> +struct aer_err_info;
> +
> +#ifdef CONFIG_PCIEAER_CXL
> +bool is_aer_internal_error(struct aer_err_info *info);
> +#else
> +static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }

This seems odd.  It's either an AER internal error or it isn't, whether
or not CXL is enabled. That stubbing out should I think go up to the
caller that can decide whether it cares or not.

> +#endif /* CONFIG_PCIEAER_CXL */
> +
>  #endif /* _PORTDRV_H_ */


