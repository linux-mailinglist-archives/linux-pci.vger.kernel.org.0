Return-Path: <linux-pci+bounces-31972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B6BB02785
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B787BFAAB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A92236E8;
	Fri, 11 Jul 2025 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AM69r9AB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E1222562
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275527; cv=none; b=P7Tj7haZV9XB6VxklKhb8HhHNmtDrejlKjY7aac3wAic8GhK5wIVhRvNsKhMHgkskZXwL/ChZcU/HFh1qDMoD0ebzx//BzQECswuxcop2CoOToVzv05AkZIIJvoB394nM1PUJEOBm9oJKA4oPyZHut6kKECfKLxsui5FUG/cjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275527; c=relaxed/simple;
	bh=iOwLrKCkhVKAxQZXp38HLHfRncvgRuif6BiGmmhGRos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCWRxFKHpe4jbbSlBvdusHC7uHI3+TIvLJWwYnRqIGPUsMppsqG5a19ziCNFD7h0xBh63QowU83LKL0XXkgYaPiz8LCUohfhBfuVfBmdfcUl2BhMJ9nAO3a1fJnkL27CdzJYoYe/5M9Zlh4GyWYtdBA1U+kywaLqX0HAAy2q/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AM69r9AB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BMcfUv031212
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0PpsrmMj0uiPokNCQ1Eqhmb2HaTUqbDl1MR+USJW6LE=; b=AM69r9ABrIKlQY4s
	YxvXrJg3dr1YOkoMN/GSblbDv2QbivqBF22HGq+bXcKJEk7KLQiiAsbq/A1GWWhk
	FE9fFuCzFLb/2jH3edDr0HjaNnP9vEuL+t8pmMQ1/3XfCihqy489xCSPoZ8eFQLG
	7i7Wxj+jZclQEVZZmWKMomCFGMYLWiGOT3BYZKLLCsQQsRcjbD74DfRbzY40NMx+
	F5ykAy+u/jXlpNkVH40wRQvxiZww30ViGur6KVDBjOMgTAm4rr1nR6ifu0v7QiOb
	rs+VnAdMC3/wmL+hI27ytiJlyBOQ6tV8gQd5zK1K4h9u+sdLvCJY3z06XruS3MFm
	taMmzw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47u15assxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:12:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748efefedb5so2519724b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 16:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752275523; x=1752880323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PpsrmMj0uiPokNCQ1Eqhmb2HaTUqbDl1MR+USJW6LE=;
        b=Cu9CxBXutOSD0meodDwBmQyrPMDBYYT9KsGT/3/OO3JkF7bJaq3oSx+JDcHesyJ9Xe
         eFpM/FSmmOsJ1ebex5TAEFgts8+mGSPxoS5NbUBR+O9k0ugve5mSL7qsE8df2FJzp1hS
         UDp12zSL85RRlhI77msUDAaKSo0xjb6dHIaTTOn38jmV8vmS4OZ/H6jr8WbT4Vsu8UyH
         OKPEiyIU6pkpjQJopXDm4O7p7dZotcXCT/AK18+4J7BdbeMoyzr7Leb1FVlro5YftKD0
         Kg/3IcVF3gtpMb1Q6hH67odLeIwY5tWwyWXUCwIFL9DgAu0mC7fNbYkzb6TBrjQcrQNk
         /mjg==
X-Forwarded-Encrypted: i=1; AJvYcCVDUjB9qVKFH8RR9fDXkLt7WN2TrM0vxuZJ6tiMK3tmHYepxGrOhsJJc2j3sJMCwCeYtwzQcRj7NZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVRtoUhbeZhTDiz2bOnNdOlrQriSqDcsSxmwKlm/+ExrNU0dP
	dtVioIIRzBvbv9VA3n2ZQnwU4Fq6QykAAizOYGvsH5TmzxBxN6lmPChdwyybEOC/Z/rusHM+V/Z
	zs4aosvciHp0Fv5LkzYTevyaOOXl/955QbkjwlDadvDteDTJLwhNZcVP1BkE7/G0=
X-Gm-Gg: ASbGncvIw/BjmAF914UbEZCt9xCOf7jPXxBxIqZWV6/qqA2yUbLpOmd/+BHCOmdy4Dl
	MVH6/EFAExUn+/OseO1+JSREfmxyORm+3fbVjwfIX+Tjw66ddmNNRa+Xo/mIyr/lCA4lhldwoPM
	cEJl3XHB+YZfnFnmY2FxEClXKARsVrRNbDruw5bPDZ7K0hjlX6ZvwHHU8x9LpUw3chKeSo8cfKi
	zwYl1pSak/SDUNeJBU0+J3aXhZ7pnZba/4CJ6OnNIrjnLJwtovzIIrKqYHuJ5a2Dp7RclaBua8k
	TLnC4ANxbgludOp+2nGy/BxRWw/1MrLrvO64OzJcRo2xb7R1NXEAfj6B4PfK67xShBsm
X-Received: by 2002:a05:6a20:d43:b0:220:3252:bb7b with SMTP id adf61e73a8af0-2312080596dmr8768289637.31.1752275523095;
        Fri, 11 Jul 2025 16:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeK7rgvIuioPJc9Djm6BWHu8SfUaUakg+lxMCli0qXD/9xlsegC+9TSbITmlPNQmxFFiKNlw==
X-Received: by 2002:a05:6a20:d43:b0:220:3252:bb7b with SMTP id adf61e73a8af0-2312080596dmr8768238637.31.1752275522626;
        Fri, 11 Jul 2025 16:12:02 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.227.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd59f1sm5742585b3a.3.2025.07.11.16.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 16:12:02 -0700 (PDT)
Message-ID: <b9647055-a9f2-4016-a7b1-81c15a0d82c1@oss.qualcomm.com>
Date: Sat, 12 Jul 2025 04:41:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] PCI: qcom: Add support for PCIe
 pre/post_link_speed_change()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250711212952.GA2308100@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250711212952.GA2308100@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5dJX-ZgGw-ZWPlGYCqdyTqiFDGyOm4yT
X-Proofpoint-ORIG-GUID: 5dJX-ZgGw-ZWPlGYCqdyTqiFDGyOm4yT
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68719a44 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=4nqOr+EkFiuPl9GB/B4vcQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=40onBu3kYIFXMOwlT5wA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE3NiBTYWx0ZWRfXw1Bgevn9iwv5
 40XyIonZfXtrOUynLnIE8gNcyi8MM9TxDxuGF6pyb69aDV9cN+AJToLDDir2ExBureW4eQsHNa/
 E/3kexgTkF6dUVY9sH7IPxxtEZGPjDqjMmyelmXDb1IgoUc9gDgM2+iU9elJ21zfuBgHk++5IiC
 SNxfcoZ1NtiFJH98wsggHjz+reh5cgI4r5xAwp4kRIMvA+OBDU/hyyWC/UFeWFGew6PxiR0z/EW
 8+nsYdKS7h/w94nry+SDz8ohF9aEMhGAm9Oy1Bc5i0nLSkcgoJyW6FgVrHLyt2vhQOvMTvvgNCe
 qFhNSMElSEtZnaHpqfqObv/gMzxeo5oX9in16KL1Fr3U+w80cwtExs3ZWvk6YvBJrzMXPhBdlqv
 uOh5nQDtw6O5uXSY4VScdd5Zd8oN6yWlYEdpQvKOCVheJxRbKm6orMC3AeeXrkLYWSFRgBrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110176



On 7/12/2025 2:59 AM, Bjorn Helgaas wrote:
> On Mon, Jun 09, 2025 at 04:21:29PM +0530, Krishna Chaitanya Chundru wrote:
>> QCOM PCIe controllers need to disable ASPM before initiating link
>> re-train. So as part of pre_link_speed_change() disable ASPM and as
>> part of post_link_speed_change() enable ASPM back.
> 
> Is this a QCOM defect?  Or is there something in the PCIe spec about
This is QCOM issue only.
> needing to disable ASPM during retrain?  What about
> pcie_retrain_link()?  Does that work on QCOM?
After disabling ASPM will work pcie_retrain_link().

- Krishna Chaitanya.
> 
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -276,10 +276,16 @@ struct qcom_pcie {
>>   	struct dentry *debugfs;
>>   	bool suspended;
>>   	bool use_pm_opp;
>> +	int aspm_state; /* Store ASPM state used in pre & post link speed change */
> 
> Whatever this is, it's definitely not an int.  Some kind of unsigned
> thing of specified size, at least.

