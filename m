Return-Path: <linux-pci+bounces-37902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42462BD3B1C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97EFD4F5595
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DA3279903;
	Mon, 13 Oct 2025 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EEdFL5TA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0526F445
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366447; cv=none; b=Mn2ZImq1PzK+rgxdMPmNlGHj+s/kGJDvqX/zqHgjLJALTOhrUErfp16EuQTGuIKmdxF85wcuTMUFmUbNLlvYPRjHP24okAtheCotWENGMJlXIUTZUsG0pfWZw4QeghSaxJgmm21MwVHFLwMwEtBvhHSu/xa1Zr2EQRvi3qgtDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366447; c=relaxed/simple;
	bh=uFSEibwg15Yfs4Ful0TZVaUJugUCpioGWaNDWPNh0BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/4zom6kj3X+h8XjX5Yy80txh7e/UoROFyx3QABGafZ7dJp6LdDlRhadjAIQ8dK7hNWyj5nkw0HQAqf+rduYpsaDQ+kihC4zW4RCaUYHRvg5pOFoOUQr1zcPCu0Y++kntaVDLCvNaINPj1DrAVQs1ndgVXeSryfB6T9FCN6nZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EEdFL5TA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAnUAG023476
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 14:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VbizHHKsV7jcegOvOnMjuJPidY+Lis3OqZISqAQQ7K4=; b=EEdFL5TAtwBQskTh
	dns/10JANGZ8/7GFXAXsDjfcXKsmJN4VUpB4BmXQDQeEUPTR9hXwSRb2jiUOsbz+
	TzYrQ1DVhfizX+RVuI8SmPIs2LjNTdF8qF3mC2zRIjH7EC5TFcRjw9ezBMA/8Vvh
	/YMRk3nsXeoEIDlCKu1ZEQXfk7y3/7avrzrO8F/VpimphzTkQRccletcAannMQaD
	q8A6lTaiZrVDZm511gVweiY2Kcf/gVHNPv/q8xhnRC794fgGbS1Kr1rRsxORIuD3
	UMs8VHU+17qdnLrt2sSib8s+YPmd6R1Uuq5QGcoc/aNhaVgc5e7LP8TnT3WBf2wg
	L8Bl3A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdfvv1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 14:40:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-334b0876195so10203954a91.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 07:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760366444; x=1760971244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbizHHKsV7jcegOvOnMjuJPidY+Lis3OqZISqAQQ7K4=;
        b=uPDHJuQvjnkkZfnBz8eZiAwCcq4jHaIQySexihhWAO5ZHrlnZeX1PsyQ/W0paeVGYy
         b0IvWh3Ly+3MXw6Wq0gyjPvJ5aGH3nARAnwHOrCKflIAuV4Ip9vY13mPIEtHXcgbOsN4
         7xE0PkwGs+1MrNvD+HcA6faHYAUvByjD3K+kVEgPf5VO0PTjTIeJL+7q6b7PFdtNMPQ0
         sXxCKQ7ewUQxuVBRtFe4C3ZCINsoc4AtZECKYrF9wl7wlZ12NuKZkqcbJOy6m8y0Kr0Y
         Ro70lEzL+XO7b1aHOVR0tjlSftnrtmpOnlolBhcdDiNaV7KRv6MYndCcYUr3DtRggTn7
         bXDg==
X-Forwarded-Encrypted: i=1; AJvYcCVeQyJQWhrq6L3a3m50x/MxE0WZoOWEXbzKOM9gDc46EAqO3xdSU0k8ZQi4ukoKmWQ0JNnU6NYF/5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrtj1sjFQegErg0K78M3aMAyUerT/Pj4uyb++x2teuppCkLLr2
	AS31os831M2k1IuhUfheomtEBNO2Grl84tLwTXcKw1+ouA2/haaN8NvRdGMF9mGC1SbUEXsn5sV
	UcvVkoJUwKyQX7prbOUBpjnuixQgT2CoP+o8xaNaNKJQJUZihIzjrV1cMAaBKUbk=
X-Gm-Gg: ASbGnctDLaDHutctiBlMYyBimhpYUmhfbBG7KAPuheMiYGE2M6Lvfuk3WHE4p24TpLV
	dq7wJPCYjh+AZdddi9JJnfBUjrExZdj74OFDd+RYS++6ouZ2Hd4s47t6MGVjdGUlqYJPByo5qWi
	4uz9SRYzKfKSGJGhKQdbe4GSNpc0LAO3pWs7W7jHAro4LfwiFXLGCVC3eL0iDbnCNEz3Ew7HF6M
	+QOL8p/ezBlc9GyaIJ60tOCOZDj5a1ZZvgdCODLM/nAEPMT6Ec7FUkEfetHeVW1+BK95FZ/IKmm
	0Exh5Hv4ScGxl8vRXSL4Op58/l3+frg7OD5e/aX+xDAH4CmdnpoYMNfPfhiEdzEGeOSWS+6ndUw
	=
X-Received: by 2002:a17:90b:1a8a:b0:32e:8931:b59c with SMTP id 98e67ed59e1d1-33b5139a212mr30108793a91.27.1760366444495;
        Mon, 13 Oct 2025 07:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdBaAuEByPv3+L1OwSYtyIG6j/FbVOk9pX+s4HIIh/tSLS9uGYDZU004sWiinorIJt51OSjA==
X-Received: by 2002:a17:90b:1a8a:b0:32e:8931:b59c with SMTP id 98e67ed59e1d1-33b5139a212mr30108753a91.27.1760366443988;
        Mon, 13 Oct 2025 07:40:43 -0700 (PDT)
Received: from [192.168.29.113] ([49.43.227.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626e8bf5sm12228174a91.23.2025.10.13.07.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 07:40:43 -0700 (PDT)
Message-ID: <91e03d54-5de2-4f41-90df-3d46225edf64@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 20:10:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: qcom: Treat PHY and PERST# as optional for the
 new binding
To: Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-3-947c004b5699@oss.qualcomm.com>
 <4532e2e6-51bd-4443-ad51-41fc02065a7d@oss.qualcomm.com>
 <yvbghnxttchfvte3nxr4ru62wqilceil2n7x7dgpa5gnm57ywu@ljrbw3c44qpw>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <yvbghnxttchfvte3nxr4ru62wqilceil2n7x7dgpa5gnm57ywu@ljrbw3c44qpw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfXyfqcTc6ttE+q
 3fiHR7+xn2xbrAVNtnVnZaPK/CvedB3+j9FrEJM0Rbt1o8qd/Ro1pwQpIJd6jgWMoWrXYRQn2rq
 Won7Mp0UuhoKozQSQ5RXdevk7o8onqnSipMD3poowFJMBdAvV6NDQxS0O/oLLw8wtM+XaT4jNJW
 UERpYbza5sZpssGYgiJxBaD/3/ehELlj4A8Z6Qac5Ezc3K8EhehRD+tDfqSn5xhL5Wjf1OTwzep
 q83iIpbg1etbAdxKZXwxNYv+4+wWvsBsCs/lSpdhxqCAXDCO40GSjCsx27HKILkUJ2jzD88ucmN
 x5ThnFs3BVj3aRY/2fqzlq6s39/Sg2XqR+AHeSPBfSJsNBZJiw6WqfLyljyvyyKVXnqwPUuMgis
 5pV/1gM+TGNq4+rrY2JltXNe3zOepQ==
X-Proofpoint-GUID: 9nlFsn2UFSW2I1t6sL2bz4Sj_G5agKHH
X-Proofpoint-ORIG-GUID: 9nlFsn2UFSW2I1t6sL2bz4Sj_G5agKHH
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ed0f6d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=mKR/62aTrRaa7QINDUyomg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=DY-I8tSyz7GcGJVrnHcA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025



On 10/11/2025 9:39 AM, Manivannan Sadhasivam wrote:
> + GPIO folks for the below API query
> 
> On Fri, Oct 10, 2025 at 08:32:51PM +0200, Konrad Dybcio wrote:
>> On 10/10/25 8:25 PM, Manivannan Sadhasivam wrote:
>>> Even for the new DT binding where the PHY and PERST# properties are
>>> specified in the Root Port, both are optional. Hence, treat them as
>>> optional in the driver too.
>>
>> I suppose this makes sense if the PHY is transparent to the OS
>> or otherwise pre-programmed and PERST# is hardwired or otherwise
>> unnecessary.. both of which I suppose aren't totally impossible..
>>
> 
> PERST# is by definition an optional signal, but I'm not sure about why PHY is
> not used by the controller driver.
> 
one case where phy is optional is in pcie tunneling through usb4, there
we don't require any phy.

- Krishna Chaitanya.
>>>
>>> If both properties are not specified, then fall back to parsing the legacy
>>> binding for backwards compatibility.
>>>
>>> Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Port binding")
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 805edbbfe7eba496bc99ca82051dee43d240f359..d380981cf3ad78f549de3dc06bd2f626f8f53920 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -1720,13 +1720,20 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
>>>   
>>>   	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
>>>   				      "reset", GPIOD_OUT_HIGH, "PERST#");
>>> -	if (IS_ERR(reset))
>>> +	if (IS_ERR(reset) && PTR_ERR(reset) != -ENOENT)
>>>   		return PTR_ERR(reset);
>>
>> Please introduce an _optional variant instead
>>
> 
> Linus, Bartosz, are you OK with devm_fwnode_gpiod_get_optional() API? Just
> wanted to confirm before I go ahead as there are existing users checking for
> -ENOENT explicitly. Not sure if they are doing it for a reason other than the
> absence of the _optional variant or not.
> 
> - Mani
> 

