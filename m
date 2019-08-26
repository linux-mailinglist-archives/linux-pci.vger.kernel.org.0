Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5CC9D1D8
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfHZOmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 10:42:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:17303 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbfHZOmu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Aug 2019 10:42:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 07:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="197069444"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 26 Aug 2019 07:42:43 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 26 Aug 2019 17:42:42 +0300
Date:   Mon, 26 Aug 2019 17:42:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add missing link delays required by the PCIe spec
Message-ID: <20190826144242.GA2643@lahna.fi.intel.com>
References: <20190821124519.71594-1-mika.westerberg@linux.intel.com>
 <20190824021254.GB127465@google.com>
 <20190826101726.GD19908@lahna.fi.intel.com>
 <20190826140712.GC127465@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826140712.GC127465@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 26, 2019 at 09:07:12AM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 26, 2019 at 01:17:26PM +0300, Mika Westerberg wrote:
> > On Fri, Aug 23, 2019 at 09:12:54PM -0500, Bjorn Helgaas wrote:
> > > Hi Mika,
> > 
> > Hi,
> > 
> > > I'm trying to figure out specifically why we need this and where it
> > > should go.  Questions below.
> > 
> > Thanks for looking at this.
> > 
> > > On Wed, Aug 21, 2019 at 03:45:19PM +0300, Mika Westerberg wrote:
> > > > Currently Linux does not follow PCIe spec regarding the required delays
> > > > after reset. A concrete example is a Thunderbolt add-in-card that
> > > > consists of a PCIe switch and two PCIe endpoints:
> > > > 
> > > >   +-1b.0-[01-6b]----00.0-[02-6b]--+-00.0-[03]----00.0 TBT controller
> > > >                                   +-01.0-[04-36]-- DS hotplug port
> > > >                                   +-02.0-[37]----00.0 xHCI controller
> > > >                                   \-04.0-[38-6b]-- DS hotplug port
> > > > 
> > > > The root port (1b.0) and the PCIe switch downstream ports are all PCIe
> > > > gen3 so they support 8GT/s link speeds.
> > > > 
> > > > We wait for the PCIe hierarchy to enter D3cold (runtime):
> > > > 
> > > >   pcieport 0000:00:1b.0: power state changed by ACPI to D3cold
> > > > 
> > > > When it wakes up from D3cold, according to the PCIe 4.0 section 5.8 the
> > > > PCIe switch is put to reset and its power is re-applied. This means that
> > > > we must follow the rules in PCIe 4.0 section 6.6.1.
> > > > 
> > > > For the PCIe gen3 ports we are dealing with here, the following applies:
> > > > 
> > > >   With a Downstream Port that supports Link speeds greater than 5.0
> > > >   GT/s, software must wait a minimum of 100 ms after Link training
> > > >   completes before sending a Configuration Request to the device
> > > >   immediately below that Port. Software can determine when Link training
> > > >   completes by polling the Data Link Layer Link Active bit or by setting
> > > >   up an associated interrupt (see Section 6.7.3.3).
> > > > 
> > > > Translating this into the above topology we would need to do this (DLLLA
> > > > stands for Data Link Layer Link Active):
> > > > 
> > > >   pcieport 0000:00:1b.0: wait for 100ms after DLLLA is set before access to 0000:01:00.0
> > > >   pcieport 0000:02:00.0: wait for 100ms after DLLLA is set before access to 0000:03:00.0
> > > >   pcieport 0000:02:02.0: wait for 100ms after DLLLA is set before access to 0000:37:00.0
> > > > 
> > > > I've instrumented the kernel with additional logging so we can see the
> > > > actual delays the kernel performs:
> > > > ...
> 
> > > >   xhci_hcd 0000:37:00.0: restoring config space at offset 0x10 (was 0x0, writing 0x73f00000)
> > > >   ...
> > > >   thunderbolt 0000:03:00.0: restoring config space at offset 0x14 (was 0x0, writing 0x8a040000)
> > > > 
> > > > This is even worse. None of the mandatory delays are performed. If this
> > > > would be S3 instead of s2idle then according to PCI FW spec 3.2 section
> > > > 4.6.8.  there is a specific _DSM that allows the OS to skip the delays
> > > > but this platform does not provide the _DSM and does not go to S3 anyway
> > > > so no firmware is involved that could already handle these delays.
> > > > 
> > > > In this particular Intel Coffee Lake platform these delays are not
> > > > actually needed because there is an additional delay as part of the ACPI
> > > > power resource that is used to turn on power to the hierarchy but since
> > > > that additional delay is not required by any of standards (PCIe, ACPI)
> > > 
> > > So it sounds like this Coffee Lake accidentally works because of
> > > unrelated firmware delay that's not actually required, or at least not
> > > related to the delay required by PCIe?
> > 
> > Correct. The root port ACPI Power Resource includes quite long delay
> > which allows the links to be trained before the _ON method is finished.
> > 
> > > I did notice that we don't implement all of _DSM function 9 and the
> > > parts we're missing look like they could be relevant.
> > 
> > AFAICT that _DSM is only for lowering the delays, not increasing them.
> > If the platform does not provide it the OS must adhere to all the timing
> > requirements of the PCIe spec (PCI FW 3.2 section 4.6.9). Here we are
> > actually trying to do just that :)
> 
> Yep, true.
> 
> > > > it is not present in the Intel Ice Lake, for example where missing the
> > > > mandatory delays causes pciehp to start tearing down the stack too early
> > > > (links are not yet trained).
> > > 
> > > I'm guessing the Coffee Lake/Ice Lake distinction is not really
> > > relevant and the important thing is that something about Ice Lake is
> > > faster and reduces the accidental delay to the point that things stop
> > > working.
> > > 
> > > So probably the same thing could happen on Coffee Lake or any other
> > > system if it had different firmware.
> > 
> > Indeed.
> 
> Thanks for confirming that.  I would probably abstract this somehow in
> the commit log so people don't have the impression that we're fixing
> something specific to Ice Lake.

OK.

> > > > There is also one reported case (see the bugzilla link below) where the
> > > > missing delay causes xHCI on a Titan Ridge controller fail to runtime
> > > > resume when USB-C dock is plugged.
> > > > 
> > > > For this reason, introduce a new function pcie_wait_downstream_accessible()
> > > > that is called on PCI core resume and runtime resume paths accordingly
> > > > if downstream/root port with device below entered D3cold.
> > > > 
> > > > This is second attempt to add the missing delays. The previous solution
> > > > in commit c2bf1fc212f7 ("PCI: Add missing link delays required by the
> > > > PCIe spec") was reverted because of two issues it caused:
> > > 
> > > c2bf1fc212f7 was merged for v5.3 (it appeared in v5.3-rc1).  I *guess*
> > > it addressed https://bugzilla.kernel.org/show_bug.cgi?id=203885, which
> > > was reported on v5.2-rc4, though c2bf1fc212f7 doesn't actually mention
> > > the bugzilla?
> > 
> > I think c2bf1fc212f7 was merged before I was aware of that bug (or I
> > just missed it).
> 
> Ah, so there's some other issue that prompted this patch in the first
> place.

Yes, the Ice Lake issue :)

> > > 0617bdede511 ("Revert "PCI: Add missing link delays required by the
> > > PCIe spec"") appeared in v5.3-rc4.  If c2bf1fc212f7 was supposed to
> > > address BZ 203885, I'm confused about why you asked Kai-Heng to test
> > > v5.3-rc4, where c2bf1fc212f7 had already been reverted.
> > 
> > I was hoping that the revert in v5.3-rc4 would help here as well but
> > after futher investigation it turned to be the exact opposite.
> > 
> > > Or maybe c2bf1fc212f7 wasn't connected with BZ 203885 in the first
> > > place?
> > > 
> > > The net result is that I think v5.3-rc4 is equivalent to v5.2 with
> > > respect to this issue.  It *is* a pretty serious usability issue, no
> > > question, but it's not completely obvious that this fix needs to be in
> > > v5.3 since it's not something we broke during the v5.3 merge window.
> > > So if we *do* want it in v5.3, we need to think about how to justify
> > > that, e.g., if this issue affects shipping systems that are likely to
> > > run an upstream kernel, etc.
> > 
> > I don't think it needs to be in v5.3. I was thinking more like v5.4 so
> > we get some more testing coverage.
> 
> Sounds good.
> 
> > > >   1. One system become unresponsive after S3 resume due to PME service
> > > >      spinning in pcie_pme_work_fn(). The root port in question reports
> > > >      that the xHCI sent PME but the xHCI device itself does not have PME
> > > >      status set. The PME status bit is never cleared in the root port
> > > >      resulting the indefinite loop in pcie_pme_work_fn().
> > > 
> > > I don't see the connection between PME and either c2bf1fc212f7 or this
> > > patch.  Is there a fix for this pcie_pme_work_fn() infinite loop?
> > 
> > No.
> > 
> > > I do see that BZ 203885 mentions a flood of "PME: Spurious native
> > > interrupt!" messages, but I don't see how we've fixed that.
> > 
> > It was not completely root caused yet. To me it looks like the root port
> > keeps the PME status and pending bits set and that causes
> > pcie_pme_work_fn() spin forever. From the debugging output logs I got
> > from Matthias, it is the xHCI that seems to send the PME but it does not
> > have PME status set for some reason.
> 
> I'm not sure what the value of mentioning this PME issue is.  If this
> patch happens to mask the PME issue, maybe it's worth a brief mention
> just to say "this patch masks but does not fix this problem".
> Otherwise it's a distraction.

OK.

> > > >   2. Slows down resume if the root/downstream port does not support
> > > >      Data Link Layer Active Reporting because pcie_wait_for_link_delay()
> > > >      waits 1100ms in that case.
> > > 
> > > I don't see the slowdown mentioned in BZ 203885; is there another link
> > > to these reports?
> > 
> > Nicholas for example reported it here:
> > 
> >   https://lore.kernel.org/linux-pci/SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM/
> > 
> > I should have added that link to the changelog.
> > 
> > > > This version should avoid the above issues because we restrict the delay
> > > > to happen only if the port went into D3cold (so it goes through reset)
> > > > and only when there is no firmware involved on resume path (so the
> > > > kernel is responsible for all the delays).
> > > > 
> > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203885
> > > > Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > ---
> > > > Hi all,
> > > > 
> > > > As the changelog says this is reworked version that tries to avoid reported
> > > > issues while at the same time fix the missing delays so we can get ICL
> > > > systems and at least the one system with Titan Ridge controller working
> > > > properly.
> > > > 
> > > > @Matthias, @Paul and @Nicholas: it would be great if you could try the
> > > > patch on top of v5.4-rc5+ and verify that it does not cause any issues on
> > > > your systems.
> > > > 
> > > >  drivers/pci/pci-driver.c |  19 ++++++
> > > >  drivers/pci/pci.c        | 127 ++++++++++++++++++++++++++++++++++++---
> > > >  drivers/pci/pci.h        |   1 +
> > > >  3 files changed, 137 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > index a8124e47bf6e..9aec78ed8907 100644
> > > > --- a/drivers/pci/pci-driver.c
> > > > +++ b/drivers/pci/pci-driver.c
> > > > @@ -918,6 +918,7 @@ static int pci_pm_resume_noirq(struct device *dev)
> > > >  {
> > > >  	struct pci_dev *pci_dev = to_pci_dev(dev);
> > > >  	struct device_driver *drv = dev->driver;
> > > > +	pci_power_t state = pci_dev->current_state;
> > > >  	int error = 0;
> > > >  
> > > >  	if (dev_pm_may_skip_resume(dev))
> > > > @@ -947,6 +948,15 @@ static int pci_pm_resume_noirq(struct device *dev)
> > > >  
> > > >  	pcie_pme_root_status_cleanup(pci_dev);
> > > >  
> > > > +	/*
> > > > +	 * If resume involves firmware assume it takes care of any delays
> > > > +	 * for now. For suspend-to-idle case we need to do that here before
> > > > +	 * resuming PCIe port services to keep pciehp from tearing down the
> > > > +	 * downstream devices too early.
> > > > +	 */
> > > > +	if (state == PCI_D3cold && pm_suspend_no_platform())
> > > > +		pcie_wait_downstream_accessible(pci_dev);
> > > 
> > > Aren't these paths used for Conventional PCI devices as well as PCIe
> > > devices?
> > 
> > Indeed they are.
> > 
> > > I think the D3cold and pm_suspend_no_platform() checks should move
> > > inside the new interface, whatever it's called.  I'm not sure what
> > > that means for the fact that you don't check pm_suspend_no_platform()
> > > in the runtime-resume path; maybe it needs a flag or something.
> > 
> > It is not needed for runtime-resume path since we are not entering
> > system suspend. For runtime-resume path we need to perform the delays
> > always.
> 
> >From the hardware device point of view, I don't think the
> system/runtime resume distinction is important.  The only thing the
> devices know is that they're changing from D3->D0, and it doesn't
> matter whether it's because of a runtime resume or an entire system
> resume.
> 
> > Here we just assume the firmware actually handles the delays which is
> > not entirely accurate. According to PCI FW 3.2 section 4.6.8 there is a
> > _DSM that the firmware can use to indicate to the OS that it can skip
> > the reset delays. So I think more correct would be to check for that in
> > resume path. However, since it looks like that _DSM is not implemented
> > in too many systems I've seen, it may slow down resume times
> > unnecessarily if the firmware actually handles the delays.
> > 
> > > But the "wait downstream" part seems a little too specific to be at
> > > the .resume_noirq and .runtime_resume level.
> > > 
> > > Do we descend the hierarchy and call .resume_noirq and .runtime_resume
> > > for the children of the bridge, too?
> > 
> > We do but at that time it is too late as we have already resumed pciehp
> > of the parent downstream port and it may have already started tearing
> > down the device stack below.
> > 
> > I'm open to any better ideas where this delay could be added, though :)
> 
> So we resume pciehp *before* we're finished resuming the Downstream
> Port?  That sounds wrong.

I mean once we resume the downstream port (the bridge) we also resume
"PCIe port services" including pciehp and only then descend to whatever
device is physically connected to that port.

> > > > +static int pcie_get_downstream_delay(struct pci_bus *bus)
> > > > +{
> > > > +	struct pci_dev *pdev;
> > > > +	int min_delay = 100;
> > > > +	int max_delay = 0;
> > > > +
> > > > +	list_for_each_entry(pdev, &bus->devices, bus_list) {
> > > > +		if (pdev->imm_ready)
> > > > +			min_delay = 0;
> > > > +		else if (pdev->d3cold_delay < min_delay)
> > > > +			min_delay = pdev->d3cold_delay;
> > > > +		if (pdev->d3cold_delay > max_delay)
> > > > +			max_delay = pdev->d3cold_delay;
> > > > +	}
> > > > +
> > > > +	return max(min_delay, max_delay);
> > > > +}
> 
> > > > + */
> > > > +void pcie_wait_downstream_accessible(struct pci_dev *pdev)
> 
> > > Do we need to observe the Trhfa requirements for Conventional PCI and
> > > PCI-X devices here?  If we don't do it here, where is it observed?
> > 
> > We probably should but I intented this to be PCIe specific since there
> > we have issues. For conventional PCI/PCI-X things "seem" to work and we
> > don't power manage those bridges anyway.
> > 
> > I'm not aware if Trhfa is handled in anywhere in the PCI stack
> > currently.
> 
> I think we should make this agnostic of the Conventional/PCIe
> difference if possible.  I assume we can tell if we're dealing with a
> D3->D0 transition and we only add delays in that case.  If we don't
> power manage Conventional PCI devices, I assume we won't see D3->D0
> transitions for runtime resume so there won't be any harm.
>
> Making it PCIe-specific seems like it adds extra code ("dev-is-PCIe
> checks") with no obvious reason for existence and an implicit
> dependency on the fact that we only power manage PCIe devices.  If we
> ever *did* support runtime power-management for Conventional PCI, we'd
> trip over that implicit dependency and probably debug this issue
> again.
> 
> But I guess it might slow down system resume for Conventional PCI
> devices.  If we rely on delays in firmware, I wonder if there's
> any point during resume where we could grab an early timestamp, then
> take another timestamp here and deduce that we've already delayed the
> difference?

That sounds rather complex, to be honest ;-)

According to PCI FW 3.2 the OS is responsible for those delays if the
platform firmware does not provide that _DSM. So simpler way would be
always do the delays if the _DSM is not there.

> > > > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
> > > > +	    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
> > > > +		return;
> > > > +
> > > > +	if (pci_dev_is_disconnected(pdev))
> > > > +		return;
> > > > +
> > > > +	if (!pdev->bridge_d3)
> > > > +		return;
> > > > +
> > > > +	bus = pdev->subordinate;
> > > > +	if (!bus)
> > > > +		return;
> > > > +
> > > > +	child = list_first_entry_or_null(&bus->devices, struct pci_dev,
> > > > +					 bus_list);
> > > > +	if (!child)
> > > > +		return;
> > > 
> > > I'm not convinced yet about skipping this if there's no subordinate
> > > bus or no children.  Don't we have to assume that the caller may
> > > immediately *probe* for children as soon as we return?
> > 
> > Yes, you are right. I was trying to avoid any unnecessary delays but
> > looks like we can't avoid them here.
> > 
> > > > +	delay = pcie_get_downstream_delay(bus);
> > > > +	if (!delay)
> > > > +		return;
> > > 
> > > I'm not sold on the idea that this delay depends on what's *below* the
> > > bridge.  We're using sec 6.6.1 to justify the delay, and that section
> > > doesn't say anything about downstream devices.
> > 
> > 6.6.1 indeed talks about Downstream Ports and devices immediately below
> > them.
> 
> Wait, I don't think we're reading this the same way.  6.6.1 mentions
> Downstream Ports: "With a Downstream Port that does not support Link
> speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> before sending a Configuration Request to the device immediately below
> that Port."
> 
> This says we have to delay before sending a config request to a device
> below a Downstream Port, but it doesn't say anything about the
> characteristics of that device.  In particular, I don't think it says
> the delay can be shortened if that device supports Immediate Readiness
> or implements a readiness _DSM.

Well it says this:

  To allow components to perform internal initialization, system software
  must wait a specified minimum period following the end of a Conventional
  Reset of one or more devices before it is permitted to issue
  Configuration Requests to those devices, unless Readiness Notifications
  mechanisms are used

My understanding of the above (might be wrong) is that Readiness
Notification can shorten the delay.

> I don't think this delay has anything to do with devices downstream
> from the Port.  I think this is about giving the Downstream Port time
> to bring up the link.  That way config requests may fail because
> there's no device below the Port or it's not ready yet, but they
> shouldn't fail simply because the link isn't up yet.

My understanding (again might be wrong) is that there are two factors
here. One is to get the link trained and the other is to give the
downstream device some time to perform its internal initialization so
that it is ready to answer config requests.

> > > If we call .resume_noirq/.runtime_resume for the downstream devices
> > > themselves, could we use d3cold_delay *there*?
> > 
> > Otherwise probably but since we already have resumed the downstream port
> > itself including pciehp it may notice that the link is not up anymore
> > and remove the device below.
> 
> I think this sounds like a problem with pciehp or the order in which
> we resume devices and portdrv services.

Well the order is from parent to children and in this case parent is the
PCIe downstream port including its port services. I'm not entirely sure
which order they get resumed but I think they are still resumed before
any of the children (probably depends on which order port services get
registered vs. the children gets enumerated).
