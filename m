Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9DD58093F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 04:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiGZCFk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 22:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiGZCFk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 22:05:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE59586
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 19:05:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 6so11905792pgb.13
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 19:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcLN0/0rRk3ozwmqISVR6hRqPCsf6L35JebQehRi1LA=;
        b=nTioK+/s3DBU4jhK/bp6W9HoNaLbn9VTPFlcs/nnOeaSY3yYsAwlorbKuiVR7waFli
         AxujWyUJgbFWM1RSWzgWAot6NAd4pZCKLsDvc0HoF7s+VR5bgVgLdNXLJPLxIyzHIRK4
         dZTAKNdgCB93tMvwtYmp03T0eThljIHTh6fSfcaZulw0c/dHrvS+dfJJOU2Vek4SJ9P9
         RIm02AJVXfyvtCeoZx6qBZIxr8dWPSUmMt8ey9XYpzEl4vsh4ETs7Jwhzi3CAIH58g4Z
         je5gG6n2jX+D76groH6t8w6Ym4ZwYL7z4ZhI/ZxwWmin5anmjrCyI5e1VsfJpb2RWXti
         1jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcLN0/0rRk3ozwmqISVR6hRqPCsf6L35JebQehRi1LA=;
        b=nydI3SOf2vEFbB/D3nAHZOQFq7vmxCwVDMTlPtADC06WCcEnHvR6YAX66lgolGoR0M
         nIHsV68DyDdjh+FHNNrVxwHRz4+Dqwk7rT/DQm8ONqcv/WTpjJQHoj/zB1PzANfxtPy1
         uO6tYmF0b0ztGJxqtv5PGJDTAbcEzdkmMUNN/ACQ4NKeEq8arz+/gMPM+Cf9MnS6Hdt0
         lDy3kxLBpZLAZ1dM1Rm9TJ0+cPTsdxiVK0ftj9XkAnphLYdpT4VCdLyAzBfIsQFmzAwi
         vMvrijmyyCP00G6hqFr5E1ezQ/yEyQ++1U5fqna6K+qX5P6lguMwZBOL8zJ11ezLcf/3
         dmWQ==
X-Gm-Message-State: AJIora8+W6RRGsyxzF5gjzIUQ6qhVmXYuyCSuzqUbHRh3psRJ85Usu2h
        57sXgTlRZ22OUWuR6IRbw98dwg==
X-Google-Smtp-Source: AGRyM1tN5cI8PLb9GQMnAmTK897rbjPgqmQUBbRdtqBmGzc3THxBtOvtBkrHDhPlskpkikFyhQ/6Lw==
X-Received: by 2002:a62:7bd7:0:b0:52b:1d57:e098 with SMTP id w206-20020a627bd7000000b0052b1d57e098mr15017966pfc.19.1658801138825;
        Mon, 25 Jul 2022 19:05:38 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm9834200pln.110.2022.07.25.19.05.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 19:05:38 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     chenzhuo.1@bytedance.com, lukas@wunner.de, jan.kiszka@siemens.com,
        stuart.w.hayes@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/ERR: Use pcie_aer_is_native() to judge whether OS owns AER
Date:   Tue, 26 Jul 2022 10:05:27 +0800
Message-Id: <20220726020527.99816-1-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The AER status of the device that reported the error rather than
the first downstream port is cleared after commit 7d7cbeaba5b7
("PCI/ERR: Clear status of the reporting device"). So "a bridge
may not exist" which commit aa344bc8b727 ("PCI/ERR: Clear AER
status only when we control AER") referring to is no longer
existent, and we just use pcie_aer_is_native() in stead of
"host->native_aer || pcie_ports_native".

pci_aer_clear_nonfatal_status() already has pcie_aer_is_native(),
so we move pci_aer_clear_nonfatal_status() out of
pcie_aer_is_native().

Replace statements that judge whether OS owns AER in
get_port_device_capability() with pcie_aer_is_native(), which has
no functional changes.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
v2:
- Add details and note in commit log
---
 drivers/pci/pcie/err.c          | 12 ++----------
 drivers/pci/pcie/portdrv_core.c |  3 +--
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 0c5a143025af..28339c741555 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -184,7 +184,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	int type = pci_pcie_type(dev);
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
@@ -237,16 +236,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast resume message\n");
 	pci_walk_bridge(bridge, report_resume, &status);
 
-	/*
-	 * If we have native control of AER, clear error status in the device
-	 * that detected the error.  If the platform retained control of AER,
-	 * it is responsible for clearing this status.  In that case, the
-	 * signaling device may not even be visible to the OS.
-	 */
-	if (host->native_aer || pcie_ports_native) {
+	if (pcie_aer_is_native(dev))
 		pcie_clear_device_status(dev);
-		pci_aer_clear_nonfatal_status(dev);
-	}
+	pci_aer_clear_nonfatal_status(dev);
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
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

