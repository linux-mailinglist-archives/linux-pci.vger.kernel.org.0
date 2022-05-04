Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0DD51ACC0
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 20:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376731AbiEDS3e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376761AbiEDS3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 14:29:13 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76BE4757F;
        Wed,  4 May 2022 11:00:37 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 51a7cf1e4c0649f0; Wed, 4 May 2022 20:00:35 +0200
Received: from kreacher.localnet (unknown [213.134.161.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A61BA66C2D7;
        Wed,  4 May 2022 20:00:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 4/9] PCI/PM: Rework changing power states of PCI devices
Date:   Wed, 04 May 2022 20:00:33 +0200
Message-ID: <2650302.mvXUDI8C0e@kreacher>
In-Reply-To: <YnKrcFSjLr+W+myL@dev-arch.thelio-3990X>
References: <4419002.LvFx2qVVIh@kreacher> <CAJZ5v0i1Ynt54yb7aMJorkYUvqkxhxOqvQJb8AdA7Ps1aBO5tg@mail.gmail.com> <YnKrcFSjLr+W+myL@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.219
X-CLIENT-HOSTNAME: 213.134.161.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeiuddrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduiedurddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, May 4, 2022 6:36:00 PM CEST Nathan Chancellor wrote:
> On Wed, May 04, 2022 at 02:59:17PM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 3, 2022 at 7:59 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Thu, Apr 14, 2022 at 03:11:21PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > There are some issues related to changing power states of PCI
> > > > devices, mostly related to carrying out unnecessary actions in some
> > > > places, and the code is generally hard to follow.
> > > >
> > > >  1. pci_power_up() has two callers, pci_set_power_state() and
> > > >     pci_pm_default_resume_early().  The latter updates the current
> > > >     power state of the device right after calling pci_power_up()
> > > >     and it restores the entire config space of the device right
> > > >     after that, so pci_power_up() itself need not read the
> > > >     PCI_PM_CTRL register or restore the BARs after programming the
> > > >     device into D0 in that case.
> > > >
> > > >  2. It is generally hard to get a clear view of the pci_power_up()
> > > >     code flow, especially in some corner cases, due to all of the
> > > >     involved PCI_PM_CTRL register reads and writes occurring in
> > > >     pci_platform_power_transition() and in pci_raw_set_power_state(),
> > > >     some of which are redundant.
> > > >
> > > >  3. The transitions from low-power states to D0 and the other way
> > > >     around are unnecessarily tangled in pci_raw_set_power_state()
> > > >     which causes it to use a redundant local variable and makes it
> > > >     rather hard to follow.
> > > >
> > > > To address the above shortcomings, make the following changes:
> > > >
> > > >  a. Remove the code handling transitions into D0
> > > >     from pci_raw_set_power_state() and rename it as
> > > >     pci_set_low_power_state().
> > > >
> > > >  b. Add the code handling transitions into D0 directly
> > > >     to pci_power_up() and to a new wrapper function
> > > >     pci_set_full_power_state() calling it internally that is
> > > >     only used in pci_set_power_state().
> > > >
> > > >  c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
> > > >     and make it work in the same way for transitions from any
> > > >     low-power states (transitions from D1 and D2 are handled
> > > >     slightly differently before the change).
> > > >
> > > >  d. Put the restoration of the BARs and the PCI_PM_CTRL
> > > >     register read confirming the power state change into
> > > >     pci_set_full_power_state() to avoid doing that in
> > > >     pci_pm_default_resume_early() unnecessarily.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >
> > > This change as commit 5bffe4c611f5 ("PCI/PM: Rework changing power
> > > states of PCI devices") causes my AMD-based system to fail to fully
> > > boot. As far as I can tell, this might be NVMe related, which might make
> > > getting a full log difficult, as journalctl won't have anywhere to save
> > > it. I see:
> > >
> > > nvme nvme0: I/O 8 QID 0 timeout, completion polled
> > >
> > > then shortly afterwards:
> > >
> > > nvme nvme0: I/O 24 QID 0 timeout, completion polled
> > > nvme nvme0: missing or invalid SUBNQN field
> > >
> > > then I am dropped into an emergency shell.
> > 
> > Thanks for the report!
> > 
> > > This is a log from the previous commit, which may give some hints about
> > > the configuration of this particular system.
> > >
> > > https://gist.github.com/nathanchance/8a56f0939410cb187896e904c72e41e7/raw/b47b2620bdd32d43c7a3b209fcfd9e3d4668f058/good-boot.log
> > >
> > > If there is any additional debugging information I can provide or
> > > patches I can try, please let me know!
> > 
> > Please see what happens if the "if (dev->current_state == PCI_D0)"
> > check and the following "return 0" statement in pci_power_up() are
> > commented out.
> 
> If I understand you correctly, this? Unfortunately, that does not help.

Thanks for testing.

Please check if the patch below makes any difference.

---
 drivers/pci/pci.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1245,7 +1245,7 @@ int pci_power_up(struct pci_dev *dev)
 
 	/* There's nothing more to do if current_state is D0 at this point. */
 	if (dev->current_state == PCI_D0)
-		return 0;
+		goto done;
 
 	/*
 	 * Program the device into PCI_D0 by forcing the entire word to 0 (this
@@ -1260,6 +1260,11 @@ int pci_power_up(struct pci_dev *dev)
 		udelay(PCI_PM_D2_DELAY);
 
 	dev->current_state = PCI_D0;
+
+done:
+	if (dev->bus->self)
+		pcie_aspm_pm_state_change(dev->bus->self);
+
 	return 1;
 
 fail:
@@ -1339,9 +1344,6 @@ static int pci_set_full_power_state(stru
 		pci_restore_bars(dev);
 	}
 
-	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
-
 	return 0;
 }
 



