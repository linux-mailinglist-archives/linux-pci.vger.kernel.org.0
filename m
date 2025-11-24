Return-Path: <linux-pci+bounces-41942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 075B7C803D9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 12:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E21904E10F0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81632FC88B;
	Mon, 24 Nov 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JoHfhOMG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PPSklVGG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5136E248F48
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984569; cv=none; b=EIg99pP9hvshW7svT4YvSADR77gs9eJd3rOR/zuSpsTO9R0dwb7yCoR64FpZ1U4JImYY2ZaaBFXR+zluJ9ldIpCbse/9MoxB78738KcUg6u63vW/mI+Xqb/iivd/ZNfN/FRYMOq5Nad4ThZKn7bAAmaGVUWuDPg3OHlPhL4yzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984569; c=relaxed/simple;
	bh=yxW+0hq+xdWaIvmIR13/79lwfDgz94e+THqjVqoR4yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqrxksTyR3TXrJlHa+EbsPffLTZl39ZosqKOi5QL6CIjP0YDEpuX6iv1ZLt/RPXboJCzbYtChO3xLlN9MjuvRm9tIIRMDVMg4r3WpLmxIo1PmAGKKtdr5Zr+/wwV0xck1NB+tbnzPPzN06NxgtKPaBQX+p9iIpAQwXAHhmNwajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JoHfhOMG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PPSklVGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO7TEUx3112066
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 11:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vOwkRleX0/HPneuTZSuUXMIp11FuA1s/fb+Wlx7sHoU=; b=JoHfhOMGcbBjfxTh
	1zKiq7cLwctkkTh5yt0xnh42UCAXUBAYIS3s672hOaC/lVMw49L0to1DFFyk/Ev2
	QgyAPF2a9GgO1eVnK9m0J19R043YvPIMJazfBWyHZMEQLWhQg/YClwTieevfTCfS
	yxy5hT49LCuUgXLTTDxcYiqYAA6svRFz6OWLc5y2HhKmlNh2NfUiEeKHo285EPas
	dwmyRDL1nwjIKHDAt2zbaNUJ0X0PbW1067CbS8SUPlYGJAH0qxqe0MRwnsO1Y6sm
	vyCaB2+iMIc/ArfYvp408fiIoe7FXTj9Q8zNrDhjrTLUobxBnysWswD16vWWCOY5
	gojg9Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amk10grfe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 11:42:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b25c5dc2c3so107935185a.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 03:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763984566; x=1764589366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOwkRleX0/HPneuTZSuUXMIp11FuA1s/fb+Wlx7sHoU=;
        b=PPSklVGGV3lSRqKmLjWrEfOonggJHoBi+xEKENFOiQNKpAOJJIqXin8ip18z2Vfuvs
         rVbFzJ5HwvjjUlFpbiktTpTppoTZZtQZkUNZQqCLBusWgi0qA03MmI8hrL9ZMCoseIpB
         eKFPPcO0zC438vM1kJH1eoTwFZq+xM26sZfvk9Bp1/AjCEp4hpj2zgzIn2Icr0RVQTRM
         4eVm4Swqobr4v8XbBL7/LQeeAMctmyTrL03uu4k0Er16xY2z5/DMGh6fWMhzJbwlHdmZ
         2bC4RzW9qc0LM97+jROObae7mIE6HabwSQru8WBBcsmZdJKgR748TyPKz2je4xvzpuIz
         R9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763984566; x=1764589366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOwkRleX0/HPneuTZSuUXMIp11FuA1s/fb+Wlx7sHoU=;
        b=QBMQNmgTDX5+Y6kYXr3s24SELm00akdQvBo6DmbdLnyeUjPcCLo5oJVJS2MDXV6wNK
         bCuvJui1Y8BSuBwYWIRQ+900WmPwr3EL9e9pWiHsIEst7tY6dFUPAvNz/eIwc1ubb/jU
         UoAxVtJth4f3xCjGyFM3/p6AZ/Uck4DMRN6r06Z2bHRnG6jzaWgSLuxdG8IHFig35EJZ
         vziB2CN2Tdry62uZCtYzElDBr9EDjH/2Vm816t8f+9SA0pjnArblRyyHxg1NXSzJG65P
         FvZT75mBZqzvWOAW4UEhGBLbBx8GRpPLYqyV+9p895e2SNJ2WI0lIaH96KBAH8S3LKoT
         EaMA==
X-Gm-Message-State: AOJu0YyT21JWzHu2slYAF+YpqeteDVxq41NJZF4CEXIem68PoeQWxGKc
	LPvj8Xl9f0DyVWaEugu8tj5mkUblGJavIsGfeKObcYho8oeNalIDfp231mSBP/hOq8tMrgu444v
	kuwbx7XRK8mnz3fZpF8oKZHuvyG69T/V2HIWca3XROCSbPfgW1mVtKIczP/nkV+ITawcZTIg=
X-Gm-Gg: ASbGncui9y55CDV5b2MwuBUDyF0cUwgSAk7IIj1CvZA1eD/piy7G7iombz9Wbt2GJ/d
	LXFfucGNJygCJSDXilXqpw+sEhame9iIGwE0r3wXrW+4/5HZAAGMRdNuUK94gULmkD6Fm9Cww5p
	xlr50S3xr2gFMpJWhYYI/fV5KQsF3J/5lOmlcr3dITm0tWgH/hpDGUK+ci8a589ywi6Vxv3XSr0
	0QKRcapG5ImKxwJNp+5FQ3PIq5ZbIexzVXYTo4crgTSHZ5TTOFwppXvabsVamzSO99tC5Vy/TKk
	+GaH6tAZYdBvyOLj2iF4qFFT5aI8Iz4m4XxgWpaTGzM0FxYhOV3Wt6MfSPaZramuyJSi1lRkinC
	41s1OChhrW62LtwWQd1Xesl2tbTW6/JmWt4rxQlt9EFcRUz6WVdQKMI7aiJVv5HqeQ6I=
X-Received: by 2002:ac8:7f47:0:b0:4ee:1367:8836 with SMTP id d75a77b69052e-4ee5b6fad57mr104481281cf.5.1763984566251;
        Mon, 24 Nov 2025 03:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOiv4g/u/e7x/GqCRfNkAnyc3/9hzMx8fvdYPjlkBHSJlkgo2NscmBHl0CkBVDbNGDKTEw6Q==
X-Received: by 2002:ac8:7f47:0:b0:4ee:1367:8836 with SMTP id d75a77b69052e-4ee5b6fad57mr104481101cf.5.1763984565753;
        Mon, 24 Nov 2025 03:42:45 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536443784sm11705733a12.28.2025.11.24.03.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 03:42:44 -0800 (PST)
Message-ID: <31bbe640-b1ea-454b-9c9c-ed013022f07c@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 12:42:42 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20251120161253.189580-1-mani@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251120161253.189580-1-mani@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: He-WVVtUcP2E4byD5FYKj5NwLK1rkvWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEwMyBTYWx0ZWRfXxAB7jSmAaFc0
 PmwDG+4UZe9LrbU741rIfUtmAyouur2NR8QJfjzvTI2ReJRyYkIaYvdG0npwDDNluA6/K2r0oeV
 XuPTXSTbV73kFelckDrTgAOmusGI83KrjyOKHe/wQmXQ+Rrfpb2Pt1m3Wvz2CwvRjihu1/SL3WM
 qoDnHst4rRfKtfeQ021fvZrOEzt1b8oUYfMu3D2UGkB5/OoJw/7fYPWfaD8hZIBCTMeowqoHCPy
 +rfwlJ24K/Jlyn1Y5m8nnPbmbTE/5GKQr7+r1ninwi/KyDmEbeZPb6Z+oxcs04jsSSDrC4LrTZq
 l0vMYG/cTefah/OgMBdVDCFjn21wsB+lT/i9tQbnBCyByrD5L9imPoSd7vdAZEFUguufb+Q9erP
 f+8Rdqj9O3s1OT9lMwSPxBm6VQ59vg==
X-Proofpoint-ORIG-GUID: He-WVVtUcP2E4byD5FYKj5NwLK1rkvWz
X-Authority-Analysis: v=2.4 cv=SP9PlevH c=1 sm=1 tr=0 ts=692444b7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=IPny-iXwT8bmEns2PIkA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240103

On 11/20/25 5:12 PM, Manivannan Sadhasivam wrote:
> The Sandisk SN740 NVMe SSDs cause below AER errors on the upstream Root
> Port of PCIe controller in Microsoft Surface Laptop 7, when ASPM L1 is
> enabled:
> 
>   pcieport 0006:00:00.0: AER: Correctable error message received from 0006:01:00.0
>   nvme 0006:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>   nvme 0006:01:00.0:   device [15b7:5015] error status/mask=00000001/0000e000
>   nvme 0006:01:00.0:    [ 0] RxErr
> 
> Hence, add a quirk to disable L1 by removing the ASPM_L1 CAP for this SSD.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---

This revision also works for me, thank you

Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # X1E80100 Romulus

Konrad

