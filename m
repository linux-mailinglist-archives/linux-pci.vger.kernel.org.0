Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0C7E44DF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbjKGP6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjKGP5z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:57:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C8861A1;
        Tue,  7 Nov 2023 07:51:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81637C433C8;
        Tue,  7 Nov 2023 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372279;
        bh=Bdskuj7cjmHtUqX1smEoiU7zJDhFg5BXnyiZfJ5xHx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCXm12GJwOKuP7KUWx/V2k0fMpeWRNYf3G6ukI+niuUUPwgl18uceugKoXdHdnrF/
         xOUCRU69QQ0oGJqIofx8BraDF41nwlxpetj5GeGMq15Rusu/+WH4yXDwX6u5lqai5z
         LvkIG4UTRHR2zeZc0kPtC5XVhars/aGtCpTA1cg5y1kVQ9ILOUkDg9CTcvwp7lA+Li
         nSMQaWj9XRU58hzIX/Y8U43DOvbQhJV3VpfbKaeQeFjj/D9MIJVowljQ7Igy1T6lY6
         uagd7ccu0vNLllZU8dmARRmKMGoCS4AZUYLl1+N0zKQhfxoyxzAW1nqOAt/lvCLWr4
         kf/O5BRjRfzfA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lpieralisi@kernel.org,
        kw@linux.com, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/30] misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller
Date:   Tue,  7 Nov 2023 10:49:58 -0500
Message-ID: <20231107155024.3766950-24-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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
index d1e2f22537dbe..36a581de3330f 100644
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

