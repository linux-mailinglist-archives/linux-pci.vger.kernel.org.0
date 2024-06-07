Return-Path: <linux-pci+bounces-8447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D495B9001B6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FAD1C213AB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAA218733B;
	Fri,  7 Jun 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9XYIGkt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA714F11B;
	Fri,  7 Jun 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758875; cv=none; b=co/UlpIpNc4qgA3CXQGOLmJzeKK05FIm422p/YHtquV78+hKto8RM1PN+pu0t/i3mbQPjHeiu7itVPIflkmxKDRSdYBsd/7fEPZowK3OdQJP7ASh2UHc6wJB5aT8H+F9jp4SE8Ec5vV0OmyIu/0ox8xkr8yIBgsaSy/+Sri2Wlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758875; c=relaxed/simple;
	bh=snAgm64ySynk6RAed5xxHOvVSYB2c27PvNSsTeM0Z7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMVbC5qSRQRpIKaLa+NZrlXmUz0rrk9vTSPjiq05ays8eklJhL+69AovsYa0kLebacBkVk8SWgy0gDKxFvJoF3/UqTemHDmvFIDvDylaDmuqROfQQ7DFh0F6ptS89ZuND+BoXpjjz1n5UsdsFOLwFsSejU1TPznFJUDCGFmX12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9XYIGkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D49C4AF0D;
	Fri,  7 Jun 2024 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758874;
	bh=snAgm64ySynk6RAed5xxHOvVSYB2c27PvNSsTeM0Z7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a9XYIGktTUGug61XAYzRh8Ay83II2dU+xipqLEOCFFvrz55aibPhQavDEM3AMjYwr
	 eBQRY55jn/G/drIK8M+zFbOmbx4Dr8QxaY5st79okeNbQcLFkhp9Z8Mu0ODF3lRQoT
	 9cY8ckfLnukfK+GYiOYe4uYYSk/WmX95OC8AncTNjkl4qligMHYRSJRF+3OjqUXP2b
	 kHMbrByEkqlHSVSVlq9Td1MA9vzzCC3So7ADx9A71Q6uWIttRee22LlOthuuvt+o60
	 Q2/dYnsNO+YWJaBJngmxdYVDjqJEv5FjxxbMf/4KuO7aiGwwkTWgQS56bXtD69xpuq
	 lgBjHahUP8Djw==
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 07 Jun 2024 13:14:21 +0200
Subject: [PATCH v5 01/13] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific reg-name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-rockchip-pcie-ep-v1-v5-1-0a042d6b0049@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=cassel@kernel.org;
 h=from:subject:message-id; bh=snAgm64ySynk6RAed5xxHOvVSYB2c27PvNSsTeM0Z7Q=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKSXk+c/04r1bFHskjqgogyS+iD27oBB4+K9v1bdPtdV
 d/9TGfRjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkmR/D/xh213PMKq95Tpf/
 /ak5/6M2axIL9/8ZLi8eBZXt/Dlfs4vhf4V5euQGd++ZyX2sByREl0ddWtN9WPKWbsadeFFn56X
 rGAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Considering that some drivers (e.g. pcie-dw-rockchip.c) already use the
reg-name "apb" for the device tree binding in Root Complex mode
(snps,dw-pcie.yaml), it doesn't make sense that those drivers should use a
different reg-name when running in Endpoint mode (snps,dw-pcie-ep.yaml).

Therefore, since "apb" is already defined in snps,dw-pcie.yaml, add it
also for snps,dw-pcie-ep.yaml.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index bbdb01d22848..00dec01f1f73 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -100,7 +100,7 @@ properties:
             for new bindings.
           oneOf:
             - description: See native 'elbi/app' CSR region for details.
-              enum: [ link, appl ]
+              enum: [ apb, link, appl ]
             - description: See native 'atu' CSR region for details.
               enum: [ atu_dma ]
     allOf:

-- 
2.45.2


