Return-Path: <linux-pci+bounces-7999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A08D3176
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5959A1F222AA
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A509178369;
	Wed, 29 May 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kltBVmHc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52191178364;
	Wed, 29 May 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971362; cv=none; b=Wd5ogfgmpJa2lcA2lHeJiOjRRrsNhOAsjtzDDGPnMXcCKmp8uEEk2StzfwusX2oOq79dBqQooLw/g1oabsberof6DNqvsKcb2ho0xuc3CS+SkkbxIw89RciZ2x0zwLuoJyxrr55FxnI3WjZuhtk5/Xq1oH1shp/KrWOqAF3TN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971362; c=relaxed/simple;
	bh=0AsOf44k0peZ3qs9praxDDjjEV3cTdstHX1bWf4Vatw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWp2Iy4LX1BBjZpDTzWBRAQRnAqSa9LWmEv2xuyndS4gSdzJbJaL2pvLGgjGyK+lxwi//tl68AUmxfG5aoYPYzYLcGD1pYTKY9hh1T9tfH/ByihgTQTEnRzEoEQwPBg3zTnM7nCZLd5VnBnHNDSXUpzLKh5y265khNL8jAFPbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kltBVmHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E687C32781;
	Wed, 29 May 2024 08:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971362;
	bh=0AsOf44k0peZ3qs9praxDDjjEV3cTdstHX1bWf4Vatw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kltBVmHcR8ymdXTWZ2dryzYB1qMuJLqY5l7F/rKZzrcc49uLpWiNeZnn/O+3p011Q
	 z+CnE/RYmVyaKluH1XxnguoEnf1C4u+2/DNFs5cfOcpzJ6hKNFgUtuPgfmlSwfwA+v
	 6PkKl9+ya2ozGuDHGx1dIlGM4AL0lzXH8lH1XhobmfgeG88aQXvc+qtGIwrOxwAVCx
	 NpwrEAV9g1TY5ij07VPUV/ijv/BPz1NElU3NjXmHphhib9av/GXS5ccAdjxWP2Pqm8
	 k8RgQkI31CdPyg1uCKQC1UCmNTPWdXcOvfQlh7nM3cRXcbEtaRv1fQM/9Li8PDZQ28
	 40SudWbejOQRA==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 29 May 2024 10:28:56 +0200
Subject: [PATCH v4 02/13] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific interrupt-names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-rockchip-pcie-ep-v1-v4-2-3dc00fe21a78@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=cassel@kernel.org;
 h=from:subject:message-id; bh=0AsOf44k0peZ3qs9praxDDjjEV3cTdstHX1bWf4Vatw=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLCnodaZ+asi51/JWVBrUmPrPzpOs8HP//tvHJ/4mV5R
 sbsrFaOjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwkcQrDX3mNvwyn188MWKdo
 zJUc/avFxfPAGakfS0IvyynvfskupMrIsFfgz6MvLz/Ma39iLrCk8FvttR91jld/e8QIBE+d8qk
 yiRkA
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
2.45.1


