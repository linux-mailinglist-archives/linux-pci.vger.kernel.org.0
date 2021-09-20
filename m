Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93144126B7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 21:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347843AbhITTVm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 15:21:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44432 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbhITTTl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 15:19:41 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 72b42ea017650ae7; Mon, 20 Sep 2021 21:18:12 +0200
Received: from kreacher.localnet (unknown [213.134.187.25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B0CCD66A65F;
        Mon, 20 Sep 2021 21:18:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 3/7] PCI: PM: Drop struct pci_platform_pm_ops
Date:   Mon, 20 Sep 2021 21:17:16 +0200
Message-ID: <4373094.cEBGB3zze1@kreacher>
In-Reply-To: <1800633.tdWV9SEqCh@kreacher>
References: <1800633.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.25
X-CLIENT-HOSTNAME: 213.134.187.25
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrddvhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgt
 hhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After previous changes there are no more users of struct
pci_platform_pm_ops in the tree, so drop it along with all of the
remaining related code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2.

---
 drivers/pci/pci.c |   11 -----------
 drivers/pci/pci.h |   39 ---------------------------------------
 2 files changed, 50 deletions(-)

Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -63,45 +63,6 @@ struct pci_cap_saved_state *pci_find_sav
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
 
-/**
- * struct pci_platform_pm_ops - Firmware PM callbacks
- *
- * @bridge_d3: Does the bridge allow entering into D3
- *
- * @is_manageable: returns 'true' if given device is power manageable by the
- *		   platform firmware
- *
- * @set_state: invokes the platform firmware to set the device's power state
- *
- * @get_state: queries the platform firmware for a device's current power state
- *
- * @refresh_state: asks the platform to refresh the device's power state data
- *
- * @choose_state: returns PCI power state of given device preferred by the
- *		  platform; to be used during system-wide transitions from a
- *		  sleeping state to the working state and vice versa
- *
- * @set_wakeup: enables/disables wakeup capability for the device
- *
- * @need_resume: returns 'true' if the given device (which is currently
- *		 suspended) needs to be resumed to be configured for system
- *		 wakeup.
- *
- * If given platform is generally capable of power managing PCI devices, all of
- * these callbacks are mandatory.
- */
-struct pci_platform_pm_ops {
-	bool (*bridge_d3)(struct pci_dev *dev);
-	bool (*is_manageable)(struct pci_dev *dev);
-	int (*set_state)(struct pci_dev *dev, pci_power_t state);
-	pci_power_t (*get_state)(struct pci_dev *dev);
-	void (*refresh_state)(struct pci_dev *dev);
-	pci_power_t (*choose_state)(struct pci_dev *dev);
-	int (*set_wakeup)(struct pci_dev *dev, bool enable);
-	bool (*need_resume)(struct pci_dev *dev);
-};
-
-int pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -972,17 +972,6 @@ static void pci_restore_bars(struct pci_
 		pci_update_resource(dev, i);
 }
 
-static const struct pci_platform_pm_ops *pci_platform_pm;
-
-int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
-{
-	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
-	    !ops->choose_state  || !ops->set_wakeup || !ops->need_resume)
-		return -EINVAL;
-	pci_platform_pm = ops;
-	return 0;
-}
-
 static inline bool platform_pci_power_manageable(struct pci_dev *dev)
 {
 	if (pci_use_mid_pm())



