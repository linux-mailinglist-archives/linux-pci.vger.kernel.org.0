Return-Path: <linux-pci+bounces-15729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE69B8001
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E2AB20EC6
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C77E1BBBEA;
	Thu, 31 Oct 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGy78zBy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A81BBBDA;
	Thu, 31 Oct 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391948; cv=none; b=CfNo/oy3847e6YRkQurlkyhbt6E3P9vRRo9dNdXvTrgXDDVhu1/nUZhsES9wUg0xtvp7TCDJM02onZaPhTLDYMjhnI4R5l28ZlmgAC5W0Y/DOF2i0Qh+uRZYg43QXQHvDMRymqibUg5w2QpsvNu/xfAiUDGTWiLNxcOFm4gemwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391948; c=relaxed/simple;
	bh=JjE5x1eGkkaUcr30PcTK0N+rFI8UzjKI7Uv+XWdOyhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=USsMxMoeunqLXx5eqTRhrxkUVV3KeukFo4I+9z/nMhVpEAy99eGJm5n/hzUlprEKf5ccrFxpO27USryibTo2hF+ksWPajYa0HOiY2S23/P29UyANxbMcvAvmo+3lQ4ls68/ahRxCkkYmSPXHZHKX8kMCZznV4dd0Ppz76i6e2xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGy78zBy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730391946; x=1761927946;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JjE5x1eGkkaUcr30PcTK0N+rFI8UzjKI7Uv+XWdOyhI=;
  b=dGy78zByvdzLOnljGtIkzE5SdfXe5wlkictUq0S9eCFHWDntSSDWh2Lx
   oy1oC2rX+MolqMndTEJikP/y4oHtIux6BrkP6MKANIuZBigOwfWw47vPn
   OAf37jZ4UA+F3lHTTgmPvGx1h7wyw5h9s623h03mtu2UZtNySFYdX9+gm
   KYoBz1oEKIHKGdi+RcS302kzDHnxCQ/hnCx8U0dDzGsN8fqomm4Nx6UEY
   C2kde+sq3CA+lnNemT8QDsCAT9EPfgbk2IjRz2cx265RRv/u6VxJet6So
   AK5sqZIC0MDyirm2kguOT5ZFhy1/EPMGR1sKm+03H9JpDnp1rSFmrWDSv
   A==;
X-CSE-ConnectionGUID: OHHNNLvdQNy3zPEfmvA/kw==
X-CSE-MsgGUID: sj3Yf3RpQjeI0S4aXv2fAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30259021"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30259021"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:25:44 -0700
X-CSE-ConnectionGUID: To6RB4RqS4iiAlKXKXqx8w==
X-CSE-MsgGUID: HaSDEYG2QKet9nTN59Uyeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113522642"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.232]) ([10.125.108.232])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:25:42 -0700
Message-ID: <a68f58d4-d79d-4c91-855f-9bfb36013cc4@intel.com>
Date: Thu, 31 Oct 2024 09:25:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] cxl/pci: Introduce helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
To: Terry Bowman <terry.bowman@amd.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-4-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241025210305.27499-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:02 PM, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices and CXL port
> devices.
> 
> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
> presence. The CXL Flexbus DVSEC presence is used because it is required
> for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
> 
> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl',
> 
> Add pcie_is_cxl_port() to check if a device is a CXL root port, CXL
> upstream switch port, or CXL downstream switch port. Also, verify the
> CXL extensions DVSEC for port is present.[1]
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/pci.c             | 14 ++++++++++++++
>  drivers/pci/probe.c           | 10 ++++++++++
>  include/linux/pci.h           |  4 ++++
>  include/uapi/linux/pci_regs.h |  3 ++-
>  4 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2..c1b243aec61c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5034,6 +5034,20 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>  					 PCI_DVSEC_CXL_PORT);
>  }
>  
> +bool pcie_is_cxl_port(struct pci_dev *dev)
> +{
> +	if (!pcie_is_cxl(dev))
> +		return false;
> +
> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> +		return false;
> +
> +	return cxl_port_dvsec(dev);
> +}
> +EXPORT_SYMBOL_GPL(pcie_is_cxl_port);
> +
>  static bool cxl_sbr_masked(struct pci_dev *dev)
>  {
>  	u16 dvsec, reg;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..9324eb345f11 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1631,6 +1631,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS);
> +	if (dvsec)
> +		dev->is_cxl = 1;
> +}
> +
>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent;
> @@ -1945,6 +1953,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Need to have dev->cfg_size ready */
>  	set_pcie_thunderbolt(dev);
>  
> +	set_pcie_cxl(dev);
> +
>  	set_pcie_untrusted(dev);
>  
>  	/* "Unknown power state" */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 106ac83e3a7b..d3b1af9fb273 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -443,6 +443,7 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* CXL alternate protocol */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially
>  	 * execute DMA attacks and similar. They are typically connected
> @@ -743,6 +744,9 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +#define pcie_is_cxl(dev) (dev->is_cxl)
> +bool pcie_is_cxl_port(struct pci_dev *dev);
> +
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>  		if (!pci_is_bridge(dev)) {} else
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 12323b3334a9..5df6c74963c5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1186,9 +1186,10 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +/* Compute Express Link (CXL r3.1, sec 8.1) */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +#define PCI_DVSEC_CXL_FLEXBUS				7
>  
>  #endif /* LINUX_PCI_REGS_H */


