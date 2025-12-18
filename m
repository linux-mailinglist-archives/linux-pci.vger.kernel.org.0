Return-Path: <linux-pci+bounces-43247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 805CFCCA6C2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7944430249EE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 06:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCF319857;
	Thu, 18 Dec 2025 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UgPCOkei";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVNcLT7w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6472617
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038445; cv=none; b=iyAPX39j0XIIhqpVlm6KC/gGCtLiTaz9aBAmwLdJDEdBV1QhI3ydmY8Hhs/w73xcaYI+GMVxqyWK4gJ8jkAA0DGNCUnJkC+HWx0GRdfBmHk74dCW/kuhYHWKqPMJVXhz6kzDi+vPCbVMc3TQ3XmUD/LMBZDSl4q/KUgiTynzKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038445; c=relaxed/simple;
	bh=jn70ywdX/gpLHa89qdo+dtRBqFjZHwxTsX20hKp8N3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C0Ufmt2fGitrSM2ZYU15/g3+hFQUAFYMutYY+Gnu8k4Gdy0ded/CtAvoABI8goBXz796756BHTBCDJv9M++CfiwVtnK8U3Ilb1o/ZWvqgZkzZdCI5x45EA0RHUMEWO975qYf41T/cSitnxSgR3RJdThgt4f0qIvFuiR6jvorD+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UgPCOkei; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WVNcLT7w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Z0qv175240
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 06:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0kJ6UUwhcE3rIAszoRnhoodK5ZgSTOrtwR0yg/qVU2U=; b=UgPCOkeiioyybYHX
	r9TZoe+4V2g9l+VE9F0c8IIUXWC1aIXmlnAzD9TOO2YsRGBgX47HDR+voLGyv2EU
	g++9f5csKH0RdvpsIU6795MMhdFCRynFZjLBuT6QyLAiw474VptmAhdFO0h0AlPs
	wtzPmRNIodGHulg5EGITlncNQXk2TwWrU8p7ta2sfNODMG7K4BTsuMlScVrrZEnv
	S4dNLQxyrAdNr8IlWNGMOU/Pk7B1eNPBhlfazAK4jsKy4XCgFKR2INpbIe6K6EP+
	f3ZuJURTXfHe7CUCCJa5C/1DRW0mJlfBI+5DmoH5VmqE5Gq95tIOOkz9rpCAXGsB
	7jW0NQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43nmsc9c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 06:14:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7aa9f595688so604344b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 22:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766038441; x=1766643241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kJ6UUwhcE3rIAszoRnhoodK5ZgSTOrtwR0yg/qVU2U=;
        b=WVNcLT7wP5eXzTm/qHBVJDBjIjQNiVGS2iR2mHhdMgIhzbBg7lW/iIEmL9A9QD41qs
         Zuoub4cZbHS3S+jeOF4pxnxipE4BHIIoLRRd2Vx9HaCD/jH2V8OyioY0HdeQQtnIeMTM
         9HghwEjSFVuYFuuIKey5EpiYu7+T5nQJ8crmLREvobMXNWVK9IOUDrsyD2VUuOd323gk
         E+blQbOtE3FnDn5FwisaM83PLAm1RcKata8K60rc7RDckK8K66tVd+K5FkpqqctSviYu
         KmfV9391Sdr7ss8e7gjsJW79kRD4jA5Bkrmtk8YvNtfr2S8fNJ04D/W0EOznnC0NhgFV
         hSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766038441; x=1766643241;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kJ6UUwhcE3rIAszoRnhoodK5ZgSTOrtwR0yg/qVU2U=;
        b=fPLq/gEw0PSMF9AjmDirEONRcioDGCKeSiSmRNwJE6mz5vusm95lKESDQj9h1nsD1G
         6keHkqyXu1CWRCIq+5o/5lw6Bib/OvrEc0BpGzvec8B3Tm7iEU8dlMGj0Ltac6hvxPSK
         ywNsOeF8iWjZlQ30Iv/PYlQjtvkD6X1LWEkcqdDukGYteVA6r0okGD9hHIRPFs5ixL8q
         Xq93X3+ARVogG9hoW4Y/r1ZBQO2LDynM0whrNedDQn8nBHG7gDpuYbS3vKcJiUq+mqa1
         CaL++Icb3fq30TnQn5dypsTca66WDRZlKQRftew3sPU6NK59rkxehF+2rHGMz3gkUydx
         0Gzg==
X-Gm-Message-State: AOJu0YwY4QzVJkZp5NgGHOismSD2j9eVlucJ8RQUiCAuPzhXW0Sx68DJ
	Ui8LPFXBjuuDTehl36pv8CHV6f3jExIT8/ZGMjyzmYLskyRN74XeR0+4PArtF2YWNbVzeI6cyJF
	sxh6vOQJepoAiaE+OWA9RzKZmKZ5eRMn03EeW6hosu8QzUK7a03mx6lnN9P69YVs=
X-Gm-Gg: AY/fxX582H6YwZGPc5LGN0cXgufVdA539KX1Dtae2YbctPtcYSnob/HPFeECUthru4k
	6j3uxBO47GpaAoMjEzqGogXMZa51I+380pDc6LxF+vciXfKLQDJtH+WbJUzamgAQY88zpKPHjY+
	xC57ptBRVqtV8scc+35zsOPTL6B6mUxTsLXEsLVQV6YNGHjP/vyfxrKIR07i4PDd5AZOL9Sa/fe
	QG3CERMMBFJccVTbF5oPWrSo8F4mU8hkozTgFfPf6kh2NJAKy2XecQWiry9J3j8rv2aPE4SGPBN
	5sYe93mvDEHTU3zjJ5h3Gg1aC35yHmWBNdqt+4EGx7mJq5FsJM2Zdpj/anrXr63KFHxfPKwyfPZ
	Ssmmd7xtsfQs=
X-Received: by 2002:a05:6a00:430e:b0:7e8:4433:8fb6 with SMTP id d2e1a72fcca58-7f66a07b23dmr20074116b3a.62.1766038441558;
        Wed, 17 Dec 2025 22:14:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl4mnxLasK1BJk18MFOX9EHZ2yWedAuh8yyDoiLYuMCRvlDIKoojGeq4Q2qMy0BEfqdqRz5g==
X-Received: by 2002:a05:6a00:430e:b0:7e8:4433:8fb6 with SMTP id d2e1a72fcca58-7f66a07b23dmr20074085b3a.62.1766038441088;
        Wed, 17 Dec 2025 22:14:01 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe13d851bbsm1358948b3a.34.2025.12.17.22.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 22:14:00 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
References: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/5] PCI/pwrctrl: Major rework to integrate
 pwrctrl devices with controller drivers
Message-Id: <176603843625.18353.5483272070289729221.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 11:43:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: NCYs_F3tGsK7gIrdz-2In4FsxWgBT8NF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0OCBTYWx0ZWRfX5lyRzNgZ4R6m
 YNsqCEn+b7ocQN8WKbqrlUc3Nlm7AXU1JcUg1LTksp2wbDPDV9U+JReXXbzsh5iWOefVPxQxJnn
 79NiuhtkwGEH8DI8fY/b4DlEDeT1IiG5agA1iK9Xz8xTR80YuVXH8OPWyc3yIBPXe57KvG9prxL
 HA9HTmn4g4uHykqUGq+a6tEgn2Yq3OYvX/jwyh6rKMrcDycYCNU68isgMlqIr/AK6+v1Ufl3ZB0
 jURwE5DBfWEm4L4OWa4vJD7t4NPIahjlsLvbiRJhMWHNGXG4Vschpd7ice8kiy79eEr1GdkcxJ6
 0JAEiXtfd/9wULMOX86ed8eIs/D0fRFJbWf9f36GKpEgi1eyAu+Fx5qlrybkcML/HPtIQyGiZXz
 YWTFklbQWVwI20cvynfP0PLMJ3e+iQ==
X-Proofpoint-ORIG-GUID: NCYs_F3tGsK7gIrdz-2In4FsxWgBT8NF
X-Authority-Analysis: v=2.4 cv=A6Zh/qWG c=1 sm=1 tr=0 ts=69439baa cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=2ooHDjnlQ54ReXCGMuQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180048


On Tue, 16 Dec 2025 18:21:42 +0530, Manivannan Sadhasivam wrote:
> This series provides a major rework for the PCI power control (pwrctrl)
> framework to enable the pwrctrl devices to be controlled by the PCI controller
> drivers.
> 
> Problem Statement
> =================
> 
> [...]

Applied, thanks!

[1/5] PCI: qcom: Parse PERST# from all PCIe bridge nodes
      commit: 36777244652a7fe773bd7a1fe46bd3803712d3be

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


