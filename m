Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBCD587626
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 06:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiHBEIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 00:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHBEIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 00:08:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630A19C06
        for <linux-pci@vger.kernel.org>; Mon,  1 Aug 2022 21:08:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id iw1so12314445plb.6
        for <linux-pci@vger.kernel.org>; Mon, 01 Aug 2022 21:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qt2lrz7hBi6/NHKhZYMSJYVUWY56n9uxWwwqraR3638=;
        b=rpCpGLlLp7TBtQ479cZ7kwRr9lCjE+DaLznlPfNFZu01VkPz1WwcASUTwlw1Bweluo
         jXkYKLsDxBsWEDMBp73X7qDXF1L60OJeyvIuShjF/k1o1KeTPFOxyxlNd3PquLOKnJkH
         +5ymXZtQ9nLxD0+xsUB3xAHJXC/8116SdFPoQOeOcpBZjPGsokL66mz3v+M9IJ07peAL
         CQRZfNAU5xFYMCWJldyjxal32EFt0rOJWA8XHb/NY6E0OToq1QINeBh9zcJpZD1DWQHw
         LdIe1ckvpddfm5pqA18mn0Ti5O9Ri29pmza/EvlfqtfdRHicttKir5eRMXZpz55MXpdJ
         ybjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qt2lrz7hBi6/NHKhZYMSJYVUWY56n9uxWwwqraR3638=;
        b=rBXDrOAdwlEaprt2ynVyhkrwPxXXNpgDL1ls808GtfBVmne+VCjS2vHx7GDVJYvZry
         ab8V2CRjfmBb/6yGoSOEpS8f5TPH7j85rp8hC52MiV3xDutPnwaQUUtvaqX2j4tzD+NU
         RTo6/YAx+Rhqy4cM1jj4stZRjS8Cef1JMSo02UfAt46BbTshoHSpqAZiB2vqZl9jr2ro
         UP6M2+lbRMR8CsuylL4DwVhj4ViajU1R2P+XI1lPIg5kPWvepw40FfKsVW9WIEb1rthW
         PbFZ2dEvJDOccfU9Y2OggbBH+5k0fV0jeiMUz2jRA3ruESVGLkiQH3MnA5qIvC95R9dK
         s23w==
X-Gm-Message-State: ACgBeo3uqud7w8GMQDV+N8CFuxlBE9WegblL7Payk/Jlmg7YiHGjfdYG
        WXF8+kfF/2yIMssOn9hap94RWQ==
X-Google-Smtp-Source: AA6agR5cH95rwmZABqpRvDzA2yYBgzz7vgM9rP0eLpQPg/wXljKfQHFd3F9EZLzviOll+6w4XaXFIw==
X-Received: by 2002:a17:902:e5c3:b0:16e:d968:634e with SMTP id u3-20020a170902e5c300b0016ed968634emr11974551plf.80.1659413319426;
        Mon, 01 Aug 2022 21:08:39 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id m18-20020a63f612000000b003fba1a97c49sm8238014pgh.61.2022.08.01.21.08.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Aug 2022 21:08:39 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     chenzhuo.1@bytedance.com, lukas@wunner.de, jan.kiszka@siemens.com,
        stuart.w.hayes@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] PCI/ERR: Use pcie_aer_is_native() to judge whether OS owns AER
Date:   Tue,  2 Aug 2022 12:08:30 +0800
Message-Id: <20220802040830.28514-1-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pcie_aer_is_native() in place of "host->native_aer ||
pcie_ports_native" to judge whether OS has native control of AER
in aer_root_reset() and pcie_do_recovery().

Replace "dev->aer_cap && (pcie_ports_native || host->native_aer)" in
get_port_device_capability() with pcie_aer_is_native(), which has no
functional changes.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
Changelog:
v4:
- Use pcie_aer_is_native() instead in aer_root_reset().
v3:
- Simplify why we use pcie_aer_is_native().
- Revert modification of pci_aer_clear_nonfatal_status() and comments.
v2:
- Add details and note in commit log.
---
 drivers/pci/pcie/aer.c          | 5 ++---
 drivers/pci/pcie/err.c          | 3 +--
 drivers/pci/pcie/portdrv_core.c | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 7952e5efd6cf..796810c49008 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1383,7 +1383,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	int type = pci_pcie_type(dev);
 	struct pci_dev *root;
 	int aer;
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	u32 reg32;
 	int rc;
 
@@ -1404,7 +1403,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	 */
 	aer = root ? root->aer_cap : 0;
 
-	if ((host->native_aer || pcie_ports_native) && aer) {
+	if (pcie_aer_is_native(dev) && aer) {
 		/* Disable Root's interrupt in response to error messages */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
@@ -1423,7 +1422,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 			pci_is_root_bus(dev->bus) ? "Root" : "Downstream", rc);
 	}
 
-	if ((host->native_aer || pcie_ports_native) && aer) {
+	if (pcie_aer_is_native(dev) && aer) {
 		/* Clear Root Error Status */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
 		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 0c5a143025af..121a53338e44 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -184,7 +184,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	int type = pci_pcie_type(dev);
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
@@ -243,7 +242,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * it is responsible for clearing this status.  In that case, the
 	 * signaling device may not even be visible to the OS.
 	 */
-	if (host->native_aer || pcie_ports_native) {
+	if (pcie_aer_is_native(dev)) {
 		pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
 	}
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 604feeb84ee4..98c18f4a01b2 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -221,8 +221,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
+	if (pcie_aer_is_native(dev) && pci_aer_available()) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
-- 
2.30.1 (Apple Git-130)

