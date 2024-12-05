Return-Path: <linux-pci+bounces-17768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9D9E581F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 15:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B656E1881302
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0D218AC2;
	Thu,  5 Dec 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="anhxgR45"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m127218.xmail.ntesmail.com (mail-m127218.xmail.ntesmail.com [115.236.127.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A61DD87C;
	Thu,  5 Dec 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407544; cv=none; b=nc5DSLre+FJsbHQlqr5vAf6vwo+NuqRl4y72T5Nb55T5thh7+Mqvh4NnLm0+1ux56TY2oMCM7C0DerU+oCbowLnKN3qvhi7pBz8tuTqtwMA8pqJRJLE9TC+/EDUCd9t+8dw9FUG30BPtkw0uSAP/eZ5WjfOjWb7lCgkqouAH9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407544; c=relaxed/simple;
	bh=ztKqQuU4KCjQJjdRSBdTN6sXF9Y/8SDDL4APxpqvSwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0oRhNjhzLg+QKMUoTj+shQjqO4oWH8RxvNRu3cEb7UKWiXFXMjjgIIilnER+iOh9CSrG5heURkeHqL/jLVD+1xQz1MUvKhtlRZl3Zfy82+lI5TMK7xX3VlPkxQBBBt6dGOsEbkNsbGb8FgTy7bxdyrbVmuEfxvtEHzKGU/3eyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=anhxgR45; arc=none smtp.client-ip=115.236.127.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cf7c95c;
	Thu, 5 Dec 2024 18:36:28 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: PCI: dwc: rockchip: Add rk3576 support
Date: Thu,  5 Dec 2024 18:36:18 +0800
Message-Id: <20241205103623.878181-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205103623.878181-1-kever.yang@rock-chips.com>
References: <20241205103623.878181-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hIGVZDGB4eGU5DThlCTB1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a9396647c2a03afkunm4cf7c95c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Qjo*KzIYMw0JHyMVCxgs
	Qg0aCRxVSlVKTEhISEJPQkNCT05MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTEs3Bg++
DKIM-Signature:a=rsa-sha256;
	b=anhxgR45JOFGpKYa1kzJdcLz3u+TUdMFwNCxoA87+DdTw61fMspve3iNy1DjZNhpoUElFzHHaz82zHL/Z7AnKOKMpXZMAl5h37qDmi3Tli1Onw+YUAyoEGzB16SWA9y9CMV9CqPGeRf/zwOMOWkE2rdkuziEzOT1ib+2lh0C/Ic=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=HjmVk9gKLzWJyLcAvjRtiVX8Ir6tmlI7JsF/W31nlu4=;
	h=date:mime-version:subject:message-id:from;

rk3576 is using the same controller as rk3568.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 550d8a684af3..5328ccad7130 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -26,6 +26,7 @@ properties:
       - const: rockchip,rk3568-pcie
       - items:
           - enum:
+              - rockchip,rk3576-pcie
               - rockchip,rk3588-pcie
           - const: rockchip,rk3568-pcie
 
-- 
2.25.1


