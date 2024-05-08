Return-Path: <linux-pci+bounces-7229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B2C8BFE3B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2EE284FED
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6379B9D;
	Wed,  8 May 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWp/ga5o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE678C93;
	Wed,  8 May 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174033; cv=none; b=nPRKQd1G54aP/2rllf0xqKzkpJ0ERla982JwkVflNk0tTFAUpf5ScY/clcRNF+cr8jb2IQmQHcQ9R4e8NCyK3mGKqWZxmpjS6uv0hTXezbnwWNkJP2SNeCftS6cGMBdPe84mhIpRu0fzoSbzRm2fQ9nGEKYyHQR6xBIIhA212Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174033; c=relaxed/simple;
	bh=MgvdOL0gkl34L22gpJGsJpktQEWaY6MRdjg4t+pKTZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhN728Cb1FxV5OAYYRJ+gkFBiwhatLZypm080FB3giJJpBP1VBh5xR+6ou8vsGokDMMwdNeZ3WW9/NWU1mkHrqkRhW0KeNPLH0T8v1Ff48jpv+tA6Lq207mAHZP4oAJEiK06rsFF/X6ymrT2hyTNX/s4FqWvbEw/+c9PKxM02sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWp/ga5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02497C4AF17;
	Wed,  8 May 2024 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174032;
	bh=MgvdOL0gkl34L22gpJGsJpktQEWaY6MRdjg4t+pKTZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MWp/ga5oYYhuhUuKZDoLkl/rFYoZag8NsD/mXlXNRnohf6K4fLhjIv2ZwEEMcZehI
	 Hq28Y/GVHu0r1Y12YNx2w140fGNKW++aPLiEN5JgnFji+erhABO0be7JiPP7mtn11R
	 TBog3YXMbmq+ku7tCuUIgc9T5eD2Nze3suHv63bW5juJwmc3bqBTKsdJ1Dl2c5CTCP
	 A3fu6403yxPBLFTj8NktiRmTYa/OBMN2PbIlIQEOo1l2+J4buWab491QPMlv0Fpqj2
	 075dcTnI4mjXH1iswEoF200gjtcizHkHfaEZObi6xIPNPvOEGbHeH8jRYrfgTrJjl+
	 A3lQmGhIHUe+g==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:34 +0200
Subject: [PATCH v3 03/13] dt-bindings: PCI: snps,dw-pcie-ep: Add
 tx_int{a,b,c,d} legacy irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-3-1748e202b084@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=cassel@kernel.org;
 h=from:subject:message-id; bh=MgvdOL0gkl34L22gpJGsJpktQEWaY6MRdjg4t+pKTZ4=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKsq+q7TFws30Rt9nm8izPnqOVq3SmGvZ3f1ylKb9l9M
 effPDbdjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkynJGhkn6x7VVf4avFxBJ
 nbaDa9ma1ueHuVfOuHfxhOke3tBIuceMDL9aP8+u3797x/x/rawf7wn/lti778z790s45RUmxsZ
 PusMHAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

The DWC core has four interrupt signals: tx_inta, tx_intb, tx_intc, tx_intd
that are triggered when the PCIe controller (when running in Endpoint mode)
has sent an Assert_INTA Message to the upstream device.

Some DWC controllers have these interrupt in a combined interrupt signal.

Add the description of these interrupts to the device tree binding.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
2.44.0


