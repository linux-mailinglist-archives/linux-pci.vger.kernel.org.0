Return-Path: <linux-pci+bounces-7998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7078D3173
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D5228D277
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDF6176FD2;
	Wed, 29 May 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNdZg47P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7294176FA3;
	Wed, 29 May 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971358; cv=none; b=E6Z5VhFIXzkvXUE8Y8SAZxETyUfjllhWf5OU0zsGz7aSIJ+2m0tn1zp4ilKTHtKkIP0dfXsRa4+LHUfropf+GX1udhVNJNljO6GDE36Ri/ReHX8C53aNWJu1U5t9wkETAmI0hZGd5UJ68EQ8cRTjFUZjMLUymz3GRebnZX/wuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971358; c=relaxed/simple;
	bh=YQdBNL3lsBxDipD/xKxlprycaEEuRK+D1X2/LL0v9pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JkIMAqm1x/q/hcTZfvLEIcRJ3W5jy3LGj8ffDsY9sp3Z3SSu2t6l9g3Lj7sWmI0wW3hylZcnn4r/PirtQZA8+Or+c8Fk+SaHDCPPC51lYHLXqX5luu59z2D31vezHIB8ewURo3j2lX31XSB9ECK4ybaBGHnJFp5mPIUGNsd+a9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNdZg47P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3ACC4AF0D;
	Wed, 29 May 2024 08:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971358;
	bh=YQdBNL3lsBxDipD/xKxlprycaEEuRK+D1X2/LL0v9pk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tNdZg47PkI8DdddprTyeIZEIsV6JOQTZDDXhrcGGQVcIrp1B5ECK0HmrzIKdrQUQ7
	 9pcvvKhs8TX8iLJgdedT68V1l3QAkpQZdAui3ViMh94wV/VJa+jbKNi/bKfG9DuljD
	 vwjrJETLDA8EIikBKWkM6vYIAt5Gwl1GvYE/aRFoP23KJsDjZwHMWyr8NQb2ONueaz
	 HEVEqcaRX/S2rj8HoGTv0NLCySh9wgtYAsaofmhAfGC9Qdj9reIlz/l+M9U/cR3ctW
	 fbK32RgZn8hK/9F3PsWMV+nvL1AmQO4/jPEaIeK2Olt05+bavyvLeymjSubpm8VXpe
	 orx/hd3l87Z4Q==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 29 May 2024 10:28:55 +0200
Subject: [PATCH v4 01/13] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific reg-name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-rockchip-pcie-ep-v1-v4-1-3dc00fe21a78@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=cassel@kernel.org;
 h=from:subject:message-id; bh=YQdBNL3lsBxDipD/xKxlprycaEEuRK+D1X2/LL0v9pk=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLCnocaCq7Jst/wOOJeK4PSzflpL85tqVjoYCEjEcW67
 9rtWE2LjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykxIjhfyZvXInhLQfrgP6D
 ga8+pT1lCphp2LZmy06zuVdD5J99amdk2BIePc1O/5n4hqwNNsFHjrIbL5D46LyP96espqkpjwY
 3JwA=
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
2.45.1


