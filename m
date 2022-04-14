Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D24500F4F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiDNN0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244337AbiDNN0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 09:26:03 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658249D4F6;
        Thu, 14 Apr 2022 06:19:53 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id b72255e1ca56a71d; Thu, 14 Apr 2022 15:19:51 +0200
Received: from kreacher.localnet (unknown [213.134.181.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1980466BE8A;
        Thu, 14 Apr 2022 15:19:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 7/9] PCI/PM: Rearrange pci_set_power_state()
Date:   Thu, 14 Apr 2022 15:17:00 +0200
Message-ID: <1936737.usQuhbGJ8B@kreacher>
In-Reply-To: <5838942.lOV4Wx5bFT@kreacher>
References: <4419002.LvFx2qVVIh@kreacher> <11975904.O9o76ZdvQC@kreacher> <5838942.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.101
X-CLIENT-HOSTNAME: 213.134.181.101
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelfedgieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurddutddupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
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

The part of pci_set_power_state() related to transitions into
low-power states is unnecessary convoluted, so clearly divide it
into the D3cold special case and the general case covering all of
the other states.

Also fix a potential issue with calling pci_bus_set_current_state()
to set the current state of all devices on the subordinate bus to
D3cold without checking if the power state of the parent bridge has
really changed to D3cold.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---

v1 -> v3:
   * Fixed typo in the changelog (missing word "bus").
   * Added R-by from Mika.

---
 drivers/pci/pci.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1452,19 +1452,25 @@ int pci_set_power_state(struct pci_dev *
 	if (state >= PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
 		return 0;
 
-	/*
-	 * To put device in D3cold, we put device into D3hot in native
-	 * way, then put device into D3cold with platform ops
-	 */
-	error = pci_set_low_power_state(dev, state > PCI_D3hot ?
-					PCI_D3hot : state);
+	if (state == PCI_D3cold) {
+		/*
+		 * To put the device in D3cold, put it into D3hot in the native
+		 * way, then put it into D3cold using platform ops.
+		 */
+		error = pci_set_low_power_state(dev, PCI_D3hot);
 
-	if (pci_platform_power_transition(dev, state))
-		return error;
+		if (pci_platform_power_transition(dev, PCI_D3cold))
+			return error;
 
-	/* Powering off a bridge may power off the whole hierarchy */
-	if (state == PCI_D3cold)
-		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
+		/* Powering off a bridge may power off the whole hierarchy */
+		if (dev->current_state == PCI_D3cold)
+			pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
+	} else {
+		error = pci_set_low_power_state(dev, state);
+
+		if (pci_platform_power_transition(dev, state))
+			return error;
+	}
 
 	return 0;
 }



