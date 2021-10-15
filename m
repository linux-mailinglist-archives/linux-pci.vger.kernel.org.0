Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E4842F99D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbhJORHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 13:07:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54332 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbhJORG5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 13:06:57 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id b0d89b5bf84f41b0; Fri, 15 Oct 2021 19:04:49 +0200
Received: from kreacher.localnet (unknown [213.134.175.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CA68A66A8C0;
        Fri, 15 Oct 2021 19:04:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v1 1/3] ACPI: PM: Turn off unused wakeup power resources
Date:   Fri, 15 Oct 2021 19:01:28 +0200
Message-ID: <4657519.GXAFRqVoOG@kreacher>
In-Reply-To: <4347933.LvFx2qVVIh@kreacher>
References: <4347933.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.255
X-CLIENT-HOSTNAME: 213.134.175.255
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddujeehrddvheehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrvdehhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthht
 oheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If an ACPI power resource is found to be "on" during the
initialization of the list of wakeup power resources of a device,
it is reference counted and its wakeup_enabled flag is set, which is
problematic if the deivce in question is the only user of the given
power resource, it is never runtime-suspended and it is not allowed
to wake up the system from sleep, because in that case the given
power resource will stay "on" until the system reboots and energy
will be wasted.

It is better to simply turn off wakeup power resources that are "on"
during the initialization unless their reference counters are not
zero, because that may be the only opportunity to prevent them from
staying in the "on" state all the time.

Fixes: b5d667eb392e ("ACPI / PM: Take unusual configurations of power resources into account")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -615,20 +615,19 @@ int acpi_power_wakeup_list_init(struct l
 
 	list_for_each_entry(entry, list, node) {
 		struct acpi_power_resource *resource = entry->resource;
-		int result;
 		u8 state;
 
 		mutex_lock(&resource->resource_lock);
 
-		result = acpi_power_get_state(resource, &state);
-		if (result) {
-			mutex_unlock(&resource->resource_lock);
-			return result;
-		}
-		if (state == ACPI_POWER_RESOURCE_STATE_ON) {
-			resource->ref_count++;
-			resource->wakeup_enabled = true;
-		}
+		/*
+		 * Make sure that the power resource state and its reference
+		 * counter value are consistent with each other.
+		 */
+		if (!resource->ref_count &&
+		    !acpi_power_get_state(resource, &state) &&
+		    state == ACPI_POWER_RESOURCE_STATE_ON)
+			__acpi_power_off(resource);
+
 		if (system_level > resource->system_level)
 			system_level = resource->system_level;
 



