Return-Path: <linux-pci+bounces-29848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B5BADADB6
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7694C3A5C93
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB1275112;
	Mon, 16 Jun 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H1IoBz+p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74B13B7AE;
	Mon, 16 Jun 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070853; cv=none; b=OAe9eqZf9JlT+m0p/MX2s+gZQLCc6fe9RyDDCoD3H78nVqs3yj0bPEKpr2BlxTAXI0Aro9K/ulR2L3NLNcr1r3CN9gUiC33i2CD9RTCio4l3YrQmN6pyc0vUuSW4Afb9V7dR8U7IFu6sQ1nDX0stMsqTsi2zb/Kw/nATQ4IWNlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070853; c=relaxed/simple;
	bh=l26Y1UKzSX3COjgMaGEwitOzzoKwdFgUTFRPib34s6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FBZA6SzPCjqIoONTup5XZRF1j5v7zH/AERCrFgVSNUWKyb53Elai0PDwxaR8fCE3ehmIjEXDQmpiqMqziEznHF61R3LAhvt+esJ1TbEdIwXJo9OBI+NVSqiKB8HkWJ63FZiHfnRURqf0inbMVmX5AwpQhL3hO/70R/YGpgqJBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H1IoBz+p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8TWXl025998;
	Mon, 16 Jun 2025 10:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pVoXjpsfwQSE3a+lpBhScYzkZsvWjpI8XcyTjY56B+E=; b=H1IoBz+psq6931Z4
	7A7BUtUW4aKB9eSM49lm0B4gNKGe2Yd64Gbuus2kKe/ZnmcOgK5YoTFa/nbM3JSI
	cIHkctRi7Zdo5ak6orwQE1rKv47O7lNPY3maz3jIDQ8MAJNsE+7W3/ADtBRTe1Y+
	CFoxa9LuH3NDf0ISOscsEUMQoMd9g54sZFIDAg8EKHikHqnUHk0z0YZMnVTNJYlP
	ENNpyyM1wJ48EcfzSU/bdvX7LAO/0k7mknFi6EeRjkpPXNU9EkbnaGq+0HDx/ACV
	+77y2DevPNV9+yjoT5m4f1i08VfaZcktBaT9eCU39tVi2/Wzc6tnke1IGSoWX5sS
	zRNKYA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791h9463a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 10:47:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55GAlJgl016618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 10:47:19 GMT
Received: from [10.253.79.108] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Jun
 2025 03:47:13 -0700
Message-ID: <9ea68c8b-59ed-48a5-9289-861ae6077fcf@quicinc.com>
Date: Mon, 16 Jun 2025 18:47:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: qcom: Add equalization settings for 8.0 GT/s
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <bhelgaas@google.com>, <johan+linaro@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <neil.armstrong@linaro.org>,
        <abel.vesa@linaro.org>, <kw@linux.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <qiang.yu@oss.qualcomm.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250611100319.464803-1-quic_ziyuzhan@quicinc.com>
 <20250611100319.464803-2-quic_ziyuzhan@quicinc.com>
 <c24314dd-229f-4e26-befb-1491a5ca4037@oss.qualcomm.com>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <c24314dd-229f-4e26-befb-1491a5ca4037@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8LJfrerG8c1opMcQiaovC795OGelrsaa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NyBTYWx0ZWRfXxBBRb/eK/o5Q
 HqQ0DNtooDndzlhXWc0gkjtz87y2loGbHchaoqD1d52G5DihuvtMY7fajacifmV4krb+NvqNSYs
 IMRk+fCQrDdKbxlpF+hGt6LALY02QJHmPv8YKQB2G+JIIBVsm0Gr5dSBEYg1bymxfWR1rkpRBiC
 P2K7EEvVxmW28QIh/cAZNW2e7a6iIiXTzThViLtBueESwUi1ogcn6Fsy3YHUal1czx/2480jNIw
 L2JjVb7ziromU1vz+O3sFHu//NPNcGLfPX4d3ym5OMKIqwkY2jTfZEob4OOpRZPlG8yhdK5Pnhv
 P9UXluBFeZqd5vAI6yaBV8Xi0aKfwxxX+WVoS0czhOhRR7S/UD0abNk9aBuT2iEXUzoa5ITN45b
 3R8vUwl/e1WqmCXOY5KfHuI4XhnCJ87ipZvTc6A1lCFvFgHSVKP1qDa837BGSXdj98ZQZJeA
X-Authority-Analysis: v=2.4 cv=UL/dHDfy c=1 sm=1 tr=0 ts=684ff639 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=Ci0Lskn0Otf-CQ4wiN4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8LJfrerG8c1opMcQiaovC795OGelrsaa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160067


On 6/11/2025 11:31 PM, Konrad Dybcio wrote:
> On 6/11/25 12:03 PM, Ziyue Zhang wrote:
>> Adding lane equalization setting for 8.0 GT/s to enhance link stability
>> and fix AER correctable errors reported on some platforms (eg. SA8775P).
>>
>> 8.0 GT/s and 16.0GT/s require the same equalization setting. This setting
>> is programmed into a group of shadow registers, which can be switched to
>> configure equalization for different GEN speeds by writing 00b, 01b
>> to `RATE_SHADOW_SEL`.
>>
>> Hence program equalization registers in a loop using link speed as index,
>> so that equalization setting can be programmed for both 8.0 GT/s and
>> 16.0 GT/s.
>>
>> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>> ---
> [...]
>
>> -void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>> +void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
>>   {
>>   	u32 reg;
>> +	u16 speed, max_speed = PCIE_SPEED_16_0GT;
>> +	struct device *dev = pci->dev;
>>   
>>   	/*
>>   	 * GEN3_RELATED_OFF register is repurposed to apply equalization
>> @@ -18,33 +20,43 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>>   	 * GEN3_EQ_*. The RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
>>   	 * determines the data rate for which these equalization settings are
>>   	 * applied.
>> +	 *
>> +	 * TODO:
>> +	 * EQ settings need to be added for 32.0 T/s in future
>>   	 */
>> -	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>> -	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>> -	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
>> -	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
>> -			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
>> -	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
>> +	if (pcie_link_speed[pci->max_link_speed] < PCIE_SPEED_32_0GT)
>> +		max_speed = pcie_link_speed[pci->max_link_speed];
>> +	else
>> +		dev_warn(dev, "The target supports 32.0 GT/s, but the EQ setting for 32.0 GT/s is not configured.\n");
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
> this function could receive `speed` as a parameter instead, so that
> it's easier to parse
>
> Konrad

Hi Konrad,

On the current platform, the register write configurations for both
8.0 GT/s and 16.0 GT/s are identical, so we believe it's unnecessary to
pass ‘speed’ as a parameter at this stage.

However, I agree that if future platforms or speed modes introduce
configuration differences, it would make sense to revisit this and
consider adding speed as a parameter for better flexibility.

BRs
Ziyue


