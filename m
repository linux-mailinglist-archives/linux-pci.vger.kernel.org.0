Return-Path: <linux-pci+bounces-13477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665359851B0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888ABB23026
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC5C14B088;
	Wed, 25 Sep 2024 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UacvM0WY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEF20E6;
	Wed, 25 Sep 2024 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727236650; cv=none; b=LplnWfJqwebI4159X5k6WR/vuoKN5++tI3H5+QAd+xdqErk4Lrf8dU6BfAvhvM/5GOfACqA0zxabh8X/a9CYDojG8R6Qxb5fYWNFArjK5wFBO/zZVLs2n0x2De1+sQW3U21uNupQWBrcnLzZfjZh3zD/aDo0D/1PluwP4GbrTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727236650; c=relaxed/simple;
	bh=YZVzUHAhTPtsCdRB659ZwrS37NIwIBpNnkeOsyC/mGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FXsbKC8bGDVO+1ZdWvrxHc4wxdNrSbVan4xZ5qLBxm9Qxf/kG6TIGE5YaOQp3+4/ShG6Q6uYLci38VHoXFjd+JsrnapIYjjaF8+r5R1O+jns25C72e/tvU926yXBiC5Vei0sM7uBVr2uKy8GJb4ORTpmyTE9Ddu21GWkUfg+rVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UacvM0WY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHPbm2030767;
	Wed, 25 Sep 2024 03:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CX20ZVEGJjZtDO5C6RRvh7xdr6TkKmPim/oalofyHN4=; b=UacvM0WY50vYut0l
	kP8X1l3Crye4s90m2Z+Lmqw2lI/5KeI6RZ5rji9KBIRCBYUPWBV/LE4znoWsZHQS
	Z/XnJfqR0M7TtvXoePbs8pIhiCvrbCsU/jWASWDVqDyggYy1ZepTY/lu/WDO1YH2
	4x6I5MAwQiAz71Fq89AiBib1ZWXuXHiRvtpXskGQn2RTa+EuVquya7F4ATZ72ZPe
	26m5zVstZowa+QeU5VCuhnANUihMd/oqDASkl42ZEGODK0JslX5GMj3U+no/7Zl2
	cbPiPGr6nXO7GLL8EyGpinr3MAe5HqvctzgEOWvo2gtsYvA18Rmdsyvu/d+nyJcG
	0uJq0A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6twn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:57:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P3vEWl010502
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:57:14 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 20:57:09 -0700
Message-ID: <f9456f67-0425-4ed0-8de0-17ed61e2af8e@quicinc.com>
Date: Wed, 25 Sep 2024 11:57:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
To: Konrad Dybcio <konradybcio@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>
CC: <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-7-quic_qianyu@quicinc.com>
 <9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c8VYh7fdAYRf9m3U8TbeBHMSdcxHJSVY
X-Proofpoint-ORIG-GUID: c8VYh7fdAYRf9m3U8TbeBHMSdcxHJSVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250027


On 9/24/2024 10:26 PM, Konrad Dybcio wrote:
> On 24.09.2024 12:14 PM, Qiang Yu wrote:
>> Describe PCIe3 controller and PHY. Also add required system resources like
>> regulators, clocks, interrupts and registers configuration for PCIe3.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
> Qiang, Mani
>
> I have a RTS5261 mmc chip on PCIe3 on the Surface Laptop.
> Adding the global irq breaks sdcard detection (the chip still comes
> up fine) somehow. Removing the irq makes it work again :|
>
> I've confirmed that the irq number is correct
Actually, I verified this patch with several devices (SDX75, AIC100 and
R8169 of TP-LINK) attached to X1E80100 QCP. But I didn't meet this issue.
Each device was detected. Can you please share boot log if it is possible?

Mani, did you ever meet similar issue on other platforms?

0003:01:00.0 Class 0200: Device 10ec:8161 (rev 15)
         Subsystem: Device 10ec:8168
         I/O ports at 100000 [size=256]
         Memory at 78304000 (64-bit, non-prefetchable) [size=4K]
         Memory at 78300000 (64-bit, non-prefetchable) [size=16K]
         Kernel driver in use: r8169

0003:01:00.0 Class ff00: Device 17cb:0309
         Subsystem: Device 17cb:0309
         Memory at 78580000 (64-bit, non-prefetchable) [size=4K]
         Memory at 78581000 (64-bit, non-prefetchable) [size=4K]
         Kernel driver in use: mhi-pci-generic

0003:01:00.0 Class 1200: Device 17cb:a100
         Subsystem: Device 17cb:a100
         Region 0: Memory at 78300000 (64-bit, non-prefetchable) 
[disabled] [size=4K]
         Region 2: Memory at 78400000 (64-bit, non-prefetchable) 
[disabled] [size=2M]
         Region 4: Memory at 78600000 (64-bit, prefetchable) [disabled] 
[size=64K]

Thanks,
Qiang Yu
>
> Konrad

