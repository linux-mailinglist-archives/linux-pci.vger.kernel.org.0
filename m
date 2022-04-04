Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019A84F1844
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377227AbiDDP1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbiDDP1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 11:27:12 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8602E193EA;
        Mon,  4 Apr 2022 08:25:15 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 3daf4d00b9762f0a; Mon, 4 Apr 2022 17:25:13 +0200
Received: from kreacher.localnet (unknown [213.134.181.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 241B166BCD2;
        Mon,  4 Apr 2022 17:25:13 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 3/3] PCI: ACPI: PM: Power up devices in D3cold before scanning them
Date:   Mon, 04 Apr 2022 17:25:04 +0200
Message-ID: <5729439.MhkbZ0Pkbq@kreacher>
In-Reply-To: <21439956.EfDdHjke4D@kreacher>
References: <21439956.EfDdHjke4D@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.62
X-CLIENT-HOSTNAME: 213.134.181.62
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddriedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddriedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
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

The initial configuration of ACPI power resources on some systems
implies that some PCI devices on them are initially in D3cold.

In some cases, especially for PCIe Root Ports, this is a "logical"
D3cold, meaning that the configuration space of the device is
accessible, but some of its functionality may be missing, but it
very well may be real D3cold, in which case the device will not
be accessible at all.  However, the PCI bus type driver will need
to access its configuration space in order to enumerate it.

To prevent possible device enumeration failures that may ensue as
a result of ACPI power resources being initially in the "off"
state, power up all children of the host bridge ACPI device object
that hold valid _ADR objects (which indicates that they will be
enumerated by the PCI bus type driver) and do that to all children
of the ACPI device objects corresponding to PCI bridges (including
PCIe ports).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c |    2 ++
 drivers/pci/pci-acpi.c  |    3 +++
 2 files changed, 5 insertions(+)

Index: linux-pm/drivers/acpi/pci_root.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_root.c
+++ linux-pm/drivers/acpi/pci_root.c
@@ -927,6 +927,8 @@ struct pci_bus *acpi_pci_root_create(str
 		host_bridge->preserve_config = 1;
 	ACPI_FREE(obj);
 
+	acpi_dev_power_up_children_with_adr(device);
+
 	pci_scan_child_bus(bus);
 	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
 				    info);
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -1374,6 +1374,9 @@ void pci_acpi_setup(struct device *dev,
 
 	acpi_pci_wakeup(pci_dev, false);
 	acpi_device_power_add_dependent(adev, dev);
+
+	if (pci_is_bridge(pci_dev))
+		acpi_dev_power_up_children_with_adr(adev);
 }
 
 void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)



