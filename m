Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10E878DB70
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbjH3SjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbjH3LYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 07:24:36 -0400
Received: from out-252.mta0.migadu.com (out-252.mta0.migadu.com [IPv6:2001:41d0:1004:224b::fc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F6CD7
        for <linux-pci@vger.kernel.org>; Wed, 30 Aug 2023 04:24:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693394144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLVdHbG85+44P7qsiRYYVxfolXMOcHBsopMctAcePck=;
        b=J59qCFT0OBGdEmbDi4JY96Y0g2lOm/hwpx206PWQver8wN02CSpISQoonof/5wEaRuSTR5
        ouCPVB3GdJM3Uyt4LGtJGwvB4wkGB4hupMSzjpaR//dtI0uBmIqZbmOBuyKnZ/kB5JxLUi
        kgv1cwNYtl3n58wormShqGG2v91FWKM=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [-next 1/5] PCI: Add the pci_is_vga() helper
Date:   Wed, 30 Aug 2023 19:15:28 +0800
Message-Id: <20230830111532.444535-2-sui.jingfeng@linux.dev>
In-Reply-To: <20230830111532.444535-1-sui.jingfeng@linux.dev>
References: <20230830111532.444535-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The PCI code and ID assignment specification defined four types of
display controllers for the display base class(03h), and the devices
with 0x00h sub-class code are VGA devices. VGA devices with programming
interface 0x00 is VGA-compatible, VGA devices with programming interface
0x01 are 8514-compatible controllers. Besides, PCI_CLASS_NOT_DEFINED_VGA
is defined to provide backward compatibility for devices that were built
before the class code field was defined. Hence, introduce the pci_is_vga()
helper, let it handle the details for us. It returns true if the PCI(e)
device being tested belongs to the VGA devices category.

Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 include/linux/pci.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index cf6e0b057752..ace727001911 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -713,6 +713,33 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
 		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
 }
 
+/**
+ * The PCI code and ID assignment specification defined four types of
+ * display controllers for the display base class(03h), and the devices
+ * with 0x00h sub-class code are VGA devices. VGA devices with programming
+ * interface 0x00 is VGA-compatible, VGA devices with programming interface
+ * 0x01 are 8514-compatible controllers. Besides, PCI_CLASS_NOT_DEFINED_VGA
+ * is defined to provide backward compatibility for devices that were built
+ * before the class code field was defined. This means that it belong to the
+ * VGA devices category also.
+ *
+ * Returns:
+ * true if the PCI device is a VGA device, false otherwise.
+ */
+static inline bool pci_is_vga(struct pci_dev *pdev)
+{
+	if (!pdev)
+		return false;
+
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+		return true;
+
+	if ((pdev->class >> 8) == PCI_CLASS_NOT_DEFINED_VGA)
+		return true;
+
+	return false;
+}
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
-- 
2.34.1

