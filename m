Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7FC4B939F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 23:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiBPWGC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 17:06:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiBPWGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 17:06:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AF72AED8A
        for <linux-pci@vger.kernel.org>; Wed, 16 Feb 2022 14:05:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c10-20020a251c0a000000b0062272fc32bfso7004549ybc.17
        for <linux-pci@vger.kernel.org>; Wed, 16 Feb 2022 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=flQKyFZ9duOPZtd4zXwnyBqVYzgGGyydxhPq51y6plY=;
        b=YobYbyfeweFubZAvOgK/ACXLIu9QYAmgvkFvi0nLU5nZF8FZ+fc/qzcZGODFOCc5rB
         rGKb6RGf8Xi8UqhtFxLMQ+d8bEb6w7pe93oYN+9zbacfjyUmJ4lQfICSnt2KCwZrx3tL
         B9/GzjbK6BdZa/kqEEzzN+TccelXGLIgu8Jut6r7Fmeq7B+97vW5QlCoaBsfeeQdyP8g
         hovC+Qfn1fNr4RBlQQgMBq3VnH+sjDNyQpVsfD6vgQQcJoDhAtvb7GP0h3gk3GCJuslW
         lL8XivVVzXUBdZlY87zwktTozYrzhJkhCZSxxUs1dc56gL/FJWpiy391jtAx6DloyaDr
         6Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=flQKyFZ9duOPZtd4zXwnyBqVYzgGGyydxhPq51y6plY=;
        b=YhPY9iHp1kWjOjTLAW1Mo/TYRv/w9k8Kb1QEU/LozLoWeo4p8zWXutXdfyVcemggtG
         fSeOqrQIAZVUz/2cK6KpgZcXAoj010cZuUBGGjU6Lustemv29ZxCP7pgYYlmPgN/uzBe
         BbBJxbkJuWim0hwHM3/reOzgBaOMcblo0MHYTjnXQBpxZ9dRjg7nAoSEbGJ9HRv5Cabc
         z928j/O2jniLCeQlyXGZp5MdONeyNXS5mXymGDBaLHisccIETmrKYsVFiu7iG9yFgbm4
         awteHCo2nw6zCoyO+bphxhyapST4WpeztRg4QDhR//UJOmddHCZvEU+Lu5cgNXbrVfJN
         gYZw==
X-Gm-Message-State: AOAM531ap7uFLp2SsOmnJX3iM6RV36+v7Xzjm5Bp77Jzx/Gt/jq30cxc
        a2viZQRkffrHcbZR2bsgLglW9cQ70aZK
X-Google-Smtp-Source: ABdhPJyFAKeq/HMX/fgmE1eQw0hYq6cqNmThpbybyHXt53ADj9iBuVkiR7I7KvXxgTNs+xHjhaStLlnnKCDr
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:f786:406d:21f6:1e1b])
 (user=rajatja job=sendgmr) by 2002:a0d:c441:0:b0:2d0:f04e:a1ee with SMTP id
 g62-20020a0dc441000000b002d0f04ea1eemr4399572ywd.263.1645049146781; Wed, 16
 Feb 2022 14:05:46 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:05:41 -0800
Message-Id: <20220216220541.1635665-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3] PCI: ACPI: Support Microsoft's "DmaProperty"
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
        Joerg Roedel <joro@8bytes.org>
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

Support the "DmaProperty" with the same semantics. Windows documents the
property to apply to PCIe root ports only. Extend it to apply to any
PCI device. This is useful for internal PCI devices that do not hang off
a PCIe rootport, but offer an attack surface for DMA attacks (e.g.
internal network devices).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: * Use Microsoft's documented property "DmaProperty"
    * Resctrict to ACPI only

 drivers/pci/pci-acpi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a42dbf448860..660baa60c040 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1350,12 +1350,30 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
+{
+	u8 val;
+
+	/*
+	 * Microsoft Windows uses this property, and is documented here:
+	 * https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
+	 * While Microsoft documents this property as only applicable to PCIe
+	 * root ports, we expand it to be applicable to any PCI device.
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
2.35.1.265.g69c8d7142f-goog

