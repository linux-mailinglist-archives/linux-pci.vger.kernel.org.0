Return-Path: <linux-pci+bounces-35063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173AB3AC7A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 23:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C798686465
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2881FBE9B;
	Thu, 28 Aug 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLN3y/+7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61844285CB3;
	Thu, 28 Aug 2025 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415238; cv=none; b=XhwbRwrdz8SE1FPb9ASbPjTiw/t3kDpFBttr58yp2Xn7ICkCN5ckfQ1HtOym3aS0SDRWzIOmr5IQ+zxGTaXo+VWXa/o5I/HrxFXoF/G4/ftiy0JljY002lrpnF6EVVCrvVP8xSeiUxjJ7u1AmrEyUFNZAWT82iykNUwaPoWjfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415238; c=relaxed/simple;
	bh=rESWN19FhIWKL3SE8GBUFzJY9/cMBsU1+x5sHbRgwA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jx4Bv23Ozvg6pfuW+VjPu+tbmWVJKX3lsEeJqXwNDCeUtplK0H+EPJxC/49sqTvmWQWOyYuA8hPM9sUvx0IjlWsMhpVG799fScy0are26xG1bh9rpUB4qn0Pf6r41nx3GnMpS0QUfo9Kx667OLxSitxiU3vFWdZ0THN5DXcJkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLN3y/+7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756415236; x=1787951236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rESWN19FhIWKL3SE8GBUFzJY9/cMBsU1+x5sHbRgwA4=;
  b=CLN3y/+7VfFx/O10LAuCNoAhHBrRKOcOJv3G0kU58cuantsxCodI1IGV
   1lddVZL25rYNRQWVI/SDew2J2DaR2gAmgaHuMv5hLMEQI59SoW2/7N7Hf
   nx5JDTPq/p2qe43VtmBX/t/M2BHHh9hlwP174/5jjPKZcQLGoX2CKWJIc
   Cg47PmE8KJkCg+oBimlboC09sW1vk5ia3u+goZO4FDJbdlJScxdTcLkQA
   mL3c2+muu0hlBiC2W8mD4GMRXEuPAAHRERnKuPzKg1Ap2iQlYE7cR+OrC
   xiIekYntIOWoF2cUUA5WAsL5hH6JE2+iAWrLvqvzWldG/bookd5dmrAXG
   A==;
X-CSE-ConnectionGUID: b6nGGIv0SyWvDVLGsDPodg==
X-CSE-MsgGUID: 7tTQ9zBCSe+tCMRjiHdEcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58551578"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58551578"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:07:16 -0700
X-CSE-ConnectionGUID: lxzcq2KYQeaCNCISMsJpUg==
X-CSE-MsgGUID: ueyiINJ4SiKTciypDD4JqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170382846"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.49]) ([10.247.118.49])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:07:06 -0700
Message-ID: <91a11ced-88be-4ecd-b3c3-04e1e85f1860@intel.com>
Date: Thu, 28 Aug 2025 14:07:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/23] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-8-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> accessible to other subsystems.
> 
> Change DVSEC name formatting to follow the existing PCI format in
> pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.

I don't think renaming is necessary. Especially changing all the existing CXL code. CXL isn't exactly considered a subset of PCI (not part of PCI consortium). IMO it may be better to leave it as it was. Maybe others have different opinions. 

DJ
 
> 
> Update existing occurrences to match the name change.
> 
> Update the inline documentation to refer to latest CXL spec version.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c        | 62 +++++++++++++++++------------------
>  drivers/cxl/core/regs.c       | 12 +++----
>  drivers/cxl/cxlpci.h          | 53 ------------------------------
>  drivers/cxl/pci.c             |  2 +-
>  drivers/pci/pci.c             | 18 +++++-----
>  include/uapi/linux/pci_regs.h | 60 ++++++++++++++++++++++++++++++---
>  6 files changed, 104 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a3aef78f903a..d677691f8a05 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -110,19 +110,19 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>  	int rc, i;
>  	u32 temp;
>  
> -	if (id > CXL_DVSEC_RANGE_MAX)
> +	if (id > PCI_DVSEC_CXL_RANGE_MAX)
>  		return -EINVAL;
>  
>  	/* Check MEM INFO VALID bit first, give up after 1s */
>  	i = 1;
>  	do {
>  		rc = pci_read_config_dword(pdev,
> -					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
> +					   d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
>  					   &temp);
>  		if (rc)
>  			return rc;
>  
> -		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
> +		valid = FIELD_GET(PCI_DVSEC_CXL_MEM_INFO_VALID, temp);
>  		if (valid)
>  			break;
>  		msleep(1000);
> @@ -146,17 +146,17 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>  	int rc, i;
>  	u32 temp;
>  
> -	if (id > CXL_DVSEC_RANGE_MAX)
> +	if (id > PCI_DVSEC_CXL_RANGE_MAX)
>  		return -EINVAL;
>  
>  	/* Check MEM ACTIVE bit, up to 60s timeout by default */
>  	for (i = media_ready_timeout; i; i--) {
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id), &temp);
>  		if (rc)
>  			return rc;
>  
> -		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
> +		active = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE, temp);
>  		if (active)
>  			break;
>  		msleep(1000);
> @@ -185,11 +185,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  	u16 cap;
>  
>  	rc = pci_read_config_word(pdev,
> -				  d + CXL_DVSEC_CAP_OFFSET, &cap);
> +				  d + PCI_DVSEC_CXL_CAP_OFFSET, &cap);
>  	if (rc)
>  		return rc;
>  
> -	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> +	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
>  	for (i = 0; i < hdm_count; i++) {
>  		rc = cxl_dvsec_mem_range_valid(cxlds, i);
>  		if (rc)
> @@ -217,16 +217,16 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	u16 ctrl;
>  	int rc;
>  
> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> +	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, &ctrl);
>  	if (rc < 0)
>  		return rc;
>  
> -	if ((ctrl & CXL_DVSEC_MEM_ENABLE) == val)
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
>  		return 1;
> -	ctrl &= ~CXL_DVSEC_MEM_ENABLE;
> +	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
>  	ctrl |= val;
>  
> -	rc = pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl);
> +	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, ctrl);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -242,7 +242,7 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
>  {
>  	int rc;
>  
> -	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
> +	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
>  	if (rc < 0)
>  		return rc;
>  	if (rc > 0)
> @@ -304,11 +304,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  		return -ENXIO;
>  	}
>  
> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
> +	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP_OFFSET, &cap);
>  	if (rc)
>  		return rc;
>  
> -	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
>  		dev_dbg(dev, "Not MEM Capable\n");
>  		return -ENXIO;
>  	}
> @@ -319,7 +319,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  	 * driver is for a spec defined class code which must be CXL.mem
>  	 * capable, there is no point in continuing to enable CXL.mem.
>  	 */
> -	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> +	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
>  	if (!hdm_count || hdm_count > 2)
>  		return -EINVAL;
>  
> @@ -328,11 +328,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  	 * disabled, and they will remain moot after the HDM Decoder
>  	 * capability is enabled.
>  	 */
> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> +	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL_OFFSET, &ctrl);
>  	if (rc)
>  		return rc;
>  
> -	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
> +	info->mem_enabled = FIELD_GET(PCI_DVSEC_CXL_MEM_ENABLE, ctrl);
>  	if (!info->mem_enabled)
>  		return 0;
>  
> @@ -345,35 +345,35 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			return rc;
>  
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i), &temp);
>  		if (rc)
>  			return rc;
>  
>  		size = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(i), &temp);
>  		if (rc)
>  			return rc;
>  
> -		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
> +		size |= temp & PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK;
>  		if (!size) {
>  			continue;
>  		}
>  
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i), &temp);
>  		if (rc)
>  			return rc;
>  
>  		base = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
> +			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_LOW(i), &temp);
>  		if (rc)
>  			return rc;
>  
> -		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> +		base |= temp & PCI_DVSEC_CXL_MEM_BASE_LOW_MASK;
>  
>  		info->dvsec_range[ranges++] = (struct range) {
>  			.start = base,
> @@ -781,7 +781,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
>  		is_port = false;
>  
>  	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> -			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
> +			is_port ? PCI_DVSEC_CXL_PORT_GPF : PCI_DVSEC_CXL_DEVICE_GPF);
>  	if (!dvsec)
>  		dev_warn(dev, "%s GPF DVSEC not present\n",
>  			 is_port ? "Port" : "Device");
> @@ -797,14 +797,14 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  
>  	switch (phase) {
>  	case 1:
> -		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
> -		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
> -		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
> +		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL_OFFSET;
> +		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE_MASK;
> +		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
>  		break;
>  	case 2:
> -		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
> -		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
> -		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
> +		offset = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL_OFFSET;
> +		base = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE_MASK;
> +		scale = PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 5ca7b0eed568..fb70ffbba72d 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -271,10 +271,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, "CXL");
>  static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  				struct cxl_register_map *map)
>  {
> -	u8 reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> -	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> +	u8 reg_type = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> +	int bar = FIELD_GET(PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK, reg_lo);
>  	u64 offset = ((u64)reg_hi << 32) |
> -		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> +		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
>  
>  	if (offset > pci_resource_len(pdev, bar)) {
>  		dev_warn(&pdev->dev,
> @@ -311,15 +311,15 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	};
>  
>  	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> -					   CXL_DVSEC_REG_LOCATOR);
> +					   PCI_DVSEC_CXL_REG_LOCATOR);
>  	if (!regloc)
>  		return -ENXIO;
>  
>  	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>  	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
>  
> -	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> -	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
> +	regloc += PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET;
> +	regblocks = (regloc_size - PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET) / 8;
>  
>  	for (i = 0; i < regblocks; i++, regloc += 8) {
>  		u32 reg_lo, reg_hi;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 3959fa7e2ead..ad24d81e9eaa 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -7,59 +7,6 @@
>  
>  #define CXL_MEMORY_PROGIF	0x10
>  
> -/*
> - * See section 8.1 Configuration Space Registers in the CXL 2.0
> - * Specification. Names are taken straight from the specification with "CXL" and
> - * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
> - */
> -#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
> -
> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> -#define CXL_DVSEC_PCIE_DEVICE					0
> -#define   CXL_DVSEC_CAP_OFFSET		0xA
> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> -
> -#define CXL_DVSEC_RANGE_MAX		2
> -
> -/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> -#define CXL_DVSEC_FUNCTION_MAP					2
> -
> -/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
> -#define CXL_DVSEC_PORT_EXTENSIONS				3
> -
> -/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
> -#define CXL_DVSEC_PORT_GPF					4
> -#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
> -#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
> -#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
> -#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
> -#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
> -#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
> -
> -/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
> -#define CXL_DVSEC_DEVICE_GPF					5
> -
> -/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
> -#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> -
> -/* CXL 2.0 8.1.9: Register Locator DVSEC */
> -#define CXL_DVSEC_REG_LOCATOR					8
> -#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
> -#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
> -#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> -#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> -
>  /*
>   * NOTE: Currently all the functions which are enabled for CXL require their
>   * vectors to be in the first 16.  Use this as the default max.
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bd100ac31672..bd95be1f3d5c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -933,7 +933,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	cxlds->rcd = is_cxl_restricted(pdev);
>  	cxlds->serial = pci_get_dsn(pdev);
>  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> +		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
>  	if (!cxlds->cxl_dvsec)
>  		dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem init\n");
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9e42090fb108..d775ed37a79b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5031,7 +5031,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>  {
>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> -					 PCI_DVSEC_CXL_PORT);
> +					 PCI_DVSEC_CXL_PORT_EXT);
>  }
>  
>  static bool cxl_sbr_masked(struct pci_dev *dev)
> @@ -5043,7 +5043,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>  	if (!dvsec)
>  		return false;
>  
> -	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	rc = pci_read_config_word(dev,
> +				  dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
> +				  &reg);
>  	if (rc || PCI_POSSIBLE_ERROR(reg))
>  		return false;
>  
> @@ -5052,7 +5054,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>  	 * bit in Bridge Control has no effect.  When 1, the Port generates
>  	 * hot reset when the SBR bit is set to 1.
>  	 */
> -	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
> +	if (reg & PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR)
>  		return false;
>  
>  	return true;
> @@ -5097,22 +5099,22 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET, &reg);
>  	if (rc)
>  		return -ENOTTY;
>  
> -	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
> +	if (reg & PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR) {
>  		val = reg;
>  	} else {
> -		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
> -		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
> +		val = reg | PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR;
> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
>  				      val);
>  	}
>  
>  	rc = pci_reset_bus_function(dev, probe);
>  
>  	if (reg != val)
> -		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET,
>  				      reg);
>  
>  	return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a3a3e942dedf..b03244d55aea 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1225,9 +1225,61 @@
>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> -#define PCI_DVSEC_CXL_PORT				3
> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +/* Compute Express Link (CXL r3.2, sec 8.1)
> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */
> +
> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
> +
> +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE					0
> +#define	  PCI_DVSEC_CXL_CAP_OFFSET	       0xA
> +#define	    PCI_DVSEC_CXL_MEM_CAPABLE	       BIT(2)
> +#define	    PCI_DVSEC_CXL_HDM_COUNT_MASK       GENMASK(5, 4)
> +#define	  PCI_DVSEC_CXL_CTRL_OFFSET	       0xC
> +#define	    PCI_DVSEC_CXL_MEM_ENABLE	       BIT(2)
> +#define	  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)     (0x18 + (i * 0x10))
> +#define	  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)      (0x1C + (i * 0x10))
> +#define	    PCI_DVSEC_CXL_MEM_INFO_VALID       BIT(0)
> +#define	    PCI_DVSEC_CXL_MEM_ACTIVE	       BIT(1)
> +#define	    PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK    GENMASK(31, 28)
> +#define	  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)     (0x20 + (i * 0x10))
> +#define	  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)      (0x24 + (i * 0x10))
> +#define	    PCI_DVSEC_CXL_MEM_BASE_LOW_MASK    GENMASK(31, 28)
> +
> +#define PCI_DVSEC_CXL_RANGE_MAX		       2
> +
> +/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
> +#define PCI_DVSEC_CXL_FUNCTION_MAP				2
> +
> +/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
> +#define PCI_DVSEC_CXL_PORT_EXT					3
> +#define	  PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET			0x0c
> +#define	    PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR		0x00000001
> +
> +/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
> +#define PCI_DVSEC_CXL_PORT_GPF					4
> +#define	  PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
> +#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE_MASK	GENMASK(3, 0)
> +#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE_MASK	GENMASK(11, 8)
> +#define	  PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
> +#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE_MASK	GENMASK(3, 0)
> +#define	    PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE_MASK	GENMASK(11, 8)
> +
> +/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE_GPF				5
> +
> +/* CXL 3.2 8.1.8: PCIe DVSEC for Flex Bus Port */
> +#define PCI_DVSEC_CXL_FLEXBUS_PORT				7
> +
> +/* CXL 3.2 8.1.9: Register Locator DVSEC */
> +#define PCI_DVSEC_CXL_REG_LOCATOR				8
> +#define	  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET		0xC
> +#define	    PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
> +#define		   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK	GENMASK(15, 8)
> +#define	    PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK	GENMASK(31, 16)
>  
>  #endif /* LINUX_PCI_REGS_H */


