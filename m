Return-Path: <linux-pci+bounces-42225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17B7C8FEE3
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 19:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626F23AB310
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 18:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139652DA760;
	Thu, 27 Nov 2025 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BgbjNIwB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GsKuK7pG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572C2773DE
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764268812; cv=none; b=QCSRTsGMEeUvnycmSG9iKWNGRqZPiSC+D243pPOKh7LMEUqK8Jf3bGfRqTDGM7RGD63p3OkO7szBiXpt0MfyxvnbyvcBbtbo4J77RwH22FhwIqqkJY/XVt2R5Y+hq8B55uuUuQZEeOo48K9rGR1mU0ZeYtdvm7RZyscrZiKRHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764268812; c=relaxed/simple;
	bh=wyFS8spSqZWn+/cG9dlErAMQS76HMdPbjHRQHZPfCD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0jUFjIkn3w7Uwjhz3FnKUpZfGY3DTuvHdxQGzAWeWe91yCWU+uekL8ammQ6H/QRGY6VQh3e93GYiIf/WXgX+2PnmvIyFkgAsezQiHjEr8gK4cahaxX+ffFTVWr+I/YE1G8Jo3QTwjPB4E7olrzr0FbmoJe39krKlFLj55ObLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BgbjNIwB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GsKuK7pG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARGvGNb2388033
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 18:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4JE8GdFgY/lBsXFFVF1PdHAx37kWrNNokkrKmrbQUYM=; b=BgbjNIwBSXw4lqKd
	ITY8pUxXObH8grFPsJQ/dJeecRINT3oabnMqJY02HuXbaHBLjEwb+SLMBZ7VUY/A
	q+Cp+Jq+WGZDz5udmr7/eUa7f2exUsmH7PAL21weo8JMF7VAZ42OS2XRa61Xzdnu
	mA9WUFIIZQEFCfCRibJPQMLAh6seYbRzxtoAtT8YlNDHtgSfMr/+ydQp017y4CuE
	mKWmsMakXpuVqxRmiktugVA5K92k4k6fkSamBGio35e5AapwjlkWMUUjARXG98H+
	O59lH3YqIaw96nCrqrl242Xq4qsF0dmJsx+C3RoJt0AGv1gGYTbBijZXWPniscuc
	d6NZcw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap7n8k7x5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 18:40:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ede0bd2154so3149941cf.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 10:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764268809; x=1764873609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4JE8GdFgY/lBsXFFVF1PdHAx37kWrNNokkrKmrbQUYM=;
        b=GsKuK7pGRLLAQaZ/5joWkZJHAd5eAtIAMDRaYFASRxiaVMosC+nQf3qTMAVPmAsHz3
         uhBna116L/HHRCtFv+5F1S/0d3XAhCQsGQ+BqO9Hj42DzmUwr6SoRV4RiHDM1GkCwVh5
         u0ISwDYC9/GOa3OoEf8EyFTn1xOy/ubf8nsuIWVtdT1kjRsB3vNiKSPdowGlXsdz/64D
         jITY6AXv1xHQbFXb26chvXUSz8NmfqugMK/iAONO9c03tNl7bI96f4FMz1Xat0ZHWB1S
         ne2dfbIMBItLK4z826mMDout8dnR1eQnaYeduOFz/SzD1+fgClbPTthe959ppCs/q111
         GqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764268809; x=1764873609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JE8GdFgY/lBsXFFVF1PdHAx37kWrNNokkrKmrbQUYM=;
        b=q6wQTDD/v88TZ6Y7rR37w0uYOWU457SO8CzkiXARrGgu8icQ+YJNCCDFDFXL+vcHKT
         54gbtZRi12lp3+KUbPvZuTtpLwYQMtrZS/nEs1AZeRgDJiFVphUMsV9pewdrDmKFDzCD
         KezVOX0jTW19CQtQXblOvyzO+LBe7aV4+eYgwd/RiTRihHaPP7XaPfQ7L+2rhU8nEh2k
         q7DbUvUZ9jgGZsA7GMpy6bpo/Fa04U4Zo5mHYu0pwKUFAtCNRWGuRnlMssBjhooy5YWq
         LefML9sEdGt3RRD4Qjea0wDAKddjJEjxjc6gRX3bhfTBUASJmsQOE++h71oStSoGDPUe
         VfnA==
X-Forwarded-Encrypted: i=1; AJvYcCXy2YspXtHjBIb8/5n7U/nFuNxdFp0uWUZJMy8HRo9+Rud/EFRGg+JmH10/vaYXss2ghQ2enVYtpJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUMgfrBodGF5iPrhM23uJjxwxxyzO0e5i2mSo91dKovf5erhW
	274C/DfhHqZjxfmft8/B0wRNh1SGCu9CJYJO9a/Pwv6HzcGRT8T0XIhKdf1xwm/vJ5pOm/2JNl5
	MJPCeHo7PBk16fV6utKQ+jRcZ0lymhi1zJeEL7tdHoCN0oq3vCukJulAvUNvMT8Mq7cjI9lY=
X-Gm-Gg: ASbGncvyG2/HAPYLgS40Jg75I2caSP5o/RLO1hxlxZdNvA1RQ0kvNxYD8v2JrC/bj/1
	f68y0vahqyEZr604T+XwnGqJjRhN8q9W4Sol98yvKA/6qyNFbfbtSOrsYzoYrw9vw3DLGPUK1kR
	Zaxh5pQnaF+upElsXabmH7FCHtprd/0Ggrw4IQ59Shx2K2ijBwQPS4whuBFGXHBX2GPflRGrzfz
	L8HOHNTlfXjFyMHdFiPCod1JWs5Fnjf93pbnSTjDGQRZaajXxq5WCdfnuRm9fj8WcLQ1h1EMjp3
	FIEvfkhY5l3hLsFevcuJm0WTSvSWgNTC8StuEmYxGVlDPAmWhIbftGUW8oixKaMWoHcjw+QQCMX
	VBgHfqiNlUBTrJA057hNO0UDMWirOoDcDA9AtaaD5S2bjWUgURwxr0WrHFEXv5lHcOZk=
X-Received: by 2002:a05:622a:c3:b0:4ee:2580:9bc5 with SMTP id d75a77b69052e-4ee5883ae04mr263262441cf.2.1764268808747;
        Thu, 27 Nov 2025 10:40:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyUFH7H352RTWbh5g726JBPXmn/y8Uo1Oe4zNmxCviaA8u5s/V5GnQbd0HzftLjmmntQoIKg==
X-Received: by 2002:a05:622a:c3:b0:4ee:2580:9bc5 with SMTP id d75a77b69052e-4ee5883ae04mr263262121cf.2.1764268808359;
        Thu, 27 Nov 2025 10:40:08 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c8393sm234863766b.31.2025.11.27.10.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 10:40:07 -0800 (PST)
Message-ID: <a678cee9-930d-4718-8341-f9cb9b01f96d@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 19:40:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>,
        Jeffrey Lien <Jeff.Lien@sandisk.com>,
        Avinash M N <Avinash.M.N@sandisk.com>
References: <20251120161253.189580-1-mani@kernel.org>
 <20251124235307.GA2725632@bhelgaas>
 <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: X8eKYCWuy7SmybJmGHcU3ZsYH6GPfBs_
X-Authority-Analysis: v=2.4 cv=AufjHe9P c=1 sm=1 tr=0 ts=69289b09 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bKK-hE_CYPLHlUXilesA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: X8eKYCWuy7SmybJmGHcU3ZsYH6GPfBs_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDE0MCBTYWx0ZWRfX/UDd/VHCzJEK
 eycVxDhzUrKYBHLRdwcEID+26CUJwzJvCq/FrBUPlHR7d8eSpezKjHUOm4PuPKzoueD8JuYqedY
 BaPjQjR3PmYwx8Y62lTEybMu7D8hp8J7OfjO+v0KYYseOkTuC53Cqm+VIIJmIYIfXeKEFroCaxR
 RlOPX1juI2E5ED90i4AZz+sBjYv8P0FASmr5RtePGYl8aQP9DnER+UdU9kVBXFmkUcKuW4juCjR
 NXIfcszVM5WawwYhjtIaN3OwysycISSZGp4ibu5F5V2Y8rkdoGk/UFOr4VF+ztbQDFcsuKpJtA5
 d+IFhkzwv8VxPoRBSGd62KMnAckahkvLcnB9voquMoBoD+7lyrro1TtAX7o4VgE9dxY9//YteJ3
 2xI9ovrMIlzZPdlDOSNeQrFRJIyUHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270140

On 11/25/25 6:21 AM, Manivannan Sadhasivam wrote:
> On Mon, Nov 24, 2025 at 05:53:07PM -0600, Bjorn Helgaas wrote:
>> [+cc Alexey, Jeffrey, Avinash]
>>
>> On Thu, Nov 20, 2025 at 09:42:53PM +0530, Manivannan Sadhasivam wrote:
>>> The Sandisk SN740 NVMe SSDs cause below AER errors on the upstream Root
>>> Port of PCIe controller in Microsoft Surface Laptop 7, when ASPM L1 is
>>> enabled:
>>>
>>>   pcieport 0006:00:00.0: AER: Correctable error message received from 0006:01:00.0
>>>   nvme 0006:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>>>   nvme 0006:01:00.0:   device [15b7:5015] error status/mask=00000001/0000e000
>>>   nvme 0006:01:00.0:    [ 0] RxErr
>>
>> Do we have any information about whether this error happens with the
>> SN740 on platforms other than the Surface Laptop 7?  Or whether it
>> happens on the Surface with other endpoints?

[...]

> -/*
> - * Sandisk SN740 NVMe SSDs cause AER timeout errors on the upstream PCIe Root
> - * Port when ASPM L1 is enabled.
> - */
>  DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5015, quirk_disable_aspm_l1);
>  
>  /*
> 
> This check is similar to the DMI checks we have currently non-DT platforms.
> Infact, we have also use the DMI checks on this laptop as it comes with SMBIOS.
> 
> Note: I'm not sure if Konrad's lapto is based on "microsoft,romulus13" or
> "microsoft,romulus15".

15, but they're otherwise identical hardware. Please quirk off both if you
go this route.

Konrad

