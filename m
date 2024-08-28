Return-Path: <linux-pci+bounces-12372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0B962F2E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 20:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475FFB22A26
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EDA1AAE30;
	Wed, 28 Aug 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="N1pQAGNv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592B1A76D8
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868089; cv=none; b=mokp5D5nzehhUHZvif4k8AuX+nRF2W5g9/lEQ2oRDz+az0KvKh6ryBA4j1n8utZDYNoDzsMKfb5uY8edjw+Zjr9NUP/+HSDhd6NmyD68G4gphfoBzJjX2LEh4hIAWhVR4NdfqyxOyU7q168tjcRwT363inDqnB83zVR4JF3fOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868089; c=relaxed/simple;
	bh=+zM+1DwPqU6oVvi9TC2LvsW03z3+giTKUSHDg03PC40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hmmr/L7hNtCurO2ycwQTIkMVuz5JkuzqUra/+nURq0+6VNU7gCX1yaML6eWfBVyea3zqt+EwAGePdGnSu0KQPNIOyKDeu1pdh0xQNQvilIPGuUBZxSU2H3oKnppC5mHS/ztLiFx3bmtTjX/p7ZfychmWN5e4ZM03anGiOgBnfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=N1pQAGNv; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240828180124b5033b47fdb9aeec7b
        for <linux-pci@vger.kernel.org>;
        Wed, 28 Aug 2024 20:01:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/8+hIAr7cfUj2tiGhrpmLQPF1IMdXeDa4BJNaA9Xqj0=;
 b=N1pQAGNvLK9mt9sBAxMVa3OIZqmnXaNPBey1d2HXsRZF4oOOe6ymsCxhdcm6KRjgUxCWT6
 lYSoXpgIdCr6pB6s3C0mcgjUkEb46WX3pJpLsFwNxn2FdQZAg7LgS5sU/ZHRh8o0ikS8Hasl
 3w/PGIshlj18bkMzbclWJhgs8eqwN3M5U/8dqmBCtX6kszXhU+hhS5SlIR397NBd24dE9f3Z
 l8h2fwIBttr4W72ibwASWZ9omROdTJZtX09d5FfE8XH4uJCz32ia3WEHgiYo1lACdXiUZjDc
 AsbbsXGKrNbFGsGhZt0UEp7y1vcb9PyXdT7fihWiUnwO7ztGdWTg6+zw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v3 4/7] arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
Date: Wed, 28 Aug 2024 20:01:17 +0200
Message-ID: <988ddd76b742240d42aa2733ad92c6e7b82a3f0e.1724868080.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724868080.git.jan.kiszka@siemens.com>
References: <cover.1724868080.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Rewrap the long lines at this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 08ce765828a4..46806f07a630 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -887,8 +887,13 @@ main_gpio1: gpio@601000 {
 
 	pcie0_rc: pcie@5500000 {
 		compatible = "ti,am654-pcie-rc";
-		reg = <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
-		reg-names = "app", "dbics", "config", "atu";
+		reg = <0x0 0x5500000 0x0 0x1000>,
+		      <0x0 0x5501000 0x0 0x1000>,
+		      <0x0 0x10000000 0x0 0x2000>,
+		      <0x0 0x5506000 0x0 0x1000>,
+		      <0x0 0x2900000 0x0 0x1000>,
+		      <0x0 0x2908000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu", "vmap_lp", "vmap_hp";
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -908,8 +913,13 @@ pcie0_rc: pcie@5500000 {
 
 	pcie1_rc: pcie@5600000 {
 		compatible = "ti,am654-pcie-rc";
-		reg = <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
-		reg-names = "app", "dbics", "config", "atu";
+		reg = <0x0 0x5600000 0x0 0x1000>,
+		      <0x0 0x5601000 0x0 0x1000>,
+		      <0x0 0x18000000 0x0 0x2000>,
+		      <0x0 0x5606000 0x0 0x1000>,
+		      <0x0 0x2910000 0x0 0x1000>,
+		      <0x0 0x2918000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu", "vmap_lp", "vmap_hp";
 		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
2.43.0


