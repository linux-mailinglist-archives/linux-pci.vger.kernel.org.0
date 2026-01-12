Return-Path: <linux-pci+bounces-44494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBB6D124F4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 621BD3004F52
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A603559D4;
	Mon, 12 Jan 2026 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLT1KdOm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HgUXQEId"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263335505E
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217373; cv=none; b=rI648PTIhHsJ+gXQU5KwUplDx7mA2ArUhWmV7O24iIu+9OQwIBYEecOUFi8htB4j2u40J0/m76Cfq8PWDAR2+GrvravjvmWKBBHtd6c77zKFu42OTfa1tfRN93Wt324Ad4bi6uNn6oTiNjFISYOp5rMMmAv+TcBtCFARMoJ1Bcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217373; c=relaxed/simple;
	bh=VLK70LC18wkNjao+aGm2zjKT4RmVykaHdWPGuVEbRxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eO9JJgDQ4sjSf8MqKryKTyWWMtDixKkRMIhWN1jDQT2PR5fv6FVVqrTR330OC2ZkX4mSuKB3FGJ4i/ytlPRq3o8142dWm91cFAz+4laTI32sQwETSYUQbttiSxfOQjUJ0do3Ccj6I2ofhGSgBBqBNdRdzCv5rO2oAptAVzvCFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLT1KdOm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HgUXQEId; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C83Ifr2829404
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 11:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tUtpv5e/gy4OU7aN/5oKSOK0w10MtlmNCkbBwyyRAXk=; b=NLT1KdOmayE+14m/
	zOO/hFHB0QrZ/45xcZrsL9sI3DBHCQFQGlOpN2hwDo1jvFUzftyKAS0HBs9ju4v6
	erf+KB6JSoFF7jeJDnFfq3cPd2md+D07jCxLIHXfyhqYLm6ZebGAZLj5zcw0unNp
	W4J8A3kUBcxtCW27fCvjO7r7y/opARCtIlthVtSc0/kyqQr2a4I3Q+uOr6Qp4SJV
	9ioVdHp3CsaADRpDB8n59SpWYkVI0OWN28UTKEkxnETBcp/mQcE9MRvl4mOxl5O0
	6TBCYpMojwwaT39RDKapZAaHNGS05TGii7z5qS/4Gn+DzVtN+6c/YMhSIFQ7s+st
	HjWt/A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmkk41y2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 11:29:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1e17aa706so32731261cf.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 03:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768217370; x=1768822170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUtpv5e/gy4OU7aN/5oKSOK0w10MtlmNCkbBwyyRAXk=;
        b=HgUXQEIdu9vcT1X69uA1+Q0FqlP65lUfAc5Au+SFihTmkHS+PpCF2/QNe1GJOordWe
         hjXZhcOTMR/KzOup+kLjjGvChnJNETmgdy2TqQWtMSADMzp8uw9nnmm3JO7Kd0es1Ppd
         wt1Pcv6hYMfSqL/p7oJeHjrUZBHW8IHeV0XYluXrIJHDlsJFF5GPCEaLBtd6IUA9v5fG
         +QOGTpfP4YcZ51ywgeM/EtdFLyhbvEE/miFoBPokRKZDQs6KVCQpzfyqNi32B04lKQi3
         irBaQ2JDjo8pnHm/GEA26Z6sarI+Xy/IpFvtGXwXSav/IpIoTaKA7swrmquWYaXsJ9cq
         h/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768217370; x=1768822170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUtpv5e/gy4OU7aN/5oKSOK0w10MtlmNCkbBwyyRAXk=;
        b=ZvBKpdeyAp89r7hAsfuc+RQhNVTX09Qmy2hbhbslVJ6XOqb/z/+NRdKNd0nIWwQRyZ
         deFh7mrXWd+FCepriQ0zcVlbgLm+TCKzS+2DlWWJyieMWPGnxsOG79WO5JmAvCaNlGvo
         Tr1e8WUFqVp7janqmM8xwJCwG0mHbSEwF2z1Jz9SLL7Q4+5NgFFYqXmckKRqzrVWyh8k
         8PmHkq5oLb1DmDUkYfhZ+8CrR4L2R+2et0cl+/T6vSuvbXHp20wd0PfiYvOHQzqQNXxJ
         s2IiJe1gNc4FuGlUd1SdkA1SSiTo9RUj1NDG4/Mt9DtZBVMR70fGX4QOiu8rNfKNkf5t
         YJQA==
X-Forwarded-Encrypted: i=1; AJvYcCWEWLEz95Hrugh/UW2LiTOaWgpg/EHub5VDP6DK6gweXJc/hiVCWS7GGBAxXIuYMyxDI8bJky7pkc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH85EsLRvni8T35qj5D3GQ2IfljGXFrcL7m4zcsqodqeTqi9XL
	mN58LCpJ7LzQvwvhBrM0xXiyLtCUuAVCPfbx2mU70qMEvto/ErbV6fbYWy2acuCn26zY2VAvcos
	Yhal5IsGBzvMLujRFfbF4XmYSyHNaSajkxSSJaifeG2rHBMeJ9ozA1TKCoVK1oEc=
X-Gm-Gg: AY/fxX6JaBLnyzqwdZP5z9Oue9CAYFK+INyCv/BQx6TXqsWwbiBFJPlResczzYse/iU
	6+/r8/aG+zYLH5olrdDUujrTy2irU5C1WSf7sLeL3jMGQgvTOPz3pPsWgwVXZP0MR+CV48oVzw6
	B8E3w7kRa4QFof4jPgszH7mi80M6ztUiKNINk7MFARF6tyPLc12HATGL/lWHfj8u23BdzEYlz06
	e32CjcHQawgBp35EqgKlyO/hLva9tw7dWxxLeHHty8HRjOLkkoRl/VlnuallwbH4g4nzj9ju69N
	i3UbnoyGV9sq3vWcaW7wRGKSGUe/RuSREXWc43SSU1nw7lbf+Z5EdBqJzaXsqBdHDwA7gEqdTT+
	zr5Z5p7GoqAWZ9mVU7zRix8pduNZPq/hGu9iYU/53I+xV7Gq3Uts9Jcaw3sjCqB8q99c=
X-Received: by 2002:ac8:7c4b:0:b0:4ee:4482:e838 with SMTP id d75a77b69052e-4ffb47e2d4bmr190431441cf.1.1768217370424;
        Mon, 12 Jan 2026 03:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi/U/8coggZOauhZL/T7g+wAK5iJgcYMafFH0a6UdArjpaA3jBAYm8fDnA4Y55d2WDEEvi6g==
X-Received: by 2002:ac8:7c4b:0:b0:4ee:4482:e838 with SMTP id d75a77b69052e-4ffb47e2d4bmr190431141cf.1.1768217369973;
        Mon, 12 Jan 2026 03:29:29 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87023a8a33sm538070066b.18.2026.01.12.03.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 03:29:29 -0800 (PST)
Message-ID: <816456c5-ad32-4829-ae0d-a0d09f468863@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 12:29:26 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] PCI: dwc: Add support for retaining link during host
 init
To: Bjorn Helgaas <helgaas@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260109155350.GA546142@bhelgaas>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260109155350.GA546142@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LpBvhNAB7AyITvcwVKKZgXtw0b3FGf3_
X-Proofpoint-ORIG-GUID: LpBvhNAB7AyITvcwVKKZgXtw0b3FGf3_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5MSBTYWx0ZWRfXzNiX+u21Z3pk
 giS8BCibuL9YgBVd/rrMfTn2cZaMvxK7eoYQDh44i/deg8xzJnH2IvIFCiaPrZLl9+55JXmDBKn
 I6sAmnhFRt0NEwwpGHEJqzC5/kPm2UOpqP4Vyw8sUtd9mN0sCUDWCnWvKhUPhu3C5ce8GOCX7jU
 a+FBUb7UH4Jwd2FW1FRNymQ4X/r5uEf+HgdJcD3B9YSzlPK32NpvVhlb2TzL1XHJfwsJYuigSOR
 4gC6jgxTBaRLPJ4aH5HWGUcYWUXTnzjg5Lt4Un3N1I5di9+vLQdgHMt9Vlq7V2XgAZddKJfQ4Ls
 qCTt0JrsAd2M2XmO/cpM3BKM/mEEkN0FeekjnWp1RupUxL0m7gODJ2ARCvug2P6xwxsp4jMadMm
 D1hvSPcAAp7UhUc2omeftXNJtgXyV7nYC5HSHqSemZJdp2XoJMppqAfWu3CV/v9ZYC6oHsYvZen
 rV4AdaozO5iSe5yEkhQ==
X-Authority-Analysis: v=2.4 cv=cs2WUl4i c=1 sm=1 tr=0 ts=6964db1b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=sQDjRcaqkbB8EtgPkRQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120091

On 1/9/26 4:53 PM, Bjorn Helgaas wrote:
> On Fri, Jan 09, 2026 at 12:51:07PM +0530, Krishna Chaitanya Chundru wrote:
>> Some platforms keep the PCIe link up across bootloader and kernel
>> handoff. In such cases, reinitializing the root complex is unnecessary
>> if the DWC glue drivers wants to retain the PCIe link.
>>
>> Introduce a link_retain flag in struct dw_pcie_rp to indicate that
>> the link should be preserved. When this flag is set by DWC glue drivers,
>> skip dw_pcie_setup_rc() and only initialize MSI, avoiding redundant
>> configuration steps.
> 
> It sounds like this adds an assumption that the bootloader
> initialization is the same as what dw_pcie_setup_rc() would do.  This
> assumption also applies to future changes in dw_pcie_setup_rc().
> 
> It looks like you mention an issue like this in [PATCH 4/5]; DBI & ATU
> base being different than "HLOS" (whatever that is).  This sounds like

FYI, "HLOS" is a Qualcomm term for "High-Level OS".. which is a very
pedantic way to say "OS"

Konrad

