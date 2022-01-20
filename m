Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DC94943F5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 01:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344658AbiATAEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 19:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344601AbiATAEP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 19:04:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17BC061574
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 16:04:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y4-20020a5b0f44000000b00611862e546dso8183035ybr.7
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 16:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=k7+5PtSi2SaE/0SJmGi4QGUE4EmxDvz5Ukuy4725lAE=;
        b=Iyr+MG88n+iHRt04O0HAxgK5CL4awNioywRv0cYQLtlwJ7Cp2SF2E+wRqKyckrKrSy
         hmfqoFYVLlfPXiyjZU06fsJiaM/B8aeEaNl3VbXQGhaWdYv6ndFzA8ejdebFsaE4eeIH
         kEvmt22o01TDRtXrlTgL3RIJthagpYwzNqQ089bNvHagB0KLUVE+3Qebav6fE5W+MVK6
         0aES0QD7R8qT9H/ciOd7arS2npXxDYv2+lDyzoviHA4D/0fKmtDzFqx3ZZuExjD1dTVD
         6mRh2ScSTKfbsEbGwT5BFTnd5Hj5sxoVitLpDVQeh5FObEJFXH+HRD6SHTvrHlLmyzbR
         fK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=k7+5PtSi2SaE/0SJmGi4QGUE4EmxDvz5Ukuy4725lAE=;
        b=oUcdpnXWEnxo3k7PKtPdfLLgkLvWt7IceB/GqPMbJGwgFk2N1tNJB7klD1l4rg8lD4
         DtUeYSIFXFN4KxBmpi/kgAPSg5Xy1dvbb6ta8xhrnir8YnwkS8phfDfmQFg7WYfFmAPm
         PsmsCruNYD+8ty1VNDOy0nUH8DesmDpkeiMWwNYNUrBynMnkIwTV56N5ql8iFO2YedTC
         9owIcu9nw9YFOq3TdKrV+YnVJFsEyHREktYkfuICfTCSVdkWNzh0CsEpSu8yAd9EMmnP
         jvf5tpfdf2aIXe6pZw7caWTcjgQdF9tZY75+tivtnBvNpEFWfAMyqeVgjXZVOtaGE82f
         ACsg==
X-Gm-Message-State: AOAM530KDDGLVdVnKw8fN5xZOmJkrgLLxfIopmytq+zaAJNMJqd6nP1o
        6tBRPScb8E/Xuod8R7Wu3OCTL3qZNI6o
X-Google-Smtp-Source: ABdhPJxHY8jtaOES8j1o7rDLaIqeTvHnKwyZJ56vMd87GW+rxIi4jQUMPrzyY5G6j/GnKeYEUMVs8qiGk8ds
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:4305:5632:a281:7eb0])
 (user=rajatja job=sendgmr) by 2002:a25:7e87:: with SMTP id
 z129mr45619551ybc.719.1642637054515; Wed, 19 Jan 2022 16:04:14 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:04:09 -0800
Message-Id: <20220120000409.2706549-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
From:   Rajat Jain <rajatja@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        dtor@google.com, jsbarnes@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Today the pci_dev->untrusted is set for any devices sitting downstream
an external facing port (determined via "ExternalFacingPort" property).
This however, disallows any internal devices to be marked as untrusted.

There are use-cases though, where a platform would like to treat an
internal device as untrusted (perhaps because it runs untrusted
firmware, or offers an attack surface by handling untrusted network
data etc).

This patch introduces a new "UntrustedDevice" property that can be used
by the firmware to mark any device as untrusted.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci-acpi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a42dbf448860..3d9e5fa49451 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1350,12 +1350,25 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static void pci_acpi_set_untrusted(struct pci_dev *dev)
+{
+	u8 val;
+
+	if (device_property_read_u8(&dev->dev, "UntrustedDevice", &val))
+		return;
+
+	/* These PCI devices are not trustworthy */
+	if (val)
+		dev->untrusted = 1;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_acpi_set_untrusted(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.34.1.703.g22d0c6ccf7-goog

