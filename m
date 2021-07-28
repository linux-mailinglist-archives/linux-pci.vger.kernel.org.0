Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC63D92AC
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 18:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhG1QBo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 12:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235688AbhG1QBn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 12:01:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C41DD6069E;
        Wed, 28 Jul 2021 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627488102;
        bh=QSUVnR2YLmegozBX4nvkQAaQOr41MNxZ+SpTU9xgWlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gB06TPBlj01rLTyvjFRKHWUxEUzZ4z001cXhKreQ1Hj8+vgiJBqurtKKsVQDaCfwZ
         64otTlWLD4c4/TuP8KZcFbzWRQoAUCL2OmNVZcrhF0MTofzlx8yFdIH+V1eofCpa/I
         mLbfZC0m+pfZFY9nj095PceyiyCUgm6bDP9IrVHKd4tmCQ4WyBQaulUBXNbDNcwNx5
         e+MISN4+bNXERhyjsJiG1Z85cC/5Pq0mQQ/HQeeTttf8SwKJHvpR1IggvxgecX2eBk
         OzHiTNCiwDHw7ymndof/o0i/6dvgrk7tICPc6lB/1Xxuq+hsnJnzDNyxX4/9WWcKUJ
         BJ93EKN9K3tpg==
Date:   Wed, 28 Jul 2021 11:01:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     hemantk@codeaurora.org, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, bjorn.andersson@linaro.org,
        linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Query on ASPM driver design
Message-ID: <20210728160140.GA823046@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfac041-9559-40a2-fc97-1dbe9c5295b1@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, driver-specific vs generic PM at very end]

On Wed, Jul 28, 2021 at 06:48:50AM +0530, Om Prakash Singh wrote:
> On 7/27/2021 8:48 PM, Bjorn Helgaas wrote:
> > On Tue, Jul 27, 2021 at 07:51:37AM +0530, Om Prakash Singh wrote:
> > > Hi Bjorn,
> > > I think it makes sense to have the scope of keeping default ASPM
> > > policy disable and API pci_enable_link_state() to selectively enable
> > > by EP Driver.
> > > 
> > > sysfs interface for ASPM also does not allow enabling ASPM for a
> > > device if the default policy (policy_to_aspm_state()) does not allow
> > > it.
> > 
> > The ASPM policy implementation may require changes.  I think the
> > current setup where a policy is compiled into the kernel via Kconfig
> > options is seriously flawed.
> > 
> > We need a fail-safe kernel parameter, i.e., "pcie_aspm=off", for cases
> > where devices don't work at all with ASPM.  We need quirks to work
> > around devices known to be broken, e.g., those that advertise ASPM
> > support that doesn't actually work, or those that advertise incorrect
> > exit latencies.  I think most other configuration should be done via
> > sysfs.
> > 
> > > Consider a situation, for a platform one wants to utilize ASPM
> > > capability of an onboard PCIe device because it is well evaluated,
> > > at the same time they want to keep ASPM disabled for other PCIe
> > > devices that can be connected on open PCIe slot to avoid possible
> > > performance issue.
> > > 
> > > I see ASPM is broken on many devices, though the device shows ASPM
> > > capabilities but has performance issues when it is enabled.
> > 
> > I'll wait to see your proposal and use case before commenting on this.
> 
> few suggestions:
> 
> 1. We can have a device-tree property to disable ASPM capabilities of a Root
> port. Corresponding to my example, the device-tree can use be use to enable
> ASPM capabilities of Root ports that have known/good/onboard PCIe device,
> and keep ASPM disabled for opens slots

ASPM can only be enabled for links between two devices.  For empty
slots, there's an upstream device (Root Port or Switch Downstream
Port) but no downstream device, so ASPM won't be enabled anyway.

> 2. sysfs should allow overriding default ASPM policy.
>    With below change system can boot with default policy ASPM disabled
> (performance). But sysfs will still allow to enable ASPM capability of
> selective device

This sounds like a good idea.  If we could get rid of the Kconfig ASPM
policy selection, we'd likely make PCIEASPM_POWER_SUPERSAVE the
default.  Then userspace could use sysfs to disable ASPM states
selective as necessary for performance.

Even before removing the Kconfig policy selection (or if we can't do
that), I think it make sense to allow sysfs to override it.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a08e7d6..268c2c5 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1278,7 +1278,7 @@
>  		link->aspm_disable |= state;
>  	}
> 
> -	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +	pcie_config_aspm_link(link, state);
> 
>  	mutex_unlock(&aspm_lock);
>  	up_read(&pci_bus_sem);
> 
> 3. Add API pci_enable_link_state()
>    This will give control to driver to change ASPM at runtime depending on
> user selected performance mode. For example Android has different
> performance modes for Wifi chip, for sleep and active state. We are using
> similar API to overcome some performance issue related to wifi on our
> internal platform.

I'd prefer to keep performance modes out of the drivers as much as
possible because that's not really a scalable approach.  I'm not a
power management expert, but I suspect the most maintainable approach
is to do this in the generic PM core, with selectable overrides via
sysfs as necessary.  I cc'd Rafael in case he wants to chime in.

Maybe there's a place for drivers to tweak ASPM at runtime, but I'm
not convinced yet.  I think the intent of ASPM is that devices
advertise exit latencies that correspond with their internal
buffering, so the L0s and L1 states can be used with no significant
performance impact.  But without more specifics, we can talk about
this all day without getting anywhere.

Bjorn
