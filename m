Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA95B4FBF2B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 16:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347316AbiDKOgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347323AbiDKOgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 10:36:16 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6151622F;
        Mon, 11 Apr 2022 07:34:01 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id ff377b1e03ebb21c; Mon, 11 Apr 2022 16:33:59 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6136366BDED;
        Mon, 11 Apr 2022 16:33:58 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 9/9] PCI/PM: Replace pci_set_power_state() in pci_pm_thaw_noirq()
Date:   Mon, 11 Apr 2022 16:33:02 +0200
Message-ID: <5729914.MhkbZ0Pkbq@kreacher>
In-Reply-To: <11975904.O9o76ZdvQC@kreacher>
References: <4419002.LvFx2qVVIh@kreacher> <11975904.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
 ihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Calling pci_set_power_state() to put the given device into D0 in
pci_pm_thaw_noirq() may cause it to restore the device's BARs, which
is redundant before calling pci_restore_state(), so replace it with
a direct pci_power_up() call followed by pci_update_current_state()
if it returns a nonzeor value, in analogy with
pci_pm_default_resume_early().

Avoid code duplication by introducing a wrapper function to contain
the repeating pattern and calling it in both places.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2.

---
 drivers/pci/pci-driver.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -551,11 +551,15 @@ static void pci_pm_default_resume(struct
 	pci_enable_wake(pci_dev, PCI_D0, false);
 }
 
-static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
+static void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
 {
 	if (pci_power_up(pci_dev))
 		pci_update_current_state(pci_dev, PCI_D0);
+}
 
+static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
+{
+	pci_pm_power_up_and_verify_state(pci_dev);
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
 }
@@ -1080,7 +1084,7 @@ static int pci_pm_thaw_noirq(struct devi
 	 * in case the driver's "freeze" callbacks put it into a low-power
 	 * state.
 	 */
-	pci_set_power_state(pci_dev, PCI_D0);
+	pci_pm_power_up_and_verify_state(pci_dev);
 	pci_restore_state(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))



