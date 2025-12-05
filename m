Return-Path: <linux-pci+bounces-42702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0055CA864F
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 17:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9B07316DB63
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9609F2BD00C;
	Fri,  5 Dec 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jt3/1u5k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kh2h7a3j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27C34CFC7
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947313; cv=none; b=gAztWbtfDbSVpwZOimF/3sbMRiCQyBSEHmYtUVgTBkEhyFbgnFIvOs4bIV41dzmyep4l9FEQyP2iXOPUZa6WBwhFeHPSjC5N9NCEQvFFJj2/kwV48lpOD/VsAW0K5+ZIx5hMmQERhkdiZjddvAyG7oG1zpI4JqimnYFFQ3XsKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947313; c=relaxed/simple;
	bh=PArCrlXxLaseY6SrjNYTk5/snsyyR1dlCwkDqHrKn9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKtnaQjKHL7m7EH5Q/Y32cwEZGZB/hloJQBuMBGSYOaS3H0wTbonOIN584O2R0AfYpsfjkLCQPZyQlklMhTHEPCQiDafi32QbvelPzBDs76IN9EJ8Fvbm0cGI4jK0eput/fYDYxqW39pEHnq2q3ucz1n6h2AKH8f/uQKFcbbq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jt3/1u5k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kh2h7a3j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5DhXUj3528106
	for <linux-pci@vger.kernel.org>; Fri, 5 Dec 2025 15:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JVCH5wvioZe9kiwYzabc8L4MQj09OxUaUi86lSa920E=; b=jt3/1u5kKCzP4Psw
	FkLq7End7Q2EaWwe7mYLbUkcfR/HuCS3D8FsSyvootdGigvyy9fjaW3Wp8jfHLpZ
	Z4RsExXhPOp8tJIKZzW2Hpp1Ccm8Jqp7F0WDReedNeUibVuCIsQHJly6nOBpWZhu
	wwe1sdXTmoYWCHJZPKa9rIjSx/GfXu3VppWgm2OOTbtjqgBlV0HMLD8vgFiuHdAK
	5jW4O6B8pYTSoncuW9RtYZnlRDGiKDWsJVw/3YN7FiFNHMSJw9jdnsu4biYvzOAZ
	e5Ne99yzxSeUSif/D4O9ty2CNGg9avsvdNR26LZHRi45N//1PkjsMfMYhImMleXU
	OuXaYg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aurwvhk1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 15:08:25 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-450d471e085so2940022b6e.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764947305; x=1765552105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVCH5wvioZe9kiwYzabc8L4MQj09OxUaUi86lSa920E=;
        b=Kh2h7a3jIoPzVlkAwqp6ZVbXMBbMPvw7EqnUsgmF/K1rNnqzl4H9X5A0xYkZ4ks8zH
         8gd20WyWyoJEzgS8YfBlBb5cDdp0Emh0LpicCtCqYhifOmY5SAhYsO+p4k6fqWAero29
         Pg+G+pEmaspO34OJAwiQjM4Twh0rQ1xh2FKNAPcxednoE56ipBxAz8wrSlifcqFSShJh
         hRZuFXxgc8Avt37jvHteVbJRwctx6JKc7LLxb217/zncOFoOiD0jN5GaqtFqRqHTyaXu
         Ly4XsD5TXOT4Y3Nl9qSVC9u08XLjbZ9V4AjeENI95ia1mAMFw5IR61Y1XM1Mw+XCIGwd
         Ci8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764947305; x=1765552105;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVCH5wvioZe9kiwYzabc8L4MQj09OxUaUi86lSa920E=;
        b=hZ3Alvq3Q/0LNwslhZbM9tAlH0U1JX4sOd367yQRQMgqy9IMI/ys9zT7GQRZyKH7dr
         G1c4mA4bVUxNkPtrzuU7WNmNu86Lt73ynBaXAnWxLwlVmiVUtGZZ0KI/P+n3zi+VlL6k
         jxzrSVgIeuIXLWtDwamRZS5ivK0uTUrZ2wKgccvUQmBSnPevIwCunhvFW+X1UsYE8U89
         qkvNWMp6hvrHqBjMmU625wYiIvgIlu1qIjgW2wCcQ8jw2FiuYLpLwPS33OLC1eEDfW4M
         /vuVjK95N4JV9gd0D7demi/LEQu3i5PGRqqP0w9u1MmkXzIz5pFBsYgGBx2Cdjgwtq+n
         5x6g==
X-Forwarded-Encrypted: i=1; AJvYcCX3dcI7QRQYoqXr5nyD6rrXG9iBRLUGwqx01SBlNbMxLHrEy5YeO8NgAttlxy6HcP0WIJ1LemXBr6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFpMCPEHn5fTC8KevZRfhzqind7MFjtJG0m0TrHsVQF22tZe5Z
	fNQEMtTHxKwhYofNQwNgndY8a23FsRLWbulqx620QBQaEpn81SFNjM8wrHas5yrcFHHQ2jHhLGz
	1s2Vy/PnU4udRZ/yWz/SsanRrliBfbjJsWImX2+8izr0wu0V3vvxcsvkcYYiyoL8=
X-Gm-Gg: ASbGncu/fFYlwymIRk8i61VSIS0hcxXiReTN1xKSf9c9NqJnpMhxSdYvBKvJi6Ep3Jq
	lIGEP9sgZNobz7UskWbFmocq+Qwjs8JSBt7uATCRLErXYhWeLbo5vp7RN554Pv3BIkVmRdW3/Nz
	B0seu46armo/YayI0SsWFg0aS5z4SAOwQcN1Dkz11O2W16UippZTAIrcozxOV8LkGEigi4f9VyO
	hq9tP8Nzn8XuMB0qJvw8dfVkw2UeKMWCSiBMdShlAScdg4GJxI4iWZfLq7DoOt3Fk9cS9WaM1cp
	NiePVRIGPbY+2rVogEIZ+Z1ghxWYy5KXTv+pGbGogyn0nF5fGilZOJ/G8/UcOFdBhOwtiBI04+t
	eXUEOYAF+6vDfsaT+wPq0pzQ18tV+aaQnCU1zoaME5rhyMhSQJDsI1c4OmuhR2Xfyb7Y+qw==
X-Received: by 2002:a05:6808:1927:b0:44f:f73c:d779 with SMTP id 5614622812f47-45379eaa3aamr3805873b6e.57.1764947304936;
        Fri, 05 Dec 2025 07:08:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETLiy/34xkKwIyuudaaUwJxiY+2SHi6tv4ZnQaCOh/kwQ2rd9DBrDLuwAeduheHE0MduqITg==
X-Received: by 2002:a05:6808:1927:b0:44f:f73c:d779 with SMTP id 5614622812f47-45379eaa3aamr3805832b6e.57.1764947304500;
        Fri, 05 Dec 2025 07:08:24 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50b510088sm3526487fac.11.2025.12.05.07.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 07:08:24 -0800 (PST)
Message-ID: <73508b26-bc71-4661-bf2d-cfce0eb1df13@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 07:08:21 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: qcom-ep: Add support for firmware-managed PCIe
 Endpoint
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com, Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>
References: <20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com>
 <20251203-firmware_managed_ep-v1-2-295977600fa5@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251203-firmware_managed_ep-v1-2-295977600fa5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwOSBTYWx0ZWRfX9axQ7ocfWa8g
 6tIwlFbcI7e9+20fIIA27MlB1Dhuc9MLi4YI2HNwuqeMEQeS6Vwju4Qy3Qi8IZmeSQN1RrPDvXA
 Q8CjruBmAPJTRfKev/pDpodCE99HEafz+LwmCELnhD5U4k9P3hulkEGo/Adiqbjpt30UdCgCIy3
 +Z6DjozPtu+qI4Vkr5dKp3c+jspHwX2iys0n/N6vAzgq14akImLU0wVWrsDfq7+Ogud8bQQqP9B
 bfQwptmDKrweElvRRGq1gWMLqlK1yUNUR5kHWs8TJtGiRLS+6p/Cn8PUb8lvdSSnaIwyEb8MPRv
 uD8djPX40ozrwX60i02zKkzjO2I/ZtAODpcEkEXuRVSUslClVMC8q+cgCg6my18hxYdQZw36v31
 koV3tEJKYi1LmwSSsprJ1trIBD+V5g==
X-Authority-Analysis: v=2.4 cv=Yd2wJgRf c=1 sm=1 tr=0 ts=6932f569 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=YnIKxIlAgHF9ygR4tIEA:9
 a=QEXdDO2ut3YA:10 a=D0TqAXdIGyEA:10 a=xa8LZTUigIcA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: BHe3LqCFMjE0oPoVA83Z8kJyDdR3Lcpp
X-Proofpoint-ORIG-GUID: BHe3LqCFMjE0oPoVA83Z8kJyDdR3Lcpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050109

On 12/3/2025 5:26 AM, Mrinmay Sarkar wrote:
> Some Qualcomm platforms use firmware to manage PCIe resources such as
> clocks, resets, and PHY through the SCMI interface. In these cases,
> the Linux driver should not perform resource enable or disable
> operations directly. Additionally, runtime PM support has been enabled
> to ensure proper power state transitions.
> 
> This commit introduces a `firmware_managed` flag in the Endpoint

please review:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

"Describe your changes in imperative mood"


