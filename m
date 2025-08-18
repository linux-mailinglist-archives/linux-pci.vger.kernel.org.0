Return-Path: <linux-pci+bounces-34185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87006B29D0F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6EA7A9E12
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584C30C373;
	Mon, 18 Aug 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BBXQsSOH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7E2F39AD
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507892; cv=none; b=OIhTuf+LgUeUTJfvdq2cdEgW6+Dbcjy/lg2eFmgaPW2XqjHseAywk0y7l/rZeobaWMPetIJnwbIlJdRg4v07mQabc2/ggrg1Za49jHi6yrg/It7WLMSL5ucD1tZKoTHvEoXYFFOVmLK80/j58map4J8rOM6cyHN0dLR8X6DSFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507892; c=relaxed/simple;
	bh=7eHIPEpHmH++L8mgdGXYq73W+DK/YmDiZBX3MvshN+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgCzvVz0CCTTftaTIlyc68eF+5D5uQmMHKBQJIIXJc3RqHvPOXwsbTU0fE9Eedj/crVVQj1v4tg5wUKxnbusyGLnmaizk6ER+ef2l3SDmAiD1NBtI5UV22WvQUg564UtNQ+gL4Z+dmyNQ30SoO57Fc3crdlzZO8HhHwlUuo8XOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BBXQsSOH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8EGkM020005
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 09:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hx7GazS6KddK4CRvhI8Jo5HoBHvhj7rho2N3bAP0xhE=; b=BBXQsSOHU3PSvwE5
	uiIHg/p4zJqhnMmh4cRlqCScbU8dRhy0rS0Z8ghOpqF6zpIvCR5O2NAwOUdgCuFh
	Mgzp33WzxgCWICzxzFAavQcRuiVSuiPNWBN0ZfhQgAxK0RNe7DRWIXiIg78tT9vN
	nfHI54lhXikMwCNQS+g4vpAUyokmcJN/ZxLfLo0QOLVAi0P3BJ0brl4yteiw3FqY
	jme0gisUozr8yAWGVglJsitVQWJDBTTp1TfZLdifCypiTZJ+exO9CcpAXqqwz/43
	fEzEpQK5vkdgt51DCfdVZ4cG+quUC3eBgFkuYZsbBL22LD5jAHZxr6w2djbAU97X
	1vJR1A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfv073-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 09:04:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581950a1so44204915ad.2
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 02:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507889; x=1756112689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hx7GazS6KddK4CRvhI8Jo5HoBHvhj7rho2N3bAP0xhE=;
        b=pQSywG+Owjnk1LMSa8VFEue1lgVxvTF/J5pfaguLJGno4cp4RndUUaeBKsjGjWY4Mh
         xmhLzoQwtKobIA3VfiZtjPDSWaQ36TaVzZfj0+5F7YqfNdLHlETaCxKFap+WjdQoAItG
         6XCp14dF2b5pc+Qt/VROvfvIDOI1iy1RHZ6vHmOANgRgV7kEqna6FV0M3o9sfHdudE/l
         Q3Puyx6MgJlQj0hbmHriFbb/foRBxCGAu292LwzoCv5ypcwMp4ci97I9JnEX1Sb+aCUV
         Fh754Nqg1yeh7IdFpHysM8uLOJZtJMIuzU85yTBPI5EfH+Txbmwf/9m5CdRbDZQbQP2w
         atPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUWSWwLb01t3LxkKmt4CGTozJGmb2jcdJPFw6udOdSJ9m1kd309lhx3LooPdPOKFa5pW/R/pHUvdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77U4W7qcg9CPrX2vkPVn+WwvXjGNgA18VqjdIuVjdVA2GnH+b
	gAwcKngFepa6MKaB7ufwadg7vMlEGwHCt1Mpc4R/xVW+i5slJu1np5LwEmsA8Qr3OWjonk3v/Gk
	MvdW8wIpwm4CkmeCtRor1OQ3hQOd8J912yZFaxYSCOLLZ34mdLtIgCic0tugd35k=
X-Gm-Gg: ASbGnctCQc40KiDr/MbxXMQTk8sAVcwOZXUQLQyBCUvmES7dukIZOtqRSFHmCWp9vBb
	W6Vgvdbv21qi1UiELpkP2pkVTaXh4yUSBBqZvF/UJdkNbqfOrN3JxFOW+rNVX9817sHuwe/+CEc
	4JYDkzmZe6HG+lAEfGYsYIj3pPHuHpbwDrsDdj9pw8q/53MTtMlOnxmkQY/BOeiItVVJXKiYki+
	1bRcbOsuKr3/ri3HLjtEfTm6nYw676wxdruGw9vN91ASuSXDCDpZ6e81t0Tcv7drEqbkAMC/zSF
	5nHoHhd2Kb0VDPKU92jcwEZDZ1nO53utGOA/YAVcryKrrkOh+O6otBqs3s6I/AZFWlVeWkkSiA=
	=
X-Received: by 2002:a17:902:ebca:b0:234:8e78:ce8a with SMTP id d9443c01a7336-2446d93a799mr162537895ad.48.1755507888999;
        Mon, 18 Aug 2025 02:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJmiHRJLFufB9IO8hcgWH6q7B7pvAk/hvQzVpakplvV5KEBqQ7f56zxSxhND4Y0wxQpYb9DA==
X-Received: by 2002:a17:902:ebca:b0:234:8e78:ce8a with SMTP id d9443c01a7336-2446d93a799mr162536185ad.48.1755507888387;
        Mon, 18 Aug 2025 02:04:48 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe38sm73988355ad.135.2025.08.18.02.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:04:48 -0700 (PDT)
Message-ID: <1f9d1b45-9267-4633-94ef-33f6f1c51401@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 14:34:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
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
 <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>
 <20250818085517.dj2nk4jeex263hvj@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250818085517.dj2nk4jeex263hvj@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jlDRHlJ3axT29sGK2s2YPVEFUreFUxqX
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a2ecb2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=1nWJchpGOjdSI0JMKxwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfX2JPw6g+hmsqG
 mT6/QKhK3YHsYl7M7Dp/VHRE7JDFAM1ky76iKcHeZOhQfy/+GRpSeiR+n59WWp6o+uikB1YlYxF
 Qybv0LT82I0pRTySUkfvNauvcEO8j91YIor1TEzht4tnfdRY1RCnFm6KsC88jY7W38Hrcj/cmKw
 Z2YjtvBe4vcbtm75JiLdgcvIQ90y21W0MbYtmp/yUyUGEvMTqH6xIZAd9KO4CHSVaK9RdwUKtYg
 BuMvGMl8unUi3DbVIclYopTwEcbo1XlRNifOiE7Gpkdk1qn6wYp/wITEvshDNl7podtBFsn2r9H
 vg5czv4F7pX9mvJ3wJaePD1TKWk/Xa3zg70aRovORRa1qqDAd1BzzPTivDjzUjt82/F9BwYIugJ
 FCBM6zbl
X-Proofpoint-ORIG-GUID: jlDRHlJ3axT29sGK2s2YPVEFUreFUxqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039



On 8/18/2025 2:25 PM, Viresh Kumar wrote:
> On 18-08-25, 13:52, Krishna Chaitanya Chundru wrote:
>> +static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
>> +				   struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
>> +{
>> +	bool freq_match = (opp_key.freq == 0 || key.freq == 0 || opp_key.freq == key.freq);
> 
> Why !opp_key.freq is okay ? If the user has provided a freq value,
> then it must match. Isn't it ?
> 
ok I will fix this in next patch.
>> +	bool level_match = (opp_key.level == OPP_LEVEL_UNSET ||
>> +			    key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);
> 
> We should compare bw too I guess in the same routine.
ok I will add bw similar to level,
> 
>> +	if (freq_match && level_match) {
>> +		*opp = temp_opp;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +/**
>> + * dev_pm_opp_find_freq_level_exact() - Search for an exact frequency and level
> 
> Instead dev_pm_opp_find_key_exact() and let the user pass the key
> struct itself.
> 
ack
>> +struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
>> +						    unsigned long freq,
>> +						    unsigned int level,
>> +						    bool available)
>> +{
>> +	struct opp_table *opp_table __free(put_opp_table);
> 
> The constructor here must be real, i.e. initialize opp_table here
> itself. This is well documented in cleanup.h. Yes there are examples
> like this in the OPP core which are required to be fixed too.
ack.

- Krishna Chaitanya.
> 

