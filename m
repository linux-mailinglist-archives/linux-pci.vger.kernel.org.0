Return-Path: <linux-pci+bounces-44161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B5ECFD191
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACE8F30E469B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F21B212542;
	Wed,  7 Jan 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UKq1DGST"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731112.qiye.163.com (mail-m19731112.qiye.163.com [220.197.31.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA8217F24
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779194; cv=none; b=mtIu8mI1wHNiij9SqhlPMBvB8daOuYyGMpEzODNSRkp3Oc9+xop332UvxmShRXgW9dq//lFJONdzkzSG7fzra+edEx6M9gE/+8CRhihiSf0cXytY1lur5UZlRjXQYBlZb92KapFWBc7X0qCnaolb/hyznUNtZu+mZlZWLIRXL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779194; c=relaxed/simple;
	bh=//9ADedbLyfcUw1duZOdbEAkFUsZwJwkxjwXrCKI2XU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=muaSDnBmKVLxWb9aZDuhL42zQiUJYBSm61PT1PoUr9kY6dExhauT2WpT4HVYHqpHXJbqwz/NJBrmr00P2BANGPZoixzmzk+j5RcehnginAMqdRYNBErNZCf9IYWGSIo3BmWs3rvDskjMg23ZmO+loFG+YD2dYvsg7aFJuBTwiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UKq1DGST; arc=none smtp.client-ip=220.197.31.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2fcf0e560;
	Wed, 7 Jan 2026 17:41:14 +0800 (GMT+08:00)
Message-ID: <014d034f-998d-466c-9c73-181297de83ba@rock-chips.com>
Date: Wed, 7 Jan 2026 17:41:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add LTSSM tracing support to debugfs
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
 <8d4e73f5-b4da-4aca-a2b2-b607be8c245a@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <8d4e73f5-b4da-4aca-a2b2-b607be8c245a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b97d4f39b09cckunm99824e1a8eb6a8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk0dTFZKGB9NSktPHkseHU5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UKq1DGSTutbU6hXV6fSMiAZs2lGy14VI5OiPeb0/nltUsCXOiUIeL/eKeEqtDSm8hovSMUG4wgFBx9pbyGb0mGkfQfw90XPswnXY4zNbHGMXAkxM9BFt70HAZWkF8j5ze4v9CyBhSnDFW/ESQowyRboBgGXA3JREsCntKt8pOHg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Tn+b1s6Nv5FIXs5nHNOp+r/XH3TXSbuK50ANRcqCEDQ=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/07 星期三 17:12, Krishna Chaitanya Chundru 写道:
> 
> 
> On 1/6/2026 2:48 PM, Shawn Lin wrote:
>> Some platforms may provide LTSSM trace functionality, recording 
>> historical
>> LTSSM state transition information. This is very useful for debugging, 
>> such
>> as when certain devices cannot be recognized. Add an ltssm_trace 
>> operation
>> node in debugfs for platform which could provide these information to 
>> show
>> the LTSSM history.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>   .../controller/dwc/pcie-designware-debugfs.c  | 44 +++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h  |  6 +++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/ 
>> drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> index df98fee69892..569e8e078ef2 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> @@ -511,6 +511,38 @@ static int ltssm_status_open(struct inode *inode, 
>> struct file *file)
>>       return single_open(file, ltssm_status_show, inode->i_private);
>>   }
>> +static struct dw_pcie_ltssm_history *dw_pcie_ltssm_trace(struct 
>> dw_pcie *pci)
>> +{
>> +    if (pci->ops && pci->ops->ltssm_trace)
>> +        return pci->ops->ltssm_trace(pci);
>> +
>> +    return NULL;
>> +}
>> +
>> +static int ltssm_trace_show(struct seq_file *s, void *v)
>> +{
>> +    struct dw_pcie *pci = s->private;
>> +    struct dw_pcie_ltssm_history *history;
>> +    enum dw_pcie_ltssm val;
>> +    u32 loop;
>> +
>> +    history = dw_pcie_ltssm_trace(pci);
>> +    if (!history)
>> +        return 0;
>> +
>> +    for (loop = 0; loop < history->count; loop++) {
>> +        val = history->states[loop];
>> +        seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int ltssm_trace_open(struct inode *inode, struct file *file)
>> +{
>> +    return single_open(file, ltssm_trace_show, inode->i_private);
>> +}
>> +
>>   #define dwc_debugfs_create(name)            \
>>   debugfs_create_file(#name, 0644, rasdes_debug, pci,    \
>>               &dbg_ ## name ## _fops)
>> @@ -552,6 +584,11 @@ static const struct file_operations 
>> dwc_pcie_ltssm_status_ops = {
>>       .read = seq_read,
>>   };
>> +static const struct file_operations dwc_pcie_ltssm_trace_ops = {
>> +    .open = ltssm_trace_open,
>> +    .read = seq_read,
>> +};
>> +
>>   static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>>   {
>>       struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>> @@ -644,6 +681,12 @@ static void dwc_pcie_ltssm_debugfs_init(struct 
>> dw_pcie *pci, struct dentry *dir)
>>                   &dwc_pcie_ltssm_status_ops);
>>   }
>> +static void dwc_pcie_ltssm_trace_debugfs_init(struct dw_pcie *pci, 
>> struct dentry *dir)
>> +{
>> +    debugfs_create_file("ltssm_trace", 0444, dir, pci,
>> +                &dwc_pcie_ltssm_trace_ops);
> Can we have this as the sysfs, so that if there is some issue in 
> production devices where debugfs is not available,
> we can use this to see LTSSM state figure out the issue.
> 

Thanks for the input. I think the ltssm_trace is debug in nature, just 
like the existing ltssm and rasdes_debug nodes, so it probably fits 
better under debugfs for consistency. Moreover, given most time we
combine rasdes_debug and ltssmm history to debug issues, if we split it
out, we’d end up with two separate debugging areas, which feels a bit
fragmented and less clear.


> - Krishna Chaitanya.
>> +}
>> +
>>   static int dw_pcie_ptm_check_capability(void *drvdata)
>>   {
>>       struct dw_pcie *pci = drvdata;
>> @@ -922,6 +965,7 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci, 
>> enum dw_pcie_device_mode mode)
>>               err);
>>       dwc_pcie_ltssm_debugfs_init(pci, dir);
>> +    dwc_pcie_ltssm_trace_debugfs_init(pci, dir);
>>       pci->mode = mode;
>>       pci->ptm_debugfs = pcie_ptm_create_debugfs(pci->dev, pci,
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/ 
>> pci/controller/dwc/pcie-designware.h
>> index 5cd27f5739f1..0df18995b7fe 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -395,6 +395,11 @@ enum dw_pcie_ltssm {
>>       DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>>   };
>> +struct dw_pcie_ltssm_history {
>> +    enum dw_pcie_ltssm *states;
>> +    u32 count;
>> +};
>> +
>>   struct dw_pcie_ob_atu_cfg {
>>       int index;
>>       int type;
>> @@ -499,6 +504,7 @@ struct dw_pcie_ops {
>>                     size_t size, u32 val);
>>       bool    (*link_up)(struct dw_pcie *pcie);
>>       enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
>> +    struct dw_pcie_ltssm_history * (*ltssm_trace)(struct dw_pcie *pcie);
>>       int    (*start_link)(struct dw_pcie *pcie);
>>       void    (*stop_link)(struct dw_pcie *pcie);
>>       int    (*assert_perst)(struct dw_pcie *pcie, bool assert);
> 
> 


