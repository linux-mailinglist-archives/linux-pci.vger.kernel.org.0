Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347304FA889
	for <lists+linux-pci@lfdr.de>; Sat,  9 Apr 2022 15:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiDINbE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Apr 2022 09:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241884AbiDINbD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Apr 2022 09:31:03 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46BADD5F;
        Sat,  9 Apr 2022 06:28:54 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 1352328eb26ee335; Sat, 9 Apr 2022 15:28:52 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C220366BCD0;
        Sat,  9 Apr 2022 15:28:51 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 7/7] PCI/PM: Rearrange pci_set_power_state()
Date:   Sat, 09 Apr 2022 15:28:38 +0200
Message-ID: <1938958.usQuhbGJ8B@kreacher>
In-Reply-To: <4419002.LvFx2qVVIh@kreacher>
References: <4419002.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekvddgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshht
 vghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
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
to set the current state of all devices on the subordinate to D3cold
without checking if the power state of the parent bridge has really
changed to D3cold.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1438,19 +1438,25 @@ int pci_set_power_state(struct pci_dev *
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



