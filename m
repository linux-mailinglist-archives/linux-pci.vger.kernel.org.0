Return-Path: <linux-pci+bounces-10475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2E9344F4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 00:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E341C21520
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E96537E9;
	Wed, 17 Jul 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pp84YKtV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49A249F9;
	Wed, 17 Jul 2024 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721257050; cv=none; b=PcSKFFzziTbvT7KmDhyx+F3TF/87Kjz6HHdrLhPl043EpvpZ3EHhjFsxN4B3ntO0CVfLXK3i5iD1JR/bwQkWNNY4ObCwJ14aI5BT7upDHiohXOtoRD8LD8Fv7G1wAUqTmunicz5gYJa6QGjAqnmpWuR2xfPUqVP6Ikk59xZRBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721257050; c=relaxed/simple;
	bh=oWqldk9LByF0/aKR32qLZJ52KR4BYCWgM6KVmobRav4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jcBzMm/NwvrgYGPQ/tgpVS00MSHTJz+GspHv6pzGU7PIPLtYC4SC5P0wRDB8UntVBZzuvMLuvM4XmIX1W17DHtDukTw24ga59kWQyJQboRPDN2EYuuCTTsUspU3SgQa6kpX+x0lpsB+b2mIkqrclI6q4NJxE9asN4ztRTFtND6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pp84YKtV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFebZi008133;
	Wed, 17 Jul 2024 22:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ATszFPG0tx6MSwF9g1jqXbljCZlzXPfIFDwZXXQ64BI=; b=Pp84YKtV4QOVG07Q
	mhFCGfY91LCoilE0EgH7XPWVkbvmFZxA+NH+9awUh2pcylajQiU5nNzPB+c1Oalk
	N4TMLbM1z7IahKFe4VdOyyfAUkXTqpEr+9ripzr5B+GnW1NkNUVHIKH6lXWuD5XT
	+7LVKVC0CMOlcrgrVm3Fd9jWN2ZXsDpvWKi4bTZrXI0GU/CPX7a0vaIwDkLM32L4
	5jqNmgp7xpz0X7CVMQ4Nz+/pqqmbq0xTvP3zfr8axX/LFCVstGjVVC9kuMEllPRL
	QuU7XtV6r4TwLlABXH22n8mAiXGA+0VXkTWgkrtKS2+KL6v5hrwMRB93zUajYktS
	Chgleg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfxbu58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 22:57:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HMvDVJ011127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 22:57:13 GMT
Received: from [10.110.77.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 15:57:12 -0700
Message-ID: <02b94a07-fcd6-4a48-bead-530b81c8a27e@quicinc.com>
Date: Wed, 17 Jul 2024 15:57:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
To: <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
 <20240717-pci-qcom-hotplug-v2-12-71d304b817f8@linaro.org>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240717-pci-qcom-hotplug-v2-12-71d304b817f8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Uj7XKNBaXILXy-Ak2ZwL3u-nrbAHM7OT
X-Proofpoint-GUID: Uj7XKNBaXILXy-Ak2ZwL3u-nrbAHM7OT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_17,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1011 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170174

Hi Mani

I don't think we can suggest that usage of link up event with Global IRQ 
as simulate PCIe hotplug. hotplug is referring to allow handling of both
add or remove of endpoint device whereas here you are using global IRQ 
as last step to rescan bus if endpoint is power up later after link 
training is initiated.

Will this work if you remove endpoint device and add it back again ?

Regards,
Mayank
On 7/17/2024 10:03 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Historically, Qcom PCIe RC controllers lack standard hotplug support. So
> when an endpoint is attached to the SoC, users have to rescan the bus
> manually to enumerate the device. But this can be avoided by simulating the
> PCIe hotplug using Qcom specific way.
> 
> Qcom PCIe RC controllers are capable of generating the 'global' SPI
> interrupt to the host CPUs. The device driver can use this event to
> identify events such as PCIe link specific events, safety events etc...
> 
> One such event is the PCIe Link up event generated when an endpoint is
> detected on the bus and the Link is 'up'. This event can be used to
> simulate the PCIe hotplug in the Qcom SoCs.
> 
> So add support for capturing the PCIe Link up event using the 'global'
> interrupt in the driver. Once the Link up event is received, the bus
> underneath the host bridge is scanned to enumerate PCIe endpoint devices,
> thus simulating hotplug.
> 
> All of the Qcom SoCs have only one rootport per controller instance. So
> only a single 'Link up' event is generated for the PCIe controller.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 55 +++++++++++++++++++++++++++++++++-
>   1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..a1d678fe7fa5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -50,6 +50,9 @@
>   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>   #define PARF_Q2A_FLUSH				0x1ac
>   #define PARF_LTSSM				0x1b0
> +#define PARF_INT_ALL_STATUS			0x224
> +#define PARF_INT_ALL_CLEAR			0x228
> +#define PARF_INT_ALL_MASK			0x22c
>   #define PARF_SID_OFFSET				0x234
>   #define PARF_BDF_TRANSLATE_CFG			0x24c
>   #define PARF_SLV_ADDR_SPACE_SIZE		0x358
> @@ -121,6 +124,9 @@
>   /* PARF_LTSSM register fields */
>   #define LTSSM_EN				BIT(8)
>   
> +/* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
> +#define PARF_INT_ALL_LINK_UP			BIT(13)
> +
>   /* PARF_NO_SNOOP_OVERIDE register fields */
>   #define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
>   #define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
> @@ -1488,6 +1494,29 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>   				    qcom_pcie_link_transition_count);
>   }
>   
> +static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> +{
> +	struct qcom_pcie *pcie = data;
> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> +	struct device *dev = pcie->pci->dev;
> +	u32 status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
> +
> +	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
> +
> +	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
> +		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> +		/* Rescan the bus to enumerate endpoint devices */
> +		pci_lock_rescan_remove();
> +		pci_rescan_bus(pp->bridge->bus);
> +		pci_unlock_rescan_remove();
How do you handle case where endpoint is already enumerated, and seeing 
link up event in parallel or later ? will it go ahead to rescan bus 
again here ?

Also can you consider doing this outside hardirq context ?

> +	} else {
> +		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
> +			      status);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static int qcom_pcie_probe(struct platform_device *pdev)
>   {
>   	const struct qcom_pcie_cfg *pcie_cfg;
> @@ -1498,7 +1527,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   	struct dw_pcie_rp *pp;
>   	struct resource *res;
>   	struct dw_pcie *pci;
> -	int ret;
> +	int ret, irq;
> +	char *name;
>   
>   	pcie_cfg = of_device_get_match_data(dev);
>   	if (!pcie_cfg || !pcie_cfg->ops) {
> @@ -1617,6 +1647,27 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   		goto err_phy_exit;
>   	}
>   
> +	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_global_irq%d",
> +			      pci_domain_nr(pp->bridge->bus));
> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto err_host_deinit;
> +	}
> +
> +	irq = platform_get_irq_byname_optional(pdev, "global");
> +	if (irq > 0) {
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						qcom_pcie_global_irq_thread,
> +						IRQF_ONESHOT, name, pcie);
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret,
> +				      "Failed to request Global IRQ\n");
> +			goto err_host_deinit;
> +		}
> +
> +		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
> +	}
> +
>   	qcom_pcie_icc_opp_update(pcie);
>   
>   	if (pcie->mhi)
> @@ -1624,6 +1675,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> +err_host_deinit:
> +	dw_pcie_host_deinit(pp);
>   err_phy_exit:
>   	phy_exit(pcie->phy);
>   err_pm_runtime_put:
> 

