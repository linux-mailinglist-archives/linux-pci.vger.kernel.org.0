Return-Path: <linux-pci+bounces-24991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29368A75C10
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 21:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9805F7A3654
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5591DEFE4;
	Sun, 30 Mar 2025 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vxch+Ql9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H1BpsCWV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60531DED47;
	Sun, 30 Mar 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743364724; cv=none; b=uXeJsNKuoWLQFBT9yEwcr983M54A31HLq6OJQnQ/XCZV22MX1kFcwe0kJ9S+/hCnKcH5SQPTCoASDJNwPoG90mV/Ik41HDDJH9jlAiX1VBuSxprZdsi0jaxs4qas60WISm7iZY9mSAS59Xh9EQYT3yJLMRDyQEqIrBvfsaJ8QZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743364724; c=relaxed/simple;
	bh=ySdr8I/DstDADLCiLnooQ0omqDTPN5vhEgIktUWV3Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQHKXPgb2P7lwHoSVROisixrAAGcJWX7pL7Arj1jPaim95fOvQMpXqv8TOCv6/DERodGK+uHxrPfpt1JCJSJ/mzTby5tuJh02Ykv+IdEqYsqTKnxdXQBjO5xj0yV+D2VMQ3cmgcuMyDaNbQwNRChE2Wzm0YFu0A0utjscK4IKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vxch+Ql9; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=H1BpsCWV; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZQlSS5x0Mz9tMt;
	Sun, 30 Mar 2025 21:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFYNJp1q91kxPG/H+VOGMsvd3pVp9apafCx8eaD2V3Q=;
	b=vxch+Ql90wwi2KwUc+3O1anRnVoHEhcEBabr6VOPgxsWbtPt8cr0cLTR6i5gxh15mXmqlY
	NBYVMANACNKeYKLgJ2bLaH/tCg/e8Q9MRMmNcOWIPW9KKjynqhf8jIE5j0onMTFwYZPHuu
	RyzXhEOr/yoyDaWnSQEJ8PHxM55RgGjlI4G80oSE6yUBLW3QvNdEKInUKM+NVlqVv6kZxQ
	qaVaJRYHJkg1hQQnYoFCUDuwWNWU/lUUONb3IWlcLrLNOGeG/LYbWojeoX4hC7TzS1Vm3Y
	yyZAd435A3ufqKH8r+KjDDyvI61NTSQZs2IeVTaSGZBZPnXJ+F0N3Mujsmkbtw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743364710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFYNJp1q91kxPG/H+VOGMsvd3pVp9apafCx8eaD2V3Q=;
	b=H1BpsCWVtiHOp7/LzfWsgrBCWkUEZlQfXHArFOx0zWI0n0VLK5XB43NArNE+2jqAYxrGAK
	pKcna13LpqHs8J4IpUm2xq9bndH61nOTmlHBcNebkPnroxkjSeMLlt0L80c7esvYS+W5jH
	7sftrJ/J/2yjDdbdv13F/niWXoNlaI6+qfKRjRLKbLWCrE4Yz2ifFTtdC6KpjH4HTOTuzl
	TEo1yCVUzKm5gTdbR6KDs6mS6SuSuDV70pqk3EJmRMOVNlkxqWFLoJNcm7Ur6II0hN8lDp
	BSR/cR91bBgBYEkjEWro1lUCx6c+01mHFUeUQTJHxgVaZAXwtOBF7MExogrcdg==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
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
Subject: [PATCH 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document optional aux clock
Date: Sun, 30 Mar 2025 21:56:09 +0200
Message-ID: <20250330195715.332106-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ftkny4rcrcptq5mm8d8hrq8nw5ziwthm
X-MBO-RS-ID: 55d868de086f88903b8
X-Rspamd-Queue-Id: 4ZQlSS5x0Mz9tMt

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
 .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml       | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index bb3f843c59d91..5e2624d4c62c7 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -46,12 +46,14 @@ properties:
       - const: app
 
   clocks:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   clock-names:
     items:
       - const: core
       - const: ref
+      - const: aux
 
   power-domains:
     maxItems: 1
@@ -105,8 +107,8 @@ examples:
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


