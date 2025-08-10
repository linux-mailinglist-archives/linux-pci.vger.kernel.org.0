Return-Path: <linux-pci+bounces-33674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB12FB1F9BB
	for <lists+linux-pci@lfdr.de>; Sun, 10 Aug 2025 13:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EC61892D40
	for <lists+linux-pci@lfdr.de>; Sun, 10 Aug 2025 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5B32459C5;
	Sun, 10 Aug 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3ldmR6f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7F1C4A13;
	Sun, 10 Aug 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754824009; cv=none; b=sSBMqWL7GCpJQnCnZW3QP6E74r7CVFFMZoajK0OCjKXVKdVoU2DQ+MApPw7VO8WCprSlaOWfZCOhZuXaKqXHeZ/UbEv0d8eoICJFQDIYjEJveY8mW6eDz6+FS+o3L4OjA/Xfi1ND0rNtSAfr66rn6r6KrN4vHzmAwFs3EDpuXbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754824009; c=relaxed/simple;
	bh=9maBNkiuwlrcxYeu/AEyNGMWk1F+1sEZ7rZxR+lOdNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWpVT0pPYWLgeZ2jeuq9y95FkP+l+NGCAtemkUhRXCuCEc2729IWDe+4KZ82AOUwBzkLce8XFMBlrUogU1X6R+bjE58Ozc1GOzzYjs35ItXhhus+1fKc0G2AbO1rZO0STB8sYGdqK+sT4XSasCWfcGwJcmHq7Rupyt4pplpKJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3ldmR6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134E8C4CEEB;
	Sun, 10 Aug 2025 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754824008;
	bh=9maBNkiuwlrcxYeu/AEyNGMWk1F+1sEZ7rZxR+lOdNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3ldmR6fq4AW898c4xoGo+kyytFMXIXw/VUvE11e2GIERHQ7mGs6uZho+OdHjY7gS
	 +08/BZKvrVT3tO3VspMRqqNQZZx+imJxpZWWCg/iiartxCTdBz6k5TxiOBW5hw0qif
	 fqMLufG8FGawT2OWCWoAvhL3bpK5xD0HOxTC4/Xmi2ZgcNcSzcZsh17YRa94SSZBOb
	 WgXQpO8PneVdK4yOXJRO2BLODWefHEWyNkBuJ/3bLpJE9HSKxkuGS+jtPDYabDeCsR
	 RRBwz1hz40m8a8z5oV5KrYOV7/EKqaqO6JuuHuL/PscIP85M2r08O0isWxqy40z+4F
	 iWLp4+v44TM0w==
Date: Sun, 10 Aug 2025 16:36:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: David Box <david.e.box@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, bhelgaas@google.com, 
	vicamo.yang@canonical.com, kenny@panix.com, ilpo.jarvinen@linux.intel.com, 
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Allow controller drivers to override default
 ASPM and CLKPM link state
Message-ID: <2rj6w6x4thwvpc3pubpxbkcxvaqlyiqoemm7olgq2oq7ieysp4@3dk4pp66y4sx>
References: <20250720190140.2639200-1-david.e.box@linux.intel.com>
 <c6757u3xdyxxuodcjsbpdje7m4qiq26tug5lfxvpbs5wm7r56l@ksy4yge7kg35>
 <CAJZ5v0jZrPyW9+Ccoo955Y4oje2SiAQA9aCChAoPgM28SJqf5g@mail.gmail.com>
 <arotuyooaoo6ustmp5gnoj64pkpyvcc3plekh4yt46siuemlik@sv6tjxnggznx>
 <CAJZ5v0hDEX_ZMiAZU-PwriCpURiw04f=JLAVwP9UJ54wv3HBEg@mail.gmail.com>
 <scajymgengcxt6e4ekl53hteig4mgu34wwif2r737xvtcdghg4@ej4qn2rbcxzg>
 <fiuyebro52meyyri2qamj3h2eijjebl3uhgnalo7wwjholwml7@rgpmcegwjxid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fiuyebro52meyyri2qamj3h2eijjebl3uhgnalo7wwjholwml7@rgpmcegwjxid>

On Thu, Jul 24, 2025 at 12:08:03PM GMT, David Box wrote:
> On Thu, Jul 24, 2025 at 10:18:47PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jul 24, 2025 at 11:58:40AM GMT, Rafael J. Wysocki wrote:
> > > On Wed, Jul 23, 2025 at 11:27 PM David Box <david.e.box@linux.intel.com> wrote:
> > > >
> > > > On Wed, Jul 23, 2025 at 01:54:41PM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, Jul 21, 2025 at 10:24 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, Jul 20, 2025 at 12:01:37PM GMT, David E. Box wrote:
> > > > > > > Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> > > > > > > visible to firmware and do not receive BIOS-provided default ASPM and CLKPM
> > > > > > > configuration. As a result, devices behind such domains operate without
> > > > > > > proper power management, regardless of platform intent.
> > > > > > >
> > > > > > > To address this, allow controller drivers to supply an override for the
> > > > > > > default link state by setting aspm_dflt_link_state for their associated
> > > > > > > pci_host_bridge. During link initialization, if this field is non-zero,
> > > > > > > ASPM and CLKPM defaults are derived from its value instead of being taken
> > > > > > > from BIOS.
> > > > > > >
> > > > > > > This mechanism enables drivers like VMD to achieve platform-aligned power
> > > > > > > savings by statically defining the expected link configuration at
> > > > > > > enumeration time, without relying on runtime calls such as
> > > > > > > pci_enable_link_state(), which are ineffective when ASPM is disabled
> > > > > > > globally.
> > > > > > >
> > > > > > > This approach avoids per-controller hacks in ASPM core logic and provides a
> > > > > > > general mechanism for domains that require explicit control over link power
> > > > > > > state defaults.
> > > > > > >
> > > > > > > Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611cef@panix.com
> > > > > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes from RFC:
> > > > > > >
> > > > > > >   -- Rename field to aspm_dflt_link_state since it stores
> > > > > > >      PCIE_LINK_STATE_XXX flags, not a policy enum.
> > > > > > >   -- Move the field to struct pci_host_bridge since it's being applied to
> > > > > > >      the entire host bridge per Mani's suggestion.
> > > > > > >   -- During testing noticed that clkpm remained disabled and this was
> > > > > > >      also handled by the formerly used pci_enable_link_state(). Add a
> > > > > > >      check in pcie_clkpm_cap_init() as well to enable clkpm during init.
> > > > > > >
> > > > > > >  drivers/pci/controller/vmd.c | 12 +++++++++---
> > > > > > >  drivers/pci/pcie/aspm.c      | 13 +++++++++++--
> > > > > > >  include/linux/pci.h          |  4 ++++
> > > > > > >  3 files changed, 24 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > > > > > index 8df064b62a2f..6f0de95c87fd 100644
> > > > > > > --- a/drivers/pci/controller/vmd.c
> > > > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > > > @@ -730,7 +730,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> > > > > > >  }
> > > > > > >
> > > > > > >  /*
> > > > > > > - * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> > > > > > > + * Enable LTR settings on devices that aren't configured by BIOS.
> > > > > > >   */
> > > > > > >  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > > > > > >  {
> > > > > > > @@ -770,7 +770,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > > > > > >        * PCIe r6.0, sec 5.5.4.
> > > > > > >        */
> > > > > > >       pci_set_power_state_locked(pdev, PCI_D0);
> > > > > >
> > > > > > This call becomes useless now.
> > > >
> > > > Missed this. I'll remove it.
> > > >
> > > > > >
> > > > > > > -     pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -785,6 +784,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > > > > >       resource_size_t membar2_offset = 0x2000;
> > > > > > >       struct pci_bus *child;
> > > > > > >       struct pci_dev *dev;
> > > > > > > +     struct pci_host_bridge *vmd_host_bridge;
> > > > > > >       int ret;
> > > > > > >
> > > > > > >       /*
> > > > > > > @@ -911,8 +911,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > > > > >               return -ENODEV;
> > > > > > >       }
> > > > > > >
> > > > > > > +     vmd_host_bridge = to_pci_host_bridge(vmd->bus->bridge);
> > > > > > > +
> > > > > > > +#ifdef CONFIG_PCIEASPM
> > > > > > > +     vmd_host_bridge->aspm_dflt_link_state = PCIE_LINK_STATE_ALL;
> > > > > > > +#endif
> > > > > >
> > > > > > I think it is better to provide an API that accepts the link state. We can
> > > > > > provide a stub if CONFIG_PCIEASPM is not selected. This will avoid the ifdef
> > > > > > clutter in the callers. Like:
> > > > > >
> > > > > > void pci_set_default_link_state(struct pci_host_bridge *host_bridge,
> > > > > >                                 unsigned int state)
> > > > > > {
> > > > > > #ifdef CONFIG_PCIEASPM
> > > > > >          host_bridge->aspm_default_link_state = state;
> > > > > > #endif
> > > > > > }
> > > > > >
> > > > > > Or you can stub the entire function to align with other ASPM APIs.
> > > > > >
> > > > > > One more thought: Since this API is only going to be called by the host bridge
> > > > > > drivers, we can place it in drivers/pci/controller/pci-host-common.c and name it
> > > > > > as pci_host_common_set_default_link_state().
> > > >
> > > > This would require VMD to select PCI_HOST_COMMON just to set one field in a
> > > > common struct. Seems heavy-handed. Thoughts? Also, with this and dropping the D0
> > > > call, I'll split the VMD cleanup into a separate patch again.
> > > 
> > > So maybe define a __weak pci_host_set_default_pcie_link_state() doing
> > > nothing in the ASPM core and let VMD override it with its own
> > > implementation?
> > > 
> > 
> > No. There are other controller drivers (like pcie-qcom) going to use this API.
> > So please move it to the pci-host-common library as it should be.
> 
> I was going to suggest that it could simply stay in aspm.c.
> pci_enable_link_state_() is there and currently only used by controllers as
> well.
> 

OK!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

