Return-Path: <linux-pci+bounces-32576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A1B0AC40
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 00:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E885A776B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BC2222C8;
	Fri, 18 Jul 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0DMcIbJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BD2AD2F;
	Fri, 18 Jul 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878763; cv=none; b=Slx73/rHXzFQczSSLEMqfueOzOBNDQQj4cQizjTmQraKt8WQzonk6kG22xrDKVebYORiF7KkZYcDtcPW+pREmYZ6bLWzCgIy89HVBa5KykcA4nFPkrnmuQ+1MyvY0gZlnb5JbF5Dp1Nzp7mve9F7nEl/Qvlyw4v6IH0uRSTSDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878763; c=relaxed/simple;
	bh=oHxm0Xfc0w15yaafaFPNxKi6bNoFhA3MvxRQFBpawgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImSz9MN53+F0kykeH4L/6+hqY+TaT6HPRvrgxRKuxJlvcyl3ChDKSd8YKjZLlfJKxiJ6M7422ZCsUn/GMVC5UawTe5SJ/xQidOJn4PufHXinzMxLRf94ivTPCeq9tJC+gqmMDp+ZoogaDl+ATh9EtXfaM4n9e0Quqv9dht2GfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0DMcIbJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752878762; x=1784414762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oHxm0Xfc0w15yaafaFPNxKi6bNoFhA3MvxRQFBpawgY=;
  b=W0DMcIbJCog+wLMD2zoidNPvaQRGo7ZhqJ6RgONyC5247pBG9stfkmz4
   dfC+vg8xg+/5ouXaI770gpQXxxaZ/phrAyhNck0BnGjhGPvp/4YH9S/Kq
   iKw7ql81rVJ3yxejynsF2sY9NvLbNTe2jnGyilxbd/tVVDJ128D3e9lM6
   2AAiH/6aJToRN/TzigdZrIKES3EumwY9FgbsvygIdCIFbuGTwGKMKvRow
   Es+pw/d7ajvciqtgiKh35QrPk/sbO3zrSuz/XrefZb7A/3UkqIPSbAmRf
   oN1RB9yATigA638yNw8fO9WI9RChmXjcXQioy/ap55Of1+ZQxvof6DEqx
   g==;
X-CSE-ConnectionGUID: W6yeG6cjQPaHjb1wWSg4fg==
X-CSE-MsgGUID: qkjCj90PQIOjq9jX356J3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54894721"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="54894721"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 15:46:01 -0700
X-CSE-ConnectionGUID: 2aP+kgYrTOGnMFZD/bSgFw==
X-CSE-MsgGUID: c0zHegfQSTKieXXlzjMigQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="163810902"
Received: from unknown (HELO [10.247.118.125]) ([10.247.118.125])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 15:45:52 -0700
Message-ID: <6fb070fc-01f3-469e-9434-775319532c59@intel.com>
Date: Fri, 18 Jul 2025 15:45:46 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/17] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: "Bowman, Terry" <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-10-terry.bowman@amd.com>
 <a5b917d5-126e-48a8-b9c3-91d7bb2466e4@intel.com>
 <164c69a6-fd73-4fc1-990d-37e920582d81@amd.com>
 <0d8f7d31-2356-4c9e-9f2e-4bd070edf1e4@intel.com>
 <5b8c3084-1953-4058-8d2a-6234fc959aa1@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <5b8c3084-1953-4058-8d2a-6234fc959aa1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 3:40 PM, Bowman, Terry wrote:
> On 7/18/2025 5:01 PM, Dave Jiang wrote:
>>
>>
>> On 7/18/25 2:55 PM, Bowman, Terry wrote:
>>>
>>>
>>> On 7/18/2025 4:28 PM, Dave Jiang wrote:
>>>>
>>>> On 6/26/25 3:42 PM, Terry Bowman wrote:
>>>>> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
>>>>> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
>>>>> mapping to enable RAS logging. This initialization is currently missing and
>>>>> must be added for CXL RPs and DSPs.
>>>>>
>>>>> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
>>>>> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
>>>>>
>>>>> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
>>>>> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
>>>>> created and added to the EP port.
>>>>>
>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>> ---
>>>>>  drivers/cxl/cxl.h  |  2 ++
>>>>>  drivers/cxl/mem.c  |  3 ++-
>>>>>  drivers/cxl/port.c | 58 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>>  3 files changed, 61 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>>> index c57c160f3e5e..d696d419bd5a 100644
>>>>> --- a/drivers/cxl/cxl.h
>>>>> +++ b/drivers/cxl/cxl.h
>>>>> @@ -590,6 +590,7 @@ struct cxl_dax_region {
>>>>>   * @parent_dport: dport that points to this port in the parent
>>>>>   * @decoder_ida: allocator for decoder ids
>>>>>   * @reg_map: component and ras register mapping parameters
>>>>> + * @uport_regs: mapped component registers
>>>>>   * @nr_dports: number of entries in @dports
>>>>>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>>>>   * @commit_end: cursor to track highest committed decoder for commit ordering
>>>>> @@ -610,6 +611,7 @@ struct cxl_port {
>>>>>  	struct cxl_dport *parent_dport;
>>>>>  	struct ida decoder_ida;
>>>>>  	struct cxl_register_map reg_map;
>>>>> +	struct cxl_component_regs uport_regs;
>>>>>  	int nr_dports;
>>>>>  	int hdm_end;
>>>>>  	int commit_end;
>>>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>>>> index 6e6777b7bafb..d2155f45240d 100644
>>>>> --- a/drivers/cxl/mem.c
>>>>> +++ b/drivers/cxl/mem.c
>>>>> @@ -166,7 +166,8 @@ static int cxl_mem_probe(struct device *dev)
>>>>>  	else
>>>>>  		endpoint_parent = &parent_port->dev;
>>>>>  
>>>>> -	cxl_dport_init_ras_reporting(dport, dev);
>>>>> +	if (dport->rch)
>>>>> +		cxl_dport_init_ras_reporting(dport, dev);
>>>>>  
>>>>>  	scoped_guard(device, endpoint_parent) {
>>>>>  		if (!endpoint_parent->driver) {
>>>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>>>> index 021f35145c65..b52f82925891 100644
>>>>> --- a/drivers/cxl/port.c
>>>>> +++ b/drivers/cxl/port.c
>>>>> @@ -111,6 +111,17 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>>>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>>>>  }
>>>>>  
>>>>> +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>>>>> +					 struct device *host)
>>>>> +{
>>>>> +	struct cxl_register_map *map = &port->reg_map;
>>>>> +
>>>>> +	map->host = host;
>>>>> +	if (cxl_map_component_regs(map, &port->uport_regs,
>>>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>>>> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>>>>   * @dport: the cxl_dport that needs to be initialized
>>>>> @@ -119,7 +130,6 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>>>>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>>>>  {
>>>>>  	dport->reg_map.host = host;
>>>>> -	cxl_dport_map_ras(dport);
>>>>>  
>>>>>  	if (dport->rch) {
>>>>>  		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>>>>> @@ -127,12 +137,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>>>>  		if (!host_bridge->native_aer)
>>>>>  			return;
>>>>>  
>>>>> +		cxl_dport_map_ras(dport);
>>>>>  		cxl_dport_map_rch_aer(dport);
>>>>>  		cxl_disable_rch_root_ints(dport);
>>>>> +		return;
>>>>>  	}
>>>>> +
>>>>> +	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
>>>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>>>> +		dev_dbg(dport->dport_dev, "Failed to map RAS capability\n");
>>>>> +
>>>>>  }
>>>>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>>>>  
>>>>> +static void cxl_switch_port_init_ras(struct cxl_port *port)
>>>>> +{
>>>>> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
>>>>> +		return;
>>>>> +
>>>>> +	/* May have upstream DSP or RP */
>>>>> +	if (port->parent_dport && dev_is_pci(port->parent_dport->dport_dev)) {
>>>>> +		struct pci_dev *pdev = to_pci_dev(port->parent_dport->dport_dev);
>>>>> +
>>>>> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>>>>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>>>>> +			cxl_dport_init_ras_reporting(port->parent_dport, &port->dev);
>>>>> +	}
>>>>> +
>>>>> +	cxl_uport_init_ras_reporting(port, &port->dev);
>>>>> +}
>>>>> +
>>>>> +static void cxl_endpoint_port_init_ras(struct cxl_port *port)
>>>> Maybe rename 'port' to 'ep' to be explicit
>>> Ok
>>>>> +{
>>>>> +	struct cxl_dport *dport;
>>>> parent_dport would be clearer. I was thinking why does the endpoint have a dport for a second there.
>>> Ok
>>>>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>>>>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>>>>> +		cxl_mem_find_port(cxlmd, &dport);
>>>>> +
>>>>> +	if (!dport || !dev_is_pci(dport->dport_dev)) {
>>>>> +		dev_err(&port->dev, "CXL port topology not found\n");> +		return;
>>>>> +	}
>>>>> +
>>>>> +	cxl_dport_init_ras_reporting(dport, cxlmd->cxlds->dev);
>>>>> +}
>>>>> +
>>>>> +#else
>>>>> +static void cxl_endpoint_port_init_ras(struct cxl_port *port) { }
>>>>> +static void cxl_switch_port_init_ras(struct cxl_port *port) { }
>>>>>  #endif /* CONFIG_PCIEAER_CXL */
>>>> I cc'd you on the new patch to move all the AER stuff to core/pci_aer.c. That should take care of ifdef CONFIG_PCIEAER_CXL in pci.c and port.c.
>>>>
>>>> DJ
>>>
>>> Move to core/native_ras.c introduced in "Dequeue forwarded CXL error", right? I just want to be certain.
>>
>> I just posted this [1] to clean up what's there. Do you prefer me to just rename the file to native_ras.c? Or maybe pci_ras.c?
>>
>> [1]: https://lore.kernel.org/linux-cxl/20250718212452.2100663-1-dave.jiang@intel.com/
>>
>> DJ
>>
> 
> Hi Dave,
> 
> I think leaving as you have it is fine. 
> 
> Would you like to see my v10 changes in core/native_ras.c stay as-is or move into pci_aer.c?

Yes. Let's move it all to pci_aer.c in v11 if no one objects to my changes. Thanks!

DJ

> 
> -Terry
> 
>>>
>>> Regards,
>>> Terry
>>>
>>>>>  >  static int cxl_switch_port_probe(struct cxl_port *port)
>>>>> @@ -149,6 +201,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>>>>  
>>>>>  	cxl_switch_parse_cdat(port);
>>>>>  
>>>>> +	cxl_switch_port_init_ras(port);
>>>>> +
>>>>>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>>>>>  	if (!IS_ERR(cxlhdm))
>>>>>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>>>>> @@ -203,6 +257,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>>>>  	if (rc)
>>>>>  		return rc;
>>>>>  
>>>>> +	cxl_endpoint_port_init_ras(port);
>>>>> +
>>>>>  	/*
>>>>>  	 * Now that all endpoint decoders are successfully enumerated, try to
>>>>>  	 * assemble regions from committed decoders
>>>
>>
> 
> 


