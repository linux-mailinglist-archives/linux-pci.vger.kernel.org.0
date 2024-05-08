Return-Path: <linux-pci+bounces-7227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1DE8BFE37
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F67B2316B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD078C9C;
	Wed,  8 May 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwzkjClH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D178C96;
	Wed,  8 May 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174024; cv=none; b=gc3lo2oShaY2il/rrtRps/lFyFxRLdWRxVeebCWFDBKr6EZ5DKjQQovUH4U/l13c9ZGPVfL09XYMx4z7jVDxjE25PxCmYyQkBaM89QfWI16ihfAcd5eU+7TfmaZoAC7XvpH1/JpA8aHJXWot2OULXGfuotmJO9k6QAFTrTa3mEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174024; c=relaxed/simple;
	bh=2auuQGe9uHpx39X2DRGeyL4wn09dTQhuOpMdAqllMYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Acq7NJseUWNiISk1XjCFJuVIT1JEYWyq8u1nyRDTj19/QR1/+qM4A7V90aXSQmjVcw1hZvkDrPD5WHd0A9ZpNJV1Jy5NtifK+Al07ikWy3PyJCUzjKXP2vhAV9KDW2bXECPrzi1Ium8rbMaD16/1XFne0h4skZtXfdeIZdDTsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwzkjClH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850E0C4DDE1;
	Wed,  8 May 2024 13:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174024;
	bh=2auuQGe9uHpx39X2DRGeyL4wn09dTQhuOpMdAqllMYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CwzkjClHXS2d5QhMsgppKR03OvIWFg6CYCTxUtnhwTKezY+02/nsfs8bmhmla11dh
	 d4gEEbHyM6ZXJGmNDks7II0mndljxHVEnTr6HCidUXkl6nM6Lz5ZYkZzQvGGyJlfTD
	 7i9n3lf/+6/Z/LlMtOiLaD1I4doW3NXchQYRggLfA//1jEo/6r1/2BKahV6bkOrlAT
	 cbKtGeuI2+xRBUFNyxUw8Q6xomU4amA0QtYlElmXRnimDwI8ylVNpIazj1rfL8R+Km
	 lKxIY9f2ZW5Gl/y+K0G/ogK/I5Nu8LU30WV3t0A9VUJNHIUjY3Kkh7QUh2G98ZQBfR
	 Etav7CZT8cOug==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:32 +0200
Subject: [PATCH v3 01/13] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific reg-name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-1-1748e202b084@kernel.org>
References: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
In-Reply-To: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=cassel@kernel.org;
 h=from:subject:message-id; bh=2auuQGe9uHpx39X2DRGeyL4wn09dTQhuOpMdAqllMYs=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKsq+qbmYu0U7pFd1ryXK+TFfFnf80WoVmu5MG7zXdG6
 OY8NZaOUhYGMS4GWTFFFt8fLvuLu92nHFe8YwMzh5UJZAgDF6cATGSROCPDlV1Cc/acU5qcL7nt
 sHPMvjU3pidxyd5QKVO/F78jN+2xNsP/6HL9ouqjLV8WKM5a3+RisuuIvVjWkpJzT2/bnpqVkHm
 JBwA=
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
2.44.0


