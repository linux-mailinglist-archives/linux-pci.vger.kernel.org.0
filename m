Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62D13C1424
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGHNXa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 09:23:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51738 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhGHNXa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 09:23:30 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 97e30bf93c42d0ed; Thu, 8 Jul 2021 15:20:45 +0200
Received: from kreacher.localnet (89-64-81-140.dynamic.chello.pl [89.64.81.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CA0B0669C1D;
        Thu,  8 Jul 2021 15:20:44 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4] PCI/PM: Target PM state is D3hot if device can only generate PME from D3cold
Date:   Thu, 08 Jul 2021 15:20:44 +0200
Message-ID: <11784883.O9o76ZdvQC@kreacher>
In-Reply-To: <CAJZ5v0gJ+5L+1VvxDcF9guGqY5i2HOJNov_jjcVTvkqH4jY0Yg@mail.gmail.com>
References: <20210617123653.58640-1-mika.westerberg@linux.intel.com> <CAJZ5v0hC=4dL_wKMf+KQp_aZ_mB-i0XwXejurJTc3X-ZkPpn+g@mail.gmail.com> <CAJZ5v0gJ+5L+1VvxDcF9guGqY5i2HOJNov_jjcVTvkqH4jY0Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.140
X-CLIENT-HOSTNAME: 89-64-81-140.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeggdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepteeggfelteegudehueegieekveduleeuledvueefjeefffegfeejudfgteefhefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeelrdeigedrkedurddugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurddugedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehuthhkrghrshhhrdhhrdhp
 rghtvghlsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhosggrrdhkohestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehrrghjrghtjhgrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrghirdhhvghnghdrfhgvnhhgsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, July 8, 2021 2:39:49 PM CEST Rafael J. Wysocki wrote:
> On Thu, Jul 8, 2021 at 2:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Jul 7, 2021 at 11:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Thu, Jun 17, 2021 at 03:36:53PM +0300, Mika Westerberg wrote:
> > > > Some PCIe devices only support PME (Power Management Event) from D3cold.
> > > > One example is ASMedia xHCI controller:
> > > >
> > > > 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
> > > >   ...
> > > >   Capabilities: [78] Power Management version 3
> > > >         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> > > >         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > > >
> > > > With such devices, if it has wake enabled, the kernel selects lowest
> > > > possible power state to be D0 in pci_target_state(). This is problematic
> > > > because it prevents the root port it is connected to enter low power
> > > > state too which makes the system consume more energy than necessary.
> > >
> > > IIUC this is because the loop that checks which states support PME
> > > starts with D3hot and doesn't even look at D3cold.
> >
> > That's because the device itself cannot be programmed into D3cold, so
> > the target state cannot be D3cold for it.
> >
> > > > The problem in pci_target_state() is that it only accounts the "current"
> > > > device state, so when the bridge above it (a root port for instance) is
> > > > transitioned into D3hot the device transitions into D3cold. This is
> > > > because when the root port is first transitioned into D3hot then the
> > > > ACPI power resource is turned off which puts the PCIe link to L2/L3 (and
> > > > the root port and the device are in D3cold). If the root port is kept in
> > > > D3hot it still means that the device below it is still effectively in
> > > > D3cold as no configuration messages pass through. Furthermore the
> > > > implementation note of PCIe 5.0 sec 5.3.1.4 says that the device should
> > > > expect to be transitioned into D3cold soon after its link transitions
> > > > into L2/L3 Ready state.
> > > >
> > > > Taking the above into consideration, instead of forcing the device stay
> > > > in D0 we modify pci_target_state() to return D3hot in this special case
> > > > and make __pci_enable_wake() to enable PME too in this case.
> > > >
> > > > Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> > > > Reported-by: Koba Ko <koba.ko@canonical.com>
> > > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > ---
> > > > The previous version of the patch is here:
> > > >
> > > > https://lore.kernel.org/linux-pm/20210616150516.28242-1-mika.westerberg@linux.intel.com/
> > > >
> > > > Changes from the previous version:
> > > >
> > > >   * Dropped redundant test in pci_target_state().
> > > >
> > > >  drivers/pci/pci.c | 16 +++++++++++++++-
> > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index b717680377a9..043c5c304308 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -2485,7 +2485,13 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
> > > >       if (enable) {
> > > >               int error;
> > > >
> > > > -             if (pci_pme_capable(dev, state))
> > > > +             /*
> > > > +              * Enable PME if device is capable from given state.
> > > > +              * Special case is device that can only generate PME
> > > > +              * from D3cold then we enable PME too.
> > > > +              */
> > > > +             if (pci_pme_capable(dev, state) ||
> > > > +                 (state == PCI_D3hot && pci_pme_capable(dev, PCI_D3cold)))
> > > >                       pci_pme_active(dev, true);
> > > >               else
> > > >                       ret = 1;
> > > > @@ -2595,6 +2601,14 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> > > >                * PME#.
> > > >                */
> > > >               if (dev->pme_support) {
> > > > +                     /*
> > > > +                      * Special case if device supports only PME from
> > > > +                      * D3cold but not from D3hot we still return D3hot.
> > > > +                      */
> > > > +                     if (target_state == PCI_D3hot &&
> > > > +                             (dev->pme_support & (1 << PCI_D3cold)))
> > > > +                             return target_state;
> > >
> > > I've spent quite a bit of time trying to understand this, and I'm kind
> > > of dragging my feet on it because I haven't been able to really
> > > connect this with the specs.
> >
> > The specs aren't very clear in this area, though.
> >
> > The overall picture is that the device in question is connected to a
> > port (a root port in this particular case) that can be programmed into
> > D3cold via ACPI, but the endpoint itself can only be programmed into
> > D3hot.  However, if the port goes into D3cold, the endpoint also goes
> > into D3cold (actually, my understanding of the specs is that even if
> > the port goes into D3hot, the endpoint should still be assumed to go
> > into D3cold).
> >
> > The power state of the endpoint is changed first and at the time this
> > happens it is not known which power state the port is going to be
> > programmed into.
> >
> > Now, the device is wake-capable (in general) and so we want it to be
> > able to signal wakeup from the final power state.  Because it only
> > reports PME support in D0 and in D3cold, the kernel today leaves it in
> > D0 which causes the port to stay in D0 too.  Still, putting the device
> > into D3hot allows the port to go into D3cold which in turn causes the
> > device to go into D3cold and it can signal wakeup from that state.
> >
> > So there are two ways to get into a configuration from which the
> > endpoint device can signal wakeup, either by leaving it and the port
> > holding it both in D0, or by putting it into D3hot, so that the port
> > can go into D3cold in which case the endpoint will end up in D3cold.
> >
> > The Mika's patch is aiming at enabling the second option.
> >
> > > It also seems unfortunate to have to add this special case in two places.
> >
> > That's because __pci_enable_wake() tries to be extra careful and only
> > call pci_pme_active() if PME is known to be supported in the target
> > power state, but that is not strictly necessary.  It could just call
> > pci_pme_active() unconditionally and return the
> > platform_pci_set_wakeup() return value.
> >
> > I think I'll send a patch making this change.
> 
> Actually, it needs to fail if PME cannot be signaled from the target
> state and the device is not power-manageable by the platform.
> 
> A better idea may be to make pci_pme_capable() also check if the
> parent bridge can go into D3cold and return "true" if so and "state"
> is D3hot while PME signaling from D3cold is supported.

So below is my version of the $subject patch (untested).

Please let me know what you think.

---
 drivers/pci/pci.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2305,7 +2305,19 @@ bool pci_pme_capable(struct pci_dev *dev
 	if (!dev->pm_cap)
 		return false;
 
-	return !!(dev->pme_support & (1 << state));
+	if (dev->pme_support & (1 << state))
+		return true;
+
+	if (state < PCI_D3hot)
+		return false;
+
+	/*
+	 * If the device goes into D3hot, the parent bridge is allowed to go
+	 * into D3 and the device will end up in D3cold, so if it supports
+	 * signaling PME from D3cold, it still should be good then.
+	 */
+	return pci_bridge_d3_possible(dev->bus->self) &&
+		(dev->pme_support & (1 << PCI_D3cold));
 }
 EXPORT_SYMBOL(pci_pme_capable);
 
@@ -2599,17 +2611,12 @@ static pci_power_t pci_target_state(stru
 	if (dev->current_state == PCI_D3cold)
 		target_state = PCI_D3cold;
 
-	if (wakeup) {
-		/*
-		 * Find the deepest state from which the device can generate
-		 * PME#.
-		 */
-		if (dev->pme_support) {
-			while (target_state
-			      && !(dev->pme_support & (1 << target_state)))
-				target_state--;
-		}
-	}
+	if (!wakeup || pci_pme_capable(dev, target_state) || !dev->pme_support)
+		return target_state;
+
+	/* Find the deepest state from which the device can generate PME#. */
+	while (target_state && !(dev->pme_support & (1 << target_state)))
+		target_state--;
 
 	return target_state;
 }




