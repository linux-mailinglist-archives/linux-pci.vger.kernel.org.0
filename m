Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73D4C07D4
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfI0Oo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 10:44:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfI0Oo1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Sep 2019 10:44:27 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3362A5859E
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2019 14:44:26 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j2so1138249wre.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2019 07:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKJlXVu+C+SUSWhFcHR/cVLK3eVfpegwLk/6ZeTU4Lw=;
        b=gX6TN3q4KpWhjflCzdKKtDoalUHjWM+QMEv1s9De4gJR3R8wk1jMWR+D5zV3P7PIYp
         kAHwLEh6LhlvHGAM0pH06lUXMnmUAWqoSQmMj3ZfOLhFcrXCvn1ldLFT1f1kCGQIXbAO
         DeAehqjbHNKw0dhugcuuGjE8Li3qfk8gXZo50wr2kfFEXYg6UDxvfGXykM8OX6v4qgDA
         FO0EhEhxU1nd7GKbLZ7CqI5ZMCvjRfPEJkyEAa4N1XU6lRA38+DXZ116UjnRgNvghR1V
         ynqYi0quJ5ikz4/cAno0T+txmt9bFwAqrtVH3FY74aUAdMmKYWQ53CsHsfWcrBj6Czea
         RIaQ==
X-Gm-Message-State: APjAAAVrdS7p8fMXoULsD8SGTGtJcuW+mRvDKdj6m7Xz6uEEe7DckjNO
        sGcOnd2mmRA+JfX5cNdvP9SHsmoQ695APM8XubJ5W6yRnFr7kDWcsyQcARsHYuhspdv/Tk9MMxG
        CYi3vrDfuzEJMBJs2vr9D
X-Received: by 2002:a1c:1c7:: with SMTP id 190mr395780wmb.23.1569595464975;
        Fri, 27 Sep 2019 07:44:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxC2IYP1DXa/fMg1u9ig7ZhBeyIkZ56QIfJYKHZiecxua/UDg6iVgqlCp0MKwat0LoPX/Jjxg==
X-Received: by 2002:a1c:1c7:: with SMTP id 190mr395767wmb.23.1569595464744;
        Fri, 27 Sep 2019 07:44:24 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:6174:20eb:3f66:382f])
        by smtp.gmail.com with ESMTPSA id e18sm4580926wrv.63.2019.09.27.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:44:23 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [RFC PATCH] pci: prevent putting pcie devices into lower device states on certain intel bridges
Date:   Fri, 27 Sep 2019 16:44:21 +0200
Message-Id: <20190927144421.22608-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes runpm breakage mainly on Nvidia GPUs as they are not able to resume.

Works perfectly with this workaround applied.

RFC comment:
We are quite sure that there is a higher amount of bridges affected by this,
but I was only testing it on my own machine for now.

I've stresstested runpm by doing 5000 runpm cycles with that patch applied
and never saw it fail.

I mainly wanted to get a discussion going on if that's a feasable workaround
indeed or if we need something better.

I am also sure, that the nouveau driver itself isn't at fault as I am able
to reproduce the same issue by poking into some PCI registers on the PCIe
bridge to put the GPU into D3cold as it's done in ACPI code.

I've written a little python script to reproduce this issue without the need
of loading nouveau:
https://raw.githubusercontent.com/karolherbst/pci-stub-runpm/master/nv_runpm_bug_test.py

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
---
 drivers/pci/pci.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 088fcdc8d2b4..9dbd29ced1ac 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -799,6 +799,42 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
 }
 
+/*
+ * some intel bridges cause serious issues with runpm if the client device
+ * is put into D1/D2/D3hot before putting the client into D3cold via
+ * platform means (generally ACPI).
+ *
+ * skipping this makes runpm work perfectly fine on such devices.
+ *
+ * As far as we know only skylake and kaby lake SoCs are affected.
+ */
+static unsigned short intel_broken_d3_bridges[] = {
+	/* kbl */
+	0x1901,
+};
+
+static inline bool intel_broken_pci_pm(struct pci_bus *bus)
+{
+	struct pci_dev *bridge;
+	int i;
+
+	if (!bus || !bus->self)
+		return false;
+
+	bridge = bus->self;
+	if (bridge->vendor != PCI_VENDOR_ID_INTEL)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(intel_broken_d3_bridges); i++) {
+		if (bridge->device == intel_broken_d3_bridges[i]) {
+			pci_err(bridge, "found broken intel bridge\n");
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *			     given PCI device
@@ -827,6 +863,9 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (state < PCI_D0 || state > PCI_D3hot)
 		return -EINVAL;
 
+	if (state != PCI_D0 && intel_broken_pci_pm(dev->bus))
+		return 0;
+
 	/*
 	 * Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper
-- 
2.21.0

