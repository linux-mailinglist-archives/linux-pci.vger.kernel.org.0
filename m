Return-Path: <linux-pci+bounces-25346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF3A7CE7F
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABF43B070B
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37921A931;
	Sun,  6 Apr 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mfar+Lwc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Q5By991c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6F218AB9;
	Sun,  6 Apr 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743950955; cv=none; b=kF8pphKYQHmcJv2C+ytBtXp/iWMMt0zSp2DR/AwktueBvEwDt58JZIzP5iDbUDzvDE4zvSDzcw/1jNFfV99KFNM2/uBYclRotw4afQHbyPc3+oRLi1bQ+LoG1Fff7hOywzDu93te4FeYu8SiIF9VSuIrPrbXShr+Mi2Me4MOGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743950955; c=relaxed/simple;
	bh=2SVjBHfQPMSyum+zL3BSBpl8rwR3boROJPhbF1uSoFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vj3EbRrHphpJifn/G6J+LxS1PkFP13CeJ8Nhn7o0DCIQ0UPoMbCaVzN16VgGJnD3IZYwkEKpM9lwI7NHWhT/SwJkcVY656p9vYYgwsW6Fy7RwVlEmm1Bnohea5GT4QCgRwzPH3AtqxwOuEH0RoFeuS6G1JB2IAV5TiDmZ5lLUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mfar+Lwc; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Q5By991c; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZVwG94DQTz9v5Q;
	Sun,  6 Apr 2025 16:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743950945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZfk8RedLxtNCRcmkK7zn9ngWF+gdEznqP4g7JRtTIA=;
	b=mfar+LwcHRFAAtIJakws9GLQUAKJL6p4GuUjpDXHMMu4dqt3G9c+ziKhT1zztKCavyQFlc
	oD1TuhQmpmPcU9rjJ4VWH6pJ8zVsLjcX6TCH8S0TPKQmcHJRPcfTTK6FOhyAVcf/uP7QqO
	uLgGtyr4+P9N+J1a4WpSZpiFqnaLX4sGd9G2HsJJsxKFIddBEWuc3/24vILjpE0IfPnyaH
	t0Vq7IJAWbQCLrYTlM/ms2hWtbHYisFPL6DpcCAFiZH92rOdaqTIvzQPmb/E7ZEWE5epk6
	o6CUEuIgTWgvnhRk6DbiaE+heriE5R4lotjqI06vUtEbC1agTZI8kM8OHef6Aw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743950943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZfk8RedLxtNCRcmkK7zn9ngWF+gdEznqP4g7JRtTIA=;
	b=Q5By991cWEpFyGc0WcGeB+yCJHOfB9nkul/mqE93eW5FDMfg/KQZfF297oATa24l5CDLQ1
	LUX5MjnDhBKIAf3xaNuu3z93uwTw2TR9DRXv2KnSik0FVCyD3H1bovvd1eHnwk+SqXSy3x
	eBe7KADGE5MSaSRCTwrmVQ2DX9/h2bfOGyEMR0AWEXtTJ02IC8I81UC4X0hx32zdAaIvYD
	oPgI9hxH+IXqzyfkWv0QC2JtrOY360uQtddKP7BAsqj+0nLY3dJMfDz8u2+UWENeO09sa7
	0h1s5kteuqdZGJjv0tEvmivAdfN5imZp+cXd+XzynE2+5ggj3Zr96FcJQktc1g==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
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
Subject: [PATCH v2 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document optional aux clock
Date: Sun,  6 Apr 2025 16:45:21 +0200
Message-ID: <20250406144822.21784-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
References: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dbb51fa08f898da8fea
X-MBO-RS-META: k4sadesb9s9f6djnzfhmuzp6g8xxmzxa
X-Rspamd-Queue-Id: 4ZVwG94DQTz9v5Q

Document 'aux' clock which are used to supply the PCIe bus. This
is useful in case of a hardware setup, where the PCIe controller
input clock and the PCIe bus clock are supplied from the same
clock synthesiser, but from different differential clock outputs:

 ____________                    _____________
| R-Car PCIe |                  | PCIe device |
|            |                  |             |
|    PCIe RX<|==================|>PCIe TX     |
|    PCIe TX<|==================|>PCIe RX     |
|            |                  |             |
|   PCIe CLK<|======..  ..======|>PCIe CLK    |
'------------'      ||  ||      '-------------'
                    ||  ||
 ____________       ||  ||
|  9FGV0441  |      ||  ||
|            |      ||  ||
|   CLK DIF0<|======''  ||
|   CLK DIF1<|==========''
|   CLK DIF2<|
|   CLK DIF3<|
'------------'

The clock are named 'aux' because those are one of the clock listed in
Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml which
fit closest to the PCIe bus clock. According to that binding document,
the 'aux' clock describe clock which supply the PMC domain, which is
likely PCIe Mezzanine Card domain.

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
NOTE: Shall we patch Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
      instead and add 'bus' clock outright ?
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
V2: - Add TB from Niklas
    - Document minItems in clock-names
---
 .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml      | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index bb3f843c59d91..528b916fdb99b 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -46,12 +46,15 @@ properties:
       - const: app
 
   clocks:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   clock-names:
+    minItems: 2
     items:
       - const: core
       - const: ref
+      - const: aux
 
   power-domains:
     maxItems: 1
@@ -105,8 +108,8 @@ examples:
                          <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "msi", "dma", "sft_ce", "app";
-            clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
-            clock-names = "core", "ref";
+            clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>, <&pcie0_clkgen>;
+            clock-names = "core", "ref", "aux";
             power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
             resets = <&cpg 624>;
             reset-names = "pwr";
-- 
2.47.2


