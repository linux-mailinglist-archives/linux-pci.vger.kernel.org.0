Return-Path: <linux-pci+bounces-12334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605CA962400
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1153D1F254CF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8216A38B;
	Wed, 28 Aug 2024 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wv4VEiK9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80CE1684A2;
	Wed, 28 Aug 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838753; cv=none; b=GEhgNzoHzK1K1Mz0UCOJVFuAM4uUShtzAKwNz8GBWmxuIx5mQxDLmIN4yfcCcYZNqcWhshKhUGgsfsWzhfhL5XeSzSfNF/LNM1Rob8Tjs3BX3AzW2Z2+oP43gOav/icfv2xyKVZFKNmI1sOiYi8JRFxfTE5y2jKGAGsPx3ToTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838753; c=relaxed/simple;
	bh=+Jw0FNbCjP3ywpmarbfUeXBfzS9rQcqYqfnZkY01tgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hN6CgH79ybRR9VJgNlVKnLfR4H0NRyGxM3/U8SUk9mFQnew16ulpCxdE+zsnAwEeIeAc60SoWpfoUlhYtEebL+UinOjcwSXQvuHzhMKcfVtLMfUUA7jV1ZHfZkSWJBpNnPUOpnskMFQapkYxFNzi6GnSJ8bU2zvybMxFE27MOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wv4VEiK9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLoxO3021979;
	Wed, 28 Aug 2024 09:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LZ/UZBqbrpDfh3OhZd0Fzvysdp6yYSxd2eS0/wozgjg=; b=Wv4VEiK9EMI+b4+h
	h8VJ5Cy7wTZcBh6aYAi1tgdDJeMOTZBgidrHpTQX/Q1HrLl8WKStiiEWKIwdLLQz
	ChnUNmbJ25haKVMD4xKZo+Z0NjvwOp5TwZ6t/U+R2HAcRkJRsMMhOPQV844sw0ud
	k8PgcUPIl2AqpQ1kOUU046N2GWQGZQfyKK/gras89CAhgwHWfttQxAhRdnQFaQzV
	cAwX/CYTYETNB66plMUli6Dj3R9ZT84zAL0K/wKzvCi16rFgA878gnIgA8iXyqWm
	Atu+eIKDh6xiqpUvLKJHx6S1WXvvtuvlMkywPIbyOyfsuDebhAMMW/WfGQG8Aryp
	iJaPJg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419q2xsc6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 09:52:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47S9qLPd029799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 09:52:21 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 Aug
 2024 02:52:13 -0700
Message-ID: <d79f84f1-345b-4099-b1d2-567ebfd3789d@quicinc.com>
Date: Wed, 28 Aug 2024 17:52:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] phy: qcom: qmp: Add phy register and clk setting for
 x1e80100 PCIe3
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-4-quic_qianyu@quicinc.com>
 <3rwkr4tqyki7umt75bgy6wcs2whchw2vb5ckrkqffaizxm3ssp@glkarq76vl4f>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <3rwkr4tqyki7umt75bgy6wcs2whchw2vb5ckrkqffaizxm3ssp@glkarq76vl4f>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2X_2s6x66qP3zlQeEjn_cCe0fE1nDiyF
X-Proofpoint-GUID: 2X_2s6x66qP3zlQeEjn_cCe0fE1nDiyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=955 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280070


On 8/27/2024 7:38 PM, Krzysztof Kozlowski wrote:
> On Mon, Aug 26, 2024 at 11:36:26PM -0700, Qiang Yu wrote:
>>   	if (cfg->tbls.ln_shrd)
>>   		qmp->ln_shrd = base + offs->ln_shrd;
>>   
>> @@ -4424,6 +4641,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>>   	}, {
>>   		.compatible = "qcom,x1e80100-qmp-gen4x2-pcie-phy",
>>   		.data = &x1e80100_qmp_gen4x2_pciephy_cfg,
>> +	}, {
>> +		.compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy",
> Undocumented compatible or your patch order is wrong.
OK, will put the yaml patch in front of this patch

Thanks,
Qiang
>
>> +		.data = &x1e80100_qmp_gen4x8_pciephy_cfg,
>>   	},
> Best regards,
> Krzysztof
>

