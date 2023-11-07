Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E927E45B0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 17:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjKGQRe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 11:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjKGQRG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 11:17:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA0D212F;
        Tue,  7 Nov 2023 07:52:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A844C433C8;
        Tue,  7 Nov 2023 15:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372350;
        bh=PQdeMjWBwkncfmkZuUey60iMQwjzkHr+Jltm9Sh4WLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIFkyTx63Q6ChJIDMMz0BRHxSsDKkxmqpjYC4JDUweauZ0xIsNLhvv/VQJ8p+k9fM
         Q41hdOsV2n0bcD+lYLeylje7dHm8WWyE/u+i1XZi113P1bKI25dATDY4owRQseMtgd
         Jc/dsw2VX1ryLiTuPbLWPylE7ogMikGtdtfuLWKO+zPpgeqyaq7gldg0+hMZeNkyuV
         /oBjC6upMm4LNcsVoP9hh3StYlJZ83++CoQWZ6W8uwLRq1ErnzLqSSs29hLLXcaK9u
         m55lmMFn3T6jv64zTkP059Gnof1L0vI4bdtsj9W4iexIsW7Iy7whWucw9pVVvs/8FL
         SaYmciHtBx47g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lpieralisi@kernel.org,
        kw@linux.com, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 19/22] misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller
Date:   Tue,  7 Nov 2023 10:51:28 -0500
Message-ID: <20231107155146.3767610-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 6c4b39937f4e65688ea294725ae432b2565821ff ]

Add Renesas R8A779F0 in pci_device_id table so that pci-epf-test
can be used for testing PCIe EP on R-Car S4-8.

Link: https://lore.kernel.org/linux-pci/20231018085631.1121289-16-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 2ad28f1b1461c..189567bed823c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -80,6 +80,7 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774B1		0x002b
 #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
+#define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
 
 static DEFINE_IDA(pci_endpoint_test_ida);
 
@@ -995,6 +996,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
+	  .driver_data = (kernel_ulong_t)&default_data,
+	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 	  .driver_data = (kernel_ulong_t)&j721e_data,
 	},
-- 
2.42.0

