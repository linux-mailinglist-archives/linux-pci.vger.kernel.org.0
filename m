Return-Path: <linux-pci+bounces-18490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D49F2C14
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 09:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F5067A2E03
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894321F709A;
	Mon, 16 Dec 2024 08:38:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B31FF615
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338320; cv=none; b=Z8qDob9Ag5tKAvRuvS6DTTZxFMtJhBkNDZJZFXS+LRUCJldjEjMmIIgN4w7wqA3hT6TsJ+jgaP8131PXmUjK4USenRceaH+sxgDDnmU3AumA/RBgFvarC1meor026pKCEVoGXjR0YMxrNIexI+nJFv+Fm7mGa3FKFNNep7nTLnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338320; c=relaxed/simple;
	bh=RHUufyQouFfc9Yt63kJIBMpJSz6NHu1pZSISb5Gqb+0=;
	h=Message-Id:From:Date:Subject:To:Cc; b=sG/QVu7UU2qiYufrhPsgk67/lcZjVP88S4Eeee1ds+AUchg4/83AmOZuE7JDYMgRr3zM0xoIQ1T0ajgoJG61eeivcNuE9K6Fw1lyiHAY8PICZ68fIGXPaDXc3YMArTE9svIgtg5laCTS1WSqvdk9ePwGCuXCkl+SKD09fw3gTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id F3CC02800B74B;
	Mon, 16 Dec 2024 09:38:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DE3304A5CC3; Mon, 16 Dec 2024 09:38:33 +0100 (CET)
Message-Id: <ceb8f672fa834c96b7287b7f74fb60b166be109e.1734338101.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 16 Dec 2024 09:38:21 +0100
Subject: [PATCH] PCI: Update code comment on PCI_EXP_LNKCAP_SLS for PCIe r3.0
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Niklas notes that the code comment on the PCI_EXP_LNKCAP_SLS macro is
outdated as it reflects the meaning of the field prior to PCIe r3.0.
Update it to avoid confusion.

Reported-by: Niklas Schnelle <niks@kernel.org>
Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 include/uapi/linux/pci_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7e..521a04e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -533,7 +533,7 @@
 #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */
 #define PCI_EXP_LNKCAP		0x0c	/* Link Capabilities */
-#define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Supported Link Speeds */
+#define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Max Link Speed (prior to PCIe r3.0: Supported Link Speeds */
 #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
-- 
2.43.0


