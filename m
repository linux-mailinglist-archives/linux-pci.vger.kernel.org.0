Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C53EAC6B
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 10:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfJaJNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 05:13:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47797 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfJaJNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Oct 2019 05:13:19 -0400
Received: from 91.217.168.176 (91.217.168.176) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 238fe852289c4eca; Thu, 31 Oct 2019 10:13:14 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        martin.blumenstingl@googlemail.com,
        Linux PCI <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Linux PM <linux-pm@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure pcie link
Date:   Thu, 31 Oct 2019 10:13:11 +0100
Message-ID: <5652130.irlrSN52DS@kreacher>
In-Reply-To: <20191031025637.GA25497@google.com>
References: <20191031025637.GA25497@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, October 31, 2019 3:56:37 AM CET Bjorn Helgaas wrote:
> On Thu, Oct 31, 2019 at 12:31:44AM +0100, Rafael J. Wysocki wrote:
> > On Wed, Oct 30, 2019 at 11:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc Heiner, Rajat]
> > >
> > > On Tue, Oct 29, 2019 at 05:31:18PM +0800, Dilip Kota wrote:
> > > > On 10/22/2019 8:59 PM, Bjorn Helgaas wrote:
> > > > > [+cc Rafael, linux-pm, beginning of discussion at
> > > > > https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com]
> > > > >
> > > > > On Tue, Oct 22, 2019 at 05:27:38PM +0800, Dilip Kota wrote:
> > > > > > On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
> > > > > > > On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
> > > > > > > > On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> > > > > > > > > PCIe RC driver on Intel Gateway SoCs have a requirement
> > > > > > > > > of changing link width and speed on the fly.
> > > > > > > Please add more details about why this is needed.  Since you're adding
> > > > > > > sysfs files, it sounds like it's not actually the *driver* that needs
> > > > > > > this; it's something in userspace?
> > > > > > We have use cases to change the link speed and width on the fly.
> > > > > > One is EMI check and other is power saving.  Some battery backed
> > > > > > applications have to switch PCIe link from higher GEN to GEN1 and
> > > > > > width to x1. During the cases like external power supply got
> > > > > > disconnected or broken. Once external power supply is connected then
> > > > > > switch PCIe link to higher GEN and width.
> > > > > That sounds plausible, but of course nothing there is specific to the
> > > > > Intel Gateway, so we should implement this generically so it would
> > > > > work on all hardware.
> > > > Agree.
> > > > >
> > > > > I'm not sure what the interface should look like -- should it be a
> > > > > low-level interface as you propose where userspace would have to
> > > > > identify each link of interest, or is there some system-wide
> > > > > power/performance knob that could tune all links?  Cc'd Rafael and
> > > > > linux-pm in case they have ideas.
> > > >
> > > > To my knowledge sysfs is the appropriate way to go.
> > > > If there are any other best possible knobs, will be helpful.
> > >
> > > I agree sysfs is the right place for it; my question was whether we
> > > should have files like:
> > >
> > >   /sys/.../0000:00:1f.3/pcie_speed
> > >   /sys/.../0000:00:1f.3/pcie_width
> > >
> > > as I think this patch would add (BTW, please include sample paths like
> > > the above in the commit log), or whether there should be a more global
> > > thing that would affect all the links in the system.
> > >
> > > I think the low-level files like you propose would be better because
> > > one might want to tune link performance differently for different
> > > types of devices and workloads.
> > >
> > > We also have to decide if these files should be associated with the
> > > device at the upstream or downstream end of the link.  For ASPM, the
> > > current proposal [1] has the files at the downstream end on the theory
> > > that the GPU, NIC, NVMe device, etc is the user-recognizable one.
> > > Also, neither ASPM nor link speed/width make any sense unless there
> > > *is* a device at the downstream end, so putting them there
> > > automatically makes them visible only when they're useful.
> > >
> > > Rafael had some concerns about the proposed ASPM interface [2], but I
> > > don't know what they are yet.
> > 
> > I was talking about the existing ASPM interface in sysfs.  The new one
> > I still have to review, but I'm kind of wondering what about people
> > who used the old one?  Would it be supported going forward?
> 
> The old one interface was enabled by CONFIG_PCIEASPM_DEBUG.  Red Hat
> doesn't enable that.  Ubuntu does.  I *thought* we heard from a
> Canonical person who said they didn't have any tools that used it, but
> I can't find that now.  I don't know about SUSE.
> 
> So the idea was to drop it on the theory that nobody is using it.
> Possibly that's too aggressive.

Well, one problem is that the "old" (actually existing) I/F has made it
to one of my OSS EU presentation slides (I did not talk to this particular
slide, but it is there in the deck that's available for downloading), so who
knows who is going to use it. :-)

So I guess that there's a risk that needs to be taken into consideration.

What could be done, in principle, would be to make the new I/F depend on
CONFIG_PCIEASPM_DEBUG being unset and provide the "old" one when it is set.

In any case, the pcie_aspm.policy module parameter cannot be dropped, because
AFAICS there is quite a bit of user space using it (e.g. TLP).

Cheers!



