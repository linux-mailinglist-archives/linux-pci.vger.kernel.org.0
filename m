Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66A7B0D6F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 22:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjI0U2f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjI0U2e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 16:28:34 -0400
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 13:28:32 PDT
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB97B121
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 13:28:32 -0700 (PDT)
Received: from nebulosa.vulpes.eutheria.net (unknown [50.47.218.115])
        by endrift.com (Postfix) with ESMTPSA id ACBDBA248;
        Wed, 27 Sep 2023 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
        t=1695846157; bh=wz9ndXaXveE1z5VyiNbE1AGAf1gjdNchTTU091F7s2M=;
        h=From:To:Cc:Subject:Date:From;
        b=Fc8IBoYG2kLnI/97i0I6aNW+j7u28kyiDpWlcNHfck3yl8lDgELMQ5518xjn8rMgY
         NMZliM8D2POlLjtDwhrezgYCw2vmJbZv4XBf2CDmx0q7oF9UlDycY+D0/WSCpUqpLH
         nzOgtox0cGvbvfpC0fXMkjhKSGOaBYyxSJttl1iiPF+xr/q8Aun1wPQOMd17A+Ciye
         vLSpAnufQUW1vV8Ka8yuDElZoGWg2SvsX06OCb0QvagjcgnpZXA/tosHE98wxNGRA0
         0zDPOEwIeX4lUXZKB0dHHJIn9+B3NUjQBVWXKjqoIn7l4tfo0Sx34fQvVhBX5RuSC7
         lt9GzL1FOgM3g==
From:   Vicki Pfau <vi@endrift.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Vicki Pfau <vi@endrift.com>
Subject: [PATCH] PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device
Date:   Wed, 27 Sep 2023 13:22:12 -0700
Message-ID: <20230927202212.2388216-1-vi@endrift.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The AMD VanGogh SoC contains a DesignWare USB3 Dual-Role Device that can be
operated as either a USB Host or a USB Device, similar to on the AMD Nolan
platform. A quirk was previously added to let the dwc3 driver claim the device
since it provides more specific support. This commit extends that quirk to
include the equivalent PID for the VanGogh SoC.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/pci/quirks.c    | 8 +++++---
 include/linux/pci_ids.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..e3e915329510 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -690,7 +690,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
 /*
  * In the AMD NL platform, this device ([1022:7912]) has a class code of
  * PCI_CLASS_SERIAL_USB_XHCI (0x0c0330), which means the xhci driver will
- * claim it.
+ * claim it. The same applies on the VanGogh platform device ([1022:163a]).
  *
  * But the dwc3 driver is a more specific driver for this device, and we'd
  * prefer to use it instead of xhci. To prevent xhci from claiming the
@@ -698,7 +698,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
  * defines as "USB device (not host controller)". The dwc3 driver can then
  * claim it based on its Vendor and Device ID.
  */
-static void quirk_amd_nl_class(struct pci_dev *pdev)
+static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
@@ -708,7 +708,9 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
-		quirk_amd_nl_class);
+		quirk_amd_dwc_class);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VANGOGH_USB,
+		quirk_amd_dwc_class);
 
 /*
  * Synopsys USB 3.x host HAPS platform has a class code of
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9..3a8e24e9a93f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -579,6 +579,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
+#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.42.0

