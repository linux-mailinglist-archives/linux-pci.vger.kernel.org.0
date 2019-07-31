Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342857D1EB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2019 01:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfGaXbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 19:31:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48065 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbfGaXbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2019 19:31:11 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 962226490afa9733; Thu, 1 Aug 2019 01:31:08 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ACPI: PM: Fix regression in acpi_device_set_power()
Date:   Thu, 01 Aug 2019 01:31:08 +0200
Message-ID: <4199592.UtrPOv3ZmA@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in
special cases") overlooked the fact that acpi_power_transition() may
change the power.state value for the target device and if that
happens, it may confuse acpi_device_set_power() and cause it to
omit the _PS0 evaluation which on some systems is necessary to
change power states of devices from low-power to D0.

Fix that by saving the current value of power.state for the
target device before passing it to acpi_power_transition() and
using the saved value in a subsequent check.

Fixes: f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in special cases")
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -236,13 +236,15 @@ int acpi_device_set_power(struct acpi_de
 		if (device->power.flags.power_resources)
 			result = acpi_power_transition(device, target_state);
 	} else {
+		int cur_state = device->power.state;
+
 		if (device->power.flags.power_resources) {
 			result = acpi_power_transition(device, ACPI_STATE_D0);
 			if (result)
 				goto end;
 		}
 
-		if (device->power.state == ACPI_STATE_D0) {
+		if (cur_state == ACPI_STATE_D0) {
 			int psc;
 
 			/* Nothing to do here if _PSC is not present. */



