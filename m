Return-Path: <linux-pci+bounces-44182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8F0CFDB9C
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 13:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD9693001821
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E0322522;
	Wed,  7 Jan 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mclLOmd+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XlQZGwjG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C5320CA3
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789342; cv=none; b=IL0cJ9YAJatJFzGR0Kka4++LBdCzzpy6nruaZqMEZOggb2w71D5pMkMkCx6XssqFzsEZKl5AWGwxTBDhUOszAOpXHJ4AnA0nYXKftPdO2v/E4xrNsfNOV14OE90uQxQ9mnZq6CCTaZ/zs3+iWF21zy8SmjEOFQ7RGjoZ2K7AFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789342; c=relaxed/simple;
	bh=Z3/xgfDcR9ktiH/1Lr6yEevZOzIdj4I2wJegVeEfRBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GDNIZjbTf9ew/BtwA5CFzC/ZBUcV3xy0k7XfCDLC6FPiJgCCS7bu93GMbbjuau552CGKHEWEfQkFD2duPIw9q9rjd20WKOMcKdTYiioP+Mwh/ChJDikMbEayR9TYeXVqKgKpjmof+fh4az9ozK38qW/HzDDLpefFZFHfdnv6+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mclLOmd+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XlQZGwjG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079q5bK218415
	for <linux-pci@vger.kernel.org>; Wed, 7 Jan 2026 12:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bC0wC25dWX1u9h804y9npqlSPE9Pd9D9e+NxLaj/2I4=; b=mclLOmd+Va5hvkJq
	I73xotDuEPUPz/8m5HsSnCU2taxUQmDmbgWwX2kQiNnHkhINHy4wAu/OF8+lAHj6
	us43TEwIv7ZhVpfrB1Se+qnRMlQZl1iCbUaZR/3eHNGfAsFuqqpSUUS96cDuuUx+
	ZLlHwR0Brvrg+1PbspBuw8bdVWa/DHSW32cuEz8IGNlqzF4XHbJqoPX1SJXRRUXz
	Fjy0QqYySQOnlI2zDl6f1WCC9W4NtsUTogulzaqgBP6xP24vdlN5szN2LZZieHAj
	/muaIpc5NfmykX6B/YGgwvXn/3ST1QLhP6EFkIX0vw2Y573ssJ+AhZ0QWCs3/Olv
	PGFzGw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn808ej9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 12:35:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7d5564057d0so4557132b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 04:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767789340; x=1768394140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC0wC25dWX1u9h804y9npqlSPE9Pd9D9e+NxLaj/2I4=;
        b=XlQZGwjGxG5YenVFmIu/3eDb2V00tLRTBuxwOqBeXMhYWkzLI7e+gS75qHILGs1rzd
         SMqTItWoiE3KR6BxbIPf1rZ1S6B8ohKSc2hFnwVPcDLkI/3No+x55umzk98V675Glqwy
         2hSxlzNtTbU0+jO/ekIhAcaS/FWWOIFEdLqgt91wFK0O6GQJUX0FPRP7+jWuHyEKNnt1
         NWQqoBFVBXMjBr54r1mclJk/OZPSd9Pr5Y3/R0x5HKaJBpbz0m7gUm0wWZPPluBbMYKy
         bZ9/Pstlhs4OLQFG3XYLRFUPjeLlC6CZIOZxRxvUwMe0U/ux1mIZXdHCiPqFkcSIzJmH
         rB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767789340; x=1768394140;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bC0wC25dWX1u9h804y9npqlSPE9Pd9D9e+NxLaj/2I4=;
        b=Dxa2CUzNM6c1K8K8t4LrOzOyo6jc4mMCFwfeRO68VrNaVujEYr1jyO6I3uDCpiQrh9
         eSDTv99Cg4GoOqJK3hguKq4E24lYyQsomoblYfa3cFVVyRj+084yP+K+mTcH5ak5t52Y
         cE9g2vp7UpfJcRrHx1Zr4rmFpITlsfSW7B+hqe2OB9PFdiYrniKsLI/mzynAFYwyCqD7
         hz8f4yvrbWehPF65rAz24CGMKoY2HbNOWm0f43H+TGADKYtzzkMjz5odkPkDYNPuzLNz
         S+81WZ+hSx5AevF+1Fgh48PkSTFZKloNifb1CBXnMkmZeRCXjV2dBJ4obCDcdBUsBtxg
         BYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXugoHUrPPAvqP88YmwMJGnlVMiIDVuuqB+v7j7YmRQmnrRpxdZompK9H4bH9F5SbvQ9XlEK+N4Dbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2hn6mC+4zkzQRLNDS11XaMrZEgq/jPU1UPtFoJL7jpTyZs1z
	/ByTMLCJq68oKnrIZ98vNEoK+TgTdK4UofV1fgyXe7OWp1HOJCvdToxQgKJdwrJDIcxrY+ogxaw
	YP/AzoZff/4YD9c60Qu9g4Cahrc9xC7gh+2nXflDckbixuXabsx5fM0fWa6UfREw=
X-Gm-Gg: AY/fxX52Ut2jaHc+dlF+CoRUhNe0pBv7rj1oCqAREaKrO5ODhTnmnVQRGOuOnCisIiZ
	WQy6uyKEz4OWNrnNSeFqUA6Mesqt53LdaGOAqcnP51XvuiIoqdOEbltffC3SZcVVP2SJMJRaQpx
	rJ5u5iq9HqM/pWqEPYFspXe1POTfu4XiDmL6FwHcUJUM3XepBXe1xDvuAWhXkN8Knck6nYXdKdQ
	t5Vb0eV0V3WVB8summ7HljAwOBE6WHjfXpUiTSlH7AmRU/PBjH23O1/z1yafeeK791dQxk7amEa
	5fji61DLtFpeu+vNHCfLq2+G30X2xDSw4XP4qzxQ/Pmwi+oSlpxw1OZXn48qTKxOCUQ2GrtnrKu
	cSj/ctUQ=
X-Received: by 2002:a05:6a00:348a:b0:800:902d:9fdb with SMTP id d2e1a72fcca58-81b7d861859mr2145557b3a.5.1767789339623;
        Wed, 07 Jan 2026 04:35:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH93fKUDfasuP5q8gHkOnrMUzHklFoNL76RVcQSiBJyvyfD7E4zZeOiwuGWUMy40Gzp59Romg==
X-Received: by 2002:a05:6a00:348a:b0:800:902d:9fdb with SMTP id d2e1a72fcca58-81b7d861859mr2145512b3a.5.1767789338774;
        Wed, 07 Jan 2026 04:35:38 -0800 (PST)
Received: from [192.168.1.102] ([120.60.59.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e7c16sm4940286b3a.53.2026.01.07.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:35:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Sjoerd Simons <sjoerd@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, netdev@vger.kernel.org,
        Daniel Golle <daniel@makrotopia.org>,
        Bryan Hinton <bryan@bryanhinton.com>,
        Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20251223-openwrt-one-network-v5-0-7d1864ea3ad5@collabora.com>
References: <20251223-openwrt-one-network-v5-0-7d1864ea3ad5@collabora.com>
Subject: Re: (subset) [PATCH v5 0/8] arm64: dts: mediatek: Add Openwrt One
 AP functionality
Message-Id: <176778933103.573787.15149542478385360900.b4-ty@kernel.org>
Date: Wed, 07 Jan 2026 18:05:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=OtJCCi/t c=1 sm=1 tr=0 ts=695e531c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=jZ9eb5YeB6VHmQ1DXVOWBw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8
 a=w7wmWQyBmLUzaIw334oA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: yV5maw7TvxEFyMlA_lhjHk7rK0Yi7iwR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA5NiBTYWx0ZWRfX0k6ecr/kcNdN
 92DJPpGLkPfxIa+IHftb7JymOxqzqM6KIIqFovTmdtVPWvTvEoUJ6XErJq2jgSfiRJZxfZpsDx8
 tV+/7NPunK1bakKTeY88GfavXOTkHzJtUuThhsUBxHFRLw7Kda23WiRMFwiHvKS5KG0wmw5f0dl
 WemK9Upba+74B9KnGsjdG/49JZxV5iuBskQ4l6Z+7iun7jBUyHUToAmq8Z1FvSbD0PSZawSxdvz
 dHJIJrm7zQIWCii5ndcfWfim8aq7QUjAKLT83Oocy8Gp4zqZ2uuG095INXk7TGzt6NtiANT9Uq0
 QM4F5/5tu+3sEa7ea/pkJrJbVJ3RNEAUhJDISUHqntwQ6rNka9BLcjwCquyEaGqzRSbSK3ffYpR
 TsO8qJldauV7FM7DtMlprsj/oTboh5KshLHmtr1OFuznSzOi1nWwFsTHDTagTWT8JGpkgAJwuyx
 QFSLPvwezn5+EvAxvMg==
X-Proofpoint-ORIG-GUID: yV5maw7TvxEFyMlA_lhjHk7rK0Yi7iwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070096


On Tue, 23 Dec 2025 13:37:50 +0100, Sjoerd Simons wrote:
> Significant changes in V5:
>   * Rebase against linux v6.19-rc2, dropping merged patches
>   * Drop note about disable pci_aspm in cover letter, not required anymore
> Significant changes in V4:
>   * Drop patches that were picked up
>   * Improve mediatek,net dt bindings:
>     - Move back to V2 version (widening global constraint, constraining
>       per compatible)
>     - Ensure all compatibles are constraint in the amount of WEDs (2 for
>       everything apart from mt7981). Specifically adding constraints for
>       mediatek,mt7622-eth and ralink,rt5350-eth
> Significant changes in V3:
>   * Drop patches that were picked up
>   * Re-order patches so changes that don't require dt binding changes
>     come first (Requested by Angelo)
>   * Specify drive power directly rather then using MTK_DRIVE_...
>   * Simply mediatek,net binding changes to avoid accidental changes to
>     other compatibles then mediatek,mt7981-eth
> Significant changes in V2:
>   * https://lore.kernel.org/lkml/20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com/
>   * Only introduce labels in mt7981b.dtsi when required
>   * Switch Airoha EN8811H phy irq to level rather then edge triggered
>   * Move uart0 pinctrl from board dts to soc dtsi
>   * Only overwrite constraints with non-default values in MT7981 bindings
>   * Make SPI NOR nvmem cell labels more meaningfull
>   * Seperate fixing and disable-by-default for the mt7981 in seperate
>     patches
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible
      commit: 407cc7ff3e99f6bca9b4ca2561d3f9e7192652fe

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


