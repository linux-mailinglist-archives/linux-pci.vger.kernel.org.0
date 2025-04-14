Return-Path: <linux-pci+bounces-25786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872D1A876E7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 06:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0838188FE2B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 04:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A297C19DFA7;
	Mon, 14 Apr 2025 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwI4ZtOi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067F4A29
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 04:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744604641; cv=none; b=F0XfeyvuLbC70jDRqcw93V2JV2wNQTZHfYs1HwX9wb1izf2KjaVfPtbn/CVq7sFW+7Ev7D7jw02j6F8P0vV8bYxwRS2G62nUQV3sSi4caTkiPVToHRmHqQGzse7FQHOy5AfpZhP1a/uRs2uVOt671rcTBorBfdpPjIsRrPGWXjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744604641; c=relaxed/simple;
	bh=NR0Is6ko5JDb+FNA+3PO9lgQkkj8irlOZrSZIdNWzhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbDLMpkxHdqvZ5rZh9cO6LaJhGhVUC5Ndg6EfbyAFUQSSCfU9LT1w+JV5qRoVyGrKxVCBUp6B7ktala2kY4kW+MQpDDXfTHX+VOEQK4aymGdK0y4R8Ywzt79APuZ8R4ZMKI0jWgt54UiewmNi90RM6R4Y28hzl1i/UzZTN3RZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XwI4ZtOi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DM1iJB017551
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 04:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ysw5B2sn3/k2d6Rp4YWNu10TJ2J4Ajcr6yXyJBKlr1U=; b=XwI4ZtOi2KqH3Iam
	IDmh4YtrdbmA00+GfPeNDLwgFLLXmWmtjpdnTIb5Iw1SqG/OsEsYM70HVNdSv227
	AH0Lm5QpJ3adSGnDQ4kJW1AqZIudAei240n61b9eTxQI7uxAo+96ImGR2sNC5NgD
	iSPeedZV4R74XsMCUA6K2u+mOWTTbtPmlVZPaPHvnOQved0ONurvNbqiIxp1kJIT
	4pdjmfm7n4Bud6I8SHULu6NDUp/o0zA65/56NG4DBTruwiT1wKz9uu95rTqGydTb
	suHRp3gj7yjA7tV8EtyKm5tRwAm7qYM95rWMhrclULZGrBymTN8tJdRJPrcIqx9s
	Dzbn7A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfcu5vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 04:23:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-306e5d9c9a6so6209684a91.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 21:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744604638; x=1745209438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysw5B2sn3/k2d6Rp4YWNu10TJ2J4Ajcr6yXyJBKlr1U=;
        b=S4IlSFhGTDzak1+ft4ZBdxmZsofaihFE/zae75gOaaoCdtghLhIPm/CT6Dm+4Tnakb
         +i2aP5Jw59ziEMN71SFaiXbS2IF+P8hCVmmbDmbC1yaEihYSq+5OEbt0rB7mtqAtSljY
         i4RBJmY/vHe1oTa35VFivdj2000OPuJTq8UgMw+HnkmXvXmPOhS0hYvoJpT25R53f0cT
         Mv99h9sR5unQchYctznhW1A0VUc+zlAd4B2Y7rI+eUHNSDm4W/CUG3EqxCsDzNB1f8sB
         90zMTW+yppzOY+bO8H21skib18P8Jl3Qf9fGGRaxwu9FTX1MWizNaRiTgTVZ0Jry8tP5
         JcnA==
X-Forwarded-Encrypted: i=1; AJvYcCW8GQrSUM5eyWeS1kKuBRC7tbf1yQmvm0xfPJ1Cej+skTA4CqlaxHKoWjfcy8YflfdKLVEwBlIe2ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YylF7qM4BwvlQ/XyUUZURNxak7nOhkBsrDgLb08sCHQVeb0rrA6
	q+QkIWFH0wvBUEDHKlwWGqxYjYjAxEVz9qhJn9aZkZHi67dP/hRnPwecZYyWFRjP1n9etpFQOt7
	/deDjnwsQxg8uIldR8wxibTqykWBExAD7uzMVAqrFS7idrjh+wJ0Pykh++AU=
X-Gm-Gg: ASbGnctIkVVHxMzWSzOX6WFR7WHJdfE8NUj3KOffas/obJ+iIaOMStRAnhH7VL9FXcE
	k0pJ5FyWEk78gvFfBPq43pHU9xxgU2bamDsCcczhaf/kxbw6Ux2xHTA2sCUdbqDOAcFFz6ZIVKL
	WfgYjiKLWg6aEpfONd/fcjbYvOeFWpJSHHEjTar6G+79KRyGGM2gOHcOiW03ZzyK4TzhnvYWIPE
	c/sh9rdN72GNWfqd7BPSRx1u+kJDFx3dhq3/Gs9TlCyzNMOriOE5lpldJ3aYrUOI+7mTn1DFvwc
	Wwk5UD3oAWtj2IzbA8o2tQDOIKWScF0aeKmb9X74jw==
X-Received: by 2002:a17:90b:3d45:b0:2ff:58a4:9db5 with SMTP id 98e67ed59e1d1-3082367edd4mr15483475a91.30.1744604638155;
        Sun, 13 Apr 2025 21:23:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvsDFaM6wYPioOLKFUeyKLcsR/+QeQ+TQ6PI9URzGFDTBStFmha7q14gB6G1TGFTKx6yxYuw==
X-Received: by 2002:a17:90b:3d45:b0:2ff:58a4:9db5 with SMTP id 98e67ed59e1d1-3082367edd4mr15483442a91.30.1744604637611;
        Sun, 13 Apr 2025 21:23:57 -0700 (PDT)
Received: from [10.92.199.136] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e672sm10413953a91.17.2025.04.13.21.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 21:23:57 -0700 (PDT)
Message-ID: <1f998456-2d4e-0208-9018-a934aed84b8f@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 09:53:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 7/9] PCI: PCI: Add pcie_link_is_active() to determine
 if the PCIe link is active
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
 <20250412-qps615_v4_1-v5-7-5b6a06132fec@oss.qualcomm.com>
 <Z_njmA49Gda-m0aH@wunner.de>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <Z_njmA49Gda-m0aH@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fc8ddf cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=DLE-xEQoUa54y48t:21 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=qtISFfrJNgDVoNSwWSYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: OpmpwU4hivxBovIyzD8gFkDJYunq9BS6
X-Proofpoint-ORIG-GUID: OpmpwU4hivxBovIyzD8gFkDJYunq9BS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=967 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140030



On 4/12/2025 9:22 AM, Lukas Wunner wrote:
> On Sat, Apr 12, 2025 at 07:19:56AM +0530, Krishna Chaitanya Chundru wrote:
>> Introduce a common API to check if the PCIe link is active, replacing
>> duplicate code in multiple locations.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> One heads-up and one nit:
> 
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
>>   	 * Synthesize it to ensure that it is acted on.
>>   	 */
>>   	down_read_nested(&ctrl->reset_lock, ctrl->depth);
>> -	if (!pciehp_check_link_active(ctrl))
>> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>>   		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>>   	up_read(&ctrl->reset_lock);
>>   }
> 
> Heads-up:  There's a trivial merge conflict here with what's queued on
> pci.git/hotplug.  No need for you to respin because I expect this will be
> merged through a different topic branch anyway, but Bjorn and the other
> maintainers will see the merge conflict when generating the next branch.
> 
> 
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1945,6 +1945,7 @@ pci_release_mem_regions(struct pci_dev *pdev)
>>   			    pci_select_bars(pdev, IORESOURCE_MEM));
>>   }
>>   
>> +bool pcie_link_is_active(struct pci_dev *dev);
>>   #else /* CONFIG_PCI is not enabled */
>>   
>>   static inline void pci_set_flags(int flags) { }
>> @@ -2093,6 +2094,9 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>   {
>>   	return -ENOSPC;
>>   }
>> +
>> +static inline bool pcie_link_is_active(struct pci_dev *dev)
>> +{ return false; }
>>   #endif /* CONFIG_PCI */
> 
> Nit:  Seems like this would still fit within 80 chars:
> 
> static inline bool pcie_link_is_active(struct pci_dev *dev) { return false; }
> 
> That said, all existing callers of this function as well as the new one
> introduced by this series are only compiled in the CONFIG_PCI=y case,
> so I'm not sure the inline stub is necessary at all?
> 
If any other driver other than these two drivers in future wants to use
this API, it can be useful in that case.

- Krishna Chaitanya.
> Thanks,
> 
> Lukas

