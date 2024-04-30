Return-Path: <linux-pci+bounces-6872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6BC8B7532
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B07428637A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6413D273;
	Tue, 30 Apr 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmLBbkco"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00D13D26E;
	Tue, 30 Apr 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478526; cv=none; b=VS2rivKq0HTMu8SQ2RQ/Y2VdP3QjBu9xZc0/h9c2LMbaw8QUd5XmX2gzz72d1qcgZadbdpd8D5WPS/VK+/f/ooyLVMuse2K9091uC3ijoUU1/9/r8TxIk0Joi67UvE0pEOpBfwjLRjJ/YXoURuZjXQB93uCdSFVwR6Kx09PCO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478526; c=relaxed/simple;
	bh=dazCN/iT/MHdY+ckymlAcfBjUpa3OmMTl+4+NDKJR2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAy5yonV2Qx1pWL9asCBn1x9oHmsijpDbu0pmJ64O2yrjsA0fqlHULVgvaQxDpyn3/uxpwpMo7/QKJcH9YYBkgRoRhkbMxREN0frZ05oTojfsUVYvSu82lKJHDM8eGQfgL/uxdd6UU3vlCsu9FfWKa3fWT3ruVLC8OuFmjbiERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmLBbkco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9693C4AF1B;
	Tue, 30 Apr 2024 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478525;
	bh=dazCN/iT/MHdY+ckymlAcfBjUpa3OmMTl+4+NDKJR2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GmLBbkco7H+9TF70s3xCJzzCfE+wdzetILLrSRfKajcLXOUyneNVwNAo2N0wW/2Qu
	 JVs/Y6Zk1mr5uKcN1+7av/t5pKjBiAGS+brI7STdhgcZS/XTDp2OJLEiMwMRHcWmQV
	 itYQP8UD5ZA/mI7VxSN6Wc3ekS5uXsvw68IsM31imleh37XZzmyORiXqbxZlEOBQ7B
	 jEtwHGzrjebJBmyCAcJpV8WeIOZm1n8sHSB9iX230DK7X9H7V9qHWjBeTMVlsXLjnS
	 ptfChZylMwPiEjKjertC235sJDxMHxsiaE+ChLcxr9nEgMdJaKPdsemMK+36b6yVeB
	 cvISqnHavpxtA==
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 30 Apr 2024 14:00:59 +0200
Subject: [PATCH v2 02/14] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific interrupt-names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rockchip-pcie-ep-v1-v2-2-a0f5ee2a77b6@kernel.org>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=cassel@kernel.org;
 h=from:subject:message-id; bh=dazCN/iT/MHdY+ckymlAcfBjUpa3OmMTl+4+NDKJR2A=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIM7m5wV9fa+ca2plhz546ct3//n9v0lXNZ8tKMOcf2h
 /1s2zxjQkcpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAmYjmFkeHQvPVe1rsP/PMS
 bLy9+FVcTWhc8HJ1/d7c+1ueJzRus2hh+Gd1jdEjKMfuqtt3B50n1vb6QedjFq6Uf2W3ZFWKDWd
 WFRsA
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
2.44.0


