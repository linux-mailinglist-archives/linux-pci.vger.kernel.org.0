Return-Path: <linux-pci+bounces-37067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0003BA200A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 01:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ABD2A1421
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 23:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CF62DCBF1;
	Thu, 25 Sep 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmICQ4WV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F637747F;
	Thu, 25 Sep 2025 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758844428; cv=none; b=GGTgGOBOF0zSDXhXwLTYQ/5Xeq5lP6frJEGzv7PTc2HszrHIVKRM1f+u5u4vH6OcA0iupZ5efuFfQfPvpsJ7hhEAfl0EBWsKGvbpqQcNt9UWJM9Zdn5rDidQ2sd8zJwaVFS5f8hLutukYTdsU0ucC0pek5z+jnrdlMOl4bXn6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758844428; c=relaxed/simple;
	bh=/j+Coqkc6bvryCE2e9/g+CtPhJKED4iT8Hi4MnTa+dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esTQT/8nIFZy0Iv01umyhCfnYi8bd/vYEoqJ96mRJNqXR6xMfoAP4KaHlrQKDTFoB4FDN4jwn8hcspkxWhqlcz3bZHS28l1s73h4oZea57Rb3QVZY60Faxtbjr6KbOKfVdIyPgpboz9O2oLMcuSsK9v/XjiziZtJH3u79vlI2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmICQ4WV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758844426; x=1790380426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/j+Coqkc6bvryCE2e9/g+CtPhJKED4iT8Hi4MnTa+dA=;
  b=WmICQ4WVHPDj4eQhxvsBpkzwBFf8rN4nCY+RpRauSaPm0FCiHmA3pRJL
   0izeIArJlDBz+L3aGohDi532Tgl54cZCq+kVxKhnXeN/aOy7HPRVKYp6l
   qraj+f1D+GzoGMOPzvrsIMettcnTFHzjgJ24hrgJV4kNBGX6cQgoZfZnp
   U9GxCKAmEFuPrD/7Bqd8gkvFFCecqlW+71nsc1+ebiFwTt78LR8RhjekZ
   5PPYgZ4M6bIhsZuAY8wWa62LM3TtMdmJvhkL3unFx82jM6gXJSH4IE33V
   cNnW/hS7clS7FRcWFxcnvL5O6UB1rvD1+gb/Kkh0R5+6wJNz3MhhmR6de
   g==;
X-CSE-ConnectionGUID: xKY+58GFQ2ix2T2eYNvvJA==
X-CSE-MsgGUID: 8zRYSsDFSjqtboSXToykbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61089370"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61089370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:53:45 -0700
X-CSE-ConnectionGUID: JMe/0vLHQ9uEGWL32X4/SQ==
X-CSE-MsgGUID: ggboOEWCR76QQRmevTc38w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="201143569"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.4]) ([10.125.109.4])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:53:42 -0700
Message-ID: <2fb13659-8203-482c-8659-cd4a82b54de1@intel.com>
Date: Thu, 25 Sep 2025 16:53:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/25] CXL/PCI: Move CXL DVSEC definitions into
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
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-8-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> accessible to other subsystems.
> 
> Change DVSEC name formatting to follow the existing PCI format in
> pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.
> Reuse the existing formatting.
> 
> Update existing occurrences to match the name change.
> 
> Update the inline documentation to refer to latest CXL spec version.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ----
> 
> Changes in v11 -> v12:
> - Change formatting to be same as existing definitions
> - Change GENMASK() -> __GENMASK() and BIT() to _BITUL()
> 
> Changes in v10 -> v11:
> - New commit
> ---
>  drivers/cxl/core/pci.c        | 62 +++++++++++++++++-----------------
>  drivers/cxl/core/regs.c       | 12 +++----
>  drivers/cxl/cxlpci.h          | 53 -----------------------------
>  drivers/cxl/pci.c             |  2 +-
>  drivers/pci/pci.c             | 18 +++++-----
>  include/uapi/linux/pci_regs.h | 63 ++++++++++++++++++++++++++++++++---
>  6 files changed, 107 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a009a51cb0de..a74a39bd909c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -157,19 +157,19 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
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
> @@ -193,17 +193,17 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
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
> @@ -232,11 +232,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
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
> @@ -264,16 +264,16 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
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
> @@ -289,7 +289,7 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
>  {
>  	int rc;
>  
> -	rc = cxl_set_mem_enable(cxlds, CXL_DVSEC_MEM_ENABLE);
> +	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
>  	if (rc < 0)
>  		return rc;
>  	if (rc > 0)
> @@ -351,11 +351,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
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
> @@ -366,7 +366,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  	 * driver is for a spec defined class code which must be CXL.mem
>  	 * capable, there is no point in continuing to enable CXL.mem.
>  	 */
> -	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> +	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT_MASK, cap);
>  	if (!hdm_count || hdm_count > 2)
>  		return -EINVAL;
>  
> @@ -375,11 +375,11 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
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
> @@ -392,35 +392,35 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
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
> @@ -828,7 +828,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
>  		is_port = false;
>  
>  	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> -			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
> +			is_port ? PCI_DVSEC_CXL_PORT_GPF : PCI_DVSEC_CXL_DEVICE_GPF);
>  	if (!dvsec)
>  		dev_warn(dev, "%s GPF DVSEC not present\n",
>  			 is_port ? "Port" : "Device");
> @@ -844,14 +844,14 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
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
> index 970e84cf49e9..0c8b6ee7b6de 100644
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
> index b0f4d98036cd..1a4f61caa0db 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5041,7 +5041,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>  {
>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> -					 PCI_DVSEC_CXL_PORT);
> +					 PCI_DVSEC_CXL_PORT_EXT);
>  }
>  
>  static bool cxl_sbr_masked(struct pci_dev *dev)
> @@ -5053,7 +5053,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
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
> @@ -5062,7 +5064,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>  	 * bit in Bridge Control has no effect.  When 1, the Port generates
>  	 * hot reset when the SBR bit is set to 1.
>  	 */
> -	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
> +	if (reg & PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR)
>  		return false;
>  
>  	return true;
> @@ -5107,22 +5109,22 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
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
> index f5b17745de60..bd03799612d3 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1234,9 +1234,64 @@
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
> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
> +
> +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE			0
> +#define  PCI_DVSEC_CXL_CAP_OFFSET		0xA
> +#define   PCI_DVSEC_CXL_MEM_CAPABLE		_BITUL(2)
> +#define   PCI_DVSEC_CXL_HDM_COUNT_MASK		__GENMASK(5, 4)
> +#define  PCI_DVSEC_CXL_CTRL_OFFSET		0xC
> +#define   PCI_DVSEC_CXL_MEM_ENABLE		_BITUL(2)
> +#define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> +#define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> +#define   PCI_DVSEC_CXL_MEM_INFO_VALID		_BITUL(0)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE		_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK	__GENMASK(31, 28)
> +#define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> +#define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> +#define   PCI_DVSEC_CXL_MEM_BASE_LOW_MASK	__GENMASK(31, 28)
> +
> +#define PCI_DVSEC_CXL_RANGE_MAX			2
> +
> +/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
> +#define PCI_DVSEC_CXL_FUNCTION_MAP				2
> +
> +/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
> +#define PCI_DVSEC_CXL_PORT_EXT					3
> +#define   PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET			0x0c
> +#define    PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR		0x00000001
> +
> +/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
> +#define PCI_DVSEC_CXL_PORT_GPF					4
> +#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE_MASK		__GENMASK(3, 0)
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE_MASK		__GENMASK(11, 8)
> +#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE_MASK		__GENMASK(3, 0)
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE_MASK		__GENMASK(11, 8)
> +
> +/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE_GPF				5
> +
> +/* CXL 3.2 8.1.8: PCIe DVSEC for Flex Bus Port */
> +#define PCI_DVSEC_CXL_FLEXBUS_PORT				7
> +#define  PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET			0xE
> +#define   PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK		_BITUL(0)
> +#define   PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK			_BITUL(2)
> +
> +/* CXL 3.2 8.1.9: Register Locator DVSEC */
> +#define PCI_DVSEC_CXL_REG_LOCATOR				8
> +#define  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET		0xC
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK			__GENMASK(2, 0)
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK		__GENMASK(15, 8)
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK		__GENMASK(31, 16)
>  
>  #endif /* LINUX_PCI_REGS_H */


