Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8CC2C3144
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 20:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgKXTqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 14:46:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51424 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgKXTqw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 14:46:52 -0500
Received: from 89-64-86-188.dynamic.chello.pl (89.64.86.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 4da66d67e8e81342; Tue, 24 Nov 2020 20:46:48 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 2/2] PM: ACPI: Refresh wakeup device power configuration every time
Date:   Tue, 24 Nov 2020 20:46:38 +0100
Message-ID: <1717218.WU8ttdIIEu@kreacher>
In-Reply-To: <27714988.CF3CpBaniU@kreacher>
References: <27714988.CF3CpBaniU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When wakeup signaling is enabled for a bridge for the second (or every
next) time in a row, its existing device wakeup power configuration
may not match the new conditions.  For example, some devices below
it may have been put into low-power states and that changes the
device wakeup power conditions or similar.  This causes functional
problems to appear on some systems (for example,  because of it the
Thunderbolt port on Dell Precision 5550 cannot detect devices plugged
in after it has been suspended).

For this reason, modify __acpi_device_wakeup_enable() to refresh the
device wakeup power configuration of the target device on every
invocation, not just when it is called for that device first time
in a row.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/device_pm.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -757,16 +757,26 @@ static int __acpi_device_wakeup_enable(s
 
 	mutex_lock(&acpi_wakeup_lock);
 
-	if (wakeup->enable_count >= INT_MAX) {
-		acpi_handle_info(adev->handle, "Wakeup enable count out of bounds!\n");
-		goto out;
-	}
+	/*
+	 * If the device wakeup power is already enabled, disable it and enable
+	 * it again in case it depends on the configuration of subordinate
+	 * devices and the conditions have changed since it was enabled last
+	 * time.
+	 */
 	if (wakeup->enable_count > 0)
-		goto inc;
+		acpi_disable_wakeup_device_power(adev);
 
 	error = acpi_enable_wakeup_device_power(adev, target_state);
-	if (error)
+	if (error) {
+		if (wakeup->enable_count > 0) {
+			acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
+			wakeup->enable_count = 0;
+		}
 		goto out;
+	}
+
+	if (wakeup->enable_count > 0)
+		goto inc;
 
 	status = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
 	if (ACPI_FAILURE(status)) {
@@ -779,7 +789,10 @@ static int __acpi_device_wakeup_enable(s
 			  (unsigned int)wakeup->gpe_number);
 
 inc:
-	wakeup->enable_count++;
+	if (wakeup->enable_count < INT_MAX)
+		wakeup->enable_count++;
+	else
+		acpi_handle_info(adev->handle, "Wakeup enable count out of bounds!\n");
 
 out:
 	mutex_unlock(&acpi_wakeup_lock);



