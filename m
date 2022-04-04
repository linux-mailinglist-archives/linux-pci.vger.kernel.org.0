Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782824F184B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378552AbiDDP1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378542AbiDDP1N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 11:27:13 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF71AF36;
        Mon,  4 Apr 2022 08:25:17 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id fbcc135d1d992d03; Mon, 4 Apr 2022 17:25:15 +0200
Received: from kreacher.localnet (unknown [213.134.181.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C6F8066BCD2;
        Mon,  4 Apr 2022 17:25:14 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 2/3] ACPI: PM: Introduce acpi_dev_power_up_children_with_adr()
Date:   Mon, 04 Apr 2022 17:23:13 +0200
Message-ID: <8937237.CDJkKcVGEf@kreacher>
In-Reply-To: <21439956.EfDdHjke4D@kreacher>
References: <21439956.EfDdHjke4D@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.62
X-CLIENT-HOSTNAME: 213.134.181.62
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddriedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddriedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
 phhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a function powering up all of the children of a given ACPI
device object that are power-manageable and hold valid _ADR ACPI
objects so as to make it possible to prepare the corresponding
"physical" devices for enumeration carried out by a bus type driver,
like PCI.

This function will be used in a subsequent change set.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   30 ++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h  |    1 +
 2 files changed, 31 insertions(+)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -427,6 +427,36 @@ bool acpi_bus_power_manageable(acpi_hand
 }
 EXPORT_SYMBOL(acpi_bus_power_manageable);
 
+static int acpi_power_up_if_adr_present(struct device *dev, void *not_used)
+{
+	struct acpi_device *adev;
+
+	adev = to_acpi_device(dev);
+	if (!(adev->flags.power_manageable && adev->pnp.type.bus_address))
+		return 0;
+
+	acpi_handle_debug(adev->handle, "Power state: %s\n",
+			  acpi_power_state_string(adev->power.state));
+
+	if (adev->power.state == ACPI_STATE_D3_COLD)
+		return acpi_device_set_power(adev, ACPI_STATE_D0);
+
+	return 0;
+}
+
+/**
+ * acpi_dev_power_up_children_with_adr - Power up childres with valid _ADR
+ * @adev: Parent ACPI device object.
+ *
+ * Change the power states of the direct children of @adev that are in D3cold
+ * and hold valid _ADR objects to D0 in order to allow bus (e.g. PCI)
+ * enumeration code to access them.
+ */
+void acpi_dev_power_up_children_with_adr(struct acpi_device *adev)
+{
+	acpi_dev_for_each_child(adev, acpi_power_up_if_adr_present, NULL);
+}
+
 #ifdef CONFIG_PM
 static DEFINE_MUTEX(acpi_pm_notifier_lock);
 static DEFINE_MUTEX(acpi_pm_notifier_install_lock);
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -525,6 +525,7 @@ int acpi_device_fix_up_power(struct acpi
 int acpi_bus_update_power(acpi_handle handle, int *state_p);
 int acpi_device_update_power(struct acpi_device *device, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
+void acpi_dev_power_up_children_with_adr(struct acpi_device *adev);
 int acpi_device_power_add_dependent(struct acpi_device *adev,
 				    struct device *dev);
 void acpi_device_power_remove_dependent(struct acpi_device *adev,



