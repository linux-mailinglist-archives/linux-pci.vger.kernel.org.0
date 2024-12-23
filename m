Return-Path: <linux-pci+bounces-18972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E969FB045
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 15:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29C1189121F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5CF1B415B;
	Mon, 23 Dec 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DCBhTADY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC6224D7;
	Mon, 23 Dec 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964545; cv=none; b=mYtezZ7ZC7yWLqyV8TX13jT+VSkOsEITECpGuY9XLtBgOxE3FJRtcy3ZduZ4r8iyxGC7z98XZ3U3wbPkWEJCtOCd785ZzoMTJQU8Yyq1lokOmwurIQN9mGzLih2jjhE+ZIJSXVuCCg24d6LQlSA96ovWRWohjmnif+uDOnSx2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964545; c=relaxed/simple;
	bh=vJZ3Uk6iPVe0ZZIcXecDwxXO5IBElB7XlJUMQqMt6zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BtwNMf72c+t/grpdf7lOz/BxYz1UDiRwYa1vg721FEueXM3drPLe8VlsxgdW6mh41Tu/ZI9k9QwLbMr9DvqCgm74nAhN4TNn0sHcmFicFMq6JlF8m1nTlNnqVLMP5RqdBIdBSZ6CJUQoVRgyBwdy8nSLKNGbr3VwiaLAnb8m6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DCBhTADY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNBVf5m006918;
	Mon, 23 Dec 2024 14:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6tkD8uSfn8nZqsLFTy9uQSJ8FJ9RYK5Kc4Pqit5t+fk=; b=DCBhTADYbEju+VXa
	Ln5U2FPXfulW48L2W85ituuQLEwjeQCAhRGnjsW6UDPczdeUVFv5CY6lahXYn8x1
	scsfaUvG6XCyuEgHsF/aWgDjGwSRcd6op5lZ4O0w6Y5Ci1ORMQFZ2JkRDyWDh7sy
	C0Nuv4a9+s4URljhnzApb31Rpj5x80f9Qw5FTYqSFdQd2oyDrVQj0W5dpnwf2Amm
	p8NKdK0Wrb1adrUSg65nnQrfoEpf8YmGd45BxQ46RAVXst7tpyp0cya2gAowLeNV
	lf8aklQS4XN7v3MOfmQuN2uP9g+EiGZO9mfSqSN3379G0moLTuWjiNjlU5zX7eq4
	1ZxMcQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q72n8dru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 14:35:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNEZZqu028171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 14:35:35 GMT
Received: from [10.216.2.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Dec
 2024 06:35:29 -0800
Message-ID: <47c9a897-cbe3-1423-b851-cf1efb11a5dc@quicinc.com>
Date: Mon, 23 Dec 2024 20:05:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Helgaas" <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <quic_mrana@quicinc.com>, <quic_vbadigan@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
 <20241223-preset_v2-v3-1-a339f475caf5@oss.qualcomm.com>
 <93ff7098-a77a-48a1-a14e-de23940bc763@oss.qualcomm.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <93ff7098-a77a-48a1-a14e-de23940bc763@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1GyqAP6odFFc1DjkeshuLYyeYJ2emYEj
X-Proofpoint-GUID: 1GyqAP6odFFc1DjkeshuLYyeYJ2emYEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=478 spamscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230131



On 12/23/2024 5:06 PM, Konrad Dybcio wrote:
> On 23.12.2024 7:51 AM, Krishna Chaitanya Chundru wrote:
>> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
>> rates used in lane equalization procedure.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
> 
> Does this also apply to PCIe3?
> 
> Konrad
>It will be applicable to PCIe3 also, I will update this in next patch

- Krishna Chaitanya.


