Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CFE42F9E8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 19:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbhJORSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 13:18:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53284 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbhJORSW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 13:18:22 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 2299f938f24327a6; Fri, 15 Oct 2021 19:16:14 +0200
Received: from kreacher.localnet (unknown [213.134.175.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4C3A866A8C0;
        Fri, 15 Oct 2021 19:16:13 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Andreas K. Huettel" <andreas.huettel@ur.de>
Subject: [PATCH v1 1/2] ACPI: PM: Do not turn off power resources in unknown state
Date:   Fri, 15 Oct 2021 19:12:21 +0200
Message-ID: <3625109.kQq0lBPeGt@kreacher>
In-Reply-To: <21226252.EfDdHjke4D@kreacher>
References: <21226252.EfDdHjke4D@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.255
X-CLIENT-HOSTNAME: 213.134.175.255
X-VADE-SPAMSTATE: spam:medium
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeljedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecuufhprghmkfhppghrthculdeftddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddujeehrddvheehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrvdehhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdho
 rhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhgvrghsrdhhuhgvthhtvghlsehurhdruggv
X-DCC--Metrics: v370.home.net.pl 1024; Body=24 Fuz1=24 Fuz2=24
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 6381195ad7d0 ("ACPI: power: Rework turning off unused power
resources") caused power resources in unknown state with reference
counters equal to zero to be turned off too, but that caused issues
to appear in the field, so modify the code to only turn off power
resources that are known to be "on".

Link: https://lore.kernel.org/linux-acpi/6faf4b92-78d5-47a4-63df-cc2bab7769d0@molgen.mpg.de/
Fixes: 6381195ad7d0 ("ACPI: power: Rework turning off unused power resources")
Reported-by: Andreas K. Huettel <andreas.huettel@ur.de>
Tested-by: Andreas K. Huettel <andreas.huettel@ur.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 5.14+ <stable@vger.kernel.org> # 5.14+
---
 drivers/acpi/power.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -1015,13 +1015,8 @@ void acpi_turn_off_unused_power_resource
 	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
 		mutex_lock(&resource->resource_lock);
 
-		/*
-		 * Turn off power resources in an unknown state too, because the
-		 * platform firmware on some system expects the OS to turn off
-		 * power resources without any users unconditionally.
-		 */
 		if (!resource->ref_count &&
-		    resource->state != ACPI_POWER_RESOURCE_STATE_OFF) {
+		    resource->state == ACPI_POWER_RESOURCE_STATE_ON) {
 			acpi_handle_debug(resource->device.handle, "Turning OFF\n");
 			__acpi_power_off(resource);
 		}



