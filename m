Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4223FEC1DC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 12:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfKALaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 07:30:35 -0400
Received: from foss.arm.com ([217.140.110.172]:34206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfKALaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 07:30:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EB661FB;
        Fri,  1 Nov 2019 04:30:34 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C1653F6C4;
        Fri,  1 Nov 2019 04:30:33 -0700 (PDT)
Date:   Fri, 1 Nov 2019 11:30:31 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure
 pcie link
Message-ID: <20191101113031.GC9723@e119886-lin.cambridge.arm.com>
References: <20191031132228.GA44315@google.com>
 <33585725-51c7-6fe5-5d92-1e7fe77ca106@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33585725-51c7-6fe5-5d92-1e7fe77ca106@linux.intel.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 01, 2019 at 01:47:39PM +0800, Dilip Kota wrote:
> 
> On 10/31/2019 9:22 PM, Bjorn Helgaas wrote:
> > On Thu, Oct 31, 2019 at 06:47:10PM +0800, Dilip Kota wrote:
> > > On 10/31/2019 6:14 AM, Bjorn Helgaas wrote:
> > > > On Tue, Oct 29, 2019 at 05:31:18PM +0800, Dilip Kota wrote:
> > > > > On 10/22/2019 8:59 PM, Bjorn Helgaas wrote:
> > > > > > [+cc Rafael, linux-pm, beginning of discussion at
> > > > > > https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com]
> > > > > > 
> > > > > > On Tue, Oct 22, 2019 at 05:27:38PM +0800, Dilip Kota wrote:
> > > > > > > On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
> > > > > > > > On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
> > > > > > > > > On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> > > > > > > > > > PCIe RC driver on Intel Gateway SoCs have a requirement
> > > > > > > > > > of changing link width and speed on the fly.
> > > > > > > > Please add more details about why this is needed.  Since
> > > > > > > > you're adding sysfs files, it sounds like it's not
> > > > > > > > actually the *driver* that needs this; it's something in
> > > > > > > > userspace?
> > > > > > > We have use cases to change the link speed and width on the fly.
> > > > > > > One is EMI check and other is power saving.  Some battery backed
> > > > > > > applications have to switch PCIe link from higher GEN to GEN1 and
> > > > > > > width to x1. During the cases like external power supply got
> > > > > > > disconnected or broken. Once external power supply is connected then
> > > > > > > switch PCIe link to higher GEN and width.
> > > > > > That sounds plausible, but of course nothing there is specific to the
> > > > > > Intel Gateway, so we should implement this generically so it would
> > > > > > work on all hardware.
> > > > > Agree.
> > > > > > I'm not sure what the interface should look like -- should it be a
> > > > > > low-level interface as you propose where userspace would have to
> > > > > > identify each link of interest, or is there some system-wide
> > > > > > power/performance knob that could tune all links?  Cc'd Rafael and
> > > > > > linux-pm in case they have ideas.
> > > > > To my knowledge sysfs is the appropriate way to go.
> > > > > If there are any other best possible knobs, will be helpful.
> > > > I agree sysfs is the right place for it; my question was whether we
> > > > should have files like:
> > > > 
> > > >     /sys/.../0000:00:1f.3/pcie_speed
> > > >     /sys/.../0000:00:1f.3/pcie_width
> > > > 
> > > > as I think this patch would add (BTW, please include sample paths like
> > > > the above in the commit log), or whether there should be a more global
> > > > thing that would affect all the links in the system.
> > > Sure, i will add them.
> > > > I think the low-level files like you propose would be better because
> > > > one might want to tune link performance differently for different
> > > > types of devices and workloads.
> > > > 
> > > > We also have to decide if these files should be associated with the
> > > > device at the upstream or downstream end of the link.  For ASPM, the
> > > > current proposal [1] has the files at the downstream end on the theory
> > > > that the GPU, NIC, NVMe device, etc is the user-recognizable one.
> > > > Also, neither ASPM nor link speed/width make any sense unless there
> > > > *is* a device at the downstream end, so putting them there
> > > > automatically makes them visible only when they're useful.
> > > This patch places the speed and width in the host controller directory.
> > > /sys/.../xxx.pcie/pcie_speed
> > > /sys/.../xxx.pcie/pcie_width
> > > 
> > > I agree with you partially,  because i am having couple of points
> > > making me to keep speed and width change entries in controller
> > > directory:
> > > 
> > > -- For changing the speed/width with device node, software ends up
> > >     traversing to the controller from the device and do the
> > >     operations.
> > > -- Change speed and width are performed at controller level,
> > The controller is effectively a Root Complex, which may contain
> > several Root Ports.  I have the impression that the Synopsys
> > controller only supports a single Root Port, but that's just a detail
> > of the Synopsys implementation.  I think it should be possible to
> > configure the width/speed of each Root Port individually.
> > 
> > > -- Keeping speed and width in controller gives a perspective (to the
> > >     user) of changing them only once irrespective of no. of devices.
> > What if there's a switch?  If we change the width/speed of the link
> > between the Root Port and the Switch Upstream Port, that doesn't do
> > anything about the links from the Switch Downstream Ports.
> I missed to evaluate the multiple root port and switch scenarios, thanks for
> pointing it.
> Then, placing the link speed and width change entries in the device node
> will be appropriate.
> Software will traverse to the respective port or bus through the device node
> and does the changes.
> > 
> > > -- For speed and link change in Synopsys PCIe controller, specific
> > >     registers need to be configured.  This prevents or complicates
> > >     adding the speed and width change functionality in pci-sysfs or
> > >     pci framework.
> > Don't the Link Control and related registers in PCIe spec give us
> > enough control to manage the link width/speed of *all* links,
> > including those from Root Ports and Switch Downstream Ports?
> > 
> > If the Synopsys controller requires controller-specific registers,
> > that sounds to me like it doesn't quite conform to the spec.  Maybe
> > that means we would need some sort of quirk or controller callback?
> Yes, Synopsys has specific registers configuration for link width resizing
> and speed change.
> I will evaluate the possible mechanism for plugging in the controller
> specific changes to the framework.

According to the spec, "Software is permitted to restrict the maximum speed
of Link operation and set the perferred Link speed by setting the value in the
Target Link Speed field in the Upstream component." - This is the Link Control
2 Register, and a link retrain should then be triggered.

With regards to this proposed sysfs API - I wonder if this implies we should
also disable 'Hardware Autonomous Speed Disable' to prevent a link speed
change for device specific reasons?

In my view, this means we *can* have a sysfs control for limiting the link
speed using standard PCI means - though callbacks and quirks may be needed
for host bridge controllers and similar.

With regards to link width, I can't see any obvious software initiated means
to change the link width (they are all RO) - though a device can change its
own link width so long as it's 'Hardware Autonomous Width Disable' bit is
clear. So whilst there may be some benefit for the initial links of a few
host bridge controllers that may opt-in to some framework for this - such an
API wouldn't benefit the majority of links in a PCI fabric. Perhaps this
(width) should be DWC specific.

Thanks,

Andrew Murray

> 
> Regards,
> Dilip
> > 
> > Bjorn
