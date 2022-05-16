Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72184528C00
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbiEPRaz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiEPRay (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 13:30:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CDEDEF2;
        Mon, 16 May 2022 10:30:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so1178335pjb.2;
        Mon, 16 May 2022 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OTSZD7XY4xlhlXYWnr6RQDyqsnVaQBafjBNNdEbut20=;
        b=ljoCpUurp4LDNznqFaSS3fU0aMtiMbgRZ6P7rLHQfTM7vNFaBZ//4Gs2TPrOjME2qV
         Blyf4d/AbF3HxAU4LT2BXM3E2nxuGZ22IHb7Skw7giN2rHej05aDC8p3fvPTypB4CZ2+
         4EpaRnUH7sirgAw3KVo9dxLIUYX/MJBQGJgALEOooZQLaJTlR4ZiJ8oFU2VXRPUk9UC+
         XpzYTNZ8dDhFxdw/s0OJIleDgCrqppZ9Y0BpZc/1RyqvIsOGMIsNBOeUkk70RTiFYjNI
         IcvK+jhjQaY6R5IlS6jT9/c0LoN+T4E3zSA5+CoJTjtwh23p92ZnxZZZ66VpnGzPLsQP
         kyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OTSZD7XY4xlhlXYWnr6RQDyqsnVaQBafjBNNdEbut20=;
        b=C6rxF+qAhtYw3uJMnphMnRBD/oSSTS/ieYycVfu6MmJibXnMH9qyz21MsCF0kp8woH
         d7+mevHqY3srFGXIRY1wn+8q97ReNl9OO0Sj4xladMAnKayFtNDrtm8ZZnwoI6d9RGoi
         dSTFAUZf04vQVuH/saBPK0LI4+GgIwBiP60ig5Htcbm2P+3i+p7CP0EgsH7ImjGnZ0oS
         jmZCbuhWE7w2rKKctRGw8+nSjY/XsY7jLqhBFgcBiI1SjUIrDxFVBoeAVH9dWo3IkCeJ
         14x391Br/Mp+oZho6erUjbFbLIdhzslzaRDQiErWm2SfdEayxNFGDrDCzJUrjjPB/8lH
         sEdA==
X-Gm-Message-State: AOAM530I1U2l9R0B2Zy5kNsYgoFzlNrwq8SPykdOgfniGdR2Be3QxDC3
        fyFqoLoCxrpCAe1WPW7/ENk=
X-Google-Smtp-Source: ABdhPJwFG7wwyVTvgM6A+HYDSQtwe3IUgtHKXP3afpbvRGISoW3hwz8dllSjmEus96jz4ohNxcrxMw==
X-Received: by 2002:a17:903:4044:b0:161:823e:6f93 with SMTP id n4-20020a170903404400b00161823e6f93mr5155213pla.172.1652722253376;
        Mon, 16 May 2022 10:30:53 -0700 (PDT)
Received: from localhost.localdomain ([103.126.24.15])
        by smtp.gmail.com with ESMTPSA id j16-20020a17090a589000b001df7c160875sm209215pji.25.2022.05.16.10.30.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 10:30:52 -0700 (PDT)
From:   "windy.bi.enflame" <windy.bi.enflame@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "windy.bi.enflame" <windy.bi.enflame@gmail.com>
Subject: [PATCH] drivers/pci: wait downstream hierarchy ready instead of slot itself ready, after secondary bus reset
Date:   Tue, 17 May 2022 01:30:47 +0800
Message-Id: <20220516173047.123317-1-windy.bi.enflame@gmail.com>
X-Mailer: git-send-email 2.36.1
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

While I do reset test of a PCIe endpoint device on a server, I find that
the EP device always been removed and re-inserted again by hotplug module,
 after secondary bus reset.

After checking I find:
1> "pciehp_reset_slot()" always disable slot's DLLSC interrupt before
   doing reset and restore after reset, to try to filter the hotplug
   event happened during reset.
2> "pci_bridge_secondary_bus_reset()" sleep 1 seconad and "pci_dev_wait()"
   until device ready with "PCIE_RESET_READY_POLL_MS" timeout.
3> There is a PCIe switch between CPU and the EP devicem the topology as:
   CPU <-> Switch <-> EP.
4> While trigger sbr reset at the switch's downstream port, it needs 1.5
   seconds for internal enumeration.

About why 1.5 seconds ready time is not filtered by "pci_dev_wait()" with
"PCIE_RESET_READY_POLL_MS" timeout, I find it is because in
"pci_bridge_secondary_bus_reset()", the function is operating slot's
config space to trigger sbr and also wait slot itself ready by input same
"dev" parameter. Different from other resets like FLR which is triggered
by operating the config space of EP device itself, sbr is triggered by
up slot but need to wait downstream devices' ready, so I think function
"pci_dev_wait()" works for resets like FLR but not for sbr.

In this proposed patch, I'm changing the waiting function used in sbr to
"pci_bridge_secondary_bus_wait()" which will wait all the downstream
hierarchy ready with the same timeout setting "PCIE_RESET_READY_POLL_MS".
In "pci_bridge_secondary_bus_wait()" the "subordinate" and
"subordinate->devices" will be checked firstly, and then downstream
devices' present state.

Signed-off-by: windy.bi.enflame <windy.bi.enflame@gmail.com>
---
 drivers/pci/pci.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ecce435fb3f..d7ec3859268b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5002,6 +5002,29 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	}
 }
 
+int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
+{
+	struct pci_dev *dev;
+	int delay = 1;
+
+	if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
+		return 0;
+
+	list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
+		while (!pci_device_is_present(dev)) {
+			if (delay > timeout) {
+				pci_warn(dev, "secondary bus not ready after %dms\n", delay);
+				return -ENOTTY;
+			}
+
+			msleep(delay);
+			delay *= 2;
+		}
+	}
+
+	return 0;
+}
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
@@ -5045,7 +5068,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
+	return pci_bridge_secondary_bus_wait(dev, PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
-- 
2.36.1

