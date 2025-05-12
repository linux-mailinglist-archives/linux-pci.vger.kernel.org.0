Return-Path: <linux-pci+bounces-27568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4CAAB32AD
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D24A1885914
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A377433A0;
	Mon, 12 May 2025 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SZN6k0q9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E51EB3D;
	Mon, 12 May 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040613; cv=none; b=rB0j0WbL9QAODFul7rXsp+4xUuO18J1+9ZUhHbEVG0OyeeOY/YcaKop335YcHjyinLaMTM2LTgMprfIosGS2eqU5dihROvWS2XyWB/Lj/5r1fwAoHW1omL9JuIHA7rNfWUYSLiNL+Lho7hy2uA1G3M3WTZEH+28/edqPPxrm7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040613; c=relaxed/simple;
	bh=rsshUYA/LRWlmxUYnBypRPS7L2QMCx+Gv5FRHPTOtA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PdQmhvIXE4Eg2uyCtuWcei3whcoqa4akT1/C7FM9wYz6dIE3wmsLnwyp5/CucWD1UcEevw+patM36S+plns7jq3gk2GZ+Btob2OkkRCjMeeYKM4ZAaPzFeaHScCC1e15QniXQrlARYUs9ynDpPs37xoPLI15UWB2QmLCXoag4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SZN6k0q9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BM1to9010230;
	Mon, 12 May 2025 09:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V/SjLHQBRX2ja8oprIqQBFz8Ft8CAPXfkAoMHk7fFCI=; b=SZN6k0q9EzYwlqGW
	nY11ZtMAtGfoWR5c/fK7lNqenesB45uOL/kK+hrG/+g2/akgustWRrLU+6LJ0/DZ
	GiEXuocpNDT1y7/axs5vegt10V6l8N3lZxHUo8U8fnYPcgvZwbJwTzN41cXu/20A
	PwAay/60aeB15JCuIuVPTkUrg4LX7NONow1NXq4fFhgAHnFAAfSl6t//+fcx82CI
	9fPqOO3wBUIOjMVJITjcdcvILmTCFYCWJjfH/mBa8K8GZpDrhylrFzSRR2i3V+fV
	iFQ5WPN68n+5WgzAfUkGn1zUR+OPqqVomXkVoqPlE1K2wCeVKDT29b5MWkAFTVoZ
	jwvC3Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hv5qc1d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:03:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54C93JDu026417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:03:19 GMT
Received: from [10.253.34.155] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 12 May
 2025 02:03:13 -0700
Message-ID: <37b5681b-ebf5-4956-8111-b53383dce755@quicinc.com>
Date: Mon, 12 May 2025 17:03:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] PCI: qcom: Add support for QCS615 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <neil.armstrong@linaro.org>,
        <abel.vesa@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_qianyu@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
 <20250507031559.4085159-6-quic_ziyuzhan@quicinc.com>
 <20250507-competent-meek-prawn-72badf@kuoka>
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250507-competent-meek-prawn-72badf@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=DqtW+H/+ c=1 sm=1 tr=0 ts=6821b958 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=xwpoersD-4fSveQz36wA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UlH3xmLVWF4q9bbSi8q9-QGJjGEG42fe
X-Proofpoint-GUID: UlH3xmLVWF4q9bbSi8q9-QGJjGEG42fe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5NSBTYWx0ZWRfX2DTo/7znvrll
 w6MDuiEIrnfHXP4By3vbxklMKXgEB5MmWkMlUBilg+iPSo9JM9hMFvIa+8zRsShbwxMfjC0vPHv
 Y555rcRIZcTTMzWKTjNkxUm0NAbo0uwROM57U8OeFjdKCyPLZlBvNxHVNumWysknYA86JPhqfPW
 9VbWrD7d1x/a839tYyYbVL0E16YYSgKY3aQqGum9Fhhqw58SqorlJpCX71bDBsD419bLLoBU1WM
 WHnsLL45JZ4CINoxwTBohDPZG9EeYBobX8ovEBsmAeou2rLGrG49Fn6C88KA4KTdseAK9on7Wj8
 Ilj3qTrSqoDAepOQ8OK2sCinGPWHs2Fn/vmxdFGvVMJV0fCspBi56hjQ80o56XWraziV7pI0GFR
 v4TKYMibAMClTes8N9TpLjIWaKwwnPfMYDqah8moN5/CnpvRWI880oAflHXWP3rKXDBmZzve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505120095


On 5/7/2025 1:18 PM, Krzysztof Kozlowski wrote:
> On Wed, May 07, 2025 at 11:15:59AM GMT, Ziyue Zhang wrote:
>> Add the compatible and the driver data for QCS615 PCIe controller.
>> There is only one controller instance found on this platform, which
>> is capable of up to 8.0GT/s.
>> The version of the controller is 1.38.0 which is compatible with 1.9.0
>> config.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index dc98ae63362d..0ed934b0d1be 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1862,6 +1862,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>>   	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>>   	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
>>   	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
>> +	{ .compatible = "qcom,qcs615-pcie", .data = &cfg_1_9_0 },
> Why? It's compatible with other entries, so why adding redundant entry
> here?
>
> Best regards,
> Krzysztof

Hi Krzysztof

If I use the compatible entry for qcs615 in the driver, do I need to
add qcom,qcs615-pcie to qcom,pcie-sm8550.yaml, or should I create a new
YAML file specifically for qcs615-pcie? Given that the PCIe cores on
qcs615 and sm8550 require different clocks, is it acceptable to combine
them in qcom,pcie-sm8550.yaml?

BRs
Ziyue


