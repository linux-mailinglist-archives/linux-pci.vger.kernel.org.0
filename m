Return-Path: <linux-pci+bounces-43600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11691CD9E0C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 16:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4799301FA76
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA557289367;
	Tue, 23 Dec 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dY21izoQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YO7N+BLQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34820275B06
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766505517; cv=none; b=s6HU5qH5MhSlCLM4NglX5P/XkzD6WRGReOkHEFYeqKh/qXhOUs3SxfZKYjjxGdVVePIfRmNDNKDB0F5bKmpxG1GwJakgh69o8ntfr3oJpv8Z3GDs34NxIwaxOkbeL0zfC3fJ3k5Wks95PBm+4f0wqN7KFhf+Uh9175JMfd2KjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766505517; c=relaxed/simple;
	bh=Mtxd/iv3yMWlETS0+3baJ1bxVujZ3ZziEvgBz2Az3SI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J6Ad+NtTD6Z+9FhBmu0+pbooSNE98EyTAbCyz44S2FP8E0wewTi93CIJHxEfuwSmdV2nlfHd03YG3x2f2p7smQcrLCpO/pdaIoe30AEYbOAuitl8XhOGkQdL857T+yp1xJc3GnQWHwAR8v4M26yePzHV+iZUS2/E0Wqm1fT8XWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dY21izoQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YO7N+BLQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNEsBDt462214
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 15:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jiVMsPmbQP7FZ38DNLit/HG1+5z9nnDnXvMaFIBjNjQ=; b=dY21izoQwZl3PUWu
	Mb6XE3I9EdcKQO8QjSqkx5MLvjiEwvp7/oOdtyn2XSuWlTf3zVnBSDfvpxeh+aLG
	uQViOdMN53cJFkPMxDxc7Tz0MrWKgjfFGwWea8YMW8CmOrD3Q9+uVH0+5tnsI3Ed
	vxfom/ISfZ5X0F9jEgVbRIeCNtAtVoQ28hzi3zolpSY+3CY1+Dtd3NVZJYHXipJu
	fTZdrdKIAAJ/Pd8qfzGX1MKPf2bTnUOKAR/WlTEpR4vdpBVwdecu0c2rn7UvVrN/
	YmCQbg4NE2gSVOFz90F80BXLJDXxr/mJHWJxz2cna19+/98SeU6WkHbCYNzBY/kS
	QCAYsA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7w8fr62n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 15:58:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a09845b7faso75166865ad.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766505514; x=1767110314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiVMsPmbQP7FZ38DNLit/HG1+5z9nnDnXvMaFIBjNjQ=;
        b=YO7N+BLQWnvWUmSdOmGUman1RzVjMDvi84p2xGPICkncZjMFCHnhJPukQ4GDwIWLQ/
         edbVicG+CRLeD4lccSS97d81ATOEBspudAMr9K7X5KcajhRqq9GOcNQr06pD8Nvj2dPf
         O+6HhEpJJZQH4zi58N1DWYckUKBWLNwvyVSixRZF0H+Y5RqHmkOVwUdNvXXKanHLE8by
         En8Z5WjW4T7ER2rWxQ3+rpaRYxwg51AR70iDSiWNCGvN7yoagXGfmcbSxUY0XDJoR2N+
         qvYzAZztsbVjEmomtDJui+r5pxSZvk/cs3nG5W8FZhXsWMMOfhvvT7KTFdyvJ16HLDgL
         fFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766505514; x=1767110314;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jiVMsPmbQP7FZ38DNLit/HG1+5z9nnDnXvMaFIBjNjQ=;
        b=cCtW87j3N1omCc7YCD689yR72F9QUR4R8pVoCI+L4t2KZhBe8VwQUbC09z0gCmOLn9
         axlbCcUJA9VuIuSDUo7CdAwM/pyn0pQMCFJaqcDDvuaxw6/QN2Tbs1l1I4WMzQFUEzuA
         PTYxSeaUD4B9gjptFhJWHe1wRxM86wIy52L+l/rDY2favxq5X0EuTT/URl82gXV8kYK4
         rRSu4o4o8iPm1LZmknlJZUvvEGrqCnlPvOCKnALWQLNdsxeW9QMKDBS9qzvmkU3oME3b
         x8dguTpoPYLpZ9mjpQ63PuS77i8QcMIW8YowKiP9IaBgs8aum8XGE2zEipMml++RjiiN
         BeFA==
X-Forwarded-Encrypted: i=1; AJvYcCVlcjwnoGoayW3ZmiMAEKOEXyfL6zolFWnIXeoOTcGF80Bn4tuyTRbJ6bqlttBTws0Ya7350397RbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4MXOU8SaG8GnWl+EkHt/1Gqf8MlVOEpE7CPu8FvnZXTdWIp9
	8lCKb5GnM9Vmt/qAvgDirOFX2b4HMTOT77X67Oi5Shih4b+6pc18wbAJTMSCnE7g2jzx0nBEDZ6
	T7O5ttF772NdMNe7EosIJEB428Gx6WlG+gfFYRyC36QAOBRSCDn+IYonF+tLNhwnVJ2t5amQ=
X-Gm-Gg: AY/fxX6P0OMM/f0hfVL7b7RPVk65J9/9ZfrtE7l31W/meDsCuvZibvGVhEhCHgwuY+8
	fF3g4qoK3Ah20ZMcE6xo4XXTcFA1UmpgqAm/0eQ1Ytm/recH/ATLKfibkG05MKwtsznupQw82HL
	g+UIHQqzAd3zCGT/Xliv7qRft5SIkPp+b4pY9WbrTM40pgE3QFAixevtRSvVowh17aDUvQa+uuB
	R3eNIe6v39RN2PjlKMxastCpXzAn3s8n8vtFt/fkpicCPI0RRts8nIyf2g7/WBXMA1ANrakulp4
	ZdXminpNIKA/y8RUr1pzmHKxUwMoByMPpolWFNZgReUQtGYzHMkLe6IbLeikENhmSBV+PTKULP0
	71liyO//wLQ==
X-Received: by 2002:a17:902:d584:b0:29e:9c82:a91e with SMTP id d9443c01a7336-2a2f21fc506mr163295515ad.7.1766505514309;
        Tue, 23 Dec 2025 07:58:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhayM1D+7Y1gHqun6N5dRaivrEs0mEAHPs1q25xLW/IAzFnLc7m+vKUO2bdvStmAZD+ZHRIQ==
X-Received: by 2002:a17:902:d584:b0:29e:9c82:a91e with SMTP id d9443c01a7336-2a2f21fc506mr163295255ad.7.1766505513842;
        Tue, 23 Dec 2025 07:58:33 -0800 (PST)
Received: from [192.168.1.102] ([120.56.200.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm131271795ad.100.2025.12.23.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:58:33 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jacky Chou <jacky_chou@aspeedtech.com>
Cc: linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org
In-Reply-To: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
References: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
Subject: Re: (subset) [PATCH v7 0/7] Add ASPEED PCIe Root Complex support
Message-Id: <176650550798.2188958.10356654881464455126.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 21:28:27 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: xf7v0jU5sqFdXkQeksP-acX_oQXQtf7S
X-Proofpoint-ORIG-GUID: xf7v0jU5sqFdXkQeksP-acX_oQXQtf7S
X-Authority-Analysis: v=2.4 cv=QutTHFyd c=1 sm=1 tr=0 ts=694abc2b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=31AEnvkI3DvSdtIumApubw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=oUgZFhhkZxxgqap4hUAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEzMiBTYWx0ZWRfX85LypFEZalMG
 f0qIDJ950Bh5OtPODS0MOgNrXGI7EL2D2+0E5FTWd3938oLgGsJbmqQw8FgIZrcRqI5XBOaffio
 L/y0UfK2oPpHjdq1ODuPakSQ7QoVHYXb6G5coaDDILmC6LAlSxLplyq5GXMySzEJeqo4d7MEQSi
 i4mgJLEjDLDRuDAGviBroZPL4m40W//bShCCYk7sw2YJj53dalSIR3GgGCsgkgTybQwkR1clLZI
 ubSOYtN2sd6spnq+Tdlr3U6TLWb15um9vfCFzjIMbUoSRtEiwjpAOaQT1eB+nmVImscKuA1l5nO
 9czesPg7+ST3LLIZUmj9K4qRKttF/yGRXZZf58hCZFGQpT3jI4ee3vLTY0LyqY3jo0rnMDqypVk
 XmOgMz9ezOkpaBL4J1I0p3x8m7kKtN/4MAY6ReIC6A6A+HFVP1+X/6VncvYqYKj3zchOIZEIH1g
 EcsBp9YciFLCtjirS7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230132


On Tue, 16 Dec 2025 09:49:59 +0800, Jacky Chou wrote:
> This patch series adds support for the ASPEED PCIe Root Complex,
> including device tree bindings, pinctrl support, and the PCIe host controller
> driver. The patches introduce the necessary device tree nodes, pinmux groups,
> and driver implementation to enable PCIe functionality on ASPEED platforms.
> Currently, the ASPEED PCIe Root Complex only supports a single port.
> 
> Summary of changes:
> - Add device tree binding documents for ASPEED PCIe PHY and PCIe RC
> - Update MAINTAINERS for new bindings and driver
> - Implement ASPEED PCIe PHY driver
> - Implement ASPEED PCIe Root Complex host controller driver
> 
> [...]

Applied, thanks!

[2/7] dt-bindings: PCI: Add ASPEED PCIe RC support
      commit: a20df1a7683d6c1416c0f56fb737554b9abe9959
[5/7] PCI: Add FMT, TYPE and CPL status definition for TLP header
      commit: 73ce5ba701a53ad89c623a641401288844f526ac
[6/7] PCI: aspeed: Add ASPEED PCIe RC driver
      commit: 9aa0cb68fcc16280c8c8bdd22dc770af8dd7349f
[7/7] MAINTAINERS: Add ASPEED PCIe RC driver
      commit: e5c2061442dda716fb08cc4eff485220c94e6475

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


