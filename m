Return-Path: <linux-pci+bounces-7660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F08C9F0D
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CDAB20E63
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA044136E0C;
	Mon, 20 May 2024 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d09pMeOY"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134113699A
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216858; cv=none; b=n1rH86iCdIS5QvbyqhDU+s+d/Mukp7hteZd6I3/IGBR7oU/z9boXSjjRrNFZ1o4BNwCYZSibT/pmCqz+PhNkCZ+0CvNVI/CRrSipb6EQdM6UVwVBpLp4xfgo3DMdIESi/gv0tidnTWk0Lt7G1t9b1WH37fqkSeE8jUDIutm2YAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216858; c=relaxed/simple;
	bh=sHuVMqOOOz9XO4IshcQZEwhXzzhogGCT5T+bmtChve0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2vPohBP0LGEVdRW7/aricE/r1zJ25rsoLT7Ic1M+9wfN/6pnbWYxvTNuXyFwCtD6H/UnheW4v39+HmVw4Kiks64DuT3Nrz2bjlENuuu5nIbtSXwx1Zq6xC3YdvmfdVs6n/PPLx4WxzWT8LpBwKpAeaTiF5NeSvPKFqeT2DHvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d09pMeOY; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716216854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TZ3BGmEu8mVwpdyswgFBs/ct4xyk7TF2NGi7rztXsU=;
	b=d09pMeOYiWVnrY3txO33VLyO8lPiZDqCbW6nnx1MgKYzNfA7HqMxY6eRxGmcAVt+xvUuLr
	HJaMZwbY43vTCCVFZNqFMo0SGjrWVZyBsNQKtRnylcNqWD/4VhGRLaMgLvshkFuswYgckK
	JKBUlXWHl5h6LN9mcvgc7bixP3ltZMI=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: krzysztof.kozlowski+dt@linaro.org
X-Envelope-To: devicetree@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: pci: xilinx-nwl: Add phys
Date: Mon, 20 May 2024 10:53:56 -0400
Message-Id: <20240520145402.2526481-2-sean.anderson@linux.dev>
In-Reply-To: <20240520145402.2526481-1-sean.anderson@linux.dev>
References: <20240520145402.2526481-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add phys properties so Linux can power-on/configure the GTR
transcievers.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- Document phys property

Changes in v2:
- Remove phy-names
- Add an example

 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
index 426f90a47f35..cc50795d170b 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -61,6 +61,11 @@ properties:
   interrupt-map:
     maxItems: 4
 
+  phys:
+    minItems: 1
+    maxItems: 4
+    description: One phy per logical lane, in order
+
   power-domains:
     maxItems: 1
 
@@ -110,6 +115,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/phy/phy.h>
     #include <dt-bindings/power/xlnx-zynqmp-power.h>
     soc {
         #address-cells = <2>;
@@ -138,6 +144,7 @@ examples:
                             <0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
                             <0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
             msi-parent = <&nwl_pcie>;
+            phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
             power-domains = <&zynqmp_firmware PD_PCIE>;
             iommus = <&smmu 0x4d0>;
             pcie_intc: legacy-interrupt-controller {
-- 
2.35.1.1320.gc452695387.dirty


