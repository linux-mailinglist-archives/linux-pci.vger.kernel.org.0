Return-Path: <linux-pci+bounces-43305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC77CCC00B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B96A4301912C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3AC34104C;
	Thu, 18 Dec 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OTgO9f8Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MsZOjVgc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6033F8A1
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064543; cv=none; b=gUH/pRRUDZTF+FIp0CfccLVdsGGvUvXz7/aBjZ9xBM+VfJj7OodT8XSLra0+h+2DxUtrj8W98TYd3e96n2JkG0FiKD3fN2U6RNasV9X5hVLgy8kP634iUorX6mnbWSLcOBz95m+ts8p/8K+8aBBVGMk8hfFSDfCwFSPcKVaD/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064543; c=relaxed/simple;
	bh=VDCahGofHHWitV3AbKaCYA9eLErNsu+V5RIxWhottrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJx3IJSfr2+OUyxJ1UCG74kUoAGAtQjWRYE+VSN4CIqq+tJHILN8cTkPgvTNtj59jRxWPAHWv+lTixOyguBOgMvkuCwTf4T0f9AFQz6xD84jR0nNyvyrtgCGWrXq6/Icija3i4jpgoSCC7NNfMi+Y+ixF43ddjLSuQw6xRNZZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OTgO9f8Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MsZOjVgc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIB5M741334760
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 13:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4d8nE/j4LG4aJ1litu/i0JqfT3L0+tYvMgLM3qO1rYg=; b=OTgO9f8ZgnPq43NJ
	iH8x5DyWxdTrKcKhXKH6ljaFKIRq3gx5PoH6jldoG29y4f18aNxE8eymfBdpmXIA
	mITh48kRj06X1REqxan+I2mc8i5/+OT1ZpTn9psN+sGc/ZcdObUk6kE3+06dyw4P
	HZGvdVV4EpLiDtecMp3KBr5mgWTsrLY8H5s1afRo+Av1qkH5ACzHGcYNcBXveYZp
	ntecnRpY+dccT15ePoEGZDrcp3nwVEKmp75g+tAbn3PP+81Ty44mpQMg3vsqhDZL
	7LcxmonEtw3DxTke97P/Ivr4+YtWvjs8eMk4nUrMlAPlc4UAXNsnOL5aCbLX8oMR
	aSrjdA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4gec0dxu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 13:29:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f47c0e60so15845005ad.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766064541; x=1766669341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4d8nE/j4LG4aJ1litu/i0JqfT3L0+tYvMgLM3qO1rYg=;
        b=MsZOjVgccfr8fM+Uo3ZeC4WOjISOocWWdReL7ZmcJE6bMMEgCOecdcdnOFb1rxKDLU
         4qLZta5hP2OU5C61RwsDbLVjYT5V1sDxbKthBrG5s3DZ/H6Nf1tqGp559cMLeQDNG3p3
         alIhAC8z83AsCeSS0HA1ZjdNst/+CJ7y0dEB4Botnh7TreA/VrGr/XzSLpAzxFlN+RG8
         3agRyvMJrFiWAp6XCaJ3sW7d0jcT4t4j8hB7RK4VAYYm8gfT5aRmbBMDJ4SAvE2rtOHv
         tiLqoJp1qWJq3sJ56IBcnfqfdpF+K0+AWL/FKvDVnpNbqfYF2V3loFMWD19i0O/+a37w
         Z6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766064541; x=1766669341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4d8nE/j4LG4aJ1litu/i0JqfT3L0+tYvMgLM3qO1rYg=;
        b=Z5LztGtTRkszZLbWiZhHSaDd4NGdEtuVlwdHjteY+FUKKtcXraoVAIR6PW/3cijfr9
         N96B6Mjc/iRFLig+09CU5VGMY5ZoPxTiEm6fGTd4C1EFneR8XD6N/Mse475UWn99bxhP
         4XHYtvFeswGY6KtR5YojddzX9hKkuYdBhj1Eq1wP9un2PKhmLfgZwUt159H8Lt09q+fH
         lBPFs/JLkLAaqvoICchH/1tf/JbblvN0NiUDl6q7dDOexQ1immWICfPSG7AgcQ3LHjlu
         YNtdNzUVCaMkZil8esmDf1UrxuzkaQ6nntYBvPTxLg3JK8/wOdWzo4IpLNqmDT8y0ysY
         Vkbw==
X-Forwarded-Encrypted: i=1; AJvYcCW/tGhb4XuzRV3E1O6kDRnq3w0w9XqB9R+/t/lZ1gfr5PuvuOc5GoWZnrFo6S1Z/oWALjr7fRnpycA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/H6QzP+Ay9Tjn7ywnYfqI1ZWsjZEz0+jg6pJqLWh/cM9dvLW
	k/6DH4NBJTjSXV7i7HpeXBGjnF453AsDaZaZMo4KSwtbbbsF5mW3UGrFagExPIxz5DXmLxxAYEf
	E5YY6p1/++b0qmm8OJjLf9AFu6xTVkJ2378Wvee9EYwtufGQ7p9lioM6kaqyTFYg=
X-Gm-Gg: AY/fxX5BaUWZ4YrYKVn4VD+iPjO3s3FCLsNmDlVnveMwnCX2fBBg5b70a3txruHN4Yy
	fDhnWRmR1amKgcBKDQRkJp+9Bgw7Tzm2OKOM6fzlMXDG8F2yahuPy13E30d7cAFdJT9pJ0qEQSL
	ByF84vm/zq/1JnDPDCVj7IuSKYFMtH0QUXecw0v0IjD1VCDRnOWS6dJ3sri0tSZICrspu7AYnvF
	GuZFl71PvYUu+YdZWKzbaL1VUvbelQ3J6PXf9plFhBhVEa2iuGIJuazwNoozHHnfZI5VjpP53kH
	CjXFCtN5VdABHlKWEQJAZzaax/2PIsCb1si5tpODNhINCE9BU6JbpFK1LEPAQ7RQ8I8UsPfWggM
	uVGj+pjXcK/UZOJOSMRpXdPpdgYcuXxgzqz3irBfwdQ==
X-Received: by 2002:a17:903:3bcf:b0:2a0:ad09:750b with SMTP id d9443c01a7336-2a0ad097797mr111644805ad.9.1766064540594;
        Thu, 18 Dec 2025 05:29:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG77qDSkD3kryCSvCIG59mV8qh7r2baMVQ19jpUBB75/MHMpbN0RDu4znUHAN1JCuGy853T5w==
X-Received: by 2002:a17:903:3bcf:b0:2a0:ad09:750b with SMTP id d9443c01a7336-2a0ad097797mr111644495ad.9.1766064540046;
        Thu, 18 Dec 2025 05:29:00 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d161278dsm25817335ad.48.2025.12.18.05.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 05:28:59 -0800 (PST)
Message-ID: <7a72f708-3f1a-421d-9299-e4ebb112f1ea@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 18:58:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: dwc: Do not return failure if link is in
 Detect.Quiet/Active states
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
 <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
 <237606b2-783a-4e11-854b-fed787e2903d@oss.qualcomm.com>
 <isbb3bng27ibc3xddvjvlgbtz7skbbpd4q3a6rdqul7ghmmsyy@ze72f2hs4kb3>
 <c4aedf62-633d-4871-9dfa-af021e9a8e42@oss.qualcomm.com>
 <bawi2oioatfrmxuwd26xlvytmtuo2mhf3yunbwrzam22y57wvm@3l4hdbzjjske>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <bawi2oioatfrmxuwd26xlvytmtuo2mhf3yunbwrzam22y57wvm@3l4hdbzjjske>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1Bn4zeqSsFFSHCkFiNkRFs2iNqfP35SZ
X-Authority-Analysis: v=2.4 cv=V51wEOni c=1 sm=1 tr=0 ts=6944019d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=x01hJFTKM_06UH880ogA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDExMCBTYWx0ZWRfX/1hOeVDLKfFP
 0LL8KvitcHTCMxGYPuGXmnmJRiKd9Q10gsj9Hqy5zrflGEIoVCXWwsxnYiJQtUCvgIIx9epJD2H
 /nSL0d4tgk9Td4fg4iW70eT0zUn7bdoU/LKQS5c5zTtcoSiHO9vp6KwN9KR+Fgeu+gbefRZ94nf
 bKfBZCsIXxzvjMhvuHqojkymQZ5VQ/6YQZWhsnaXWsqeFQ23j2HRzWy4nG9roMmPJXwTv9jqFzR
 Cv6cL+chLF2YOQSMiyGEdIVmaXneb+WGB5ot8kcX1Xis6MYkx13gX8UifQAF5bIDy8ywS3HGiww
 JClYJhpl4xl7L4M/4Y0M2w0AYl1jjZjz9p5H6slHV11tQeXQtguyeHxCPMalbhAzT8Fttnsphzz
 c/spLPSXQzD8IBneAgzMQE20eQK0Nw==
X-Proofpoint-GUID: 1Bn4zeqSsFFSHCkFiNkRFs2iNqfP35SZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180110



On 12/18/2025 6:30 PM, Manivannan Sadhasivam wrote:
> On Thu, Dec 18, 2025 at 06:26:12PM +0530, Krishna Chaitanya Chundru wrote:
>>
>> On 12/18/2025 6:16 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Dec 18, 2025 at 05:57:30PM +0530, Krishna Chaitanya Chundru wrote:
>>>> On 12/18/2025 5:34 PM, Manivannan Sadhasivam via B4 Relay wrote:
>>>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>>>
>>>>> dw_pcie_wait_for_link() API waits for the link to be up and returns failure
>>>>> if the link is not up within the 1 second interval. But if there was no
>>>>> device connected to the bus, then the link up failure would be expected.
>>>>> In that case, the callers might want to skip the failure in a hope that the
>>>>> link will be up later when a device gets connected.
>>>>>
>>>>> One of the callers, dw_pcie_host_init() is currently skipping the failure
>>>>> irrespective of the link state, in an assumption that the link may come up
>>>>> later. But this assumption is wrong, since LTSSM states other than
>>>>> Detect.Quiet and Detect.Active during link training phase are considered to
>>>>> be fatal and the link needs to be retrained.
>>>>>
>>>>> So to avoid callers making wrong assumptions, skip returning failure from
>>>>> dw_pcie_wait_for_link() only if the link is in Detect.Quiet or
>>>>> Detect.Active states after timeout and also check the return value of the
>>>>> API in dw_pcie_host_init().
>>>>>
>>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>>> ---
>>>>>     drivers/pci/controller/dwc/pcie-designware-host.c |  8 +++++---
>>>>>     drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
>>>>>     2 files changed, 16 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> index 43d091128ef7..ef6d9ae6eddb 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> @@ -670,9 +670,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>>>     	 * If there is no Link Up IRQ, we should not bypass the delay
>>>>>     	 * because that would require users to manually rescan for devices.
>>>>>     	 */
>>>>> -	if (!pp->use_linkup_irq)
>>>>> -		/* Ignore errors, the link may come up later */
>>>>> -		dw_pcie_wait_for_link(pci);
>>>>> +	if (!pp->use_linkup_irq) {
>>>>> +		ret = dw_pcie_wait_for_link(pci);
>>>>> +		if (ret)
>>>>> +			goto err_stop_link;
>>>>> +	}
>>>>>     	ret = pci_host_probe(bridge);
>>>>>     	if (ret)
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>>>> index 75fc8b767fcc..b58baf26ce58 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>>> @@ -641,7 +641,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>>>>>     int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>>>>     {
>>>>> -	u32 offset, val;
>>>>> +	u32 offset, val, ltssm;
>>>>>     	int retries;
>>>>>     	/* Check if the link is up or not */
>>>>> @@ -653,6 +653,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>>>>     	}
>>>>>     	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
>>>>> +		/*
>>>>> +		 * If the link is in Detect.Quiet or Detect.Active state, it
>>>>> +		 * indicates that no device is detected. So return success to
>>>>> +		 * allow the device to show up later.
>>>>> +		 */
>>>>> +		ltssm = dw_pcie_get_ltssm(pci);
>>>>> +		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
>>>>> +		    ltssm == DW_PCIE_LTSSM_DETECT_ACT)
>>>>> +			return 0;
>>>>> +
>>>>>     		dev_info(pci->dev, "Phy link never came up\n");
>>>> Can you move this print above, as this print is useful for the user to know
>>>> that, link is not up yet.
>>>>
>>> If the device is not connected to the bus, what information does this log
>>> provide to the user?
>> Not every user is aware that device is not connected, at-least this log will
>> give info
>> that there is no device connected.
>>
> Users won't grep the dmesg log to check whether the device is connected to the
> bus or not. They will use lspci.
ack.

- Krishna Chaitanya.
> - Mani
>


