Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A844F9CB4
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiDHSbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiDHSbK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 14:31:10 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332AA97BB4;
        Fri,  8 Apr 2022 11:29:04 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 90bc16d103d9c465; Fri, 8 Apr 2022 20:29:02 +0200
Received: from kreacher.localnet (unknown [213.134.187.56])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2ACED66BDA1;
        Fri,  8 Apr 2022 20:29:02 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v2] PCI: PM: Power up all devices during runtime resume
Date:   Fri, 08 Apr 2022 20:29:01 +0200
Message-ID: <2652115.mvXUDI8C0e@kreacher>
In-Reply-To: <4412361.LvFx2qVVIh@kreacher>
References: <4412361.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.56
X-CLIENT-HOSTNAME: 213.134.187.56
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudektddguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepteeggfelteegudehueegieekveduleeuledvueefjeefffegfeejudfgteefhefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudekjedrheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekjedrheeipdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghr
 rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
Subject: [PATCH] PCI: PM: Power up all devices during runtime resume

Currently, endpoint devices may not be powered up entirely during
runtime resume that follows a D3hot -> D0 transition of the parent
bridge.

Namely, even if the power state of an endpoint device, as indicated
by its PCI_PM_CTRL register, is D0 after powering up its parent
bridge, it may be still necessary to bring its ACPI companion into
D0 and that should be done before accessing it.  However, the current
code assumes that reading the PCI_PM_CTRL register is sufficient to
establish the endpoint device's power state, which may lead to
problems.

Address that by forcing a power-up of all PCI devices, including the
platform firmware part of it, during runtime resume.

Link: https://lore.kernel.org/linux-pm/11967527.O9o76ZdvQC@kreacher
Fixes: 5775b843a619 ("PCI: Restore config space on runtime resume despite being unbound")
Reported-by: Abhishek Sahu <abhsahu@nvidia.com>
Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Move pci_pm_default_resume_early() away from #ifdef CONFIG_PM_SLEEP.
   * Add R-by from Mika.

---
 drivers/pci/pci-driver.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -551,10 +551,6 @@ static void pci_pm_default_resume(struct
 	pci_enable_wake(pci_dev, PCI_D0, false);
 }
 
-#endif
-
-#ifdef CONFIG_PM_SLEEP
-
 static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 {
 	pci_power_up(pci_dev);
@@ -563,6 +559,10 @@ static void pci_pm_default_resume_early(
 	pci_pme_restore(pci_dev);
 }
 
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+
 /*
  * Default "suspend" method for devices that have no driver provided suspend,
  * or not even a driver at all (second part).
@@ -1312,7 +1312,7 @@ static int pci_pm_runtime_resume(struct
 	 * to a driver because although we left it in D0, it may have gone to
 	 * D3cold when the bridge above it runtime suspended.
 	 */
-	pci_restore_standard_config(pci_dev);
+	pci_pm_default_resume_early(pci_dev);
 
 	if (!pci_dev->driver)
 		return 0;



