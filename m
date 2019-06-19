Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA834BA42
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 15:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfFSNlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 09:41:03 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36406 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFSNlD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 09:41:03 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hdapd-0001rq-9z; Wed, 19 Jun 2019 15:40:57 +0200
Message-ID: <634be6de5fd29064bd41540a5d93d1756c06a980.camel@sipsolutions.net>
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if
 PCIe link is up
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-wireless@vger.kernel.org
Date:   Wed, 19 Jun 2019 15:40:54 +0200
In-Reply-To: <20190619133817.GA143205@google.com>
References: <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
         <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
         <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
         <20190613154250.GA32713@ulmo>
         <a523a19c-fdfa-01f7-6f6d-2ca367a10a50@nvidia.com>
         <20190617114745.GL508@ulmo> <20190617193024.GC13533@google.com>
         <a7e0472d-f4a7-ed63-836a-b5e8b1360645@nvidia.com>
         <20190618104918.GA28892@ulmo>
         <9c0fb01f0dc6a193265297eaa100a35ff25413e7.camel@sipsolutions.net>
         <20190619133817.GA143205@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-06-19 at 08:38 -0500, Bjorn Helgaas wrote:

> > > > > How does rfkill work?  It sounds like it completely removes
> > > > > power from the wifi device, putting it in D3cold.  Is there
> > > > > any software notification other than the "Slot present pin
> > > > > change" (which looks like a Tegra-specific thing)?
> > 
> > Well, they said above it's a GPIO that controls it, so the software
> > already knows and doesn't really need an event?
> 
> Forgive my ignorance about rfkill.  At least in this Tegra case, it
> sounds like rfkill basically controls a power switch for the entire
> device, i.e., it doesn't merely turn off the radio portion of the
> device; it puts the entire PCI device in D3cold.

Sort of. The actual (hardware) implementation seems a bit more
complicated than a "power switch", but yes, that's the effect of it.

> Is rfkill integrated with the power management subsystem?  E.g., when
> lspci or X tries to read config space via pci_read_config(), does the
> pci_config_pm_runtime_get() in that path wake up the device?

No, that's the problem at hand AFAICT.

> IMO, if the struct pci_dev exists, we should be able to rely on the
> device actually being accessible (possibly after bringing it back to
> D0).  If rfkill only turns off the radio, leaving the PCI interface
> active, that would be fine -- in that case generic PCI things like
> lspci would work normally and it would be up to the driver to manage
> network-related things.
> 
> But if rfkill turns off PCI interface and the power management
> subsystem can't wake it up, I think we should unbind the driver and
> remove the pci_dev, so it wouldn't appear in lspci at all.

Right. That's being suggested here, but since the platform has no actual
hardware hotplug, that needs to be implemented in software.

The question at hand is *how* to actually achieve that.

I'm kind of arguing that it's not rfkill that achieves it, but the
underlying GPIO that toggles the device, since that GPIO could also be
bound to something other than an rfkill-gpio instance.

johannes

