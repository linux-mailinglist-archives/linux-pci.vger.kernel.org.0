Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA08D32F312
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 19:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCESpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 13:45:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49578 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCESok (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 13:44:40 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 40b9a7510e5517b8; Fri, 5 Mar 2021 19:44:37 +0100
Received: from kreacher.localnet (89-64-81-9.dynamic.chello.pl [89.64.81.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 46B4D663EA1;
        Fri,  5 Mar 2021 19:44:36 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v1 2/4] ACPI: utils: Introduce acpi_evaluation_failure_warn()
Date:   Fri, 05 Mar 2021 19:41:44 +0100
Message-ID: <3660317.i3jicEtL8u@kreacher>
In-Reply-To: <2775419.haJ69vZeI0@kreacher>
References: <2775419.haJ69vZeI0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddtiedguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfelheffhfetffelhfelteejffetteetgfetkeejvdfhfeeftdeufeevgeevieevnecukfhppeekledrieegrdekuddrleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhgrrhhssehmvghtrghfohhordguvgdprhgtphhtthhopehpmhgvvghrfiesphhmvggvrhifrdhnvghtpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuggvlhhvrghrvgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqhhifmhhonhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Quite a few users of ACPI objects want to log a warning message if
the evaluation fails which is a repeating pattern, so introduce a
helper function for that purpose and convert some code where it is
open-coded to using it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_link.c             |    6 ++----
 drivers/acpi/processor_perflib.c    |   10 +++-------
 drivers/acpi/processor_throttling.c |   16 ++++------------
 drivers/acpi/utils.c                |   14 ++++++++++++++
 include/linux/acpi.h                |    5 +++++
 5 files changed, 28 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/acpi/utils.c
===================================================================
--- linux-pm.orig/drivers/acpi/utils.c
+++ linux-pm/drivers/acpi/utils.c
@@ -512,6 +512,20 @@ EXPORT_SYMBOL(__acpi_handle_debug);
 #endif
 
 /**
+ * acpi_evaluation_failure_warn - Log evaluation failure warning.
+ * @handle: Parent object handle.
+ * @name: Name of the object whose evaluation has failed.
+ * @status: Status value returned by the failing object evaluation.
+ */
+void acpi_evaluation_failure_warn(acpi_handle handle, const char *name,
+				  acpi_status status)
+{
+	acpi_handle_warn(handle, "%s evaluation failed: %s\n", name,
+			 acpi_format_exception(status));
+}
+EXPORT_SYMBOL_GPL(acpi_evaluation_failure_warn);
+
+/**
  * acpi_has_method: Check whether @handle has a method named @name
  * @handle: ACPI device handle
  * @name: name of object or method
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -1027,9 +1027,14 @@ static inline void acpi_ec_set_gpe_wake_
 __printf(3, 4)
 void acpi_handle_printk(const char *level, acpi_handle handle,
 			const char *fmt, ...);
+void acpi_evaluation_failure_warn(acpi_handle handle, const char *name,
+				  acpi_status status);
 #else	/* !CONFIG_ACPI */
 static inline __printf(3, 4) void
 acpi_handle_printk(const char *level, void *handle, const char *fmt, ...) {}
+static inline void acpi_evaluation_failure_warn(acpi_handle handle,
+						const char *name,
+						acpi_status status) {}
 #endif	/* !CONFIG_ACPI */
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_DYNAMIC_DEBUG)
Index: linux-pm/drivers/acpi/processor_throttling.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_throttling.c
+++ linux-pm/drivers/acpi/processor_throttling.c
@@ -281,9 +281,7 @@ static int acpi_processor_get_platform_l
 	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND)
-			acpi_handle_warn(pr->handle,
-					 "_TPC evaluation failed: %s\n",
-					 acpi_format_exception(status));
+			acpi_evaluation_failure_warn(pr->handle, "_TPC", status);
 
 		return -ENODEV;
 	}
@@ -416,9 +414,7 @@ static int acpi_processor_get_throttling
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND)
-			acpi_handle_warn(pr->handle,
-					 "_PTC evaluation failed: %s\n",
-					 acpi_format_exception(status));
+			acpi_evaluation_failure_warn(pr->handle, "_PTC", status);
 
 		return -ENODEV;
 	}
@@ -503,9 +499,7 @@ static int acpi_processor_get_throttling
 	status = acpi_evaluate_object(pr->handle, "_TSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND)
-			acpi_handle_warn(pr->handle,
-					 "_TSS evaluation failed: %s\n",
-					 acpi_format_exception(status));
+			acpi_evaluation_failure_warn(pr->handle, "_TSS", status);
 
 		return -ENODEV;
 	}
@@ -586,9 +580,7 @@ static int acpi_processor_get_tsd(struct
 	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND)
-			acpi_handle_warn(pr->handle,
-					 "_TSD evaluation failed: %s\n",
-					 acpi_format_exception(status));
+			acpi_evaluation_failure_warn(pr->handle, "_TSD", status);
 
 		return -ENODEV;
 	}
Index: linux-pm/drivers/acpi/pci_link.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_link.c
+++ linux-pm/drivers/acpi/pci_link.c
@@ -256,8 +256,7 @@ static int acpi_pci_link_get_current(str
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
 				     acpi_pci_link_check_current, &irq);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_warn(handle, "_CRS evaluation failed: %s\n",
-				 acpi_format_exception(status));
+		acpi_evaluation_failure_warn(handle, "_CRS", status);
 		result = -ENODEV;
 		goto end;
 	}
@@ -345,8 +344,7 @@ static int acpi_pci_link_set(struct acpi
 
 	/* check for total failure */
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_warn(handle, "_SRS evaluation failed: %s",
-				 acpi_format_exception(status));
+		acpi_evaluation_failure_warn(handle, "_SRS", status);
 		result = -ENODEV;
 		goto end;
 	}
Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -67,9 +67,7 @@ static int acpi_processor_get_platform_l
 		acpi_processor_ppc_in_use = true;
 
 		if (ACPI_FAILURE(status)) {
-			acpi_handle_warn(pr->handle,
-					 "_PPC evaluation failed: %s\n",
-					 acpi_format_exception(status));
+			acpi_evaluation_failure_warn(pr->handle, "_PPC", status);
 			return -ENODEV;
 		}
 	}
@@ -199,8 +197,7 @@ static int acpi_processor_get_performanc
 
 	status = acpi_evaluate_object(pr->handle, "_PCT", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_warn(pr->handle, "_PCT evaluation failed: %s\n",
-				 acpi_format_exception(status));
+		acpi_evaluation_failure_warn(pr->handle, "_PCT", status);
 		return -ENODEV;
 	}
 
@@ -300,8 +297,7 @@ static int acpi_processor_get_performanc
 
 	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_warn(pr->handle, "_PSS evaluation failed: %s\n",
-				 acpi_format_exception(status));
+		acpi_evaluation_failure_warn(pr->handle, "_PSS", status);
 		return -ENODEV;
 	}
 



