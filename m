Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F20F64D857
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 10:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLOJOI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 04:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLOJOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 04:14:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDD44732C;
        Thu, 15 Dec 2022 01:14:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id l10so6189586plb.8;
        Thu, 15 Dec 2022 01:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfLzsL7VDero6YWwKcqTb9ieJRXrPfx+gmoIve9/GWg=;
        b=Nc0l7TBhxhOs1I5DfhXoyqlSlNtIsM2erNwOEUEnj/kKTKaaxqivDkCIJBMFmV6J15
         JF42SXlUVpkaGSb7llFjitND5nGdaFKBI6SkmES1aOlCoGyuKGNScjaekdk6GUX81WV2
         tuFzTWZDWlXLRvo+/nMFOJN+PoMCEKlomOb39Xc71Ah3RBZgHWPM8J7YIuOgINdi21Qk
         RgQ+fW+v+yiiXgnqmBSaWh1pucLR5x1Q9VlUGZlHf4gyvdpEszn5+QM08B/W9GmQ/c4F
         tUA3ZCr8403Z7U6k7Cm7OwRqNArTaA+n+vc6HOkByFdvEqe8/rViL/XrYA47hEKwdLRo
         mk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfLzsL7VDero6YWwKcqTb9ieJRXrPfx+gmoIve9/GWg=;
        b=XxeMhm4ZgBOPBsauygZcpXQSQle6czDqFvI/FH+DKWyephuSbJq/xVbG6pT6bJ+FNW
         qUWweqsjq3A744fVBb0F5asFrAkq8zv2tZE+tqTSzNY7T03Y++M+Dnh1lgUx4Dcsx0Ff
         CaxoMwpfTvlj6vto4e7x5HNIcOJvviuP6yh35mtXbEy8zLmxLucS1OxySc2j9ZErUa5z
         DlNtGhldB2o76o7OcQnbArn7Ze6/tbLd+tCLl7aRVTnaeroyRVsBW2iV7RSOqSYuFcdv
         LNHIcnwzQTkcQB+FzDgbqn9Y5vO+LwiwQ5tVrgmv3+EQiFV2Nh+ILFTZXOxb9ZC/lcyj
         a1Hw==
X-Gm-Message-State: ANoB5pmtJ5kicaq+E3Q/onXKCfd6Kv0LN+dAqNHsBt/yj6rKlboBo8kd
        mq9QbWwmMxQOF85e28nSVA8=
X-Google-Smtp-Source: AA0mqf4ZNsrUVxvC5YowLGVU7xgRW1as+5Ggcf0AZq8gW61WK2Qb2nAuhQuFWgYufN/ITiCJkF4vng==
X-Received: by 2002:a17:902:d195:b0:189:760d:c5f1 with SMTP id m21-20020a170902d19500b00189760dc5f1mr23640282plb.7.1671095642648;
        Thu, 15 Dec 2022 01:14:02 -0800 (PST)
Received: from dell-cros.hitronhub.home ([119.77.166.223])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902ef4400b0017f36638010sm3228297plx.276.2022.12.15.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:14:02 -0800 (PST)
From:   Ron Lee <ron.lee.intel@gmail.com>
X-Google-Original-From: Ron Lee <ron.lee@intel.com>
To:     bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lmajczak@google.com, rajatja@google.com,
        Ron Lee <ron.lee@intel.com>
Subject: [PATCH v2] PCI: Fix up L1SS capability for Intel Apollolake PCIe bridge
Date:   Thu, 15 Dec 2022 17:13:57 +0800
Message-Id: <20221215091357.8738-1-ron.lee@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Google Coral and Reef family chromebooks, the PCIe bridge lost its
L1 PM Substates capability after resumed from D3cold, and identify that
the pointer to the this capability and capapability header are missing
from the capability list.

....
Capabilities: [150 v0] Null
Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ ...
                  PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                   T_CommonMode=40us LTR1.2_Threshold=98304ns
        L1SubCtl2: T_PwrOn=60us
...

This patch fix up the header and the pointer to the L1SS capability
after resuming from D3Cold.

Signed-off-by: Ron Lee <ron.lee@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/pci/quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 285acc4aaccc..fc959be17a9d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5992,3 +5992,20 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+#ifdef CONFIG_PCIEASPM
+static void chromeos_fixup_apl_bridge_l1ss_capability(struct pci_dev *pdev)
+{
+	if (!dmi_match(DMI_SYS_VENDOR, "Google") ||
+		(!dmi_match(DMI_PRODUCT_FAMILY, "Google_Coral") &&
+		 !dmi_match(DMI_PRODUCT_FAMILY, "Google_Reef")))
+		return;
+
+	pci_info(pdev, "Fix up L1SS Capability\n");
+	/* Fix up the L1SS Capability Header*/
+	pci_write_config_dword(pdev, pdev->l1ss, (0x220 << 20) | (1 << 16) | (PCI_EXT_CAP_ID_L1SS));
+	/* Fix up the pointer to L1SS Capability*/
+	pci_write_config_dword(pdev, 0x150, pdev->l1ss << 20);
+}
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_bridge_l1ss_capability);
+#endif

base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
-- 
2.17.1

