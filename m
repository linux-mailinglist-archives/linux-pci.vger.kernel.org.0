Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1025316D4
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiEWRRS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 13:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbiEWRRJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 13:17:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43D21E18;
        Mon, 23 May 2022 10:16:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z11so4810569pjc.3;
        Mon, 23 May 2022 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZnKZoJrCw++R1qQpo4hgDWev0CwMVPdkg70pBxSDPs=;
        b=SWLxCg+JHh1EmVh/YW54O8CBi97MTi0/1JM5ILiPhIyGHO1RMktyLeQBNcTEMf6D4h
         WWX1DWAgTQSR6AwH5G/J6S5nEU2i8LLyz9X7y3MX83wjyH3gxtEqZFfK4FPanivITjXu
         vh4rhhqq0T8T69QwnEnY3Y77b4l+Ijn5ctqRvLJLfkPYdxSoQNeGTcnwQWKPSDn6VIF4
         33wUxPDXKvmp0g0QWyLFiF1A1ttC33oT9I3PKui+Z2jOT8HRfM50AQ0n/bQW+fQNlCDh
         DDhuVMlIAH99fHaejkbQm7i6ycS4NSJKe47o3pCuSpoFcDPVKGxPYi6rFs3eOQTD8gbM
         1jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZnKZoJrCw++R1qQpo4hgDWev0CwMVPdkg70pBxSDPs=;
        b=2X6wwCojgbE/oyCXaZfariw32fqfLCXuhFVeOlDDUU2Ti+ux9abPvLW7qvYTId9P3u
         qqCaGPOXi1p+Z0Z9N1bh8fuXONUDms//ElFbqwC96Uyqzpo8L5V8+NItgoXRI8ihTe4O
         Czdh87g4maj5xIl3uv9PMYaPKB5lIhCax6JSadh/hRtJ1JUqZyq8Qmwm9KipP/tbUe/7
         bnBJXToH76kVHl95BaGlmraCHqwZopuisIfllCDaMvmJl244axpOkQT9aaYwMdMzd14w
         Qep2pPhWjK1teACVM63WSqTKcjI52vLqHFB4Z0Q44CNQXfyd/eev1pY2FciuZ5QdGusH
         EzVQ==
X-Gm-Message-State: AOAM530z5WlgzDM6Nxn25rG4BbrcBDKDzffOn7PVIVlsRIeJHW3HGnNP
        2A7aIWsend3aZcU7sO6VhT2J5/qcW0x4xA==
X-Google-Smtp-Source: ABdhPJzAFYIctogy39e+t4ny6sLP7bQRcD59ohd2F8F32KypIHkS67if1nnOaBVw9Ptgs5jVSjU8DA==
X-Received: by 2002:a17:902:b214:b0:161:f6d8:45cd with SMTP id t20-20020a170902b21400b00161f6d845cdmr16367154plr.95.1653326137063;
        Mon, 23 May 2022 10:15:37 -0700 (PDT)
Received: from localhost.localdomain ([103.126.24.15])
        by smtp.gmail.com with ESMTPSA id i198-20020a6287cf000000b005180c127200sm7604646pfe.24.2022.05.23.10.15.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 10:15:36 -0700 (PDT)
From:   Sheng Bi <windy.bi.enflame@gmail.com>
To:     helgaas@kernel.org, bhelgaas@google.com,
        alex.williamson@redhat.com, lukas@wunner.de
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sheng Bi <windy.bi.enflame@gmail.com>
Subject: [PATCH v3] PCI: Fix no-op wait after secondary bus reset
Date:   Tue, 24 May 2022 01:15:17 +0800
Message-Id: <20220523171517.32407-1-windy.bi.enflame@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAGdb+H0qnC4noBa_=N3oQW88+dgXYtA7gqJ5qiD2g7Ywd+2K=Q@mail.gmail.com>
References: <CAGdb+H0qnC4noBa_=N3oQW88+dgXYtA7gqJ5qiD2g7Ywd+2K=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_bridge_secondary_bus_reset() triggers SBR followed by 1 second sleep,
and then uses pci_dev_wait() for waiting device ready. The dev parameter
passes to the wait function is currently the bridge itself, but not the
device been reset.

If we call pci_bridge_secondary_bus_reset() to trigger SBR to a device,
there is 1 second sleep but not waiting device ready, since the bridge
is always ready while resetting downstream devices. pci_dev_wait() here
is a no-op actually. This would be risky in the case which the device
becomes ready after more than 1 second, especially while hotplug enabled.
The late coming hotplug event after 1 second will trigger hotplug module
to remove/re-insert the device.

Instead of waiting ready of bridge itself, changing to wait all the
downstream devices become ready with timeout PCIE_RESET_READY_POLL_MS
after SBR, considering all downstream devices are affected during SBR.
Once one of the devices doesn't reappear within the timeout, return
-ENOTTY to indicate SBR doesn't complete successfully.

Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")
Signed-off-by: Sheng Bi <windy.bi.enflame@gmail.com>
---
 drivers/pci/pci.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index eb7c0a08ff57..4653a9ae6e5b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5049,6 +5049,34 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	}
 }
 
+static int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
+{
+	struct pci_dev *dev;
+	unsigned long start_jiffies;
+
+	down_read(&pci_bus_sem);
+
+	if (!bridge->subordinate || list_empty(&bridge->subordinate->devices)) {
+		up_read(&pci_bus_sem);
+		return 0;
+	}
+
+	list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
+		start_jiffies = jiffies;
+
+		if (timeout < 0 || pci_dev_wait(dev, "bus reset", timeout)) {
+			up_read(&pci_bus_sem);
+			return -ENOTTY;
+		}
+
+		timeout -= jiffies_to_msecs(jiffies - start_jiffies);
+	}
+
+	up_read(&pci_bus_sem);
+
+	return 0;
+}
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
@@ -5092,7 +5120,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
+	return pci_bridge_secondary_bus_wait(dev, PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 

base-commit: 617c8a1e527fadaaec3ba5bafceae7a922ebef7e
-- 
2.36.1

