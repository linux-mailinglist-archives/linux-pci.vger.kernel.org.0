Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF34E1A6A
	for <lists+linux-pci@lfdr.de>; Sun, 20 Mar 2022 07:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbiCTGak (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Mar 2022 02:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244812AbiCTGaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Mar 2022 02:30:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A95FF1E98
        for <linux-pci@vger.kernel.org>; Sat, 19 Mar 2022 23:29:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a18-20020a25bad2000000b0063360821ea7so9942216ybk.15
        for <linux-pci@vger.kernel.org>; Sat, 19 Mar 2022 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ASJzKtjYfW3z8f/kiOdf3O3IhYj+R3xbLBVIICLaL3k=;
        b=dPFkW/Ck2UL5AoOdA6Cz0rPjNvn8yK05uE0Xm2HL/viXm1ySX1TLtgDnqRKai9VyMl
         KLy4K5nYOqrleAfGBOFi14Jz8snJOM/Ma3lE5CQaWYaq9GNDs8Tbwqgb9al+0Frlcho0
         cXAEGoW8VtU11wcxOJOnzwgXAgwWe6avL9HI6MybXN92SKK6Mn2o330K1OzbD3AE5f4c
         AX0t6SUjhSdCulmD3jO0nRMVEwMLRkEAja9VO8AX8kQnJDyncnJdrdCeFcDee0PM4inx
         5bq5duGStWNWRNbLTMkjtH5WgvXivj37aFUbhbREceZOmLwQ2PCavmihJR2SuBIsN2yH
         CivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ASJzKtjYfW3z8f/kiOdf3O3IhYj+R3xbLBVIICLaL3k=;
        b=ZMu2iraiQ/aN1YzAfHhGGpR1xt2T7IZ7gBToh3KmD8jXAYmRcESJ6xqYWOE4Pnn8Wl
         752clTZ3iarH4LeTGugpYN4RrVPSdkZrIKHTWt06be8PL5bG15yCHMCtkNSZQ+oRVju+
         8Ebdr41YNwxd4sLG3x71BnqMicu5f+SEGtjfN8Z65CtFyfmzBaO4W7v1mosnSg2nVF0O
         4aDlL7n3yZoyUjyupjUwBXEMzCk2D23KdaQ5mzZevqJwOEQe6tzkPAoRVl/GPQwnQGgl
         A46KjawMchbICdc/duOxhXvvAYOCIWmzqEFKWlVnNOJohdlLHInBEyWjwEW/YSq2C2UP
         MFIQ==
X-Gm-Message-State: AOAM530NPSd1EkBcI3fDNB8i03NgQRIihRIY0I00n+H/AyxGRFvFXK/5
        EdPEL2SFBZ5XufsgbybNajBWpRut7hGo
X-Google-Smtp-Source: ABdhPJyA1/PLVkOcQRO7zP5IrnCWC5GLuOxnX8km0260X51BYH8R29UtxaOINOdqUREPgrXHVEXZVZqiVanY
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:5445:bc31:4f4a:d610])
 (user=rajatja job=sendgmr) by 2002:a25:c884:0:b0:633:7961:8a06 with SMTP id
 y126-20020a25c884000000b0063379618a06mr17596271ybf.38.1647757756226; Sat, 19
 Mar 2022 23:29:16 -0700 (PDT)
Date:   Sat, 19 Mar 2022 23:29:06 -0700
In-Reply-To: <20220320062907.3272903-1-rajatja@google.com>
Message-Id: <20220320062907.3272903-2-rajatja@google.com>
Mime-Version: 1.0
References: <20220320062907.3272903-1-rajatja@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v4 2/2] PCI: ACPI: Support Microsoft's "DmaProperty"
From:   Rajat Jain <rajatja@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "DmaProperty" is supported and documented by Microsoft here:
https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
They use this property for DMA protection:
https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt

Support the "DmaProperty" with the same semantics. This is useful for
internal PCI devices that do not hang off a PCIe rootport, but offer
an attack surface for DMA attacks (e.g. internal network devices).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: * Add the GUID. 
    * Use the (now) renamed property - pci_dev->poses_dma_risk)
    * Update the comment and commitlog.
v3: * Use Microsoft's documented property "DmaProperty"
    * Resctrict to ACPI only

 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d0986bda2964..20603cacc28d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -48,6 +48,9 @@ static const guid_t prp_guids[] = {
 	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
 	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
 		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
+	/* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
+	GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
+		  0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
 };
 
 /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1f15ab7eabf8..5360f1af2ed3 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1350,12 +1350,28 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
+{
+	u8 val;
+
+	/*
+	 * Property also used by Microsoft Windows for same purpose,
+	 * (to implement DMA protection from a device, using the IOMMU).
+	 */
+	if (device_property_read_u8(&dev->dev, "DmaProperty", &val))
+		return;
+
+	if (val)
+		dev->poses_dma_risk = 1;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_acpi_check_for_dma_protection(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.35.1.894.gb6a874cedc-goog

