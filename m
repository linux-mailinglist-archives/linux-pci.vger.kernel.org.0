Return-Path: <linux-pci+bounces-40478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B3C39E3D
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 10:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2C188EB47
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44A22D7B1;
	Thu,  6 Nov 2025 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hSLKx8pI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Euh5obur"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F438DE1
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422476; cv=none; b=Q6y2H9tsMWkS5Mha7yeodFQ2nsBUDnvKFJ4/MMdngpYHVQk4D0NFC3GvZ9MomFe7APxM9iP8r1g9FBTO78qHO9T20jsFtg1rpy8JuOdpL9UFOqN1PtjQcB1NPFPyfY8pjZPnwc+UQcggH+8OTJJS8wOjoG57eUabCFj1kIQ60iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422476; c=relaxed/simple;
	bh=vavezM5McYCdO0GTAExjvodbuYeC8rvFYUP3Bzrb6a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+hdrIOpC9A3j30bPSZvkjz/nqasrw1Cq1t2mnNYhyJW9dwWW8qiFw3UWCf+MIAGA0RvyXYxpGXb2f4qOoDIcyHk49WoJ8xs+e954TZDS3lJuf67cvPRksnkRmfkyjv8gLI72hmv6vNGtItBo0HFiuIWYvpZrofWBGEhZnI9BYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hSLKx8pI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Euh5obur; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66t8Kd3156156
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 09:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9IBxiMX/J2w532V+aM7PJT3Rhdmy1U28t6gabb7CXog=; b=hSLKx8pIVW45KUsN
	UE5qLb8ljopgQ97CwrnC1XRVYnlbeIqDY038Sk3CR9zQENRHt/lvWe/aDxbbGneS
	3RJk3WO1YHDNZtvBotsfSLca3QdcnMj7lNqHXqeViHhZvydRyBeHP1k5L6L9KMWm
	hAOQhhkM24EwKjEbtTR4I/Nx/1zABG+ROYSnyrQ5pnXyqYFzVJuUigL2Y5k/S6BP
	ZQNXJ5gaDs+M6dFf0aSDex6f8G+371Qvpwogtnnprvt7IsX2q2utiPV5LZGVhZSj
	V9ukR/kvm6aPBv1vY7TAkfcLu1DjBS+bePfFMy3W9zbeMCpOFXsbm4aSsuLrcuxN
	IXCxqA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pu0gfxy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 09:47:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b1be0fdfe1so3790385a.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 01:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762422474; x=1763027274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IBxiMX/J2w532V+aM7PJT3Rhdmy1U28t6gabb7CXog=;
        b=Euh5oburOgbQyEo3+sqVXqEORRndoSlqmAN6LGWQSBl1sGYMlx4wnBx0tFxz2l6vlV
         DHLF7gLt2BVJ5QZirossefsLdfaGdmaCyLcBdBdlBR5TtX9ryNXT9P0838qCyFaHcBZ0
         GKv+ZTSH47S8iQ+l6XTWrUC5p7ykvAaOxyM2B/502fTwiLq8qAyUzIKpdYghmputGnPn
         NXVasNDInm8U5ScXlpTumOWA6Tbeqory/9plMw9lzlmaMB0aVzvXcayuqS4FHfuN/jpt
         hYBOb8a8HXreZCgj4ll8Ih2G7F4fPwzFsNtgJ6cmjBcUcVBc4szZQh6Bc5jPodraOavS
         n1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422474; x=1763027274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IBxiMX/J2w532V+aM7PJT3Rhdmy1U28t6gabb7CXog=;
        b=s6H0/LgaZJ85Jzf8OElZbkrn3rkyQKhJX8Xkxoj/6NnWNllexF6VzrLK7e4+qQQMRM
         GKRozMdcWu8OacEPCuVMiy/sWhwX5iltuYa+WAJGBJ2eHr6sPBTYSktQXz6jRPn81t8z
         5fgNf+rICHJP6GNIb3iV4z6na8+HTMV2JGHfH39CAjxjgxDcMQCgV70Xapds6GxAE5RM
         g3jHO/GzFCgOFsvsUd7iNTjmqFHpm2vnUbGIdGCjAzy9DLEemcJ+6ZFMOtRw8S5XdSnF
         nQUFtxUTrqTDutMTtUYC3B4R7Q6JLubvINYoAwEJXvr+xituH0WHTGSJlqyWbBUyoKSZ
         q/Og==
X-Forwarded-Encrypted: i=1; AJvYcCVxbHKdmiBhUZs22PEK/N0pmYQCEZoYKEmo+Z+wZATRBIoLZq0oAoMX5QZvrfrRdnqIuM1k+Zohn9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iKQYJnLT2tmUm16sQ93N6vbp4sBjbL+2aglswcnqp5Px0eBx
	e1G2J7zPNyQBMxlqSHdRJiR5E2cPnOvJWz1NuYOB9WaPNp8Y9loXjgzyyr+znE37RD/aZ9HB1k6
	sbYB5P6v9vy2XorC0Zy2A3vfjI7VB0l07NwaDo06AHd6G+4Z8Bj5OdPqc42rZMj0=
X-Gm-Gg: ASbGncusRkv5SgjxD2kYOR6tT1YwWHNOXJZJPviK4rWJkfBmvfO78OS6G7PfAFkwru6
	OaPCPL+xmSqUi69vlhcQztMfcYizjgjyWIAxJcM9gtEoP7ki3OgujjWbZS0AGjJEBdS6QIBCJ8I
	1cMLACvLORKWg4WMS81eNVi70sp2SUpA0meqDUvEJqbHDZ+gAS8ZEKFAz8QmFDichf0mM7lsjrM
	/ocvIlHheiz26Bw9yZkOUboKlGpaI4bhBsUdcJH4N+4w9wXeWgUGrS1OHughx5c4X/DxGBYinf7
	c2J+UrEoXeEIiwYR2P6LACgJCOi0xv0zfkSlK9Rys9TGXaka7fnAfAKZG4wBX9ZT9sacqhDZsb0
	6mj6tIX7zod4eoKhKIJPdX+Hf1umAbb+8/11g8QTqXSbEhVbQoZsx96f6
X-Received: by 2002:a05:622a:18a6:b0:4ed:1869:6c05 with SMTP id d75a77b69052e-4ed72338594mr57540461cf.5.1762422473661;
        Thu, 06 Nov 2025 01:47:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpuKuCWzp0t7fCbW5KVhS4FD/Jdg9+sVXbJS47KWq/o+LFPWmer47f/TSodncTzWe2GNegOw==
X-Received: by 2002:a05:622a:18a6:b0:4ed:1869:6c05 with SMTP id d75a77b69052e-4ed72338594mr57540311cf.5.1762422473198;
        Thu, 06 Nov 2025 01:47:53 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6412a27d68dsm516869a12.9.2025.11.06.01.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:47:51 -0800 (PST)
Message-ID: <4aface5d-66eb-41bb-b6f3-ee8ce5d5da6b@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 10:47:48 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: host-common: Add an API to check for any device
 under the Root Ports
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251106061326.8241-2-manivannan.sadhasivam@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251106061326.8241-2-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3OCBTYWx0ZWRfX7SfN7YMoMlYi
 QD42Fofq8ioBoFwstURDNPj2+1LYuRJmFrSD+ZS358bdvuaHt50A7dVK5YGCeuOIASemWy5Kx0Y
 kusTKq82BQxtafubLu8Bd/vLJ2hhvyBIv9OMZaQNxyrlaCSaw7hz+F2AdSnDz70HMNi8ORU6u9e
 avPbknCZRrM6f4goRRxZQG4h2V6p8xei16Vt/+3qTopW/4ULHtsbMznlogulKbobdearnCFRsip
 QxiMCZUO8lqyUOMpu43eZ0MjeNQMN5omGnNIKDVCQq9GH0UqXeDRYPzWdxqbIUTk3cU6T11Ak0X
 32igP/Asc2Ev70e9w5tDwjq6TOiNeHMa6IMQYju1rFjgzYkNBTZDQyoNLoDncvp7cK69Hsx+tVJ
 VzX2TNNea3xuw7RFlsBlDxtusRKhfA==
X-Authority-Analysis: v=2.4 cv=bIYb4f+Z c=1 sm=1 tr=0 ts=690c6eca cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=X544SMn2G6euAj6E:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RsEGIJiJnbDJ2EEs828A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: zrBRvzkvB1JbicRiSp6XdK_rkd5kc4eX
X-Proofpoint-GUID: zrBRvzkvB1JbicRiSp6XdK_rkd5kc4eX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060078

On 11/6/25 7:13 AM, Manivannan Sadhasivam wrote:
> Some controller drivers need to check if there is any device available
> under the Root Ports. So add an API that returns 'true' if a device is
> found under any of the Root Ports, 'false' otherwise.
> 
> Controller drivers can use this API for usecases like turning off the
> controller resources only if there are no devices under the Root Ports,
> skipping PME_Turn_Off broadcast etc...
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 21 +++++++++++++++++++++
>  drivers/pci/controller/pci-host-common.h |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index 810d1c8de24e..6b4f90903dc6 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -17,6 +17,27 @@
>  
>  #include "pci-host-common.h"
>  
> +/**
> + * pci_root_ports_have_device - Check if the Root Ports under the Root bus have
> + *				any device underneath
> + * @dev: Root bus
> + *
> + * Return: true if a device is found, false otherwise
> + */
> +bool pci_root_ports_have_device(struct pci_bus *root_bus)
> +{
> +	struct pci_bus *child;
> +
> +	/* Iterate over the Root Port busses and look for any device */
> +	list_for_each_entry(child, &root_bus->children, node) {
> +		if (list_count_nodes(&child->devices))

Is this list ever shrunk? I grepped around and couldn't find where
that happens

Konrad

