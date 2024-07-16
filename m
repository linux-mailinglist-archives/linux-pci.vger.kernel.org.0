Return-Path: <linux-pci+bounces-10345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC4931F88
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 06:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C26AB21791
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BFC13FF9;
	Tue, 16 Jul 2024 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hl/l5GHU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B033C5;
	Tue, 16 Jul 2024 04:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721102675; cv=none; b=ZansPQJ+gJDoHyJOj4FsoRzssRYJce3KEenZCTzT/XiXI6bM9fOc0y/1KCF1rSmGKd8V+wkFAQ83HpPZ1YIs5R+FHB73usEKdcEqfvhv2AVXWKtYR2iqSOasQldRzCm969SFqw9zpwQbcwJNoTj/oVlj0tBKoakCTLoqmF8izdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721102675; c=relaxed/simple;
	bh=HsFmI1s/3LURKPRNtWHsllATcSGn3i4GKtUex6d7cjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TJQ1B9TPTY320oi6md+2R62CqKLR5VEWGZ2IRtBFOQVsRjyxGG9xNpI2LMl21O51AQjEgEYxSLnN+Ur5v1W8lqipwBXfCUor4yELizy/8BIOmwT3/5JfGv41ZG3h/RAOiGLdt5/wcCpClYr41peVBzPsgGezev7XZ/KxwKc64VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hl/l5GHU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH92wi032052;
	Tue, 16 Jul 2024 04:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1sPRlKkfbA0aweXIugAyK4kAqgEqh3OJ7rsI3b38EJQ=; b=hl/l5GHUDQveJdNm
	X+arINI4WcTLx5VOQz7JPPlpoyCLMlCZzU6P/AWcYQCenpP1lo8doQqVUmbLnnn6
	mgbYfdb0EtMYvoyjgvArAvL+NfJ7PD380ODQucHyd97goDApj22NDJGArkChCbC3
	P+sb959fZL75CfhEn6omymw6zSG+6ojrOBMRwlKsxqfGky33N3N/q/5qCE6oRS51
	F90/NNul6tDYFVgz+EtYN//BvfArPn6k/iBkPWLajlk009L1WE7dEVFzmxSzykCk
	AxasnRt7k4GJKnLI49h+c9PdYqyLrNUNCEnDxwGV8mMF3Ib5iGnJ1QVqEA/Y33lY
	eQ00vQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjrjdu2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 04:04:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G44Lsl027515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 04:04:21 GMT
Received: from [10.216.59.252] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 21:04:16 -0700
Message-ID: <dca49572-dc77-58df-1bd1-b0e897191c87@quicinc.com>
Date: Tue, 16 Jul 2024 09:34:13 +0530
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
To: <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
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
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-13-5f3765cc873a@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240715-pci-qcom-hotplug-v1-13-5f3765cc873a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fVp-wpjekQe_TtxXBc59yHBE0Ct_VETg
X-Proofpoint-ORIG-GUID: fVp-wpjekQe_TtxXBc59yHBE0Ct_VETg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160029



On 7/15/2024 11:03 PM, Manivannan Sadhasivam via B4 Relay wrote:
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
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 55 ++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..38ed411d2052 100644
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
> @@ -260,6 +266,7 @@ struct qcom_pcie {
>   	struct icc_path *icc_cpu;
>   	const struct qcom_pcie_cfg *cfg;
>   	struct dentry *debugfs;
> +	int global_irq;
>   	bool suspended;
>   };
>   
> @@ -1488,6 +1495,29 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>   				    qcom_pcie_link_transition_count);
>   }
>   
> +static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> +{
> +	struct qcom_pcie *pcie = data;
> +	struct dw_pcie_rp *pp = &pcie->pci->pp; > +	struct device *dev = pcie->pci->dev;
> +	u32 status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
> +
> +	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
> +
> +	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
> +		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> +		/* Rescan the bus to enumerate endpoint devices */
> +		pci_lock_rescan_remove();
> +		pci_rescan_bus(pp->bridge->bus);
There can be chances of getting link up interrupt before PCIe framework
starts enumeration and at that time bridge-> bus is not created and
cause NULL point access.
Please have a check for this.

- Krishna Chaitanya.
> +		pci_unlock_rescan_remove();
> +	} else {
> +		dev_err(dev, "Received unknown event. INT_STATUS: 0x%08x\n",
> +			status);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static int qcom_pcie_probe(struct platform_device *pdev)
>   {
>   	const struct qcom_pcie_cfg *pcie_cfg;
> @@ -1498,6 +1528,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   	struct dw_pcie_rp *pp;
>   	struct resource *res;
>   	struct dw_pcie *pci;
> +	char *name;
>   	int ret;
>   
>   	pcie_cfg = of_device_get_match_data(dev);
> @@ -1617,6 +1648,28 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
> +	pcie->global_irq = platform_get_irq_byname_optional(pdev, "global");
> +	if (pcie->global_irq > 0) {
> +		ret = devm_request_threaded_irq(&pdev->dev, pcie->global_irq,
> +						NULL,
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
> @@ -1624,6 +1677,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> +err_host_deinit:
> +	dw_pcie_host_deinit(pp);
>   err_phy_exit:
>   	phy_exit(pcie->phy);
>   err_pm_runtime_put:
> 

