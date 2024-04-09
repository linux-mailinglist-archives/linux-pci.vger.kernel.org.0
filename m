Return-Path: <linux-pci+bounces-5977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E2F89E4EC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 23:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F7D283FDA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA6158851;
	Tue,  9 Apr 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOSCJ9pM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49B763F1;
	Tue,  9 Apr 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698084; cv=none; b=EUOVPfakv03dHQIRBHpWjK4O1zwYeA3opnDuZcAY9M55PhPeKtIb3tLP8ssA2O+NHPD90fydTc82J8OQi7f02keVowvzJ3VvvzVwwd+z3pUPfnxL5EyBUFEJjt/441fVmYjKg7/BCk+SO9pCwW5fx9q/XrhCl1AzFRkUMNJJniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698084; c=relaxed/simple;
	bh=ZTrc2RdVV4v29qfNaF6SXOOfEwF/e27UDGshggT5dg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDsmLwfRFufEd8GFsQeN7K2YJNwe5iq1Duhr6A7+jgzMADWs2QrDKr3C1aRirfVp6x3I8wdk4gMTwd77GULHdrOQWUcm3vHfKllttzfpcslTkPNI3Xxx1sgY/wkUXOtU5kwJXlyp66ybchFYSdBZdGFK7H44+IHL4iREIo4Z5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOSCJ9pM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712698082; x=1744234082;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZTrc2RdVV4v29qfNaF6SXOOfEwF/e27UDGshggT5dg4=;
  b=bOSCJ9pM55XJMlmwprlnsk7z5EN0shrdYaN6EZbbH9amVDc0VyUuZAaX
   dm9fxk1FR4Up+dEfDMsUhUDb9fvjeSETNt0QgqCDQ4uk+4Q6Kxn0ofEoy
   IEn6J2mfR/t82VesLIyMyUTo7hfeMK0sD5LtD1vlW7BXT+AgQrVSpdVoN
   rejazDTFCud2CukJush76F97T0qr7Agl9gtBAvnJKVqFzLrGK3Jn4GS5h
   KFGJ/7OMQ4gmYIHLJiytcFCfv5/ZFde4G3xCotEuw8WQRG5BSZ7B8cDy8
   iQcgOebGljWb95OWw4dhF7hZjyDe5V++3PPrcFoAmiXP+yt1hhkK6OkTn
   w==;
X-CSE-ConnectionGUID: IBPrSfT+SgGxaFt1FzQzVw==
X-CSE-MsgGUID: 912Mv8VFTgqNVp27mVSGNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8214155"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8214155"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:28:02 -0700
X-CSE-ConnectionGUID: mnMiwWaQRx6EkmQmuUQ+dQ==
X-CSE-MsgGUID: KN06rIUATZakk1Htx9OhJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20785006"
Received: from osezer-mobl.amr.corp.intel.com (HELO [10.209.70.70]) ([10.209.70.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:28:01 -0700
Message-ID: <162f9331-8e42-4a0d-b2f1-56bbb780a03b@linux.intel.com>
Date: Tue, 9 Apr 2024 14:28:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] PCI/cxl: Move PCI CXL vendor Id to a common
 location from CXL subsystem
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com, lukas@wunner.de, Bjorn Helgaas <helgaas@kernel.org>
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-2-dave.jiang@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240409160256.94184-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/9/24 9:01 AM, Dave Jiang wrote:
> Move PCI_DVSEC_VENDOR_ID_CXL in CXL private code to PCI_VENDOR_ID_CXL in
> pci_ids.h in order to be utilized in PCI subsystem.
>
> The response Bjorn received from the PCI SIG was "1E98h is not a VID in our
> system, but 1E98 has already been reserved by CXL." He suggested "we should
> add '#define PCI_VENDOR_ID_CXL 0x1e98' so that if we ever *do* see such an
> assignment, we'll be more likely to flag it as an issue.

Nit: Instead of including the comments as-it-is, I think it is better just state
the conclusion.

>
> Link: https://lore.kernel.org/linux-cxl/20240402172323.GA1818777@bhelgaas/
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
>  drivers/cxl/core/pci.c  | 6 +++---
>  drivers/cxl/core/regs.c | 2 +-
>  drivers/cxl/cxlpci.h    | 1 -
>  drivers/cxl/pci.c       | 2 +-
>  drivers/perf/cxl_pmu.c  | 2 +-
>  include/linux/pci_ids.h | 2 ++
>  6 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0df09bd79408..c496a9710d62 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -525,7 +525,7 @@ static int cxl_cdat_get_length(struct device *dev,
>  	__le32 response[2];
>  	int rc;
>  
> -	rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
> +	rc = pci_doe(doe_mb, PCI_VENDOR_ID_CXL,
>  		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  		     &request, sizeof(request),
>  		     &response, sizeof(response));
> @@ -555,7 +555,7 @@ static int cxl_cdat_read_table(struct device *dev,
>  		__le32 request = CDAT_DOE_REQ(entry_handle);
>  		int rc;
>  
> -		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
> +		rc = pci_doe(doe_mb, PCI_VENDOR_ID_CXL,
>  			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  			     &request, sizeof(request),
>  			     rsp, sizeof(*rsp) + remaining);
> @@ -640,7 +640,7 @@ void read_cdat_data(struct cxl_port *port)
>  	if (!pdev)
>  		return;
>  
> -	doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +	doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_CXL,
>  				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..da52fc9e234b 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -313,7 +313,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		.resource = CXL_RESOURCE_NONE,
>  	};
>  
> -	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>  					   CXL_DVSEC_REG_LOCATOR);
>  	if (!regloc)
>  		return -ENXIO;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 93992a1c8eec..4da07727ab9c 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -13,7 +13,6 @@
>   * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
> -#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
>  
>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>  #define CXL_DVSEC_PCIE_DEVICE					0
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..110478573296 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -817,7 +817,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	cxlds->rcd = is_cxl_restricted(pdev);
>  	cxlds->serial = pci_get_dsn(pdev);
>  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> +		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>  	if (!cxlds->cxl_dvsec)
>  		dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem init\n");
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 308c9969642e..a1b742b1a735 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -345,7 +345,7 @@ static ssize_t cxl_pmu_event_sysfs_show(struct device *dev,
>  
>  /* For CXL spec defined events */
>  #define CXL_PMU_EVENT_CXL_ATTR(_name, _gid, _msk)			\
> -	CXL_PMU_EVENT_ATTR(_name, PCI_DVSEC_VENDOR_ID_CXL, _gid, _msk)
> +	CXL_PMU_EVENT_ATTR(_name, PCI_VENDOR_ID_CXL, _gid, _msk)
>  
>  static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(clock_ticks,			CXL_PMU_GID_CLOCK_TICKS, BIT(0)),
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a0c75e467df3..7dfbf6d96b3d 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2607,6 +2607,8 @@
>  
>  #define PCI_VENDOR_ID_ALIBABA		0x1ded
>  
> +#define PCI_VENDOR_ID_CXL		0x1e98
> +
>  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


