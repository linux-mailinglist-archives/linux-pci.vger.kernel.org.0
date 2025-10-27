Return-Path: <linux-pci+bounces-39428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800A3C0DFE2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6716818930FF
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C992868BA;
	Mon, 27 Oct 2025 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JK7xfJJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91F23E355
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571352; cv=none; b=HlloVH9ZGE83ETX0Sn5uUWf6+r/lSPzpvu2G8YjMZBTn1s6gulPK3sdyTBCwxXSGkrMaOjMUbaf0k3WONBw3yXjmWQnhHzkF++ouysndmLGBJeve7U4Q1UXE0N0ey3JHk6bzN+HoQMSYhluOW19ccGWfQRXMJvSczdtshxocYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571352; c=relaxed/simple;
	bh=FuLPGb9lpc3kIhzrWDfWe9XL+0VkpsfAt3WLq5eKKKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lofNLyItkY/Ebhjq6fX8+K5aTYrwPosvLAEY9mbpZpZRviSAzNTKrmKpUNoU4uyWkHKzGoxq2eWawPQ1CAe7qQsBCB4Q9giFS59gSvECX6Y5ory11z8HFiuBkWjSNHbOFwXULdTdnguwuGSTQdvU/whkpZeCcNdYPIAFCevzxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JK7xfJJm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R7jpCN588480
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 13:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bOamnVJjm+3duRsX5YWXJXmZ4fYfBcBJKOdsubpmAGE=; b=JK7xfJJmIhsARo/h
	+zlqzqH+epJrohpGrugMsbmErn3Q+xnKQ/nHTu910A8MbmhSSmQ+McAUTWAqO6Jj
	GfS8mnPh2q7hT6nOJnXYNz5he+KkokLYwSylPopuSHr5vnX8Vv3n3vZTzAZ5qWug
	Ln34lsRMWGa6mvC8UgiAovtS0+dCUOjvM/ka5ojng6z81c0MEWn8SM0yporgkY2m
	/GC8E18WGCwh1NoJ+XKnX6xVYsLcpZJlZSyaPM7kXUYfEZGh1pWP86QsYDxKSKfI
	sRUAGGhgDdTs8JL0p9QdLKMpxpiOt6t4j4eSdf/xBP28K6j8gOFr3pquAxSZ5VRg
	p+iJvA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0ps14ms5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 13:22:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87df3a8cab8so14011366d6.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 06:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571349; x=1762176149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOamnVJjm+3duRsX5YWXJXmZ4fYfBcBJKOdsubpmAGE=;
        b=b7f6cwujVpWMTgpansSxIt7wgCdAH74+YYyUqS7/YPNFfY7wcyGpI7NHvayieMY5PM
         ErQxdG7pWb2LvhxoR1rgDJxuC7k/UajWZhyIG5RU7tuUCY4+N+RJGIwbhu+LWlF6jniQ
         I0bX4n92X35tFlAbOvokiJVtMA75E6Km8riTQdgDgcgYcWp91gc5yvVbUXhRPx4L+o8y
         WIRNwZaNqVhw5YNOgfcyUBy8Gy6N68LTdXcmxq9F3MkSW/1hC2C+/Bi5WaJk6GOob9RX
         A/lp0BMJqLu6i3dQD4RDh91CfPCpUQyaEe26nDe2Fh+QRHC2EA8WPncVf7oup4DOQRsW
         Ue8w==
X-Forwarded-Encrypted: i=1; AJvYcCXYC/uqCCkFBvNQDBewClmadqRaCbar128CG8AiTYOmeWqPy0pCK0bOzuFfbiqygB/XwH6b09G6uZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVU+hI9UsXfA7YtKf1glcsBDm3fYG2wxAp1Jzj1TZf+xu3lXbP
	+GynKn4mKNgadUMt1tfcLz2jzbdW1IObc6MIKvhWBxBE7k17o+MMeFwugNnTA1xzoCMpZld0K+K
	glsUq6UvP5KU1RNUgEeFYxXtLBnNxu/JcilH7Nann4vRTHRSFVoHPQleQxFQanXg=
X-Gm-Gg: ASbGnctQWbpDxbg9RXMlvuAOhf0DQAGTAS5hqXdH7FQEkScm0SmGBoJ624R5wZ3RosL
	spx91NCH0G6m/oQkvDwFQhTtkjUN4MsbBgUXxLJc99qexF73G5lPWUdvMGa4cdTwCjM83agjM2H
	USvWqGQejavNwrhXr4PbMZxtYe3jK9j+YGUS3mKdTSWyXWkhOrzJz3dDu4usgCGS5NJATVdY+3T
	paR8T1V4FgVvVSLfL/A5kUu7qiwUpSl6QIcjaOTYph1qz5h3xeVXeMgoqh0ONEZX/uY8LGKdeB6
	H5vtH3Do7k+NiKU/vQ/8XwsrTU7OLgrmijb99RQquvCdghjVDm5Yqd6p9hdLiONULpBL/ku4Axh
	c+fmPynbeWtiijxuMGBUpHTgiQz1DgfnMV60Fakv+OhZDtU2xyoZF+vuA
X-Received: by 2002:ad4:5de6:0:b0:87c:19b6:398e with SMTP id 6a1803df08f44-87de70b4724mr204621346d6.2.1761571349369;
        Mon, 27 Oct 2025 06:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERE9vYsDZcoNA0WsLgwk+/4zZa5M1BCBMWIBkdBse7SWtg/6ZU8mEslR7ufn5BKT+zPKuiFA==
X-Received: by 2002:ad4:5de6:0:b0:87c:19b6:398e with SMTP id 6a1803df08f44-87de70b4724mr204620706d6.2.1761571348570;
        Mon, 27 Oct 2025 06:22:28 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6c129sm6430632a12.3.2025.10.27.06.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:22:28 -0700 (PDT)
Message-ID: <b16872b5-e497-484d-bba5-7c4ec590cfc2@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 14:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add PCIe support for Kaanapali
To: Manivannan Sadhasivam <mani@kernel.org>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
 <o4o6tthwz4vz5uqqjv5c4cld6qhhrfa7xzotjd3qyz7gpoab5s@ki4nwe6us4zc>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <o4o6tthwz4vz5uqqjv5c4cld6qhhrfa7xzotjd3qyz7gpoab5s@ki4nwe6us4zc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ju78bc4C c=1 sm=1 tr=0 ts=68ff7216 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ceeQHXABJUnddBcZNCUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: w-vMnJfQDoOcmLe21Kmuz8jBI-Wj70fm
X-Proofpoint-GUID: w-vMnJfQDoOcmLe21Kmuz8jBI-Wj70fm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyNSBTYWx0ZWRfX2n8QRZ2li1C1
 yglfQz/SHzNKeR4ze1HukXOnqIKPeUnLxynsxw4Dfn/utG26Jmytcvp6gYMYJgbLnqXpHvaFyfa
 LxKDpmJ9sFJATzG9JwCC2dXf5SKdFkpMLh/Ol6kfAjtQVBZSxet5ab/tgShZhdM61xojFOFKT/i
 yGtQZIZZrxeCQIN9AF4o83rO9Ob96KmerSueu35+bXjSKgu2OHLy+QiRgwUFEzN2p8MZS7MXhxZ
 vG+kmQocBwhEkY6stv+8ZlUcpRZ9jcobnTojCudPMa9q7G5ad7Xx18IV/y6D35T1YpBIPSc7jjy
 kq6at6xwtcHsVer5yIY8c5tuKiFvVqRTs+hyj0ulZSnK34+KV3bWdDeOb46kECmbiZ8U5PUAyFT
 TLHGEJky1P8QgVCSBdOCIrLq4ZPTwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270125

On 10/27/25 2:21 PM, Manivannan Sadhasivam wrote:
> On Wed, Oct 15, 2025 at 03:27:30AM -0700, Qiang Yu wrote:
>> Describe PCIe controller and PHY. Also add required system resources like
>> regulators, clocks, interrupts and registers configuration for PCIe.
>>
>> Changes in v2:
>> - Rewrite commit msg for PATCH[3/6]
>> - Keep keep pcs-pcie reigster definitions sorted.
>> - Add Reviewed-by tag.
>> - Keep qmp_pcie_of_match_table sorted.
>> - Link to v1: https://lore.kernel.org/all/20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com/
>>
>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> ---
>> Qiang Yu (6):
>>       dt-bindings: PCI: qcom,pcie-sm8550: Add Kaanapali compatible
>>       dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add Kaanapali compatible
>>       phy: qcom-qmp: qserdes-txrx: Add complete QMP PCIe PHY v8 register offsets
>>       phy: qcom-qmp: pcs-pcie: Add v8 register offsets
>>       phy: qcom-qmp: qserdes-com: Add some more v8 register offsets
>>       phy: qcom: qmp-pcie: add QMP PCIe PHY tables for Kaanapali
> 
> So this platform doesn't support nocsr PHY reset?

There's a reset, but the UEFI doesn't program the sequences on mobile..

I raised that point internally, maybe next gen > 
> - Mani
> 

