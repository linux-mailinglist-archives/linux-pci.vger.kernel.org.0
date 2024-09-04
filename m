Return-Path: <linux-pci+bounces-12789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B696C8E7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 22:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB8D289C35
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 20:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5314A617;
	Wed,  4 Sep 2024 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iQNCbpSf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1FE14901B;
	Wed,  4 Sep 2024 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482803; cv=none; b=TNOk6HWgaqjnPYisZ+roOvJBKHIbrCzajmYBt0axLsOWNdJnxNvHC2DeQjwonZSlj0QYjZNVreQ1OPYo/KsvBesDZbsLttRVWrwylBu5OzV3hcw6YQcZqAXwCMS//h4xRHdsGbESSaTH3lgQuk/ijiwvlj5AGwRrG6rFbfy/5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482803; c=relaxed/simple;
	bh=vw+J/VIYJjCZ31M6Fi58GMcEvrKNhe1IZc5W69d4XSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hPwAh/hBaVqeH3isBfrWvNkP/eTWYvOqjksGF4EJQEkDj6zMVjQ94lCakBhmCO4izXYQsyEy3oCoBFVXxXJfGUsjglfIrn2/VhL0c2qLajOOO6tayKqEem56Oiw5xNgX1dQR7WCVfQpxooSPtzsG/+SyvMD8WLLTK810qekkTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iQNCbpSf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849lM4g031912;
	Wed, 4 Sep 2024 20:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NLURRDs5TBwe1WjxXBPM9Y+47RMOzmzBmGieeji+aaM=; b=iQNCbpSf6idQlk5T
	Ms+yAPfJv5ZlBICXenu3+KDAQT/lEbSqj0xWDh6P88cNe1Bbokhy/7aD3wZUfA7P
	AIW4ftOdCpVUGHNqdSpQBb2xXojOTwaaePCpUqPa0Rf0BZ+Rw4RS+wB35Q1fIBpI
	Ys6RY75GakwJxzEVTN+xTVdrH0EYkoE0uoQ+Zg9ueazQ8olcAooX0L2UB5pIty8s
	Dcj+x4jNGRVTC+mVneerTZlGdWI0rCQqJw3xRbeiqE2D8oBv+eZlIOGS3bXpTBv+
	1w9LjPcs/fZTbHfQxTOunke+g8RtQrgTDvpD/iP8TmwAsYlw4bw/wZM1XivodWk8
	Y96tvQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt6742p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 20:46:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484KkAwo026397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 20:46:10 GMT
Received: from [10.81.25.230] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 13:46:10 -0700
Message-ID: <941d1bfb-965e-43e4-9f34-edaf2de5d661@quicinc.com>
Date: Wed, 4 Sep 2024 13:46:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold
	<johan@kernel.org>
CC: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix
 Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
        Chuanhua Lei <lchuanhua@maxlinear.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <abel.vesa@linaro.org>, <johan+linaro@kernel.org>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>
 <ZtgqvXGgp2sWNg5O@hovoldconsulting.com>
 <20240904155233.zm3m6x3wvco35g6t@thinkpad>
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
In-Reply-To: <20240904155233.zm3m6x3wvco35g6t@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yZ_tsvi8JzuRLAhD_yL9olgx968NN90N
X-Proofpoint-GUID: yZ_tsvi8JzuRLAhD_yL9olgx968NN90N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_18,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040157



On 9/4/24 08:52, Manivannan Sadhasivam wrote:
> On Wed, Sep 04, 2024 at 11:39:09AM +0200, Johan Hovold wrote:
>> On Wed, Sep 04, 2024 at 12:41:59PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>>> From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
>>>
>>> During high data transmission rates such as 16.0 GT/s, there is an
>>> increased risk of signal loss due to poor channel quality and interference.
>>> This can impact receiver's ability to capture signals accurately. Hence,
>>> signal compensation is achieved through appropriate lane equalization
>>> settings at both transmitter and receiver. This will result in increased
>>> PCIe signal strength.
>>>
>>> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> [mani: dropped the code refactoring and minor changes]
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>  
>>> +#define GEN3_EQ_CONTROL_OFF			0x8a8
>>
>> Nit: uppercase hex since that's what is used for the other offsets
>>
>>> +#define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
>>> +#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE	BIT(4)
>>> +#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC	GENMASK(23, 8)
>>> +#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
>>> +
>>> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
>>
>> Nit: odd indentation uses spaces, uppercase
>>
>>> +#define GEN3_EQ_FMDC_T_MIN_PHASE23		GENMASK(4, 0)
>>> +#define GEN3_EQ_FMDC_N_EVALS			GENMASK(9, 5)
>>> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA	GENMASK(13, 10)
>>> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA	GENMASK(17, 14)
>>> +
>>>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>>>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>>>  
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
>>> new file mode 100644
>>> index 000000000000..dc7d93db9dc5
>>> --- /dev/null
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
>>> @@ -0,0 +1,45 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <linux/pci.h>
>>> +
>>> +#include "pcie-designware.h"
>>> +#include "pcie-qcom-common.h"
>>> +
>>> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
>>> +{
>>> +	u32 reg;
>>> +
>>> +	/*
>>> +	 * GEN3_RELATED_OFF register is repurposed to apply equalization
>>> +	 * settings at various data transmission rates through registers namely
>>> +	 * GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF determines
>>> +	 * data rate for which this equalization settings are applied.
>>
>> *The* RATE_SHADOW_SEL bit field
>>
>> *the* data rate
>>
>> s/this/these/
>>
>>> +	 */
>>> +	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>>> +	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>>> +	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
>>> +	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK, 0x1);
>>
>> How does 0x1 map to gen4/16 GT?
>>
> 
> I need inputs from Shashank here as I don't know the answer.
> 
> - Mani

GEN3_RELATED_OFF has been repurposed to use with multiple data rates. RATE_SHADOW_SEL_MASK on GEN3_RELATED_OFF value decides the data rate of shadow registers namely GEN3_EQ_* registers. Per documentation 0x0 maps to 8 GT/s, 0x1 maps to 16 GT/s and 0x2 maps to 32 GT/s. 
> 
>>> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
>>> +
>>> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
>>> +	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
>>> +		GEN3_EQ_FMDC_N_EVALS |
>>> +		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
>>> +		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
>>> +	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
>>> +		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
>>> +		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
>>> +		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
>>> +	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
>>> +
>>> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
>>> +	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
>>> +		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
>>> +		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
>>> +		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
>>> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
>>> +}
>>> +EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
>>> new file mode 100644
>>> index 000000000000..259e04b7bdf9
>>> --- /dev/null
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
>>> @@ -0,0 +1,8 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include "pcie-designware.h"
>>
>> You only need a forward declaration:
>>
>> 	struct dw_pcie;
>>
>>> +
>>> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
>>
>> Compile guard still missing.
>>
>> Johan
> 

