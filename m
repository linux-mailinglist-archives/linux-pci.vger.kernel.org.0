Return-Path: <linux-pci+bounces-31054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F776AED569
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 09:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4551F1897B02
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEBC1FDD;
	Mon, 30 Jun 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l+eLlrqN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90714190072;
	Mon, 30 Jun 2025 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267973; cv=none; b=BUbhL7cfMs083mdGlUZd9MYCpCoI7Pl8tXGtA4nUrvBeaj+GZFYc4/3Ve9cpFvYHl3LXMwfcltX9XM9Sefs2chXAgWh8xH6apq0FS9t97fqLFPiybw2GBQAVFSPUm8Uxe413U9Z4BEu85Bh053Oc144d7AGDLuuQBGN8tTwNTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267973; c=relaxed/simple;
	bh=ToPQLK8RrAyEB6SvkYVTw/FQSTlaE0A5rAz6vEKN9RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BySWRgxT+/vgJxQWVR28mS4ZrTXexP2PatACMq6LmDfIiEPimtblf9KxycEH7gs2ons5GtvkTOQAEd60HWzaT7CWUBdPaGDbCvmB/WiryDYZs65iXA2Ob9QOq2SrC+ggLM2fcxmu/dd0a5SSy/IcgNaHKCwujnTOLFOZs5dakQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l+eLlrqN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U6GGHU002504;
	Mon, 30 Jun 2025 07:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BXT9LfuhHHaK3D0qfEOCg3V3HkEMCSsGXlJJRBerDYw=; b=l+eLlrqNKIuhiNyT
	AVddxClx1G1EpwHPddm8HYW3Rxou9ZjUYR6ErGUQMzng1lHkcrsTqqE7atldAgpB
	dlH0WB2WzZUJxcihwCebX9zwK249q7MfN6Y738g+7v1DMuXULGdBUyMUhwvL1+T3
	3lws9UDNfprM+6vyxTA9yimMy4GIAdbbOuIAjzHt8oF79yunJ8iUZpyVp97RV9FS
	8VHAUUosdoXs/QdkDgORNQDC8kElinVgNatOT6IkhL07QfnGIgGzSDs6Wylj7zHQ
	dFMqSG+ByGamK1GUfCBiK6sb56yJJ2/tDIxbGc2JNdDhuTPbM/Q+t9VlpTvYd1BQ
	MahcpQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5j8549-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:19:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U7JKCI032309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:19:20 GMT
Received: from [10.253.38.22] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 30 Jun
 2025 00:19:14 -0700
Message-ID: <8ccd3731-8dbc-4972-a79a-ba78e90ec4a8@quicinc.com>
Date: Mon, 30 Jun 2025 15:19:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] PCI: qcom: Add equalization settings for 8.0 GT/s
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jingoohan1@gmail.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <bhelgaas@google.com>, <johan+linaro@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <neil.armstrong@linaro.org>,
        <abel.vesa@linaro.org>, <kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <qiang.yu@oss.qualcomm.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250625085801.526669-1-quic_ziyuzhan@quicinc.com>
 <20250625085801.526669-2-quic_ziyuzhan@quicinc.com>
 <uakd5br4e5l24xmb6rxqs2drlt3fcmemfjilxo7ozph6vysjzs@ag3wjtic3qfm>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <uakd5br4e5l24xmb6rxqs2drlt3fcmemfjilxo7ozph6vysjzs@ag3wjtic3qfm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=68623a79 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=FO1-HDWkAmQojB1LmXIA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bBhI4LbnApoQljt5ywTwSiH7_TmMtlTR
X-Proofpoint-GUID: bBhI4LbnApoQljt5ywTwSiH7_TmMtlTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1OSBTYWx0ZWRfX1AWcsk9kD/kC
 1knmlO6pUltJ/qUCIujK1vv+vz4XmQa1gKTT1dp23N6eupwXKD9ESBtS26dS97uaxA0SPy+zHQa
 hPQv8e7VnMFxKvtqWpdtuLjhWamYQ13d3gKlLY2X1vIWAINF8DS3bn78ihslS2Bq+FJ6Aq1Ry9H
 wYZcenxTLkH8aJKmAQi7RxvPaRwf2N9uWbJo59rHJe4xxqJyQm71N38ggESkUDqeTjkM33QV0QH
 SgqRjqKrl80I3/wLTwJHGVZWrhME/8tV02/negbCLh2W0fL2/ChkJwuASFnmNi8/VCJqWNw0QVr
 cGiHX2UlZ2l3TNtLIeuIeAvCDZRt/t4ybNLGUH+WBHYlm04naKncjJ2N8hsEKxZEPFvdwFtr8eN
 /VLGllymQzoFCul0hVlR0Syb7EaC6l+vqgHqELNXvZk8bZMY9lXUQQ2pqxupTFQC9Ox/4Du0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300059


On 6/25/2025 11:58 PM, Manivannan Sadhasivam wrote:
> On Wed, Jun 25, 2025 at 04:57:59PM +0800, Ziyue Zhang wrote:
>> Add lane equalization setting for 8.0 GT/s to enhance link stability and
>> aviod AER Correctable Errors reported on some platforms (eg. SA8775P).
>>
>> 8.0 GT/s and 16.0 GT/s require the same equalization setting. This
>> setting is programmed into a group of shadow registers, which can be
>> switched to configure equalization for different speeds by writing 00b,
>> 01b to `RATE_SHADOW_SEL`.
>>
>> Hence program equalization registers in a loop using link speed as index,
>> so that equalization setting can be programmed for both 8.0 GT/s and
>> 16.0 GT/s.
>>
>> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>>   drivers/pci/controller/dwc/pcie-qcom-common.c | 55 +++++++++++--------
>>   drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +-
>>   drivers/pci/controller/dwc/pcie-qcom.c        |  6 +-
>>   5 files changed, 38 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index ce9e18554e42..388306991467 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -127,7 +127,6 @@
>>   #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
>>   #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>>   #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
>> -#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT	0x1
>>   
>>   #define GEN3_EQ_CONTROL_OFF			0x8A8
>>   #define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
>> index 3aad19b56da8..ed466496f077 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
>> @@ -8,9 +8,11 @@
>>   #include "pcie-designware.h"
>>   #include "pcie-qcom-common.h"
>>   
>> -void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>> +void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
>>   {
>>   	u32 reg;
>> +	u16 speed, max_speed = PCIE_SPEED_16_0GT;
>> +	struct device *dev = pci->dev;
>>   
>>   	/*
>>   	 * GEN3_RELATED_OFF register is repurposed to apply equalization
>> @@ -19,32 +21,37 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>>   	 * determines the data rate for which these equalization settings are
>>   	 * applied.
>>   	 */
>> -	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>> -	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>> -	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
>> -	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
>> -			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
>> -	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
>> +	if (pcie_link_speed[pci->max_link_speed] < PCIE_SPEED_32_0GT)
>> +		max_speed = pcie_link_speed[pci->max_link_speed];
> So the logic here is that you want to limit the max_speed to < 32 GT/s because
> you are not sure if 32 GT/s or more would require the same settings?
>
> If so, why can't you just simply bail out early if the link speed > 16 GT/s and
> just use pci->max_link_speed directly? Right now, 32 GT/s or more would be
> skipped implicitly because you have initialized max_speed to PCIE_SPEED_16_0GT.
>
> - Mani

Hi Mani

I'll update the code according to your feedback in my next submission.

BRs

Ziyue

>>   
>> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
>> -	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
>> -		GEN3_EQ_FMDC_N_EVALS |
>> -		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
>> -		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
>> -	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
>> -		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
>> -		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
>> -		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
>> -	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
>> +	for (speed = PCIE_SPEED_8_0GT; speed <= max_speed; ++speed) {
>> +		reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>> +		reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>> +		reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
>> +		reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
>> +			  speed - PCIE_SPEED_8_0GT);
>> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
>>   
>> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
>> -	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
>> -		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
>> -		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
>> -		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
>> -	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
>> +		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
>> +		reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
>> +			GEN3_EQ_FMDC_N_EVALS |
>> +			GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
>> +			GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
>> +		reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
>> +			FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
>> +			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
>> +			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
>> +		dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
>> +
>> +		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
>> +		reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
>> +			GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
>> +			GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
>> +			GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
>> +		dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
>> +	}
>>   }
>> -EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_equalization);
>> +EXPORT_SYMBOL_GPL(qcom_pcie_common_set_equalization);
>>   
>>   void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci)
>>   {
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
>> index 7d88d29e4766..7f5ca2fd9a72 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-common.h
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
>> @@ -8,7 +8,7 @@
>>   
>>   struct dw_pcie;
>>   
>> -void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci);
>> +void qcom_pcie_common_set_equalization(struct dw_pcie *pci);
>>   void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci);
>>   
>>   #endif
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index bf7c6ac0f3e3..aaf060bf39d4 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -511,10 +511,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>>   		goto err_disable_resources;
>>   	}
>>   
>> -	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
>> -		qcom_pcie_common_set_16gt_equalization(pci);
>> +	qcom_pcie_common_set_equalization(pci);
>> +
>> +	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
>>   		qcom_pcie_common_set_16gt_lane_margining(pci);
>> -	}
>>   
>>   	/*
>>   	 * The physical address of the MMIO region which is exposed as the BAR
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index c789e3f85655..0fcb17ffd2e9 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -298,10 +298,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>>   {
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>   
>> -	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
>> -		qcom_pcie_common_set_16gt_equalization(pci);
>> +	qcom_pcie_common_set_equalization(pci);
>> +
>> +	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
>>   		qcom_pcie_common_set_16gt_lane_margining(pci);
>> -	}
>>   
>>   	/* Enable Link Training state machine */
>>   	if (pcie->cfg->ops->ltssm_enable)
>> -- 
>> 2.34.1
>>

