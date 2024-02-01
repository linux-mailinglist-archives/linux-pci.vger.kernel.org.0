Return-Path: <linux-pci+bounces-2928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC9B845C27
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2730E1C241E3
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18746626B2;
	Thu,  1 Feb 2024 15:52:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8D626B4
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802731; cv=none; b=hESWxOw7XLwguS4aBJQlJDLQ1SMHibNLPYif9lvBD+K2bsZKKPRp/3KQiB+DMbGtsl6/gkdKnr4frNYE2Vah1KoAmtJ5L36lFHLEcrpUBvqc/4tTLnt5LYv8s4oyWOszCrxIgiSR9n/+qxZPbaGeqWLzYI5R4JLL4nZQluJt2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802731; c=relaxed/simple;
	bh=37o2Ts4IW3atKBcwdsff8mQOq/M/Y4L9qyyi0wt0iZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LEy21pKP2sspmnXwZ8IRUWJy4yjIUFks/MFFqUkNQpR//SH/Vt05ejiqd1/SDi0eIH6PNnd6gseYXvurUQFsntTkwu3hjvsTtjfhMPaYxbdk5k/uMx30NX3+oGjDaYbdtw86vL++4FUHrrhTZthF+qWNWvaYcdlcpJ7dsHLTrVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:4392:e888:3d14:1bdc])
	by michel.telenet-ops.be with bizsmtp
	id hrs32B00N2BHJxj06rs39L; Thu, 01 Feb 2024 16:52:06 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rVZLJ-00GvjG-IQ;
	Thu, 01 Feb 2024 16:52:02 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rVZMA-00Abrn-GL;
	Thu, 01 Feb 2024 16:52:02 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: PCI: rcar-pci-host: Add missing IOMMU properties
Date: Thu,  1 Feb 2024 16:52:01 +0100
Message-Id: <babc878a93cb6461a5d39331f8ecfa654dfda921.1706802597.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make dtbs_check:

    arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: pcie@fe000000: Unevaluated properties are not allowed ('iommu-map', 'iommu-map-mask' were unexpected)
	    from schema $id: http://devicetree.org/schemas/pci/rcar-pci-host.yaml#

Fix this by adding the missing IOMMU-related properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index b6a7cb32f61e5d4f..835b6db00c27968a 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -77,6 +77,9 @@ properties:
   vpcie12v-supply:
     description: The 12v regulator to use for PCIe.
 
+  iommu-map: true
+  iommu-map-mask: true
+
 required:
   - compatible
   - reg
-- 
2.34.1


