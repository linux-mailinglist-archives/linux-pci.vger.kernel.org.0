Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00C3610831
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 04:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiJ1CiB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 22:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiJ1Ch3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 22:37:29 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 766E0A474;
        Thu, 27 Oct 2022 19:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zqkmr
        0wA7VhQA95CKLsLqZlQw5p80Szn0PM+lT5Es9U=; b=Jn2N7yUuCkWpV+D6wJUsq
        QlXBH73ICQNd2e74cmEbhfANjsZaNAsAHPGP5ff8cZbmlkBkHEuCFfII5/RQJr8B
        LAlsKha++y6hz6lIJFpa3rfu11Cwji7Ag7TDFuigYIgPAiqCk5n5qgFrqM1p3F5A
        US09HfBkKlFJ2IM4MrZPpY=
Received: from jbd-ThinkPad-X1-Nano-Gen-1.. (unknown [223.104.77.214])
        by smtp7 (Coremail) with SMTP id C8CowADXe9VaQFtjLOfMOQ--.4894S2;
        Fri, 28 Oct 2022 10:37:16 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] PCI: Add vendor ID for Quectel and Cinterion
Date:   Fri, 28 Oct 2022 10:37:11 +0800
Message-Id: <20221028023711.4196-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowADXe9VaQFtjLOfMOQ--.4894S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1UWw47tFy5CF4DZF4rAFb_yoW8GryfpF
        s8CrWktr48JFW7Gw1vyr1DWF9FvFs0kFn8AF1agw4F9F47Xw48XryUArs0kryagFs2qrW5
        XF1DCws0ga4DXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pioUDkUUUUU=
X-Originating-IP: [223.104.77.214]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRxyoZFc7ZFzyLAAAsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In MHI driver, there are some companies product still do not have their
 own PCI vendor macro. So we add it here to make the code neat. Ref ID
 could be found in link https://pcisig.com/membership/member-companies
 and https://pciids.sourceforge.net/pci.ids . Thales use Cinterion as
their IOT modem card's trademark. So you will find 0x1269 belongs to
Thales. Actually, Cinterion belongs to Gemalto, and Gemalto belongs to
 Thales.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 include/linux/pci_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..9e2b6286f53f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1765,6 +1765,8 @@
 #define PCI_VENDOR_ID_SATSAGEM		0x1267
 #define PCI_DEVICE_ID_SATSAGEM_NICCY	0x1016
 
+#define PCI_VENDOR_ID_CINTERION		0x1269	/* Celluar Modules*/
+
 #define PCI_VENDOR_ID_ENSONIQ		0x1274
 #define PCI_DEVICE_ID_ENSONIQ_CT5880	0x5880
 #define PCI_DEVICE_ID_ENSONIQ_ES1370	0x5000
@@ -2585,6 +2587,8 @@
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
+#define PCI_VENDOR_ID_QUECTEL		0x1eac
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.34.1

