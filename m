Return-Path: <linux-pci+bounces-42839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F81CAFD9B
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 13:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E49003011A95
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349FA3203A1;
	Tue,  9 Dec 2025 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XQhf3xS7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kRMhRSmJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7EC23185D
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281762; cv=none; b=psY0jnv0xUWLb90iTm2C3GJLOw2C2ezxJzW+2A0+/RoB+Y9MDuaMfRHcs7yJ9JcKkWBTQkmAr2w/HfHgIfqQbpX0l6dWUVPUwam2uBAxbziBwLxvE2QUOO0pnfPBiSZF3hPTOaBtu07nWwAW/TzLvek9NF+Gn1KDNMqNQeIZS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281762; c=relaxed/simple;
	bh=qBeHB0ao5JZDqlmxJigH+IAffilh/hYyB9z5+XIgO5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXVHOF20AHuz/y6Pz3NYPpDCDIC/OU9iNnFjWfeDYMvpXA2kV/216OmexcHEchWDIIRnZpCywa8lc1/wFUiMY7iEacmT/yzHhHYKK3gi6oWM+z7AmsDYs06nh3lgtQvzC4flxur9QJ55yemRYl+xfn9HWOcAL8c4BXmatEeiTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XQhf3xS7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kRMhRSmJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B99NMR13871163
	for <linux-pci@vger.kernel.org>; Tue, 9 Dec 2025 12:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fLQpjF8rcNb/GHQPbUcbfA7iNDbwW4pkFSVocFtz3gs=; b=XQhf3xS7bwSFGh/d
	9ERMr3ilTDk7r+GhKRgaKG8r8AxRbcUCnK6CPlm6nD6IO6pCvXeU+DsPITJVc96g
	KHgwiGKctsWJnOuQ3rew9gkzGn7GVnDjy6QMIm5qkBguI4kNqjCVfNRPVcmoNH9h
	libJRATxe91ubkFtX04M/KcD+3kIlfMt3OfxNIBnKSL5yrI8biCj8TRYp6trnjuE
	vMh1QkZfOkOSMKKLW5fyhsFCatYxMMVq50911a/yysqvQEwcf4S7OrqArMe99O+e
	d6ieKlxe1qqM7lmOs7Oin0pS7F7NyFGZdyPkn3PFH4LdTutBMMCXKVlE7re7O27o
	0+0jvA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axgs9rh2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 12:02:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29be4d2ef78so116412465ad.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765281758; x=1765886558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLQpjF8rcNb/GHQPbUcbfA7iNDbwW4pkFSVocFtz3gs=;
        b=kRMhRSmJeJkmVJ0solCPh9baMz9X+uKU+EK3UPbsA+qcUv5xhECcp6UrB/hywdynO/
         5TqIPiv8gucw10CNTXfw4dFRuEso7t5GeDyNGJJ0qbd95nUeD+SYhoBRLPq9ZOHaTbND
         FMx0zbBV7A+ES6m5A7CkXFBUUh/hCECDWrut1YvLsZhH8FPanqszWI4DF695dYxD2lMv
         7sH+kTH5TmQ+Qu4dXJkISYovrQO98llop1aI6LUrLEvcMrfMPccE5DegxxbI/kBLuttT
         tflymv2fG+U7Y+kfIZkIW+JpKqCg1JqRSPEKy3dW+jFv8fDvo1+Mfm2Vmb0mX0Gp3mB3
         Epcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765281758; x=1765886558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLQpjF8rcNb/GHQPbUcbfA7iNDbwW4pkFSVocFtz3gs=;
        b=nJtY5Xf9UKIvOvJPsb7uBHD4G+/9gt0y2CueqDWxm5wfwo+EOxAI2a4uTFdb4B+h47
         2q7ibkTwTVJOAOWbvL2WTeaDvw9/L1QsKFZ89WAx959hgQ1eiendSHkS+hjdmNxkGX1e
         fPsIGlsPV+6NVioUi1rfgtKtLsmiS2vZIYMGCXDaqhXZUj1uQPboy4GydeLEPkUSJNlj
         OBuTyVNXEmMeLBAkLE/c5Sl166MlO9hWNwALqqxd4JuejMUpyqSeBpCfRpm+6PPiB0AN
         +BgFfD0ykj40xMVFwZHvCb+VHX5mfMurVto1SyOfyIy4zSkAtwTXWMcaSfjJT8H1Wuln
         91cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYq89A/9bc3N8F92bTwwfKdZYqI9enH+JUFonTsPgl3tu3v6HkRE4tBJKMflZ9At/qids5I96UAi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37x9q7RUwK9vjb78F6XjkLidR6FyWJTVuhGRsWfVjUyVxONXt
	1BvMkVZKx0hOpOQVVQ4wd0nVUXhL4Z0hteiS8PvsmSfZek8PPcHazjGqr+IVTtEzPtdYdEs7DmA
	SagSL/r2YtZsET28E668tKkg0gwR5lUT7Unz2A23mcF7CpUyP5GBHA2saZBW36q0=
X-Gm-Gg: AY/fxX4IulbYgRkD72NVqKgdPSzg6WTHXDZ6tnE5B2h4hdoH68sDMhQdv9aRLkTUbZ4
	n3vlk9taRZsrOIjPYe2CFKX05wHi1SjnfhewxgWEE8Pnya3rJPeK1bujasvNXF9lAyzzaWW3wQZ
	SwpyOYP8BzXP5MzEvuXKPYOhUfVh/mT3GkEUaquunOBDtNIQlOS2+hRPRjckNi/yI9v/pEkS5h+
	UfH4k7NKHG0gqIbDQvHuCWApDM2LJnom3N5FsKhLE6UZP3G8HToUaPoxqt56wNLIQPvd/mK4bSk
	mOEa2GIB6XHMnisq+nAOUaYhkYCY9PFd4LDW77ZSl3/eESevLAC++NJHUZGuf7dzVqPNqGzzX6/
	MwmUqmvmbuhdJNyUPz4RlJ4RlnTv+J+v1XhqjaorGvw==
X-Received: by 2002:a17:902:e80a:b0:295:3eb5:6de1 with SMTP id d9443c01a7336-29df8710342mr122828285ad.34.1765281757457;
        Tue, 09 Dec 2025 04:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmpRlsqsFA63XiVsXWx/LKwqn4GYwjz8vftkCBcT026iGBWSKMUNsHoMZ3xSINgclwvQZ0Kg==
X-Received: by 2002:a17:902:e80a:b0:295:3eb5:6de1 with SMTP id d9443c01a7336-29df8710342mr122827895ad.34.1765281756885;
        Tue, 09 Dec 2025 04:02:36 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29e9822c308sm20083185ad.80.2025.12.09.04.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 04:02:36 -0800 (PST)
Message-ID: <5f9d44e1-1702-44ee-a908-eaad3cb35e2c@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 17:32:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] PCI: eic7700: Add Eswin PCIe host controller
 driver
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
        shradha.t@samsung.com, thippeswamy.havalige@amd.com,
        inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com,
        linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
        ouyanghui@eswincomputing.com
References: <20251202090225.1602-1-zhangsenchuan@eswincomputing.com>
 <20251202090406.1636-1-zhangsenchuan@eswincomputing.com>
 <a1b692f6-6abd-4edd-8498-9ca00cd8fc13@oss.qualcomm.com>
 <1ee0a7a9.1022.19afdf7ee9f.Coremail.zhangsenchuan@eswincomputing.com>
 <ae4592d3-872a-4e47-ac71-b5a4e43d246b@oss.qualcomm.com>
 <f90196f.10d9.19b02f3c021.Coremail.zhangsenchuan@eswincomputing.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <f90196f.10d9.19b02f3c021.Coremail.zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA4NiBTYWx0ZWRfX7cFLRipZqYDU
 q7bYjpOIZ4lkEpCbFRO0JBobXPfU2ocZaffcEse5Oh8wCvyk/JhvUkknYtnS8ivGTQkN8h8welR
 Z2wZB+J5/ioAI4vC3IG6rbJlTY2F7zfuYFJpWUhxGJALZho6fMAzyJMdWtzPGpf2JPlF8RIegVo
 6V1VIlqhh3TIzjMA/0GEMhwSaRxFARiAUEZTvP9G3LxvVmmBmZZCGOHw1zYaNQTM9gSSIBHvw0h
 wZe33hnW1JgFgwVD1zACCPQY5GG46fAcOKDuGo4PmAVJjMJhYO0IKuLD0DLhWWtlsCYC1efpape
 g/xkmWwdD6bVkgsvzd4b6bNOprTB9mYGeptvqrYDYzpw1ZLZZ/xdQE/YjUijPQlN17HoK7Jmges
 LEdIJTPlt7rYUac267wHRpeKST37YA==
X-Authority-Analysis: v=2.4 cv=ArzjHe9P c=1 sm=1 tr=0 ts=69380fde cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=h4SL0BZ7AAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=jIQo8A4GAAAA:8 a=8b9GpE9nAAAA:8
 a=hD80L64hAAAA:8 a=zd2uoN0lAAAA:8 a=8AirrxEcAAAA:8 a=mpWPMT4aAAAA:8
 a=-sBtJi5Kp24WsdYkRl4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=Cfupvnr7wbb3QRzVG_cV:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=ST-jHhOKWsTCqRlWije3:22
 a=v37LFXLKhGMj9cfQ2Zw7:22
X-Proofpoint-GUID: 3Wln3m646Yfom5rdC-SW6sZOaGSBK4RF
X-Proofpoint-ORIG-GUID: 3Wln3m646Yfom5rdC-SW6sZOaGSBK4RF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090086



On 12/9/2025 5:21 PM, zhangsenchuan wrote:
>
>
>> -----Original Messages-----
>> From: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
>> Send time:Monday, 08/12/2025 22:13:13
>> To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
>> Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
>> Subject: Re: [PATCH v7 2/3] PCI: eic7700: Add Eswin PCIe host controller driver
>>
>>
>>
>> On 12/8/2025 6:07 PM, zhangsenchuan wrote:
>>>
>>>> -----Original Messages-----
>>>> From: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
>>>> Send time:Friday, 05/12/2025 20:40:53
>>>> To: zhangsenchuan@eswincomputing.com, bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com
>>>> Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
>>>> Subject: Re: [PATCH v7 2/3] PCI: eic7700: Add Eswin PCIe host controller driver
>>>>
>>>>
>>>>
>>>> On 12/2/2025 2:34 PM, zhangsenchuan@eswincomputing.com wrote:
>>>>> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>>>>>
>>>>> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
>>>>> the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
>>>>> supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
>>>>> interrupts.
>>>>>
>>>>> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
>>>>> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
>>>>> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>>>>> ---
>>>>>     drivers/pci/controller/dwc/Kconfig        |  11 +
>>>>>     drivers/pci/controller/dwc/Makefile       |   1 +
>>>>>     drivers/pci/controller/dwc/pcie-eic7700.c | 378 ++++++++++++++++++++++
>>>>>     3 files changed, 390 insertions(+)
>>>>>     create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>>>>> index 519b59422b47..c837cb5947b6 100644
>>>>> --- a/drivers/pci/controller/dwc/Kconfig
>>>>> +++ b/drivers/pci/controller/dwc/Kconfig
>>>>> @@ -93,6 +93,17 @@ config PCIE_BT1
>>>>>     	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
>>>>>     	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
>>>>>     
>>>>> +config PCIE_EIC7700
>>>>> +	tristate "Eswin EIC7700 PCIe controller"
>>>>> +	depends on ARCH_ESWIN || COMPILE_TEST
>>>>> +	depends on PCI_MSI
>>>>> +	select PCIE_DW_HOST
>>>>> +	help
>>>>> +	  Say Y here if you want PCIe controller support for the Eswin EIC7700.
>>>>> +	  The PCIe controller on EIC7700 is based on DesignWare hardware,
>>>>> +	  enables support for the PCIe controller in the EIC7700 SoC to work in
>>>>> +	  host mode.
>>>>> +
>>>>>     config PCI_IMX6
>>>>>     	bool
>>>>>     
>>>>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>>>>> index 67ba59c02038..7c5a5186ea83 100644
>>>>> --- a/drivers/pci/controller/dwc/Makefile
>>>>> +++ b/drivers/pci/controller/dwc/Makefile
>>>>> @@ -6,6 +6,7 @@ obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>>>>>     obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>>>>>     obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
>>>>>     obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
>>>>> +obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o
>>>>>     obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>>>>>     obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>>>>>     obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/controller/dwc/pcie-eic7700.c
>>>>> new file mode 100644
>>>>> index 000000000000..cb7cdea6a94b
>>>>> --- /dev/null
>>>>> +++ b/drivers/pci/controller/dwc/pcie-eic7700.c
>>>>> @@ -0,0 +1,378 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * ESWIN EIC7700 PCIe root complex driver
>>>>> + *
>>>>> + * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
>>>>> + *
>>>>> + * Authors: Yu Ning <ningyu@eswincomputing.com>
>>>>> + *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>>>>> + *          Yanghui Ou <ouyanghui@eswincomputing.com>
>>>>> + */
>>>>> +
>>>>> +#include <linux/interrupt.h>
>>>>> +#include <linux/iopoll.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/of.h>
>>>>> +#include <linux/pci.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>> +#include <linux/resource.h>
>>>>> +#include <linux/reset.h>
>>>>> +#include <linux/types.h>
>>>>> +
>>>>> +#include "pcie-designware.h"
>>>>> +
>>>>> +/* ELBI registers */
>>>>> +#define PCIEELBI_CTRL0_OFFSET		0x0
>>>>> +#define PCIEELBI_STATUS0_OFFSET		0x100
>>>>> +
>>>>> +/* LTSSM register fields */
>>>>> +#define PCIEELBI_APP_LTSSM_ENABLE	BIT(5)
>>>>> +
>>>>> +/* APP_HOLD_PHY_RST register fields */
>>>>> +#define PCIEELBI_APP_HOLD_PHY_RST	BIT(6)
>>>>> +
>>>>> +/* PM_SEL_AUX_CLK register fields */
>>>>> +#define PCIEELBI_PM_SEL_AUX_CLK		BIT(16)
>>>>> +
>>>>> +/* DEV_TYPE register fields */
>>>>> +#define PCIEELBI_CTRL0_DEV_TYPE		GENMASK(3, 0)
>>>>> +
>>>>> +/* Vendor and device ID value */
>>>>> +#define PCI_VENDOR_ID_ESWIN		0x1fe1
>>>>> +#define PCI_DEVICE_ID_ESWIN		0x2030
>>>>> +
>>>>> +#define EIC7700_NUM_RSTS		ARRAY_SIZE(eic7700_pcie_rsts)
>>>>> +
>>>>> +static const char * const eic7700_pcie_rsts[] = {
>>>>> +	"pwr",
>>>>> +	"dbi",
>>>>> +};
>>>>> +
>>>>> +struct eic7700_pcie_data {
>>>>> +	bool no_pme_handshake;
>>>>> +};
>>>>> +
>>>>> +struct eic7700_pcie_port {
>>>>> +	struct list_head list;
>>>>> +	struct reset_control *perst;
>>>>> +	int num_lanes;
>>>>> +};
>>>>> +
>>>>> +struct eic7700_pcie {
>>>>> +	struct dw_pcie pci;
>>>>> +	struct clk_bulk_data *clks;
>>>>> +	struct reset_control_bulk_data resets[EIC7700_NUM_RSTS];
>>>>> +	struct list_head ports;
>>>>> +	const struct eic7700_pcie_data *data;
>>>>> +	int num_clks;
>>>>> +};
>>>>> +
>>>>> +#define to_eic7700_pcie(x) dev_get_drvdata((x)->dev)
>>>>> +
>>>>> +static int eic7700_pcie_start_link(struct dw_pcie *pci)
>>>>> +{
>>>>> +	u32 val;
>>>>> +
>>>>> +	/* Enable LTSSM */
>>>>> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
>>>>> +	val |= PCIEELBI_APP_LTSSM_ENABLE;
>>>>> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static bool eic7700_pcie_link_up(struct dw_pcie *pci)
>>>>> +{
>>>>> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>>>> +	u16 val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
>>>>> +
>>>>> +	return val & PCI_EXP_LNKSTA_DLLLA;
>>>>> +}
>>>>> +
>>>>> +static int eic7700_pcie_perst_reset(struct eic7700_pcie_port *port,
>>>>> +				    struct eic7700_pcie *pcie)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = reset_control_assert(port->perst);
>>>>> +	if (ret) {
>>>>> +		dev_err(pcie->pci.dev, "Failed to assert PERST#\n");
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	/* Ensure that PERST# has been asserted for at least 100 ms */
>>>>> +	msleep(PCIE_T_PVPERL_MS);
>>>>> +
>>>>> +	ret = reset_control_deassert(port->perst);
>>>>> +	if (ret) {
>>>>> +		dev_err(pcie->pci.dev, "Failed to deassert PERST#\n");
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int eic7700_pcie_parse_port(struct eic7700_pcie *pcie,
>>>>> +				   struct device_node *node)
>>>>> +{
>>>>> +	struct device *dev = pcie->pci.dev;
>>>>> +	struct eic7700_pcie_port *port;
>>>>> +
>>>>> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>>>>> +	if (!port)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	port->perst = of_reset_control_get_exclusive(node, "perst");
>>>>> +	if (IS_ERR(port->perst)) {
>>>>> +		dev_err(dev, "Failed to get PERST# reset\n");
>>>>> +		return PTR_ERR(port->perst);
>>>>> +	}
>>>>> +
>>>>> +	/*
>>>>> +	 * TODO: Since the Root Port node is separated out by pcie devicetree,
>>>>> +	 * the DWC core initialization code can't parse the num-lanes attribute
>>>>> +	 * in the Root Port. Before entering the DWC core initialization code,
>>>>> +	 * the platform driver code parses the Root Port node. The EIC7700 only
>>>>> +	 * supports one Root Port node, and the num-lanes attribute is suitable
>>>>> +	 * for the case of one Root Rort.
>>>>> +	 */
>>>>> +	if (!of_property_read_u32(node, "num-lanes", &port->num_lanes))
>>>>> +		pcie->pci.num_lanes = port->num_lanes;
>>>>> +
>>>>> +	INIT_LIST_HEAD(&port->list);
>>>>> +	list_add_tail(&port->list, &pcie->ports);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int eic7700_pcie_parse_ports(struct eic7700_pcie *pcie)
>>>>> +{
>>>>> +	struct eic7700_pcie_port *port, *tmp;
>>>>> +	struct device *dev = pcie->pci.dev;
>>>>> +	int ret;
>>>>> +
>>>>> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>>>>> +		ret = eic7700_pcie_parse_port(pcie, of_port);
>>>>> +		if (ret)
>>>>> +			goto err_port;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +err_port:
>>>>> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>>>>> +		list_del(&port->list);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int eic7700_pcie_host_init(struct dw_pcie_rp *pp)
>>>>> +{
>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>> +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
>>>>> +	struct eic7700_pcie_port *port;
>>>>> +	u32 val;
>>>>> +	int ret;
>>>>> +
>>>>> +	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);
>>>>> +	if (pcie->num_clks < 0)
>>>>> +		return dev_err_probe(pci->dev, pcie->num_clks,
>>>>> +				     "Failed to get pcie clocks\n");
>>>>> +
>>>>> +	/*
>>>>> +	 * The PWR and DBI Reset signals are respectively used to reset the
>>>>> +	 * PCIe controller and the DBI registers.
>>>>> +	 * The PERST# signal is a reset signal that simultaneously controls the
>>>>> +	 * PCIe controller, PHY, and Endpoint.
>>>>> +	 * Before configuring the PHY, the PERST# signal must first be
>>>>> +	 * deasserted.
>>>>> +	 * The external reference clock is supplied simultaneously to the PHY
>>>>> +	 * and EP. When the PHY is configurable, the entire chip already has
>>>>> +	 * stable power and reference clock.
>>>>> +	 * The PHY will be ready within 20ms after writing app_hold_phy_rst
>>>>> +	 * register of ELBI register space.
>>>>> +	 */
>>>>> +	ret = reset_control_bulk_deassert(EIC7700_NUM_RSTS, pcie->resets);
>>>>> +	if (ret) {
>>>>> +		dev_err(pcie->pci.dev, "Failed to deassert resets\n");
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	/* Configure Root Port type */
>>>>> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
>>>>> +	val &= ~PCIEELBI_CTRL0_DEV_TYPE;
>>>>> +	val |= FIELD_PREP(PCIEELBI_CTRL0_DEV_TYPE, PCI_EXP_TYPE_ROOT_PORT);
>>>>> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
>>>>> +
>>>>> +	list_for_each_entry(port, &pcie->ports, list) {
>>>>> +		ret = eic7700_pcie_perst_reset(port, pcie);
>>>>> +		if (ret)
>>>>> +			goto err_perst;
>>>>> +	}
>>>>> +
>>>>> +	/* Configure app_hold_phy_rst */
>>>>> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
>>>>> +	val &= ~PCIEELBI_APP_HOLD_PHY_RST;
>>>>> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
>>>>> +
>>>>> +	/* The maximum waiting time for the clock switch lock is 20ms */
>>>>> +	ret = readl_poll_timeout(pci->elbi_base + PCIEELBI_STATUS0_OFFSET,
>>>>> +				 val, !(val & PCIEELBI_PM_SEL_AUX_CLK), 1000,
>>>>> +				 20000);
>>>>> +	if (ret) {
>>>>> +		dev_err(pci->dev, "Timeout waiting for PM_SEL_AUX_CLK ready\n");
>>>>> +		goto err_phy_init;
>>>>> +	}
>>>>> +
>>>>> +	/*
>>>>> +	 * Configure ESWIN VID:DID for Root Port as the default values are
>>>>> +	 * invalid.
>>>>> +	 */
>>>> we need to make dbi registers writeable before this through this API
>>>> dw_pcie_dbi_ro_wr_en().
>>> Hi, Krishna Chaitanya
>>>
>>> Thank you for your comment.
>>> When our driver initialization starts, the BIT(0) of the
>>> PCIE_MISC_CONTROL_1_OFF address defaults to 1, allowing for the reading
>>> and writing of dbi registers.
>> Thanks for the info, then in that case do we need to clear it before
>> enumeration?
> Thank you for the reminder.
> Do you mean that after executing the dw_pcie_writew_dbi function,
> dw_pcie_dbi_ro_wr_dis() should be called to clear the writable bits of dbi?
>
> Kind regards,
> Senchuan Zhang
>
>>>>> +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_ESWIN);
>>>>> +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_ESWIN);
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +err_phy_init:
>>>>> +	list_for_each_entry(port, &pcie->ports, list)
>>>>> +		reset_control_assert(port->perst);
>>>>> +err_perst:
>>>>> +	reset_control_bulk_assert(EIC7700_NUM_RSTS, pcie->resets);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static void eic7700_pcie_host_deinit(struct dw_pcie_rp *pp)
>>>>> +{
>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>> +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
>>>>> +	struct eic7700_pcie_port *port;
>>>>> +
>>>>> +	list_for_each_entry(port, &pcie->ports, list)
>>>>> +		reset_control_assert(port->perst);
>>>>> +	reset_control_bulk_assert(EIC7700_NUM_RSTS, pcie->resets);
>>>>> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>>>>> +}
>>>>> +
>>>>> +static const struct dw_pcie_host_ops eic7700_pcie_host_ops = {
>>>>> +	.init = eic7700_pcie_host_init,
>>>>> +	.deinit = eic7700_pcie_host_deinit,
>>>>> +};
>>>>> +
>>>>> +static const struct dw_pcie_ops dw_pcie_ops = {
>>>>> +	.start_link = eic7700_pcie_start_link,
>>>>> +	.link_up = eic7700_pcie_link_up,
>>>>> +};
>>>>> +
>>>>> +static int eic7700_pcie_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	const struct eic7700_pcie_data *data;
>>>>> +	struct eic7700_pcie_port *port, *tmp;
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +	struct eic7700_pcie *pcie;
>>>>> +	struct dw_pcie *pci;
>>>>> +	int ret, i;
>>>>> +
>>>>> +	data = of_device_get_match_data(dev);
>>>>> +	if (!data)
>>>>> +		return dev_err_probe(dev, -ENODATA, "OF data missing\n");
>>>>> +
>>>>> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>>>>> +	if (!pcie)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	INIT_LIST_HEAD(&pcie->ports);
>>>>> +
>>>>> +	pci = &pcie->pci;
>>>>> +	pci->dev = dev;
>>>>> +	pci->ops = &dw_pcie_ops;
>>>>> +	pci->pp.ops = &eic7700_pcie_host_ops;
>>>>> +	pcie->data = data;
>>>>> +	pci->no_pme_handshake = pcie->data->no_pme_handshake;
>>>>> +
>>>>> +	for (i = 0; i < EIC7700_NUM_RSTS; i++)
>>>>> +		pcie->resets[i].id = eic7700_pcie_rsts[i];
>>>>> +
>>>>> +	ret = devm_reset_control_bulk_get_exclusive(dev, EIC7700_NUM_RSTS,
>>>>> +						    pcie->resets);
>>>>> +	if (ret)
>>>>> +		return dev_err_probe(dev, ret, "Failed to get resets\n");
>>>>> +
>>>>> +	ret = eic7700_pcie_parse_ports(pcie);
>>>>> +	if (ret)
>>>>> +		return dev_err_probe(dev, ret,
>>>>> +				     "Failed to parse Root Port: %d\n", ret);
>>>>> +
>>>>> +	platform_set_drvdata(pdev, pcie);
>>>>> +
>>>>> +	pm_runtime_no_callbacks(dev);
>>>>> +	devm_pm_runtime_enable(dev);
>>>>> +	ret = pm_runtime_get_sync(dev);
>>>>> +	if (ret < 0)
>>>>> +		goto err_pm_runtime_put;
>>>> Any specific reason why we are enabling runtime pm and doing
>>>> pm_runtime_get_sync()
>>> To avoid warnings when the driver starts, pm_runtime_get_sync()
>>> has been added. Warnings as follows:
>>>
>>> "pci0000:00: runtime PM trying to activate child device pci0000:00
>>> but parent (54000000.pcie) is not active".
Yes, otherwise we are violating the PCIe spec.

- Krishna Chaitanya.
>>>
>>> Kind regards,
>>> Senchuan Zhang
>>>
>>>>> +
>>>>> +	ret = dw_pcie_host_init(&pci->pp);
>>>>> +	if (ret) {
>>>>> +		dev_err(dev, "Failed to initialize host\n");
>>>>> +		goto err_init;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +err_init:
>>>>> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>>>>> +		list_del(&port->list);
>>>>> +		reset_control_put(port->perst);
>>>>> +	}
>>>>> +err_pm_runtime_put:
>>>>> +	pm_runtime_put(dev);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int eic7700_pcie_suspend_noirq(struct device *dev)
>>>>> +{
>>>>> +	struct eic7700_pcie *pcie = dev_get_drvdata(dev);
>>>>> +
>>>>> +	return dw_pcie_suspend_noirq(&pcie->pci);
>>>>> +}
>>>>> +
>>>>> +static int eic7700_pcie_resume_noirq(struct device *dev)
>>>>> +{
>>>>> +	struct eic7700_pcie *pcie = dev_get_drvdata(dev);
>>>>> +
>>>>> +	return dw_pcie_resume_noirq(&pcie->pci);
>>>>> +}
>>>>> +
>>>>> +static const struct dev_pm_ops eic7700_pcie_pm_ops = {
>>>>> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(eic7700_pcie_suspend_noirq,
>>>>> +				  eic7700_pcie_resume_noirq)
>>>>> +};
>>>>> +
>>>>> +static const struct eic7700_pcie_data eic7700_data = {
>>>>> +	.no_pme_handshake = true,
>>>>> +};
>>>>> +
>>>>> +static const struct of_device_id eic7700_pcie_of_match[] = {
>>>>> +	{ .compatible = "eswin,eic7700-pcie", .data = &eic7700_data },
>>>>> +	{},
>>>>> +};
>>>>> +
>>>>> +static struct platform_driver eic7700_pcie_driver = {
>>>>> +	.probe = eic7700_pcie_probe,
>>>>> +	.driver = {
>>>>> +		.name = "eic7700-pcie",
>>>>> +		.of_match_table = eic7700_pcie_of_match,
>>>>> +		.suppress_bind_attrs = true,
>>>>> +		.pm = &eic7700_pcie_pm_ops,
>>>>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>>>> +	},
>>>>> +};
>>>>> +builtin_platform_driver(eic7700_pcie_driver);
>>>>> +
>>>>> +MODULE_DESCRIPTION("Eswin EIC7700 PCIe host controller driver");
>>>>> +MODULE_AUTHOR("Yu Ning <ningyu@eswincomputing.com>");
>>>>> +MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com>");
>>>>> +MODULE_AUTHOR("Yanghui Ou <ouyanghui@eswincomputing.com>");
>>>>> +MODULE_LICENSE("GPL");


