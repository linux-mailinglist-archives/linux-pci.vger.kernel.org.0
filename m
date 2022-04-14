Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB419500F6B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbiDNN1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244417AbiDNN0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 09:26:33 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70FB9F3B5;
        Thu, 14 Apr 2022 06:20:01 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id ab2470cf6047be01; Thu, 14 Apr 2022 15:19:59 +0200
Received: from kreacher.localnet (unknown [213.134.181.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 210F766BE86;
        Thu, 14 Apr 2022 15:19:59 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 3/9] PCI/PM: Rearrange pci_update_current_state()
Date:   Thu, 14 Apr 2022 15:07:24 +0200
Message-ID: <1917095.PYKUYFuaPT@kreacher>
In-Reply-To: <5838942.lOV4Wx5bFT@kreacher>
References: <4419002.LvFx2qVVIh@kreacher> <11975904.O9o76ZdvQC@kreacher> <5838942.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.101
X-CLIENT-HOSTNAME: 213.134.181.101
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelfedgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurddutddupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
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

Save one config space access in pci_update_current_state() by
testing the retireved PCI_PM_CTRL register value against
PCI_POSSIBLE_ERROR() instead of invoking pci_device_is_present()
separately.

While at it, drop a pair of unnecessary parens.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3:
   * Fixed typo in the changelog ("retrieved" spelling).
   * Added R-by from Mika.

---
 drivers/pci/pci.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1201,14 +1201,17 @@ static int pci_raw_set_power_state(struc
  */
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
 {
-	if (platform_pci_get_power_state(dev) == PCI_D3cold ||
-	    !pci_device_is_present(dev)) {
+	if (platform_pci_get_power_state(dev) == PCI_D3cold) {
 		dev->current_state = PCI_D3cold;
 	} else if (dev->pm_cap) {
 		u16 pmcsr;
 
 		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+		if (PCI_POSSIBLE_ERROR(pmcsr)) {
+			dev->current_state = PCI_D3cold;
+			return;
+		}
+		dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
 	} else {
 		dev->current_state = state;
 	}



