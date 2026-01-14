Return-Path: <linux-pci+bounces-44880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7DD21BBB
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 00:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40589302C211
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 23:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8130E828;
	Wed, 14 Jan 2026 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cz7FfJp+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B65264A9D;
	Wed, 14 Jan 2026 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432694; cv=none; b=Xj7dN6OFN2YvLLd3z+JyCAun/pcbDBDHylX3Uu41ND6nJH/W2e4EdVLNQpaQ0Ac/nozMCV1BiB0a56z2fk83usn8CC0Sm2HyJt16L6ITvHWwuUhLEbhF86fIHIgbW3rPCknc+5/DvEVTzNGsl5qcj+CBthuOf76sPCgnPaLHmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432694; c=relaxed/simple;
	bh=Cw8VyfqFM9encrFkkO6obNTzHU9pg7+wSw3oO1MMqPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umjXg9Ij/K2N+7P8c5CxLm2lu/w6GuqxMF5hc6A3g4hd/b8WNtDdPPQwo052KXaunMnGlJBPBnkFc8JKIK2CQU1RnGhukjdNe/fSq42CSMWXQAMMKyHVUskQ6sOoCqjm3KTiEBPq7FvqR9HgjPouDn8BKJQFTbQ49FcB7nMi0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cz7FfJp+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768432693; x=1799968693;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cw8VyfqFM9encrFkkO6obNTzHU9pg7+wSw3oO1MMqPY=;
  b=cz7FfJp+tEU/hh8WZuwoSd6v69iiJKNjS3vc5ds+xpwGZ0Zq7SyiwUIk
   oSYvDTPVTKw1pKgqV4tn6L1AdbZ7e+hoimh5XTfBBmf49XuFpmoqjboAH
   8upW/vLWXmH7BrVKjIkaOWpalL2pCbBLi3DTufC61pPufhZmxkzFTt5Ji
   tEPzO4IPuooEAkwGcDePIbxK+0FHKC9iPOR1xU9O03NbbmtQvO+Jl1T+X
   TJUFAIWauTxz6u7oAaCYPXjs9qLbcMwKNQEZ0zLsUENx1/7m9y1ydMz8x
   R8ey1HKbl0rvUGK5jbhdcSK31PvD7Ton7feOoxStwkbNMKCYuo3Xg9hpU
   A==;
X-CSE-ConnectionGUID: FyF79zQ+Tciqy8eP86J8og==
X-CSE-MsgGUID: viV4o/ZSQC6QQjkP5uuFEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69475499"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69475499"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 15:18:12 -0800
X-CSE-ConnectionGUID: XatWQ2ujTs61N9UpD15PJg==
X-CSE-MsgGUID: 2+kodVcFSye1KF/yfqUxow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204591075"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 15:18:11 -0800
Message-ID: <2ddecc1e-8134-4730-bb76-630691359269@intel.com>
Date: Wed, 14 Jan 2026 16:18:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 30/34] PCI/AER: Dequeue forwarded CXL error
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-31-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-31-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> The AER driver now forwards CXL protocol errors to the CXL driver via a
> kfifo. The CXL driver must consume these work items and initiate protocol
> error handling while ensuring the device's RAS mappings remain valid
> throughout processing.
> 
> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
> AER service driver. Lock the parent CXL Port device to ensure the CXL
> device's RAS registers are accessible during handling. Add pdev reference-put
> to match reference-get in AER driver. This will ensure pdev access after
> kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v13->v14:
> - Update commit title's prefix (Bjorn)
> - Add pdev ref get in AER driver before enqueue and add pdev ref put in
>   CXL driver after dequeue and handling (Dan)
> - Removed handling to simplify patch context (Terry)
> 
> Changes in v12->v13:
> - Add cxlmd lock using guard() (Terry)
> - Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
> - Change pr_err() calls to ratelimited. (Terry)
> - Update commit message. (Terry)
> - Remove namespace qualifier from pcie_clear_device_status()
>   export (Dave Jiang)
> - Move locks into cxl_proto_err_work_fn() (Dave)
> - Update log messages in cxl_forward_error() (Ben)
> 
> Changes in v11->v12:
> - Add guard for CE case in cxl_handle_proto_error() (Dave)
> 
> Changes in v10->v11:
> - Reword patch commit message to remove RCiEP details (Jonathan)
> - Add #include <linux/bitfield.h> (Terry)
> - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
> - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
> - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
> - Use FIELD_GET() in discovering class code (Jonathan)
> - Remove BDF from cxl_proto_err_work_data. Use 'struct
> pci_dev *' (Dan)
> ---
>  drivers/cxl/core/core.h       |  3 ++
>  drivers/cxl/core/port.c       |  6 +--
>  drivers/cxl/core/ras.c        | 98 +++++++++++++++++++++++++++++++----
>  drivers/pci/pcie/aer_cxl_vh.c |  1 +
>  4 files changed, 94 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 306762a15dc0..39324e1b8940 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -169,6 +169,9 @@ static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>  #endif /* CONFIG_CXL_RAS */
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>  
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a535e57360e0..0bec10be5d56 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1335,8 +1335,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> @@ -1578,7 +1578,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>   * Function takes a device reference on the port device. Caller should do a
>   * put_device() when done.
>   */
> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>  {
>  	struct device *dev;
>  
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index bf82880e19b4..0c640b84ad70 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> -int cxl_ras_init(void)
> -{
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> -}
> -
> -void cxl_ras_exit(void)
> -{
> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);
> -}
> -
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map = &dport->reg_map;
> @@ -173,6 +162,44 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> +/*
> + * Return 'struct cxl_port *' parent CXL Port of dev
> + *
> + * Reference count increments returned port on success
> + *
> + * @pdev: Find the parent CXL Port of this device
> + */
> +static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
> +{
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	}
> +	pci_warn_once(pdev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -316,3 +343,52 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +
> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
> +{
> +}
> +
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	while (cxl_proto_err_kfifo_get(&wd)) {
> +		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;
> +
> +		if (!pdev) {
> +			pr_err_ratelimited("NULL PCI device passed in AER-CXL KFIFO\n");
> +			continue;
> +		}
> +
> +		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +		if (!port) {
> +			pr_err_ratelimited("Failed to find parent Port device in CXL topology.\n");
> +			continue;
> +		}
> +		guard(device)(&port->dev);
> +
> +		cxl_handle_proto_error(&wd);
> +	}
> +}
> +
> +static struct work_struct cxl_proto_err_work;
> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
> +
> +int cxl_ras_init(void)
> +{
> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
> +		pr_err("Failed to initialize CXL RAS CPER\n");
> +
> +	cxl_register_proto_err_work(&cxl_proto_err_work);
> +
> +	return 0;
> +}
> +
> +void cxl_ras_exit(void)
> +{
> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> +	cancel_work_sync(&cxl_cper_prot_err_work);
> +
> +	cxl_unregister_proto_err_work();
> +	cancel_work_sync(&cxl_proto_err_work);
> +}
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 2189d3c6cef1..0f616f5fafcf 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -48,6 +48,7 @@ void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
>  	};
>  
>  	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
> +	pci_dev_get(pdev);

Should this chunk move to where the commit that implements cxl_forward_error()?


>  	if (!cxl_proto_err_kfifo.work || !kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
>  		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo error");
>  		return;


