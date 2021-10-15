Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2F42F9E1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhJORQ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 13:16:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60030 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbhJORQz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 13:16:55 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 615faa74ca6a96bd; Fri, 15 Oct 2021 19:14:48 +0200
Received: from kreacher.localnet (unknown [213.134.175.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2DAE666A8C0;
        Fri, 15 Oct 2021 19:14:47 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        "Andreas K. Huettel" <andreas.huettel@ur.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 2/2][RFT] ACPI: PM: Check states of power resources during initialization
Date:   Fri, 15 Oct 2021 19:14:10 +0200
Message-ID: <8835496.CDJkKcVGEf@kreacher>
In-Reply-To: <21226252.EfDdHjke4D@kreacher>
References: <21226252.EfDdHjke4D@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.255
X-CLIENT-HOSTNAME: 213.134.175.255
X-VADE-SPAMSTATE: spam:medium
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeljedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucfuphgrmhfkphgprhhtucdlfedttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddujeehrddvheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrvdehhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvrghsrdhhuhgvthhtvghlsehurhdruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhg
 vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To avoid situations in which the actual states of certain ACPI power
resources are not known just because they have never been referenced
by any device configuration objects, check the initial states of all
power resources as soon as they are found in the ACPI namespace (and
fall back to turning them on if the state check fails).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Andreas, please test this patch (on top of the [1/2]) and let me know
if it works for you.

Thanks!

---
 drivers/acpi/power.c |   30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -923,6 +919,7 @@ struct acpi_device *acpi_add_power_resou
 	union acpi_object acpi_object;
 	struct acpi_buffer buffer = { sizeof(acpi_object), &acpi_object };
 	acpi_status status;
+	u8 state_dummy;
 	int result;
 
 	acpi_bus_get_device(handle, &device);
@@ -951,6 +948,10 @@ struct acpi_device *acpi_add_power_resou
 	resource->order = acpi_object.power_resource.resource_order;
 	resource->state = ACPI_POWER_RESOURCE_STATE_UNKNOWN;
 
+	/* Get the initial state or just flip it on if that fails. */
+	if (acpi_power_get_state(resource, &state_dummy))
+		__acpi_power_on(resource);
+
 	pr_info("%s [%s]\n", acpi_device_name(device), acpi_device_bid(device));
 
 	device->flags.match_driver = true;



