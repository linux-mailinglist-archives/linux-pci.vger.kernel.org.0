Return-Path: <linux-pci+bounces-10140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799592E019
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 08:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B37E1C20EDC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 06:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF93E84DE9;
	Thu, 11 Jul 2024 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dt6ZFSZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1B83CD6;
	Thu, 11 Jul 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679286; cv=none; b=I1eRbtSHG3AvbgWxGuV9REI4qjRBGdPU3VVRfWymedJ49gxknoRL6KJpBpg+cDNcaMuGaxVoXe3fWptykMHdptDM8yqQ9lmqHQFNUMG5kOJNK3VAzXxLNU6ADiI91loRxYgifjMxasGd5u4fe5HiUdt4GVYzWlp2EZAop60XNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679286; c=relaxed/simple;
	bh=2uxmTCZV6wdZ4BdAvADYGh/dTaVrMo39/6i3EygQAOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aIDAog4JivppiOrtklD3NxUgn00oGgA9fx5cVQi0lfZYqmIaUMElrB0C32OopGBoaJPokpCUteTNklNptI91FvB2fLA+kolCccfzMeZp/8LgHGTOxa4pDNsDctOLQUviR/QXZjqSldumzjY9lMt+U4QrzvXh1tv7YPUlFOgF9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dt6ZFSZZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4mj1P014569;
	Thu, 11 Jul 2024 06:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rBpuZLrNCGsTn/D1eggkjYSZqxJ/1YdlhMGfNazg0sQ=; b=dt6ZFSZZUaT6STyB
	iO6+vM3PnuEqICxk3rKDRwRjMGhoxLP/V5bL1La6Q7l7ldkBKyzqi28izNb8Ivfx
	zt/zw1M8WEm5tETsasJ6z4LTn7lPSNPe7s2LlS0pWfFFIFAf1wKNbnwcGv2XvMD+
	9R1srS1SkbrZKcfB/RVvu89/uzRFoth1khidkr+6fEtDTS6GRjcef7nEL4LLCM95
	k2tm/jZV2uL1N4V7XJtibPvf3v6HiWiPkcbAaqZkAjkAwTwAdm3jae7fY7Emq3uz
	UH6ZHVeGZdjkAyQYhx/JPVrNfdQbaIOUOOiTfFf12cB066nB251R6v3eHHcNZ5NX
	AsXbIw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409kdtk89k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 06:27:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B6RijT020417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 06:27:44 GMT
Received: from [10.216.38.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 23:27:38 -0700
Message-ID: <a56de2dc-30a0-a292-c03c-16ec5393eea8@quicinc.com>
Date: Thu, 11 Jul 2024 11:57:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 2/4] PCI: qcom-ep: Add support for D-state change
 notification
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring
	<robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>, Manivannan Sadhasivam
	<mani@kernel.org>
References: <20240710121118.GA240905@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240710121118.GA240905@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mXHbW_6Y4FDFYiXrAqEIVIrBokao0TBO
X-Proofpoint-GUID: mXHbW_6Y4FDFYiXrAqEIVIrBokao0TBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_03,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110043



On 7/10/2024 5:41 PM, Bjorn Helgaas wrote:
> On Wed, Jul 10, 2024 at 04:38:15PM +0530, Krishna chaitanya chundru wrote:
>> Add support to pass D-state change notification to Endpoint
>> function driver.
> 
> Blank line between paragraphs.
> 
Ack.
>> Read perst value to determine if the link is in D3Cold/D3hot.
> 
> I assume this reads the state of the PERST# signal driven by the host.
> Style it to match the spec usage ("PERST#") to make that connection
> clearer.
> 
Ack.
> D3cold/D3hot is a device state and doesn't apply to a link.  Link
> states are L0, L1, L2, L3,etc.  Also in cover letter.
> 
Ack.
> I don't understand the connection between PERST# state and the device
> D state.  D3cold is defined to mean main power is absent.  Is the
> endpoint firmware still running when main power is absent?
> 
Host as part of its d3cold sequence will assert the perst. so we are
reading perst to know the link the state.

Qcom devices are drawing power from the PCIe, so even when PCIe is in
D3cold endpoint firmware can still run.

- Krishna Chaitanya.
>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 236229f66c80..817fad805c51 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -648,6 +648,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>   	struct device *dev = pci->dev;
>>   	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
>>   	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
>> +	pci_power_t state;
>>   	u32 dstate, val;
>>   
>>   	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
>> @@ -671,11 +672,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>   		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>>   					   DBI_CON_STATUS_POWER_STATE_MASK;
>>   		dev_dbg(dev, "Received D%d state event\n", dstate);
>> -		if (dstate == 3) {
>> +		state = dstate;
>> +		if (dstate == PCI_D3hot) {
>>   			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>>   			val |= PARF_PM_CTRL_REQ_EXIT_L1;
>>   			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
>> +
>> +			if (gpiod_get_value(pcie_ep->reset))
>> +				state = PCI_D3cold;
>>   		}
>> +		pci_epc_dstate_notify(pci->ep.epc, state);
>>   	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>>   		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
>>   		dw_pcie_ep_linkup(&pci->ep);
>>
>> -- 
>> 2.42.0
>>

