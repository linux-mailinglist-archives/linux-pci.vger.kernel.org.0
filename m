Return-Path: <linux-pci+bounces-5475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5D8939E4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1703EB21E12
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC6C11C94;
	Mon,  1 Apr 2024 10:01:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDB10A3E;
	Mon,  1 Apr 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965667; cv=none; b=b3LGAWim9uIbGT6dFDnHKGiZLJSfoE+eE3FSXTU1zBDtmbAlV4PvDS+btWJM24E0SwfopRR297bHjMLMZbFlBNsqYuakrrkhRvxDncX+gO5PSqIc0eAQkIBaaNyD7uFY9m58paaPrpHGKJBcU1Gx1zmh/2VjxhuPTna7D8Z3tHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965667; c=relaxed/simple;
	bh=7nXZN2LsejGXwaK9gE1a3Pn8vtiq9m6Dr+peuqIJnjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LsICY3eyhlFlidMD6jg0YrtJkTLgG4Y6kJOG5ytTSKBkX2W20gBlB7dLfbS/icADczEK4V+ouTGldXJJKZlUPSycITiljy8cdpZik7lTXTAbd6m5/vctJfjFrkV/nCeEbrYP6Ixwb+cD34XZc5ww/2oSfAui5jv481bu3JoaFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150F2C433F1;
	Mon,  1 Apr 2024 10:01:02 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: PCI: rockchip,rk3399-pcie: add missing maxItems to ep-gpios
Date: Mon,  1 Apr 2024 12:00:58 +0200
Message-Id: <20240401100058.15749-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with GPIOs should define number of actual GPIOs, so add
missing maxItems to ep-gpios.  Otherwise multiple GPIOs could be
provided which is not a true hardware description.

Fixes: aa222f9311e1 ("dt-bindings: PCI: Convert Rockchip RK3399 PCIe to DT schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
index 531008f0b6ac..002b728cbc71 100644
--- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
@@ -37,6 +37,7 @@ properties:
     description: This property is needed if using 24MHz OSC for RC's PHY.
 
   ep-gpios:
+    maxItems: 1
     description: pre-reset GPIO
 
   vpcie12v-supply:
-- 
2.34.1


