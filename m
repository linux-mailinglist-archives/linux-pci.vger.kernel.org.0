Return-Path: <linux-pci+bounces-27443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1133AAFCDF
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 16:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8E61BA36E4
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82826E16A;
	Thu,  8 May 2025 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dgh/ElC+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540C252911
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714380; cv=none; b=uE2Lqqi+uQbm6n9pUGxtxqNcdjf7oT6YWxGRFBjjaTE2cC9PFiZOXw87VM7BPX94uRNkSuouf5njGuIntRBOL3Id3wNwvdPRNFAYoOVSn70qx7AIsXfthBl7HUWT/JVF/Kg6nhr4Ez+QjbDGd02ceKmJVJ/WDZSrmgmA8fJxnbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714380; c=relaxed/simple;
	bh=uJm2d/sYysk/ox5eXeJvGB2Ff2/lvKGPfhJiU6lhUCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWDKsKLj+dS2XPAC5W2L7VFvAFyP5wvK/F9f+18Sp7++cOXTLnkHa0Et4ZsXZ+5D5zBJwddlj3sSHZyPFID7tFnhcFP4uKqX6uaYU6/Nk4Riuk8kSvufT+cvcGnaTSp0m0tGR4gUTX8Zt7HGBzYc50zCffnoyrVv6g4XwbOphcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dgh/ElC+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548DSpev016663
	for <linux-pci@vger.kernel.org>; Thu, 8 May 2025 14:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UXdlLGg1lnlu/LLea5+Zsq6a/vEhr+UdYLuwJ2Yk5Do=; b=Dgh/ElC+I0tBaC7m
	SxP/yOcwwBFJf5x6/b+2PcyAUWxy0V2vhQ+n2cm5EsGxCNrpa/+TRp3viakckvoJ
	MkM0d8/raFtVZZWo3DqNqk1bAXGYdi+Kg2/wnHCI5LJNIoyaN75xQavoeF8SOsyH
	FHXQ0CfiCH4Y7l8hxWQPVh8ivM1OtCDGvnK3u7TVkWseJH7cJIPNmLYLxLNuonqH
	mmU4WWsT+G8kcF85M2vXxrynXTzr9vnRYIFkezWWV872hX0GZei1HdOY6P1kRkhH
	AcN1q/hecHZCpmlZFQ/bG7+Qtqu1ReIOlzuNdvwwZ43i1n+K70N/ehhzk9EgZWVB
	DJKbtQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp8sjuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 14:26:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54be4b03aso22133685a.3
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 07:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714377; x=1747319177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXdlLGg1lnlu/LLea5+Zsq6a/vEhr+UdYLuwJ2Yk5Do=;
        b=TkKkwsjykdQ77Cxa87pu0/rGKu6lqIBk9jvl2hOrf3d+/V5mPjZRpTHEkU4L/Y9Lgb
         Fuo/9O187zSuofe4Zz/s0nEnBhFS3nNGqKb/6dhX4YEK+iK2xfTIwp7nMD2jogX62ocv
         isN0Wi6H0H4rH2BWlY+gdKM1i1+xNvDm7hitIlxdRdAaIEhXiiRXasi5wVJgu8QveYBm
         DfqRbFzYE1eJ+gfNcqnhFp4iJ4SKQur+cBDNvfP19zhS0Vw1QFqN46SHEHqrjYv+zNr7
         2leLY5egbrIZiW8SBUeZuKmXQ96IOj/vf0NgexNBFYH1oCUONlK+c56yyzMQWHotRZ6e
         os8w==
X-Forwarded-Encrypted: i=1; AJvYcCU7jEAtSBkwCDUTQkFRYSCl6UF5KEGDM+xb/X6oTcOn8VcbYZ7PRwDvL5PjJX9B+PhYXw4GBm5Qpuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgdC8KqO0yOrN9n3ylwdMr9ptRITLY8/EC+gSDEMS7hbYj1mk
	cDyxSzUU9ncgzVdNG16yXBKgnQxs8Iaa9w0vgVd3Fe8f7HBW9PwkmUw28hiVh9OfMByu/XzVZYL
	oXH2VGbkS+hm70GO1P5+qUpqCrJwk8+m9yEuq2OwWV2AbBIN6cPBAj1rWkQo=
X-Gm-Gg: ASbGncsdU1SCz6/E5jjdsEDElm1ItXoQN4FUdXUS+TIpV1YO7xtrv9zXpLz4j+/JLeM
	LVvL8F8Xpt9Nr/sb/hM1BROeIrH+aAoduyRY5mPzhD9xdXY9ZTNLiJEqAqqUM3yqucV/oTz5PzI
	gekG68sLDUipCI0yPEN0oMpLX5ov6Nly2m983abRdBijQdUBh9UkzNly5CyvZZU+f+jNcF8xcX+
	arRq2CbmUnvTfwGHMHxW4I42ynjeVS6MZZxaBoxKDhR1s5jgFWiV0Wao7OatZKugpbNAuwfHseH
	rErkECSbGvgXxuy1WhRFClp6Dj1kGAO1gI1lTXkxBgWYKYgfLor1c4ldXR5WE5ANiKQ=
X-Received: by 2002:a05:620a:319a:b0:7c3:c340:70bf with SMTP id af79cd13be357-7caf7420db2mr384145885a.14.1746714377146;
        Thu, 08 May 2025 07:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBmwqtRAYRbfqe3Sg4B1w/JN84aZ1KCtI2s+2ewc9k1uRUwUorYOTTAwQlq/ZNkjmJHGD2LQ==
X-Received: by 2002:a05:620a:319a:b0:7c3:c340:70bf with SMTP id af79cd13be357-7caf7420db2mr384143785a.14.1746714376822;
        Thu, 08 May 2025 07:26:16 -0700 (PDT)
Received: from [192.168.65.105] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fb9c00ddd8sm4639625a12.58.2025.05.08.07.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:26:16 -0700 (PDT)
Message-ID: <2ce28fb9-1184-4503-8f16-878d1fcb94cd@oss.qualcomm.com>
Date: Thu, 8 May 2025 16:26:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
To: Rob Herring <robh@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>
 <20250423153747.GA563929-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250423153747.GA563929-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -6HAlQ5efgJuSY-eyi3xz_BJ68Fxq76M
X-Proofpoint-ORIG-GUID: -6HAlQ5efgJuSY-eyi3xz_BJ68Fxq76M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyMyBTYWx0ZWRfXw11Jw+d0erkO
 Dix3aRhdbGdsZhSAgQwU8KNyIA7CI9nG36T7WN6ec5wN4era/8NYQeH8vDViVjePi7x22ueHE4u
 oirAxhW4NqpAMVnfvwdwEWenYKIcgk+2uYjGzwMKqxCyfiB7FlNsKSRClPzumhkHsboj6UTmEtM
 VFuRFQcdMfuU1O0bbWqUQMrFFWYxJg+O5B2HQpX/ksonfeqHVzUzBtw13ipbFrakGvmtSF9VEYp
 bVzn/neKr/ueNF7dJMGqQ2LqSsfvKxGR5rqTlTRsPnibKh4XoKaGnkR13uqnhGCgAyiuuAOjH6C
 Q6Ja5YyNJ+uwxRxSwzaBGkORHMtXDc7uwPrD8as1OTtLVzVgGu8JMVhH70j3Qv/s7F1CgM/MMG8
 mORzt4oB53Z0iLCjdubQgJ+cUKvGsCyiZfZXV3o859TqyTWbEQVChsjMVOXrRn5RVEI9fXzz
X-Authority-Analysis: v=2.4 cv=e/4GSbp/ c=1 sm=1 tr=0 ts=681cbf0a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EtpzxOmWCkDpKJZIM9sA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080123

On 4/23/25 5:37 PM, Rob Herring wrote:
> On Sat, Apr 19, 2025 at 10:49:26AM +0530, Krishna Chaitanya Chundru wrote:
>> There are many places we agreed to move the wake and perst gpio's
>> and phy etc to the pcie root port node instead of bridge node[1].
>>
>> So move the phy, phy-names, wake-gpio's in the root port.
>> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
>> start using that property instead of perst-gpio.
> 
> Moving the properties will break existing kernels. If that doesn't 
> matter for these platforms, say so in the commit msg.

I don't think we generally guarantee *forward* dt compatibility though, no?

Konrad

