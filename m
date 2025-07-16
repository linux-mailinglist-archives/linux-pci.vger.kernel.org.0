Return-Path: <linux-pci+bounces-32236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A21EB06E48
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6323169487
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 06:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A631288533;
	Wed, 16 Jul 2025 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YDF7JGR3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EB221FA4;
	Wed, 16 Jul 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752648849; cv=none; b=UGalRxwpszonrRTdzvGEsJIzw3VBTvwGYace9tgl8eAEBsus5wN3xYjh0Kanj+hFqG7CHPiZ1mWwW2FmkzGSsWG2j2CSjUkbKW4v2PuUddXwADSYY+iAwcyV6pLPGmcjefDF6LxktmQSqdS6Y7JSeBGIgs5UKbMRwuVSdZhYQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752648849; c=relaxed/simple;
	bh=vbiU6J99smeg4PUQWQsHKAIFmZqBqVfN+1w7iDue7jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=okTL0lrV5tgFwrdccIwfB6s3C5kzuWNPCNk1M4ki7RoKWaRIHe+D2azB0qo1BGfpsnku76pHuKVcPjqkEPr0qQyTHRe+b9VAbA3Mw8M3SF0IVtOg7qBb7ADOIr4d6zgsZFysluNf8SfjfU3OSYdMqNMYXHmnVlleE9b7L6s/Lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YDF7JGR3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5klvM024997;
	Wed, 16 Jul 2025 06:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KdyAir9UGaX/l86jgduIW9RnCbdq1mDvqq12WzLdr0c=; b=YDF7JGR3yD9fEOH6
	+U/pkQh/A/3LmPPmDyPIJMpt2mnf34WsgVAZ5WpZUzfDftpE47xtjWGycxf3/oHJ
	Co/rmjY3e02ThDdAMz6hGlR9dHd1ye8sw1ZScCZIUdRLJn+M9ylR3o5gRkK2brBd
	V7SuMfwHE7wYucEt5sSMDi3o3RpYVea31rt5GHbARkckGKiMFGVThP/WMTmJtlaz
	NcZ6Uf+NqjrNT0OhKB7BQOL8RPlQvQRAUAgpZEfCaOusMGMRak1SF+ALk/D3PtaU
	Q+jhZ6t4a0OAbdKwzfVhyuYuPm2U/aOJCl4a8KNvXWVxUxLhOHTM0yh3q/XdfE1h
	RYlLmg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58ynpbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 06:54:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56G6s15j006993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 06:54:01 GMT
Received: from [10.218.37.122] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 15 Jul
 2025 23:53:57 -0700
Message-ID: <ead761e1-2b48-4b9d-90cc-f63463a97f60@quicinc.com>
Date: Wed, 16 Jul 2025 12:23:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>
CC: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Johan Hovold
	<johan@kernel.org>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
 <eccae2e8-f158-4501-be21-e4188e6cbd84@oss.qualcomm.com>
 <qg4dof65dyggzgvkroeo2suhhnvosqs3dnkrmsqpbf4z67dcht@ltzirahk2mxd>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <qg4dof65dyggzgvkroeo2suhhnvosqs3dnkrmsqpbf4z67dcht@ltzirahk2mxd>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA2MCBTYWx0ZWRfXxvW4Au0jHqfz
 TAIFvbLx3lsIzj4gYaPk+2zHs5inEaESa5ozgUiOK1hM4A4T6zyzWp+8BFcPPC6kKL3GwsxQcLa
 SSJCFuQYMORSUkuld0KyQy2znS8b4XL3XDFPS44qWeOGSFgG/p80Dmg0ECi4VZydfyCSfAwWIR8
 95wH9NUYY+tq3e+G3JVhNNYu4te+PR+yD0WWc5V51FoT28XXoC0QMIs6sPbmi6WAfu5lSJ3YrUP
 3pzrfim1CwEuLRBsoJ6Kc/0Wd3yaU8sYJ25dP9wzcR0y16zpNPFBjRRo6YBt1G3KVxL3jCx3OY5
 X1ljLegaLZUN8EUYsiXQHcC/mGUWGszQcl4OOSgLbc83goyE930MxHCFYJABBqpHQsWWaRTILw4
 emEocjsZ+bJWdzaC8pnIOPjQ9rsWhshQr17GOnHDlGMgqVII1qmwGAs3ti7lLVCnnHht3d54
X-Proofpoint-GUID: 7jjvlKF6Z6mekIqBaKN8E03Lu-J0ZLsv
X-Proofpoint-ORIG-GUID: 7jjvlKF6Z6mekIqBaKN8E03Lu-J0ZLsv
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=68774c8a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=9XPAJaHZ0NnvTPy2xSYA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160060



On 7/16/2025 12:16 PM, Manivannan Sadhasivam wrote:
> On Wed, Jul 16, 2025 at 10:24:23AM GMT, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/15/2025 4:06 PM, Manivannan Sadhasivam wrote:
>>> On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
>>>> On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
>>>>> It allows us to group all the settings that need to be done when a PCI
>>>>> device is attached to the bus in a single place.
>>>>>
>>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>>> ---
>>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
>>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>> index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>> @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>>>>>    		pci_lock_rescan_remove();
>>>>>    		pci_rescan_bus(pp->bridge->bus);
>>>>>    		pci_unlock_rescan_remove();
>>>>> -
>>>>> -		qcom_pcie_icc_opp_update(pcie);
>>>>>    	} else {
>>>>>    		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>>>>>    			      status);
>>>>> @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
>>>>>    	switch (action) {
>>>>>    	case BUS_NOTIFY_BIND_DRIVER:
>>>>>    		qcom_pcie_enable_aspm(pdev);
>>>>> +		qcom_pcie_icc_opp_update(pcie);
>>>>
>>>> So I assume that we're not exactly going to do much with the device if
>>>> there isn't a driver for it, but I have concerns that since the link
>>>> would already be established(?), the icc vote may be too low, especially
>>>> if the user uses something funky like UIO
>>>>
>>>
>>> Hmm, that's a good point. Not enabling ASPM wouldn't have much consequence, but
>>> not updating OPP would be.
>>>
>>> Let me think of other ways to call these two APIs during the device addition. If
>>> there are no sane ways, I'll drop *this* patch.
>>>
>> How about using enable_device in host bridge, without pci_enable_device
>> call the endpoints can't start the transfers. May be we can use that.
>>
> 
> Q: Who is going to call pci_enable_device()?
> A: The PCI client driver
> 
> This is same as relying on BUS_NOTIFY_BIND_DRIVER notifier.
>
userspace can enable device using sysfs[1] without attaching
any kernel drivers.

[1] 
https://elixir.bootlin.com/linux/v6.16-rc6/source/drivers/pci/pci-sysfs.c#L315
- Krishna Chaitanya.

> - Mani
> 

