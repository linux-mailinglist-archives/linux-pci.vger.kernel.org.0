Return-Path: <linux-pci+bounces-26311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47093A9488B
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 19:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08E1188EFBC
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C73220B812;
	Sun, 20 Apr 2025 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="THhdTyyK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DGfWaqCR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AF1E991A;
	Sun, 20 Apr 2025 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745170770; cv=none; b=i6AiqJs+Yx0l5/zN7zJpTbMCSJyf5SFSeloibEsDGRYQyYg+2nhjgp1Si/EKcQlbnZ0yS0tmBedNJ8D2NhgcI2sx5jYju59VEiDJqzatb4PeMorZr8dM1FPTrMOkf9Y+CkG8Xcgx2I5jB/jUVaZ73jdsQQwvogkS6vTaxag9mnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745170770; c=relaxed/simple;
	bh=TW9Jtl60AgYvjUyXlVJa7j16Ky2ZLcA0QFeNX/9VaVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDkDwnCoiTubW0d5oaoP1Jgix32Gf+exn9rsZ7IRMI/S9FvPo7drXfMa8K55Gcak5kPIig+4JBjRGhIR1uTCR/8t0P9sXyOe3sjQ8gmxzOO661xukoRLFMKpujEGC+ypQfWc032/XQanQgMyRGE9o+FmqhbpbivGwDgoGAZu3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=THhdTyyK; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DGfWaqCR; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZgbN84NRdz9tXv;
	Sun, 20 Apr 2025 19:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745170760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycNAhVHWprcmlx0NXKu/950Cj9ZtnGPvQSTzBEdE08o=;
	b=THhdTyyK3/5qfdfEg/XowqSZGbKcRCdTnSZXIfUIbHIRkWOiLD7TnI3OuyV4rTab8vnhT3
	H97/R08gjpeJ2fR6383yoLhmk7ze7WbpK2wMFW4tWUbY1sUv6MfuFQjcrRAioamvzPS1Gg
	VcloEL9g6FORTQtkSzhZLUeUNtRtv5/mRlLASm6mhySDwr4bSfj/CyGqye3jktKodCf/PF
	7LPOmfBJTgYQHndZSZs8uauCseaS13lIx2RnB1ec/uLykUUleIQxFR+bc/M5HuqV/T0v+c
	5Wwt4MWO2+E1rQ/HrRjMZQGPsGlkeHY5PZhFMFuuS1vI6nchT4q4hjpbxvBt6Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745170758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycNAhVHWprcmlx0NXKu/950Cj9ZtnGPvQSTzBEdE08o=;
	b=DGfWaqCRZZ5cgG2HzD2XJp47rEMoF8J52aYSGQKhX6DLS+NCgZrlPwAhZ3JZmDyw0ndvbr
	PiLaQpji5y+DF29exHvDOKYQOdvbvU80pnRoT/OpvBL71X9v17b8j+YF8Bul+d+G06XRno
	8xMvxi08lffMJhMjShdWLLTlucWNSGWfOoM4xkAzcMzxkMofg0xGkHwYJ25TyjM7srN9hu
	9rcv03htdjGMIWQ4Z6wuhjbd0bAjupNxbdrUS1d3h2d3XuOTF8UHj0LqdpHvu0nOSTJlFp
	tviTaw8uP2ciK/AXm4t2BpKeV6VmBXNaML1cZRIaIhGYJg9F6k69o0Wl3fKQjQ==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Junhao Xie <bigfoot@classfun.cn>,
	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: soc: renesas: Document Retronix R-Car V4H Sparrow Hawk board support
Date: Sun, 20 Apr 2025 19:36:28 +0200
Message-ID: <20250420173829.200553-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250420173829.200553-1-marek.vasut+renesas@mailbox.org>
References: <20250420173829.200553-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ffqcsgydgpipf78ye5gg7qhhp65tap84
X-MBO-RS-ID: 1ce5a253f8c40f34f9f
X-Rspamd-Queue-Id: 4ZgbN84NRdz9tXv

Document Retronix R-Car V4H Sparrow Hawk board based on Renesas R-Car V4H ES3.0
(R8A779G3) SoC. This is a single-board computer with single gigabit ethernet,
DSI-to-eDP bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports,
micro SD card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD,
debug UART and JTAG.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: "Rafał Miłecki" <rafal@milecki.pl>
Cc: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Junhao Xie <bigfoot@classfun.cn>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Add AB from Krzysztof
    - Add TB from Niklas
    - Rename {Renesas,Retronix} R-Car V4H Sparrow Hawk in commit message
      and update R-Car V4H ES3.0 to Renesas R-Car V4H ES3.0
V3: No change
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 0389355b9ecad..3acfb835dd375 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -375,6 +375,13 @@ properties:
               - renesas,r8a779g3 # ES3.x
           - const: renesas,r8a779g0
 
+      - description: R-Car V4H (R8A779G3)
+        items:
+          - enum:
+              - retronix,sparrow-hawk # Sparrow Hawk board
+          - const: renesas,r8a779g3 # ES3.x
+          - const: renesas,r8a779g0
+
       - description: R-Car V4M (R8A779H0)
         items:
           - enum:
-- 
2.47.2


