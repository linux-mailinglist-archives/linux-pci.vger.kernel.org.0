Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCF2DCA3F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 02:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgLQA6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 19:58:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:12153 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgLQA6e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Dec 2020 19:58:34 -0500
IronPort-SDR: /OzDceenrnNtOiICfHSdMKrzmsnQBRUxwG7ITYY7qsb+vFCuBnRPj015EDWx9535QfACFA5Z38
 +jdrwSLVHhEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="154393534"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="154393534"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 16:57:40 -0800
IronPort-SDR: AhDE9XYQhnnC3NL1/cGNoRc5wSVVP9weN0rLDr0EItCO19jjp451Si8bcR5nwBYacOOPEaYm2B
 2gpTHFxcZEZA==
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="385113859"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.4])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 16:57:40 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] msi: use for_each_msi_entry_safe iterator macro
Date:   Wed, 16 Dec 2020 16:55:57 -0800
Message-Id: <20201217005557.45031-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 81b1e6e6a859 ("platform-msi: Free descriptors in
platform_msi_domain_free()") introduced for_each_msi_entry_safe as an
iterator operating on the msi_list using the safe semantics with
a temporary variable.

A handful of locations still used the generic iterator instead of the
specific macro. Fix the 3 remaining cases. Add a cocci script which can
detect and report any misuse that is introduced in future changes.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
I noticed that a couple places used the generic _safe iterator. They appear
to be code which was written before the commit that introduced the new
MSI-specific iterator.

 drivers/base/platform-msi.c                   |   2 +-
 drivers/bus/fsl-mc/fsl-mc-msi.c               |   2 +-
 drivers/soc/ti/ti_sci_inta_msi.c              |   2 +-
 .../iterators/for_each_msi_entry.cocci        | 101 ++++++++++++++++++
 4 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100644 scripts/coccinelle/iterators/for_each_msi_entry.cocci

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index c4a17e5edf8b..1fd8ac26c245 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -110,7 +110,7 @@ static void platform_msi_free_descs(struct device *dev, int base, int nvec)
 {
 	struct msi_desc *desc, *tmp;
 
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
+	for_each_msi_entry_safe(desc, tmp, dev) {
 		if (desc->platform.msi_index >= base &&
 		    desc->platform.msi_index < (base + nvec)) {
 			list_del(&desc->list);
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 8edadf05cbb7..d0a52ccfa738 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -214,7 +214,7 @@ static void fsl_mc_msi_free_descs(struct device *dev)
 {
 	struct msi_desc *desc, *tmp;
 
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
+	for_each_msi_entry_safe(desc, tmp, dev) {
 		list_del(&desc->list);
 		free_msi_entry(desc);
 	}
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index 0eb9462f609e..66f9772dcdfa 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -64,7 +64,7 @@ static void ti_sci_inta_msi_free_descs(struct device *dev)
 {
 	struct msi_desc *desc, *tmp;
 
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
+	for_each_msi_entry_safe(desc, tmp, dev) {
 		list_del(&desc->list);
 		free_msi_entry(desc);
 	}
diff --git a/scripts/coccinelle/iterators/for_each_msi_entry.cocci b/scripts/coccinelle/iterators/for_each_msi_entry.cocci
new file mode 100644
index 000000000000..45282f93ab6f
--- /dev/null
+++ b/scripts/coccinelle/iterators/for_each_msi_entry.cocci
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use for_each_msi_entry(_safe) instead of generic iterator
+///
+// Confidence: High
+// Copyright: (C) 2020 Jacob Keller, Intel Corporation.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+@depends on context@
+identifier member =~ "list";
+struct msi_desc *desc;
+struct msi_desc *tmp;
+struct device *dev;
+iterator name list_for_each_entry_safe;
+iterator name list_for_each_entry;
+statement S;
+@@
+(
+* list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), member)
+S
+|
+* list_for_each_entry(desc, dev_to_msi_list(dev), member)
+S
+)
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+@depends on patch@
+identifier member =~ "list";
+struct msi_desc *desc;
+struct msi_desc *tmp;
+struct device *dev;
+iterator name list_for_each_entry_safe;
+iterator name for_each_msi_entry_safe;
+iterator name list_for_each_entry;
+iterator name for_each_msi_entry;
+statement S;
+@@
+(
+- list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), member)
++ for_each_msi_entry_safe(desc, tmp, dev)
+S
+|
+- list_for_each_entry(desc, dev_to_msi_list(dev), member)
++ for_each_msi_entry(desc, dev)
+S
+)
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+@r depends on (org || report )@
+identifier member =~ "list";
+struct msi_desc *desc;
+struct msi_desc *tmp;
+struct device *dev;
+iterator name list_for_each_entry_safe;
+iterator name list_for_each_entry;
+statement S;
+position p1, p2;
+@@
+(
+ list_for_each_entry_safe@p1(desc, tmp, dev_to_msi_list(dev), member) S
+|
+ list_for_each_entry@p2(desc, dev_to_msi_list(dev), member) S
+)
+
+@script:python depends on report@
+p << r.p1;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: Use for_each_msi_entry_safe")
+
+@script:python depends on org@
+p << r.p1;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: Use for_each_msi_entry_safe")
+
+@script:python depends on report@
+p << r.p2;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: Use for_each_msi_entry")
+
+@script:python depends on org@
+p << r.p2;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: Use for_each_msi_entry")

base-commit: 255b2d524884e4ec60333131aa0ca0ef19826dc2
-- 
2.29.0

