Return-Path: <linux-pci+bounces-44326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEBCD07622
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 07:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21862303837C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 06:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC5296BBF;
	Fri,  9 Jan 2026 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BGLzTK6Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com [117.135.214.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129A28506B;
	Fri,  9 Jan 2026 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767939746; cv=none; b=RWnf2OJ7C1xojhgsUvBTyX7Hhn+qB9O9ywBiABMWAdA/BPF1002Ifvfn7qgkTts51LFxJ5q9VNEe/s5GEAdQm9SCNkaBuMIWCKEwBVOtevBvLR8ij89YyOaGY9oWOMk36iiNPF73a9wHvgGtezleTYfF2izpbXbwjR4oebcL6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767939746; c=relaxed/simple;
	bh=Wty9H0UnmPdr2z7gdWU7XScrqhg5D9w7XjlVUCC9NjE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zzqfu0TellcI0ht54ks+XxSRatR0eFu9QbTSQ+dB8ux85Hi1KZ92J0VtSDzJiTDiRyMCapS6YBkIY1rhc36T00LLKvY/+zGNb6ZMicZXs76EkASB7tpMEJ+S3bM1qiTadHhZuhn4l7h1E0GhDXqIafrE2hwtS3WUXa08PG9AhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BGLzTK6Q; arc=none smtp.client-ip=117.135.214.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 300cbf6a5;
	Fri, 9 Jan 2026 14:22:11 +0800 (GMT+08:00)
Message-ID: <dddbcb37-68d4-4ccb-9897-b1e5a4b41be7@rock-chips.com>
Date: Fri, 9 Jan 2026 14:22:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition
 trace support
To: Manivannan Sadhasivam <mani@kernel.org>
References: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
 <1767929389-143957-4-git-send-email-shawn.lin@rock-chips.com>
 <uev63wla4msmmhww4j3t2jim7lhvxjikvujwpxiblg5mz7jwwa@2jucxkbtcsfm>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <uev63wla4msmmhww4j3t2jim7lhvxjikvujwpxiblg5mz7jwwa@2jucxkbtcsfm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ba16b709409cckunm3a5211faa0570
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtKH1YfT0lCGBgaTkJOSENWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BGLzTK6QoCvwxHdMC1RRW6dwY43TnaJqrY/cL2NiL+N3UDZiUZZkpLfB+wOFJguwyghTMd6I5LxWg42RWci9IFmQFRt5CCAJHpQSnz22gpW4kDyi1azGmcmanaOE9q+rqMuOxYscUi4mnMgr+b74zNtgv/6GksxboCnE8uIF9N4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=fusigJkE09jP1amE7Q6yCbc178kexJW7rrHRQizLPt8=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/09 星期五 13:55, Manivannan Sadhasivam 写道:
> On Fri, Jan 09, 2026 at 11:29:49AM +0800, Shawn Lin wrote:
>> Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
>> LTSSM history. Any LTSSM change will be recorded. It's userful
>> for debug purpose, for example link failure, etc.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - use tracepoint
>>
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 92 +++++++++++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index 352f513..be9639aa 100644
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
>> @@ -73,6 +75,18 @@
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
>> +#define PCIE_DBG_LTSSM_HISTORY_CNT	64
>> +
>>   /* Hot Reset Control Register */
>>   #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>>   #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
>> @@ -96,6 +110,7 @@ struct rockchip_pcie {
>>   	struct irq_domain *irq_domain;
>>   	const struct rockchip_pcie_of_data *data;
>>   	bool supports_clkreq;
>> +	struct delayed_work trace_work;
>>   };
>>   
>>   struct rockchip_pcie_of_data {
>> @@ -206,6 +221,79 @@ static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
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
>> +	u32 val, rate, l1ss, loop, prev_val = DW_PCIE_LTSSM_UNKNOWN;
> 
> Reverse Xmas order please.
> 
>> +
>> +	for (loop = 0; loop < PCIE_DBG_LTSSM_HISTORY_CNT; loop++) {
> 
> s/loop/i?
> 
>> +		val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_DBG_FIFO_STATUS);
>> +		rate = (val & GENMASK(22, 20)) >> 20;
>> +		l1ss = (val & GENMASK(10, 8)) >> 8;
>> +		val &= PCIE_LTSSM_STATUS_MASK;
> 
> Can you use FIELD_ macros here?
> 
>> +
>> +		/* Two consecutive identical LTSSM means invalid subsequent data */
> 
> Interesting. Does the hardware maintain a counter to track the reads? So once
> you break out of the loop and read it after 5s, you'll start from where you left
> i.e., the duplicate entry or from the start of the counter again?
> 

Yes, the ring FIFO maintains counters for recording both of 
last-read-point for user to continue to read, and last-valid-point for 
HW to
continue to update transition state. So we could start from where we
left.

>> +		if ((loop > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
>> +			break;
>> +
>> +		state = prev_val = val;
>> +		if (val == DW_PCIE_LTSSM_L1_IDLE) {
>> +			if (l1ss == 2)
>> +				state = DW_PCIE_LTSSM_L1_2;
>> +			else if (l1ss == 1)
>> +				state = DW_PCIE_LTSSM_L1_1;
> 
> I believe L1.0 is not supported.
> 

I'm not sure I follow this comment. state is DW_PCIE_LTSSM_L1_IDLE
（L1.0） if l1ss is neither 1 nor 2.

>> +		}
>> +
>> +		trace_pcie_ltssm_state_transition(dev_name(pci->dev),
>> +					dw_pcie_ltssm_status_string(state),
>> +					((rate + 1) > pci->max_link_speed) ?
>> +					PCI_SPEED_UNKNOWN : PCIE_SPEED_2_5GT + rate);
>> +	}
>> +
>> +	schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
>> +}
>> +
>> +static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
>> +				      bool en)
> 
> s/en/enable
> 
> - Mani
> 


