Return-Path: <linux-pci+bounces-28059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5349ABCE16
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 06:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8149116EDFB
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 04:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C48A258CE5;
	Tue, 20 May 2025 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ok2dYX/2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E32586CF
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713970; cv=none; b=oTkTGNkYjrxrgPyAuJvL4E06rPBPJIoFNJn7IJ2KG0acQ0WCH0n74ZHIKTKYpz0ATBWtGLx2rgSqd+Bj74qziW3oyOMBHA1Q1mLdYKLCX0OKAkwl5bT8EzZdNI75HeoMZKfi3n17XJi8WOuCF+wdBQ7rWMlgdo4XE9joHsCMKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713970; c=relaxed/simple;
	bh=OjHg+Vyus8o0ZLxaz0u47ocwameFVHjmY7vBPG4yAT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAdS3qy98xVOX3jQAgRhPVtYNJtY5xtQ31Lx8gcjjD+QkUMREY3MHWhC3qW83SG6wA1rD+/wBk6yFJynQV5hOBw/9Z94DqFT5isDVg2sgTFBkmS09pMZJLZcTGkSKxjZzwzeU2oEyZp+YT6FtxQo9GlH0Lyu0QGtPY4e6pXT0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ok2dYX/2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JKjAob022751
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 04:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mRkL6ZD37aILbTjnj5L1nOvB0DmK7nmgx/7Bty5lsHA=; b=ok2dYX/2JfvIPoT5
	1EdJ6q1GigS8gpD+pcbPatWPkZVETqe0DYpUc8C50rI0AHNF6NWQuYu6OrO9zTF5
	sc7MlmfF9JG7cGOGVvPfyNhs07LnS3ykzrWV1YpJcyUdrpvOHdcEpWGkJQZYp8no
	5wFcgJJhoKju92/h2mCRC7a0zwME8nqH46J4mKl7Wha4CRpscBqrZNgGm+Z7vuwp
	6dDmpSaDx8aHL7ypmvUw1jY6rWMGHa6a6EqVy4bnYffiExWD3RWgVa0x0zqFYB+C
	WLUIPi54xiZlGU29YULaKW10p095pn4FoqRQpTL1otMeVPAECP3Iwls+a8MlwSQP
	5rlSmw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r29d2je5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 04:06:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso3300186a12.0
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 21:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713965; x=1748318765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRkL6ZD37aILbTjnj5L1nOvB0DmK7nmgx/7Bty5lsHA=;
        b=ApzNPr369YZNj06+zUvMwvKdncHwGcdfPypT5lhCueWtqgDG3GmE9/M9UYK+A0tbAi
         NtfHfPRHrpa+NhE7/yU4X4UkPUJGhfunYNue9bQzQYq0nXUGDQhb/r7eZVIcGF2vkuX+
         Ukb+Gf8syVQ03gfQkWmpJXO1uN6d9GB4EwGctpzEtuJcgsv4qL9UPb2loRUay7a73duY
         /U/LG0iwX50vPFw4dk4uScFqXorVprdiXkegfPIwdxyoGIhIJ37wluiM5/BAPTEMdFlN
         hsvHoHUsnNyZqShX5Nb41FTzIAd4yXyyavwlO6DCRCjYybd9dKUxjm3giUwkP4XZsG3N
         wniA==
X-Forwarded-Encrypted: i=1; AJvYcCVNhMh9dgrzMrdp+SBKQ+ZoWSsevxByY+j4zPypRKn/uVVWnWJJ6mLz0YV3BznMsk8eD98sX/G7v88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKXyjowshJMOmyemkC+LVFfOpF9tLN1A95/6+4p4pjz8lVj83
	dcaASW8gyVMkdsR1bkiACORq5iPpEI3BL9foogTZpfQdnQwVmRYsN2NM8MERrukcfx7EjJbFdEs
	p/V6pxjOI20xu4f7yjP8bEkMcwm1oD7qM/bBQkOPlACYrVT7+OLdUNOHAEqKv/xw=
X-Gm-Gg: ASbGnctlr24g9TqMa63/ucmYa33DQWvjXEdDzDcku1HvFThnZ2frGDnxqZhq6ouOwD4
	JYkbnx3xBPpal2hYY3NQl4IAhvjKkwcg8Zk3HNPhdGBNcW+QQ+kfdnGFmVrUzhO0HoRrcPUfpoM
	nAgWtqK4BjxrUIicPjc2HnsC8ks5KweNhdY80sF/ddA0BK6iGrk6Ljp5a28L31coxlNmv/nkWvc
	PthRaVtuf5+zCtJKWHJjOKMyoUT44rqGmDSwzsFAXS1o9jOoaojIaQxNs9BdCh8yeQyCF5Q8fJC
	MYvtTODdQuyq2wM9Ghg5isaTLNrfQrTXGddw2m70jA==
X-Received: by 2002:a17:903:1987:b0:223:5e76:637a with SMTP id d9443c01a7336-231d451906dmr235890415ad.23.1747713965022;
        Mon, 19 May 2025 21:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCF1HMD5IOIAcLUdbyDa32PLQI1LeHPs7Pwruc6NNnS2Fm+f5VrtQdL4uL+gDaDwT1GlS9+w==
X-Received: by 2002:a17:903:1987:b0:223:5e76:637a with SMTP id d9443c01a7336-231d451906dmr235890025ad.23.1747713964612;
        Mon, 19 May 2025 21:06:04 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e98009sm67639245ad.152.2025.05.19.21.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 21:06:04 -0700 (PDT)
Message-ID: <25723231-c396-2d20-aea1-5e506b44a778@oss.qualcomm.com>
Date: Tue, 20 May 2025 09:35:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 01/11] PCI: Update current bus speed as part of
 pci_pwrctrl_notify()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
 <20250519-mhi_bw_up-v3-1-3acd4a17bbb5@oss.qualcomm.com>
 <10de35f5-bec6-5df3-768d-04f88c4e3d77@linux.intel.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <10de35f5-bec6-5df3-768d-04f88c4e3d77@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDAzMSBTYWx0ZWRfXy8OYStxJoXOd
 9XDxGU7zpUd5y0hLHxP0ARptjMFrfddx5fi8tJq0jgVMFFQmkanutxRNkC8lC+Kaor+GdpJ7Nin
 tp4oQwZ6165yKetLTz9UB8smvsKl+LcG8AcuM21vOEfDsi/+L0pQeXmnjbO77OUyhEA6dTcUyzG
 d0ia9PrA6+/zwM/o7hhY/w1WGizB6UE2TI26lsbTAKs2ph9EFZpt6X8GRgDolPv5kPJnXndALCv
 ZFD8YowAIJ6W7WhQmLNVRk7qhIrXigHPl2OHyLE1RFAmXJp0raVHbyoYFPsWxLRgdjjFWEGBjeL
 JFBIN2FKykCAsdqBKSJymODhXKubeq/WEAXhjUeTq/wcLJOb1J8hyrY228bYhbcyMzH9WVVa/rT
 IiervpkNhIXSye9tPuRPwIUZYXSJZUyC1Bxy2eZPH3lkGwuXtkoU2C52MtaoZLPgwUZ2zNOy
X-Proofpoint-GUID: W4gO_FGkUuzwNddW7bs2c3ihNlNUuv4s
X-Authority-Analysis: v=2.4 cv=KLdaDEFo c=1 sm=1 tr=0 ts=682bffae cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=tf4daXCc1kDTc5M98m0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: W4gO_FGkUuzwNddW7bs2c3ihNlNUuv4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200031



On 5/19/2025 6:39 PM, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Krishna Chaitanya Chundru wrote:
> 
>> If the link is not up till the pwrctl drivers enable power to endpoints
>> then cur_bus_speed will not be updated with correct speed.
>>
>> As part of rescan, pci_pwrctrl_notify() will be called when new devices
>> are added and as part of it update the link bus speed.
>>
>> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/pwrctrl/core.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
>> index 9cc7e2b7f2b5608ee67c838b6500b2ae4a07ad52..034f0a5d7868fe956e3fc6a9b7ed485bb69caa04 100644
>> --- a/drivers/pci/pwrctrl/core.c
>> +++ b/drivers/pci/pwrctrl/core.c
>> @@ -10,16 +10,21 @@
>>   #include <linux/pci-pwrctrl.h>
>>   #include <linux/property.h>
>>   #include <linux/slab.h>
>> +#include "../pci.h"
>>   
>>   static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>>   			      void *data)
>>   {
>>   	struct pci_pwrctrl *pwrctrl = container_of(nb, struct pci_pwrctrl, nb);
>>   	struct device *dev = data;
>> +	struct pci_bus *bus = to_pci_dev(dev)->bus;
>>   
>>   	if (dev_fwnode(dev) != dev_fwnode(pwrctrl->dev))
>>   		return NOTIFY_DONE;
>>   
>> +	if (bus->self)
>> +		pcie_update_link_speed((struct pci_bus *)bus);
> 
> Why are you casting here?? (Perhaps it's a leftover).
> 
yeah it is a leftover I will remove it in next patch.

- Krishna Chaitanya.
>> +
>>   	switch (action) {
>>   	case BUS_NOTIFY_ADD_DEVICE:
>>   		/*
>>
>>
> 

