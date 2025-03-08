Return-Path: <linux-pci+bounces-23185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2409A57B61
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 16:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B787A3F11
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098C1DD886;
	Sat,  8 Mar 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QStkJoM9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C931ACECB
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741446220; cv=none; b=FVl5MBZbDokR6Rs9dxUbA289eG9v24MSrm8p62wQiQcN8HmhWPDJGJFdsXH28eNAF8xbvwiDF5VktZltDR5c1r6FnUMMX3Yj/doKiRr9WfBGyTirBNIzHE9QetZTtnI0lDp605IfpUnULeFQoJUlutD5dOjIwICKbJbwhtAqaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741446220; c=relaxed/simple;
	bh=e8SexFMLy+V7m84HKtVT7FdSZ56Nzyx3ZfiZYFbyK0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSlbD41poD2UXeyqjmyXXiaFcToxm8Hoi5CvQVYJOKCS5G/CfgwVNKMFldwlfLT7ZHETq9pl/yQ5HENTlTN+LZ6UETMPMgAVSbqy8HNPdYU0NemI4S3NLzeACc5ZP4EPpZj+S0O4+kGGYCFtE3hqEZcVGN+FiRxOWxLnTPB5tXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QStkJoM9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528EUJqP027431
	for <linux-pci@vger.kernel.org>; Sat, 8 Mar 2025 15:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IKPlg8KpcdilLw+MDQw3ribbQkf1W3yXLlwbnkUFVEo=; b=QStkJoM9yFDPRuKP
	TAlN9Nx3GZ8AzY7PwGE6cY+IUQALBrunGtJ71X91Iydk32xhzHGO51JIXEG0/rVW
	iSoEx9rxOAMom7RXWhrXa4KQHWX3Giv0qYI2bJIDaSizeOBOJFAFjZzWZkuCtLXE
	KMrgw86aP/ossoee9Y7dn9i5D3NyfRy+6DVTn9vVIpTCkLkvOYN/9OgicGe9iA2l
	bIzWZCP9i633tpIVaOpMKHGWRbEbSYrkDqsvrYfi4hrihwwr/5JpB8GaW3NnKmsm
	plGuhK6NVVX4M6Fervj4CyTeD5QUU6MsXdfYyHzI7vGmqla/DFMRW152l8+7hIoE
	hYoZVQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f2m8qak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 15:03:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e4546f8c47so7460276d6.0
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 07:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741446216; x=1742051016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKPlg8KpcdilLw+MDQw3ribbQkf1W3yXLlwbnkUFVEo=;
        b=XBP55n16KSpvy8cJbeKA70I/LkrU5tIfPFhyRrk6v+yOV/m7ltppY9MeARcZK47bSW
         qTER8yHUVs5ofJYqOBSNogbsUYQaFJIAvSdJwHaOgIxsPtkXHexf2JMP0Ztaasj/BecF
         EKzjbFe64q7Rw2mmb+h7T9NAUoimxpykf4/8kgdZLd4NHJ/ta5XZwft40vJ3SUGBkLRd
         5e08RfVTmvylgaSgh43FCRn6fDoAsuJ6mBv2g2gpj0Ou72nXgbF6pLOPcgmI4MxBZlK6
         0TzO0x9KuzwyqjByTxlJzeevX5qhig+D5BoOk/WZs9hJrow1hfPivNIDmc899hQXayui
         6fYA==
X-Forwarded-Encrypted: i=1; AJvYcCVm5azhyZQRN1S3wQ//edQlOdydAiZ7ruoIWUkivtZIQcNo78ciskn9bCSskkJBWZxmqP5LZvgaqb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykXoqGAVPDEHmUG28Dy2Qg0QbC1FXCzGAhXYnlDAYe8YaytVpa
	6CmPDOmBboMJgE3ePqzH1xHQq6yzH8J+TYv8aK7hvfpOxCD7Y75/0u78W0K9rQzZ5dSdt/c6r0Z
	czoUgXILXZfm2b/1E165r0p2Td7J2F8Ezm5es7zGw2AZPOmpKF7CyHAHTvr8=
X-Gm-Gg: ASbGnctHVRf/Wfb1iwpgX0i8mupIdVMtLdj5TsCVkTq+ahHIZOCsUFnJzStQ7NEE5r0
	qLst+rSAeEIR7GTwsW7rOIPr3rUlsDr5f6xYcjYpNWIX6dPnqFR2ERGq/nlWq/bDAkc9HTHeE8f
	0WJ8ILH4wTWNzw0B6Ie4VhsGf8jfiaaE1Yn4EYlTxCEHtYng0LjSqCgfLoJtzbe7w6BK8KYzAMI
	4eZ7U3vOPZbGWTNmHhhvHqlb6X30YpLxKkjf67+a44irGU7kIw9OYUuE/ZQNKcRDjoo0ZiZX53Y
	t8h60zOVfEsdgtkawH80Ln0HOK8EKOkbAgXxgJ8nSIalW/1GuGusEDC+gUi7QyiyrTORNA==
X-Received: by 2002:a05:622a:2b0c:b0:474:e7de:8595 with SMTP id d75a77b69052e-47666ca49c3mr13703121cf.14.1741446216616;
        Sat, 08 Mar 2025 07:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2C1ER2UZOIAo7ctUzp4nSuh/7gNp2uvGTLVNBhuB4jYEmqZINWmCWfInxvDC01eRy/YRnlQ==
X-Received: by 2002:a05:622a:2b0c:b0:474:e7de:8595 with SMTP id d75a77b69052e-47666ca49c3mr13702851cf.14.1741446216104;
        Sat, 08 Mar 2025 07:03:36 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768f98asm3999255a12.68.2025.03.08.07.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 07:03:34 -0800 (PST)
Message-ID: <df2f0bfb-665e-45a8-8103-5c6217dd194a@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 16:03:32 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/23] arm64: dts: qcom: sc8180x: Add 'global' PCIe
 interrupt
To: manivannan.sadhasivam@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-21-2b70a7819d1e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250227-pcie-global-irq-v1-21-2b70a7819d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7ED9a_78lv70q187AokzerXx-kWHIUAe
X-Proofpoint-ORIG-GUID: 7ED9a_78lv70q187AokzerXx-kWHIUAe
X-Authority-Analysis: v=2.4 cv=ab+bnQot c=1 sm=1 tr=0 ts=67cc5c4a cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=x0-Ntm4DP0gVEan9CnAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=570 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080113

On 27.02.2025 2:41 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 'global' interrupt is used to receive PCIe controller and link specific
> events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

