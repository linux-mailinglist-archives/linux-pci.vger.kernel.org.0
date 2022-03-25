Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01894E7B6C
	for <lists+linux-pci@lfdr.de>; Sat, 26 Mar 2022 01:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiCYTkc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiCYTjw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 15:39:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5509E1546A5
        for <linux-pci@vger.kernel.org>; Fri, 25 Mar 2022 12:12:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h8-20020a25e208000000b00628c0565607so6807581ybe.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Mar 2022 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=woMjFLNUegNjbJ51x62lvW6UbmQA+Ba7zyUjvkY6YYA=;
        b=pPUMCEvf8BZ62Y/c+W1qNInLop6JGyWd784jOQMkj1CbDHqg6py/a0QUTHIl90KdK9
         w8p+a0V9OwXTGRp2ndKsQIWc5a+N8W0cnnGZFdPvIxrlF1S6agDjEDnrq+kop7VArS9W
         RbYNWRUOGzcuxrBV4L2CC5m9He2upt/Ljn2rs9gmG3kXrsXyBQMYXRw3Gbsg1t4Arnqw
         Vz5BauwAV3zM0pm0GHPutIyIuVDPFsGPQzM4SkLsQISvm66TNi9ybfRXySbc8zm/ozK8
         dVwdJktR7GmW3rsxUBUyM3bSBrBGyKaXWu9kydtN+Kk/btVZUC8+M9kY4J9l0j+/DcQR
         l9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=woMjFLNUegNjbJ51x62lvW6UbmQA+Ba7zyUjvkY6YYA=;
        b=bsprFepp01fowvXqGyBOZ+ex0KySQ6VhygmA7xjY+e3oGG1KbkkEvT/khL0pNz/KBP
         bWgeJcwmISBYsbavBlQsmyRDihmMHKpIdup0pHbqIUGm3R6axnEpIFIGEmGDW3aM9lsq
         70MKaIC1AizvhBFuvptIGulJePmETfZYDZdos8IYu+Z+q889Co+Cr7ZXycYj+vK5AHMo
         3GphxBooUUV0wxJsumtsFm674gzUgIH8Hky/4LUhuJeR4NFIKp5LQujHin8OhfGA7aDN
         yduTzf4luvLHCKvbCQDdjctJbYiaHCTnoGTRAcaP5j789D1n4naBdLFMEC81rXc3Wfis
         8aPw==
X-Gm-Message-State: AOAM531Wi/Iauj5ldwyxLEcY0thKjcudQGc/MOptFq22EggGTqFTtmVM
        g5W6Fqu6zM9rx/qu1YrYyps8WpvWQfY0
X-Google-Smtp-Source: ABdhPJyRS7LP7fvCaSt0TldDrztqH9QfayLTVY7BMeLHgtTzqTb9UkZpPGUKvtovyGUbBIdo731RsDJISrP1
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:4cfc:6eaf:38d8:46d6])
 (user=rajatja job=sendgmr) by 2002:a81:94d:0:b0:2e5:b91a:195b with SMTP id
 74-20020a81094d000000b002e5b91a195bmr12106133ywj.44.1648233973993; Fri, 25
 Mar 2022 11:46:13 -0700 (PDT)
Date:   Fri, 25 Mar 2022 11:46:08 -0700
Message-Id: <20220325184609.4059963-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v5 1/2] PCI: ACPI: Support Microsoft's "DmaProperty"
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v5: * Reorder the patches in the series
v4: * Add the GUID. 
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
index 1f15ab7eabf8..378e05096c52 100644
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
+		dev->untrusted = 1;
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
2.35.1.1021.g381101b075-goog

