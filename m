Return-Path: <linux-pci+bounces-28835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94EDACC03E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 08:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C503A2BAB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16137204840;
	Tue,  3 Jun 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cwCnRELw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5913AD05
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932393; cv=none; b=TAuc1GvDmucuydpfetbWcJ6sMe4UnS+E80bciQOBTYFGvnBmkCK8HYeb4IrVOHOrCUixbZvgrnU4lfrSY5wT8awxTwGRYVwU0ZVvxWe+RVJllNky18x533gPl9wNmdNz9wE/WZTztM94o2VX4kMlp/JsnGQL2CWUBYq9DZHaFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932393; c=relaxed/simple;
	bh=RsGYtgtdANl/zO/ogZLbFhtRUx9OmRHuZoXn6BxbNqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4WhC0QyUvdwmBhbCQ19uFwakGWKIQN2fghcU6t2s3zjU7f4Om+7hqO1b+sQaWTrys+t9jvGH6lIkS401nu2j3z2dRSi9wXng9c+ICgyywcnGR5lj1TFRpsC1vj8ztK2fMIWw1JAwmmgZgbPtmrdiNQew0AX1D+3EnEc29J0PJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cwCnRELw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HJkLY030582
	for <linux-pci@vger.kernel.org>; Tue, 3 Jun 2025 06:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9pc6PHB6crm3zwpJbt4GLLT2Ce8F7PkqjaaH7vHbgPE=; b=cwCnRELwNaVxYI9M
	oAPlIZxDlM2BMVIyXkDlK9iqnPBgw5INiD+AWntbERFLygOOPqW3akmCQIgx4Cw+
	VxNPrJ/sWpruPI1wwdJ9aNHapyWx10lyun/QWBp24Gg/uF1iHtUgdTK+n/IlLv3K
	TdIxcK6eSFl50o+ws9cjHcaueCfeJkpLJElxBTZKozc+cf8Rg0J6Q1ecGpho+M8i
	6IA9JgU5/H2rYxqiifbwhNt4pm917bmrH37AxYlv5onlWBqpMXbbShtvbCnWiauw
	wi+L0TOOAHiDR33qj3JuRgeEwqlZRbnEzE41Pe6BVxRFy8JCdOL1wV6M0YLi9BP9
	8q9l/w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8tsjvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 06:33:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-310e7c24158so5146220a91.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Jun 2025 23:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748932388; x=1749537188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pc6PHB6crm3zwpJbt4GLLT2Ce8F7PkqjaaH7vHbgPE=;
        b=GotrsQq4cvNffkmiBStccX0+Fpxvx4HzUfB1n4MHJLn7OVP+2Ua4S8Hg11XqRXv2F1
         W5lOOvErZzHURDOTluzB44YKnYxnQa/lFtXSqrBtnKT0fG30tg7dCaacI7tw4jgtlnbG
         35VLQHBLnvUXN4ge6shhybv5SLlFVHAWocMMKdvosUVznvTtP4LbKMjjXyEw2lg9lR71
         Jji/4bvzdHKHODiMegaiJSrCXNmkZEuJ9q6EkcAs3k9yfEYbx4ACHRjbQK4/DrQkkxDt
         B0nmTgY3vrCIdHtl5IBm/kVL3/yTiqmI6DKqHLZv4UOyLcbshsteBnPmXTiYAjrL9fV9
         A3og==
X-Forwarded-Encrypted: i=1; AJvYcCWuN5wVYeJIdHdZx6Xy3hlPxsTvIltL0uU0PfxhSeViCm1Ks2ZT6kScpDZk+x/JNA8QIl6PrkE2ISA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqV4GcGYcMlyx4/HONfYwcklkXRBVp3dlJnonXGfktriypc9z5
	FbbHr5StRKaEK3HLUtbGT85J3aUP+9c0vU7XvM9nyNbCwA3Ljy3cYLiELbav3rS7q/Xw9AVnP7Z
	z6fETveDMg56zizf3GBro0mmFIU6uur0h7tNT3uhYLS0O8MQJpYIOW/5h++jwfLQ=
X-Gm-Gg: ASbGncs4uLfeb6Ly/Hu2x8xPiEggU8wlUV+d98DTGmg8onNwRUlVsOB0rdzyKmuy+UG
	TX9WG80HdAYiercS+n7x6wb5/zElFdi4K+UTwcOGUjki6/mNhdTmlj2sQmjZI+Z5MKnZOAIeVAa
	LfGrqI0or+svtGE1gdJUd1h+EcPg9XTxtdo71E0SI/QXBvvzQZMNzugRtxBCJJ3YSYMJ8MsEubn
	JePR8c3DPDw0Y0UsbYF4zRNQ8Adcu8Wuw3sl8lnTqiFeYnbA008zOeNWc8EmuuQWCR2NKvT+9/F
	Njd8BHjQVvmm6WL5spWtFvng8Ftq9v4AxHF+c/V6Rw==
X-Received: by 2002:a17:90b:2249:b0:312:1e41:3a5b with SMTP id 98e67ed59e1d1-3125035317fmr20383229a91.4.1748932388107;
        Mon, 02 Jun 2025 23:33:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG14BrL2PlcTbB07wK/qZ6PgKdgYBcfapOLCfQTa+Dc+QD3aVcsU8s27xf8IUVdxud5j5tkbw==
X-Received: by 2002:a17:90b:2249:b0:312:1e41:3a5b with SMTP id 98e67ed59e1d1-3125035317fmr20383183a91.4.1748932387543;
        Mon, 02 Jun 2025 23:33:07 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e399b3bsm6562535a91.31.2025.06.02.23.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 23:33:07 -0700 (PDT)
Message-ID: <0e1d8b8e-9dd3-a377-d7e0-93ec77cf397f@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 12:03:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>
 <r4mtndc6tww6eqfumensnsrnk6j6dw5nljgmiz2azzg2evuoy6@hog3twb22euq>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <r4mtndc6tww6eqfumensnsrnk6j6dw5nljgmiz2azzg2evuoy6@hog3twb22euq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: raw23kMZRQx1w422wIr0iQk5UW-l1lst
X-Authority-Analysis: v=2.4 cv=Qspe3Uyd c=1 sm=1 tr=0 ts=683e9725 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=kQES2RtodgDv6MKcoUgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA1NSBTYWx0ZWRfX3SFc3zTefYi7
 q0RUpFiq/VMwjGRN33LZCuLxOEkJw0O7zO1/A2lLQ3o+0v1/EOmXaeVrfi53uJAXz7S7gWdPvp7
 GObe7VVq5HllnRu9bseqYrgR+Z7wC+wXdIDOxxCHpGmu1QRk27jEgjSsAjWhEGcfowSohsYXddt
 ZbUcXbXSIREibbrbnsy5XMrZGhK9Ys0OExKT+wFLtBkvTboThI866aMjjfev/Q8Ach2iOfZHVC8
 duv9sZRxjXifq4rdGnN31lxqo81mg1CdcrOimbHGrbANhV79lbbj92M9a9EzjAbAkVLPaXdPXVC
 Dt2BKxS15JrAU72M1oO3IQAZaCv9LJM1B/Ik2xJVQIBUm56DOzmu9F75iZ2OD5FgrWX+5+D3v7W
 mPIl0ggOW0xnygGTRxHLqQ0h3E5R+cOwySX8EEMr7Axi5jr6tlWWovA7MTPPHr1ceVl7mTPM
X-Proofpoint-ORIG-GUID: raw23kMZRQx1w422wIr0iQk5UW-l1lst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030055



On 6/1/2025 12:35 PM, Manivannan Sadhasivam wrote:
> On Sat, Apr 19, 2025 at 10:49:26AM +0530, Krishna Chaitanya Chundru wrote:
>> There are many places we agreed to move the wake and perst gpio's
>> and phy etc to the pcie root port node instead of bridge node[1].
> 
> Same comment as binding patch applies here.
> 
>>
>> So move the phy, phy-names, wake-gpio's in the root port.
> 
> You are not moving any 'wake-gpios' property.
> 
ack I will remove it.
>> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
>> start using that property instead of perst-gpio.
>>
>> [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 5 ++++-
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 5 ++++-
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi           | 6 ++----
>>   4 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 7a36c90ad4ec8b52f30b22b1621404857d6ef336..3dd58986ad5da0f898537a51715bb5d0fecbe100 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -709,8 +709,11 @@ &mdss_edp_phy {
>>   	status = "okay";
>>   };
>>   
>> +&pcie1_port0 {
>> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>> +};
>> +
>>   &pcie1 {
>> -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>>   
>>   	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
>>   	pinctrl-names = "default";
> 
> What about the pinctrl properties? They should also be moved.
> 
pinctrl can still reside in the host bridge node, which has
all the gpio's for all the root ports. If we move them to the
root ports we need to explicitly apply pinctrl settings as these
not tied with the driver yet.

- Krishna Chaitanya.
> - Mani
> 

