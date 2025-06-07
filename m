Return-Path: <linux-pci+bounces-29154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C843DAD0F29
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40703188F6BF
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 19:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7120FA98;
	Sat,  7 Jun 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="geA2P0Dr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sl5HztyV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55931494CC;
	Sat,  7 Jun 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749325587; cv=none; b=c6/Y4pr+0Tg2JohlSCCjGrbWaLsmPY0nuWMxOz3i6bX3fkChTTk2WGR8JTed7Wyw4R1CIXLLOi6RzeIi6atUpiw/bRzvL19wcmygn0jlUSYz4oMcv/Swo6pTu6SFoBxWSnI2Hugg6oaE+Ksx8PrBDShY8FfH1PRh22ysJwsKa5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749325587; c=relaxed/simple;
	bh=UliZhGvwi033g/4Uttvx592muXhmvDuzjWYBFjjcxWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/4THcZuynjwq/MCpE2R1JiIlLbFW4aB5b19pUYSpJcr4KA6ATJI3QZ+JPbwzOp3bbl+z/bLYtFRtA/ydMl739ilQMzZKhzzlLuxc3KwTXNV5IrmdnqMASRwaog+oQpupyT02A8qpu7cSzznvnh6HaXV3pr8JzfcGg5a2Kndu00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=geA2P0Dr; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sl5HztyV; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bF7wV079wz9srM;
	Sat,  7 Jun 2025 21:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749325578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMRfokKzKXH1ZLU+7tVQpEyn332oudckXH5+iv7xEkE=;
	b=geA2P0Drbx6sta3rzcEF4JSJW4o5voDpuSAT1PKcMI74Qy0RuRNDjlWoto8pKARGo5ZN6L
	ZvmYW4o7qPo0WWuhoj6JXfYw6Rc9cLwdCuVV+ulfQjQkre/QLc0bQWe+h1b/b0k6GPOpz0
	h3uLsPil7MAlRkmDY2F32evAKJOVALKGrBOXniXNaPLqWAfZyqUZeYL4RICTakyR7Oys22
	tLJxXtn/IjDZL2q91iAKZtlTfmdtXf2UwjoMQS86pA28C9hMzBvBgGaFcSc/Z6swk2oOgp
	gyHzcTLkLI6ucIKDs5YJVPwKqrFF915aqET3UPAwRePQ0HS0ljRTHudrkCF75A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749325576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMRfokKzKXH1ZLU+7tVQpEyn332oudckXH5+iv7xEkE=;
	b=sl5HztyVIAk/JSbwtvaEP7CBIy1/QGFR7Bmj4Gjs1nUwHmCbVLrPQ7Q+i3lwC76vjjCk3g
	yZvpMv2woGqQ8vpcsCQes6ZOd4yK68hOuI+SfDxWlLcSrSXygydgV9gjokoMNFifrCT5j3
	0UV1heb3bgOZAugmJ283tEWWzB5jkFhcHLlN4xm5KMVgDlAi62EGNYpGEDjj1+7lPIKJSB
	EZDND72+w+wtJftOUbgstSG766ZNV3hbl2n5AGNLnERcGRsWb9nmDVheB3ibmF03kiS+9q
	NVC9XaqQ6B1UC/mv3DnMfLnWsaJ2G+5cJAcacuHsWhJOMpZWT5gRaPMr6EQimA==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: dts: renesas: r8a779g0: Describe root port on R-Car V4H
Date: Sat,  7 Jun 2025 21:44:38 +0200
Message-ID: <20250607194541.79176-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250607194541.79176-1-marek.vasut+renesas@mailbox.org>
References: <20250607194541.79176-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tkzfd66x1madga448z9i7q6q5475nyqu
X-MBO-RS-ID: 33f608aa3f148c713dc
X-Rspamd-Queue-Id: 4bF7wV079wz9srM

Add node which describes the root port into PCIe controller DT node.
This can be used together with pwrctrl driver to control clock and
power supply to a PCIe slot. For example usage, refer to V4H Sparrow
Hawk board.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: New patch
V3: - Add AB from Manivannan
    - Add RB from Geert
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 6dbf05a559357..8d9ca30c299c9 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -798,6 +798,16 @@ pciec0: pcie@e65d0000 {
 					<0 0 0 4 &gic GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>;
 			snps,enable-cdm-check;
 			status = "disabled";
+
+			/* PCIe bridge, Root Port */
+			pciec0_rp: pci@0,0 {
+				#address-cells = <3>;
+				#size-cells = <2>;
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				ranges;
+			};
 		};
 
 		pciec1: pcie@e65d8000 {
@@ -835,6 +845,16 @@ pciec1: pcie@e65d8000 {
 					<0 0 0 4 &gic GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>;
 			snps,enable-cdm-check;
 			status = "disabled";
+
+			/* PCIe bridge, Root Port */
+			pciec1_rp: pci@0,0 {
+				#address-cells = <3>;
+				#size-cells = <2>;
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				ranges;
+			};
 		};
 
 		pciec0_ep: pcie-ep@e65d0000 {
-- 
2.47.2


