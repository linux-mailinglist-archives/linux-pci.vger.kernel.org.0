Return-Path: <linux-pci+bounces-35946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9730FB53C74
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 21:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493A216A69D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FC125A642;
	Thu, 11 Sep 2025 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7rjOkmf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41D2DC778;
	Thu, 11 Sep 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619668; cv=none; b=ruAsj2Xhy3M0U6S5JUkDmb5fuHbcEoXUqFqhKB0kBbThdAyLIXiieQhxFG1JTPh9P1YS0pGj96IqAqvBofBJ/y/zOV6VeM1FZXkAbx7+dzlGYNTe+GrEX3YpNkz6ahh539YIMf0lH+e4510B4WD7DCVt5w2K2UiMtGA44wCtgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619668; c=relaxed/simple;
	bh=azqTZYq7izDHKy0kvsNslCGmf6NBt85iWA5XbSaV308=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIKEYKL8Yk2+og6gqtjjF7gV11RJKrkFHcZcPkaX4HYij6CucjxSyTbP+ixPD6QNlbcSDDBmBA5gyVfRoCG6DWQ/Z5KWHny4FVJ7zzy06Wv5mw91WQxFXVRHVWXyFKUkdUa6cB++OxIWqJ5uu38vWrzB9MPGBtymle64LOdqWDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7rjOkmf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757619666; x=1789155666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=azqTZYq7izDHKy0kvsNslCGmf6NBt85iWA5XbSaV308=;
  b=V7rjOkmfOXOXJTt5YlUFTgvfwVAN7r6n5lIXjg9sJVE7utVP4xhGsMmG
   FPnAo3D9S+/DJCKYFRC3hgPQzCtiRAP2hykqratUSqNZ5vNIPg5THGsLj
   xo+K6cHMPkKE7pULGJ3gJ24K1AcdHFOQbpCdfbpPrTHByt4lkDyNbKYvz
   EAow9J4NEglWlyqxf/xycewhdUefearUAnhOwubatv99jxmbf19M6PMXl
   3DnlvJLNwGbXyMrj4nyE3U4xcUgjjm8pA3lrFVnxTG6Xnsxb/JdOFdTb7
   unTriq+007gfYNfb9SgVH9MNZ8LXVg45lL+ZWR9lrw3s1MdD92n6L3qjY
   A==;
X-CSE-ConnectionGUID: wYSzFkYdQEC6gVuzM9OkrA==
X-CSE-MsgGUID: yoMAI8sWSXqCSHa2t2ZhiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70582959"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="70582959"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:41:06 -0700
X-CSE-ConnectionGUID: 7cmWVu23Scy5NMtx1DXQew==
X-CSE-MsgGUID: KU+4K6JfS6eiPv8Wx2QgUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="204545178"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.21]) ([10.125.111.21])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:41:04 -0700
Message-ID: <fb81e416-6c12-490f-b600-dd05a7d9a727@intel.com>
Date: Thu, 11 Sep 2025 12:41:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/23] cxl: Move CXL driver RCH error handling into
 CONFIG_CXL_RCH_RAS conditional block
To: "Bowman, Terry" <terry.bowman@amd.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, alison.schofield@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-6-terry.bowman@amd.com>
 <20250829163355.00004fda@huawei.com>
 <ee9d1e0b-1583-4fd0-9598-753219957df1@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ee9d1e0b-1583-4fd0-9598-753219957df1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/11/25 10:48 AM, Bowman, Terry wrote:
> 
> 
> On 8/29/2025 10:33 AM, Jonathan Cameron wrote:
>> On Tue, 26 Aug 2025 20:35:20 -0500
>> Terry Bowman <terry.bowman@amd.com> wrote:
>>
>>> Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
>>> from the CXL Virtual Hierarchy (VH) handling. This is because of the
>>> differences in the RCH and VH topologies. Improve the maintainability and
>>> add ability to enable/disable RCH handling.
>>>
>>> Move and combine the RCH handling code into a single block conditionally
>>> compiled with the CONFIG_CXL_RCH_RAS kernel config.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>
>> How painful to move this to a ras_rch.c file and conditionally compile that?
>>
>> Would want to do that is some merged thing with patch 1 though, rather than
>> moving at least some of the code twice.
>>
> 
> I don't see an issue and the effort would be a simple rework of patch1 as you 
> mentioned. But, it would drop the 'reviewed-by' sign-offs. Should we check with 
> others about this too? 

I would go ahead and do it.


> 
> Terry
> 
>>
>>> ---
>>> v10->v11:
>>> - New patch
>>> ---
>>>  drivers/cxl/core/ras.c | 175 +++++++++++++++++++++--------------------
>>>  1 file changed, 90 insertions(+), 85 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>> index 0875ce8116ff..f42f9a255ef8 100644
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> @@ -126,6 +126,7 @@ void cxl_ras_exit(void)
>>>  	cancel_work_sync(&cxl_cper_prot_err_work);
>>>  }
>>>  
>>> +#ifdef CONFIG_CXL_RCH_RAS
>>>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>>  {
>>>  	resource_size_t aer_phys;
>>> @@ -141,18 +142,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>>  	}
>>>  }
>>>  
>>> -static void cxl_dport_map_ras(struct cxl_dport *dport)
>>> -{
>>> -	struct cxl_register_map *map = &dport->reg_map;
>>> -	struct device *dev = dport->dport_dev;
>>> -
>>> -	if (!map->component_map.ras.valid)
>>> -		dev_dbg(dev, "RAS registers not found\n");
>>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> -		dev_dbg(dev, "Failed to map RAS capability.\n");
>>> -}
>>> -
>>>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>>  {
>>>  	void __iomem *aer_base = dport->regs.dport_aer;
>>> @@ -177,6 +166,95 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>>  }
>>>  
>>> +/*
>>> + * Copy the AER capability registers using 32 bit read accesses.
>>> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>>> + * status after copying.
>>> + *
>>> + * @aer_base: base address of AER capability block in RCRB
>>> + * @aer_regs: destination for copying AER capability
>>> + */
>>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>> +				 struct aer_capability_regs *aer_regs)
>>> +{
>>> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>>> +	u32 *aer_regs_buf = (u32 *)aer_regs;
>>> +	int n;
>>> +
>>> +	if (!aer_base)
>>> +		return false;
>>> +
>>> +	/* Use readl() to guarantee 32-bit accesses */
>>> +	for (n = 0; n < read_cnt; n++)
>>> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>>> +
>>> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>>> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +/* Get AER severity. Return false if there is no error. */
>>> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>> +				     int *severity)
>>> +{
>>> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>>> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>>> +			*severity = AER_FATAL;
>>> +		else
>>> +			*severity = AER_NONFATAL;
>>> +		return true;
>>> +	}
>>> +
>>> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>>> +		*severity = AER_CORRECTABLE;
>>> +		return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> +	struct aer_capability_regs aer_regs;
>>> +	struct cxl_dport *dport;
>>> +	int severity;
>>> +
>>> +	struct cxl_port *port __free(put_cxl_port) =
>>> +		cxl_pci_find_port(pdev, &dport);
>>> +	if (!port)
>>> +		return;
>>> +
>>> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>> +		return;
>>> +
>>> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>>> +		return;
>>> +
>>> +	pci_print_aer(pdev, severity, &aer_regs);
>>> +	if (severity == AER_CORRECTABLE)
>>> +		cxl_handle_cor_ras(cxlds, dport->regs.ras);
>>> +	else
>>> +		cxl_handle_ras(cxlds, dport->regs.ras);
>>> +}
>>> +#else
>>> +static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>>> +static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>>> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>>> +#endif
>>> +
>>> +static void cxl_dport_map_ras(struct cxl_dport *dport)
>>> +{
>>> +	struct cxl_register_map *map = &dport->reg_map;
>>> +	struct device *dev = dport->dport_dev;
>>> +
>>> +	if (!map->component_map.ras.valid)
>>> +		dev_dbg(dev, "RAS registers not found\n");
>>> +	else if (cxl_map_component_regs(map, &dport->regs.component,
>>> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> +		dev_dbg(dev, "Failed to map RAS capability.\n");
>>> +}
>>>  
>>>  /**
>>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>> @@ -270,79 +348,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>>>  	return true;
>>>  }
>>>  
>>> -/*
>>> - * Copy the AER capability registers using 32 bit read accesses.
>>> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>>> - * status after copying.
>>> - *
>>> - * @aer_base: base address of AER capability block in RCRB
>>> - * @aer_regs: destination for copying AER capability
>>> - */
>>> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>> -				 struct aer_capability_regs *aer_regs)
>>> -{
>>> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>>> -	u32 *aer_regs_buf = (u32 *)aer_regs;
>>> -	int n;
>>> -
>>> -	if (!aer_base)
>>> -		return false;
>>> -
>>> -	/* Use readl() to guarantee 32-bit accesses */
>>> -	for (n = 0; n < read_cnt; n++)
>>> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>>> -
>>> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>>> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>>> -
>>> -	return true;
>>> -}
>>> -
>>> -/* Get AER severity. Return false if there is no error. */
>>> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>> -				     int *severity)
>>> -{
>>> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>>> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>>> -			*severity = AER_FATAL;
>>> -		else
>>> -			*severity = AER_NONFATAL;
>>> -		return true;
>>> -	}
>>> -
>>> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>>> -		*severity = AER_CORRECTABLE;
>>> -		return true;
>>> -	}
>>> -
>>> -	return false;
>>> -}
>>> -
>>> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>> -{
>>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> -	struct aer_capability_regs aer_regs;
>>> -	struct cxl_dport *dport;
>>> -	int severity;
>>> -
>>> -	struct cxl_port *port __free(put_cxl_port) =
>>> -		cxl_pci_find_port(pdev, &dport);
>>> -	if (!port)
>>> -		return;
>>> -
>>> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>> -		return;
>>> -
>>> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>>> -		return;
>>> -
>>> -	pci_print_aer(pdev, severity, &aer_regs);
>>> -	if (severity == AER_CORRECTABLE)
>>> -		cxl_handle_cor_ras(cxlds, dport->regs.ras);
>>> -	else
>>> -		cxl_handle_ras(cxlds, dport->regs.ras);
>>> -}
>>> -
>>>  void cxl_cor_error_detected(struct pci_dev *pdev)
>>>  {
>>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> 


