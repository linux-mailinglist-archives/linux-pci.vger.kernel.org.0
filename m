Return-Path: <linux-pci+bounces-36725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E021B93FAE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 04:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316093AE65D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 02:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693FB26FA57;
	Tue, 23 Sep 2025 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AGQIMRC4"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B39478;
	Tue, 23 Sep 2025 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758593824; cv=none; b=VzQ7fODIpz0vC+oYsbkDHbA0ydZk7fqfrlPfPNnKpRR14Mkcx/yK+RDj3M9OcELXRojBbN5AcCsn/zWiTDoUqvLm7RskDwy4axy8WOmr7nhRKX7mv289/DaUtuqS8jGKOE1DLQR8ejeUBr3McHKsMKJzXHX2ndKv2kWI01Yfe44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758593824; c=relaxed/simple;
	bh=B1zsSF9qe7OEHd2YFH2OlgC0iTuiA8DzMILYXwXr6nc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qx1TqHSvaEsxyKfk6+8AGhuPUP6RHcrHa07wkR0196iG5I6x9zkrrK/ubUjSK/0tMeekVu4UfqMbypO0kLjmUb81aya5kAVwJuV/pNJIPOmlcph7fCPc9jucULBsHZbbOg+COv7+R/VrFKN5VFmb68RZeWKOH8m+HX9EvyKNXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AGQIMRC4; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758593817; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=ZsKqdYHSWavPMgKI1y2o2ldKEM5tkb7kIEHNl5Tl04s=;
	b=AGQIMRC4ELLeBVDjsEKWrVcxqVJ5NAVBh9ZP4RfHIW3vW7GUnywGengltcDW6yU/KyFO2TaEXX1FWVXpV5pYPGnOKViLqWzXCA/VhdSU2xmccfnuxlfBXyyd9oUyEg41RMlyXpVXBnOaz9MpN+2HNFG1KCLHY7iwEn/Gs/lyLF4=
Received: from 30.246.179.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wod5R4q_1758593813 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 10:16:55 +0800
Message-ID: <1f70ddf0-702a-444e-ac81-f2c52fa46f55@linux.alibaba.com>
Date: Tue, 23 Sep 2025 10:16:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v10 2/3] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: rostedt@goodmis.org, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, mattc@purestorage.com, Jonathan.Cameron@huawei.com,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250920060117.866-1-xueshuai@linux.alibaba.com>
 <20250920060117.866-3-xueshuai@linux.alibaba.com>
 <74cc8672-8e21-41e6-1535-2c504d90bbe0@linux.intel.com>
In-Reply-To: <74cc8672-8e21-41e6-1535-2c504d90bbe0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/22 21:06, Ilpo Järvinen 写道:
> On Sat, 20 Sep 2025, Shuai Xue wrote:
> 
>> PCIe link speed degradation directly impacts system performance and
>> often indicates hardware issues such as faulty devices, physical layer
>> problems, or configuration errors.
>>
>> To this end, add a RAS tracepoint to monitor link speed changes,
>> enabling proactive health checks and diagnostic analysis.
>>
>> The following output is generated when a device is hotplugged:
>>
>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable
>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>     irq/51-pciehp-88      [001] .....   381.545386: pcie_link_event: 0000:00:02.0 type:4, reason:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA
>>
>> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Suggested-by: Matthew W Carlis <mattc@purestorage.com>
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/pci/hotplug/pciehp_hpc.c |  3 +-
>>   drivers/pci/pci.c                |  2 +-
>>   drivers/pci/pci.h                | 22 +++++++++++--
>>   drivers/pci/pcie/bwctrl.c        |  4 +--
>>   drivers/pci/probe.c              |  9 +++--
>>   include/linux/pci.h              |  1 +
>>   include/trace/events/pci.h       | 56 ++++++++++++++++++++++++++++++++
>>   7 files changed, 87 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index bcc51b26d03d..ad5f28f6a8b1 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -320,7 +320,8 @@ int pciehp_check_link_status(struct controller *ctrl)
>>   	}
>>   
>>   	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
>> -	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
>> +	__pcie_update_link_speed(ctrl->pcie->port->subordinate, PCIE_HOTPLUG,
>> +				 lnk_status, linksta2);
>>   
>>   	if (!found) {
>>   		ctrl_info(ctrl, "Slot(%s): No device found\n",
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b0f4d98036cd..96755ffd3841 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4749,7 +4749,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
>>   	 * Link Speed.
>>   	 */
>>   	if (pdev->subordinate)
>> -		pcie_update_link_speed(pdev->subordinate);
>> +		pcie_update_link_speed(pdev->subordinate, PCIE_LINK_RETRAIN);
>>   
>>   	return rc;
>>   }
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index b8d364545e7d..422406a0695c 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -3,6 +3,7 @@
>>   #define DRIVERS_PCI_H
>>   
>>   #include <linux/pci.h>
>> +#include <trace/events/pci.h>
>>   
>>   struct pcie_tlp_log;
>>   
>> @@ -455,16 +456,31 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>>   }
>>   
>>   u8 pcie_get_supported_speeds(struct pci_dev *dev);
>> -const char *pci_speed_string(enum pci_bus_speed speed);
>>   void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>>   void pcie_report_downtraining(struct pci_dev *dev);
>>   
>> -static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta, u16 linksta2)
>> +enum pcie_link_change_reason {
>> +	PCIE_LINK_RETRAIN,
>> +	PCIE_ADD_BUS,
>> +	PCIE_BWCTRL_ENABLE,
>> +	PCIE_BWCTRL_IRQ,
>> +	PCIE_HOTPLUG
> 
> Please use comma on any non-terminator entry so that adding to the list
> later will not mess up diffs.

Sure.

> 
>> +};
>> +
>> +static inline void __pcie_update_link_speed(struct pci_bus *bus,
>> +					    enum pcie_link_change_reason reason,
>> +					    u16 linksta, u16 linksta2)
>>   {
>>   	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
>>   	bus->flit_mode = (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
>> +
>> +	trace_pcie_link_event(bus,
>> +			     reason,
>> +			     FIELD_GET(PCI_EXP_LNKSTA_NLW, linksta),
>> +			     linksta & PCI_EXP_LNKSTA_LINK_STATUS_MASK);
>>   }
>> -void pcie_update_link_speed(struct pci_bus *bus);
>> +
>> +void pcie_update_link_speed(struct pci_bus *bus, enum pcie_link_change_reason reason);
>>   
>>   /* Single Root I/O Virtualization */
>>   struct pci_sriov {
>> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
>> index 36f939f23d34..32f1b30ecb84 100644
>> --- a/drivers/pci/pcie/bwctrl.c
>> +++ b/drivers/pci/pcie/bwctrl.c
>> @@ -199,7 +199,7 @@ static void pcie_bwnotif_enable(struct pcie_device *srv)
>>   	 * Update after enabling notifications & clearing status bits ensures
>>   	 * link speed is up to date.
>>   	 */
>> -	pcie_update_link_speed(port->subordinate);
>> +	pcie_update_link_speed(port->subordinate, PCIE_BWCTRL_ENABLE);
>>   }
>>   
>>   static void pcie_bwnotif_disable(struct pci_dev *port)
>> @@ -234,7 +234,7 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>>   	 * speed (inside pcie_update_link_speed()) after LBMS has been
>>   	 * cleared to avoid missing link speed changes.
>>   	 */
>> -	pcie_update_link_speed(port->subordinate);
>> +	pcie_update_link_speed(port->subordinate, PCIE_BWCTRL_IRQ);
>>   
>>   	return IRQ_HANDLED;
>>   }
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index f41128f91ca7..c4cae2664156 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/irqdomain.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/bitfield.h>
>> +#include <trace/events/pci.h>
>>   #include "pci.h"
>>   
>>   #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
>> @@ -788,14 +789,16 @@ const char *pci_speed_string(enum pci_bus_speed speed)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_speed_string);
>>   
>> -void pcie_update_link_speed(struct pci_bus *bus)
>> +void pcie_update_link_speed(struct pci_bus *bus,
>> +			    enum pcie_link_change_reason reason)
>>   {
>>   	struct pci_dev *bridge = bus->self;
>>   	u16 linksta, linksta2;
>>   
>>   	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
>>   	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA2, &linksta2);
>> -	__pcie_update_link_speed(bus, linksta, linksta2);
>> +
>> +	__pcie_update_link_speed(bus, reason, linksta, linksta2);
>>   }
>>   EXPORT_SYMBOL_GPL(pcie_update_link_speed);
>>   
>> @@ -882,7 +885,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
>>   		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
>>   		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
>>   
>> -		pcie_update_link_speed(bus);
>> +		pcie_update_link_speed(bus, PCIE_ADD_BUS);
>>   	}
>>   }
>>   
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 59876de13860..edd8a61ec44e 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -305,6 +305,7 @@ enum pci_bus_speed {
>>   	PCI_SPEED_UNKNOWN		= 0xff,
>>   };
>>   
>> +const char *pci_speed_string(enum pci_bus_speed speed);
>>   enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>>   enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
>>   
>> diff --git a/include/trace/events/pci.h b/include/trace/events/pci.h
>> index 208609492c06..78e651b95cb3 100644
>> --- a/include/trace/events/pci.h
>> +++ b/include/trace/events/pci.h
>> @@ -57,6 +57,62 @@ TRACE_EVENT(pci_hp_event,
>>   	)
>>   );
>>   
>> +#define PCI_EXP_LNKSTA_LINK_STATUS_MASK (PCI_EXP_LNKSTA_LBMS | \
>> +					 PCI_EXP_LNKSTA_LABS | \
>> +					 PCI_EXP_LNKSTA_LT | \
>> +					 PCI_EXP_LNKSTA_DLLLA)
> 
> This looks fragile because of the headers, I don't think there anything
> that pulls these required defines within this header itself (so it only
> works because the .c files have the pci.h include before it so that that
> the defines from uapi side will be include).
> 
> If it's allowed for these files, you should include uapi/linux/pci_regs.h.
> 

Thanks for pointing out this dependency issue. You're absolutely right.

I'll add the explicit include for uapi/linux/pci_regs.h at the top of
the trace header file to ensure the PCI register macros are always
available, regardless of inclusion order.

Will fix this in next version.

Thanks.
Shuai

