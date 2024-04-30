Return-Path: <linux-pci+bounces-6871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B818B752F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 14:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1428E1F2128E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1313D289;
	Tue, 30 Apr 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EosXEdTe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363513D272;
	Tue, 30 Apr 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478521; cv=none; b=WVnOSvAqPUE0TgIgyFr8y76DMpElY0btpTOkiku4y1IMr05fh9LhXQ2VI7uheVyM2X/8dhBhH4gfdDCldM8k/mPCeprevn7XwpJWvY0ywRnX2aOxgEEGN8IAYidt+DBOVxWgDN17v0yhuQ3l9JVu0psRS7GnDClicccHfS3yR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478521; c=relaxed/simple;
	bh=2auuQGe9uHpx39X2DRGeyL4wn09dTQhuOpMdAqllMYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0N54HRbjTLYxbKtrQjJkHETuoWXfwgY/cnMXvyGBvy4ymeS7+vrRpsupjr39hEu9NK3OAc1tu1RUL/azO0j22FloRTt15j2eNFV/SKsLzMU4bwOyCvnFlOPRUvBZD5XvfUbUpdaS5sKVktcDqp2yPKUFDjv/I+osthbtXf9m5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EosXEdTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED08C4AF53;
	Tue, 30 Apr 2024 12:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478521;
	bh=2auuQGe9uHpx39X2DRGeyL4wn09dTQhuOpMdAqllMYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EosXEdTek2E40smXhuEIGDxUvmmW9wEsWePza5cW+B9qJbPla0yG6LphRr07y/ypt
	 YP5BI19dzXKR4VzkA2sqkEghrbFNEHcgYAjVJ9PGmTPjdRPRz58mrgtv5D775EeEVT
	 KCCpirt/XxvDnp3Uvv5tQF2FFMJtJz7/SZ35wW6jd85pSEyWJz0iu7JKucmUCkhutM
	 mPCVXt8m0+ZnIU+Maeh2otyBzLX6AW5LcZOMEPi3IISrST12b0MDZe8tVfSdWjh7XD
	 yqs+jlMKUb4Zk2wkgOmPmWa92HuyxqqRDCqDx2KIWo/rhbYwpTyNJ5OG9NZQqnYN/7
	 yiYZajI2Befkw==
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 30 Apr 2024 14:00:58 +0200
Subject: [PATCH v2 01/14] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific reg-name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rockchip-pcie-ep-v1-v2-1-a0f5ee2a77b6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=cassel@kernel.org;
 h=from:subject:message-id; bh=2auuQGe9uHpx39X2DRGeyL4wn09dTQhuOpMdAqllMYs=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIM7m54EhHDfYpZSPL3KQkrk0aO9Vm8vs+1ea82a8kG5
 8+emHqlo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPJV2D4X7T+/puP6Y6remsl
 3aVC1mbc7vhpNVP50OS+y3WSgfzP/BkZuluDGAVWfLg2d9fvRZEBbgdcjbZN3pR+8VViy5Rzs04
 94QIA
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


