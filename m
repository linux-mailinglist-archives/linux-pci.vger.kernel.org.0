Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5B41040B1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfKTQXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 11:23:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:35003 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbfKTQXM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 11:23:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 08:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="215851006"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 08:23:07 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Nov 2019 18:23:06 +0200
Date:   Wed, 20 Nov 2019 18:23:06 +0200
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191120162306.GM11621@lahna.fi.intel.com>
References: <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com>
 <20191120115127.GD11621@lahna.fi.intel.com>
 <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
 <20191120120913.GE11621@lahna.fi.intel.com>
 <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com>
 <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120155301.GL11621@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 05:53:07PM +0200, Mika Westerberg wrote:
> On Wed, Nov 20, 2019 at 04:37:14PM +0100, Karol Herbst wrote:
> > On Wed, Nov 20, 2019 at 4:15 PM Mika Westerberg
> > <mika.westerberg@intel.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 01:11:52PM +0100, Karol Herbst wrote:
> > > > On Wed, Nov 20, 2019 at 1:09 PM Mika Westerberg
> > > > <mika.westerberg@intel.com> wrote:
> > > > >
> > > > > On Wed, Nov 20, 2019 at 12:58:00PM +0100, Karol Herbst wrote:
> > > > > > overall, what I really want to know is, _why_ does it work on windows?
> > > > >
> > > > > So do I ;-)
> > > > >
> > > > > > Or what are we doing differently on Linux so that it doesn't work? If
> > > > > > anybody has any idea on how we could dig into this and figure it out
> > > > > > on this level, this would probably allow us to get closer to the root
> > > > > > cause? no?
> > > > >
> > > > > Have you tried to use the acpi_rev_override parameter in your system and
> > > > > does it have any effect?
> > > > >
> > > > > Also did you try to trace the ACPI _ON/_OFF() methods? I think that
> > > > > should hopefully reveal something.
> > > > >
> > > >
> > > > I think I did in the past and it seemed to have worked, there is just
> > > > one big issue with this: it's a Dell specific workaround afaik, and
> > > > this issue plagues not just Dell, but we've seen it on HP and Lenovo
> > > > laptops as well, and I've heard about users having the same issues on
> > > > Asus and MSI laptops as well.
> > >
> > > Maybe it is not a workaround at all but instead it simply determines
> > > whether the system supports RTD3 or something like that (IIRC Windows 8
> > > started supporting it). Maybe Dell added check for Linux because at that
> > > time Linux did not support it.
> > >
> > 
> > the point is, it's not checking it by default, so by default you still
> > run into the windows 8 codepath.
> 
> Well you can add the quirk to acpi_rev_dmi_table[] so it goes to that
> path by default. There are a bunch of similar entries for Dell machines.
> 
> Of course this does not help the non-Dell users so we would still need
> to figure out the root cause.

I think I asked you to test the PCIe delay patch and it did not help but
I wonder if it helps if we increase the delay. As an experiment could
you try Bjorn's pci/pm branch. The last two commits are for the delay.

If you could pull that branch and apply the following patch on top and
give it a try? Then post the dmesg somewhere so we can see whether it
did the delay at all.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1f319b1175da..1ad6f1372ed5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4697,12 +4697,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 		return;
 	}
 
-	/* Take d3cold_delay requirements into account */
-	delay = pci_bus_max_d3cold_delay(dev->subordinate);
-	if (!delay) {
-		up_read(&pci_bus_sem);
-		return;
-	}
+	delay = 500;
 
 	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
 				 bus_list);
@@ -4715,7 +4710,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	 * management for them (see pci_bridge_d3_possible()).
 	 */
 	if (!pci_is_pcie(dev)) {
-		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
+		pci_info(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
 		msleep(1000 + delay);
 		return;
 	}
@@ -4741,10 +4736,10 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 		return;
 
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
-		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
+		pci_info(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
 	} else {
-		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
+		pci_info(dev, "waiting %d ms for downstream link, after activation\n",
 			delay);
 		if (!pcie_wait_for_link_delay(dev, true, delay)) {
 			/* Did not train, no need to wait any further */
@@ -4753,7 +4748,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	}
 
 	if (!pci_device_is_present(child)) {
-		pci_dbg(child, "waiting additional %d ms to become accessible\n", delay);
+		pci_info(child, "waiting additional %d ms to become accessible\n", delay);
 		msleep(delay);
 	}
 }
