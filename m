Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F139EE61
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 07:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFHFwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 01:52:23 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41913 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFHFwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 01:52:22 -0400
Received: by mail-ot1-f54.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so19218532oth.8;
        Mon, 07 Jun 2021 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqaJy/AjovIrG5BqeRkyRVaad0hxL4Cbogzxl2VFgCg=;
        b=nfQd8/dr2SaEonVYoXSEM0cWVBbLeXmPcIPjuzwSs7csBoJJB71FqScX4qMSA7TPlR
         02Khas9NGq8WWFgOBPlMFGC5SQV8L6s1iOmWQqA4G+/XS9QBbHQeMUDBtCdNjdTloALJ
         DUqZFlXSQFolcjuxhCv3LkZV1WLys4zST2oiYTnSa3Qw4kdm4NrXH8gOWiQEdmLKH65S
         9PLqPneTkX1Ds6sX5WkVQHC5OsrTpcnYYgfQsYYndZusuZvO6RbEayeXvVuDehL80t9N
         SLWCYGgNr051hwBqKXc2c6clCFNGz0n9050gpC5d54p/um6cSEZ7e/Z08OUTtNFJCA8Y
         5QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqaJy/AjovIrG5BqeRkyRVaad0hxL4Cbogzxl2VFgCg=;
        b=hUKQxqh/dXkaUkMgpeqBXkXULtA2T5RYVp3K2CNKzPcsx9ZEV3iwt5fR1WFQqkiFOl
         h+fmBjLybFpE8qINyKqYbAPXo19pAUhf+bCfhDYsv9CCMFcGrbkRBo2jWNLL8IC38Mbi
         IcxxkGrkbq2s9tkr4h9r2WJOABDZqr0pKnTowtQcOs3zOP7nv9dXVwW9+6FqpOVBgD24
         afc2AGKv4+PS3Z/1qifAI5rDZCdHWWKN9MxyiTfs65ZUNb0r0jSvhGaouH0ks3M9lZ6D
         7iedC6uqzQvp8K0h+rqcE1tHKIl9I74I0rBHcO/u3RhvJYT/fkkYqprDpvegm9/K+xhS
         GUAQ==
X-Gm-Message-State: AOAM530o5nNV1oObX/6mpd0KGp3hCKR36ayT9PVwcC94Fm+kDltZ1PIX
        /1UjUUNmgzBWWgnYcYwf0fARuZueC6gbow==
X-Google-Smtp-Source: ABdhPJwxj0nQZViIBnRT1F1GJWMJu84LJ/OH5BurZLd2eVgW/Gm1SYNRwxTD41nCOZpiUIzFAPkVLw==
X-Received: by 2002:a05:6830:190:: with SMTP id q16mr4126021ota.34.1623131361179;
        Mon, 07 Jun 2021 22:49:21 -0700 (PDT)
Received: from localhost.localdomain (static-198-54-128-46.cust.tzulo.com. [198.54.128.46])
        by smtp.googlemail.com with ESMTPSA id o2sm2489730oom.26.2021.06.07.22.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:49:20 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v7 3/8] PCI: Remove reset_fn field from pci_dev
Date:   Tue,  8 Jun 2021 11:18:52 +0530
Message-Id: <20210608054857.18963-4-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608054857.18963-1-ameynarkhede03@gmail.com>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

reset_fn field is used to indicate whether the device supports any reset
mechanism or not. Remove the use of reset_fn in favor of new reset_methods
array which can be used to keep track of all supported reset mechanisms of
a device and their ordering.

The octeon driver is incorrectly using
reset_fn field to detect if the device supports FLR or not. Use
pcie_reset_flr() to probe whether it supports FLR or not.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
 drivers/pci/pci-sysfs.c                            | 2 +-
 drivers/pci/pci.c                                  | 6 +++---
 drivers/pci/probe.c                                | 1 -
 drivers/pci/quirks.c                               | 2 +-
 drivers/pci/remove.c                               | 1 -
 include/linux/pci.h                                | 1 -
 7 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 516f166ce..336d149ee 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 			oct->irq_name_storage = NULL;
 		}
 		/* Soft reset the octeon device before exiting */
-		if (oct->pci_dev->reset_fn)
+		if (!pcie_reset_flr(oct->pci_dev, 1))
 			octeon_pci_flr(oct);
 		else
 			cn23xx_vf_ask_pf_to_do_flr(oct);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index beb8d1f4f..316f70c3e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1367,7 +1367,7 @@ static umode_t pci_dev_reset_attr_is_visible(struct kobject *kobj,
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	if (!pdev->reset_fn)
+	if (!pci_reset_supported(pdev))
 		return 0;
 
 	return a->mode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 39a9ea8bb..2302aa421 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5232,7 +5232,7 @@ int pci_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_lock(dev);
@@ -5268,7 +5268,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	pci_dev_save_and_disable(dev);
@@ -5291,7 +5291,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	if (!dev->reset_fn)
+	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
 	if (!pci_dev_trylock(dev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8cf532681..90fd4f61f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2405,7 +2405,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
-	dev->reset_fn = pci_reset_supported(dev);
 }
 
 /*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f977ba79a..e86cf4a3b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5589,7 +5589,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 
 	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
 	    pdev->subsystem_device != 0x222e ||
-	    !pdev->reset_fn)
+	    !pci_reset_supported(pdev))
 		return;
 
 	if (pci_enable_device_mem(pdev))
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index dd12c2fcc..4c54c7505 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -19,7 +19,6 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-		dev->reset_fn = 0;
 
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0955246f8..6e9bc4f9c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -429,7 +429,6 @@ struct pci_dev {
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
-	unsigned int	reset_fn:1;
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
-- 
2.31.1

