Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655F441EEFC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 15:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhJAN75 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 09:59:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50168 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhJAN75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 09:59:57 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id b330d1a140d17332; Fri, 1 Oct 2021 15:58:11 +0200
Received: from kreacher.localnet (unknown [213.134.175.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BFC5E66A79A;
        Fri,  1 Oct 2021 15:58:10 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH] PCI: ACPI: Check parent pointer in acpi_pci_find_companion()
Date:   Fri, 01 Oct 2021 15:58:10 +0200
Message-ID: <5523582.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.164
X-CLIENT-HOSTNAME: 213.134.175.164
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudekiedgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvvefgteeuteehkeduuedvudetleevffdtffdtjeejueekffetieekgfeigfehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddujeehrdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudeigedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
 tghpthhtohepshgthhhnvghllhgvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepjhgvshhsvgdrsghrrghnuggvsghurhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshguohhnthhhihhnvghnihesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghlvgigrdifihhllhhirghmshhonhesrhgvughhrghtrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If acpi_pci_find_companion() is called for a device whose parent
pointer is NULL, it will crash when attempting to get the ACPI
companion of the parent due to a NULL pointer dereference in
the ACPI_COMPANION() macro.

This was not a problem before commit 375553a93201 ("PCI: Setup ACPI
fwnode early and at the same time with OF") that made pci_setup_device()
call pci_set_acpi_fwnode() and so it allowed devices with NULL parent
pointers to be passed to acpi_pci_find_companion() which is the case
in pci_iov_add_virtfn(), for instance.

Fix this issue by making acpi_pci_find_companion() check the device's
parent pointer upfront and bail out if it is NULL.

While pci_iov_add_virtfn() can be changed to set the device's parent
pointer before calling pci_setup_device() for it, checking pointers
against NULL before dereferencing them is prudent anyway and looking
for ACPI companions of virtual functions isn't really useful.

Fixes: 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time with OF")
Link: https://lore.kernel.org/linux-acpi/8e4bbd5c59de31db71f718556654c0aa077df03d.camel@linux.ibm.com/
Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -1243,6 +1243,9 @@ static struct acpi_device *acpi_pci_find
 	bool check_children;
 	u64 addr;
 
+	if (!dev->parent)
+		return NULL;
+
 	down_read(&pci_acpi_companion_lookup_sem);
 
 	adev = pci_acpi_find_companion_hook ?



