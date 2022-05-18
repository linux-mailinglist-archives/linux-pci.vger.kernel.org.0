Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A552B92A
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiERLyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 07:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiERLyn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 07:54:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8438742ECF;
        Wed, 18 May 2022 04:54:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso1788578pjb.3;
        Wed, 18 May 2022 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZ4rncoyGFQjon2zJSWDjtwMAq3ZWWnFkDUlE+wmkgc=;
        b=I3NM2uZ9tp3oYKMlCG+JFNj2KUghksK39Pq3/ZBVLLP9Vuljc6IgCyPN7syDipHm3+
         OfPHEq9klr6SmwYgzO+10cHLTchPqsGGxEbNsPdBEUZ1sUCmtgkakMIKzwdiK02CYBrJ
         aS6YtDqlniNJvCyMsUAPyCZPgQ2Suy5f7iNZ5Chh7O0/Lw6ideQNxjMI17j9MdXgM5D3
         xbHoFWtgSoEAu3h9VRRpBkihqIDc4+GIVPMC56AZeSUJcC43Ibnw/INYuGY9nYxiP0tW
         3vp/+U3a03WuqEewO0i7uZuhLDhOwW78iCAnipGk/m8yRMwD8e1hioewhBQFzZdCH+nK
         hFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZ4rncoyGFQjon2zJSWDjtwMAq3ZWWnFkDUlE+wmkgc=;
        b=SvBkBn9JTx9U4Tgf674D+ake0CnYP8FQ/M8YkABJX7WSXH9l2PIANSarK7HcAcfjoW
         Slu14ptZ7zTydc+euxUkIWE+Oz3I+qrjT9bKeoC0XST/gII1ZiE62qgjbO6Cgs5IrXTA
         CVEd6K4+mafhY1B5WrweebsFRpi8dGH6BbyII+FCPrk4dl6dcOMV7A5eJtmnc9X78yiV
         gWrYOBUzBUBmTHeRn95aNefzgtF4u3mwWziAYP/74ZAlHkMktkWQS6Ri1yrdMqQsl2zI
         /OgTKfZQkP6eWoYN0NtmdcxTDJ0Ssksln30SGv2kZTbfrHyXVm09sz8CJEZMc3ui59Wn
         d/PA==
X-Gm-Message-State: AOAM533136gRv08/k3hNsCfYzb56X6X8ijdA4ihwszYXy2l0KJiJyc+m
        4pdxNOtkn+2xQy72b/T5Ans=
X-Google-Smtp-Source: ABdhPJzUUw6sp/8onoLyjYQQXzsoGYB1a1jcXVVvrMlvxiQt9k5434pZsal3kaXbjCVhs8pUKllpXw==
X-Received: by 2002:a17:902:ecc7:b0:161:c860:38e2 with SMTP id a7-20020a170902ecc700b00161c86038e2mr2175566plh.75.1652874879062;
        Wed, 18 May 2022 04:54:39 -0700 (PDT)
Received: from localhost.localdomain ([103.126.24.15])
        by smtp.gmail.com with ESMTPSA id q19-20020a056a00085300b0050dc76281c9sm1755304pfk.163.2022.05.18.04.54.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 May 2022 04:54:38 -0700 (PDT)
From:   Sheng Bi <windy.bi.enflame@gmail.com>
To:     helgaas@kernel.org, bhelgaas@google.com
Cc:     alex.williamson@redhat.com, lukas@wunner.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sheng Bi <windy.bi.enflame@gmail.com>
Subject: [PATCH v2] PCI: Fix no-op wait after secondary bus reset
Date:   Wed, 18 May 2022 19:54:32 +0800
Message-Id: <20220518115432.76183-1-windy.bi.enflame@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516165740.6256af51.alex.williamson@redhat.com>
References: <20220516165740.6256af51.alex.williamson@redhat.com>
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
index eb7c0a08ff57..32b7a5c1fa3a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5049,6 +5049,34 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	}
 }
 
+static int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
+{
+	struct pci_dev *dev;
+	int delay = 0;
+
+	if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
+		return 0;
+
+	list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
+		while (!pci_device_is_present(dev)) {
+			if (delay > timeout) {
+				pci_warn(dev, "not ready %dms after secondary bus reset; giving up\n",
+					delay);
+				return -ENOTTY;
+			}
+
+			msleep(20);
+			delay += 20;
+		}
+
+		if (delay > 1000)
+			pci_info(dev, "ready %dms after secondary bus reset\n",
+				delay);
+	}
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

