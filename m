Return-Path: <linux-pci+bounces-32305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E14B07BCD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675D97B1E92
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5932F6F8C;
	Wed, 16 Jul 2025 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcrgpN0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4A2F5491
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685898; cv=none; b=YYRYMUj2OkjqumAZvY5ytgwrsBolN7SY47KC6cUMU+m5ubavLaXeucCNBeXz37QnLBRSmlmw3eRsm0XUwRaJ/kREtLrUl6tlwYarT11GlMah85szWNJjldKkeaXyI43ASFNeD8tvk/1BGXO0m79obc1b8wf7kY0MM3mize0SfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685898; c=relaxed/simple;
	bh=teMc9fjwUgbak3TeVa32zmM1K7Kuh41Gi+pH8Ju0/BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLuQpcd8dQuV1Q1WTjxfZ+KWhlGduLqTfd/hS75Okl9+GjdYe6Vrjld84Bqy7FBzOI5dL2yNo746SE6oVpv6eed4v8jjS202D/RocNUcKishaZGR1FdyEkq/0BNyNDd59ZvaeudLFCRCgzkKjEFcM7SfAY4YCsJj2B5uvoQw3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcrgpN0R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGDeMM030598
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 17:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AvZu+s6FPUG3iM8B2iDP144HoBABMQMyB2lUuofN4v8=; b=lcrgpN0RS21s/wFj
	BA3V9E2v1JVAb0Jubcya9oPGT/MF+0yYlDwuJymmhDfnmwOBvvSZbbRcJCBu1TOY
	8NLV+BAE+cMui13Nej2B0JwpSsfbb4p+XU1HEM8aFm6g/eSVLKdLXMhUan+Wo37U
	LyaF8coJAdDXauV/J+qOph7zsKyDCWH2iAWQGHe/M6upStdCLSQNHLxJHs2xdLyA
	3EyrsJuzQ5fqObKx9gfBbbjcyyVvdCO4R/aO/aN3jLhSi+KVjnO5pgQcPhEFwVp/
	8OZdVTpXIZiVJPZLCb1QIh2yqciql6cFRNZ8xSj9ykqhbeAsK6/K1AvK9BPDslu2
	Z0w+Ag==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7hk5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 17:11:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23507382e64so280655ad.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 10:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752685890; x=1753290690;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvZu+s6FPUG3iM8B2iDP144HoBABMQMyB2lUuofN4v8=;
        b=LN+Z+aWD1npZv8V93E5M9CLnq6KPSCbGGnN0OOD+IudJfcu1H+/UAB/t6/2EOhZTE8
         L2vP6pPwTsWQ/9j6DG9u0yInXeNK8l+Aez5t+wuzp7peEfOAg46EWYbl/DOMDTkMjUgy
         Zuk9YPBwsUwlTajzN1HVP23j4JB1R2jBqHHlfjnEyaybAkn9dGk/QuPldNpqJq9/xhw0
         t3W7S67VTjwj3JVpydYzFbwTdZnZ1HDS3WmtzYotW000sp5U5vpqFGsLZtS0ZlwOeCKV
         aOqpA8DAihGfM4vXxvvmiA25aw3tmiWbKIZSnMlzB9Ma/MD6GCCv65dV//gMCFhLJD70
         ajCg==
X-Forwarded-Encrypted: i=1; AJvYcCUcx+/5wpArx8GMI/vb57rdenEFM19tP7iqMxqlVDxvx9HNzFf4xZo6u209/JV9GgvE7cqZvQ6ilxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjf2xxUKuGJFIpdyM3RgkCdDxZhGPeTxjvaXSvvhB4voGdHZLz
	Yi9AEhSu8+eBvQRN39/zDBMs6cGdevE1dRtAaaVYauSJ3Ek2lJ7Z3OGOqMXJ3mkh33PYAchKoa0
	7dA1zwPAxQmmTP/XDO/0UbPwUfwHHZ4KoLcxd4t9uUDquljWsJSvttKdu1CeQSVk=
X-Gm-Gg: ASbGncuKl08sP5cMLPExE+XD9XWdKqTS8vxM/UxOOXIDzokE2O7bqmUHDTkVdJ+fJJu
	Cbs0ZrgCd8lCOgTYHM9ATH5igAKiwAVAy/YFIxb+c9sE4pZ3k7cGLeuVASRRvCpfh/OjoeDC1QK
	ZNCqGHQ1wj2D6BQt0hvm1pf2bcJ5LMTDSLVkUAMPrl+xfO6wp98iH95eeDTJ5dfwdv55g9mu05I
	72d3W+wGtfz1V5xZI5vY84I4VrskuAFkrDXjiPphlSjPDXmZvhnZ84g3Y1FbrLlyb5fNpbv8emj
	woh5TkVEH92X+jWtTZN0EqkwBrgl61gIjY2jDIUWI26JawtAd6b+nzh2eDZUBwq//4vUN9M1cKK
	SBfwOrlryXPEa+kbwzwE=
X-Received: by 2002:a17:903:1cf:b0:235:efbb:9539 with SMTP id d9443c01a7336-23e256b6e94mr60970185ad.17.1752685890508;
        Wed, 16 Jul 2025 10:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCaXQ8h/tJKVUb7+n8ZsAIn5RASnIJXRAkFzeIQw6HcoivPyubiz6hlD2vF/imJdL6JmfECw==
X-Received: by 2002:a17:903:1cf:b0:235:efbb:9539 with SMTP id d9443c01a7336-23e256b6e94mr60969775ad.17.1752685890010;
        Wed, 16 Jul 2025 10:11:30 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42abd8esm128205355ad.54.2025.07.16.10.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 10:11:29 -0700 (PDT)
Message-ID: <f3374104-684d-48c7-9e2d-e97dd48700e9@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 10:11:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PCI/ASPM: Fix pci_enable_link_state*() APIs behavior
To: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1NSBTYWx0ZWRfX6GHDbI348Cge
 AJHsxNz2Ycz8RoDevm3vL2/7DSuhe/4Xj36r6HncM3KwOrAj6B1H60WwMX5iXHU/XX6rseEi0Gl
 OQjksz5o8fySj3Sm5OQYnO1VNn+FetSw4sELq490aJmc2S5Ra885dT7sx3s7nBUK4QcAv21+DZ2
 NAZCnmISpLHK4AN4NcXfwIa2ekqVLtm4H5DcT//srNNopYh5S82rt0xZXFOUs7w30ZO2Wp0ifcF
 R66Gfn9PoNkgKdkAo3Mx6ftZReYSTOieRQFTPSB5c4wcIBb4uw3HrV/w3YBXJ5GbEA2InZJNvMG
 n63KH+0AxgY2C9JLB17iX5YXJrrX+DQGlLoZiQCLZD+RPUhMHDNU/ZSqKapyaxbvqrkwUq8dDD6
 CZhnt+qXsQmde9ybmuG0fy2vuqUIt/u/ParKXZbTyzAgooV3ou12pT1Yo+m0gtOCZtc5vNky
X-Proofpoint-GUID: vZ0_8IX64-dlRtTenQ8hcRe34nNdovz3
X-Proofpoint-ORIG-GUID: vZ0_8IX64-dlRtTenQ8hcRe34nNdovz3
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=6877dd43 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rhYh_zIkBfzxVmIspk8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=435 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160155

On 7/16/2025 5:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> Merging Strategy
> ================
> 
> Even though there is no build dependency between PCI core and atheros patches,
> there is a functional dependency. So I'd recommend creating an immutable branch
> with PCI patches and merging that branch into both PCI and linux-wireless trees
> and finally merging the atheros patches into linux-wireless tree.
> 
> If immutable branch seems like a hassle, then PCI core patches could get merged
> for 6.17 and atheros patches can wait for 6.18.

I'm fine with either strategy. In the first case I'd merge the immutable
branch into the ath tree. Note I plan to issue my final PR to linux-wireless
for the 6.17 merge window on Monday, so we should close on this decision soon.

/jeff

