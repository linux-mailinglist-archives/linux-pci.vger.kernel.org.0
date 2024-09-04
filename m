Return-Path: <linux-pci+bounces-12790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE38996C8F7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 22:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D242285164
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16FA146D7F;
	Wed,  4 Sep 2024 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IC3xmFZG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9762A02;
	Wed,  4 Sep 2024 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483005; cv=none; b=Uf8AfToTOsyHa7i0g8C0BjQrLNzhEZoRsQK/B7EAV6DmBQd9rvKlLRjCN/Lugi4nQrhjTtcSvjFPgOMy9ejCNRlEwCSnWHOxvdW1F5Tr4jK7zQb9AYi0pB2ZvY8FOqeQYrrZStjOl6BV9IYmISw5M5+l5pjHOrjHy9Edv3rNGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483005; c=relaxed/simple;
	bh=hMDviyqPpbNkAXtWMozFCrxEkhOype3sYzn9/eDJzS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bIxxYAdxJFTCcJToIk2BpzJhLJ7zYnv4dQItgIuFvLte/dRbktZPKiQvpdlVMGu7JEafHi24s0FBOEavfci06186y6Va2ySQ5f05qqs+o7H4yAAXxI4gmdcBvdFPZCzJCDwx3iHNgqE7b/ggXcKtiyFSif7qKrrYL7kMNrlx0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IC3xmFZG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484A6ZmK006005;
	Wed, 4 Sep 2024 20:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LWxPeIqAejEe5oPCfx9IDxvc+KANAKRiwRmr9zEOadk=; b=IC3xmFZGYGZMjY7s
	PIzk3yBHisGgtox70K/Oh3DafrmAmt+hbOpl4d1p5+5EJI4CJ3IQrRWnPizrpsLR
	TV6Gnc84kzZMXDdVkGb003G9HmkYx+e1as1n8RRPM0nOHsYTLX1oEwxqVHcSV6vh
	n8+ZD6bqai3JBa5H3Mnh58W3S51IJWiO9palOD4CrFvSoojIg+Hi+QjA31UQM0xJ
	q5aWzLlasInIn/JrVH3G0x8Fu1GmpBgl7j8NduLgMq1uxpf0jves0HfLB98C5DMZ
	qY5zgMtJXV6UIqN7Gv9rk0oH935N/wcXDaXFngtoOVk5MxzSQ3PWZNfUolptKFUp
	Hl4AwQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt6742x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 20:49:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484KmAdj002821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 20:49:35 GMT
Received: from [10.81.25.230] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 13:48:10 -0700
Message-ID: <195b4937-dfba-4ef9-8381-0ba2bdbd6e4c@quicinc.com>
Date: Wed, 4 Sep 2024 13:48:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] PCI: qcom: Add RX margining settings for 16.0 GT/s
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
 <20240904-pci-qcom-gen4-stability-v6-4-ec39f7ae3f62@linaro.org>
 <ZtguJs128O-N07Eg@hovoldconsulting.com>
 <20240904160422.gcyrdrzgc47w7pbd@thinkpad>
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
In-Reply-To: <20240904160422.gcyrdrzgc47w7pbd@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3G2FaZ3_2d7nIn9G5XqtHjtOBkdK_n5p
X-Proofpoint-GUID: 3G2FaZ3_2d7nIn9G5XqtHjtOBkdK_n5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_18,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=746 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040157



On 9/4/24 09:04, Manivannan Sadhasivam wrote:
> On Wed, Sep 04, 2024 at 11:53:42AM +0200, Johan Hovold wrote:
>> On Wed, Sep 04, 2024 at 12:42:00PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>>> From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
>>>
>>> Add RX lane margining settings for 16.0 GT/s (GEN 4) data rate. These
>>> settings improve link stability while operating at high date rates and
>>> helps to improve signal quality.
>>>
>>> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> [mani: dropped the code refactoring and minor changes]
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-designware.h  | 18 ++++++++++++++++
>>>  drivers/pci/controller/dwc/pcie-qcom-common.c | 31 +++++++++++++++++++++++++++
>>>  drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>>>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 +++-
>>>  drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
>>>  5 files changed, 56 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>>> index 51744ad25575..f5be99731f7e 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> @@ -209,6 +209,24 @@
>>>  
>>>  #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
>>>  
>>> +/*
>>> + * 16.0 GT/s (GEN4) lane margining register definitions
>>
>> nit: Gen 4?
>>
>>> + */
>>> +#define GEN4_LANE_MARGINING_1_OFF		0xb80
>>
>> nit: upper case hex
>>
>>> +#define MARGINING_MAX_VOLTAGE_OFFSET		GENMASK(29, 24)
>>> +#define MARGINING_NUM_VOLTAGE_STEPS		GENMASK(22, 16)
>>> +#define MARGINING_MAX_TIMING_OFFSET		GENMASK(13, 8)
>>> +#define MARGINING_NUM_TIMING_STEPS		GENMASK(5, 0)
>>> +
>>> +#define GEN4_LANE_MARGINING_2_OFF		0xb84
>>
>> Same here
>>
>>> +#define MARGINING_IND_ERROR_SAMPLER		BIT(28)
>>> +#define MARGINING_SAMPLE_REPORTING_METHOD	BIT(27)
>>> +#define MARGINING_IND_LEFT_RIGHT_TIMING		BIT(26)
>>> +#define MARGINING_IND_UP_DOWN_VOLTAGE		BIT(25)
>>> +#define MARGINING_VOLTAGE_SUPPORTED		BIT(24)
>>> +#define MARGINING_MAXLANES			GENMASK(20, 16)
>>> +#define MARGINING_SAMPLE_RATE_TIMING		GENMASK(13, 8)
>>> +#define MARGINING_SAMPLE_RATE_VOLTAGE		GENMASK(5, 0)
>>>  /*
>>>   * iATU Unroll-specific register definitions
>>>   * From 4.80 core version the address translation will be made by unroll
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
>>> index dc7d93db9dc5..99b75e7f085d 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
>>> @@ -43,3 +43,34 @@ void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
>>>  	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
>>>  }
>>>  EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
>>> +
>>> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)
>>
>> I'd try to find a shorter symbol name here, "settings" seems redundant
>> after "set". Perhaps just
>>
>> 	qcom_pcie_common_enable_lane_margining()
>>
>> or
>>
>> 	qcom_pcie_common_enable_16gt_lane_margining()?
>>
> 
> This one looks better. Since lane margining is implemented in the receiver, we
> don't really need 'rx' in the function name.
> 
>> if these settings are indeed specific to 16 GT/s. But perhaps it's
>> better to let the helper honour pci->max_link_speed if different
>> settings will later be needed for higher speeds:
>>
>> 	if (pcie_link_speed[pci->max_link_speed] >= PCIE_SPEED_16_0GT)
>> 		qcom_pcie_common_enable_lane_margining(pci)
>>
> 
> I did thought about it during the review, but this setting claims to be for 16
> GT/s only. So I wouldn't recommend applying it to other speeds without checking 
> with Qcom.
> 
> Unfortunately, I'm on vacation for 2 weeks and have limited access to Qcom
> internal docs/chat. So won't be able to check it soon. If Shashank could check
> it, it is fine. But on the conservative side, let's stick to 16 GT/s only?
> 
> - Mani

Yes Mani I think we have to stick to 16 GT/s only for now as we haven't characterized 32 GT/s yet.


> 
>>>  void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
>>> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci);
>>
>> And maybe something similar for the eq settings for symmetry.
>>
>> Johan
> 

