Return-Path: <linux-pci+bounces-40496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B6EC3AB38
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 12:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E693A83F6
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF630F95E;
	Thu,  6 Nov 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O71WoNgu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BRelBRQ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BBD30F811
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429330; cv=none; b=tiUXE9+0Y0x9NYsRCLhbYsDC4i/qjU3WFWjT4+5j12Kc0w1E4ClRdk1glM3to2iYYuUCyQrcNKb9WIvPY2K3f9Iysn1HzYZR6ZnYPFufX/zusCyhuBzGHo/QKhAx8M/+hQWEinvdvtGIEIj637cYUfGVLwHqf5DMy7OZAg8s0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429330; c=relaxed/simple;
	bh=sQLg/ltUathCjSADzC6pfsCa5ibsNIbv+YZgTavNDqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DR3FDn90ktmOubKLy7cuUNLUUcKi52+TfhluzsMHmmXqTLeZjVJ9cKhSXDr5bAprDY55RmRwgUemoaeFJrnCXW5ybpjYPzK4h5xoECfiMJqrQKGpMGAvSitbzhROBfS7WReNUIfNxTPjrzPECG2+tur/2fHAuyY1oRGNfkL5TAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O71WoNgu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BRelBRQ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66rBYk3361959
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 11:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XyNQCdDuYt8FJ59B50KoPOS+Dq0RnIAj1w8pRuHSc1A=; b=O71WoNgualVbB4gO
	gGKayh8cjXI3XqcJwjUE49yMHZVVhTFb0LumjebySrTqklpZdYeF9dO9kbstU5Ey
	HNSopO0bCzMLyJTFs+RI4p3QKQ2d1mUxd5HYn8ALccQsYmJL3YZD0W4ZbVXfsnBD
	TPuBZwIGW7P2vXXY8iEUIvEcsVsmrHrAs4QrrAH2mT6fX0odpVtgwfjhGzQuWtqH
	S5J5Vb056WkxMeGNcw9cenhHIGg3OPo2eMeJXh9wPqszdRAGu0HIIWYTbRAT77g+
	XAUMkqYyfa71bNdYRKKrtojAPFqe6lcNQNPseKyxQupVJhfQg3bqPW5ZPJL2bhFw
	FKeaEw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pt58shd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 11:42:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297b355d33eso2725115ad.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 03:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762429327; x=1763034127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyNQCdDuYt8FJ59B50KoPOS+Dq0RnIAj1w8pRuHSc1A=;
        b=BRelBRQ9CWj8Nvo/gTXm61yRtzFe3Qc0wQGMEE/PSOUZOnRgDuM6lhmiT/eanduW/k
         IxU9ftcIJTIhpFXOnBXuLS20iWWkAvEdxzy/3JvyOIti1XdO86FJmLtZNpQH5IzRpejg
         KJafqeol+jKIBovhKCDNE5bnjrIy8ItPlbqU8Z3MSN9Etssu+zff2tSvIIu9qEVaEuar
         3UhwIMLmmprYtqYYcxtYjQShzQZ49TOu630EjYFqiTMNBG6am9ZpXsre3nnX121+0lI5
         SaU7n75W2nj5dF0IyIZKqXBHqbTq0RsPfb6YYdErGaY0RCUQoN3l/yo3W+UXBuCOCQ8d
         f2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429327; x=1763034127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyNQCdDuYt8FJ59B50KoPOS+Dq0RnIAj1w8pRuHSc1A=;
        b=pNj3GldacigrrDJ2OzF85PEnwPSg0LyyhfkX3cxeyaAi69Ki7eYunECjapGf4JmZX5
         7DPmxMJzFPejK1zTko/nrWasM1jXaXTSKZwFQSBVyxPC7drNzjilneAh8vCulhAzqHkO
         9vZ98flHvbjB5s6Nil/o5x/EvJ6sdwGPW+uBq3O6L4JUzpkaLq5pj3VifT4hHMWnawbw
         +5iNCvmcnB2e4y0tSZ/z0k8TCgZBEXuV0UXIRzMHZAc+OmhEwZLAECpC1kEsmYcD9joo
         ot6xuO3xLmB8uBRWCpoXbyO7xQ55dF67QMym+rsgLys/AwbffeuunAmKI7SV7p2fSnbH
         sZTg==
X-Forwarded-Encrypted: i=1; AJvYcCV3C3UUOZptg972CkDqwQINlIoYjQX3JcBzVeunJVeocrm7ztHvca3GfHVTVfG+geK6jP++ehukVH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlh6zr9aa4eD6WNPQ+xtKUZn8A/QKh3hX/k4HVWWRJxkkK58li
	o4uIubA3GBvY6b7qSw4tk8Q0vradHhGpH8F8VEvhxzXY9Hvv+cPaWsk9MOFKcgC2V+R6Rw1i1Zr
	skVoEPpZKKkUOxRMKz9XgSZvOBD51hyPukIkzwXAkWY5yHPK5tybiec6Xu2/OxUM=
X-Gm-Gg: ASbGnct3TKRfBUvfAHPizUF7Fl1WGG4r+FNaNJSThe9bhnyy27JuPbJdA70AYxQHTDb
	mTPUHARjITOxonxxKrF+uzDxUB7bGL+FdJ9mXKMK+7KZjLVUijDDqx4wj3dprJtgM2HhJNNEnd9
	tMTwO79dAXNpzoXrKFDEoV7frV7DhkHeLDV4DRhhT1/8m665ShSJ2rr2Dj/6Noc9P2NFkBSQx3Y
	kIKboTSNyKR47SZuZ0gtbZyhVZYhFB24f9V7NSK1FmKxmpv7nIugqmTm6tdK8CW2Iu0AvKS6xIP
	9rN4YdNL3AcJ4f9uvp+Z93wwowAF5IQ9yIeFg0lwNMrIsKivQdBwW6Z5fsoYVFZI1LupfoHMP5u
	4/op0dd2CISitoFN9gJOs02HLmlXSCKY=
X-Received: by 2002:a17:902:d48e:b0:24b:25f:5f81 with SMTP id d9443c01a7336-2962ad16addmr101807175ad.17.1762429327231;
        Thu, 06 Nov 2025 03:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA9TIB8orqE5oPIwoVJXvrc38Pb3yNWldPGYOvWIlv3ebdEia7DEdvxcYxMUiRoVSNBpxMMw==
X-Received: by 2002:a17:902:d48e:b0:24b:25f:5f81 with SMTP id d9443c01a7336-2962ad16addmr101806835ad.17.1762429326694;
        Thu, 06 Nov 2025 03:42:06 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm26117435ad.44.2025.11.06.03.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:42:06 -0800 (PST)
Message-ID: <d739102c-d7b1-4c5c-9246-200e17cf1ef1@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 17:12:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20251104175657.GA1861670@bhelgaas>
 <e459b4de-52f1-4c20-be84-07efdc9fed93@oss.qualcomm.com>
 <tecoemfjvcuwrvhiqxla2e7b27tgsmkahrbe2msr6vlh65alvp@vhlklrfasjd5>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <tecoemfjvcuwrvhiqxla2e7b27tgsmkahrbe2msr6vlh65alvp@vhlklrfasjd5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OIie2vLISdfedkalYsYNV-x_bBi8Zk5V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5MiBTYWx0ZWRfX1U2sVeI0dkb2
 ofMTMxioLJPBAxTCy8litSmPBs9ZMPKM58PDnletrkF8z54QykHRcLF8arHYgcKwhEDuR8lUhp6
 wnaze9SmTmtgioGEzrY+tX4Ocuv6X/eTpia2mfK33T0xb49WA9CRL6j5KKOfBHPA19e20VqIjWD
 WJYCw4/fPpIGde9s28KHI0u+zqeETpbgC2V9aStw71qpQ8PgMnFr7EwqEC+9yDYultXAUbEKKPn
 /uaeu911UGdU2XYMNbwmAeCiP3UMHLkgbzfX491RUWvkjuVAxPyJghGtjF4tMOZ/fQ9GQfgTWDR
 61um6yt9ACQjo7Y4v435CkC7hzV+a/vY4KbKMQqKx7Di9wtRrKOy5Q7YskNrEGWAfPDqXMTUy+D
 xic2qPFiNsozBNFx1844k4mdwHpgjg==
X-Authority-Analysis: v=2.4 cv=XNI9iAhE c=1 sm=1 tr=0 ts=690c8990 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lcPbnEz4b48S40dIIKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: OIie2vLISdfedkalYsYNV-x_bBi8Zk5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060092


On 11/6/2025 11:51 AM, Manivannan Sadhasivam wrote:
> On Thu, Nov 06, 2025 at 10:30:44AM +0530, Krishna Chaitanya Chundru wrote:
>> On 11/4/2025 11:26 PM, Bjorn Helgaas wrote:
>>> On Tue, Nov 04, 2025 at 05:42:45PM +0530, Krishna Chaitanya Chundru wrote:
>>>> The T_POWER_ON indicates the time (in μs) that a Port requires the port
>>>> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
>>>> asserted before actively driving the interface. This value is used by
>>>> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
>>>>
>>>> Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
>>>> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
>>>> This can result in improper L1.2 exit behavior and can trigger AER's.
>>>>
>>>> To address this, program the T_POWER_ON value to 80us (scale = 1,
>>>> value = 8) in the PCI_L1SS_CAP register during host initialization. This
>>>> ensures that ASPM can take the root port's T_POWER_ON value into account
>>>> while calculating the LTR_L1.2_THRESHOLD value.
>>> I think the question is whether the value depends on the circuit
>>> design of a particular platform (and should therefore come from DT),
>>> or whether it depends solely on the qcom device.
>> Yes it depends on design.
>>> PCIe r7.0, sec 5.5.4, says:
>>>
>>>     The T_POWER_ON and Common_Mode_Restore_Time fields must be
>>>     programmed to the appropriate values based on the components and AC
>>>     coupling capacitors used in the connection linking the two
>>>     components. The determination of these values is design
>>>     implementation specific.
>>>
>>> That suggests to me that maybe there should be devicetree properties
>>> related to these.  Obviously these would not be qcom-specific since
>>> this is standard PCIe stuff.
>> Yes Bjorn these are PCIe stuff only, I can go to Device tree route if we
>> have different values for each target, as of now we are using this same
>> value in all targets as recommended by our HW team. If there is at least one
>> more target or one more vendor who needs to program this we can take
>> devicetree property route.
>>
>> I am ok to go with devicetree way also if you insists. - Krishna Chaitanya.
>>
> Since this is a PCI generic value, using devicetree property makes sense to me.
Raised devicetree change here [PATCH] schemas: pci: Document PCIe T_POWER_ON

<https://lore.kernel.org/all/20251106113951.844312-1-krishna.chundru@oss.qualcomm.com/>- 
Krishna Chaitanya.
> - Mani
>

