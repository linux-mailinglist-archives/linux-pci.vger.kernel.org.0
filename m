Return-Path: <linux-pci+bounces-10530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3979593512A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 19:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2AFCB2274B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72770144D3C;
	Thu, 18 Jul 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Eh3K2Bzd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140B143892;
	Thu, 18 Jul 2024 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721323024; cv=none; b=PO8sGqhyyMos9vVI05n8u3iMoWKMWRMOWR9qijcovjHRBQlO/21C7zD8RNrM6PU3PLi4CDf3Z+rureVLSO7RJZXGeLwGJmKR+WfM2Xf1yNLqrCJf6+MQC0PHa4SpxJIEfkD3CVuGE7EQ7gNIAMIQtbdrASafoyIOPlu05aK9Wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721323024; c=relaxed/simple;
	bh=s56HzSY+L94RmyRrNVmtG55johXwCDWucKIAMmGgx+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lxMQFmDQsWIVd6HstGFCIae4K6oeN9jum9ORaFASpPMLPFwaxyXxNvyYpgrOsQSpYKW6TCO4S3VJBbSjBTLcuZwIg4HpCtLaYubuaEHsncsIx2JQCRJvTEDK8vyDu2fxNBSCjc2NZHfcqBK4Zm1fVVpuuM7zRVlhTydDJfKsA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Eh3K2Bzd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IFAnXe013666;
	Thu, 18 Jul 2024 17:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hVkuSgr+QVm0hogbZSkHmsumX/eIVh8SPD1NHT5nqws=; b=Eh3K2BzdarwvIpFS
	liI1PaupV3fw0wklkgrmMeWRZGxlLQcycg/61SIjdkXa9Vw2ZAecNbL1uH4T0buG
	+OwzVYzx1gpZRhyNcdIvYc+1mqueuDbQRwXX70oOZD6J0o9xnkeXdvK0Pbs9mpg+
	M5ZQx7LdMkW6EnpCdNxitB7OD6E58PqCNiKl4j+jlex8VTegaaflPd4X9KawOUIj
	M+AFWuZjLZZGCHF8lVMHU88oP9QhbazrvDQEZg2/Xye+p4TC+bG9z4/VxG9iHP5b
	oldsMoKKIr7g+nIzsRtPpPs2bVSaGupP+mmpqGKx3sBDHSRKna/NoLzia9C5/Nt4
	cHoZTA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfwe1aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 17:16:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46IHFxDT002507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 17:15:59 GMT
Received: from [10.110.7.185] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Jul
 2024 10:15:58 -0700
Message-ID: <8c3e77b6-0d23-42ef-a7db-52635bd5070a@quicinc.com>
Date: Thu, 18 Jul 2024 10:15:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay
 Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
 <20240717-pci-qcom-hotplug-v2-12-71d304b817f8@linaro.org>
 <02b94a07-fcd6-4a48-bead-530b81c8a27e@quicinc.com>
 <20240718102938.GA8877@thinkpad>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240718102938.GA8877@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rEdeG7HL2j_iEoFYxTGkwCmLWyBtTx_Q
X-Proofpoint-ORIG-GUID: rEdeG7HL2j_iEoFYxTGkwCmLWyBtTx_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_12,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407180113

Hi Mani

On 7/18/2024 3:29 AM, Manivannan Sadhasivam wrote:
> On Wed, Jul 17, 2024 at 03:57:11PM -0700, Mayank Rana wrote:
>> Hi Mani
>>
>> I don't think we can suggest that usage of link up event with Global IRQ as
>> simulate PCIe hotplug. hotplug is referring to allow handling of both
>> add or remove of endpoint device whereas here you are using global IRQ as
>> last step to rescan bus if endpoint is power up later after link training is
>> initiated.
>>
> 
> Why not? Well it is not entirely the standard 'hotplug' and that's why I
> referred it as 'simulating hotplug'.
Because it is misleading here by saying simulate hotplug. You can 
mention as use link up event
to rescan bus instead of using simulate PCIe hotplug here.

> The point of having this feature is to avoid the hassle of rescanning the bus
> manually when the devices are connected to this bus post boot.
> 
>> Will this work if you remove endpoint device and add it back again ?
>>
> 
> No, not currently. But we could add that logic using LINK_DOWN event. Though,
> when the device comes back again, it will not get enumerated successfully due to
> a bug in the link training part (which I plan to address later). But this
> issue is irrespective of this hotplug simulation.
ok. Although LINK DOWN event not necessary suggests that endpoint has been
removed but it also suggests that link has gone into bad state, and it 
is being detected and notified as link down event.
>> Regards,
>> Mayank
>> On 7/17/2024 10:03 AM, Manivannan Sadhasivam via B4 Relay wrote:
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>
>>> Historically, Qcom PCIe RC controllers lack standard hotplug support. So
>>> when an endpoint is attached to the SoC, users have to rescan the bus
>>> manually to enumerate the device. But this can be avoided by simulating the
>>> PCIe hotplug using Qcom specific way.
>>>
>>> Qcom PCIe RC controllers are capable of generating the 'global' SPI
>>> interrupt to the host CPUs. The device driver can use this event to
>>> identify events such as PCIe link specific events, safety events etc...
>>>
>>> One such event is the PCIe Link up event generated when an endpoint is
>>> detected on the bus and the Link is 'up'. This event can be used to
>>> simulate the PCIe hotplug in the Qcom SoCs.
>>>
>>> So add support for capturing the PCIe Link up event using the 'global'
>>> interrupt in the driver. Once the Link up event is received, the bus
>>> underneath the host bridge is scanned to enumerate PCIe endpoint devices,
>>> thus simulating hotplug.
>>>
>>> All of the Qcom SoCs have only one rootport per controller instance. So
>>> only a single 'Link up' event is generated for the PCIe controller.
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-qcom.c | 55 +++++++++++++++++++++++++++++++++-
>>>    1 file changed, 54 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 0180edf3310e..a1d678fe7fa5 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -50,6 +50,9 @@
>>>    #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>>>    #define PARF_Q2A_FLUSH				0x1ac
>>>    #define PARF_LTSSM				0x1b0
>>> +#define PARF_INT_ALL_STATUS			0x224
>>> +#define PARF_INT_ALL_CLEAR			0x228
>>> +#define PARF_INT_ALL_MASK			0x22c
>>>    #define PARF_SID_OFFSET				0x234
>>>    #define PARF_BDF_TRANSLATE_CFG			0x24c
>>>    #define PARF_SLV_ADDR_SPACE_SIZE		0x358
>>> @@ -121,6 +124,9 @@
>>>    /* PARF_LTSSM register fields */
>>>    #define LTSSM_EN				BIT(8)
>>> +/* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
>>> +#define PARF_INT_ALL_LINK_UP			BIT(13)
>>> +
>>>    /* PARF_NO_SNOOP_OVERIDE register fields */
>>>    #define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
>>>    #define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
>>> @@ -1488,6 +1494,29 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>>>    				    qcom_pcie_link_transition_count);
>>>    }
>>> +static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>>> +{
>>> +	struct qcom_pcie *pcie = data;
>>> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
>>> +	struct device *dev = pcie->pci->dev;
>>> +	u32 status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
>>> +
>>> +	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
>>> +
>>> +	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>>> +		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
>>> +		/* Rescan the bus to enumerate endpoint devices */
>>> +		pci_lock_rescan_remove();
>>> +		pci_rescan_bus(pp->bridge->bus);
>>> +		pci_unlock_rescan_remove();
>> How do you handle case where endpoint is already enumerated, and seeing link
>> up event in parallel or later ? will it go ahead to rescan bus again here ?
>>
> 
> If the endpoint is already enumerated, there will be no Link up event. Unless
> the controller reinitializes the bus (which is the current behavior).
> 
> If the endpoint is already powered on during controller probe, then it will be
> enumerated during dw_pcie_host_init() and since we register the IRQ handler
> afterwards, there will be no Link up in that case.
> 
> This feature is only applicable for endpoints that comes up post boot.
ok. thanks for above information. I feel capturing this information in 
commit text
would be helpful.
>> Also can you consider doing this outside hardirq context ?
>>
>
> This is already running in threaded irq context (bottom half), wouldn't that
> be enough?
Done.
> - Mani
> 
Regards,
Mayank

