Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F92581E5F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 05:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbiG0Dxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 23:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiG0Dxr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 23:53:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F528371A2
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 20:53:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso908228pjo.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jhbj5Abg4TXA2patlqLjYtOIDWLphgG/ZlRWxSbkmg=;
        b=TTb6Ern0vF5/xiSQCYnJ6Gg46rjWaD0lesX5iMjCWYSKagGQwasI8rZx4GE+f9WmcK
         Ggv2fbmEV69lUNGSXnrr+YM+YEHUekKd1nY4FlYQgZ5IPWhBmUq4u3xQYvHkfcPHMh6B
         md+w4lFiGy8n1GDONsIK9I1uT+huTwHEDmCv2krKvh0VI6EyRv5Sj4SHZWfjm6CEmXfw
         80lGsC8h0lp/ctlJKfildkSPLMZzf3dpVDNzZgd0dKZhEV5SMPL2f5tJFQHUvLIxhbtl
         Yq71FexWR0TTqYK6VkaK+pSjM5vZ3HTz7nMJvhMRrekFbAAZZmXc6weE0qBWmJXMsG3A
         15+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jhbj5Abg4TXA2patlqLjYtOIDWLphgG/ZlRWxSbkmg=;
        b=tUJFx3X4PbqXwQ/3KBVYE4uMdonAJNPcdEBNMJiHJXs+EDqmTMBuVBav7e6EMkUDYg
         LN6Tp7unFe7mLsn8NBTeEfj19Hb+Whs6RktCnjvDFJ5q2ODl+pCLp69F1wGQRXG7g1OL
         MdebJ6IhvDLaEGo9GLHWW3n6XsrRrF71zLsladyVhLe8IYIiWlxTrU12/2C5VMZBZSyl
         xjCxDFzvuae2bpMs0Oh2y6cPrzY8nWDZPkFN9TYyIGT+lImJn1Wl+kr8S4o4UkcZr26K
         55nkzrc1Qbweg4oAunLbq7y6Yr1woAebzQdaO+1Im/AIkW3ZH2e35dpiIOQlq49Pmkgs
         tkrA==
X-Gm-Message-State: AJIora/b4GB0+dOAt49Hb6Z6ssWQ/dMAJxysiFSTVJ5CJ6SwT7rbTfF9
        fnuHYPPwY2hXx7NWLlUJ5XbfEw==
X-Google-Smtp-Source: AGRyM1s980FWuq1gVlztoVmgOxTY3rsrl6DOXaqVSgmqR8KVUchf4hKTtG0e9jsYHw4zD/h04NZfrA==
X-Received: by 2002:a17:903:2601:b0:16d:b055:2985 with SMTP id jd1-20020a170903260100b0016db0552985mr1722624plb.161.1658894025876;
        Tue, 26 Jul 2022 20:53:45 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709027fc900b0016bb24f5d19sm12516515plb.209.2022.07.26.20.53.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2022 20:53:45 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     chenzhuo.1@bytedance.com, lukas@wunner.de, jan.kiszka@siemens.com,
        stuart.w.hayes@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI/ERR: Use pcie_aer_is_native() to judge whether OS owns AER
Date:   Wed, 27 Jul 2022 11:53:34 +0800
Message-Id: <20220727035334.9997-1-chenzhuo.1@bytedance.com>
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
in pcie_do_recovery().

Replace "dev->aer_cap && (pcie_ports_native || host->native_aer)" in
get_port_device_capability() with pcie_aer_is_native(), which has no
functional changes.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
Changelog:
v3:
- Simplify why we use pcie_aer_is_native().
- Revert modification of pci_aer_clear_nonfatal_status() and comments.
v2:
- Add details and note in commit log.
---
 drivers/pci/pcie/err.c          | 3 +--
 drivers/pci/pcie/portdrv_core.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

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

