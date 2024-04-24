Return-Path: <linux-pci+bounces-6633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEC38B0DC2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAA01C22685
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB2415F3F4;
	Wed, 24 Apr 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIShaqMp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2B15F3EC;
	Wed, 24 Apr 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971803; cv=none; b=p1q/30pEGpQZR7Bq6zEvGSRiyB+QMo3YmZ6KO0EZqV0G/lrK3PGP/ZLBi/JukCPvY8CRj2J6cgjgPI0TkPq3W3gZIcJpM7YPRMgAZb3RZ4YqYrrObe8MPIgkcaRv3nyARHP+f4LGh5sALPMMscRbzvpE1fHXduMckfhe+3hKZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971803; c=relaxed/simple;
	bh=Dz2zX6pvYQupG08wzkCHyigvD513tXaWstBbBs/KqqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/9FJrP355BT2sUae4yrnHdu50xSfkPyyUUSkCqUIs6gnzY40vkX4HW6Y9yuBtmcAXXcHaq5nSRcJx/AEBLqzauJrPZlPiWu7RYHI7NPej5qk816ZlpY26lU4HZrGoFV2QbADD3+cIf1EMJqoWvKsif7mt9xNHbOusHcbuP5LPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIShaqMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DB2C2BD10;
	Wed, 24 Apr 2024 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971803;
	bh=Dz2zX6pvYQupG08wzkCHyigvD513tXaWstBbBs/KqqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eIShaqMpHgxz5fHgGPYgEqGa2swx/yz3eQ5CYt3YtNbmk3Crdi1qOfhTjyKufIhzI
	 mNF792Jlm5MBmm7o0d/rlvZvP6+65vCyKm0fAag+e3CuIE3fVlDUA6tC2Gw8bNxzG1
	 pD3iFBFnVXnvzBvF3aEA1akLsaCBP3+/RFN5JdlDmXugJCYpLADJeS6ZTYQHiBkMnw
	 temPzfuPS5Qlmm3nT8JGtrTzqht8XmKTaSTCGkVuLztIo/9D/+uX85+O4Si0Aiu+jK
	 jOGHJ3oARrnJvuZLgvEH4MjwTsINVL2MeyAB/ynei7w0J/wNe0P70ARrp4XvfvMUd8
	 mQZjouSlSdauA==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:19 +0200
Subject: [PATCH 01/12] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific reg-name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-1-b1a02ddad650@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=cassel@kernel.org;
 h=from:subject:message-id; bh=Dz2zX6pvYQupG08wzkCHyigvD513tXaWstBbBs/KqqQ=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYJKTk/dfPLXWvWGRvZ6boVS0xKf9/nOP2pMF33Qa
 FGcqS7cUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgInMEmBk+DP3RV3ibnGuFqX1
 Rsfzdh8KUP5x+kPs4Z8n0i69TInJXcjI0KGwy6NyRn9Bmt3hi1N0lzqlNnjbH89eNmHWy+sTrE8
 95gYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Considering that some drivers (e.g. pcie-dw-rockchip.c) already use the
reg-name "apb" for the device tree binding in Root Complex mode
(snps,dw-pcie.yaml), it doesn't make sense that those drivers should use a
different reg-name when running in Endpoint mode (snps,dw-pcie-ep.yaml).

Therefore, since "apb" is already defined in snps,dw-pcie.yaml, add it
also for snps,dw-pcie-ep.yaml.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
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


