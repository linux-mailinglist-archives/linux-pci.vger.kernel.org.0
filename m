Return-Path: <linux-pci+bounces-18101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5399EC69D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88F22814B0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C01D31A5;
	Wed, 11 Dec 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ebfRRvq2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com [101.71.155.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB271CC8AE
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904625; cv=none; b=ZUSLEZxLMvuchpBwBw6pBpVsXzVsJNs0NMU6Xuo2rvtTCH5YxsqtjPXPNQ1sy+dKv1knwAY4aa96KFGwV2w9CuXiMDH3U2ENPX14+vSPfMiFUEISIz6q/RoUMtun37gchOtYRLFF058oo+oATLgnhD5O7AetamDbEHpObD9KWnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904625; c=relaxed/simple;
	bh=PbdxYntF4Sc+HQl8xKRm4SjWFviXl81QghqTPZRDZJg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qnbFccwP0NS9SFN02ibr7VimwxHvi3j/AcCXCM3fhAvXnfxp0IX20oqm4Duh5Xh6Yx9JWrlUuNBVw8EJ/vbIh5GOm+0bo/Kk+MsKb/SYJap0V7GJrdW4EVr3A92DlwRCKpehAAV204MYQCbk8WYs/GmG+cE+d7JocGW5Wh1uwjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ebfRRvq2; arc=none smtp.client-ip=101.71.155.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55cd080a;
	Wed, 11 Dec 2024 11:34:22 +0800 (GMT+08:00)
Message-ID: <6503180f-fcc2-49db-9e68-1cefac18af79@rock-chips.com>
Date: Wed, 11 Dec 2024 11:34:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] perf/dwc_pcie: Add support for Rockchip SoCs
To: Shuai Xue <xueshuai@linux.alibaba.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <1733885598-107771-1-git-send-email-shawn.lin@rock-chips.com>
 <1733885598-107771-2-git-send-email-shawn.lin@rock-chips.com>
 <0883f9ec-b984-4374-b54e-9a4c881e9be3@linux.alibaba.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <0883f9ec-b984-4374-b54e-9a4c881e9be3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8eQlYYHU5NSE4eTUJDT01WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93b3c833d909cckunm55cd080a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTI6Pxw4PjIPEDMvCC0sFjER
	SAEKFB1VSlVKTEhIQ0NDS01ISElOVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhPSEM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=ebfRRvq2mlB7D9Bi2m/3xmso1O0G4UHobGS1deoUc6Db27IMDaMZrwTyiu4xINk3II6E9i7DTphUCYS7OrXAG6TJbVV0f+H3f4YS/5N7WLAfY/q311aSrU2q67OzHzLG/bDDpI+OBhHVFtBdAqwZx8bTpgfxEMEwvEqDGoHOyRE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=p0jbOg/Zh+QXxKL+pqw5TDFwt2PV04bHvV8wBupdZ/o=;
	h=date:mime-version:subject:message-id:from;

在 2024/12/11 11:06, Shuai Xue 写道:
> 
> 
> 在 2024/12/11 10:53, Shawn Lin 写道:
>> Add support for Rockchip SoCs by adding vendor ID to the vendor list.
>> And fix the lane-event based enable/disable/read process which is 
>> slightly
>> different on Rockchip SoCs, by checking vendor ID.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/perf/dwc_pcie_pmu.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
>> index 9cbea96..b3276b8 100644
>> --- a/drivers/perf/dwc_pcie_pmu.c
>> +++ b/drivers/perf/dwc_pcie_pmu.c
>> @@ -108,6 +108,7 @@ static const struct dwc_pcie_vendor_id 
>> dwc_pcie_vendor_ids[] = {
>>       {.vendor_id = PCI_VENDOR_ID_ALIBABA },
>>       {.vendor_id = PCI_VENDOR_ID_AMPERE },
>>       {.vendor_id = PCI_VENDOR_ID_QCOM },
>> +    {.vendor_id = PCI_VENDOR_ID_ROCKCHIP },
> 
> Hi, Shawn,
> 
> Bjorn is working on fixing the VSEC matching[1], could you rebase on his 
> lastest patch?
> 
> [1] https://lore.kernel.org/r/20231012162512.GA1069387@bhelgaas

Sure, thanks for reminding me about this.

> 
> Best Regards,
> Shuai
> 
>>       {} /* terminator */
>>   };
>> @@ -256,12 +257,27 @@ static const struct attribute_group 
>> *dwc_pcie_attr_groups[] = {
>>       NULL
>>   };
>> +static void dwc_pcie_pmu_lane_event_enable_for_rk(struct pci_dev *pdev,
>> +                          u16 ras_des_offset,
>> +                          bool enable)
>> +{
>> +    if (enable)
>> +        pci_write_config_dword(pdev, ras_des_offset + 
>> DWC_PCIE_EVENT_CNT_CTL,
>> +                       DWC_PCIE_CNT_ENABLE | DWC_PCIE_PER_EVENT_ON);
>> +    else
>> +        pci_clear_and_set_config_dword(pdev, ras_des_offset + 
>> DWC_PCIE_EVENT_CNT_CTL,
>> +                       DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
>> +}
>> +
>>   static void dwc_pcie_pmu_lane_event_enable(struct dwc_pcie_pmu 
>> *pcie_pmu,
>>                          bool enable)
>>   {
>>       struct pci_dev *pdev = pcie_pmu->pdev;
>>       u16 ras_des_offset = pcie_pmu->ras_des_offset;
>> +    if (pdev->vendor == PCI_VENDOR_ID_ROCKCHIP)
>> +        return dwc_pcie_pmu_lane_event_enable_for_rk(pdev, 
>> ras_des_offset, enable);
>> +
>>       if (enable)
>>           pci_clear_and_set_config_dword(pdev,
>>                       ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
>> @@ -287,9 +303,14 @@ static u64 
>> dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
>>   {
>>       struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>>       struct pci_dev *pdev = pcie_pmu->pdev;
>> +    int event_id = DWC_PCIE_EVENT_ID(event);
>>       u16 ras_des_offset = pcie_pmu->ras_des_offset;
>>       u32 val;
>> +    if (pdev->vendor == PCI_VENDOR_ID_ROCKCHIP)
>> +        pci_write_config_dword(pdev, ras_des_offset + 
>> DWC_PCIE_EVENT_CNT_CTL,
>> +                       event_id << 16);
>> +
>>       pci_read_config_dword(pdev, ras_des_offset + 
>> DWC_PCIE_EVENT_CNT_DATA, &val);
>>       return val;
> 
> 


