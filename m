Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCAA632BE9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 19:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKUSS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 13:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiKUSS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 13:18:26 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC42C696D;
        Mon, 21 Nov 2022 10:18:24 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 8a177fe1352f71fd; Mon, 21 Nov 2022 19:18:21 +0100
Received: from kreacher.localnet (unknown [213.134.163.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A6EF8780F76;
        Mon, 21 Nov 2022 19:18:20 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/2] PCI/portdrv: Set PCIE_PORT_SERVICE_HP for Root and Downstream Ports only
Date:   Mon, 21 Nov 2022 19:15:18 +0100
Message-ID: <4786090.31r3eYUQgx@kreacher>
In-Reply-To: <5623410.DvuYhMxLoT@kreacher>
References: <5623410.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.140
X-CLIENT-HOSTNAME: 213.134.163.140
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrheeigdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduieefrddugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeifedrudegtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgurhhighhordhvihhvihesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehv
 ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that on some systems pciehp binds to an Upstream Port and
attempts to operate it which causes devices below the Port to disappear
from the bus.

This happens because acpiphp sets is_hotplug_bridge for that Port (after
receiving a Device Check notification on it from the platform firmware
via ACPI) during the enumeration of PCI devices and so when
get_port_device_capability() runs, it sees that is_hotplug_bridge is
set and adds PCIE_PORT_SERVICE_HP to Port services (which allows pciehp
to bind to the Port in question) without consulting the PCIe type which
should be either Root Port or Downstream Port for the hotplug capability
to be present.

Make get_port_device_capability() more robust by adding a PCIe type
check to it before adding PCIE_PORT_SERVICE_HP to Port services which
helps to avoid the problem.

Reported-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/portdrv_core.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-pm/drivers/pci/pcie/portdrv_core.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-pm/drivers/pci/pcie/portdrv_core.c
@@ -209,6 +209,8 @@ static int get_port_device_capability(st
 	int services = 0;
 
 	if (dev->is_hotplug_bridge &&
+	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
 	    (pcie_ports_native || host->native_pcie_hotplug)) {
 		services |= PCIE_PORT_SERVICE_HP;
 



