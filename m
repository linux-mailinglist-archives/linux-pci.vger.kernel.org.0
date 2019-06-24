Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37CD5098F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 13:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfFXLOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 07:14:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41880 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfFXLOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 07:14:51 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id dea609813937a26d; Mon, 24 Jun 2019 13:14:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get PCI device power state
Date:   Mon, 24 Jun 2019 13:14:47 +0200
Message-ID: <1858642.x2LvR771H8@kreacher>
In-Reply-To: <CAJZ5v0hfCnyuAA7kC5-fXRo-Mf0jvGZQASV9T4iK8QxsqHMN_g@mail.gmail.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com> <20190620141541.GA257318@google.com> <CAJZ5v0hfCnyuAA7kC5-fXRo-Mf0jvGZQASV9T4iK8QxsqHMN_g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, June 21, 2019 12:32:22 PM CEST Rafael J. Wysocki wrote:
> On Thu, Jun 20, 2019 at 4:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Jun 20, 2019 at 04:37:10PM +0300, Mika Westerberg wrote:
> > > On Thu, Jun 20, 2019 at 08:16:49AM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Jun 20, 2019 at 11:27:30AM +0300, Mika Westerberg wrote:
> > > > > On Wed, Jun 19, 2019 at 04:28:01PM -0500, Bjorn Helgaas wrote:
> > > > > > On Tue, Jun 18, 2019 at 07:18:56PM +0300, Mika Westerberg wrote:
> > > > > > > Intel Ice Lake has an integrated Thunderbolt controller which
> > > > > > > means that the PCIe topology is extended directly from the two
> > > > > > > root ports (RP0 and RP1).
> > > > > >
> > > > > > A PCIe topology is always extended directly from root ports,
> > > > > > regardless of whether a Thunderbolt controller is integrated, so I
> > > > > > guess I'm missing the point you're making.  It doesn't sound like
> > > > > > this is anything specific to Thunderbolt?
> > > > >
> > > > > The point I'm trying to make here is to explain why this is problem
> > > > > now and not with the previous discrete controllers. With the
> > > > > previous there was only a single ACPI power resource for the root
> > > > > port and the Thunderbolt host router was connected to that root
> > > > > port. PCIe hierarchy was extended through downstream ports (not root
> > > > > ports) of that controller (which includes PCIe switch).
> > > >
> > > > Sounds like you're using "PCIe topology extension" to mean
> > > > specifically something below a Thunderbolt controller, excluding a
> > > > subtree below a root port.  I don't think the PCI core is aware of
> > > > that distinction.
> > >
> > > Right it is not.
> > >
> > > > > Now the thing is part of the SoC so power management is different
> > > > > and causes problems in Linux.
> > > >
> > > > The SoC is a physical packaging issue that really doesn't enter into
> > > > the specs directly.  I'm trying to get at the logical topology
> > > > questions in terms of the PCIe and ACPI specs.
> > > >
> > > > I assume we could dream up a non-Thunderbolt topology that would show
> > > > the same problem?
> > >
> > > Yes.
> > >
> > > > > > > Power management is handled by ACPI power resources that are
> > > > > > > shared between the root ports, Thunderbolt controller (NHI) and xHCI
> > > > > > > controller.
> > > > > > >
> > > > > > > The topology with the power resources (marked with []) looks like:
> > > > > > >
> > > > > > >   Host bridge
> > > > > > >     |
> > > > > > >     +- RP0 ---\
> > > > > > >     +- RP1 ---|--+--> [TBT]
> > > > > > >     +- NHI --/   |
> > > > > > >     |            |
> > > > > > >     |            v
> > > > > > >     +- xHCI --> [D3C]
> > > > > > >
> > > > > > > Here TBT and D3C are the shared ACPI power resources. ACPI
> > > > > > > _PR3() method returns either TBT or D3C or both.
> > > >
> > > > I'm not very familiar with _PR3.  I guess this is under an ACPI object
> > > > representing a PCI device, e.g., \_SB.PCI0.RP0._PR3?
> > >
> > > Correct.
> > >
> > > > > > > Say we runtime suspend first the root ports RP0 and RP1, then
> > > > > > > NHI. Now since the TBT power resource is still on when the root
> > > > > > > ports are runtime suspended their dev->current_state is set to
> > > > > > > D3hot. When NHI is runtime suspended TBT is finally turned off
> > > > > > > but state of the root ports remain to be D3hot.
> > > >
> > > > So in this example we might have:
> > > >
> > > >   _SB.PCI0.RP0._PR3: TBT
> > > >   _SB.PCI0.RP1._PR3: TBT
> > > >   _SB.PCI0.NHI._PR3: TBT
> > >
> > > and also D3C.
> > >
> > > > And when Linux figures out that everything depending on TBT is in
> > > > D3hot, it evaluates TBT._OFF, which puts them all in D3cold?  And part
> > > > of the problem is that they're now in D3cold (where config access
> > > > doesn't work) but Linux still thinks they're in D3hot (where config
> > > > access would work)?
> > >
> > > Exactly.
> > >
> > > > I feel like I'm missing something because I don't know how D3C is
> > > > involved, since you didn't mention suspending xHCI.
> > >
> > > That's another power resource so we will also have D3C turned off when
> > > xHCI gets suspended but I did not want to complicate things too much in
> > > the changelog.
> >
> > If D3C isn't essential to seeing this problem, you could just omit it
> > altogether.  I think stripping out anything that's not essential will
> > make it easier to think about the underlying issues.
> >
> > > > And I can't mentally match up the patch with the D3hot/D3cold state
> > > > change (if indeed that's the problem).  If we were updating the path
> > > > that evaluates _OFF so it changed the power state of all dependent
> > > > devices, *that* would make a lot of sense to me because it sounds like
> > > > that's where the physical change happens that makes things out of
> > > > sync.
> > >
> > > I did that in the first version [1] but Rafael pointed out that it is
> > > racy one way or another [2].
> > >
> > > [1] https://www.spinics.net/lists/linux-pci/msg83583.html
> > > [2] https://www.spinics.net/lists/linux-pci/msg83600.html
> >
> > Yeah, interesting.  It was definitely a much larger patch.  I don't
> > know enough to comment on the races.
> 
> Say two power resources are listed by _PR3 for one device (because why
> not?) and you want to change the device's state to D3cold only if the
> two power resources are both "off".  Then, you need some locking (or
> equivalent) to synchronize two power resources with each other, so
> that you can change the devices state when the last of them goes _OFF.
> Currently, there is no such synchronization between power resources
> other then the "system_level" value which may not be reliable enough
> for this type of use.
> 
> Or you can say that the device is in D3cold if at least one of the
> power resources is _OFF, but IMO that may not really be consistent
> with the view that the "logical" power state of the device should
> reflect the physical reality accurately.
> 
> > I would wonder whether there's a way to get rid of the caches that become stale,
> 
> I guess what you mean is that the "cached" (or rather "logical" or
> "expected") power state value may become different from what is
> returned by acpi_device_get_power() for the device.
> 
> The problem here is that acpi_device_get_power() really only should be
> used for two purposes: (1) To initialize adev->power.state, or to
> update it via acpi_device_update_power(), and (2) by the
> "real_power_state" sysfs attribute (of ACPI device objects).  The
> adev->power.state value should be used anywhere else, in principle, so
> the Mika's patch is correct.

Well, it is an improvement, but it is not sufficient.

> [Note that adev->power.state cannot be updated after calling
> acpi_device_get_power() to the value returned by it without updating
> the reference counters of the power resources that are "on" *exactly*
> because of the problem at hand here.]

That is obviously correct, but ->

> > but that's just an idle thought, not a suggestion.
> 
> After the initialization of the ACPI subsystem, the authoritative
> source of the ACPI device power state information is
> adev->power.state.  The ACPI subsystem is expected to update this
> value as needed going forward (including system-wide transitions like
> resume from S3).

-> the "resume from S3 or hibernation" case needs special handling, because
in that case the device power state need not reflect the information the ACPI
subsystem has.  That only matters if adev->power.state is ACPI_STATE_D0 and
the device is actually *not* in D0, because in that case acpi_device_set_power()
will not work.  So that case is not covered currently (it should be rare in practice,
though, if it happens at all), so something like the patch below (untested) may
be needed in addition to the Mika's patch.

Still, there is also the "power state not matching" case in pci_pm_complete() that's
need to be covered and the non-PCI ACPI PM has a similar issue in theory, so I
need to think about this a bit more.

---
 drivers/pci/pci-acpi.c |   14 +++++++++++++-
 drivers/pci/pci-mid.c  |    3 ++-
 drivers/pci/pci.c      |    9 +++++----
 drivers/pci/pci.h      |    2 +-
 4 files changed, 21 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -632,7 +632,8 @@ static bool acpi_pci_power_manageable(st
 	return adev ? acpi_device_power_manageable(adev) : false;
 }
 
-static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state,
+				    bool force)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 	static const u8 state_conv[] = {
@@ -657,6 +658,17 @@ static int acpi_pci_set_power_state(stru
 		}
 		/* Fall through */
 	case PCI_D0:
+		if (force) {
+			int acpi_state;
+
+			error = acpi_device_update_power(adev, &acpi_state);
+			if (error)
+				return error;
+
+			if (acpi_state == ACPI_STATE_D0)
+				return 0;
+		}
+		/* fall through */
 	case PCI_D1:
 	case PCI_D2:
 	case PCI_D3hot:
Index: linux-pm/drivers/pci/pci-mid.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-mid.c
+++ linux-pm/drivers/pci/pci-mid.c
@@ -21,7 +21,8 @@ static bool mid_pci_power_manageable(str
 	return true;
 }
 
-static int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
+static int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state,
+				   bool not_used)
 {
 	return intel_mid_pci_set_power_state(pdev, state);
 }
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -767,9 +767,10 @@ static inline bool platform_pci_power_ma
 }
 
 static inline int platform_pci_set_power_state(struct pci_dev *dev,
-					       pci_power_t t)
+					       pci_power_t state, bool force)
 {
-	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
+	return pci_platform_pm ?
+		pci_platform_pm->set_state(dev, state, force) : -ENOSYS;
 }
 
 static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
@@ -944,7 +945,7 @@ void pci_update_current_state(struct pci
 void pci_power_up(struct pci_dev *dev)
 {
 	if (platform_pci_power_manageable(dev))
-		platform_pci_set_power_state(dev, PCI_D0);
+		platform_pci_set_power_state(dev, PCI_D0, true);
 
 	pci_raw_set_power_state(dev, PCI_D0);
 	pci_update_current_state(dev, PCI_D0);
@@ -960,7 +961,7 @@ static int pci_platform_power_transition
 	int error;
 
 	if (platform_pci_power_manageable(dev)) {
-		error = platform_pci_set_power_state(dev, state);
+		error = platform_pci_set_power_state(dev, state, false);
 		if (!error)
 			pci_update_current_state(dev, state);
 	} else
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -67,7 +67,7 @@ int pci_bus_error_reset(struct pci_dev *
 struct pci_platform_pm_ops {
 	bool (*bridge_d3)(struct pci_dev *dev);
 	bool (*is_manageable)(struct pci_dev *dev);
-	int (*set_state)(struct pci_dev *dev, pci_power_t state);
+	int (*set_state)(struct pci_dev *dev, pci_power_t state, bool force);
 	pci_power_t (*get_state)(struct pci_dev *dev);
 	pci_power_t (*choose_state)(struct pci_dev *dev);
 	int (*set_wakeup)(struct pci_dev *dev, bool enable);



