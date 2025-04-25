Return-Path: <linux-pci+bounces-26727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A5A9C335
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F979A801E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD2B2356A6;
	Fri, 25 Apr 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1H6nIsi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403314A4DF;
	Fri, 25 Apr 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572834; cv=none; b=b9bGUyRgQaR4A/JqYfxB1eFsYoQo0WWoq35COvkj4Bl8n8+YH0WBuxcEev8v+44aVBfrg4K86n3GvjiETO6ZGzCohicm104I8Z0yOX0pPAbldErnvZYpKVe7pYBI48ntwdyQVB8C2b99d0n6PeN7V26H/sBjCpCr1PE4Un9mdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572834; c=relaxed/simple;
	bh=UCh7hkxvuQd37GFSK2LhlE4EldkR+D9x5Yj7n5pmJ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVjjKiHbZfBpW5Py+n4KVCuhu6Eay8HlyyJXuF2QnszMRNeCCzlz6lxoQP00fhFYW20kFDbaWrxIjty2hUnrGRMa9U9PumTTPLqPOHfHh1BrnApBvREomknZc/mcbRlw6l5ia2AdCBYBvORULuF9w9VYpYGepuTdeooWrZe2ED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1H6nIsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860A8C4CEE4;
	Fri, 25 Apr 2025 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745572834;
	bh=UCh7hkxvuQd37GFSK2LhlE4EldkR+D9x5Yj7n5pmJ6s=;
	h=From:To:Cc:Subject:Date:From;
	b=t1H6nIsiaqSmUOGlPHvl8EqHJpRWdC19g1Lgu2W1muVLRSCJ2AU0+BGmne7XtM0pU
	 h2fdkixyxQENxvFR5olTtcGA9unhBM5wluexnOvNqCYr5jcRtsoSucxNYiNoF1Fv//
	 0qNdIrTLCsU7A6HOKiy8G5gA87qjoqjWQUe8jqpCBUR0/YLjZQ4V4sr4Pl0bzVcKGE
	 KHFteIlCGitz0Xv5HVx2sWC0RNzZILFG9tCfH9ZeKPinBJw7r1VoxEZyka24XhDeEV
	 9uV3gBPEKiu8f2FhUVT26dtjlhsuJYDtW4hIOPMg0AD2eY9PRZZhCfDHJ7b0PHMRJU
	 hXlFjSm0pD21g==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abraham I <kishon@kernel.org>
Cc: dlemoal@kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Date: Fri, 25 Apr 2025 11:20:12 +0200
Message-ID: <20250425092012.95418-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2252; i=cassel@kernel.org; h=from:subject; bh=UCh7hkxvuQd37GFSK2LhlE4EldkR+D9x5Yj7n5pmJ6s=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK4g8/cWVGQ+TvQdfdsp6o/xzndVUs5a7IlOSMbvznFq pp1u8zuKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwETWxzH8T6w+pXpG+7z4P8OD kavfzny9+ECoWrrZTpbJWi2XD/UHvmD4X/jO6vWPbud1G1aUt2TWS991ZFub8aw98XeX9ooNpiZ r+QA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While some boards designs support multiple reference clocking schemes
(e.g. Common Clock and SRNS), and can choose the clocking scheme using
e.g. a DIP switch, most boards designs only support a single clocking
scheme (even if the SoC might support multiple clocking schemes).

This property is needed such that the PCI controller driver, in endpoint
mode, can set the proper bits, e.g. the Common Clock Configuration bit and
the SRIS Clocking bit, in the PCIe Link Control Register (Offset 10h).
(Sometimes, there are also specific bits that needs to be set in the PHY.)

Some device tree bindings have already implemented vendor specific
properties to handle this, e.g. "nvidia,enable-ext-refclk" (Common Clock)
and "nvidia,enable-srns" (SRNS). However, since this property is common
for all PCI controllers running in endpoint mode, this really ought to be
a property in the common pcie-ep.yaml device tree binding.

Add a new ref-clk-mode property that describes the reference clocking
scheme used by the endpoint. (We do not add a common-clk-ssc option, since
we cannot know/control if the common clock provided by the host uses SSC.)

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 Documentation/devicetree/bindings/pci/pci-ep.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
index f75000e3093d..206c1dc2ab82 100644
--- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -42,6 +42,15 @@ properties:
     default: 1
     maximum: 16
 
+  ref-clk-mode:
+    description: Reference clocking architechture
+    enum:
+      - common-clk        # Common Reference Clock (provided by RC side)
+      - common-clk-ep     # Common Reference Clock (provided by EP side)
+      - common-clk-ep-ssc # Common Reference Clock With Spread (provided by EP side)
+      - srns              # Separate Reference Clocks No Spread
+      - sris              # Separate Reference Clocks Independent Spread
+
   linux,pci-domain:
     description:
       If present this property assigns a fixed PCI domain number to a PCI
-- 
2.49.0


