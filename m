Return-Path: <linux-pci+bounces-8000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578CF8D3179
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116F428D324
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900817965E;
	Wed, 29 May 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4ry1cqd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C81791EF;
	Wed, 29 May 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971366; cv=none; b=HbomKBzwiaPgcqN1RDdX8j7qgNGMDqdbw//PTsuf7krW69LB97Y5SCYYclaBKMrM6yeVopU3ncQcrISlGtTrh4OpLAq2oMb/C6vw/zRChonupz8sPHEwh9W5fEnRdRs8ouw1uw6vuCOagpsa0wBNJt8KNOF3p1oY2L0jXZDb8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971366; c=relaxed/simple;
	bh=qiqeHfjdk+Gj3u+QTqjs/LSs7UUp1/lyknJfxw+i+DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ri9vNym76kxCgr1AMl5SE4LbmJdgAo7+29YG2G1U73INiaac/vrzaPwUxH7QdqZCCQP/z/+aS485k+SZG5toeAY8ZNXsObVKP3QbyiwvkPPj92sL7hdxrbBh68j8nxVh9EgsZ0/6jfjM55np64EDJCwYRn5N3lU2DvZkBwkC63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4ry1cqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1847C4AF0E;
	Wed, 29 May 2024 08:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971366;
	bh=qiqeHfjdk+Gj3u+QTqjs/LSs7UUp1/lyknJfxw+i+DA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g4ry1cqd8cEzgUN5sgycB2Tcf5R7uiP6t0Dm/q9LtF67P31IKtyflNthn2PVOdMqS
	 om7YWdJOnopR3AsM3G4F4cnUrH3lrWVuWlMf5ZtBG51zubCwnyY5voZAQD9H1LrWjP
	 eE+lieWeTRSgrKpY26OuQGsDjbz2GIUpF0QZsKzpgOtby3YQtW4LLqUmaDjIKRoHpn
	 u5wmBx1OIpC89prBDN70Zp5RddterI3xUJQjMLg06TIMga6Ua5i86IXpALocmW/v9g
	 ywO/Zm9zKnj8nPu7GuwCSKvio6RS0HRgMbeZR9EFQy+rqunO7UbyatqhWF7HAiUlPE
	 Pduy6KCHrSGSA==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 29 May 2024 10:28:57 +0200
Subject: [PATCH v4 03/13] dt-bindings: PCI: snps,dw-pcie-ep: Add
 tx_int{a,b,c,d} legacy irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-rockchip-pcie-ep-v1-v4-3-3dc00fe21a78@kernel.org>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=cassel@kernel.org;
 h=from:subject:message-id; bh=qiqeHfjdk+Gj3u+QTqjs/LSs7UUp1/lyknJfxw+i+DA=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLCnoc6hojfuZDwtrcj87srW2uyR1UtS1jG3q6UOYv2n
 vf9k7G8o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABNJL2dk2P3P7CxH533tJZtt
 rVZEpKTXnHB8pPZWJE44KVqNIeHvd4b/7gfcp1jz96Xc4r5/7trsl29Dt+j22K24HvHj5z5Lln3
 lXAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

The DWC core has four interrupt signals: tx_inta, tx_intb, tx_intc, tx_intd
that are triggered when the PCIe controller (when running in Endpoint mode)
has sent an Assert_INTA Message to the upstream device.

Some DWC controllers have these interrupt in a combined interrupt signal.

Add the description of these interrupts to the device tree binding.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index f5f12cbc2cb3..f474b9e3fc7e 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -151,6 +151,15 @@ properties:
             Application-specific IRQ raised depending on the vendor-specific
             events basis.
           const: app
+        - description:
+            Interrupts triggered when the controller itself (in Endpoint mode)
+            has sent an Assert_INT{A,B,C,D}/Desassert_INT{A,B,C,D} message to
+            the upstream device.
+          pattern: "^tx_int(a|b|c|d)$"
+        - description:
+            Combined interrupt signal raised when the controller has sent an
+            Assert_INT{A,B,C,D} message. See "^tx_int(a|b|c|d)$" for details.
+          const: legacy
         - description:
             Vendor-specific IRQ names. Consider using the generic names above
             for new bindings.

-- 
2.45.1


