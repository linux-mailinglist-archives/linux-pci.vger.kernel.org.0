Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9597E3BA0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjKGMIR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 07:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjKGMHz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 07:07:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6C173B;
        Tue,  7 Nov 2023 04:07:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD27EC433CB;
        Tue,  7 Nov 2023 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358857;
        bh=s7IkpwFkvc63VeyiRhEpqYii0TAbOTbVdNVK41uQ8yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0FAgYfUWostZTAzlsE+DFZsR9+r+CFeDugaZId5BiNY9/sCjrP6esgmarSpKltyd
         JJ0QQene7pH5PT/ReNI7HIcsWPI0HCilnPLUn+K0eQuccGger1/wOaRFaHXo0lVxzb
         5qnEDasf2aNgi8q2YvhhMA/X4AwfoXNQuw+L07+Nh7selII/fWvvUV7EVII3A4NtIP
         OP/C7yDMJAZwpkJJ9A0m1g6qNvdVFyVNiLmMkSJUUUAG8Jero6ZEO4tf3wzViUPna6
         ouiZlopoY9jrzYbDVdXkbMZpnlWg/9t9SGKE7diXG4tiPGwTRvsML8EILAarQJajau
         PfwsBtJ1fYRUQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ingo Rohloff <lundril@gmx.de>, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>, lorenzo@kernel.org,
        ryder.lee@mediatek.com, kvalo@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bhelgaas@google.com,
        deren.wu@mediatek.com, sean.wang@mediatek.com,
        quan.zhou@mediatek.com, Leon.Yen@mediatek.com,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/31] wifi: mt76: mt7921e: Support MT7992 IP in Xiaomi Redmibook 15 Pro (2023)
Date:   Tue,  7 Nov 2023 07:06:00 -0500
Message-ID: <20231107120704.3756327-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ingo Rohloff <lundril@gmx.de>

[ Upstream commit fce9c967820a72f600abbf061d7077861685a14d ]

In the Xiaomi Redmibook 15 Pro (2023) laptop I have got, a wifi chip is
used, which according to its PCI Vendor ID is from "ITTIM Technology".

This chip works flawlessly with the mt7921e module.  The driver doesn't
bind to this PCI device, because the Vendor ID from "ITTIM Technology" is
not recognized.

This patch adds the PCI Vendor ID from "ITTIM Technology" to the list of
PCI Vendor IDs and lets the mt7921e driver bind to the mentioned wifi
chip.

Signed-off-by: Ingo Rohloff <lundril@gmx.de>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
 include/linux/pci_ids.h                         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 3dda84a937175..f04e7095e1810 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -17,6 +17,8 @@ static const struct pci_device_id mt7921_pci_device_table[] = {
 		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7922),
 		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ITTIM, 0x7922),
+		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0608),
 		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9e..0328a4c01e0bf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -180,6 +180,8 @@
 #define PCI_DEVICE_ID_BERKOM_A4T		0xffa4
 #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO	0xffa8
 
+#define PCI_VENDOR_ID_ITTIM		0x0b48
+
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
 #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
 #define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
-- 
2.42.0

