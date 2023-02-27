Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47576A3867
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 03:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjB0CTN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Feb 2023 21:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjB0CSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Feb 2023 21:18:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F5A1EFFF
        for <linux-pci@vger.kernel.org>; Sun, 26 Feb 2023 18:14:14 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so10419392pjn.1
        for <linux-pci@vger.kernel.org>; Sun, 26 Feb 2023 18:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9Elx/OktSxbW/ZTsMXsiJKt2uP4I2yrugiLovEI2eU=;
        b=tF1eklQmlLz5nvLkUV7z7sNrSoRJ5Z3ElhvAX1ZQ46oBIl56yxrldAoNyZyN49kR75
         KRW4AnMlCGgt56FtQKXPH0oGjc0T8r9j350X6iO6r3b06ipjlWhfDhoJU+DtXe+NsOYN
         uYgq6878KXvXZVfk56ZjfhBEkmbYdjlLHQQw26dOHmO1PdU/qgQV+TQjh1dKs5lcBzO7
         9X3F2qgc8kf/3dv11Og0C7iWqUMKD0+55Wypw7gHBEEx6MrZiUeKHy1fXwqV4gpZ6iX+
         gG80HjwtEeckb7qpZFrVA51OO2tMhsVPZrcReZBjMMniRmmOxKQI3xuF4R6JMU27goJz
         6tgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9Elx/OktSxbW/ZTsMXsiJKt2uP4I2yrugiLovEI2eU=;
        b=hpJuermdeuKUllvoe5FYGx0kivzUHv/IgNYz8n53uMC4IfU5zohYh1Tj/m/gQHuT8h
         pVU1qBCLOUIBlQQKxIQqg+1L2wqAoiTTNqVDeA4kIK4VzKKeNUa4P/d9DpKmg/RRXTI0
         Xaeyrex5CAnwKhvF7expBHTvpD/pbeTDVuXNQnuke1JRTUj+tgjnRpyvSanYpk6QfvbK
         GVV6fbKjpZKx+qLAWBYAC5sOafwq1QGrSq90JDJWf9sgh2kAKUmfCAoeZ7hCpGg+BAL2
         rGLdxw4NkVRqCC+DuNpldvNOkXQcpCtaNwON/DY6NcLUvcErj0IWviFTvmkhbQOUbYbF
         NM1A==
X-Gm-Message-State: AO0yUKV4zZLAHOtXj2Mxc1hRmUzKtc0nhEXCWnVpLqHLrEvlnWo9mzsV
        Ek0Rt4n2XmJvjknV1/G6XfZggw==
X-Google-Smtp-Source: AK7set/WT431W3AXator1w5cHD9yTUKHJM7s2Y35U5EitKL/JiMXaRXP5rZCuKam91/vBJCfjydGwg==
X-Received: by 2002:a17:90b:4c50:b0:234:1f57:ecb1 with SMTP id np16-20020a17090b4c5000b002341f57ecb1mr23918858pjb.40.1677463966735;
        Sun, 26 Feb 2023 18:12:46 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a68c200b00234b785af1dsm3124513pjj.26.2023.02.26.18.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 18:12:45 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] arm64: PCI: Add quirk for platforms running Windows
Date:   Mon, 27 Feb 2023 10:12:21 +0800
Message-Id: <20230227021221.17980-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
host bridge windows") introduced a check to remove host bridge register
resources for all arm64 platforms, with the assumption that the PNP0A03
_CRS resources would always be host bridge registers and never as windows
on arm64.

The assumption stands true until Qualcomm Snapdragon Windows laptops
emerge.  These laptops describe host bridge windows in PNP0A03 _CRS
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

Add a quirk for these platforms to avoid the resource being removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
We are running into the issue on more devices than just Surface Pro X
now, so trying to sort it out with a quirk as suggested by Lorenzo [1].

[1] https://lore.kernel.org/all/20210527093200.GA16444@lpieralisi/

 arch/arm64/kernel/pci.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 2276689b5411..896dbd028b67 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -109,16 +109,42 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	return 0;
 }
 
+#define QCOM_DSDT_QUIRK "Host bridge windows in PNP0A03 _CRS"
+
+static struct acpi_platform_list qcom_platlist[] = {
+	/* Thinkpad X13s */
+	{ "LENOVO", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
+	/* Microsoft Surface Pro 9 (5G) and Windows Dev Kit 2023 */
+	{ "QCOMM ", "SDM8280 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
+	/* Microsoft Surface Pro X */
+	{ "QCOMM ", "SDM8180 ", 0, ACPI_SIG_DSDT, all_versions, QCOM_DSDT_QUIRK },
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
+	 * Most arm64 platforms that do not run Windows describe host bridge
+	 * registers in PNP0A03 _CRS resources, but some like Qualcomm
+	 * Snapdragon Windows laptops describe host bridge windows in there.
+	 * We do not want to destroy the resources for these platforms.
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

