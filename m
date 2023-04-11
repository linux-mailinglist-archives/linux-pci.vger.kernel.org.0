Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852F96DE054
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDKQC6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDKQCt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 12:02:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D2A55BA;
        Tue, 11 Apr 2023 09:02:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ke16so8226466plb.6;
        Tue, 11 Apr 2023 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681228959; x=1683820959;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdG1ON11+I6NN3yy4WwLOjLuCBAnsssuQue/NCh4cmA=;
        b=inNtc+JithQ/UKJ9S7MCR3NBNSh1fXp9AepZUx8pdr3vZBSYDL/HGdfvN7VcD/Xkpg
         ygfOmwjmLcZSixJ7Ltpsq049pkCcD74GiFSJ5dbxkoXp9vBwnsCehcG6Rec2r1VKbJ98
         4XAZGxfEMIa90auoeh3xWejIGt9PLRBFwWHeJ5kHF4E0+GECZoR/xDmSFqgilRsMmEc4
         WJAY5fCL/IY23HKyu2neLpBBVQp9XpvnqvrtCrKMIbCvWgH0e4TaXdqfP9rgHK9zQGXk
         veq6lI0PiAjyDoT0dd5aXcMhKYJ58NJ2exVjqNRRmXJAaOJXSFvV2wKi05z+O9sZRoKk
         fY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681228959; x=1683820959;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdG1ON11+I6NN3yy4WwLOjLuCBAnsssuQue/NCh4cmA=;
        b=NiO52lSmtMhLBQVgvz2FqqNUVxSbywy7kYZL9ewB+O0B9Q85wCMlpj5G5ZVFack7d9
         Pisy/f0U+qXX0A0mQfY7df+hbs+6fpQSRU6jBRCjJqKYPG/Rg0rJ7+fUtEmGGWfcz5tz
         EGEi4jkHNOR8FWd8AP4VGVKVaq9xpYZRqvfEP98ZUz+apVCrQ0/4LQ/aRBD7cYAbKU8m
         7dR0p1DKb+7GsWiHHsAeslW7EbXrMUUvzJCfMLva1UJ/E3pGChurNztkDFzjbqL7D87i
         mag7DCbLSrmw6WilVnx2jK9/v6DmDSdWl2XE3HnN35uQt1yZ3E5z9Ol/0/q+duZfYoQq
         W3JA==
X-Gm-Message-State: AAQBX9fLoYDhFDPN/1DPK6QCWJRNm4q5CZ5LSRY7uj/9pbIeT6Nh+gnR
        gL6hKmdriGJL4X20lXecjT8=
X-Google-Smtp-Source: AKy350aY2bmptSWiFDPCPtUM7VPs1/gP6REclJXctKvwuThoVn92T/xn6wcb3+KK+oCYKKs4sMKqEA==
X-Received: by 2002:a17:902:dac8:b0:19f:1c79:8b21 with SMTP id q8-20020a170902dac800b0019f1c798b21mr17714422plx.42.1681228959173;
        Tue, 11 Apr 2023 09:02:39 -0700 (PDT)
Received: from ronlee-MOBL1.hitronhub.home ([119.77.166.223])
        by smtp.gmail.com with ESMTPSA id q10-20020a65494a000000b004fb10399da2sm8766454pgs.56.2023.04.11.09.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:02:38 -0700 (PDT)
From:   Ron Lee <ron.lee.intel@gmail.com>
X-Google-Original-From: Ron Lee <ron.lee@intel.com>
To:     bhelgaas@google.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lmajczak@google.com, rajatja@google.com,
        Ron Lee <ron.lee@intel.com>
Subject: [PATCH v4] PCI: Fix up L1SS capability for Intel Apollo Lake Root Port
Date:   Wed, 12 Apr 2023 00:02:13 +0800
Message-Id: <20230411160213.4453-1-ron.lee@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Google Coral and Reef family Chromebooks with Intel Apollo Lake
SoC, firmware clobbers the header of the L1 PM Substates capability and
the previous capability when returning D3cold to D0.

Save those header at enumeration-time and restore them at resume.

Link: https://lore.kernel.org/linux-pci/CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com/T/#u
Signed-off-by: Ron Lee <ron.lee@intel.com>
---
Changes from v3: 
- Move to arch/x86/pci/fixup.c
- Save prev cap offset & header, L1SS offset & header at enumeration-time
  and restore them at resume
- Remove CONFIG_PCIEASPM directive
- Stop traversal if L1SS capability was found

 arch/x86/pci/fixup.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 615a76d70019..28335aaa6c33 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -824,3 +824,62 @@ static void rs690_fix_64bit_dma(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
 
 #endif
+
+/*
+ * When returning from D3cold to D0, firmware on some Google Coral and Reef
+ * family Chromebooks with Intel Apollo Lake SoC clobbers the headers of
+ * both the L1 PM Substates capability and the previous capability for the
+ * "Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1".
+ *
+ * Save those values at enumeration-time and restore them at resume.
+ */
+
+static u16 prev_cap, l1ss_cap;
+static u32 prev_header, l1ss_header;
+
+static void chromeos_save_apl_pci_l1ss_capability(struct pci_dev *dev)
+{
+	int pos = PCI_CFG_SPACE_SIZE, prev = 0;
+	u32 header, pheader = 0;
+
+	while (pos) {
+		pci_read_config_dword(dev, pos, &header);
+		if (PCI_EXT_CAP_ID(header) == PCI_EXT_CAP_ID_L1SS) {
+			prev_cap = prev;
+			prev_header = pheader;
+			l1ss_cap = pos;
+			l1ss_header = header;
+			return;
+		}
+
+		prev = pos;
+		pheader = header;
+		pos = PCI_EXT_CAP_NEXT(header);
+	}
+}
+
+static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
+{
+	u32 header;
+
+	if (!prev_cap || !prev_header || !l1ss_cap || !l1ss_header)
+		return;
+
+	/* Fixup the header of L1SS Capability if missing */
+	pci_read_config_dword(dev, l1ss_cap, &header);
+	if (header != l1ss_header) {
+		pci_write_config_dword(dev, l1ss_cap, l1ss_header);
+		pci_info(dev, "restore L1SS Capability header (was %#010x now %#010x)\n",
+			 header, l1ss_header);
+	}
+
+	/* Fixup the link to L1SS Capability if missing */
+	pci_read_config_dword(dev, prev_cap, &header);
+	if (header != prev_header) {
+		pci_write_config_dword(dev, prev_cap, prev_header);
+		pci_info(dev, "restore previous Capability header (was %#010x now %#010x)\n",
+			 header, prev_header);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
-- 
2.17.1

