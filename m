Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD39964D5B1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 04:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLODti (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 22:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLODtg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 22:49:36 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F380D532EB;
        Wed, 14 Dec 2022 19:49:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 17so5599797pll.0;
        Wed, 14 Dec 2022 19:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoGErgG0tPjEmHbvShVDwwWrf8srDtoKq+kmmat95m4=;
        b=X/gzNQ0eQQmf65T1aVS5FnWeKPIqq7d5KelstASURwfxQbb4bBxhD17W9QzQdWuoiO
         lcwQWTXobQ12aI7Qpm2Dn/rv6LuKHGln+mV+xuxKy+slrKmmlxWeWplqNXpdgjDHxaYg
         O4lMbHrOM0m+VC/iijnAgmsA0zUakdui9e+p2Tf3TX2ASTPa+Cz+nEVcMloS/MVpPG4f
         mddWGnIclG7v2RGyO5j5CJjeh4eYJkWy5KdZJEPfch4N4JRn4dOdmSdnD4jsYukl5Vze
         zhlAoAoFaiOuiPEC07jmmJ2aeSAPavLbQA3DWjUk1aoQUtRnRtxd8HYYyhjIIGH+ERQl
         Tfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoGErgG0tPjEmHbvShVDwwWrf8srDtoKq+kmmat95m4=;
        b=gbXSxvlQXJOKZ10rAK7OHeDoj6w2NuG3r5YR8ZZ769SzQLxNbG0kZhyXnIS+kag2vX
         nw9yN36nPrD/5j5eaHmn33XeGHptS4x0NtYXykvHrsa+zR99usg3dwmuzLbYg2T2+/UO
         j12EYjD5a4Sb/y3v85Ao9KvTdV4dF0tzsexOJc0WlQZ6XPPoGZzVFug/E9yHjYUBzC/t
         CTfFFR+EY2GFXlwBnYXD2DYWqmOjKayEwdCpaBdVlna3PuECorgf+/Kx2D9qeDuz7VRp
         rWglQLn/z4M/Wxj7DDznN9Ppj54p7ilJs7q6MoES5gG4SiVyLYIUJu+IOY/Wwfd/ozEV
         sUag==
X-Gm-Message-State: ANoB5pmjA14MrG9pizwmrsyCPCgfjs7nLJ9BWyy+wn3aKsYHkOzCNXLy
        JSPpoS/lvCQSW4czRwzt5kA=
X-Google-Smtp-Source: AA0mqf5FN9N2BagNPjFbLCKWMwGh2ybPt7IpL3XwDFlzON8j/WcEg0aF3EKVbrnrhHM2ktFkHbJN1Q==
X-Received: by 2002:a05:6a20:9c93:b0:a5:6e3d:1055 with SMTP id mj19-20020a056a209c9300b000a56e3d1055mr30770655pzb.16.1671076173361;
        Wed, 14 Dec 2022 19:49:33 -0800 (PST)
Received: from dell-cros.hitronhub.home ([119.77.166.223])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b0018980f14940sm2577852plg.178.2022.12.14.19.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 19:49:32 -0800 (PST)
From:   Ron Lee <ron.lee.intel@gmail.com>
X-Google-Original-From: Ron Lee <ron.lee@intel.com>
To:     bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lmajczak@google.com, rajatja@google.com,
        Ron Lee <ron.lee@intel.com>
Subject: [PATCH] PCI: Fix up L1SS capability for Intel Apollolake PCIe bridge
Date:   Thu, 15 Dec 2022 11:48:57 +0800
Message-Id: <20221215034857.9076-1-ron.lee@intel.com>
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
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 285acc4aaccc..e538f6d066f7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5992,3 +5992,18 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
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
-- 
2.17.1

