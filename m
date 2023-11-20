Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42CE7F1820
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 17:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjKTQGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 11:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjKTQF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 11:05:59 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA3EAA
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uJXLwyehp0lxE2TjY9S/gAjQUQ3QLZ80CgpLAdjxHh4=; b=FlFgFeO/8oRLccPdwMFtGugUYn
        tACchHYoyeN9POoy0TDSANNa41fsTgqmJGrfSQfHYIHn6vxlDvkG1OGgtYKLt0fAihiYfakPjUQKo
        HG6AcBjgBWoSFOCXMVGPKzavpLrPeDSrKwgfw40CJBhmDy3Y1eIOQ/DQQLVYMA6kGSNy3fkCMSGn+
        JTEjHoIrhhQN68doZzVLPQ3yHMXqDS1XyiFWhrdCWfWBfgW/rS5Dp271LHA+dPVaA2ntNN5TKZeOT
        715hazeAbw19/N1+8dE88q/gFQZiaLOC4gJltmXnTfJnGCX9ISkjZSGq62etyjdAo6rGDTB+nHzf7
        CzOCfGNg==;
Received: from 201-92-23-2.dsl.telesp.net.br ([201.92.23.2] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1r56mR-005IKe-RE; Mon, 20 Nov 2023 17:05:48 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, kernel@gpiccoli.net, kernel-dev@igalia.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Huang Rui <ray.huang@amd.com>, Vicki Pfau <vi@endrift.com>
Subject: [PATCH] PCI: Only override AMD USB controller if required
Date:   Mon, 20 Nov 2023 13:04:36 -0300
Message-ID: <20231120160531.361552-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

By running a Vangogh device (Steam Deck), the following message
was noticed in the kernel log:

"pci 0000:04:00.3: PCI class overridden (0x0c03fe -> 0x0c03fe) so dwc3 driver can claim this instead of xhci"

Effectively this means the quirk executed but changed nothing, since the
class of this device was already the proper one (likely adjusted by
newer firmware versions).

Hence, let's just check and perform the override only if necessary.

Cc: Huang Rui <ray.huang@amd.com>
Cc: Vicki Pfau <vi@endrift.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/pci/quirks.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..4e3bb1643b09 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -702,10 +702,13 @@ static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
-	/* Use "USB Device (not host controller)" class */
-	pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
-	pci_info(pdev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
-		 class, pdev->class);
+	if (class != PCI_CLASS_SERIAL_USB_DEVICE) {
+		/* Use "USB Device (not host controller)" class */
+		pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
+		pci_info(pdev,
+			"PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
+			class, pdev->class);
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_dwc_class);
-- 
2.42.0

