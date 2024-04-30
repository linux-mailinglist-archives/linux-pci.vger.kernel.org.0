Return-Path: <linux-pci+bounces-6873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6648A8B7533
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 14:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969D61C20A93
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3985413D26E;
	Tue, 30 Apr 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI1UUdyJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137BE13D268;
	Tue, 30 Apr 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478530; cv=none; b=YNXfQGM7LpaqPlkOmi3X5sTKPtSkvmL5U88f2Lzo5lJHHEPVDCJvO5YXUAC7Owzu/q3Eq33iNRJYcylyfPXpcIPAw9EK1DdIYHQvLCscEpaPsCBotKuKMcnLhNLmlBlvTBBm14up5ecBJqiGmkpLKuN7qsFbqXTdB60HexY+m00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478530; c=relaxed/simple;
	bh=MgvdOL0gkl34L22gpJGsJpktQEWaY6MRdjg4t+pKTZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9a7SjB3yuPHWzvmKi956lb9iTfTLBv329WpVxOzg+F7oZad+iBg6dN9E4LbUTgVbFi/P83ijYXXBGAnjA0xzs+XJ6W3k3XtpgNkUZZ4++4nSiKZXTqYp4omxVaJy02I9bbJxyKxbRvT/Vn0XpwCCTL+sUOjPnTsfjZiluTXCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI1UUdyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CF0C4AF19;
	Tue, 30 Apr 2024 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478529;
	bh=MgvdOL0gkl34L22gpJGsJpktQEWaY6MRdjg4t+pKTZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cI1UUdyJQ6nyysGSO+1CFiMo62exm3q0sFo04KTrjpmYiOW67SwkDuj9cRNXEN11s
	 wSnF0O7y79kXJwkUWHGrELr5bH+QlrU5yMipuuudfpGgSb3vA7GpSV9rzrzVBDAluN
	 VmdlApL/NjvYILsWii/g6Eye6VHZAoAeV0PeYnH1sQOLQdnag8tbSPXgpp3INP8QX+
	 PIRR2tYDbGz+bGoavGTRKAeEUj+Fq1PtCMjKfxdM4iE4ZORcpGVLyhaIqQtIRsd56I
	 77Bbcn4BowgktzugL1IPpW+k0v+9ZglQVHXFROw/sBoGUQoHvyNPhYq2OC8BeQU3Ok
	 ogZ7mR+B9cDIQ==
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 30 Apr 2024 14:01:00 +0200
Subject: [PATCH v2 03/14] dt-bindings: PCI: snps,dw-pcie-ep: Add
 tx_int{a,b,c,d} legacy irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rockchip-pcie-ep-v1-v2-3-a0f5ee2a77b6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=cassel@kernel.org;
 h=from:subject:message-id; bh=MgvdOL0gkl34L22gpJGsJpktQEWaY6MRdjg4t+pKTZ4=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIM7m74LT61fuHJ1GeOp0xSvxu7LDd9d7BFXTVe+2UK6
 42p3lLGHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIp80M/x3+/Im7ezlCNc/5
 x4Hi/z/zby/I6tylEpLMzsH59UMq11OGP/zr778T9bgTftz889UJtwrNwlkSfU4FMEx4raB5fAJ
 rGxsA
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


