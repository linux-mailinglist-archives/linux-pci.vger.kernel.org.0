Return-Path: <linux-pci+bounces-5979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCAE89E50E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 23:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA95B21A6F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3F1586C0;
	Tue,  9 Apr 2024 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpqz+hQL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0261EA8F;
	Tue,  9 Apr 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698757; cv=none; b=T8kcXdB+2pGz21ZxTwWoMk66JkWhoPXe7ETaULG1OaZ4SModkEi9kTd8C1c37cQRcF3PE65+H+sTmYZw/E56tn5/UgCE3ZcDvwFx+6oXSAGt5T4LjH4uGjACz9tSOnEuA1XvdaCf2EGozUrzi3l6s07VS+tJrfciYyWGjsXD0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698757; c=relaxed/simple;
	bh=Ek6fAFjtCRWfLKN/l/0m1CXP0kECokP53EKTsBPsHVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4SV/V5VSygGEX/DaqDT3T5rhiF8pffLBHH/600qv/zDlH83yUQirnHonEXFWvI16r5GnlAVy6r2hHFDwhhNrMS9bkjmU6QCXJW9kVgLFRlr9HTZCp2Zcohk4iX0d5f+greDTVLbh/MFY6xi/KY5uccA1pfqytHjgIA9ChUzX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpqz+hQL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712698756; x=1744234756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ek6fAFjtCRWfLKN/l/0m1CXP0kECokP53EKTsBPsHVM=;
  b=bpqz+hQLbCe/p1bNkCCkIkvOQtJNgDKvXYx7VqJK1p2tYQ2FxV5CO9Ph
   rY6cTHHcP4gqIu18kO5GHLgkE+ZR2FIYV/hmO28rnqS3Y7ooW/GOrrWXh
   lqbSdIGnwr8KAvrTQ9LemwS1gqSkj7NM8ABVFRbzoKpQ+4dr/Av6BVu1i
   Qzs+ZJuMEq7kiUdLzLS7pdSSv3HTWZytcj6hwPBrvieSXupju0koXmb9c
   5msyD1VCGMV4cn8MEFhubrH8IgQ9lp+C+JQnHiBx9nzqJgw8soqLmWy/l
   12T9Yg2xpKyLK+/DgW+jJNvAeyssV0K5NK2l2dvyQnWzOdPFxNUXpr4hx
   g==;
X-CSE-ConnectionGUID: NbNgQqyGTUuO3/Hz6fkERA==
X-CSE-MsgGUID: P1b8ZaviTrayR9Kee73EWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8611346"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8611346"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:39:15 -0700
X-CSE-ConnectionGUID: jMSnl/xGSrqdfemSKx+iVA==
X-CSE-MsgGUID: Ahjw75y/Qg+qqyaehaai5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20825395"
Received: from osezer-mobl.amr.corp.intel.com (HELO [10.209.70.70]) ([10.209.70.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:39:15 -0700
Message-ID: <da8ca6a2-860f-44a5-bb47-b5967f40be90@linux.intel.com>
Date: Tue, 9 Apr 2024 14:39:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] PCI: Add check for CXL Secondary Bus Reset
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com, lukas@wunner.de
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-3-dave.jiang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240409160256.94184-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/9/24 9:01 AM, Dave Jiang wrote:
> Per CXL spec r3.1 8.1.5.2, Secondary Bus Reset (SBR) is masked unless the
> "Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
> path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
> the CXL Port Control Extensions register by returning -ENOTTY.
>
> When the "Unmask SBR" bit is set to 0 (default), the bus_reset would
> appear to have executed successfully. However the operation is actually
> masked. The intention is to inform the user that SBR for the CXL device
> is masked and will not go through.
>
> If the "Unmask SBR" bit is set to 1, then the bus reset will execute
> successfully.
>
> Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - cxl_port_dvsec() should return u16. (Lukas)
> ---
>  drivers/pci/pci.c             | 45 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |  5 ++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..570b00fe10f7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +static u16 cxl_port_dvsec(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					 PCI_DVSEC_CXL_PORT);
> +}

Since cxl_sbr_masked() is the only user of this function, why not directly
check for this capability there.

> +
> +static bool cxl_sbr_masked(struct pci_dev *dev)
> +{
> +	u16 dvsec, reg;
> +	int rc;
> +
> +	/*
> +	 * No DVSEC found, either is not a CXL port, or not connected in which
> +	 * case mask state is a nop (CXL r3.1 sec 9.12.3 "Enumerating CXL RPs
> +	 * and DSPs"
> +	 */
> +	dvsec = cxl_port_dvsec(dev);
> +	if (!dvsec)
> +		return false;
> +
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	if (rc || PCI_POSSIBLE_ERROR(reg))
> +		return false;
> +
> +	/*
> +	 * CXL spec r3.1 8.1.5.2
> +	 * When 0, SBR bit in Bridge Control register of this Port has no effect.
> +	 * When 1, the Port shall generate hot reset when SBR bit in Bridge
> +	 * Control gets set to 1.
> +	 */
> +	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
> +	struct pci_dev *bridge = pci_upstream_bridge(dev);
>  	int rc;
>  
> +	/* If it's a CXL port and the SBR control is masked, fail the SBR */
> +	if (bridge && cxl_sbr_masked(bridge)) {
> +		if (probe)
> +			return 0;

Why return success during the probe?

> +
> +		return -ENOTTY;
> +	}
> +
>  	rc = pci_dev_reset_slot_function(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a39193213ff2..d61fa43662e3 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1148,4 +1148,9 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> +/* Compute Express Link (CXL) */
> +#define PCI_DVSEC_CXL_PORT				3
> +#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> +#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +
>  #endif /* LINUX_PCI_REGS_H */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


