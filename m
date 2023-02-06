Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDEE68C037
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 15:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBFOfx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 09:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBFOfx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 09:35:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CE223DA0;
        Mon,  6 Feb 2023 06:35:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d2so8138750pjd.5;
        Mon, 06 Feb 2023 06:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6xEVHTq4BRT21XT3igauxghHQalnR6mzNTQMSRZCcI=;
        b=PUK6yVSLPoWPtAI6SVLDKNFP6ey/03oHofWOTQaRF2f8HQujwDUcSUf62NWhLKm4Uo
         YXstcii1NiNg0y/eG5kinLFNV8/+8smrm8PXFNjHOL39IAFe/e5Qof19TQzEdU0TrEOw
         mdlMMpadPxAlE7b8dGNMwT9HWVEBlwXPR0seRZSCHXiPFMohdT8/u7YqVuWNJwg0RxzX
         Jv1hUcmReKedzpYn6XFsFMxS35bweAf0/iAnoU3HeOctkI8Snn1LiogH684zEBM1d5R1
         UKpIZz5VbMcvDXpi+OdMedjl44jR8IbpVh/gl6+z8jyCrTQXrR1rPe23hzpU/Wiuymfd
         LfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6xEVHTq4BRT21XT3igauxghHQalnR6mzNTQMSRZCcI=;
        b=Ivq1Hhq1+sUuQ/gyv9MEcr5ZqgBYaints97ht5qHGJ+O0v0ZsMu3AJs+6rc1S4wr4x
         eowOAb3soaF2NCR6PoYg6+/GUbLKSA+68eJQfOsss6O9Tfs1gCZAjuB5A26EnsvmrIaB
         FWuDSrLSnGbVcTSnsulhL1dhTBAM+6BbCK758DUcHumauNmRTmRznbK7BJBAxBk15nj3
         S9oPfP7juBACVAo6CkaTOsreGHoXr+fwp5BJl0Y8ZaUC3ngPUgyE0buHAnhLMK+xFOed
         eE410xHKWVVJI34MwcLNwmIungCgyvh+LIlbfwPouCol76Y6FvyHy+f8aGXvb248xSK1
         q8yA==
X-Gm-Message-State: AO0yUKXt1wpv3TzVbdz3FGpJshT7SWofuPo1pcSEug+tbtrDRyUS2n5i
        DZr25sKWVpQER8ka9IsEjgOCu+PnuT8=
X-Google-Smtp-Source: AK7set9KvzHJrQ1opQ/69an3pSyuKPBPwGMCbWMp7807AmsrBf9HEFH4jM3ULC8bAMCO2S8nqjIxvw==
X-Received: by 2002:a17:902:dad2:b0:193:678:df13 with SMTP id q18-20020a170902dad200b001930678df13mr24797027plx.36.1675694151737;
        Mon, 06 Feb 2023 06:35:51 -0800 (PST)
Received: from dell-cros.hitronhub.home ([119.77.166.223])
        by smtp.gmail.com with ESMTPSA id p6-20020a170903248600b00198b0fd363bsm7021181plw.45.2023.02.06.06.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:35:51 -0800 (PST)
From:   Ron Lee <ron.lee.intel@gmail.com>
X-Google-Original-From: Ron Lee <ron.lee@intel.com>
To:     bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lmajczak@google.com, rajatja@google.com,
        Ron Lee <ron.lee@intel.com>
Subject: [PATCH v3] PCI: Fix up L1SS capability for Intel Apollo Lake PCIe bridge
Date:   Mon,  6 Feb 2023 22:35:40 +0800
Message-Id: <20230206143540.15325-1-ron.lee@intel.com>
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

On Google Coral and Reef family Chromebooks with Intel Apollo Lake
SoC, the PCIe bridge lost its L1 PM Substates capability after resumed
from D3cold. This patch save the capability header and the pointer
offset to the L1SS capability after this bridge initialized, and
recover them every time resuming from D3cold.

Link:https://lore.kernel.org/linux-pci/CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com/T/#u
Signed-off-by: Ron Lee <ron.lee@intel.com>
---
Change from v2: traverse the capability link list to find the L1SS capability header
and pointer offset to the L1SS capability, save them after the bridge initialized and 
restore them after resuming from D3cold.

 drivers/pci/quirks.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 285acc4aaccc..4e1c8c4c7e9a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5992,3 +5992,44 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+#ifdef CONFIG_PCIEASPM
+static u16 pos_to_l1ss;
+static u32 l1ss_header;
+static void chromeos_save_apl_pci_l1ss_capability(struct pci_dev *pdev)
+{
+	u32 header;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	while (pos) {
+		pci_read_config_dword(pdev, pos, &header);
+		if (PCI_EXT_CAP_NEXT(header) == pdev->l1ss)
+			pos_to_l1ss = pos;
+		else if (PCI_EXT_CAP_ID(header) == PCI_EXT_CAP_ID_L1SS)
+			l1ss_header = header;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+	}
+}
+
+static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *pdev)
+{
+	u32 header;
+
+	if (!pos_to_l1ss || !l1ss_header)
+		return;
+
+	pci_info(pdev, "Fixup L1SS Capability\n");
+	/* Fixup the header of L1SS Capability if missing */
+	pci_read_config_dword(pdev, pdev->l1ss, &header);
+	if (PCI_EXT_CAP_ID(header) != PCI_EXT_CAP_ID_L1SS)
+		pci_write_config_dword(pdev, pdev->l1ss, l1ss_header);
+
+	/* Fixup the link to L1SS Capability if missing*/
+	pci_read_config_dword(pdev, pos_to_l1ss, &header);
+	if (PCI_EXT_CAP_NEXT(header) != pdev->l1ss)
+		pci_write_config_dword(pdev, pos_to_l1ss, pdev->l1ss << 20);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
+#endif
-- 
2.17.1

