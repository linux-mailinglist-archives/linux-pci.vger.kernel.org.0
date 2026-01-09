Return-Path: <linux-pci+bounces-44355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C2D08D88
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 12:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30EE03012DE1
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 11:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0D33C188;
	Fri,  9 Jan 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARHEqsJB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PI0UByHo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118333AD92
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957252; cv=none; b=UkaLi2XUBod9obc2kpDOhYrlUyYpibTqlZBD06Tw+Bins33K/gJfmLl1v8jGlYCF6n6ufjjxc5vXoavtJ/PEPh+rA6MqWE4hNFxLbRC3mTB09Bn7jjEsuM1fA1V+566oX4GLdmzot4yqk1Kj2nCOxeDHcC11vsWya5qznoAiCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957252; c=relaxed/simple;
	bh=hVtNJAfAuRuf73LQMtg59ts4s2e//TKY93Vcy8rZE+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCRBaTdbyBQqumjEqS9nOiTCg4QhHdhV4J4gaT8p1EizyILnsEro3tzwfB1NhWWtUQBTa9TOERf+iDn79HTtMDsh2+T5/fbaD7d0fqZnIfu31FAXmtB/xxIyQKRYT2S1Rlb+BVuNUQpdkpEMTG9bIc5z9dbJXavRqe4q3usu5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARHEqsJB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PI0UByHo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098VF3j3728380
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 11:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbGsyEjb9GLUxR/KE7Zt2yh4eaMOiAA5kJ01ApCC77w=; b=ARHEqsJBnJaq2osq
	Z87MjGzAlY18jovCmDfmtA3z3cSuu0Fr70TN1CKh6m9jWM9CFxn7mw4SDL9Hlg0a
	l3EvtqvtYViUB3lbOl/u6ZuLoSWg36RUH64qc2CB+HF31wGLPXZSFvluq/9g4Ggm
	ZSqcFrGopLuge3wVPZuRpDnjytjfv5sTUGyL41Y87noMqVEg0PKxcHvGcIUosZ3/
	6ypZRzdYCxV6kFo9BAHZUmsjo0Ad1O3nhNVnUgYjgW/UmdkOrkDA1CnkOClUREG2
	8TJtnDPLGXUrs1g2aKe7gdAKbJxlFh9HAxA3sS27pdu7x0KlZdyTYTmi3IMP/VRr
	xSW5Rg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjpmkhsxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 11:14:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee409f1880so9855321cf.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 03:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767957249; x=1768562049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbGsyEjb9GLUxR/KE7Zt2yh4eaMOiAA5kJ01ApCC77w=;
        b=PI0UByHo6Nocb032JL8/w0cPhZ3M06cMrc8lFRAMdElQQ6SJYGREUNg4arRipJWqis
         YiisqVI2N5ziA6ooXscRZlXS2N/5mTWHFkFUgYe96b7ahwNKfJORgrBzMWOdvTQG+Z2v
         M7G8jCfaQeMgZaRdaaBqh8qd4PzPCSykp/gsETuGzeENzuI9VIKilMMnTIft9zIHXuGJ
         4K83Eyxr/zsR/vXascN5zp4gibVOVNOampY7akoDu2fav4iUSLI+MXZufO+aztt6P+ry
         8EZJi9g510T2LhkDe7lmvBk8MNsVX6SPBX2Cpd1WTFJjNW1pN0g+/13LNtEeZ61EdhLW
         T3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767957249; x=1768562049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbGsyEjb9GLUxR/KE7Zt2yh4eaMOiAA5kJ01ApCC77w=;
        b=n/xqAjACT+xB84YXiZfANEe7Lt4wWfRrcGwbWPq2vsKJjCxxUbW7Ew5xfSqn4TDAeM
         bzZWs0/h6HqHxo/KnhKkNAY/ReeMN1Ss/5F4HhkDxjvkdQjq9qFUeww8WoQT1kd4Q3v6
         MmycAo+15VgeoMp5aojSQT8Am5fzQPXvs+0tG1xgrhzVeSnfkWnKwtpLYmzkaOENeh/o
         wyRurmt1Ww/1ziNNd+hxxHr+l3crWFLxGcrMAYePdA9p7byyZjNbXphM2OcSo6Re7t7H
         wQApjHzkSvvkbcETy8yneYMPNcRlIxJyVCtNAzAIHquKrL/BytzIQTdW0dEmifu2Ap/J
         vkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpKQ75/LbAbQn7sa7cH/tWxjYgd6xabv2L0F1GpVEL9JDhmsUa80glH/txzXLH36W+s86pu7g5Dr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzrsTI/RImNUgn2dJ5+bg+fzaHkYp2IILEPD9LjlfXJM09RkFK
	Ewb94YvZwm3D63H5FWHnvR57LqPV5um2GUcgtDXjtuXQ2XzrgQV4MD5/VWk+DAKT1fKp9D74BEG
	FKyBrxyjXxCn3erltkbff1oq1s5uZ9vrPEKsuUVW7g5lIYtjAoTGQtvwVOgXl6wo=
X-Gm-Gg: AY/fxX5gAhF8YHBzrb6cyoTt9/WNtUmvDFSI7t+tTFUmLYRB/XVN1TwUPNC9gkvP39q
	6RDYUKsNtjCKcRXzOINbhf3XRKo3jxgr9ViZpOrg6pop8AKjvhrKigF0GbE/boLG8oEW+T0XuJm
	XVveYjcmLs/iF9PTXssj/sFukOYd2uXSbRMqmgpc/hThUjOq5zhRYjK6RjHmx75p0iEzZN8DjN6
	gxj3rPahyEPhfUaLHszReqDcyxi1cAh7mD0oZCu1VuZvDVfZuz5cZb1WldCAEat8pfhv3ZoaDfG
	fWlEsC+mbvC5T1T6Jw5VH+MNS2bhyuV/jsgWpOfcnMdsDTL1yVM7c6qsl/ggPCt3LQXjLZb124l
	C/LzfdjPnFvnYEb34K/jO4woUiQ4zD8CiBwltDwoA6jDPtzGAVSVJ1MMXUu1UtujCXCs=
X-Received: by 2002:a05:622a:51:b0:4ee:2339:a056 with SMTP id d75a77b69052e-4ffb487fcb1mr106443541cf.2.1767957249094;
        Fri, 09 Jan 2026 03:14:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdvN0j1mfTjJ9QiVsMbOTGrNWeD/W2yvwWHCpWlcYUo0gPkpqG1W9F+oG5sS4PJEpVUDXSWw==
X-Received: by 2002:a05:622a:51:b0:4ee:2339:a056 with SMTP id d75a77b69052e-4ffb487fcb1mr106443331cf.2.1767957248609;
        Fri, 09 Jan 2026 03:14:08 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfd97sm1044008866b.36.2026.01.09.03.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:14:07 -0800 (PST)
Message-ID: <be6aecbc-3ea4-4282-b777-0dc8ae1b8c26@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 12:14:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] PCI: qcom: Keep PERST# GPIO state as-is during probe
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-3-7e6782230f4b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260109-link_retain-v1-3-7e6782230f4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YNiSCBGx c=1 sm=1 tr=0 ts=6960e302 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=M-jGJTmE-ygQmRKCDXMA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: VYUuvE-NbNJ3x7PQUcb9dm1-rVNVkSYF
X-Proofpoint-ORIG-GUID: VYUuvE-NbNJ3x7PQUcb9dm1-rVNVkSYF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA4MSBTYWx0ZWRfX9b7e0BUhDtpi
 k6qiGiodos+jg2Bl6dv3QRoN4a6dpkDT/DNVLESq5cbMvxNYgZe0AQTUkcbB3QuqCqmSoq/wZtW
 bmJzNGaTMaVGqT5ss77JfPPH6UUPDvFp+CXsQ0tr8gcqa5mn1VGSxCK68hni1CFhT5eg7olYp6b
 qldpkFD+39YWmEVWSN5vTrn9jlp3xUB5ttPxqeE1HZZOHAMz+aCn3wirb8RjT6nrOfWZILrSGZe
 mrELJxPLV9tYH73dyylqZUDAW99k++LKkAf9Y/LcNsU0NoihPal30C8h+JiaL1qnvG1i/LyhHF+
 XehkB2fm4wvuob9nqipbdDU9QSYKeQjLyYuLS43Ls3U1opySqnP9Cgshp7LfpriJvIQv0+N7CNq
 71+uvoDgL5fXUvzIvD01CXpbp/bgaRgmnLNNYagOMUW2eeht64gXcVduzngHyTWC+jk2jyPg9Et
 sLPr+8KJjDogoaVkY0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090081

On 1/9/26 8:21 AM, Krishna Chaitanya Chundru wrote:
> The PERST# signal is used to reset PCIe devices. Currently, the driver
> requests the GPIO with GPIOD_OUT_HIGH, which forces the line high
> during probe. This can unintentionally assert reset early, breaking

                                         ^ de-assert, probably?

Konrad

> link retention or causing unexpected device behavior.
> 
> Change the request to use GPIOD_ASIS so the driver preserves the
> existing state configured by the bootloader or firmware. This allows
> platforms that manage PERST# externally to maintain proper reset
> sequencing.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 7b92e7a1c0d9364a9cefe1450818f9cbfc7fd3ac..9342f9c75f1c3017b55614069a7aa821a6fb8da7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1711,7 +1711,7 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
>  	int ret;
>  
>  	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> -				      "reset", GPIOD_OUT_HIGH, "PERST#");
> +				      "reset", GPIOD_ASIS, "PERST#");
>  	if (IS_ERR(reset))
>  		return PTR_ERR(reset);
>  
> @@ -1772,7 +1772,7 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
>  	if (IS_ERR(phy))
>  		return PTR_ERR(phy);
>  
> -	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> +	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_ASIS);
>  	if (IS_ERR(reset))
>  		return PTR_ERR(reset);
>  
> 

