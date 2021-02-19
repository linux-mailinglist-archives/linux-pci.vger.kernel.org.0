Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A664231FEBE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 19:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBSSZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 13:25:39 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48032 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBSSZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Feb 2021 13:25:37 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 26afb1c30fe441b8; Fri, 19 Feb 2021 19:18:15 +0100
Received: from kreacher.localnet (89-64-81-29.dynamic.chello.pl [89.64.81.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2B311661E07;
        Fri, 19 Feb 2021 19:18:14 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v1 3/4] ACPI: PCI: Drop ACPI_PCI_COMPONENT that is not used any more
Date:   Fri, 19 Feb 2021 19:16:54 +0100
Message-ID: <4837180.Z1r8MVlPr0@kreacher>
In-Reply-To: <4822757.tvZ08WQ2Gl@kreacher>
References: <4822757.tvZ08WQ2Gl@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgleehfffhtefflefhleetjeffteettefgteekjedvhfeffedtueefveegveeiveenucfkphepkeelrdeigedrkedurddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrvdelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehguhhohhgrnhhjuhhnsehhuhgrfigvihdrtgho
 mh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After dropping all of the code using ACPI_PCI_COMPONENT drop the
definition of it too and update the documentation to remove all
ACPI_PCI_COMPONENT references from it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    4 +---
 Documentation/firmware-guide/acpi/debug.rst     |    5 -----
 drivers/acpi/sysfs.c                            |    1 -
 include/acpi/acpi_drivers.h                     |    1 -
 4 files changed, 1 insertion(+), 10 deletions(-)

Index: linux-pm/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-pm/Documentation/admin-guide/kernel-parameters.txt
@@ -50,7 +50,7 @@
 			CONFIG_ACPI_DEBUG must be enabled to produce any ACPI
 			debug output.  Bits in debug_layer correspond to a
 			_COMPONENT in an ACPI source file, e.g.,
-			    #define _COMPONENT ACPI_PCI_COMPONENT
+			    #define _COMPONENT ACPI_EVENTS
 			Bits in debug_level correspond to a level in
 			ACPI_DEBUG_PRINT statements, e.g.,
 			    ACPI_DEBUG_PRINT((ACPI_DB_INFO, ...
@@ -60,8 +60,6 @@
 
 			Enable processor driver info messages:
 			    acpi.debug_layer=0x20000000
-			Enable PCI/PCI interrupt routing info messages:
-			    acpi.debug_layer=0x400000
 			Enable AML "Debug" output, i.e., stores to the Debug
 			object while interpreting AML:
 			    acpi.debug_layer=0xffffffff acpi.debug_level=0x2
Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -54,7 +54,6 @@ shows the supported mask values, current
     ACPI_TOOLS                      0x00002000
     ACPI_SBS_COMPONENT              0x00100000
     ACPI_FAN_COMPONENT              0x00200000
-    ACPI_PCI_COMPONENT              0x00400000
     ACPI_CONTAINER_COMPONENT        0x01000000
     ACPI_SYSTEM_COMPONENT           0x02000000
     ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
@@ -127,10 +126,6 @@ AML) during boot::
 
     acpi.debug_layer=0xffffffff acpi.debug_level=0x2
 
-Enable PCI and PCI interrupt routing debug messages::
-
-    acpi.debug_layer=0x400000 acpi.debug_level=0x4
-
 Enable all ACPI hardware-related messages::
 
     acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -54,7 +54,6 @@ static const struct acpi_dlayer acpi_deb
 
 	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_PCI_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -17,7 +17,6 @@
  */
 #define ACPI_SBS_COMPONENT		0x00100000
 #define ACPI_FAN_COMPONENT		0x00200000
-#define ACPI_PCI_COMPONENT		0x00400000
 #define ACPI_CONTAINER_COMPONENT	0x01000000
 #define ACPI_SYSTEM_COMPONENT		0x02000000
 #define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000



