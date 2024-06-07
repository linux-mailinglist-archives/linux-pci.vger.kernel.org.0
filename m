Return-Path: <linux-pci+bounces-8449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462CE9001BA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EB61C213E3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFCC18733B;
	Fri,  7 Jun 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjWK+86C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EE14F11B;
	Fri,  7 Jun 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758884; cv=none; b=kNEpGEbEHNUJeO2Qwpud8M87mATkiU8FT05iaOLf/qLr7jZ3bw6agmxynmZhtZUejR76wgo/yUclwtS3ka6zpdrSC/1okMzzXObjn+90jNBmkeYkpNIbVRVij0s3HAHY1PasGCFFyiXxjMNb+J/N7bRROP4juYq3blOEwG0Zdlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758884; c=relaxed/simple;
	bh=0ArQlCvHIIXLagRFXrfsGxVZ7s8NLv5FvY16U5TNFcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peHC22Zx+2Oeb0kYarO2HmnAgEXneFDokrGq0ltWlQGDJDHmLhltyZbResFgrQ0BGv/RkQHPTFQD0fOnZxQGQlhw1x3ZKHAd9TXml/rfIo2tRYOT2gfVBnGP4hCybZJn/TXD83YrDLCDwUh4Eanl2CJkioUdc6x6dWKeR1vfz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjWK+86C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76AEC4AF07;
	Fri,  7 Jun 2024 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758883;
	bh=0ArQlCvHIIXLagRFXrfsGxVZ7s8NLv5FvY16U5TNFcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EjWK+86C+IwPuNGJ7G+aL7euUVjHMwR59DX3jnJpNUG1O/hTyiGLWMU+MeC8Hpwil
	 AM0JYpXAqtXeEGrmvwnWfDzAiSwoUgnQg1UgyVGpMOKbSCN0V0FDzew4SugzySNxdl
	 sUaEXbg0zmZBQb2Z6Gxf4lHu2ovz2lQRSHjEBYVeqKPbkS1/lt7nY3VK8KQT1eEKSy
	 n71rCrI6fc36H47rYeot953Yjhg9Prx8KsBgXw+c+oei1oTd3VD9QegrVHNONiVofD
	 oSTcgspYBGNBpE6sjv3tp+5W9LtGfoAhwbNcdknj8vYhyo2mtz/tatQGkVCJv1t5DN
	 QIBjfcwC/hA3A==
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 07 Jun 2024 13:14:23 +0200
Subject: [PATCH v5 03/13] dt-bindings: PCI: snps,dw-pcie-ep: Add
 tx_int{a,b,c,d} legacy irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-rockchip-pcie-ep-v1-v5-3-0a042d6b0049@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=cassel@kernel.org;
 h=from:subject:message-id; bh=0ArQlCvHIIXLagRFXrfsGxVZ7s8NLv5FvY16U5TNFcc=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKSXk+sbPnG7ZJUeUrxxCWWArn4Vy5lczRk5j3WfJKyY
 01Of8jPjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzk3WJGhmkBL7V+iqUvfhIv
 KPmm88ZKz68t5ev+Zm2c/MEn+lu84gqGf+p8/1MnyVxW7mzhOJLU67/mmeXr78ZXX8g8FA5f8sw
 8hBcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

The DWC core has four interrupt signals: tx_inta, tx_intb, tx_intc, tx_intd
that are triggered when the PCIe controller (when running in Endpoint mode)
has sent an Assert_INTA Message to the upstream device.

Some DWC controllers have these interrupt in a combined interrupt signal.

Add the description of these interrupts to the device tree binding.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
2.45.2


