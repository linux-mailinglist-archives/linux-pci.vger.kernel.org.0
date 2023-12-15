Return-Path: <linux-pci+bounces-1044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E08B8141A1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 06:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291CEB21C09
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 05:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8B6FA1;
	Fri, 15 Dec 2023 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KnP+0ffK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6336AB7;
	Fri, 15 Dec 2023 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF2WU8S001366;
	Fri, 15 Dec 2023 05:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XFNIRz9sz5pLmm9sbk+725p0qlJMx3H0g4U9OyyUyXI=; b=Kn
	P+0ffKh+cgcMC/a2uEjZrC6xF00GxWm2nQV2wqlw1Bnq0PkPHeqKz/laSWQ7uuSd
	2uyz98ZiZytXbKzr9HhwlRC6a+8pxwpgXsLTxw01o50VMeuTi0KIHrfT+JC0tEnn
	1jf0dG1HxhK8C8BEdFuH7/IRPsLybVejhMgZK2DjPNh9ltuA6yDR2Ih/G5F1Ol8t
	WbkcrI+IFwfBY4nSMJWPlW5a0N9LXrbPTMxHJQ0FxQxP3tsaP/8kat3M3w054UDl
	d65esYMAV1dY0AVuHRTRO9wD0R5GuC1aoafkoFn/Z8Xm1Fxn/kTbL1iA+bZ38f8m
	81EngzMLoMViLFOSfzsg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynjacesr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:58:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF5wYHK015956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:58:34 GMT
Received: from [10.201.3.91] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 21:58:27 -0800
Message-ID: <ccb28d3c-8f48-47e1-a4e8-5f995c72ce77@quicinc.com>
Date: Fri, 15 Dec 2023 11:28:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] arm64: dts: qcom: ipq5332: Add separate entry for
 USB pipe clock
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
 <20231214062847.2215542-4-quic_ipkumar@quicinc.com>
 <CAA8EJpqJ_7CPjTs2zykqnZpm9bQ31G7Q+1CA308OdS1BNqK6GA@mail.gmail.com>
From: Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <CAA8EJpqJ_7CPjTs2zykqnZpm9bQ31G7Q+1CA308OdS1BNqK6GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g4tTtgpDSSfl_LfOuPfo2tkjzGbS6V7X
X-Proofpoint-ORIG-GUID: g4tTtgpDSSfl_LfOuPfo2tkjzGbS6V7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=876 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150034



On 12/14/2023 12:51 PM, Dmitry Baryshkov wrote:
> On Thu, 14 Dec 2023 at 08:29, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>> Add separate entry in clock-controller for USB pipe clock.
> In my opinion, there is no need to do that separately. Please squash
> into patch 9.
Sure will squash this change with patch 9.
>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index 42e2e48b2bc3..f0d92effb783 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -213,6 +213,7 @@ gcc: clock-controller@1800000 {
>>                                   <&sleep_clk>,
>>                                   <0>,
>>                                   <0>,
>> +                                <0>,
>>                                   <0>;
>>                  };
>>
>> --
>> 2.34.1
>>
>>
>
--
Thanks,
Praveenkumar

