Return-Path: <linux-pci+bounces-18564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E79CB9F39A2
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 20:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C516C55A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AAE206287;
	Mon, 16 Dec 2024 19:19:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D36207663
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376769; cv=none; b=XiqKbof0T0GZhkAcqMnATK0wmGFLO970EBsDh3jWSTfxCbSplGfLssaGN9JPpBQ8kcoIzeNjbbt7Nc21uRJNY4QP/tbjqDsKyzaZAgJPlvf82bTa4VTTJuFyZbxwIFiT2jz7gZIuMqe3fL4w51IiVJIt+tC3gEQtjxr7EP65dUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376769; c=relaxed/simple;
	bh=hqkrGC8unCX44MpjDo3S6+IbaSP0BST/wISUHxRLyBA=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=luWTt+U+H8d12gIklwnE1b/tbLwoShMdonU1IjpmufuFX3s2Nya02xE8me88jYEVTEu39XwLH0WlGXzF6riA8iSxnKdpRiT58ocw5H4V9799tLkPFfNy8o93FGseBa4l4Ptbbca9iZqn3qHsloelMcyDBgkxjC85Kiq6SYSD4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C199D2800BB3F;
	Mon, 16 Dec 2024 20:19:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A6F206320D2; Mon, 16 Dec 2024 20:19:16 +0100 (CET)
Message-Id: <6152bd17cbe0876365d5f4624fc317529f4bbc85.1734376438.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 16 Dec 2024 20:18:41 +0100
Subject: [PATCH v2] PCI: Update code comment on PCI_EXP_LNKCAP_SLS for PCIe
 r3.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>

Niklas notes that the code comment on the PCI_EXP_LNKCAP_SLS macro is
outdated as it reflects the meaning of the field prior to PCIe r3.0.
Update it to avoid confusion.

Reported-by: Niklas Schnelle <niks@kernel.org>
Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Only change v1 -> v2: Add closing parenthesis.
Seems there's a million ways to botch even the most trivial patch. :(

 include/uapi/linux/pci_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7e..02d0ba2 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -533,7 +533,7 @@
 #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */
 #define PCI_EXP_LNKCAP		0x0c	/* Link Capabilities */
-#define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Supported Link Speeds */
+#define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Max Link Speed (prior to PCIe r3.0: Supported Link Speeds) */
 #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
-- 
2.43.0


