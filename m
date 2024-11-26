Return-Path: <linux-pci+bounces-17313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759E9D91F3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12242832E6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B6180A80;
	Tue, 26 Nov 2024 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aMEhKCAp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8131A260;
	Tue, 26 Nov 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603850; cv=none; b=r1tK4dxlcQlAly22HlN4mjbaGUls5yjOcUcWD+Iybd7Elp0pBiR2U3DOAuSryNi+GgZW2bNWhbV8X4sZ0UIlbIv8KQCgraRCfblMXuL/TS3Xr8kxg0Ka6los7qM/pMdPL/kaugiAhGjIgNDAkb5fsX8qpJScYigAaLo5eGO7N4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603850; c=relaxed/simple;
	bh=P8PZRcNd4tTQCge9mgB4g9bdXLpi4U9nQjjtlVEv4d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TUJE7lJ5ImxtSLaqhNcy/HSVrlgjut9DmnvQd5p4K9GNa0TNbm4Ixvc6shJCiQsPmjmq201yVy8Bh1xr1GZbHzevmcw1nQ/llrNwctESHq1cvkX2Z7dHVNAlBD97WGRXwNe3uqi/0y9MV4rxcofnvd57H6Csd0wY0pOB0lBKAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aMEhKCAp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ5bdgl010667;
	Tue, 26 Nov 2024 06:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	srMcnyxoj0w+hwEi9C3TsBzhfGs038zKSSvCCggophM=; b=aMEhKCApviaoiC7a
	eAZDpQfQSvEdCZqmiT//wkKRBolFVwvGG5B0ZZ4dt8dtGvr94K/sAKMi9sRBDYoa
	RvnskO0PAdByaLr1wy0W6CWnfNkamLgZu3jEGScDb2snAsyZyS6UNmUVPq1LflW9
	VYsGvjedy+BzSqEdCxHZxpny+JXrWuiuoupaBORqWe8268QFEb55ZPXtRlUmJVrB
	xEYt4sfOG04Ady1fXB0LAp0IfN57/ENcGk+VIEytx27FHhFNMzRoeUWANORjQFEh
	vjKnSerhZYaD/Ckymf7zBtDsCj+U3zFENhNk5Mp2Sdi0VUIAJ6de/9T8JDCz8+lN
	UZCkOg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434mx73ddw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:50:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AQ6obg6003071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:50:37 GMT
Received: from [10.216.8.10] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 25 Nov
 2024 22:50:31 -0800
Message-ID: <cce7507f-a2c4-6f96-f993-b9a7e9217ffa@quicinc.com>
Date: Tue, 26 Nov 2024 12:20:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <poruhxgxnkhvqij5q7z4toxzcsk2gvkyj6ewicsfxj6xl3i3un@msgyeeyb6hsf>
 <42425b92-6e0d-a77b-8733-e50614bcb3a8@quicinc.com>
 <b203d90d-91bc-437b-9b91-1085034ed716@kernel.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <b203d90d-91bc-437b-9b91-1085034ed716@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -3kNUEx0cSXvKgCcmrqpIVjVDgvfqwiQ
X-Proofpoint-ORIG-GUID: -3kNUEx0cSXvKgCcmrqpIVjVDgvfqwiQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=671 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260052



On 11/25/2024 1:10 PM, Krzysztof Kozlowski wrote:
> On 24/11/2024 02:41, Krishna Chaitanya Chundru wrote:
>>> ...
>>> 
>>>> +  qps615,axi-clk-freq-hz:
>>> 
>>> That's a downstream code you send us.
>>> 
>>> Anyway, why assigned clock rates do not work for you? You are 
>>> re-implementing legacy property now under different name :/
>>> 
>>> The assigned clock rates comes in to the picture when we are 
>>> using clock
>> framework to control the clocks. For this switch there are no 
>> clocks needs to be control, the moment we power on the switch 
>> clocks are enabled by default. This switch provides a mechanism to 
>> control the frequency using i2c. And switch supports only two 
>> frequencies i.e
> 
> 
> frequency of what, since there are no clocks?
> 
The axi clock frequency internal to the switch, host can't control
the enablement of the clocks it can control only the frequency.

we already had a discussion on this on v2[1], and we taught you agreed
on this property.

[1] 
https://lore.kernel.org/netdev/d1af1eac-f9bd-7a8e-586b-5c2a76445145@codeaurora.org/T/#m3d5864c758f2e05fa15ba522aad6a37e3417bd9f

- Krishna Chaitanya.
>> 125MHz and 250MHZ by default it runs on 250MHz, we can do one i2c 
>> write with which switch runs in 125MHz.
> 
> How doing a write is relevant? Or you want to say you can control 
> clock?
> 
> 
> 
> Best regards, Krzysztof

