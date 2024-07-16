Return-Path: <linux-pci+bounces-10351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC8A931FAF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 06:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC85282613
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 04:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D46011C92;
	Tue, 16 Jul 2024 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gNeveWDU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8A23B0;
	Tue, 16 Jul 2024 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103917; cv=none; b=gqNgZBRJzXHsdNePplHeAgB9vYtcJc8cccBpfW16w7MbOGBUgbwea2Q+2NI90jj/1jZtQbg95QzL2QdvQ4SGONAQv4CFMUlO2ggRujU7yZqhD0Fr4KhYoD8ok9jk4iaEPSGEp3ZGf3L8R4F6Pcnrh4ZKrPULpflV36rI65EXy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103917; c=relaxed/simple;
	bh=6MX+NE8Jxzwb8avED/COfEGkUNieFwkqSY0z/WSeoLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OUg2/48oveAxlMhY3lO93wBgRRTqFOYhTUyHiCWUtbSu5Tlmrsc39tVSJU258yME0SyzDRbPWPF/2kuF/u6BJ0gsO3QyatOITwb+SmnZ2PphG17qZ9B0P9zr6OZ0RnItNBZDJhAwG0ORoi1w9Q8sTgnu16U2ozvDBWiCl55zL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gNeveWDU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH95LT022751;
	Tue, 16 Jul 2024 04:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Qz4N6UHAH0nIVVa+R9Y9Jl2Jpt/5B6jrSJZ83NGUqU=; b=gNeveWDUDvCq4FyJ
	bKvdEGCAZ8KATXdBOBObYBb2GrAYaknNDO681WVGbG1aRko9cnMV0iUmLGGuQFLQ
	92fEPfGpT17unAsj+JtpJmSWM57oUIf9Skz5ybKBDgeewO1Pt0Rk3gSK7cV+4Kq8
	yphMhWOLtxa0SKpkMAcqJFvtFF9nqU6qljJjNhrVtczVES/HEiMN9e0fCUeTYrm1
	9K82fIGnU827f/DUUQiBaezkBCNsibCrkLBRh0aa5R5hApl3cB5krgeEfunkra1e
	K+jaqQPcWI6XRzREtg6HXO2OFejKudMwnEtPBy2M+DgaiNo3luHXFcTxcjm9CBI9
	b+scmA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjv8nwtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 04:25:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G4P2TS026239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 04:25:02 GMT
Received: from [10.216.59.252] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 21:24:57 -0700
Message-ID: <5f8218cb-a8d6-789a-8723-0af07353e432@quicinc.com>
Date: Tue, 16 Jul 2024 09:54:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 13/14] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
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
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-13-5f3765cc873a@linaro.org>
 <dca49572-dc77-58df-1bd1-b0e897191c87@quicinc.com>
 <20240716041827.GD3446@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240716041827.GD3446@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bdr6bUfVGoiuQg_qxT9MyY6-EKJsTvXm
X-Proofpoint-GUID: bdr6bUfVGoiuQg_qxT9MyY6-EKJsTvXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160031



On 7/16/2024 9:48 AM, Manivannan Sadhasivam wrote:
> On Tue, Jul 16, 2024 at 09:34:13AM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/15/2024 11:03 PM, Manivannan Sadhasivam via B4 Relay wrote:
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
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-qcom.c | 55 ++++++++++++++++++++++++++++++++++
>>>    1 file changed, 55 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 0180edf3310e..38ed411d2052 100644
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
>>> @@ -260,6 +266,7 @@ struct qcom_pcie {
>>>    	struct icc_path *icc_cpu;
>>>    	const struct qcom_pcie_cfg *cfg;
>>>    	struct dentry *debugfs;
>>> +	int global_irq;
>>>    	bool suspended;
>>>    };
>>> @@ -1488,6 +1495,29 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>>>    				    qcom_pcie_link_transition_count);
>>>    }
>>> +static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>>> +{
>>> +	struct qcom_pcie *pcie = data;
>>> +	struct dw_pcie_rp *pp = &pcie->pci->pp; > +	struct device *dev = pcie->pci->dev;
>>> +	u32 status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
>>> +
>>> +	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
>>> +
>>> +	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>>> +		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
>>> +		/* Rescan the bus to enumerate endpoint devices */
>>> +		pci_lock_rescan_remove();
>>> +		pci_rescan_bus(pp->bridge->bus);
>> There can be chances of getting link up interrupt before PCIe framework
>> starts enumeration and at that time bridge-> bus is not created and
>> cause NULL point access.
>> Please have a check for this.
>>
> 
> Host bridge is enumerated during dw_pcie_host_init() and the IRQ handler is
> registered afterwards. So there is no way the 'pp->bridge' can be NULL.
> 
> - Mani
I leaved a gap between bridge-> & bus by mistake, I want to highlight 
bridge->bus in above comment. The bus can be NULL and it can create NULL
point access.
- Krishna Chaitanya.
> 

