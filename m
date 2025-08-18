Return-Path: <linux-pci+bounces-34186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26152B29D38
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 11:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7947A1883D0A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE1D30C368;
	Mon, 18 Aug 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dr4jJhpB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67755307AF1
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508032; cv=none; b=XXOLgTN3+kPbGVd+qPqCLzw6lf8ZrGkv+7bt1CEHKUcCgEotu+r1X47e+ElUlulLwwfb46gfnduFTA+UJgN7R5pjdjEeBDm6Cg33+abwdxI7R/xzmPWnZzaqfEscRx2WL2vjW3TLDsatxsygJIbxtQYH6/z+zFAlIIiWzBaIhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508032; c=relaxed/simple;
	bh=wyq/7YeczeadlIcGxtjwBRjfO2o1GBWQYroM9CBv0ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqVCoOLI0lrGxuiOD0xhZTG3Rg9NRjxLc2y7fFCEENdT6hRA9F5lxaDrokth1e6dCBArUg9VQXnh+4irHhxiJk8h2QX3RI0Gw5Nhsvog3hXseuXNM2a7P6ggtBLVpzqh5WUIzIw9hfY+hI6z/R9Xc9zQxinhHcDvFkfmJM7gHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dr4jJhpB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I6c6k0007903
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 09:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dUhpdrCm+k4CB4DE4j2STl3XU1CxkFy0Dl3z3gmHHDg=; b=dr4jJhpBWkhC0hl4
	KNLVhV/EZCKuB+KOy5yVaf2hs2kkScwOO6ssaq/q8+U5Xn7JAEinUEFQ9SA6ryyZ
	JMF+/dZqa4Zo7nyFDJapRonWHDsTxMDbZ8nOVrZJ9bfQ5H1zqMIf2xIURrFo83Gw
	PSIBNUh84K6nqP0KDtwB+jfYYspay+z8aKEKGLsfwFarNUEtWjgd9Jj+9WuLpJ7z
	nLTxaGjXxBV3jpI5pNBDNW3zmGcy0doPL4PVYeDoPwnMGIpvLeqOFKo1bvOZsdDX
	suBTREPKnWfiqFobZEG7NlTzIajO2kH2qGoq1YES5vZ/1pTwHDTCEfichPJ4e2xL
	CB/Iiw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj7441g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 09:07:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458297be0so94672565ad.3
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 02:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508030; x=1756112830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUhpdrCm+k4CB4DE4j2STl3XU1CxkFy0Dl3z3gmHHDg=;
        b=dKOuk2DXXI3o7ady0w5VbakYfnabkNrHbZ7DRxHCfx+qjK0C+uAbxU4xQqf7joB4im
         JaNJDzgLMtP6eoX+9fClMnhS/5JDafoUz6rhMQOR8dXX6x3diS4/XKWR24DWoDSO96ML
         2i54dO1g9jPNKKR7kUxOIOQrX34Fr4fGYyDAV976G/qxJs/q+ySjppGencbmmycxSRrh
         CpRkbXkK0mfjLNITGlAyY5rICySmFs2xHXOSdw3jSfPTMRE9De1uRYx6zB2mDuFS3Oen
         HcFP9pbh+S/ChUn05AtAGz96HlOarOEyxQv1FnD54lxzLJeY56sdgdGMYGCOlxeBrE19
         RWsw==
X-Forwarded-Encrypted: i=1; AJvYcCU6q7bmDrCR9paoZJDNgb8456qED8Txy0DElSNto++t5lwjnRIIps3bm2qe+3uYWIVxQBCwKJlK0L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgup7AsMLxomQ+QoF70hC17hz8MuBoL66NgEEG6/OOP9RKVc3
	PNcPxpoQSksSRA+SmzL+wvTV6blKpXOhx+7NnOG9+uy4kfT8bqvX75lZ99J1J8vi4Z6K9E/iYWl
	8Pc3zyNV8zHYuhW+sgRUbll9nrwROZLfjWLp0FzY16cipPB8JrMKRltu3BRT/ZLQ=
X-Gm-Gg: ASbGncu3X09QiyYc1o9ebgzeU4jrSa5z6nqPMnOWI9dQ0oAoSbbMUw8s1f9jGlaITVG
	w6U48iqcYD4JopiRW0iNzvKvQAXR28i2XxfPkG6oQcD7rh+U0YSzNIYc0dgYtqfhd8yfe0PpNgC
	raw06LWDvB8/ERBsncxX7sED2Oh4L25vzVjj6nv8vmVuxh4/RnAdYrt2lASkiKLNIMezZfLo4RH
	nhl+GrjXwuno8TY0arLmCywH7orkIegHH2Q58BEbb8yrKA6NEks4D+vdIceI2vVVMtyXMEMc1uA
	AFoDFOQ2CRLGwpRc/f2HoV1gl9U3H1Nf42AKS2QEiOhccSAyNUqcz+bH2wAH6qqCS/GQzWZS4A=
	=
X-Received: by 2002:a17:902:f64d:b0:242:6f41:2351 with SMTP id d9443c01a7336-2446d756f8cmr135619025ad.14.1755508030004;
        Mon, 18 Aug 2025 02:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh9JX97qwlZF3aEKy3JEAMK4ybJH6tMcLrA2mXkPjaM+Z0DmqdjxHsABWyv6WSPHfpsDKwwA==
X-Received: by 2002:a17:902:f64d:b0:242:6f41:2351 with SMTP id d9443c01a7336-2446d756f8cmr135618585ad.14.1755508029517;
        Mon, 18 Aug 2025 02:07:09 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d554619sm74574605ad.141.2025.08.18.02.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:07:09 -0700 (PDT)
Message-ID: <5f3261c3-3e44-42a5-bac7-624ce4e7041f@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 14:37:03 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
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
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
 <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Kd7muMW6Mw5d-ltwN5SzWDvg76hGKJ9r
X-Proofpoint-ORIG-GUID: Kd7muMW6Mw5d-ltwN5SzWDvg76hGKJ9r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX90kCuPRfIopN
 hmQBfZFMJqAI0Yex91z2cpNMgTfqe72ukR47lt7KY454Tc1QjXsUlVZ9ewhttX3CoVMHziGaYm9
 V8PR6FskZHenAGfmFedUJUtbmA1iM1BsEMagzFlbo4cmpg/a7T0iCFt1pUQgnqYMh+3neAquVIf
 gzV1uORK/JJUlIvcA4cdKl3bYA0yMgRdr9yWUOgEldkGlEA4m+FORzAOOLfH7tcUmEEsoBknyud
 I+FqCGsOZF9LeSNvtXgi1bOWQ4WmPns1mFOK3uShv+ELXIAJ89jn2C0CvdC/TaLibLufAF2Zop4
 kLBgeeCUwdak1GWzW9mcW2CqP4IrL+N93dudni0/4Gt5UGDbBzoE5lQg4+FGCaBBsB14zZokrO7
 0ycNdzZ4
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a2ed3e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=jYHQ0JWC-Ns_2KpUhz4A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033



On 8/18/2025 2:32 PM, Viresh Kumar wrote:
> On 18-08-25, 13:52, Krishna Chaitanya Chundru wrote:
>> @@ -2210,45 +2213,67 @@ pcie1_opp_table: opp-table {
>>   				compatible = "operating-points-v2";
>>   
>>   				/* GEN 1 x1 */
>> -				opp-2500000 {
>> +				opp-2500000-1 {
> 
> Why mention -1 here when there is only one entry with this freq value
> ?
> 
>>   					opp-hz = /bits/ 64 <2500000>;
>>   					required-opps = <&rpmhpd_opp_low_svs>;
>>   					opp-peak-kBps = <250000 1>;
>> +					opp-level = <1>;
>>   				};
>>   
>> -				/* GEN 1 x2 and GEN 2 x1 */
>> -				opp-5000000 {
>> +				/* GEN 1 x2 */
>> +				opp-5000000-1 {
>> +					opp-hz = /bits/ 64 <5000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <500000 1>;
>> +					opp-level = <1>;
>> +				};
>> +
>> +				/* GEN 2 x1 */
>> +				opp-5000000-2 {
>>   					opp-hz = /bits/ 64 <5000000>;
>>   					required-opps = <&rpmhpd_opp_low_svs>;
>>   					opp-peak-kBps = <500000 1>;
>> +					opp-level = <2>;
>>   				};
> 
> This looks okay.
> 
>>   
>>   				/* GEN 2 x2 */
>> -				opp-10000000 {
>> +				opp-10000000-2 {
> 
> Why -2 here ?
> 
>>   					opp-hz = /bits/ 64 <10000000>;
>>   					required-opps = <&rpmhpd_opp_low_svs>;
>>   					opp-peak-kBps = <1000000 1>;
>> +					opp-level = <2>;
>>   				};
>>   
>>   				/* GEN 3 x1 */
>> -				opp-8000000 {
>> +				opp-8000000-3 {
> 
> same.
> 
>>   					opp-hz = /bits/ 64 <8000000>;
>>   					required-opps = <&rpmhpd_opp_nom>;
>>   					opp-peak-kBps = <984500 1>;
>> +					opp-level = <3>;
>> +				};
>> +
>> +				/* GEN 3 x2 */
>> +				opp-16000000-3 {
> 
> Shouldn't this be opp-16000000-1 only ? This is the first occurrence
> 16000000.
> 
>> +					opp-hz = /bits/ 64 <16000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <1969000 1>;
>> +					opp-level = <3>;
>>   				};
>>   
>> -				/* GEN 3 x2 and GEN 4 x1 */
>> -				opp-16000000 {
>> +				/* GEN 4 x1 */
>> +				opp-16000000-4 {
> 
> opp-16000000-2 ?
I tried to add the level as prefix as that will indicate the PCIe date
rate also instead of 1, 2 to make more aligned with the PCIe 
representations. I will update this in the commit text in my next
series.

- Krishna Chaitanya.
> 

