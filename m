Return-Path: <linux-pci+bounces-39287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FADDC07836
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 19:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDF13A3ED5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB432AACA;
	Fri, 24 Oct 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/spX9wL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8A1329C6A;
	Fri, 24 Oct 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326116; cv=none; b=sMFH54TeiArGjcT1Sb6LJzHOqfNuuUL0RbLSAUhNLL064P7xs34bhTbA1R5192+RMUFNSJT/acfpMA8KKUuwHwfwz7oMfIEZBqdCoNFlpl4CjeynQ9vtKLGcw/RbDrpC69W17M2J0T7rxNqsxlrR9UM4i3j2QTE0IfdTQfCejxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326116; c=relaxed/simple;
	bh=+ClohS40EsCnl1jkg5AVYI8a/qMq4Dgk6t8q+Sm9ogc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZassKuW3QZ2LjcSbAJoAkp5Sja46FB4A+gAmEPYPcOZCXmVKAtutjBGzxGH0WF9goONcScIV9O2f7pS1Sbnimki+Kkmyqujfl2WmBNSkCXsVZ/7l3srFGkSRnUANMr24z46Cz6JIjndDNO/uVncdDdZvRlkZUedMBmCPLQUqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/spX9wL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761326114; x=1792862114;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+ClohS40EsCnl1jkg5AVYI8a/qMq4Dgk6t8q+Sm9ogc=;
  b=M/spX9wLUTSjMDtfD5t1vGIU6y1kc0bvoa1LGo9P8pSBWwbT9G9gMNnq
   Ju5EO2CdW/ROrcATEI72Dusz5P3BtVKLZYLrJldf6aSAaN2cHx3avzP2g
   lqinuLmHqH4EVNBLOrfi33CYPcGpKlo5Cu4PSHTWkO3gtE0sfs0i/+1gn
   Fyo16NLTrFedFq0uwjPoBcT3RFx1vHfjc56caFSEcK+pwM92fPHjuwe3P
   LkeK/1FhUa0ilTqJCYuacD1gKaxOpoM3gDRY1I2d8S1OuiWIc8ApHQQje
   Av2Irdu5C7TXScbKYV7Fye7R5ReX3Lrtdm9mT6PntIonDFaqVyDRvCXzk
   Q==;
X-CSE-ConnectionGUID: D8cBgNrORcai2qAKLTQjkQ==
X-CSE-MsgGUID: 4FUkUVAgRt6YNbPdWcietA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80944030"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="80944030"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 10:15:13 -0700
X-CSE-ConnectionGUID: sn3p5HdfSMyBETtiKMJWoQ==
X-CSE-MsgGUID: bSsE9ib5SiqsTvltcXtWRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="185245942"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.43]) ([10.125.109.43])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 10:15:11 -0700
Message-ID: <ae492c92-81c8-49bb-9be9-a61952b15d3a@intel.com>
Date: Fri, 24 Oct 2025 10:15:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/25] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-16-terry.bowman@amd.com>
 <883ee74a-0f11-414e-be62-1d5bdbfb1edd@intel.com>
 <2f5d7017-d49c-4358-b12c-0cd00b229f2c@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <2f5d7017-d49c-4358-b12c-0cd00b229f2c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/24/25 3:25 AM, Alejandro Lucero Palau wrote:
> 
> On 9/26/25 22:10, Dave Jiang wrote:
>>
>> On 9/25/25 3:34 PM, Terry Bowman wrote:
>>> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
>>> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
>>> mapping to enable RAS logging. This initialization is currently missing and
>>> must be added for CXL RPs and DSPs.
>>>
>>> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
>>> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
>>>
>>> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
>>> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
>>> created and added to the EP port.
>>>
>>> Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
>>> Upstream Port's CXL capabilities' physical location to be used in mapping
>>> the RAS registers.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>
>>> ---
>>>
>>> Changes in v11->v12:
>>> - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
>>> RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().
>>>
>>> Changes in v10->v11:
>>> - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
>>> - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
>>> - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
>>>    and cxl_switch_port_init_ras() (Dave Jiang)
>>> - Port helper changes were in cxl/port.c, now in core/ras.c (Dave
>>> Jiang)
>>> ---
>>>   drivers/cxl/core/core.h |  7 ++++++
>>>   drivers/cxl/core/port.c |  1 +
>>>   drivers/cxl/core/ras.c  | 48 +++++++++++++++++++++++++++++++++++++++++
>>>   drivers/cxl/cxl.h       |  2 ++
>>>   drivers/cxl/cxlpci.h    |  4 ----
>>>   drivers/cxl/mem.c       |  4 +++-
>>>   drivers/cxl/port.c      |  5 +++++
>>>   7 files changed, 66 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>> index 9f4eb7e2feba..8c51a2631716 100644
>>> --- a/drivers/cxl/core/core.h
>>> +++ b/drivers/cxl/core/core.h
>>> @@ -147,6 +147,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>>>   #ifdef CONFIG_CXL_RAS
>>>   int cxl_ras_init(void);
>>>   void cxl_ras_exit(void);
>>> +void cxl_switch_port_init_ras(struct cxl_port *port);
>>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep);
>>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>>   #else
>>>   static inline int cxl_ras_init(void)
>>>   {
>>> @@ -156,6 +159,10 @@ static inline int cxl_ras_init(void)
>>>   static inline void cxl_ras_exit(void)
>>>   {
>>>   }
>>> +static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
>>> +static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
>>> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>> +                        struct device *host) { }
>>>   #endif // CONFIG_CXL_RAS
>>>     int cxl_gpf_port_setup(struct cxl_dport *dport);
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index d5f71eb1ade8..bd4be046888a 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -870,6 +870,7 @@ static int cxl_port_add(struct cxl_port *port,
>>>               return rc;
>>>             port->component_reg_phys = component_reg_phys;
>>> +        cxl_port_setup_regs(port, port->component_reg_phys);
>> This was actually moved previously to delay the port register probe. It now happens when the first dport is discovered. See the end of __devm_cxl_add_dport().
> 
> 
> FWIW (other people not going through my discovery path :-) ) Dave is pointing out to his patchset for delaying port probing and now applied to next.

It's in 6.18-rc now.

DJ

> 
> 
> Terry, any estimation of when your next version will be sent to the list? My Type2 patchset is dependent on yours, so I'll be reviewing it as soon as you do it.
> 
> 
> Thank you
> 
> 
>>>       } else {
>>>           rc = dev_set_name(dev, "root%d", port->id);
>>>           if (rc)
>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>> index 97a5a5c3910f..14a434bd68f0 100644
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> @@ -283,6 +283,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>>   +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>>> +                     struct device *host)
>>> +{
>>> +    struct cxl_register_map *map = &port->reg_map;
>>> +
>>> +    map->host = host;
>>> +    if (cxl_map_component_regs(map, &port->uport_regs,
>>> +                   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> +        dev_dbg(&port->dev, "Failed to map RAS capability\n");
>>> +}
>>> +
>>> +void cxl_switch_port_init_ras(struct cxl_port *port)
>>> +{
>>> +    struct cxl_dport *parent_dport = port->parent_dport;
>>> +
>>> +    if (is_cxl_root(to_cxl_port(port->dev.parent)))
>>> +        return;
>>> +
>>> +    /* May have parent DSP or RP */
>>> +    if (parent_dport && dev_is_pci(parent_dport->dport_dev) &&
>>> +        !parent_dport->rch) {
>>> +        struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
>>> +
>>> +        if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>>> +            (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>>> +            cxl_dport_init_ras_reporting(parent_dport, &port->dev);
>>> +    }
>>> +
>>> +    cxl_uport_init_ras_reporting(port, &port->dev);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_switch_port_init_ras, "CXL");
>>> +
>>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>> +{
>>> +    struct cxl_dport *parent_dport;
>>> +    struct cxl_memdev *cxlmd = to_cxl_memdev(ep->uport_dev);
>>> +    struct cxl_port *parent_port __free(put_cxl_port) =
>>> +        cxl_mem_find_port(cxlmd, &parent_dport);
>>> +
>>> +    if (!parent_dport || !dev_is_pci(parent_dport->dport_dev) || parent_dport->rch) {
>>> +        dev_err(&ep->dev, "CXL port topology not found\n");
>>> +        return;
>>> +    }
>>> +
>>> +    cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>> +
>>>   static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>>   {
>>>       void __iomem *addr;
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 259ed4b676e1..b7654d40dc9e 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -599,6 +599,7 @@ struct cxl_dax_region {
>>>    * @parent_dport: dport that points to this port in the parent
>>>    * @decoder_ida: allocator for decoder ids
>>>    * @reg_map: component and ras register mapping parameters
>>> + * @uport_regs: mapped component registers
>>>    * @nr_dports: number of entries in @dports
>>>    * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>>    * @commit_end: cursor to track highest committed decoder for commit ordering
>>> @@ -620,6 +621,7 @@ struct cxl_port {
>>>       struct cxl_dport *parent_dport;
>>>       struct ida decoder_ida;
>>>       struct cxl_register_map reg_map;
>>> +    struct cxl_component_regs uport_regs;
>>>       int nr_dports;
>>>       int hdm_end;
>>>       int commit_end;
>>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>>> index 0c8b6ee7b6de..3882a089ae77 100644
>>> --- a/drivers/cxl/cxlpci.h
>>> +++ b/drivers/cxl/cxlpci.h
>>> @@ -82,7 +82,6 @@ void read_cdat_data(struct cxl_port *port);
>>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>                       pci_channel_state_t state);
>>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>>   #else
>>>   static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>>>   @@ -91,9 +90,6 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>   {
>>>       return PCI_ERS_RESULT_NONE;
>>>   }
>>> -
>>> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>> -                        struct device *host) { }
>>>   #endif
>>>     #endif /* __CXL_PCI_H__ */
>> I think this change broke cxl_test:
>>
>>    CC [M]  test/mem.o
>> test/mock.c: In function ‘__wrap_cxl_dport_init_ras_reporting’:
>> test/mock.c:266:17: error: implicit declaration of function ‘cxl_dport_init_ras_reporting’ [-Wimplicit-function-declaration]
>>    266 |                 cxl_dport_init_ras_reporting(dport, host);
>>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index 6e6777b7bafb..f7dc0ba8905d 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -7,6 +7,7 @@
>>>     #include "cxlmem.h"
>>>   #include "cxlpci.h"
>>> +#include "core/core.h"
>>>     /**
>>>    * DOC: cxl mem
>>> @@ -166,7 +167,8 @@ static int cxl_mem_probe(struct device *dev)
>>>       else
>>>           endpoint_parent = &parent_port->dev;
>>>   -    cxl_dport_init_ras_reporting(dport, dev);
>>> +    if (dport->rch)
>>> +        cxl_dport_init_ras_reporting(dport, dev);
>>>         scoped_guard(device, endpoint_parent) {
>>>           if (!endpoint_parent->driver) {
>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>> index 51c8f2f84717..2d12890b66fe 100644
>>> --- a/drivers/cxl/port.c
>>> +++ b/drivers/cxl/port.c
>>> @@ -6,6 +6,7 @@
>>>     #include "cxlmem.h"
>>>   #include "cxlpci.h"
>>> +#include "core/core.h"
>>>     /**
>>>    * DOC: cxl port
>>> @@ -65,6 +66,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>>       /* Cache the data early to ensure is_visible() works */
>>>       read_cdat_data(port);
>>>   +    cxl_switch_port_init_ras(port);
>> This is probably not the right place to do it because you have no dports yet with the new delayed dport setup. I would init the uport when the register gets probed in __devm_cxl_add_dport(), and init the dport on per dport basis as they are discovered. So maybe in cxl_port_add_dport(). This is where the old dport stuff in the switch probe got moved to.
>>
>>> +
>>>       return 0;
>>>   }
>>>   @@ -86,6 +89,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>>       if (rc)
>>>           return rc;
>>>   +    cxl_endpoint_port_init_ras(port);
>>> +
>>>       /*
>>>        * Now that all endpoint decoders are successfully enumerated, try to
>>>        * assemble regions from committed decoders


