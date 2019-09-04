Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3082EA7A5E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 06:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfIDEqG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 00:46:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40187 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfIDEqG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 00:46:06 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so25937390iof.7;
        Tue, 03 Sep 2019 21:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Q0avX4v2vZHpCIqwUim8D3UELtW0tXv6ck8jZrMQ9g=;
        b=UQofwZGdSbbp9D4Vn8mM/TXj7JzhgJu6UD2+8jlgtEG+1q/LshBpptDfD9q+DV3NIU
         VECKOzdL4J1oPebv7mckE97BZArfZGDqExqHcpg0zcKH0lwt+8Es9YerMFTOkPLaXWxr
         KD37067s+CG5At2sfoNCnbXQYgC/zddalIE9wAzzv1U/+6nxvaNyKhBBvgItMK9/uVrv
         2OR0F96nFugu9ShDfaj/6pXGKISFdnkWqXq9/dFPzQ6mrZojiCR7Ol+jaKjB0oYINNnH
         OBT/39wNNylbvMrkMuadC95nZlTKhPh90N1Um//mwyy09s1kPtaIc+9qqOFPdTPBgQJS
         /nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Q0avX4v2vZHpCIqwUim8D3UELtW0tXv6ck8jZrMQ9g=;
        b=PfKBUSLkxl63L3UVvsZBdgUY5xvYMHQqMfkkkRpE1x6r/oG+QERxlkltXnoJTdB0mL
         ze5kAVl1va8nniEU5C3oYZgLMTjtGTp7uzwGO3Ek5kmED8i9WMTXxq7KkZGm5IicYiir
         TK26MRVWnsSIs06ptM4hpUoMS7ACJqcaaa0X16elawujS+U6rXFvZj3rHFfIaWFsNxh5
         EZjlxoBZmO0ZhOCkN9MG9MzZgqrPyaCEId9tOyHzdTTCPUEx7mJ5d1SmWw7OneWSkDT8
         VKg8k5lGoC01cXFL88slzN5LXcq18eVge+VUotCFHadN259D/jsRhfPFom0MDkEamX9s
         dlEQ==
X-Gm-Message-State: APjAAAU0033bXg1pF4+2GoCkeyM3DtyyDU65iHwVCPJV6kw+44dNWCm4
        eRSgzoiQMWzChpFkc3sw7tdwF4wV1go=
X-Google-Smtp-Source: APXvYqzLvKmh5ygpyY4Z8KrJ6zu2m746saM2ITViaGtJKjI9hvum8T7mBqEhMnYVtbMUWyIfqVS+sQ==
X-Received: by 2002:a02:3b21:: with SMTP id c33mr8136400jaa.54.1567571992209;
        Tue, 03 Sep 2019 21:39:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s5sm16471411iol.88.2019.09.03.21.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 21:39:51 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Cc:     skhan@linuxfoundation.org, rafael.j.wysocki@intel.com,
        keith.busch@intel.com
Subject: [PATCH 1/2] PCI: Change pci_device_is_present() to pci_dev_is_inaccessible()
Date:   Tue,  3 Sep 2019 22:36:34 -0600
Message-Id: <20190904043633.65026-2-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904043633.65026-1-skunberg.kelsey@gmail.com>
References: <20190904043633.65026-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_device_is_present() name may encourage poor practice of calling
pci_device_is_present() and if true, assuming the device is still present
after the call. This type of practice can be racy when assuming a device
is still connected after checking.

Change pci_device_is_present() to pci_dev_is_inaccessible() to promote
only using to learn whether we should avoid accessing a device that's
inaccessible.

Change pci_device_is_inaccessible() to now return true if PCI device is
inaccessible.

Change the boolean values returned from calling pci_dev_is_inaccessible()
to their opposite value to reflect the change of checking if the device is
present to checking if the device is inaccessible. Example:
	Before:
		if (!pci_device_is_present(tp->pdev))
			return -ENODEV;
	After:
		if (pci_dev_is_inaccessible(tp->pdev))
                	return -ENODEV;

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c       |  4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c |  2 +-
 drivers/nvme/host/pci.c                   |  2 +-
 drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
 drivers/pci/pci.c                         | 10 +++++-----
 drivers/thunderbolt/nhi.c                 |  2 +-
 include/linux/pci.h                       |  2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 4c404d2213f9..7646a8303d01 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -9067,7 +9067,7 @@ static int tg3_chip_reset(struct tg3 *tp)
 	void (*write_op)(struct tg3 *, u32, u32);
 	int i, err;
 
-	if (!pci_device_is_present(tp->pdev))
+	if (pci_dev_is_inaccessible(tp->pdev))
 		return -ENODEV;
 
 	tg3_nvram_lock(tp);
@@ -11782,7 +11782,7 @@ static int tg3_close(struct net_device *dev)
 
 	tg3_stop(tp);
 
-	if (pci_device_is_present(tp->pdev)) {
+	if (!pci_dev_is_inaccessible(tp->pdev)) {
 		tg3_power_down_prepare(tp);
 
 		tg3_carrier_off(tp);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b4df3e319467..87bc067c2abc 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8835,7 +8835,7 @@ static int __maybe_unused igb_resume(struct device *dev)
 	pci_restore_state(pdev);
 	pci_save_state(pdev);
 
-	if (!pci_device_is_present(pdev))
+	if (pci_dev_is_inaccessible(pdev))
 		return -ENODEV;
 	err = pci_enable_device_mem(pdev);
 	if (err) {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb970ca82517..2a4500325471 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2812,7 +2812,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	pci_set_drvdata(pdev, NULL);
 
-	if (!pci_device_is_present(pdev)) {
+	if (pci_dev_is_inaccessible(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 		nvme_dev_disable(dev, true);
 		nvme_dev_remove_admin(dev);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index e4c46637f32f..9cc2d65877bd 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -647,7 +647,7 @@ static void trim_stale_devices(struct pci_dev *dev)
 		alive = alive || (ACPI_SUCCESS(status) && device_status_valid(sta));
 	}
 	if (!alive)
-		alive = pci_device_is_present(dev);
+		alive = !pci_dev_is_inaccessible(dev);
 
 	if (!alive) {
 		pci_dev_set_disconnected(dev, NULL);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ed5ec1ac27..7b4e248db5f9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -931,7 +931,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
 {
 	if (platform_pci_get_power_state(dev) == PCI_D3cold ||
-	    !pci_device_is_present(dev)) {
+	    pci_dev_is_inaccessible(dev)) {
 		dev->current_state = PCI_D3cold;
 	} else if (dev->pm_cap) {
 		u16 pmcsr;
@@ -5906,15 +5906,15 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
 		test_bit(dev1->devfn, dev2->dma_alias_mask));
 }
 
-bool pci_device_is_present(struct pci_dev *pdev)
+bool pci_dev_is_inaccessible(struct pci_dev *pdev)
 {
 	u32 v;
 
 	if (pci_dev_is_disconnected(pdev))
-		return false;
-	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
+		return true;
+	return !pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
 }
-EXPORT_SYMBOL_GPL(pci_device_is_present);
+EXPORT_SYMBOL_GPL(pci_dev_is_inaccessible);
 
 void pci_ignore_hotplug(struct pci_dev *dev)
 {
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 27fbe62c7ddd..597c7579d882 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -879,7 +879,7 @@ static int nhi_resume_noirq(struct device *dev)
 	 * unplugged last device which causes the host controller to go
 	 * away on PCs.
 	 */
-	if (!pci_device_is_present(pdev))
+	if (pci_dev_is_inaccessible(pdev))
 		tb->nhi->going_away = true;
 	else
 		nhi_enable_int_throttling(tb->nhi);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e700d9f9f28..e599068537cf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1202,7 +1202,7 @@ int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size
 void pci_release_resource(struct pci_dev *dev, int resno);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
-bool pci_device_is_present(struct pci_dev *pdev);
+bool pci_dev_is_inaccessible(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
 
 int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
-- 
2.20.1

