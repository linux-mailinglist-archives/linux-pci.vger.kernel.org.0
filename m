Return-Path: <linux-pci+bounces-24638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61649A6ED8C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244BE3AFBBD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2F25335F;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+oj1AWH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C21EF099;
	Tue, 25 Mar 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898395; cv=none; b=F90/sqy0jCpSMrhgeLxQhTUgM+M9BQoNna5EK0IS760ECkUZZFGtVW+FVzvfVDGt3YoFRzecJoBBtGmdEFTBYQXyZF24EyWmuVUAD+nXqYPS/YtBzPRVIg5XGvjZOrjmUB2E9Ry6tnDBdtI+dQKnXju1XzzWxKtYfx4xBs0b6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898395; c=relaxed/simple;
	bh=/pBN+ohvIjqo2ih8p/b4lanOQSzFYkL2+lcRC1yvrVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4bOha5N08G/L73Gi05UMxzpSM+6562Pp9m4Ar1R76mf4ziTK8uwT4uN/K7XyNF7fcIS/1aE8plQ4aEzF+anQBuiLRudGs5X6ni8vmkI4FAOlOCeWyL+oloAojRn3mXwvxzT7WbDt0O7pazYBGjYIrskEAdHgMr2wZ5iXowcUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+oj1AWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830BEC4CEED;
	Tue, 25 Mar 2025 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898394;
	bh=/pBN+ohvIjqo2ih8p/b4lanOQSzFYkL2+lcRC1yvrVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+oj1AWHl0o4XLiCt8VoROLvs/Q0L0pBhKLu06Ywe1Fg+BzXr9+5ip2+PApClIoHs
	 fs7zcKnQ5DJFV48eHfrQ9RUt7TtDPTaFkkhH7fIkBH0uPke3YjsU8elUwpv6Jc3WeE
	 8SOb+i0AeyL2ickHR8IG85j6Z7uX3iIY0Qs2qnvUVNsJ34ESqHmuJw8L2G2O8iZtNM
	 trJfNMRQmQXIPx7rSfMfHn1huIQps7TUqsh+nhbx0jbsaNCmbxerWXTh3sMjImBRRu
	 QIm5u42VFey8fYmjs9AbUng/ukqVW/96DNyFRqOrAVirWFSneaFxYuH0HcAPx/oEcB
	 F9ha/hulenm7Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UO-00GsRS-Ci;
	Tue, 25 Mar 2025 10:26:32 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH v2 01/13] dt-bindings: pci: apple,pcie: Add t6020 compatible string
Date: Tue, 25 Mar 2025 10:25:58 +0000
Message-Id: <20250325102610.2073863-2-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250325102610.2073863-1-maz@kernel.org>
References: <20250325102610.2073863-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Alyssa Rosenzweig <alyssa@rosenzweig.io>

t6020 adds some register ranges compared to t8103, so requires
a new compatible as well as the new PHY registers themselves.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
[maz: added PHY registers]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/devicetree/bindings/pci/apple,pcie.yaml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index c8775f9cb0713..77554899b9420 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -17,6 +17,10 @@ description: |
   implements its root ports.  But the ATU found on most DesignWare
   PCIe host bridges is absent.
 
+  On systems derived from T602x, the PHY registers are in a region
+  separate from the port registers. In that case, there is one PHY
+  register range per port register range.
+
   All root ports share a single ECAM space, but separate GPIOs are
   used to take the PCI devices on those ports out of reset.  Therefore
   the standard "reset-gpios" and "max-link-speed" properties appear on
@@ -35,11 +39,12 @@ properties:
           - apple,t8103-pcie
           - apple,t8112-pcie
           - apple,t6000-pcie
+          - apple,t6020-pcie
       - const: apple,pcie
 
   reg:
     minItems: 3
-    maxItems: 6
+    maxItems: 10
 
   reg-names:
     minItems: 3
@@ -50,6 +55,10 @@ properties:
       - const: port1
       - const: port2
       - const: port3
+      - const: phy0
+      - const: phy1
+      - const: phy2
+      - const: phy3
 
   ranges:
     minItems: 2
-- 
2.39.2


