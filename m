Return-Path: <linux-pci+bounces-32213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA24B06CD8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 06:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2D6503639
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 04:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F8FBF6;
	Wed, 16 Jul 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7IO801v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF11C84DF
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641676; cv=none; b=O8OJLXJKCqYMYUwjThQ279jDn04Wt+s/FoPXDT9jywhICVKYw4wGF1czYaHqI5LtUgksPbtRjVe3uvO5wU2PXz/QMTK1CfYtcfKiV1tci+QuWDCEpQtQ0hwVJOMuHTnEqhFR6EY+b3MrRPVpnVsB4XkhLpeMJHd0/K8YIbRuyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641676; c=relaxed/simple;
	bh=JcgawIRkiXGDkejFfyGdNqbuJduoSCYxQVrXLGYc07A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXbJpfaTcX/keSxe8CmQVZuHx3J9d/VdUUEpXJyfPRxXsuuNrAV/ErFjRJFDapk4/iJnLgyKkpdxDvQb1DLrU/ehQnLCw23CR+nc9Id4VHNPL0U9p/NfbnS2FcXyMGXwbhx+I+R/TSZcOBOzMGgHKGROTO2z6+Tv9kBEizuO2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7IO801v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDGZL017998
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 04:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HAPA/34RtxDjvhrdalVzCKzkycZXICqD7bav8h/cZ5Y=; b=A7IO801vj/WHxsyc
	lis9RxTSJKlG3BasMsC9MlRC7tl2x8Kgo0m7Az4WXe7DxeAwEiqsfT+//08TOKgo
	UPD3eAPbBDIKPNeGv2LRp+Fsmvk+Epeq8Xg/G3CvLrJtxpow6Wf0mr+kCpTpPqdt
	JDlTOql3RxaQV3CrDkQPWj302b7asJToVBhSsYgqchozVc9BD1IKNvWZOiX/Z53X
	YI0FsWij10XmjqcEU4ZZRNgh40Nmi04R6t9VxCl4B2VSApmB6hP5mo/T06fKRjve
	PKdSWOWj5R7x4AhZdc5648SvEtXkyL+9PCSxKKp4ZoxQgkG0TWaDAAxNW2b7M8vH
	5lZ6XA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug382nav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 04:54:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23507382e64so62861395ad.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 21:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752641671; x=1753246471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAPA/34RtxDjvhrdalVzCKzkycZXICqD7bav8h/cZ5Y=;
        b=Jcb6UrlLikycUVqsXjVnJZoUilQhEnWJ5aVYPv3ukGH0uy+kqwBF/Yqc/YZ5u0aaWo
         oE/GJUlehno5Uj2IiKdidRCIWTnpHth1rnY8YlD8oVp0xb2o+ajc8Oxxw1QRsdvSnDff
         UkSLEomGuo3/1dVGsudPEHMb+oLKhbVm8ZVlFxAUtw20BSvhedGX3mKvEhMMyqAG0mSw
         Q2qTq5TBrrLGfUzjCbRF95E9u0rm0ffuxpXfexIRTMTlXSn6l3yoOsvfFqXMIEY50KwL
         0BRKZvx8LswUP0SkWFOwB491VbE+y8jFo7LsTSqQpp4u8v6d/TZQvVQLegHma083D0JA
         QPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZGPfhTiW4gUXhI25A41OyFyKEyDdwuF9XTmBr9HsDH/wgVLRR86qpkEOcHcH4aZBkUG2z4wLCPwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBY87tPt3XITf+8jVHa3E2YzF8raIY3P+StuNgc3AAMs1WrYAQ
	L3wtWvjE5txzE6jhYOkNYN7t3ueaANAO0fiwwpUJGcxGz9ISGDVJ99dBqNUvoYenrDGpUK52N2d
	1bv0TMgGwWtdtnETDs7PPWw8DyBxz+7obtUh7hush0ttgQwHK9/n9I4xwglh3j1c=
X-Gm-Gg: ASbGnctla2tAxKm/bfUoY0oHPR7/LMLntWY57M7cywiV44f7AkpiP7dpJWYT8D1Rzrd
	/VoOC89cYDZiM2hcLPh6y5my40tQyIrmNSxP+itgXxcG0bNYaFGLSj3O4ivs68UcUUpO5cdp47M
	kx4ZEvUX2gPQVfiJsJCr/pCMC6+y9dQbKEJjLuc2bdwc/Vrrjo0JQK3YoX7eXGhqZN6ZOUZy5uc
	mGlLDNTpwdI8kdGws7MLnlYPCUF0pKlMAXX77Kycq3HudzDkap5ADI+R+O0iA2ttrrGDkIpG8ji
	XsC8lD23XhqsOh95IOTFwDMIKFkVhSC9Qg1YqOeURzZd92/89my7K5ebP/UgqHk1sHIW8w==
X-Received: by 2002:a17:902:f545:b0:234:ba37:879e with SMTP id d9443c01a7336-23e2574547dmr20717635ad.38.1752641670798;
        Tue, 15 Jul 2025 21:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3o8ZyYwDjR7aKMNEc/ivaUPzgonLNBGd7pGRCieP1Gp9KfqY+Mxb+hO4nDvgLn070PhIIpQ==
X-Received: by 2002:a17:902:f545:b0:234:ba37:879e with SMTP id d9443c01a7336-23e2574547dmr20717285ad.38.1752641670325;
        Tue, 15 Jul 2025 21:54:30 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435bbc1sm117686505ad.228.2025.07.15.21.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 21:54:29 -0700 (PDT)
Message-ID: <eccae2e8-f158-4501-be21-e4188e6cbd84@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 10:24:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
To: Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA0MSBTYWx0ZWRfX5MorZJwtTYGP
 4okqlmSvBODFcoxOnuaoa/4NgjvT+CT6qt9a8N0O3TKpt9S7rhtIp1Vv3zzR/DK7sjeO8GBydUT
 FWNKCBaAuiNE/Z9lkvGs33bvv+BuDKKuXUJ6uPXhC86KxiArXZ7pQgaGKkHCPWKbvJEZJinA8h3
 /+alJ5AZwsKlD5Ur2oahM/OoBTRepxo+tfp6MehEi41TNBawKUelkbXFg6Lfm8XZhpZzmkZ5/CT
 AicOD/+lpwEzeK0x0st1zvUehiEBGIaOyUckXx0ooabOgd+9akF6QMDN8aXXk1ACi6utBuyknne
 PGXuNMM3ER6943a+zWPyfFUKklh4rBiP6ebmKJoqMjwCxy9irGjFQwS39VX+tVAvj1PFlRCAi1W
 l7/ZzKpLQ037PbyOY2XvmALLDE37A9ZH6u2jYUq7gVrTHyEWondObfPiFGFi6v4eCOz2yA5G
X-Proofpoint-GUID: KWoSCFtltD2j7aYBLyxzI4aDezEGvd5i
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=68773088 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=uNiOjgRUHSxkwL6ZQ2AA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: KWoSCFtltD2j7aYBLyxzI4aDezEGvd5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160041



On 7/15/2025 4:06 PM, Manivannan Sadhasivam wrote:
> On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
>> On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
>>> It allows us to group all the settings that need to be done when a PCI
>>> device is attached to the bus in a single place.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index b4993642ed90915299e825e47d282b8175a78346..b364977d78a2c659f65f0f12ce4274601d20eaa6 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -1616,8 +1616,6 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>>>   		pci_lock_rescan_remove();
>>>   		pci_rescan_bus(pp->bridge->bus);
>>>   		pci_unlock_rescan_remove();
>>> -
>>> -		qcom_pcie_icc_opp_update(pcie);
>>>   	} else {
>>>   		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>>>   			      status);
>>> @@ -1765,6 +1763,7 @@ static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
>>>   	switch (action) {
>>>   	case BUS_NOTIFY_BIND_DRIVER:
>>>   		qcom_pcie_enable_aspm(pdev);
>>> +		qcom_pcie_icc_opp_update(pcie);
>>
>> So I assume that we're not exactly going to do much with the device if
>> there isn't a driver for it, but I have concerns that since the link
>> would already be established(?), the icc vote may be too low, especially
>> if the user uses something funky like UIO
>>
> 
> Hmm, that's a good point. Not enabling ASPM wouldn't have much consequence, but
> not updating OPP would be.
> 
> Let me think of other ways to call these two APIs during the device addition. If
> there are no sane ways, I'll drop *this* patch.
> 
How about using enable_device in host bridge, without pci_enable_device
call the endpoints can't start the transfers. May be we can use that.

- Krishna Chaitanya.
> - Mani
> 

