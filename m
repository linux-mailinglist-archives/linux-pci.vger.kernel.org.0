Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBAA4AD19A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 07:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347489AbiBHGer (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 01:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiBHGeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 01:34:46 -0500
X-Greylist: delayed 292 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 22:34:45 PST
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A147C0401EF;
        Mon,  7 Feb 2022 22:34:45 -0800 (PST)
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 2186Lll6023885;
        Tue, 8 Feb 2022 14:21:47 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2186LPY6023863;
        Tue, 8 Feb 2022 14:21:25 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Feb
 2022 14:29:32 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Neal Liu <neal_liu@aspeedtech.com>,
        Tao Ren <rentao.bupt@gmail.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH] usb: ehci: add pci device support for Aspeed platforms
Date:   Tue, 8 Feb 2022 14:29:27 +0800
Message-ID: <20220208062927.3527137-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2186LPY6023863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable Aspeed quirks in commit 7f2d73788d90 ("usb: ehci:
handshake CMD_RUN instead of STS_HALT") to support Aspeed
ehci-pci device.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/host/ehci-pci.c | 6 ++++++
 include/linux/pci_ids.h     | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index e87cf3a00fa4..a91b25d216ae 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -222,6 +222,12 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
 			ehci->has_synopsys_hc_bug = 1;
 		}
 		break;
+	case PCI_VENDOR_ID_ASPEED:
+		if (pdev->device == PCI_DEVICE_ID_ASPEED_EHCI) {
+			ehci_info(ehci, "applying Aspeed HC workaround\n");
+			ehci->is_aspeed = 1;
+		}
+		break;
 	}
 
 	/* optional debug port, normally in the first BAR */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index aad54c666407..410b395fe56c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3096,4 +3096,7 @@
 
 #define PCI_VENDOR_ID_NCUBE		0x10ff
 
+#define PCI_VENDOR_ID_ASPEED		0x1a03
+#define PCI_DEVICE_ID_ASPEED_EHCI	0x2603
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.25.1

