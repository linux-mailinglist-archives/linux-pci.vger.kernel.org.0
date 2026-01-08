Return-Path: <linux-pci+bounces-44254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86252D01069
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 05:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABE1303E439
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 04:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4FA2C21FE;
	Thu,  8 Jan 2026 04:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jfslcXFa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com [45.254.49.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EF2D0C7A
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848321; cv=none; b=FB+gqMBTkPZN2cqGobBFQZk55Qr2C1qyMRQL1EPvs96/gHDjBJViWG4+jhW9sxsmcX8uGOMiLL3D43HrHlzsYSNfFh2hTb2t86tn4mVELt/i8L0BB/F5SiZ927J1uC+AxWMOGoBwoMqpWEV3R8yHvkHCD3laLu/NJl64Kw2zBqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848321; c=relaxed/simple;
	bh=lXn0pTppSBegGElu6a+FmHnxiShi5VsDZUM/h08hknI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g7wp/9/3TbPSLrsXKPFNWMkmV3+LKzPvyE8yyQ8TmzyGxDU39GJypd4bcjW7ZeP6y6m0QpH2QPpKvdc3LM2+BYhMFw1B+If+GbYSG1Vs/5v07+H+5axvbaMVXVkQ4YoayFCp+PZBSv32VDtwYxu+mrHiJ+MKfCOovDWMfvd49Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jfslcXFa; arc=none smtp.client-ip=45.254.49.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fe7522f0;
	Thu, 8 Jan 2026 12:58:29 +0800 (GMT+08:00)
Message-ID: <70b6e8c9-8dbe-484a-b8a8-aeb7380b6ca2@rock-chips.com>
Date: Thu, 8 Jan 2026 12:58:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add LTSSM tracing support to debugfs
To: Manivannan Sadhasivam <mani@kernel.org>
References: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
 <cudy2lfd7q7tujfivampgciziuho7izkpvmabj3qa2udvzkvfh@lw5vasqcrs6c>
 <2e1a3eff-5d4d-4e3a-a076-ef8a76e08d4c@rock-chips.com>
 <lhshuxj4aztwbernypwgaxkdtxzonzydzipu63mspbqfygyrvy@nggpj7vwsw7n>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <lhshuxj4aztwbernypwgaxkdtxzonzydzipu63mspbqfygyrvy@nggpj7vwsw7n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b9bf8722709cckunme78d4b0088855
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9DTlZLGhpNGU5CSktNHUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jfslcXFa6jn5pFaMTluTyVBwtOti+6+OvcCPz40HECjzDAsdldDI83+NcqjC1SjW+nmB33m9lRMRA2ge/4opej29prXy2MgHsm1qatm7mfsHkLt1v5NDhsRoSkORt2fuKHJklfaargznMpleF5MQQUNu6/2BqsUmAswjR1eQeU4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wTPuu3xgyg0xoYlHD4kMcHX7pKbo2jNhwxG5uBDypg8=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/08 星期四 12:49, Manivannan Sadhasivam 写道:
> On Thu, Jan 08, 2026 at 09:01:43AM +0800, Shawn Lin wrote:
>> 在 2026/01/07 星期三 20:41, Manivannan Sadhasivam 写道:
>>> On Tue, Jan 06, 2026 at 05:18:38PM +0800, Shawn Lin wrote:
>>>> Some platforms may provide LTSSM trace functionality, recording historical
>>>> LTSSM state transition information. This is very useful for debugging, such
>>>> as when certain devices cannot be recognized. Add an ltssm_trace operation
>>>> node in debugfs for platform which could provide these information to show
>>>> the LTSSM history.
>>>>
>>>
>>> Why don't you implement it as a tracepoint since you want to expose traces?
>>>
>>
>> I evaluated this option but didn't choose to do it just as I didn't
>> want to select CONFIG_TRACING_SUPPORT for dwc driver because of this
>> cheap function. But I'm fine to implement it as a tracepoint. Just to
>> make it clear, if a tracepoint is preferred, should I need to create a new
>> file like pcie-designware-trace?
>>
> 
> I would prefer that, because that will allow us to add more tracepoints in the
> future and not muddle pcie-designware.h. General convention is to define
> trace events in a separate header.
> 

I did a quick convention by adding it to the existing 
include/trace/events/pci.h

The TRACE_EVENT is called pcie_ltssm_state_change, making it not just
for dwc-based but for all possible coming host drivers and the output
looks like below. Is that the way you expected?

root@debian:/#echo 1 > 
/sys/kernel/debug/tracing/events/pci/pcie_ltssm_state_change/enable
root@debian:/# cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 572/572   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |

...
      kworker/1:1-109     [001] .....     4.719968: ltssm_state_change: 
dev: a40000000.pcie state: 0x0d rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719969: ltssm_state_change: 
dev: a40000000.pcie state: 0x0f rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719970: ltssm_state_change: 
dev: a40000000.pcie state: 0x10 rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719970: ltssm_state_change: 
dev: a40000000.pcie state: 0x11 rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719971: ltssm_state_change: 
dev: a40000000.pcie state: 0x13 rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719972: ltssm_state_change: 
dev: a40000000.pcie state: 0x14 rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719973: ltssm_state_change: 
dev: a40000000.pcie state: 0x0d rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719973: ltssm_state_change: 
dev: a40000000.pcie state: 0x0f rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719974: ltssm_state_change: 
dev: a40000000.pcie state: 0x10 rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719975: ltssm_state_change: 
dev: a40000000.pcie state: 0x11 rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719975: ltssm_state_change: 
dev: a40000000.pcie state: 0x13 rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719976: ltssm_state_change: 
dev: a40000000.pcie state: 0x14 rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719977: ltssm_state_change: 
dev: a40000000.pcie state: 0x0d rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719977: ltssm_state_change: 
dev: a40000000.pcie state: 0x0f rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719978: ltssm_state_change: 
dev: a40000000.pcie state: 0x10 rate: 8.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719979: ltssm_state_change: 
dev: a40000000.pcie state: 0x11 rate: 5.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719980: ltssm_state_change: 
dev: a40000000.pcie state: 0x13 rate: 5.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719980: ltssm_state_change: 
dev: a40000000.pcie state: 0x14 rate: 5.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719981: ltssm_state_change: 
dev: a40000000.pcie state: 0x0d rate: 5.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719982: ltssm_state_change: 
dev: a40000000.pcie state: 0x0f rate: 5.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719982: ltssm_state_change: 
dev: a40000000.pcie state: 0x10 rate: 5.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719983: ltssm_state_change: 
dev: a40000000.pcie state: 0x11 rate: 5.0 GT/s PCIe
      kworker/1:1-109     [001] .....     4.719984: ltssm_state_change: 
dev: a40000000.pcie state: 0x13 rate: 5.0 GT/s PCIe


> - Mani
> 
>>> - Mani
>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>> ---
>>>>    .../controller/dwc/pcie-designware-debugfs.c  | 44 +++++++++++++++++++
>>>>    drivers/pci/controller/dwc/pcie-designware.h  |  6 +++
>>>>    2 files changed, 50 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>>>> index df98fee69892..569e8e078ef2 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>>>> @@ -511,6 +511,38 @@ static int ltssm_status_open(struct inode *inode, struct file *file)
>>>>    	return single_open(file, ltssm_status_show, inode->i_private);
>>>>    }
>>>> +static struct dw_pcie_ltssm_history *dw_pcie_ltssm_trace(struct dw_pcie *pci)
>>>> +{
>>>> +	if (pci->ops && pci->ops->ltssm_trace)
>>>> +		return pci->ops->ltssm_trace(pci);
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +static int ltssm_trace_show(struct seq_file *s, void *v)
>>>> +{
>>>> +	struct dw_pcie *pci = s->private;
>>>> +	struct dw_pcie_ltssm_history *history;
>>>> +	enum dw_pcie_ltssm val;
>>>> +	u32 loop;
>>>> +
>>>> +	history = dw_pcie_ltssm_trace(pci);
>>>> +	if (!history)
>>>> +		return 0;
>>>> +
>>>> +	for (loop = 0; loop < history->count; loop++) {
>>>> +		val = history->states[loop];
>>>> +		seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ltssm_trace_open(struct inode *inode, struct file *file)
>>>> +{
>>>> +	return single_open(file, ltssm_trace_show, inode->i_private);
>>>> +}
>>>> +
>>>>    #define dwc_debugfs_create(name)			\
>>>>    debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
>>>>    			&dbg_ ## name ## _fops)
>>>> @@ -552,6 +584,11 @@ static const struct file_operations dwc_pcie_ltssm_status_ops = {
>>>>    	.read = seq_read,
>>>>    };
>>>> +static const struct file_operations dwc_pcie_ltssm_trace_ops = {
>>>> +	.open = ltssm_trace_open,
>>>> +	.read = seq_read,
>>>> +};
>>>> +
>>>>    static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>>>>    {
>>>>    	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>>>> @@ -644,6 +681,12 @@ static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>>>>    			    &dwc_pcie_ltssm_status_ops);
>>>>    }
>>>> +static void dwc_pcie_ltssm_trace_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>>>> +{
>>>> +	debugfs_create_file("ltssm_trace", 0444, dir, pci,
>>>> +			    &dwc_pcie_ltssm_trace_ops);
>>>> +}
>>>> +
>>>>    static int dw_pcie_ptm_check_capability(void *drvdata)
>>>>    {
>>>>    	struct dw_pcie *pci = drvdata;
>>>> @@ -922,6 +965,7 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci, enum dw_pcie_device_mode mode)
>>>>    			err);
>>>>    	dwc_pcie_ltssm_debugfs_init(pci, dir);
>>>> +	dwc_pcie_ltssm_trace_debugfs_init(pci, dir);
>>>>    	pci->mode = mode;
>>>>    	pci->ptm_debugfs = pcie_ptm_create_debugfs(pci->dev, pci,
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>>>> index 5cd27f5739f1..0df18995b7fe 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>>> @@ -395,6 +395,11 @@ enum dw_pcie_ltssm {
>>>>    	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>>>>    };
>>>> +struct dw_pcie_ltssm_history {
>>>> +    enum dw_pcie_ltssm *states;
>>>> +    u32 count;
>>>> +};
>>>> +
>>>>    struct dw_pcie_ob_atu_cfg {
>>>>    	int index;
>>>>    	int type;
>>>> @@ -499,6 +504,7 @@ struct dw_pcie_ops {
>>>>    			      size_t size, u32 val);
>>>>    	bool	(*link_up)(struct dw_pcie *pcie);
>>>>    	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
>>>> +	struct dw_pcie_ltssm_history * (*ltssm_trace)(struct dw_pcie *pcie);
>>>>    	int	(*start_link)(struct dw_pcie *pcie);
>>>>    	void	(*stop_link)(struct dw_pcie *pcie);
>>>>    	int	(*assert_perst)(struct dw_pcie *pcie, bool assert);
>>>> -- 
>>>> 2.43.0
>>>>
>>>>
>>>
>>
>>
> 


