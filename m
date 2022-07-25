Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4B580260
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 18:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiGYQCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 12:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiGYQCW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 12:02:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335E913F98
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 09:02:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so13092197pjj.5
        for <linux-pci@vger.kernel.org>; Mon, 25 Jul 2022 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKqeLialV+6vbEP9iLh1rw+b+hmjByPHU1zMv6k/ebc=;
        b=3zsZRztKOEhwhcwxTyuAJc8jmK7Yd5DM5WDlQ8uNoCD0B0JdzO0Zr6i0fvzBbIeHGL
         K1J9803VZkOtPHjBJjT4QvcPcrBqPmlyBibQFNfoLnJL2nH/8cmJZUl6jIbQx7NGbPNN
         08+Ll+QxTbHmmBtibJ4KKjfXAbYDVI3PjoT0djdSDPSnUr00wKWUXUem3GEA9s+0sqso
         vpZFIY0eOy38/uhvApzUMyDSDhHH3jPQ1VTXer2Cyum9Ff5GijNMSLUXAyVfmk/nlRqL
         c0WLgAt1NLkoXArDAkcdqPEZWBzIV/RYls6whvzrjgsVYeCHBq/VtW9q21vfsycSgx3Y
         CQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKqeLialV+6vbEP9iLh1rw+b+hmjByPHU1zMv6k/ebc=;
        b=sqCQfaU6xbyIQf+GLWeUkOMvShdT8dL9PPFGoZoFxl/VcRgZacNaNXZFNwMsTdcrcF
         bUX7+ZdDYNiqf5gBV0Wu8788CUnQdQcBheEvaP4svSkl5eXt0K7e038qO3e2Ley6ICJJ
         E6MUU0Bqmw1ANm8KV2O9ITg4+KNa263CAA4pEcuNkU/S3yRMgH4MKUX0zLYQpvKxB1El
         1n79wDEmgB1BV/nSgWHLJh4svBcJJYUwqWVibp54DdjgojkFeakjYIvlpuT9aMgMxUeo
         2WIPBkP5hybTNuA84kMXj5Nne5vZ7WikpyORCkb+vZ9h9eOgwOKsmYEUfrEfl3In9wRv
         H1uA==
X-Gm-Message-State: AJIora+R516DLZV+cSD1jtdvG97tU1LATZWtolICefn7J1vgzKoOtwAj
        syYoWU5OINh2IYXUVDh0fPUgMg==
X-Google-Smtp-Source: AGRyM1tqvaWk/DDOXJIx1or0Y+22nYb/JgOeC2l2098PgfKLfLZkKZF0XasYDv3WsyNFz03m/6wFVA==
X-Received: by 2002:a17:90b:3ec5:b0:1f0:3986:4502 with SMTP id rm5-20020a17090b3ec500b001f039864502mr15647381pjb.6.1658764940683;
        Mon, 25 Jul 2022 09:02:20 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id o6-20020a1709026b0600b0015e8d4eb2easm9273441plk.308.2022.07.25.09.02.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:02:19 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com
Cc:     chenzhuo.1@bytedance.com, lukas@wunner.de, jan.kiszka@siemens.com,
        stuart.w.hayes@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ERR: Use pcie_aer_is_native() to judge whether OS owns AER
Date:   Tue, 26 Jul 2022 00:01:31 +0800
Message-Id: <20220725160131.83687-1-chenzhuo.1@bytedance.com>
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

After commit 7d7cbeaba5b7 ("PCI/ERR: Clear status of the reporting
device"), the AER status of the device that reported the error
rather than the first downstream port is cleared. So the problem
in commit aa344bc8b727 ("PCI/ERR: Clear AER status only when we
control AER") is no longer existent, and we change to use
pcie_aer_is_native() here.

pci_aer_clear_nonfatal_status() already has pcie_aer_is_native(),
so we move pci_aer_clear_nonfatal_status() out of
pcie_aer_is_native().

Replace statements that judge whether OS owns AER in
get_port_device_capability() with pcie_aer_is_native().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
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

