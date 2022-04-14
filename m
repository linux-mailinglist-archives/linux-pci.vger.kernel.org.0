Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1C6500F62
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbiDNN0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244346AbiDNN0a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 09:26:30 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5999E9E1;
        Thu, 14 Apr 2022 06:19:56 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 6ff0503fedc9cd83; Thu, 14 Apr 2022 15:19:55 +0200
Received: from kreacher.localnet (unknown [213.134.181.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3DC4666BE86;
        Thu, 14 Apr 2022 15:19:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 6/9] PCI/PM: Clean up pci_set_low_power_state()
Date:   Thu, 14 Apr 2022 15:15:31 +0200
Message-ID: <1749771.VLH7GnMWUR@kreacher>
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

Make the following assorted non-essential changes in
pci_set_low_power_state():

 1. Drop two redundant checks from it (the caller takes care of these
    conditions).

 2. Modify error messages printed by it to make them more consistent
    with the messages printed by pci_power_up() and
    pci_set_full_power_state().

 3. Change the log level of one of the messages to "debug", because
    it only indicates a programming mistake.

 4. Make it return -ENODEV (instead of -EIO) when the device is not
    accessible.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---

v1 -> v3:
   * Added R-by from Mika.

---
 drivers/pci/pci.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1345,16 +1345,9 @@ static int pci_set_low_power_state(struc
 {
 	u16 pmcsr;
 
-	/* Check if we're already there */
-	if (dev->current_state == state)
-		return 0;
-
 	if (!dev->pm_cap)
 		return -EIO;
 
-	if (state < PCI_D1 || state > PCI_D3hot)
-		return -EINVAL;
-
 	/*
 	 * Validate transition: We can enter D0 from any state, but if
 	 * we're already in a low-power state, we can only go deeper.  E.g.,
@@ -1362,7 +1355,7 @@ static int pci_set_low_power_state(struc
 	 * we'd have to go from D3 to D0, then to D1.
 	 */
 	if (dev->current_state <= PCI_D3cold && dev->current_state > state) {
-		pci_err(dev, "invalid power transition (from %s to %s)\n",
+		pci_dbg(dev, "Invalid power transition (from %s to %s)\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
 		return -EINVAL;
@@ -1375,10 +1368,10 @@ static int pci_set_low_power_state(struc
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
-		pci_err(dev, "can't change power state from %s to %s (config space inaccessible)\n",
+		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
-		return -EIO;
+		return -ENODEV;
 	}
 
 	pmcsr &= ~PCI_PM_CTRL_STATE_MASK;



