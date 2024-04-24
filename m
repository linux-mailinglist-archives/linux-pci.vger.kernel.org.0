Return-Path: <linux-pci+bounces-6635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38968B0DC4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56C21C24CCE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C0515EFD5;
	Wed, 24 Apr 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHA53oSZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152015EFC7;
	Wed, 24 Apr 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971811; cv=none; b=uQayiTd1JVtMQyKNPqpJiPRZRiMdBhPz/8oUTuqxHvmacDXINijSDThYKzCAdqEafGuDEw/eDYqQzWF/T7REzyCrAUi/FlIgcABr+ltP76GfFwaldFR98vdJlBS8IpwT5U5O/LVIOXKJGIcwbZczoXu8QVAiD7VYHtBr15gbbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971811; c=relaxed/simple;
	bh=h8lnjPbesIZKEXHuDY56KI4CbN9QDflC/gTeCl9JudA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKVv+YIMZdhsz62NKgblbjT9uminopzaZ92MDNvIdIemJP7QN9lP6J3Ba269sjMhru3xVOTmNfAF5EsLBVUwGGKBNUKCA7APVbh/IogoOIzf7OwHTa0DpD4eOFCJNwwqZwAxusG9X9Jjo1t9DXXTI2UES4p/afw1CXlFnFXHDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHA53oSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE887C32781;
	Wed, 24 Apr 2024 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971811;
	bh=h8lnjPbesIZKEXHuDY56KI4CbN9QDflC/gTeCl9JudA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XHA53oSZ7HyiUp4IAUWEw8wRCx+ZM0y3zs0Aq4CKgm+ETKtBdkuB2N7ce5+FAmY6J
	 gM+qCM1ye1y1JHOr4sFciA73zR1xoqKVoud9jcIvlGcsAho+5Qx3oJYiuDSUT3dlnP
	 cJTkdwmsX0sV6zYMsgoa+wTm+/r0ha6lbTwvVbG3JkMRBeZ9an+dqoVqLXeeI0LyDA
	 CxtFUKXeEnlr8fG5yiWSy+9U4Skyb+CcVMpp4v17McnWzgioqPqiWimMWiYhvpOE+v
	 XvhzeLEZqIihXRNbzU/6U7v0e6FOBpjPX6rQ1FBJpOFOk4PGHO9Fn6YCuZ4WELK93j
	 JLDn4sotDNnEQ==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:21 +0200
Subject: [PATCH 03/12] dt-bindings: PCI: snps,dw-pcie-ep: Add
 tx_int{a,b,c,d} legacy irqs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-3-b1a02ddad650@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=cassel@kernel.org;
 h=from:subject:message-id; bh=h8lnjPbesIZKEXHuDY56KI4CbN9QDflC/gTeCl9JudA=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYIyuX1M4iyl5kbPlyyRFG6csmCyVPqcrEyVz0+KZ
 LeryZR1lLIwiHExyIopsvj+cNlf3O0+5bjiHRuYOaxMIEMYuDgFYCJKNxgZ3qyvzDBjrqlh2BRh
 p3hjh4Cy+mXbift6BFv3uiwqtDLYzfDPIOLpNPVvLR52NUKhFx8sPZygb52tt+LHI+dHjMLNC5K
 5AA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

The DWC core has four interrupt signals: tx_inta, tx_intb, tx_intc, tx_intd
that are triggered when the PCIe controller (when running in Endpoint mode)
has sent an Assert_INTA Message to the upstream device.

Some DWC controllers have these interrupt in a combined interrupt signal.

Add the description of these interrupts to the device tree binding.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
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


