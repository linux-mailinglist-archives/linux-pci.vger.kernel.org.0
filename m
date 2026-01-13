Return-Path: <linux-pci+bounces-44604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC1D191B3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D8403010CCC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 13:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21707346AFC;
	Tue, 13 Jan 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c4cvxJbI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H0p4FW/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839B2C08C8
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311158; cv=none; b=BTEtZka1UIsZcrAdNdhET6hOh5kdMGmGRAX1hYgWKaaCbx+ScruFPZpk2BJlEU2043xsLPgPfzQHfr09fubWFLBTB20OWqnzHPVd8O8t0fOEBWozCRVFpCWoZ3L5bUcbjqPD1SW5m8R93gbY4UogWqjR4+1d6F1Exlg1dQmF6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311158; c=relaxed/simple;
	bh=iaesIPrqbVwJjFyXUeP+5jmVglPcQj+vLOMaszr3DJ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XHhFBNHt50RNAFNkW671fdF7j6WrU4O67/nxYbUmAG0TTA/TyoUDpg7stj+AdJXqeS81btow/Cz3twF22z0Z2p7EJ4t+Dz0wx1eJZLZT5qIbuNEQa3jbxEuvaRkIvH+b55LBHeg9iVoSBu705fwgFoBUJffxg9AHoYJ7+5TAX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c4cvxJbI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H0p4FW/o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DC9Sc53637551
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 13:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E8TJC1xR5qwjZdXuz/Ki/VwolLGb9COznW5/ec1379Y=; b=c4cvxJbIr267S+mx
	bxPq2sXOacnTkPP+w81iECdR2hCE5raPuh2mmO5lrX6G+xNqXep4ikcTC1WAK48Z
	roLTQ7S31cud5mfDw+nNPy+hgfdT+1rceD46EpMiwf7txhVXixtk4Lesx1t5cMBP
	8f/dEYPw5HgUUV2wtj56gjTA+Bcj7TzDKXH0ZdbwMT0CxROfkxsZlcq+1aEsgHi3
	LaCenOHapmi3MhW6VQpro1OSOySXf6PVC8xJsGqHeNBOovKvKDEAKh/mC9ZRgpNO
	8cVuqU5Pue22bncGpQ/grOy5kER/xZnYnUceiMzUh66hCt/BrxzvvynagUD7U5Z7
	mf39nQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng2c1enm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 13:32:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a58c1c74a3so8091315ad.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 05:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768311155; x=1768915955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8TJC1xR5qwjZdXuz/Ki/VwolLGb9COznW5/ec1379Y=;
        b=H0p4FW/ovOv+FSX2qct/AYqOgjza0EoPG/JBemBw01EkHBPhUxS0eiw7Y8f7YhNTYT
         2p4eH9uHdGO4P9YTnPccHsFLweC0m276wToXmvRB4RoBS3bm9NeOUT5mubfd4ApwpgeP
         7dOyBbsTpBt+jf7X2begVu4gh5WUtVNRixyRkojeUsEjZJ3OgaVSYPSGJ/71US2vWT7q
         vgY6oVf+qF6+Sd1f/vMnxR40cMxE8DWG+eOM0uPukuo20SPj67XEbnCEb/x1le1rwRok
         mTGfJ63noX1js0VKbDTx2ImqkkCj+XOnlD5yZjt6zTxAbMkVbigzwwm5/v225jQHdF6o
         ucqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768311155; x=1768915955;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8TJC1xR5qwjZdXuz/Ki/VwolLGb9COznW5/ec1379Y=;
        b=MOz+RRHqfy9BNNAb7to3YshJY91HdcXwyW2YLvAIVuMdcG/CTRDhJwQKuZ/Ikozw7t
         qvjQ7GSxvbvMgYV0owK23uCVgea8nIiPxqsdpBUi+eHyiXWLYyyMxqzx/fft+Lwd44DQ
         1Gm8L0vUr7k29C8kJleo1iWkp+V+i9KigMUU0RJJJW2rooENVQvL6EJADFY0RxzU7fMW
         1kzTarwdIDAydhjuJ5OWsf/Ow/350u8gzdbGgMSL42bS3pC0EFHWb9wdeNmspQjMY/RR
         jrWvkNI7kgdBmOuowQaD1GAwxGJr9hIUm41zuEvz97ZhfPgHENh5VglNWIACXa+SC8Rl
         6IqQ==
X-Gm-Message-State: AOJu0YzivccQJSXLO0D3kQIsHWa74sQMov+uAXKEW94lA5ogJV65MSX8
	O4IFqLcWnjTWfmHhl+dqBpuUmvIlIeJFWNjJomkF9R3FYKmGLU0nf/5n+anZknmY+WFN6st7L9R
	GX99bxOQyY0LnWoB0QDPAvMZpIfhlZinFvMk3bNegLM3vxAv609P17BKelcYwpek=
X-Gm-Gg: AY/fxX5pvUO72kUiAtpN947kOhH6rLUt3+/QeIhK33r5k4iBTnCdbYowqENpNtuP4cX
	Df/cBEUWzmxLQWOw423zFul6o3ubxjkJMO2r2AuHva4xoYdtULErc6dp2BsWTiQs/MNDQgIRxSt
	t/vMjZNDtCpUu0OJNvDFmJCjfoatZY08phbgLs9GroohA2mYVNS7A7oOeOzxzSsBt/YIyU54QCK
	1Oww8y5BoM/4WXaIjN7UmhL8Z0ZIQxk2aRqB+csSNcy7Q8BAKM4go6uMlJLRxcmExjScKqFtynb
	kmWMlh3GceiK8joAvxJenwoGc2HNsr6JtJ9qYRsqYvRsBXt/EiEEimsBgQ/lOXXX5y/rzRsCp1O
	IJTKlLC8Q
X-Received: by 2002:a17:90b:3a8d:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-34f68b65de0mr18289152a91.9.1768311155361;
        Tue, 13 Jan 2026 05:32:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQSeTTC0e5zR0aZPRVtYeUvCiFIncOpvm5d1GGOQzzdJx+WVyV1lsQhT267/6cpb7RuZ0E5g==
X-Received: by 2002:a17:90b:3a8d:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-34f68b65de0mr18289130a91.9.1768311154759;
        Tue, 13 Jan 2026 05:32:34 -0800 (PST)
Received: from [192.168.1.102] ([120.60.62.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa78ebdsm19939128a91.4.2026.01.13.05.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 05:32:34 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>, Yao Zi <me@ziyao.cc>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
In-Reply-To: <20251209140006.54821-1-me@ziyao.cc>
References: <20251209140006.54821-1-me@ziyao.cc>
Subject: Re: (subset) [PATCH 0/2] Fix LoongArch dtbs_check warnings
Message-Id: <176831115031.476677.605007474581802284.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 19:02:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExNCBTYWx0ZWRfX3H3Nf2J+K+S7
 xRtODu0+Auuv+9p+MtuyKPvSPVHZ8j5Mjbu9U29yjF1YZVx0VtudHbI1hOI8HU0tInZvuqJlnoV
 YngIhrezOhh1gpcE7LYy1fkmIt2yE5tHxPikNclCUsIfnDGtMzOn6hjzSIRFR/1tSgXXxdYOKIm
 TQiJFbC3F6LMlLaAgJoFjFy3uoZ4KUZJpCkaN/QLss4Ixerx0SXWACTlfaDqf+QrNbc0YJuGD7O
 HXfE7BeSeYzEtkZwWeUFCDsyU3WQlSAe2k1ldI8y2OYB1ulbWU4NYFokZvkX87Kd6hSoTWM4DxB
 EGQkjWrJC6mAz7ieMXLUcUaPHzQWMyfoTpgZAiiNkQST6FfWMxvV1Wkls821ntR/4Onx3kIhemI
 3lJMRwEiRX5GmA/JALaHy8scn09JufSk/20NwA7CEECegL2fIPG3pTObt65J92dGWLHztnrSFfE
 nFPLvU9IhB7G0kwM60A==
X-Authority-Analysis: v=2.4 cv=C5TkCAP+ c=1 sm=1 tr=0 ts=69664974 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=tlgrONNCw2HA119KiuRAjA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7KmsL79GNCPbkX_oTsYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 1B0zVKlS4istuV_ZiBLDwOuFHPrTUz4w
X-Proofpoint-ORIG-GUID: 1B0zVKlS4istuV_ZiBLDwOuFHPrTUz4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130114


On Tue, 09 Dec 2025 14:00:04 +0000, Yao Zi wrote:
> Running dtbs_check with ARCH=loongarch emits a lot of warnings, most
> about describing sideband interrupts for PCI devices through interrupts
> property, and usage of undocumented msi-parent property in pcie
> controller in loongson-2k2000.dtsi.
> 
> Patch 1 solves the former problem by using interrupts-extended property
> for these devices. I don't have LS2K1000/2000 devices on hand, so
> helping in testing it will be appreciated. msi-parent property is
> documented in the second patch for Loongson PCI controllers.
> 
> [...]

Applied, thanks!

[2/2] dt-bindings: PCI: loongson: Document msi-parent property
      commit: d782e6e7aa798a2c28f30f984ea6dcdb63f51674

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


