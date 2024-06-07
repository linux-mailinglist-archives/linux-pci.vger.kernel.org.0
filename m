Return-Path: <linux-pci+bounces-8448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A509001B8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D411C21260
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE91218629A;
	Fri,  7 Jun 2024 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u887h5Ua"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760214F11B;
	Fri,  7 Jun 2024 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758879; cv=none; b=XlyPufgdpBC3bZ0IrFuScswHyDWnRaRd4zzBqR5ypVq+vonKDyw0rEoCOBDpgewx5LJPqLra7eQd3vwOI9EU/nYcCxGKhOsw2SM90TKZ5bqPXm3ncW0x096mJpofQ3PuVm6tV4Clo9ZM2Jvo5j4YvxJSjFAXjJ27AK+8nYDomH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758879; c=relaxed/simple;
	bh=G70B+FIi6b2LUEcgijriiOGQyyBBVbl1An3dk3fUHTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRViSuFJt1+aFATOdVlx3xFFFmIENzliqi9kbP7Xn3Mf/D4WOgvi23r78/EpLSxSC++aBNswiUt7QjhggFDLiaHukpN8IjTaNo9lBJ1e5Z/J34hzfZr15Xz6KgfqDCs1bQc2ePnreq1MCBH9XV+P2LmGYbrvucHqBGhe+iw/HZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u887h5Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58150C2BBFC;
	Fri,  7 Jun 2024 11:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758879;
	bh=G70B+FIi6b2LUEcgijriiOGQyyBBVbl1An3dk3fUHTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u887h5UaoyOONY4FiqX78ZwqWPOytYssT381fEaC9y3OHHSvIR/st7unQpeD4uj+F
	 gHK/ArrZKVvFsg2B9Aw7oVi6B290u90mk+L1oFQZXpeyc0Kv+qRfxU7iJnW3fyC8L9
	 kL2H6X4FJ70acEqkNLIyW6PzGT2RDm3wecaQnhUMMdvY0U0RMzDC8dXuqcX0CX0KLC
	 2CNvAGbSK0WtZq+lJnuQo3QXSVzIonBdGpAIfsUWMLe4YztsOU2p8x+9pL+1Pb/fG2
	 ZRu3PGRbJ/WONnvFr1eRH6coYjc21DJ/GibKKpHprszPh0SLUHl5axFasG7qH0lhkv
	 JsRjq8jFnmRcw==
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 07 Jun 2024 13:14:22 +0200
Subject: [PATCH v5 02/13] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific interrupt-names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-rockchip-pcie-ep-v1-v5-2-0a042d6b0049@kernel.org>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
In-Reply-To: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=cassel@kernel.org;
 h=from:subject:message-id; bh=G70B+FIi6b2LUEcgijriiOGQyyBBVbl1An3dk3fUHTg=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKSXk+897DtZpMw76qmgC3Hpu3ev2L7qifJ7L9+vQ/X2
 MqhoX9tVkcpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAmYrSHkWGPxJXoqQxB4rcX
 6u94f7Y9JuTLij1Hfpz3y/68eOuR/9uNGP4p/Tf7KnLTXbz70414oZuPrjrrp7tMidpx6MzGV/v
 MvLZyAwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Considering that some drivers (e.g. pcie-dw-rockchip.c) already use the
interrupt-names "sys", "pmc", "msg", "err" for the device tree binding in
Root Complex mode (snps,dw-pcie.yaml), it doesn't make sense that those
drivers should use different interrupt-names when running in Endpoint mode
(snps,dw-pcie-ep.yaml).

Therefore, since "sys", "pmc", "msg", "err" are already defined in
snps,dw-pcie.yaml, add them also for snps,dw-pcie-ep.yaml.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index 00dec01f1f73..f5f12cbc2cb3 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -156,7 +156,7 @@ properties:
             for new bindings.
           oneOf:
             - description: See native "app" IRQ for details
-              enum: [ intr ]
+              enum: [ intr, sys, pmc, msg, err ]
 
   max-functions:
     maximum: 32

-- 
2.45.2


