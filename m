Return-Path: <linux-pci+bounces-16920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4619CF3BC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067CE1F23554
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A3F16A956;
	Fri, 15 Nov 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PqSYbWYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D914A088;
	Fri, 15 Nov 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694594; cv=none; b=MFsw/Ki8tkgJyPaSA7L9lIzce+iBTvlWfCY4yX31kaj2H6Zu9vnTq6a5AWGEA8WZKpNEyqHTr+JGYrtWUxUQ/l+YIjy0SH4wFBot/BL0EICByK+QE+uTtb+Du4BYv9mHmQ8B0wWO5oNmQkEf/9xvsjbFXoXL69oonCtsBrFOgAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694594; c=relaxed/simple;
	bh=lheEkqBX2yXREuxJwn1h4/8pG65zPH2nTt2pJuLcunQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mTrdFSVkSCYOBham001kQgfcguGIZgn/Q2KY1qetUKlSHWlg/3F07FzFBd0qcNCa57ewSpDU9xCRs9jijq2iRfLrMiJYn5VSWMck0/qVs94Ky/ZJ3pgXL57+IfWP+uz45S3R98Q8zWJ7vkuXkYp4DeXRwfpz0VH6Q+FI6v5NlOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PqSYbWYB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8RccX000955;
	Fri, 15 Nov 2024 18:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W9qPvxN6uRIi5UeMOSKj63tYe+8gD/+fSqb4QQ40A9k=; b=PqSYbWYBxbiNheYA
	t3cQ+mDW/b1gTNl6Sw650KjQ/GXpa/cchwyB6NUX77zxBb1Tu6G0mMxb4RqhlcWi
	jfd1WpVA0JLj/XV9O9/TVBZObJP+oXxJ/Kac+z8yxE5KmLGDQz4OzVhq4w3oSBam
	B8ss1Mm4IyVHW0xDF/gMl+KDuo2qKvasONMHZlx2Ng6UJeYVPG2+vJWOFDa+ha/C
	qs9xUHz3VQa0E67s6TBif9RZ9butoWpiIW68p3J3HIXaroI0h8O1QT6VpGUrX5QP
	lIjo3bL8hte2QXi3KU/OuEbv6T4Hw5Z1pfmdXSe/XlGzHZjpbzaGYWDXxkSgyAXc
	rHx04A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w9sv6tb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:16:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFIGFxb020426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:16:15 GMT
Received: from [10.110.68.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 10:16:14 -0800
Message-ID: <70cfe4b4-93dc-4e9a-b064-9ce149dcca3c@quicinc.com>
Date: Fri, 15 Nov 2024 10:16:13 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] PCI: host-generic: Export gen_pci_init() API to
 allow ECAM creation
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <jingoohan1@gmail.com>, <will@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzk@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_krichai@quicinc.com>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-3-quic_mrana@quicinc.com>
 <20241115091759.5wogqwvyaqgc7iua@thinkpad>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20241115091759.5wogqwvyaqgc7iua@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P1DlBD10Lf6OpCTHbL0xLu0gGu8KfWph
X-Proofpoint-GUID: P1DlBD10Lf6OpCTHbL0xLu0gGu8KfWph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150154



On 11/15/2024 1:17 AM, Manivannan Sadhasivam wrote:
> On Wed, Nov 06, 2024 at 02:13:39PM -0800, Mayank Rana wrote:
>> Export gen_pci_init() API to create ECAM and initialized ECAM OPs
>> from PCIe driver which don't have way to populate driver_data as
>> just ECAM ops.
>>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   drivers/pci/controller/pci-host-common.c | 3 ++-
>>   include/linux/pci-ecam.h                 | 2 ++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
>> index cf5f59a745b3..b9460a4c5b7e 100644
>> --- a/drivers/pci/controller/pci-host-common.c
>> +++ b/drivers/pci/controller/pci-host-common.c
>> @@ -20,7 +20,7 @@ static void gen_pci_unmap_cfg(void *ptr)
>>   	pci_ecam_free((struct pci_config_window *)ptr);
>>   }
>>   
>> -static struct pci_config_window *gen_pci_init(struct device *dev,
>> +struct pci_config_window *gen_pci_init(struct device *dev,
> 
> Please rename the API to something like 'pci_host_common_init()'.
> 'gen_pci_init()' is fine within the driver, but doesn't look good when exported
> outside.
ACK

> - Mani
> 
>>   		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops)
>>   {
>>   	int err;
>> @@ -48,6 +48,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
>>   
>>   	return cfg;
>>   }
>> +EXPORT_SYMBOL_GPL(gen_pci_init);
>>   
>>   int pci_host_common_probe(struct platform_device *pdev)
>>   {
>> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
>> index 3a4860bd2758..386c08349169 100644
>> --- a/include/linux/pci-ecam.h
>> +++ b/include/linux/pci-ecam.h
>> @@ -94,5 +94,7 @@ extern const struct pci_ecam_ops loongson_pci_ecam_ops; /* Loongson PCIe */
>>   /* for DT-based PCI controllers that support ECAM */
>>   int pci_host_common_probe(struct platform_device *pdev);
>>   void pci_host_common_remove(struct platform_device *pdev);
>> +struct pci_config_window *gen_pci_init(struct device *dev,
>> +		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
>>   #endif
>>   #endif
>> -- 
>> 2.25.1
>>
> 

