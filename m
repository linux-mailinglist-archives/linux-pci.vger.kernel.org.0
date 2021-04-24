Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A739369E7D
	for <lists+linux-pci@lfdr.de>; Sat, 24 Apr 2021 04:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhDXCRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 22:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbhDXCRQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Apr 2021 22:17:16 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE1EC061756
        for <linux-pci@vger.kernel.org>; Fri, 23 Apr 2021 19:16:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i8-20020a6548480000b02901fb8ebd5714so15303953pgs.12
        for <linux-pci@vger.kernel.org>; Fri, 23 Apr 2021 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TKEPf9xP7+FNQEpv6lL50M3TdirSF/eiH1hrWQCRY5o=;
        b=udh0DmIPk5GqWvOfgWdQNGdjkGvWb/x3HJGafhBtFYld8mjwWaVVh+oZsbZU1KnrLd
         auemL2nKOD7NGcxKR+XGuurcSaNcXnwglupQ+4cCCeM5ysa/iQXb8JU7MJwuCne8K8BI
         GbgE1DIHo5Bf00x0XdzPbPEz4k8trEnh7MQSwYI0NWQSahrRqIYIrrNd8hkl048jMv1H
         NM7bQG1aLj/mPPCsyS5nGnDiQ6P251JOt3I9FfLYyWE7OJB8ESygP0A6Kq0SEh/gWGXc
         H70eawyqHHeDkqoMrwvHq3MF3/tdFRubTMyNmHT5mMBnUX/vslK1ZG2/ggNYb54E7MOC
         JwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TKEPf9xP7+FNQEpv6lL50M3TdirSF/eiH1hrWQCRY5o=;
        b=B9HLv9BQJkf8B2pIXrqMmx6Kt8K0wyKsNf+Vm09bnmI6zrhGxFoAbJdMjxmaLHrOx8
         NurwyyGn3Ja6CsfTaMUIn/0SsmMdRxJIvXlWyIp/vHVqv6KwcNc1BcN0KouBH0ToWgqc
         MXdPBkwWoQe21Ok3xxfr1RWjp2bAfkZT1m8s47j+uzFrp1hLsbrk8Ets2aFR2o/0sjUu
         qJOkEJ2gLw0+hXVXqJqs998PiQ1HWdPWIuA8WrF2+YgB++CIT2Zm/FI8F4SyEEMUe6VD
         fObDU0cHHNDgXj2GLQfibtgR5BzGJOq7kJOJ/KSHip8z+Kj6DWo0wnFdsbtd9fr6M4C2
         mKAw==
X-Gm-Message-State: AOAM533lygH8qC8C4cEhM5t0ZeW3a27uMW7rEyaugxY9ot2h/ZUwzZrH
        FVRqVWWVY67H/szFiambFdwEimPWjZf/
X-Google-Smtp-Source: ABdhPJxbxWJhWAYwpRE5nap2mHgvnzk4LWBr9JI/FjTVoxsf79fnUj2hC/STJT9O0kod3MZfUfgVs4ejVzem
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:5cef:2faf:44cf:b69b])
 (user=rajatja job=sendgmr) by 2002:a17:903:248e:b029:ec:9c4f:765e with SMTP
 id p14-20020a170903248eb02900ec9c4f765emr7098613plw.17.1619230599038; Fri, 23
 Apr 2021 19:16:39 -0700 (PDT)
Date:   Fri, 23 Apr 2021 19:16:31 -0700
In-Reply-To: <20210424021631.1972022-1-rajatja@google.com>
Message-Id: <20210424021631.1972022-2-rajatja@google.com>
Mime-Version: 1.0
References: <20210424021631.1972022-1-rajatja@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
From:   Rajat Jain <rajatja@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        helgaas@kernel.org
Cc:     rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export the already available info, to the userspace via the
device core, so that userspace can implement whatever policies it
wants to, for external removable devices.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Add documentation

 Documentation/ABI/testing/sysfs-devices-removable |  3 ++-
 drivers/pci/pci-sysfs.c                           |  1 +
 drivers/pci/probe.c                               | 12 ++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
index e13dddd547b5..daac4f007619 100644
--- a/Documentation/ABI/testing/sysfs-devices-removable
+++ b/Documentation/ABI/testing/sysfs-devices-removable
@@ -14,4 +14,5 @@ Description:
 
 		Currently this is only supported by USB (which infers the
 		information from a combination of hub descriptor bits and
-		platform-specific data such as ACPI).
+		platform-specific data such as ACPI) and PCI (which gets this
+		from ACPI / device tree).
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f8afd54ca3e1..9302f0076e73 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1582,4 +1582,5 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
 
 const struct device_type pci_dev_type = {
 	.groups = pci_dev_attr_groups,
+	.supports_removable = true,
 };
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..d1cceee62e1b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1575,6 +1575,16 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 		dev->untrusted = true;
 }
 
+static void set_pci_dev_removable(struct pci_dev *dev)
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
@@ -1819,6 +1829,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
+	set_pci_dev_removable(dev);
+
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

