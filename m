Return-Path: <linux-pci+bounces-12688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F91C96A69F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 20:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB7928839A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E901917D9;
	Tue,  3 Sep 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UA8eeZG1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1401917CD;
	Tue,  3 Sep 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388355; cv=none; b=sStsLn6/t6Ul3JLb+CPg4IIiQymxumyurn2hJWJCjQDbyHkY6CTf2xlv+KSTcRm7AJeTEmEkYrZNjayoLGCSTfvarr1xIk+hxWfl+eUfC6Uo4LBd4bNmC5Hr++pp1jIY955ErbHLM3iZQgKpR6gOSgqDwQZrlUh+qNVf6+INOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388355; c=relaxed/simple;
	bh=nYiZP4ZQdAgrx+clF6rOT89SYsiPaOcm3NPZLG3JsrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R2KD9+hKyE3sNsnLqH/GRMy5hSXLdizuQBG7fpRMJti/n+L1mVp/VQP0CEbUo/R6QlXkAKwc6G38fJURjIMZ4m7bvtrQ0YIdF4OvFnqys8xzlkdD1uFFgw4BOqi++8Cmhv5w4hVkBga7hUB7U2Gg3uDwnHwH84Hij6I/QY/Y60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UA8eeZG1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483AgDrT019040;
	Tue, 3 Sep 2024 18:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1w9wz0apQoz9JLbYl/ERFoLViBi4KWpYV/ahb6L5VvI=; b=UA8eeZG1AOclyfWE
	px9cnBK67B0esWDzggm9xx9cD8uj+fdtyJWX0kDvIRWQ4xO7UryboztUGv0p5aip
	DyviQkcrfWBJDCvaxkub55ZooCk3j16hcmH9BGJZBRXsHgv/6STZOFu88sTjrU0g
	wgzOsRcsKtjnh5jM5LnJ7YarDC59lCrE755lne+kVAAlIyThfhCAeu9nQajUiuOY
	8G/XMznbwtzgvARXeHIrUDU/lojdKR1mYLhqJTu/5BnEd8alc2dERN5z396Aae6F
	KLGj+CXIReW+PUwYTkRduXOThOplwy0HCqF6T45cmZXgdKhh5U/+k2SO22U7wT+p
	qnGccw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bud2re8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 18:32:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 483IWMKL025340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 18:32:22 GMT
Received: from [10.81.25.230] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 11:32:21 -0700
Message-ID: <af65b744-7538-4929-9ab4-8ee42e17b8d1@quicinc.com>
Date: Tue, 3 Sep 2024 11:32:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] PCI: qcom: Add equalization settings for 16 GT/s
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>, <quic_msarkar@quicinc.com>,
        <quic_kraravin@quicinc.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Niklas Cassel <cassel@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240821170917.21018-1-quic_schintav@quicinc.com>
 <20240821170917.21018-3-quic_schintav@quicinc.com>
 <20240826075505.zg3tr7abs5rotkjo@thinkpad>
Content-Language: en-US
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
In-Reply-To: <20240826075505.zg3tr7abs5rotkjo@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wC_49uT40JyFPI3FlYlOaTyD4Kck3Wmv
X-Proofpoint-ORIG-GUID: wC_49uT40JyFPI3FlYlOaTyD4Kck3Wmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030149



On 8/26/24 00:55, Manivannan Sadhasivam wrote:
> On Wed, Aug 21, 2024 at 10:08:43AM -0700, Shashank Babu Chinta Venkata wrote:
>> During high data transmission rates such as 16 GT/s , there is an
>> increased risk of signal loss due to poor channel quality and
>> interference. This can impact receiver's ability to capture signals
>> accurately. Hence, signal compensation is achieved through appropriate
>> lane equalization settings at both transmitter and receiver. This will
>> result in increased PCIe signal strength.
>>
>> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware.h  | 12 ++++++
>>  drivers/pci/controller/dwc/pcie-qcom-common.c | 37 +++++++++++++++++++
>>  drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  3 ++
>>  drivers/pci/controller/dwc/pcie-qcom.c        |  3 ++
>>  5 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 53c4c8f399c8..50265a2fbb9f 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -126,6 +126,18 @@
>>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
>>  
>> +#define GEN3_EQ_CONTROL_OFF			0x8a8
>> +#define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
>> +#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE	BIT(4)
>> +#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC	GENMASK(23, 8)
>> +#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
>> +
>> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
>> +#define GEN3_EQ_FMDC_T_MIN_PHASE23		GENMASK(4, 0)
>> +#define GEN3_EQ_FMDC_N_EVALS			GENMASK(9, 5)
>> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA	GENMASK(13, 10)
>> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA	GENMASK(17, 14)
>> +
>>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>>  
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
>> index 1d8992147bba..e085075557cd 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
>> @@ -15,6 +15,43 @@
>>  #include "pcie-designware.h"
>>  #include "pcie-qcom-common.h"
>>  
>> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
>> +{
>> +	u32 reg;
>> +
>> +	/*
>> +	 * GEN3_RELATED_OFF register is repurposed to apply equalization
>> +	 * settings at various data transmission rates through registers
>> +	 * namely GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
>> +	 * determines data rate for which this equalization settings are
>> +	 * applied.
>> +	 */
>> +	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>> +	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>> +	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
>> +	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK, 0x1);
>> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
>> +
>> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
>> +	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
>> +		GEN3_EQ_FMDC_N_EVALS |
>> +		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
>> +		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
>> +	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
>> +		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
>> +		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
>> +		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
>> +	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
>> +
>> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
>> +	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
>> +		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
>> +		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
>> +		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
>> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
>> +
>>  struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
>>  {
>>  	struct icc_path *icc_p;
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
>> index 897fa18e618a..c281582de12c 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-common.h
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
>> @@ -13,3 +13,4 @@
>>  struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path);
>>  int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem, u32 bandwidth);
>>  void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
>> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index e1860026e134..823e33a4d745 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -455,6 +455,9 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>>  		goto err_disable_resources;
>>  	}
>>  
>> +	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
> 
> Abel reported that 'pci->link_gen' is not updated unless the 'max-link-speed'
> property is set in DT on his platform. I fixed that issue locally and this
> series will depend on those patches.
> 
> Provided that you are having issues with your build environment as discussed
> offline, I'd like to take over the series to combine my patches and address the
> review comments. Let me know if you are OK with this or not.
> 
> - Mani
> 

Sure Mani.You can include my patches in your series.

Thanks
Shashank
>> +		qcom_pcie_common_set_16gt_eq_settings(pci);
>> +
>>  	/*
>>  	 * The physical address of the MMIO region which is exposed as the BAR
>>  	 * should be written to MHI BASE registers.
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index ee32590f1506..829b34391af1 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -280,6 +280,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>>  {
>>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>  
>> +	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
>> +		qcom_pcie_common_set_16gt_eq_settings(pci);
>> +
>>  	/* Enable Link Training state machine */
>>  	if (pcie->cfg->ops->ltssm_enable)
>>  		pcie->cfg->ops->ltssm_enable(pcie);
>> -- 
>> 2.46.0
>>
> 

