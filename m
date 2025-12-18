Return-Path: <linux-pci+bounces-43256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FD0CCAB05
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D43E5300A1FF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB431ED9F;
	Thu, 18 Dec 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MqgYZDk3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BMp3WXQb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F420311
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043356; cv=none; b=CfXuLK6r94AS3NtqFCD+K+fBM3ZyuU9Wp8l2XqSa/jDsJBWscdoB8J0WSRPKhimuGS+gBzEfM48ll67zQ/mwO2FOZIBnzP5IGL595yO4IJ/qanvqXFM4lnVhvfuS0k039gRq0WgFv/QGCDDqhCeg0ZC6M6CY0U3bE4Soz5JMn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043356; c=relaxed/simple;
	bh=6n+IMOSEgat3Tj18bXe0zNndbG7l2DlP/cMSc/3HqsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lFujCPUFOIaol1HJcKLXeKYc+CXuCViKPSsMvnm6rbslA5pPCYOpQAV4yg5wkQ6MDEw0oCKHhiTgyfrDh2zEfdL1J9fp3pZX2t3DS4ctV507lo6ZBYgcoNqfhk/pqmgzpayZsWv5ehgnS6R0utEY4FCiKLuqZweZIa7DKkNjoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MqgYZDk3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BMp3WXQb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1ZJTe3718119
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DyBiHIU9DR8DtiBtV6NrK7oc04ZzyQThNtKsERGP6ng=; b=MqgYZDk3AmTfzrrN
	r+9LeOJRAY+zIhqzfcEzCtUIIpNP3uuyowbbMv+FSwd7MFmViBu1vRse2b3/kkiX
	Gd/E6BQqMdWd1yZoMuiSYxa/ZAGsNkitBRSQAC2Bl37BD37xakeW9/p08gutrvdk
	kbIc+tO0poQ0jxiWdwrDrZ8shLExsIyydVQehgvFePfCEtJ/wEuu2vQ76BfvxHxY
	FjMHB55oKpHWtUO+IaMcnAyE3HWjoJa0gDEORCq11mBPGVtzffkHVifj8onXmeIy
	NCrXmTX7ZmBnTJnkdw8/VJyUmY8yIavCfQfuwHjlbCoRu4zoU9zxhvNBgZl195bl
	zKSoXQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40n7a69r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:35:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34abd303b4aso1085932a91.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 23:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766043353; x=1766648153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyBiHIU9DR8DtiBtV6NrK7oc04ZzyQThNtKsERGP6ng=;
        b=BMp3WXQbOrrYtTi/Q+aveZF/1REblMeyBtVMWmzpwAEuw1v95sdnFyA+js4HdqgVrv
         4oGHpOR441+QsJglw1HURzcuGK2/7uIs80EMl00f25IP1bjfAPjd30QeJ+21BzgffyW4
         Q3gnSahsuxDd7QoQDTsc8FHaFpldowgRK5gBM3vccc7HI7K5wqBilaWZ8/8CFhSA1mzp
         sTdTxRtbnuDmG+eUPEMZ0nWcBAXDwejRk6fQcXtkWCxG8anPoVlakPro+1wonMa2m4pF
         JqgsTuPzbn2vq9tb5ktH1M+aaao5ZTjRhTK5bij9Evs2ZV44tMVJr8puuNTyJFMlbZUN
         OXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766043353; x=1766648153;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DyBiHIU9DR8DtiBtV6NrK7oc04ZzyQThNtKsERGP6ng=;
        b=s2EbH+eztNQwZBNd7zz7wD/eK6AJyAs9taL2NgBgJLdILpjn3zEu5w34cgtHVFle+S
         EHMPUH2amS2ff6emF1R69NzFXNBex6j+6XTjAxBh2hf/KgY/aS+LfxpQnyuQMkUjlaM4
         cuuVd/Z9EYQXtBCOBc5/Q6LWB4g8fW0Jz9igjPmgDWEizfMGa9aPJIslYhWq85b6uJ/X
         Ua+HValP5tCABUHAGraJmEQKgbhTlCh8v8WYrW3YEcRSEq9g9uf/+BaP/yMMlZmpO43G
         BUfMr22j6Qy0ZxBVRTfH1J4o/sGPQlmD/FwDfvoeUOn81C6WpnmRb894Rxtvt0fUMTeH
         uPOQ==
X-Gm-Message-State: AOJu0YwXRZOi3+w+5RYareTCXEixm7pui8wankr9yedkVCY1QGzDTyOk
	KHVCi9XGy46zRahv3w3GSqhBgkwgaxfW0kZxlW77lb2bPbqfMwY1/tKCZ5z5aL3A1Gho0Hmx5uS
	AsQSkRZWRRzK24Jd/gLrVknQRaSCmGq4HqZpocRY35+mqS6dq9ESLeFNdRegcHVw=
X-Gm-Gg: AY/fxX4BeLzFReFeluhFN+QjOEeqSWpgHoPhP2FzLAYF6SKoQiiY20JhRDxTBrkZGwI
	+UhwLLrnXXeFp9moShfIg89Ean+JxGObPAcmSiL2Mv6yEq3CX62wMttkhsa2+4hNEkfn9qN0r61
	wdY4j7cf2mPl1O8JEe1fs5Unfpt6HQ4KwWGUxD2kxDBq82h/3S9H2lACWKyAOXBip0O2+qADzUd
	STNY2zP6srAe395sBkkKoCgNnYGNAXculCEmeEzfxzwYKONej5wruBzTKl8J8EhkSzRAJkSP8py
	r0vwDfxo30/NMTSLMB+KxDLGykdctDScHV9feNPUos6LwlucWoOyuBLouAA4Xeza3CS8ELcGoyc
	8CkEyWzQpxG0=
X-Received: by 2002:a17:90b:5883:b0:34c:2db6:57d5 with SMTP id 98e67ed59e1d1-34c2db65c0amr17034944a91.0.1766043353128;
        Wed, 17 Dec 2025 23:35:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw8FXg1nPzbXznGbhv/sFTHWfXcEofsq6S8QK2Bcfzct8iGZQISvvb554tA14/5OShVw5wXA==
X-Received: by 2002:a17:90b:5883:b0:34c:2db6:57d5 with SMTP id 98e67ed59e1d1-34c2db65c0amr17034935a91.0.1766043352602;
        Wed, 17 Dec 2025 23:35:52 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbc9d6sm1583665a91.10.2025.12.17.23.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:35:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
In-Reply-To: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
Subject: Re: [PATCH 0/5] PCI: Remove unsupported or incomplete PCIe
 Capabilities
Message-Id: <176604334948.837916.5544634528057993616.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 13:05:49 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: o0vopI3os5NSOaCnPgOKmc38Mj10Mg4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA2MSBTYWx0ZWRfX/yegK/7OEFNJ
 eGiPMRRgXNBxvtqBjgI6uAQmvPjPH+wLEmNRophxluh8BFQ9/TfKaJ+Bp/YhRT98QJVM0ScG1oM
 CMUPis5f0lmxj4n8o5fJXHCADaNapVeoUXb0pign+uEDk9A0R1GfH1BdeEu0RJJNU4zI7Uf8kPD
 sEebYf7L+psNYHGGbIAYsYb1QiKHzK/bfsUpZiv3ynb65DePx0b0tl93AbcEi2/VBEKJjoyW4qJ
 95iNsLsSv44m0pIcsrMdhvMUhCOKA/bgffpMBpTAH+43AkMg+l8bEtGw6joXv0vaozXz5m5EFRK
 QJRNVeXmHBv3XUvsDOpxP090wMGwmbbTKuPaFMf1V2yILxqNuDa6s+ge0bsk/qjqMSokEjjrkWU
 +cTy+FiTaVNWIx8/iXqCAm8/ArcYeg==
X-Authority-Analysis: v=2.4 cv=TZebdBQh c=1 sm=1 tr=0 ts=6943aed9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=15xY4BtIdfvhjXbsFDsA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: o0vopI3os5NSOaCnPgOKmc38Mj10Mg4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180061


On Sun, 09 Nov 2025 22:59:39 -0800, Qiang Yu wrote:
> This patch series addresses issues where certain PCIe Standard or Extended
> Capabilities are advertised by the controller, but not fully or at all
> implemented in hardware. Exposing such capabilities to the PCI framework
> can lead to unexpected or undefined behavior.
> 
> The series consists of two main parts:
> 
> [...]

Applied, thanks!

[1/5] PCI: Add preceding capability position support and update drivers
      commit: a2582e05e39adf9ab82a02561cd6f70738540ae0
[2/5] PCI: dwc: Add new APIs to remove standard and extended Capability
      commit: 0183562f1e824c0ca6c918309a0978e9a269af3e
[3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is used as MSI controller
      commit: f5cd8a929c825ad4df3972df041ad62ad84ca6c9
[4/5] PCI: qcom: Remove MSI-X Capability for Root Ports
      commit: 7c29cd0fdc07e5e21202fdeed0b63cba2b4f10c6
[5/5] PCI: qcom: Remove DPC Extended Capability
      commit: 6a1394990902f0393706d7f96f58c21d88b65df7

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


