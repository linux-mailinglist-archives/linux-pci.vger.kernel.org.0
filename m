Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8FE6EBC87
	for <lists+linux-pci@lfdr.de>; Sun, 23 Apr 2023 05:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDWDFw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 23:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjDWDFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 23:05:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFA4210E
        for <linux-pci@vger.kernel.org>; Sat, 22 Apr 2023 20:05:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a68f2345c5so28498225ad.2
        for <linux-pci@vger.kernel.org>; Sat, 22 Apr 2023 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682219149; x=1684811149;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crhg2BtmzV8z4fyeXuT3xLp41da6Pfmqjc/PTEndqFM=;
        b=G9xbbtwY9Pdx+xP4Mhg57gpO5BbHxpcuAkWKxKCn7dEPJHPJhscll/9jG19ZmVdxR3
         Udga/B9CAWMVvUgWbIQhwVs0f6jJnlavvoIeolP6dPxPcP9a7gRPpfrDYru56hO5mL7M
         dyw4dDYxZm1hOJSPXhjCj7A6jOw3VZcZ/nEfdvyilyjnKfedvagcfVb3RMx/Q/t9K5JX
         f7y0dY6uZz3x0Dqs3Cyw6Fd2SF8N88mhujMpaxq2+0Jb9QB/7uD2b3HJDLm7BYUuutrQ
         59e1Np4YhXK+lghsWsMmnEbcGgNiSU12Zr2RD1ZjhmYLaPeFcCbUmlnHdsf+dKJPEyrB
         C2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682219149; x=1684811149;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crhg2BtmzV8z4fyeXuT3xLp41da6Pfmqjc/PTEndqFM=;
        b=k2NJ6Km0wrZpaBz5Zdd+Kr8qgSNGZ0gvjI1/dYwa2x1iJDaJaq3OQrrpSuiJRxRqSq
         IfYck2XMzfsX1I9LAsW4cw58I1XuP5k+0BCRmj8jumjX0r9Df7iK/TM0tocfXrUmgQz6
         CLnzm38B8hofgyHEEInya2fmC+I7J8p3CLhL0DVuQ6zJx8OLyn1P45Baaobnh2Ycudaz
         ftwvXiWPEU7mjLPVFUPW+g/z5YnyQYaZJqxzfszTVm5brts0b4ptlN71gxyurjoiju2x
         Fef/eGwFaBvqHAlYK0QHFo3WTRIWPhzXbcw8LQ0PEAGonvrBXhqadWAO2WQvaMzMEGFQ
         2Gvw==
X-Gm-Message-State: AAQBX9dnh3suP4pCPStnQEoTBhI48aIVLzNxlgPagG39/Cxgs+fZMS3B
        p6Dbw2Rm2XztyW/kgjdbL7PrlQ==
X-Google-Smtp-Source: AKy350bTF3GschNC3Wp1o4THB7iil7PMwvgBN1IquHPj20l5TL4uIusprnmXUKNRHWp6mQ6pSorJEA==
X-Received: by 2002:a17:902:d4ca:b0:1a6:523c:8583 with SMTP id o10-20020a170902d4ca00b001a6523c8583mr11670530plg.68.1682219148771;
        Sat, 22 Apr 2023 20:05:48 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b001a6370bb33csm4584954plb.41.2023.04.22.20.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 20:05:47 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2] arm64: PCI: Add quirk for Qualcomm WoA devices
Date:   Sun, 23 Apr 2023 11:05:20 +0800
Message-Id: <20230423030520.9570-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
host bridge windows") introduced a check to remove host bridge register
resources for all arm64 platforms, with the assumption that the PNP0A03
_CRS resources would always be host bridge registers and never as windows
on arm64 platforms.

The assumption stands true until Qualcomm WoA (Windows on ARM) devices
emerge.  These devices describe host bridge windows in PNP0A03 _CRS
resources instead.  For example, the Microsoft Surface Pro X has host
bridges defined as

    Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
    Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID

    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
    {
        Name (RBUF, ResourceTemplate ()
        {
            Memory32Fixed (ReadWrite,
                0x60200000,         // Address Base
                0x01DF0000,         // Address Length
                )
            WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                0x0000,             // Granularity
                0x0000,             // Range Minimum
                0x0001,             // Range Maximum
                0x0000,             // Translation Offset
                0x0002,             // Length
                ,, )
        })
        Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
    }

The Memory32Fixed holds a host bridge window, but it's not properly
defined as a "producer" resource.  Consequently the resource gets
removed by kernel, and the BAR allocation fails later on:

    [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
    [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
    [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
    [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]

This eventually prevents the PCIe NVME drive from being accessible.

Add a quirk for these devices to avoid the resource being removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes for v2:
- Match devices using PPTT instead of DSDT to avoid maintenance burden.
  Hope this is an acceptable compromise.
- Add const delaration to qcom_platlist[].

v1 link:
https://lore.kernel.org/lkml/20230227021221.17980-1-shawn.guo@linaro.org/

 arch/arm64/kernel/pci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 2276689b5411..2ff2f3befa76 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -109,16 +109,44 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	return 0;
 }
 
+#define QCOM_PCI_QUIRK "Host bridge windows in PNP0A03 _CRS"
+
+/*
+ * Ideally DSDT (Differentiated System Description Table) should be used to
+ * match the platforms, as the quirk is in there. But devices from different
+ * manufacturers usually have different oem_id and oem_table_id in DSDT,
+ * so matching DSDT makes the list a maintenance burden.  As a compromise,
+ * PPTT (Processor Properties Topology Table) is used instead to work
+ * around this quirk for the most Qualcomm WoA (Windows on ARM) devices.
+ */
+static const struct acpi_platform_list qcom_platlist[] = {
+	{ "QCOM  ", "QCOMEDK2", 0, ACPI_SIG_PPTT, all_versions, QCOM_PCI_QUIRK },
+	{ }
+};
+
 static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 {
 	struct resource_entry *entry, *tmp;
 	int status;
+	int idx;
 
 	status = acpi_pci_probe_root_resources(ci);
+
+	/*
+	 * Instead of describing host bridge registers in PNP0A03 _CRS
+	 * resources, Qualcomm WoA devices describe host bridge windows in
+	 * there.  We do not want to destroy the resources on these platforms.
+	 */
+	idx = acpi_match_platform_list(qcom_platlist);
+	if (idx >= 0)
+		goto done;
+
 	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
 		if (!(entry->res->flags & IORESOURCE_WINDOW))
 			resource_list_destroy_entry(entry);
 	}
+
+done:
 	return status;
 }
 
-- 
2.17.1

