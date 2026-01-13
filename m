Return-Path: <linux-pci+bounces-44582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8DAD16920
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 04:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEFE93016CCB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 03:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9C93101C5;
	Tue, 13 Jan 2026 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="arlC/2hp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com [45.254.49.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300F3126A5;
	Tue, 13 Jan 2026 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276528; cv=none; b=B78J90gxaYvUypwqf0vpphRefjEuvarcyCZ2jGs7QY6za0gatmUWbP03t8FXtMWMOXE+mFweLl75GNVS0I/GBdqRwHLukUV8kxyRcMFJlt/QPlsIGs5j+Cgy/h7yglCA7E4+6yb36k3UZr+bMiI0enRuRnJNUcGZ/IEXg/BqR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276528; c=relaxed/simple;
	bh=EHNqyewQacUvW1Ibjpfbw+396u5i06O1R0vbwIlKdZo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PNRIUckc5dlr7c37zCBltrbuCJMeKtOrH05cTsUrB9PTy5FEnwVicGft9hZ+cCDRlHkY6vMrkXAmLvTiYI6jIlkIOT00ktUgRwEKoH2flQhvLsf3eSac4cLPstGMcazIsF0fiUdD87VcA3T+mxjkvAe51JYIn3Wf584tWuZf4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=arlC/2hp; arc=none smtp.client-ip=45.254.49.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 306b4e5b4;
	Tue, 13 Jan 2026 11:55:14 +0800 (GMT+08:00)
Message-ID: <02b530b1-93e2-4bd3-9d29-a009c24eb3e3@rock-chips.com>
Date: Tue, 13 Jan 2026 11:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition
 trace support
To: Steven Rostedt <rostedt@goodmis.org>
References: <1768180800-63364-1-git-send-email-shawn.lin@rock-chips.com>
 <1768180800-63364-4-git-send-email-shawn.lin@rock-chips.com>
 <20260112101644.5c1b772a@gandalf.local.home>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260112101644.5c1b772a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bb57e572c09cckunm550ec7913638ae
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlMGVZMSh1CSh1IThlDGE1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=arlC/2hpapH734Cab1zvf2Yb8LMjgLHJIrMyDRwen7eggJ6RsaiEC9o213XgQ9SFECTFfN1sVLYvfcJ+imAsWTGCeOaE9mAk0+BJlVGrcjtjASneRg8gYUEBkTvEbCJxVSHjy/K7K5PF2xHD0UUk5J/y1tlZ6CSNqqlLVteGm6M=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=97V1F7S4KJ+9mZWTw8AYWTllOD9spM17YItPb7AVlu0=;
	h=date:mime-version:subject:message-id:from;

Hi Steven,

在 2026/01/12 星期一 23:16, Steven Rostedt 写道:
> On Mon, 12 Jan 2026 09:20:00 +0800
> Shawn Lin <shawn.lin@rock-chips.com> wrote:
> 
>> Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
>> LTSSM history. Any LTSSM change will be recorded. It's userful
>> for debug purpose, for example link failure, etc.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v3:
>> - reorder variables(Mani)
>> - rename loop to i; rename en to enable(Mani)
>> - use FIELD_GET(Mani)
>> - add comment about how the FIFO works(Mani)
>>
>> Changes in v2:
>> - use tracepoint
>>
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 104 ++++++++++++++++++++++++++
>>   1 file changed, 104 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index 352f513..344e0b9 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -22,6 +22,8 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>>   #include <linux/reset.h>
>> +#include <linux/workqueue.h>
>> +#include <trace/events/pci_controller.h>
>>   
>>   #include "../../pci.h"
>>   #include "pcie-designware.h"
>> @@ -73,6 +75,20 @@
>>   #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
>>   #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_2	BIT(5)
>>   
>> +/* Debug FIFO information */
>> +#define PCIE_CLIENT_DBG_FIFO_MODE_CON	0x310
>> +#define  PCIE_CLIENT_DBG_EN		0xffff0007
>> +#define  PCIE_CLIENT_DBG_DIS		0xffff0000
>> +#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0	0x320
>> +#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1	0x324
>> +#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0	0x328
>> +#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1	0x32c
>> +#define  PCIE_CLIENT_DBG_TRANSITION_DATA 0xffff0000
>> +#define PCIE_CLIENT_DBG_FIFO_STATUS	0x350
>> +#define  PCIE_DBG_FIFO_RATE_MASK	GENMASK(22, 20)
>> +#define  PCIE_DBG_FIFO_L1SUB_MASK	GENMASK(10, 8)
>> +#define PCIE_DBG_LTSSM_HISTORY_CNT	64
>> +
>>   /* Hot Reset Control Register */
>>   #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>>   #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
>> @@ -96,6 +112,7 @@ struct rockchip_pcie {
>>   	struct irq_domain *irq_domain;
>>   	const struct rockchip_pcie_of_data *data;
>>   	bool supports_clkreq;
>> +	struct delayed_work trace_work;
>>   };
>>   
>>   struct rockchip_pcie_of_data {
>> @@ -206,6 +223,89 @@ static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
>>   	return rockchip_pcie_get_ltssm_reg(rockchip) & PCIE_LTSSM_STATUS_MASK;
>>   }
>>   
>> +#ifdef CONFIG_TRACING
>> +static void rockchip_pcie_ltssm_trace_work(struct work_struct *work)
>> +{
>> +	struct rockchip_pcie *rockchip = container_of(work, struct rockchip_pcie,
>> +						trace_work.work);
>> +	struct dw_pcie *pci = &rockchip->pci;
>> +	enum dw_pcie_ltssm state;
>> +	u32 i, l1ss, prev_val = DW_PCIE_LTSSM_UNKNOWN, rate, val;
>> +
>> +	for (i = 0; i < PCIE_DBG_LTSSM_HISTORY_CNT; i++) {
>> +		val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_DBG_FIFO_STATUS);
>> +		rate = FIELD_GET(PCIE_DBG_FIFO_RATE_MASK, val);
>> +		l1ss = FIELD_GET(PCIE_DBG_FIFO_L1SUB_MASK, val);
>> +		val = FIELD_GET(PCIE_LTSSM_STATUS_MASK, val);
>> +
>> +		/*
>> +		 * Hardware Mechanism: The ring FIFO employs two tracking counters:
>> +		 * - 'last-read-point': maintains the user's last read position
>> +		 * - 'last-valid-point': tracks the hardware's last state update
>> +		 *
>> +		 * Software Handling: When two consecutive LTSSM states are identical,
>> +		 * it indicates invalid subsequent data in the FIFO. In this case, we
>> +		 * skip the remaining entries. The dual-counter design ensures that on
>> +		 * the next state transition, reading can resume from the last user
>> +		 * position.
>> +		 */
>> +		if ((i > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
>> +			break;
>> +
>> +		state = prev_val = val;
>> +		if (val == DW_PCIE_LTSSM_L1_IDLE) {
>> +			if (l1ss == 2)
>> +				state = DW_PCIE_LTSSM_L1_2;
>> +			else if (l1ss == 1)
>> +				state = DW_PCIE_LTSSM_L1_1;
>> +		}
>> +
>> +		trace_pcie_ltssm_state_transition(dev_name(pci->dev),
>> +					dw_pcie_ltssm_status_string(state),
>> +					((rate + 1) > pci->max_link_speed) ?
>> +					PCI_SPEED_UNKNOWN : PCIE_SPEED_2_5GT + rate);
>> +	}
> 
> Does it make sense to call this work function every 5 seconds when the
> tracepoint isn't enabled?
> 

That's a good question. We don't need to read fifo and call
trace_pcie_ltssm_state_transition if tracepoint isn't enabled.
Will improve in v4.

> You can add a function callback to when the tracepoint is enabled by defining:
> 
> TRACE_EVENT_FN(<name>
>   TP_PROTO(..)
>   TP_ARGS(..)
>   TP_STRUCT__entry(..)
>   TP_fast_assign(..)
>   TP_printk(..)
> 
>   reg,
>   unreg)
> 
> reg() gets called when the tracepoint is first enabled. This could be where
> you can start the work function. And unreg() would stop it.
> 

As how to start/stop it may vary from host to host, so I think we could
use reg()/unreg() to set a status to indicate whether this tracepoint is
enabled. Then the host drivers could decide how to implement trace work
based on it.

> You would likely need to also include state variables as I guess you don't
> want to start it if the link is down. Also, if the tracepoint is enabled
> when the link goes up you want to start the work queue.


Frankly, I do want to start it if the link is down as the link may come
up later and that will make us able to dump the transition in time.

> 
> I would recommend this so that you don't call this work function when it's
> not doing anything useful.

Sure, very appreciate your suggestion.

Thanks.

> 
> -- Steve
> 
>   
> 
>> +
>> +	schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
>> +}
>> +
> 


