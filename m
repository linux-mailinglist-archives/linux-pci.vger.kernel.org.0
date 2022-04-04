Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2D4F18AB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378362AbiDDPof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 11:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347003AbiDDPoe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 11:44:34 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0831393F5;
        Mon,  4 Apr 2022 08:42:37 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 663112fc46d070d8; Mon, 4 Apr 2022 17:42:36 +0200
Received: from kreacher.localnet (unknown [213.134.181.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3F1BC66BCD3;
        Mon,  4 Apr 2022 17:42:35 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 2/2] PCI: PM: Resume bus after putting the bridge into D0 entirely
Date:   Mon, 04 Apr 2022 17:42:27 +0200
Message-ID: <1807986.atdPhlSkOF@kreacher>
In-Reply-To: <4198163.ejJDZkT8p0@kreacher>
References: <4198163.ejJDZkT8p0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.62
X-CLIENT-HOSTNAME: 213.134.181.62
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddriedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekuddriedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhk
 rgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
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

It is rather counter-intuitive to attempt to resume devices on a bus
segment before completing a transition of their parent bridge into
D0, so do that when the transition is complete.

This matters especially when the transition in question is not
successful, in which case it doesn't make sense to even try to
resume the child devices at all.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1310,15 +1310,24 @@ static int pci_dev_wait(struct pci_dev *
 int pci_power_up(struct pci_dev *dev)
 {
 	pci_power_t old_state = dev->current_state;
+	int ret;
 
 	pci_platform_power_transition(dev, PCI_D0);
+	/*
+	 * For transitions from D3hot or deeper (including unknown), force
+	 * PCI_PM_CTRL register write, D3*->D0 transition delay and BARS
+	 * restoration.
+	 */
+	if (old_state >= PCI_D3hot)
+		dev->current_state = PCI_D3hot;
 
+	ret = pci_raw_set_power_state(dev, PCI_D0);
 	/*
 	 * Mandatory power management transition delays are handled in
 	 * pci_pm_resume_noirq() and pci_pm_runtime_resume() of the
 	 * corresponding bridge.
 	 */
-	if (dev->runtime_d3cold) {
+	if (!ret && dev->runtime_d3cold) {
 		/*
 		 * When powering on a bridge from D3cold, the whole hierarchy
 		 * may be powered on into D0uninitialized state, resume them to
@@ -1327,15 +1336,7 @@ int pci_power_up(struct pci_dev *dev)
 		pci_resume_bus(dev->subordinate);
 	}
 
-	/*
-	 * For transitions from D3hot or deeper and initial power-up, force
-	 * PCI_PM_CTRL register write, D3*->D0 transition delay and BARS
-	 * restoration.
-	 */
-	if (old_state >= PCI_D3hot)
-		dev->current_state = PCI_D3hot;
-
-	return pci_raw_set_power_state(dev, PCI_D0);
+	return ret;
 }
 
 /**



