Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDE92CF310
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 18:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgLDRWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 12:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgLDRWe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 12:22:34 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A480C0613D1
        for <linux-pci@vger.kernel.org>; Fri,  4 Dec 2020 09:21:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so6071335wrx.5
        for <linux-pci@vger.kernel.org>; Fri, 04 Dec 2020 09:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xGFSjpeH8g6dTBRTGYBKVkvKKh8j2BzTKXEerenCUTM=;
        b=C2n5YngYMq6LCpba/WuAYv4KvOpP19BjYUUqF43/aspUsbd88RHJCmmLmiM5tVQ5Tg
         r3VWkvXhoQVRj8K1ofJ8N2ei13+0ds/aGMNJrU26ZXADbl5BRbfeGfxNMV/NNmBTddHf
         /QYBq709tVaZ8n7DPm1mVuzK9joewYLjYHLgxueIfl4GHhmibRRuMoYM7Tk+UxMOUOkh
         m7jWcyyscDcpTYqgMvbAms9Vv4fiyk16Mw2i1ZvU9u3K52ALCBtkXqbzlx53yPUz0iZo
         qaQKjdlmLku/iERDgXNY7x+JIbJJSx4hatvzEhAd36xMrbrT2G6CB9RygCfnrrNbhUkb
         +9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xGFSjpeH8g6dTBRTGYBKVkvKKh8j2BzTKXEerenCUTM=;
        b=PgzdF94oSr5N6ziGTen9FULXf24oFCqZB5HQLluJnXtYIk1tMRZyl4flzfwP60Yyu6
         3EMJASomP7mVOa7Mq1gQ1M5GcZHt056vSruudihERNEpwHJGYiJ7Hdx5tWu7TTiiY9CK
         Ca7W+y7ognUfMThh+3rJ3B/1WpbVtbsgRb+SWF9IaJP9vlvsbB3Xn/x9sLoQP5oar1rj
         zvL7KQQSjEw3CfOuDn+xDqg/DmlAtMHCNDsJVCCbEGxoQUe4g1+YJq/gQ+InXXEnJUiY
         UJRpIQevoqQym/Fxc6DSVsYiaPNVg+uPxAohurec64nKbSwrpXZpp+/NR6vHmVS0doaK
         xafw==
X-Gm-Message-State: AOAM532VhpwXiHLJuFqJQSqE9b0Iw8Xyhp6j9JGAvLwbu5MilebhLrYm
        AXGSOUO/dOeJ9lvz6abUO/YfJXwxSr2efouM
X-Google-Smtp-Source: ABdhPJxoVL1ZVnc0Md6tYy3/wzSWlYkBTe/PPjk87BUQG4iIdNPupj38SGW3m9116eJZj88c8xZ/bA==
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr4328839wrs.398.1607102512800;
        Fri, 04 Dec 2020 09:21:52 -0800 (PST)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id c2sm4729020wrf.68.2020.12.04.09.21.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:21:52 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     bhelgaas@google.com, ruscur@russell.cc
Cc:     linux-pci@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [RFC] pci: aer: Disable corrected error reporting by default
Date:   Fri,  4 Dec 2020 18:28:52 +0100
Message-Id: <1607102932-10384-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It appears to be very common that people complain about kernel log
(and irq) flooding because of reported corrected errors by AER.

An usual reply/solution is to completely disable aer with 'noaer' pci
parameter. This is a big hammer tip since it also prevents reporting of
'real' non corrected PCI errors, that need to be handled by the kernel.

A PCI correctable error is an error corrected at hardware level by the
PCI protocol (e.g. with retry mechanism), the OS can then totally live
without being notified about that hardware event.

A simple change would then consist in not enabling correctable error
reporting at all, but it can remain useful in some cases, such as for
determining health of the PCI link.

This patch changes the default AER mask to not enable correctable error
reporting by default, and introduce a new pci parameter, 'aerfull' that
can be used to re-enable all error reports, including correctable ones.

Note: Alternatively, if changing the legacy behavior is not desirable,
that can be done the other way, with a 'noaer_correctable' parameter to
only disable correctable error reporting.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/pci/pci.c      |  2 ++
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 12 +++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6d4d5a2..c67ec709 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6498,6 +6498,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "aerfull")) {
+				pci_aer_full();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f86cae9..36306a1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -662,6 +662,7 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_aer_full(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -670,6 +671,7 @@ int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_aer_full(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f..e0ec7047 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -102,6 +102,7 @@ struct aer_stats {
 #define ERR_UNCOR_ID(d)			(d >> 16)
 
 static int pcie_aer_disable;
+static int pcie_aer_full;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
@@ -109,6 +110,11 @@ void pci_no_aer(void)
 	pcie_aer_disable = 1;
 }
 
+void pci_aer_full(void)
+{
+	pcie_aer_full = 1;
+}
+
 bool pci_aer_available(void)
 {
 	return !pcie_aer_disable && pci_msi_enabled();
@@ -224,12 +230,16 @@ int pcie_aer_is_native(struct pci_dev *dev)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
+	u16 flags = PCI_EXP_AER_FLAGS;
 	int rc;
 
 	if (!pcie_aer_is_native(dev))
 		return -EIO;
 
-	rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
+	if (!pcie_aer_full)
+		flags &= ~PCI_EXP_DEVCTL_CERE;
+
+	rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, flags);
 	return pcibios_err_to_errno(rc);
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
-- 
2.7.4

