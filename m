Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50D37EEF9
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhELWjg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 18:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347311AbhELVqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 17:46:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D4C06134E
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 14:35:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p64-20020a2529430000b02904f838e5bd13so29830185ybp.20
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O4prwy0dt076IdQhcTAcUnDE5VADW8jC/nkDuCrMp/E=;
        b=cg5jrRhYrcGnbAPJsnJ/5EYIxyKKBKikA6TdWTgM6hM+NftKs1GDRfa0rm+EChPCuZ
         t0L4Tq5/946AM60F0m7nlK2FWPIyXEp1S+RxTnYQBnWwKIMQ8XaeZTAh6YXklnGxXmG2
         APCBf4UhSgHVeUqOQrA9ua0wH3PgO48v7agpbCJ1WztS5T0fe/eI/qqjaqIymxSRSplF
         qZO865O4FLo0EzxPr/oLNQWgbxq7Yxh90O0YiLR1TevdUqpziX5IGY1u+ZKDuvs3YpS3
         Q5NEueKOa+IPrzmQkst2OXlVbH2/mXDVqVYkHFPu6P5nlpruN6MUDj9x9esFSpc9btKT
         zCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O4prwy0dt076IdQhcTAcUnDE5VADW8jC/nkDuCrMp/E=;
        b=O5tvTC6QcJhZJTXzR9VTWK18KznitCo24GnPmF2HsWL/QruiabDmeNDi4VaEDz3G+g
         x1YxkmxaIS6iYpIWtt1YsX+oUZ4rvwBhdP4XHoKG8AkQPR1QloVWK8ncfy6X4R5rNMfu
         ay2ce1gZ+J3cG8opdglm961UoiuLcYMlXbAa0Z0FeXnm9q+wcD64V3/187nyHNTG0uL7
         njkDS2MhHBan4Sm/xCt3a4wGf5/5xitl6U2OKifbgG/a0793egSCRZDbVw1KbOZMAMQl
         QGJoQQGem3oCmDbZ8c2jpmzQ5yMcXiHLgjyPlQrDy674DzhpGirBF9FKeb2pt6BrIISr
         lvVA==
X-Gm-Message-State: AOAM533c+ZDSurMzxil1kYlvHrFsdXS9ZIWglpTnXTRskfO32BcVBz6/
        u2SlSp8lxaTDcpmaMjfjePa0TvNSaoKm
X-Google-Smtp-Source: ABdhPJxmhNKqohQCYBcFHAEgPzE3okQz2tv+sCqfcm/srb8tvpZZ3v51jWN+0aF+A7bm9uvOqqs5xcifsO3M
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:45af:4b75:ef28:4f6d])
 (user=rajatja job=sendgmr) by 2002:a25:dc89:: with SMTP id
 y131mr48833854ybe.493.1620855305337; Wed, 12 May 2021 14:35:05 -0700 (PDT)
Date:   Wed, 12 May 2021 14:34:57 -0700
In-Reply-To: <20210512213457.1310774-1-rajatja@google.com>
Message-Id: <20210512213457.1310774-2-rajatja@google.com>
Mime-Version: 1.0
References: <20210512213457.1310774-1-rajatja@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v3 2/2] PCI: Add sysfs "removable" attribute
From:   Rajat Jain <rajatja@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        helgaas@kernel.org, Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>
Cc:     rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A PCI device is "external_facing" if it's a Root Port with the ACPI
"ExternalFacingPort" property or if it has the DT "external-facing"
property.  We consider everything downstream from such a device to
be removable by user.

We're mainly concerned with consumer platforms with user accessible
thunderbolt ports that are vulnerable to DMA attacks, and we expect those
ports to be identified as "ExternalFacingPort". Devices in traditional
hotplug slots can technically be removed, but the expectation is that
unless the port is marked with "ExternalFacingPort", such devices are less
accessible to user / may not be removed by end user, and thus not exposed
as "removable" to userspace.

Set pci_dev_type.supports_removable so the device core exposes the
"removable" file in sysfs, and tell the device core about removable
devices.

This can be used by userspace to implment any policies it wants to,
tailored specifically for user removable devices. Eg usage:
https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
(code uses such an attribute to remove external PCI devicces or disable
features on them as needed by the policy desired)

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: - commit log updated
    - Rename set_pci_dev_removable() -> pci_set_removable()
    - Call it after applying early PCI quirks.
v2: Add documentation

 Documentation/ABI/testing/sysfs-devices-removable |  3 ++-
 drivers/pci/pci-sysfs.c                           |  1 +
 drivers/pci/probe.c                               | 12 ++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
index 9dabcad7cdcd..ec0b243f5db4 100644
--- a/Documentation/ABI/testing/sysfs-devices-removable
+++ b/Documentation/ABI/testing/sysfs-devices-removable
@@ -14,4 +14,5 @@ Description:
 
 		Currently this is only supported by USB (which infers the
 		information from a combination of hub descriptor bits and
-		platform-specific data such as ACPI).
+		platform-specific data such as ACPI) and PCI (which gets this
+		from ACPI / device tree).
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index beb8d1f4fafe..38b3259ba333 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1541,4 +1541,5 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
 
 const struct device_type pci_dev_type = {
 	.groups = pci_dev_attr_groups,
+	.supports_removable = true,
 };
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3a62d09b8869..3515afeeaba8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1575,6 +1575,16 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 		dev->untrusted = true;
 }
 
+static void pci_set_removable(struct pci_dev *dev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(dev);
+	if (parent &&
+	    (parent->external_facing || dev_is_removable(&parent->dev)))
+		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+	else
+		dev_set_removable(&dev->dev, DEVICE_FIXED);
+}
+
 /**
  * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
  * @dev: PCI device
@@ -1822,6 +1832,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 
+	pci_set_removable(dev);
+
 	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
 		 dev->vendor, dev->device, dev->hdr_type, dev->class);
 
-- 
2.31.1.607.g51e8a6a459-goog

