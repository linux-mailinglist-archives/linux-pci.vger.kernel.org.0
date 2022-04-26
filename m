Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A964C50ED29
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 02:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbiDZAJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 20:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiDZAJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 20:09:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F73120111
        for <linux-pci@vger.kernel.org>; Mon, 25 Apr 2022 17:06:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h14-20020a25e20e000000b006484e4a1da2so4429745ybe.9
        for <linux-pci@vger.kernel.org>; Mon, 25 Apr 2022 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EQ6VT6w46Hd44XRTan9TInx0ubvgoNtxDCqLgonw/Fw=;
        b=HS1HO9FzmdSJFLMep5JjzcdD/vAauAAiJdJtzVrco1UZk50LeqYCzwhWCfRJZ34zuo
         qofqkRZyy6+RFdFh2w+QDW8VSe7d6xxNp46ta/i+iF8YOjRw3+5tLbnRtaro28Cio8o4
         OiNAeSDzHohgt4vbhCl/9Wvc9F6y3USITzJ10+JX+o97t3jdebP1nHALnKme07MYlKGU
         mxH/cmQgkqRAOh5TyDU0LaZ+kzTDPONTBv2KsgkeszUMtpbaBxIlgTjQx1ZHJGgr9rAO
         X8d6uZP7cZOeMc6TODikbj71Y+Li4qUszasbi90W6haTph6MsBXtG6XPJ0xdp8YxPd40
         2tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EQ6VT6w46Hd44XRTan9TInx0ubvgoNtxDCqLgonw/Fw=;
        b=fwwGtEdQ8voBrAw5vLprmnxoqakI7B0ec3K+cqeUcPt0BwpiT7zGfd0HzYAHbfASRx
         nFrSQxVpZV+ujPVPsYevB70QbujVkvwwyUkzkTqzrkXRg7hnpp6BKyEBKyPvRBAPe4wX
         0KcTQhvVGSxSR4ISv7t7ky6oWgzPvGGlDoQTrG5mb7y1PVHJ1ixjK5wdgX8+vKjpj8TD
         QUsiHdmBXkZ+7t71eikJqFbToJQsEyg5pUoko0db+BpEp+IqUvqImIVSJizVTvAjxjRE
         vKTkFlG+YYp771EJa77hK1RenRJFk3r4kAngYaHXdjsRepsY6NPkXe/Q/1TArvSyXY8w
         vrew==
X-Gm-Message-State: AOAM532X3fkMrP71LzfEsxWtxhWflgLZzkuMDt5kxJaTq68CE4KAWC6B
        d8ai+A/vEPlb6KjXVPAHCBR3z+ut4njv
X-Google-Smtp-Source: ABdhPJwNNzWNR0miZ2gObmHApAL+Qq+RPW++GHIubAxH7gus9hz33wGevQAaQAJC9bdTGWNEfprWQMSD7v1q
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:9590:6ed7:be38:9068])
 (user=rajatja job=sendgmr) by 2002:a25:f30f:0:b0:648:6d75:614 with SMTP id
 c15-20020a25f30f000000b006486d750614mr6652624ybs.558.1650931604103; Mon, 25
 Apr 2022 17:06:44 -0700 (PDT)
Date:   Mon, 25 Apr 2022 17:06:39 -0700
Message-Id: <20220426000640.3581446-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v6 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
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
Cc:     Rajat Jain <rajatja@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "DmaProperty" is supported and currently documented and used by
Microsoft [link 1 below], to flag internal PCIe root ports that need
DMA protection [link 2 below]. We have discussed with them and reached
a common understanding that they shall change their MSDN documentation
to say that the same property can be used to protect any PCI device,
and not just internal PCIe root ports (since there is no point
introducing yet another property for arbitrary PCI devices). This helps
with security from internal devices that offer an attack surface for
DMA attacks (e.g. internal network devices).

Support DmaProperty to mark DMA from a PCI device as untrusted.

Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v6: * Take care of Bjorn's comments:
       - Update the commit log
       - Rename to pci_dev_has_dma_property()
       - Use acpi_dev_get_property()
v5: * Reorder the patches in the series
v4: * Add the GUID. 
    * Update the comment and commitlog.
v3: * Use Microsoft's documented property "DmaProperty"
    * Resctrict to ACPI only

 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 12bbfe833609..bafe35c301ac 100644
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
index 3ae435beaf0a..d7c6ba48486f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1369,12 +1369,33 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static int pci_dev_has_dma_property(struct pci_dev *dev)
+{
+	struct acpi_device *adev;
+	const union acpi_object *obj;
+
+	adev = ACPI_COMPANION(&dev->dev);
+	if (!adev)
+		return 0;
+
+	/*
+	 * Property also used by Microsoft Windows for same purpose,
+	 * (to implement DMA protection from a device, using the IOMMU).
+	 */
+	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
+				   &obj) && obj->integer.value == 1)
+		return 1;
+
+	return 0;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

