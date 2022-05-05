Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E965851C7C8
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383173AbiEESdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385318AbiEESaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 14:30:20 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A22E54BF4;
        Thu,  5 May 2022 11:21:00 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id cb2124d2900a9eb5; Thu, 5 May 2022 20:19:37 +0200
Received: from kreacher.localnet (unknown [213.134.161.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BEF7266C2F2;
        Thu,  5 May 2022 20:19:36 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v1 05/11] PCI/PM: Do not call pci_update_current_state() from pci_power_up()
Date:   Thu, 05 May 2022 20:09:12 +0200
Message-ID: <3695055.kQq0lBPeGt@kreacher>
In-Reply-To: <4738492.GXAFRqVoOG@kreacher>
References: <4738492.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.219
X-CLIENT-HOSTNAME: 213.134.161.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduiedurddvudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiuddrvdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgv
 lhdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that calling pci_update_current_state() from pci_power_up() is
redundant and may be harmful in some cases.

First, if the device is in a low-power state before pci_power_up()
gets called for it and platform_pci_set_power_state() successfully
changes its power state to D0, pci_update_current_state() will update
current_state to reflect that and pci_power_up() will return success
right away without restoring the device's BARs or reconfiguring ASPM
which may be necessary.  This is arguably incorrect and definitely
inconsistent with the case when platform_pci_set_power_state() returns
an error (for example, because the device is not power-manageable by
the platform firmware).

Second, current_state should not be overwritten until the decision
whether or not to restore the device's BARs is made, because that
decision generally depends on its value.  Again, calling
pci_update_current_state() in pci_power_up() is not consistent with
this observation.

Next, pci_power_up() attempts to read from the device's PCI_PM_CTRL
register regardless of the current_state value unless it is PCI_D0,
including the case when pci_update_current_state() sets current_state
to PCI_D3cold to indicate that the device is not accessible.  If the
register read is not successful, current_state will be set to
PCI_D3cold anyway, so that pci_update_current_state() action is
redundant.

Further, if pci_update_current_state() reads the device's PCI_PM_CTRL
register, pci_power_up() will repeat that read going forward and
it is not necessary to update current_state in the meantime.

Finally, if pm_cap is not set (in which case the PCI_PM_CTRL register
is not present), the power state of the device should be determined
with the help of the platform firmware or set to D0 if that's not
possible and pci_update_current_state() does not do that.

Accordingly, rearrange pci_power_up() so as to address the above
shortcomings.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1192,23 +1192,24 @@ static int pci_dev_wait(struct pci_dev *
  */
 int pci_power_up(struct pci_dev *dev)
 {
-	bool need_restore = false;
+	bool need_restore;
+	pci_power_t state;
 	u16 pmcsr;
-	int ret;
 
-	ret = platform_pci_set_power_state(dev, PCI_D0);
-	if (!ret) {
-		pci_update_current_state(dev, PCI_D0);
-	} else if (!dev->pm_cap) { /* Fall back to PCI_D0 */
-		dev->current_state = PCI_D0;
-		return 0;
-	}
+	platform_pci_set_power_state(dev, PCI_D0);
+
+	if (!dev->pm_cap) {
+		state = platform_pci_get_power_state(dev);
+		if (state == PCI_UNKNOWN)
+			dev->current_state = PCI_D0;
+		else
+			dev->current_state = state;
 
-	if (dev->current_state == PCI_D0)
-		return 0;
+		if (state == PCI_D0)
+			return 0;
 
-	if (!dev->pm_cap)
 		return -EIO;
+	}
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
@@ -1218,26 +1219,31 @@ int pci_power_up(struct pci_dev *dev)
 		return -EIO;
 	}
 
+	state = pmcsr & PCI_PM_CTRL_STATE_MASK;
+
+	need_restore = (state == PCI_D3hot || dev->current_state >= PCI_D3hot) &&
+			!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
+
+	if (state == PCI_D0) {
+		dev->current_state = PCI_D0;
+		goto end;
+	}
+
 	/*
 	 * If we're (effectively) in D3, force entire word to 0. This doesn't
 	 * affect PME_Status, disables PME_En, and sets PowerState to 0.
 	 */
-	if (dev->current_state >= PCI_D3hot) {
-		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot &&
-		    !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
-			need_restore = true;
-
+	if (state == PCI_D3hot)
 		pmcsr = 0;
-	} else {
+	else
 		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
-	}
 
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
 
 	/* Mandatory transition delays; see PCI PM 1.2. */
-	if (dev->current_state == PCI_D3hot)
+	if (state == PCI_D3hot)
 		pci_dev_d3_sleep(dev);
-	else if (dev->current_state == PCI_D2)
+	else if (state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
@@ -1246,6 +1252,7 @@ int pci_power_up(struct pci_dev *dev)
 		pci_info_ratelimited(dev, "Refused to change power state from %s to D0\n",
 				     pci_power_name(dev->current_state));
 
+end:
 	/*
 	 * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
 	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning



