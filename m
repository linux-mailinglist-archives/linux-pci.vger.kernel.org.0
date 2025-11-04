Return-Path: <linux-pci+bounces-40261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC153C32724
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51FDE3445DF
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B65335570;
	Tue,  4 Nov 2025 17:52:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BF335547;
	Tue,  4 Nov 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278751; cv=none; b=XILT4BuUkLEip13DN9JeZksizS7AUEGsRtB9gi0fkY8g/f3BDxV6vdT0XWDKFId7/9O66vGEPjL1wRJkAuSsqWaw4LLeFxJQwgLta9iJyB0ZMwGN5/pvNkYvFXXR/XGNNVoMXYz7rcvM9R2wdgVCc77CjwQx6WdIB9zIRLva44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278751; c=relaxed/simple;
	bh=ZWO3poGajjPw0a7R4Pj40W00d2HpOM/6ynNljH3Pu3E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QstHDB8xAeZ5qtnuEbucs29ytn/W3xdyvvCTEiyQ1Pw45eDCHI5O40/IXaxLJ8r7O855VlMnC9j6tdSPW+IjMqjj/R+Al3aI2K1HcnRXl7loPNPIZysoG4wWXRpyRz986bOV/W0c6iME4z1/K3GqsdiDwM9FQmoxk/RckanyAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1GCR2tDWz6L55x;
	Wed,  5 Nov 2025 01:48:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7178D1404C6;
	Wed,  5 Nov 2025 01:52:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 17:52:24 +0000
Date: Tue, 4 Nov 2025 17:52:23 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
Message-ID: <20251104175223.00004e02@huawei.com>
In-Reply-To: <20251104170305.4163840-3-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-3-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 11:02:42 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL and AER drivers need the ability to identify CXL devices.
> 
> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
> presence is used because it is required for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> CXL.cache and CXl.mem status.
> 
> In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
> the parent downstream device. Once a device is created there is
> possibilty the parent training or CXL state was updated as well. This
> will make certain the correct parent CXL state is cached.
> 
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
Hi Terry,

Drag the FLEXBUS_STATUS defines from previous patch to this one and we
are all good I think. At least it wasn't far :)

Jonathan

> ---
> 
> Changes in v12->v13:
> - Add Ben's "reviewed-by"
> 
> Changes in v11->v12:
> - Add review-by for Alejandro
> - Add comment in set_pcie_cxl() explaining why updating parent status.
> 
> Changes in v10->v11:
> - Amend set_pcie_cxl() to check for Upstream Port's and EP's parent
>   downstream port by calling set_pcie_cxl(). (Dan)
> - Retitle patch: 'Add' -> 'Introduce'
> - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
> ---
>  drivers/pci/probe.c | 29 +++++++++++++++++++++++++++++
>  include/linux/pci.h |  6 ++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a8..63124651f865 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1709,6 +1709,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
> +	if (dvsec) {
> +		u16 cap;
> +
> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
> +
> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
> +	}
> +
> +	if (!pci_is_pcie(dev) ||
> +	    !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
> +		return;
> +
> +	/*
> +	 * Update parent's CXL state because alternate protocol training
> +	 * may have changed
> +	 */
> +	parent = pci_upstream_bridge(dev);
> +	set_pcie_cxl(parent);
> +}


