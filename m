Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7892A2C1EF8
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 08:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgKXHgc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 02:36:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44117 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgKXHgb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 02:36:31 -0500
Received: from 1.general.khfeng.uk.vpn ([10.172.196.174] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1khSsC-0005hv-8e; Tue, 24 Nov 2020 07:36:25 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com
Cc:     andy.shevchenko@gmail.com, mika.westerberg@linux.intel.com,
        hdegoede@redhat.com, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI: PM: Re-enable ACPI GPE if it's already enabled
Date:   Tue, 24 Nov 2020 15:36:19 +0800
Message-Id: <20201124073619.771940-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dell Precision 5550 fails to detect Thunderbolt device hotplug events,
once the Thunderbolt device and its root port are runtime-suspended to
D3cold.

While putting the entire hierarchy to D3cold, the root port ACPI GPE is
enabled via acpi_pci_propagate_wakeup() when suspending Thunderbolt
bridges/switches. So when putting the root port to D3cold as last step,
ACPI GPE is untouched as it's already enabled.

However, platform may need PCI devices to be in D3hot or PME enabled
prior enabling GPE to make it work. So re-enable ACPI GPE to address
this.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/device_pm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 94d91c67aeae..dc25d9d204ae 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -757,11 +757,10 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
 
 	mutex_lock(&acpi_wakeup_lock);
 
-	if (wakeup->enable_count >= max_count)
-		goto out;
-
-	if (wakeup->enable_count > 0)
-		goto inc;
+	if (wakeup->enable_count > 0) {
+		acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
+		acpi_disable_wakeup_device_power(adev);
+	}
 
 	error = acpi_enable_wakeup_device_power(adev, target_state);
 	if (error)
@@ -777,8 +776,8 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
 	acpi_handle_debug(adev->handle, "GPE%2X enabled for wakeup\n",
 			  (unsigned int)wakeup->gpe_number);
 
-inc:
-	wakeup->enable_count++;
+	if (wakeup->enable_count < max_count)
+		wakeup->enable_count++;
 
 out:
 	mutex_unlock(&acpi_wakeup_lock);
-- 
2.29.2

