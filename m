Return-Path: <linux-pci+bounces-18874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FEE9F8F46
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE601646C4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66F1AF0BB;
	Fri, 20 Dec 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TnXttQgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85F1AA1F4
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688127; cv=none; b=cDiitRV54dh79RduLO7DpnIrUFlx7A1fwYbdqGbEKbePxGU2rCoJV/YMCGg/6cQWel6I65tGDTvj/5GH53m8MY7tp2fBFU1e2BqVSLXywzZ+XUdRbRkaCmzpoUdZHH/ruBKmrs9VrNSk7PYgQXft4ZgKt0Nes6WOIUDKOvIQ3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688127; c=relaxed/simple;
	bh=/u9h2u8VCyh8Wn9919kX8kdRK2eFwLLsCmZITUi20AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/v8MRZuH/4zOvgCHAaG3c+PuUcSJTvwmnPdT5iWEGPgsgZ2ltbWJlIiZqUs3rqzeWC3NILpmdKTGObd1kAtPT06At5cbUFXwRSSHwVpZnb4NfxrNVQm6LIA1KTxQwpTMR3pNPDKxL7dwuu4j/QJL5pP+M9cT7DJwkMI6zRHgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TnXttQgS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK4PZpc024611
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rVUKpvjNKYGH0d1LGTP6M2rnV3QaECUxpVoVBYXGfy8=; b=TnXttQgSCor7rJoe
	ZTBEftsaaXQeMsPvYEG6HAS4ZywCAggRUc0fj9YqhkUyaAK5MEE17GJItr7P8s+m
	oS95fkfGpPDhHflfjcPq+3lvpJVQL15DY3U/8YlscKeqKiGpdeDOOcL19dCOADRM
	cx+y4aw6AqTuRW0jdE7Mb715dmGANGaBDFjB6mOq8gJnXDMHsNDjJCMJAGR6gcF2
	bKtVe6IdhtdgVIlGrz2CdQoOT2Gtn//PsNZW2LHNQuCadDIpDXf8qcJtYezBSZhA
	a6lGQMpiSAvwu2AoEVzyIIs7KtTdwa/Y5FdTkz+Gq8+APwEacS7Q6xmKafS/U3pN
	fLjmMA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n1hx0td6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:48:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8e7016630so4028676d6.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 01:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734688124; x=1735292924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVUKpvjNKYGH0d1LGTP6M2rnV3QaECUxpVoVBYXGfy8=;
        b=M9t6gA2AN8admVcG49kGFR06LYe7qHU5JjvKOl7xhDrFcFSNDYJrn/iM5emWq5OHTp
         qRetuNFDb4lEd9NL8seWolSnfqrgdZVzbp1cS1WBJgAhSYSCJmCgJqWswbDCr95p+ZRe
         labLMtxoRS7WcrtynPDzfLOogkWjLUShMdEJM3ZE7yXII7IWVXECHoo2uNcrcoVeTU6/
         mWYdeTnMH/yHuoRqQl9lMQ3hwheqYzYY8z1P0CiRK6rQA98HjKjU2wTLXjPaojprNvz3
         hJoJvltaBAyaxzxXau6Jq3l/c9k+rLW05d4aGxB1NdYadkvyHERNNXWlwu0Klx+CHr0z
         /Sog==
X-Forwarded-Encrypted: i=1; AJvYcCU7KNNX+7tyn3jzM3Tp8ExCnPAwf7IhT9RHUbHnmvnnleIgcHpnj5NNWlYgn+g6r5cz8yQp1AmpQVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWo8KpfQvYZFtLNaoTIjE7lXjejKZuNZJl5EEmW3OORn92hBaQ
	lkDjq8fSzV4HyAgeRDTXaDXe5qHp+t2MO2msha1LiYY7UqNjgxglt02HN4a18E4kk8z7RVLTcvM
	5/sniRTLI+n16E4Vwn+f/bzLOLaRI0msK5qGX8Y0M73R5cuKpJaW+dE8YH2A=
X-Gm-Gg: ASbGncv9vJWF6eOQ1axbJTMSx5SRhYNhBOSYO3ZihyPNavkDTQOfxpAWY22wtDhr4Pj
	VHwMhh2Gr0BEcJgZhZU2A3Krj1cXl1MrwbtPoyQvK0vT4nUCS/62YMdKvtyTbazdEratYaD1IBp
	CD0GGmL6PEcGuJrLEYH5Zd8At1adwLNBboZQuFHijZBiwaffxD22s5ht7/gpcnZYYOTiUs7jQJo
	r94YKVICt5ma/FCFAtp+uD5cnljwtcwyFCdw8PY8bRP1KHR3Gvm1UHh9aL++ZJEtBuybnhXBJ9D
	bt+ezsgs+fRt4tRxfZqPUFYPHvEeX36XuQA=
X-Received: by 2002:ac8:7c56:0:b0:467:6379:8d2f with SMTP id d75a77b69052e-46a4a9a3aa9mr14362451cf.15.1734688123784;
        Fri, 20 Dec 2024 01:48:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrggBl9ERFYcbqyZk1aIf/jeZFXwznISS8GkbxVKTIw+S69nHydV8TNBfU9FuwstBBRIOaUQ==
X-Received: by 2002:ac8:7c56:0:b0:467:6379:8d2f with SMTP id d75a77b69052e-46a4a9a3aa9mr14362341cf.15.1734688123444;
        Fri, 20 Dec 2024 01:48:43 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f011efdsm156471866b.134.2024.12.20.01.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 01:48:42 -0800 (PST)
Message-ID: <71d2135f-664a-465d-bc1f-051cc07c8537@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 10:48:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: ipq5424: Add PCIe PHYs and
 controller nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, bhelgaas@google.com,
        lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
 <20241213134950.234946-4-quic_mmanikan@quicinc.com>
 <69dffe54-939d-47c3-b951-4a4dea11eae0@oss.qualcomm.com>
 <08fbde92-a827-4270-a143-cca56a274e6c@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <08fbde92-a827-4270-a143-cca56a274e6c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SB7gT5AzumvXCYsDgMms7_AUDoBeUVBC
X-Proofpoint-ORIG-GUID: SB7gT5AzumvXCYsDgMms7_AUDoBeUVBC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200080

On 20.12.2024 7:42 AM, Manikanta Mylavarapu wrote:
> 
> 
> On 12/13/2024 8:36 PM, Konrad Dybcio wrote:
>> On 13.12.2024 2:49 PM, Manikanta Mylavarapu wrote:
>>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>>> found on IPQ5424 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---

[...]

>>>  		tlmm: pinctrl@1000000 {
>>>  			compatible = "qcom,ipq5424-tlmm";
>>> @@ -168,11 +261,11 @@ gcc: clock-controller@1800000 {
>>>  			reg = <0 0x01800000 0 0x40000>;
>>>  			clocks = <&xo_board>,
>>>  				 <&sleep_clk>,
>>> +				 <&pcie0_phy>,
>>> +				 <&pcie1_phy>,
>>>  				 <0>,
>>
>> This leftover zero needs to be removed too, currently the wrong
>> clocks are used as parents
>>
> 
> Hi Konrad,
> 
> The '<0>' entry is for "USB PCIE wrapper pipe clock source".
> And, will update the pcie entries as follows
> 	<&pcie0_phy GCC_PCIE0_PIPE_CLK>
> 	<&pcie1_phy GCC_PCIE1_PIPE_CLK>
> 	<&pcie2_phy GCC_PCIE2_PIPE_CLK>
> 	<&pcie3_phy GCC_PCIE3_PIPE_CLK>
> 
> Please correct me if i am wrong.

The order of these is fixed by the first enum in
drivers/clk/qcom/gcc-ipq5424.c. The <0> entry must be at the end of
the clocks list for it to do what you want it to.

Konrad

