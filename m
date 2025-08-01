Return-Path: <linux-pci+bounces-33271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA79B17E48
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 10:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956E85849E3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CF421D018;
	Fri,  1 Aug 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxIVFVQu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3C213E90
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036893; cv=none; b=SQms13mURwKK+a43VDaT//x3lcG39y+Duk6mL5fT1INGnVq4CFsB+H6pFS2faN0/S0YZWtjiAZ3JcOpAZKrzCqXSGSsV1UiBZ2voeY0mQsqxUmvtNnbm2m+iuQNNKdUpME+yuEWBQ+1VUwy8kPHPIrYiGGa2ypREmzDY/dQWsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036893; c=relaxed/simple;
	bh=n21FYt0R2MUIO2Qf1PzQwL42JjC+OUvtksC+UTS2eYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH/d+/Nx8GttkD1zlPQSfWE20lbAZjMGDCstF4igYG/Aud/o3PZXOPXI+0guw13gikHk0T9+LKcKUxslQKWK/TQXrhUYF9jLYn4cCQQhZgFn3EP+OR1j85bYQmf5hA8ZYABl6uvAP0jlZWio4d1BpSNsf7EpMws+vziTWl0hiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxIVFVQu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5710PGOU021187
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2025 08:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	maSw2CmMyXYMAvKmdoOc+yYzrI3pcEaJZUjifnEuM/o=; b=BxIVFVQuqV0jyujy
	yHXB+wfkRrSKT9aqMVbG1hqlQELgHhIU31sT9BQBmkigZh8NjIwCOHnODCmxojIY
	Gfy2ZJPhYzSTY3CRBhu9ZbavBhYXZa8QcaqBE2pfcfjfvgbUePgFM1I7cMpPt1tw
	zytn4BNQ6goS4nTh1UZ0W7CrGekoKs8dbm2Ch9fQsgIC90gKTCj4Wb5MSSuoD0+N
	tKHXl/Q7dpaHp5IFWzq8rcv1U33Pd4/W81yOWNiH/bK3MvUH8eYdkxmVDr9ltYfM
	nULozSQZwOj6UluFGaBsoZrYYqmNp21Th9zb9KOAUvMs3iCZtXgoaSZZyNGoaZxz
	r9WgIQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1atx2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 08:28:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24011c9da24so15962325ad.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 01:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754036888; x=1754641688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maSw2CmMyXYMAvKmdoOc+yYzrI3pcEaJZUjifnEuM/o=;
        b=X7sSMBK21KNuUNmhwI/wRS51zNKTXsE3SJ3bihTAzv58jtyL9bR9PkSV0VedTNOyHh
         EpZgVwwPJXYMZ9C+gjpqq/eUGkEtHfLLjrwEgPLMZMNd7Qd5/yNVrcr1p5qKx8mZ3be4
         09zH+1LNIpwcESBAgR0ena6TGXG2V92WkCH7tY88Xa5T6HVV/knOt00UdbUcVix9Bw99
         l+YDDV348LMvgCeWjICh1v7OtokWhAgy1odgZxYTeTm2Em/I6WbqClstb7xf2UJc7Kpy
         cDeztaZOrlLkeRCfiZLXjkOlvE3/oc3guySzqq5hrHSyEaj43grM8IRsAK+KjKv55RVK
         Fa9A==
X-Forwarded-Encrypted: i=1; AJvYcCUosBWc/4cYjfmC9yaFcuyDwBvV4nAtG0zjCMc6R8nkLzBKEUlDf7SDO6w1UVv6Nbu24momcxfKSJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfFUWwmNvrtBcH5XZTrO+ACT4TVchRCwD89UZ8c8F8Pxwzc/I/
	HkA8aRd6gwuGEzF5XkvNwdT86s03THPd6TQAE3fzY/xuTjGB3SZcyFc0EBj3wXOHDWvzNMx8Nn2
	+4zhwSjzxMHeN8tchmbN3mbIReH/gBpdwIbP+Wjk1sP+hPmOfLkkgHkGDaWgYmv0=
X-Gm-Gg: ASbGncuyks9K34OspiWtrxM2NwxQLvoJqqdCcw6XL5HuBNisrxlhdfTAsZYSVLjH0zw
	MkcrwSkDAf61trIZIoCwdy/sKVkPNoxkPMllUdKOi6sigknJSs8rQCpwttPl3fz/IuRfTrOogKN
	dQM6XGMwt9VL+1T1YdpsZr4fEhLD6Wvq3uYMi5gEXZEVt3YfdL4Mp9P5KQS0nTG1oyMVgQKMald
	nsPKjMsbwaFw95Rv0uc/UDYNu9o/ikAOou6kfH53eXD47UWmRqbvF44TVLIPSTxuUubwBXaUUnn
	9Zn2pCWo1ChujG4MKiNil+Cw7n7LKA2aOd23mHKCRYHxiQ5Aabg9KZMmija2xZEhRBn3h/i75g=
	=
X-Received: by 2002:a17:903:283:b0:231:c3c1:babb with SMTP id d9443c01a7336-24200b0f9f0mr71691945ad.18.1754036888083;
        Fri, 01 Aug 2025 01:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXzVMpoNTOUr+QJdVXJ84SNHSBTQYxIJbq36BDLV4wmlovxf8sqtvX2B9vl9qw1lN1AHJg7w==
X-Received: by 2002:a17:903:283:b0:231:c3c1:babb with SMTP id d9443c01a7336-24200b0f9f0mr71691545ad.18.1754036887597;
        Fri, 01 Aug 2025 01:28:07 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a3acfsm37009225ad.146.2025.08.01.01.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 01:28:07 -0700 (PDT)
Message-ID: <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 13:58:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TUNctkwVI3OMDKNhrAE1wyU90nOryrhX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA2MCBTYWx0ZWRfX/WC4/wtQyGlJ
 0KSeqjexXqgQMLkGUmCu1wvQ1lYxCta/q/QN5MczDVCaM2Ub5UUxgxr8sxUo5oZT5JGIbRS7AwK
 0nlQE0fR0V1cH6l6yEuAgkf02/9B8wGctTw6GHmFvjmH+v2idO4/SxegnV5UEBPWn854PIB6s8v
 eb0BVz9rygimSUQ50D5EFkNfqaX2l+V1314ckX4wj0RC1f+DSxmR5yJ1GBa8Z+uhVVF+g2Q9GCd
 wJpYY4vIVPobJr/tiSomr81dsUIUBW8Afj8QIBEL7U8sgIvsAuLWa/gmxiZs5fiJ3AOTi60ZwBY
 rf1xVNuhRlNNZEb84VBlLh0xC5dcWFmMO+jLsQsTatXxmBdWB2ABru9FaYledE7AQbHSMEFOEV5
 /Pr1BsWvbJFqVJjLDrSMpAg1AbAfyrTuz7IyW3EXSMNpIAnehogO+j6iq3PSdntudi2zrRh2
X-Proofpoint-GUID: TUNctkwVI3OMDKNhrAE1wyU90nOryrhX
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688c7a99 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=9P8yD98ns4tQo_T1VPoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_02,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=800 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010060



On 8/1/2025 12:58 PM, Viresh Kumar wrote:
> On 01-08-25, 12:05, Krishna Chaitanya Chundru wrote:
>> Can you please review this once.
> 
> Sorry about the delay.
> 
>>> The existing OPP table in the device tree for PCIe is shared across
>>> different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
>>> These configurations often operate at the same frequency, allowing them
>>> to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
>>> different characteristics beyond frequency—such as RPMh votes in QCOM
>>> case, which cannot be represented accurately when sharing a single OPP.
> 
>  From the looks of it, something like this should also work:
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 54c6d0fdb2af..0a76bc4c4dc9 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2216,18 +2216,12 @@ opp-2500000 {
>                                          opp-peak-kBps = <250000 1>;
>                                  };
> 
> -                               /* GEN 1 x2 and GEN 2 x1 */
> +                               /* GEN 2 x1 */
>                                  opp-5000000 {
>                                          opp-hz = /bits/ 64 <5000000>;
>                                          required-opps = <&rpmhpd_opp_low_svs>;
> -                                       opp-peak-kBps = <500000 1>;
> -                               };
> -
> -                               /* GEN 2 x2 */
> -                               opp-10000000 {
> -                                       opp-hz = /bits/ 64 <10000000>;
> -                                       required-opps = <&rpmhpd_opp_low_svs>;
> -                                       opp-peak-kBps = <1000000 1>;
> +                                       opp-peak-kBps-x1 = <500000 1>;
> +                                       opp-peak-kBps-x2 = <1000000 1>;
>                                  };
> 
>                                  /* GEN 3 x1 */
> @@ -2237,18 +2231,12 @@ opp-8000000 {
>                                          opp-peak-kBps = <984500 1>;
>                                  };
> 
> -                               /* GEN 3 x2 and GEN 4 x1 */
> +                               /* GEN 4 x1 */
>                                  opp-16000000 {
>                                          opp-hz = /bits/ 64 <16000000>;
>                                          required-opps = <&rpmhpd_opp_nom>;
> -                                       opp-peak-kBps = <1969000 1>;
> -                               };
> -
> -                               /* GEN 4 x2 */
> -                               opp-32000000 {
> -                                       opp-hz = /bits/ 64 <32000000>;
> -                                       required-opps = <&rpmhpd_opp_nom>;
> -                                       opp-peak-kBps = <3938000 1>;
> +                                       opp-peak-kBps-x1 = <1969000 1>;
> +                                       opp-peak-kBps-x2 = <3938000 1>;
>                                  };
>                          };
> 
> The OPP core supports named properties, which will make this work.
Hi Viresh,

When ever PCIe link speed/width changes we need to update the OPP votes,
If we use named properties approach we might not be able to change it
dynamically without removing the OPP table first. For that reason only
we haven't used that approach.

Correct us if our understanding is wrong.

- Krishna Chaitanya.
> 

