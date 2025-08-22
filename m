Return-Path: <linux-pci+bounces-34548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A3B314AF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 12:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16677A1FBB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345212877E9;
	Fri, 22 Aug 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFOV+fWL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A227EFF1
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857120; cv=none; b=oBChxVagFTqsAxJXWXJA7R3VuHdUUm7ykzl7D4kW5uJir3e9C3q9w50dDwrtmEUS2glVHmxpPQBdCNBEErVJEXJUvqgTgDZKmX/EF/wG20vk1A6bOXILUKY5hdzEMg0GOyhpcLFxrPmAPDAwnvxijAbhRHlFalkpfBdYGZ2rvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857120; c=relaxed/simple;
	bh=KivU5RnfA0zCwbsH7zhExGKtReC3rbkiFiOi0NUu8JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQCQUMP8OjUNu6OzdkDbXtavEf4ANzp06U8rslrOygyGnoh4Dcey5iXPgxjQAmiVzPvfZ0bn2N9DJIz+4f04EVszZqkJUDte7SsgPF8LWjtT3RLpZOzRLpLgVM7maIgvPQGOmdrbPM4nAJ+NvVIYM2A1ApHcYgh82XEJpPK4iF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFOV+fWL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UWh1006750
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 10:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NCvb4E87MdnkwFWFQpgaGoK+/UWKLd0ckk9/uB8fxpI=; b=gFOV+fWLijaslLma
	A9XqpoRAKL4OPj1l1BTVvFvigN6fQ/5oXcLvh1AkfQ1phE5QY85wqYHzG3EUAO4o
	AajQcO5PCy9VAtP4uI/4dGv0ZzShI8AsgTwfq1xwFCLv/0LPmynBt5Smv/E3+R9D
	SC6GYK/YDOPW+OTy2JbKDmuDNtfu4AjSbimMahTTqAJsOuW6oHxOg36wdINf/KxP
	pnmCJMkgL+aSBAZ64BwF6mGNz9Dewgrjw1tD3EQG9HZYTq8C8kxbz9X49B4KgEpc
	6tnGmO/fv9ZNLQwM1hTOwLEys2rXsFWep8nI6/TS1t/VKrN0Wg2O8kwkW9D38ykj
	GV/MlA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290t5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 10:05:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458264c5aso22801625ad.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 03:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857115; x=1756461915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCvb4E87MdnkwFWFQpgaGoK+/UWKLd0ckk9/uB8fxpI=;
        b=ohWlQzsNb2jVbmJEzhOWQ0+lJz8FSu3wQFYl7w9X7KrnRMOcxvJlRRhzQctEsDX1Id
         SIP3GaTBV2wyjjvzOJHBTMJ0v2EVRDZE9tNwbnZDOxw/xERQR/mTi9v7J/JI2CvGreuj
         awwSZaM0J8DtaD5413Am2F5/AHrfchI+dQyRxyFtdfKwGH+v6Qo7TZgCTNy2iynZbx8n
         58dk3LK09zRFuW4pWZw7IvZfbCqdPjMzQGMjWDhLMtCRSzHRBfmq/YR6UWSDlk7WQ9+N
         bMGMy2Gs0vfnQ7OlztM3TI/jebwpxz+/tJiBgOS0a7n5+FPmywUA0y+1vHsOeiAf6Qdl
         bQSg==
X-Forwarded-Encrypted: i=1; AJvYcCWdsYKnqpPwKQLFHXQfB1Z9NTLr06Jn/RwR7l3CM/Ah19BLX/PjeCdHc9mIkihpMcYTbeWksnrGo+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWQK43EiURqbWSKeBjGxYc5Uc0A/AQPD8m+BNio/EXglj0FVm
	0I9kYfzyKRJlnXY1oE2cvm1uGzqhLEX4zut15U4P/SpgmZfu4xHnnmWE3GbIFYT3QydxBQnCBFl
	86oNDyuwobOxQc2c2rfJSpFhA7XPx1O39SD+pJlXkyYm1oBEpIRy8RUvcyku0Xb0=
X-Gm-Gg: ASbGnctghru/Z0J0tDV3FIDy2fHhPGltruwDMlZz/RPFlNL67JUsJ0BQEcgipN5MNxv
	V0OtkzSrRPUwULdwZLhi9mr5+fSy/Di3LBAtTHjWKzwKP5vqjzOoZ2zgZkJgTqDS9LtPqAFgT/k
	eIfMS+2EUicaNWhHjKBPsGmp+/LiD/aVsft58/vmjE/qAd1C0w2jC/Hu2N2KR78HVm4kKdOvd7u
	2fJVc4BaJciUsKGRRK4zZNu8NBilAeUtucUUm1pK9W88PlnsLLDHidBujnzgoHqUKip2QUHt4Un
	20Pbm2mvVOhmxqeXJKPYGYWaaQ5AOjedDIbVdS7qvuBbG2tOI40C5wcdVrwFh3vwcsnkEYfopr2
	brDUGF+69DEXbDjTFRVqwDM0XiVXPOJo=
X-Received: by 2002:a17:903:22cc:b0:240:640a:c57b with SMTP id d9443c01a7336-2462ef1f7bamr36120125ad.37.1755857114845;
        Fri, 22 Aug 2025 03:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHShlcLRCyxd3es3abUH//R1uFG+bwmxmXbbL+TYec1DVJUwY5M/qqhUXum/j4nkYom6lZREg==
X-Received: by 2002:a17:903:22cc:b0:240:640a:c57b with SMTP id d9443c01a7336-2462ef1f7bamr36119655ad.37.1755857114355;
        Fri, 22 Aug 2025 03:05:14 -0700 (PDT)
Received: from [10.133.33.128] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32513902819sm2098106a91.14.2025.08.22.03.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 03:05:13 -0700 (PDT)
Message-ID: <b43382fc-a2c3-4c6b-b462-0cabf7a2103d@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 18:05:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] PCI: qcom: Add equalization settings for 8.0 GT/s
 and 32.0 GT/s
To: Manivannan Sadhasivam <mani@kernel.org>,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com
References: <20250819071649.1531437-1-ziyue.zhang@oss.qualcomm.com>
 <20250819071649.1531437-2-ziyue.zhang@oss.qualcomm.com>
 <z54p5x5u56u7dprrlv3obzhxotjgimbufa2spajoqvnlrevgdd@4dejnkmiegrh>
Content-Language: en-US
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
In-Reply-To: <z54p5x5u56u7dprrlv3obzhxotjgimbufa2spajoqvnlrevgdd@4dejnkmiegrh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a840dd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=uZ_Y6Hf0VBP1xoXJwNUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: eIOwMAqvET171_sN28nduGJbMcMX_nSb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3VfUNzKfjPtW
 LvvYval6zm7uW8qRqPUuSvy0RLax4ayyfplP15kS/V+QSe/oUwPeLzJD5i+h6an2/KNDAJnJDj9
 hMG7tOiWnDu4uYgQDHUp+xpsom5l7zIYoMegALqShW5tH5qXziqk073ia7PcgYtLgtRQXRwqw8A
 Tquj1WYIwbZEvjGpy9vCGljxBG15RAABttHY6NDK5F0dY56Q33q7u/8HNTV2cfFirJJsSsg2gPX
 r4/d6yC+Ps9+FzWlyZq1xM4+1p2+F4N282FI/F4s9DPT6T4U9Foc3r3QcKGPwtbkvq1Z2OZ3pKx
 71pCZPtKTSGQwy87aaYalmaKhMrknEm9dhOUmVjZX7BJ/J41zJ0EWsZOxhUtDgwgadeMNdzzZr8
 6IHScPWp9saOLwR/G6ck5fdUbmcCnw==
X-Proofpoint-ORIG-GUID: eIOwMAqvET171_sN28nduGJbMcMX_nSb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/22/2025 4:06 PM, Manivannan Sadhasivam wrote:
> On Tue, Aug 19, 2025 at 03:16:46PM GMT, Ziyue Zhang wrote:
>> Add lane equalization setting for 8.0 GT/s and 32.0 GT/s to enhance link
>> stability and avoid AER Correctable Errors reported on some platforms
>> (eg. SA8775P).
>>
> 
> So this is fixing an issue, right? Then you should add relevant Fixes tag. I
> guess the tag here would be the commit that added SA8775p.
> 
>> 8.0 GT/s, 16.0 GT/s and 32.0 GT/s require the same equalization setting.
>> This setting is programmed into a group of shadow registers, which can be
>> switched to configure equalization for different speeds by writing 00b,
>> 01b and 10b to `RATE_SHADOW_SEL`.
>>
>> Hence program equalization registers in a loop using link speed as index,
>> so that equalization setting can be programmed for 8.0 GT/s, 16.0 GT/s
>> and 32.0 GT/s.
>>
>> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>>   drivers/pci/controller/dwc/pcie-qcom-common.c | 58 +++++++++++--------
>>   drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +-
>>   drivers/pci/controller/dwc/pcie-qcom.c        |  6 +-
>>   5 files changed, 41 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index b5e7e18138a6..11de844428e5 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -123,7 +123,6 @@
>>   #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
>>   #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>>   #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
>> -#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT	0x1
>>   
>>   #define GEN3_EQ_CONTROL_OFF			0x8A8
>>   #define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
>> index 3aad19b56da8..cb98e66d81d9 100644
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
>> +	u16 speed;
>> +	struct device *dev = pci->dev;
> 
> Reverse Xmas order please.
> 
>>   
>>   	/*
>>   	 * GEN3_RELATED_OFF register is repurposed to apply equalization
>> @@ -19,32 +21,40 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>>   	 * determines the data rate for which these equalization settings are
>>   	 * applied.
>>   	 */
>> -	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>> -	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>> -	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
>> -	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
>> -			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
>> -	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
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
>> +	for (speed = PCIE_SPEED_8_0GT; speed <= pcie_link_speed[pci->max_link_speed]; ++speed) {
>> +		if (speed > PCIE_SPEED_32_0GT) {
>> +			dev_warn(dev, "Skipped equalization settings for speeds higher than 32.0 GT/s\n");
>> +			break;
>> +		}
>>   
>> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
>> -	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
>> -		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
>> -		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
>> -		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
>> -	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
>> +		reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
>> +		reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>> +		reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
>> +		reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
>> +			  speed - PCIE_SPEED_8_0GT);
>> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
>> +
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
>> index 60afb4d0134c..aeb166f68d55 100644
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
> 
> This condition has existed even before this patch, but just noticing this
> possible issue. So if 'max_link_speed' is > 16 GT/s, we do not need to set lane
> margining? We used the same logic to set equalization setting earlier also.

Lane margining is supported for 16 GT/s and 32 GT/s. The settings are
dependent on phy design. For a specific phy, they have same settings
for 16 GT/s and 32 GT/s. Perhaps we can get the settings from devicetree
and program them in a loop.

But I'm not sure why we need to program it. It will no affect singal
quality and only required when user wants to collect margining info.

- Qiang Yu

> 
> - Mani
> 


