Return-Path: <linux-pci+bounces-86-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900E7F3DD7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48A1B21986
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1D0156E8;
	Wed, 22 Nov 2023 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0++E1kt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD7156DF
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A5AC433C9;
	Wed, 22 Nov 2023 06:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633051;
	bh=ZdBDTbg6J81QQ48xW6Co6Ef8U/EFdtKbcKQQFJO6Y7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0++E1ktW9x6jPvaLA5zeoYkTqddSvtJFfZ2fV/s5uVaumnFa30ognDzr4VMGBtr9
	 kBE1ismQ+YXZA/lQqhc35PKOOZPxfiyHaFXB4+rEk0PWKV0SItkpP9SNXJajGQ5zO8
	 nP2dm/Y/tMF2t/GdPykWzeEqvlvDFKjk3wjgaJfblgtxBhY17i5Lb2yS3jm5QukHDt
	 RdPgKvOc0NiNRyfADHoQf0AgXPzKNd5Xr7mqojmdyoehL4CbPuwZ7h6ZrpMbCd/59m
	 oYwzMCbES4tDYwcqQ/WMYLSGnCEkNS5K2XsJ0Cnqf5j1XzroK/KfQchbJDiKQOQ39h
	 h7dGlSOlQk8HA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 01/16] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
Date: Wed, 22 Nov 2023 15:03:51 +0900
Message-ID: <20231122060406.14695-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX to be more explicit about the type
of IRQ being referenced as well as to match the PCI specifications
terms. Redefine PCI_IRQ_LEGACY as an alias to PCI_IRQ_INTX to avoid the
need for doing the renaming tree-wide. New drivers and new code should
now prefer using PCI_IRQ_INTX instead of PCI_IRQ_LEGACY.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/linux/pci.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..9ab4b46c0d19 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1073,11 +1073,13 @@ enum {
 	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
 };
 
-#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
+#define PCI_IRQ_INTX		(1 << 0) /* Allow INTx interrupts */
 #define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
 #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
 #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
 
+#define PCI_IRQ_LEGACY		PCI_IRQ_INTX /* Deprecated! Use PCI_IRQ_INTX */
+
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-- 
2.42.0


