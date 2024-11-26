Return-Path: <linux-pci+bounces-17366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A36E9D9C23
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 18:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4A6282881
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09191DA0F1;
	Tue, 26 Nov 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIdjH9Oa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC91D9359;
	Tue, 26 Nov 2024 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641102; cv=none; b=NvtAorXVJ62zn+0Ehb9Scdl5I+wIaqWxnODHFYjjbahdEBavUtFWA2vTC0+oRWfAZpWQO6C13kLxbN1c5x3CCqY5w3gnA0Ia4FTCOwBcis94fODBcdJxhPNSHO+zadSdO+4sJx9BRKN4BBfuiODEM+xdJBPcdyLb1lAcAwdJuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641102; c=relaxed/simple;
	bh=PcWyXQgNPTpMoLNU/7rwlwC0Y2RIdPcU36jGw+tXhvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx5ntRVEl3kOWXDlPjXBnEN3u2gLCZfGmSpxe0JUD1ydmS2/ZFdHXDkLY/GjMJAh4fO25edpOaOsCMxR0fYnkShhmxT9zUTCZY9X+IqZNohe0E41rTwh2njr0m13oA7kd5Ab4V6i2JhutrTk/1fAhs9kkGqjCo0r7+faFIjdTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIdjH9Oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC16C4CECF;
	Tue, 26 Nov 2024 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641101;
	bh=PcWyXQgNPTpMoLNU/7rwlwC0Y2RIdPcU36jGw+tXhvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIdjH9OaRi0shA7i+cAtwv7v2jmcldjDS+yG/xQSXnM6ZyIyZun8z+SJ8W2XYDmsm
	 oC54KXATpGpV0uQo98hszHKQ1alp23grGwrWPPCyBj0DLka/Apzvlx8n+INMAwPUfC
	 NTWX7ZpsIcx9n1DjyM+9Oj1vVrMfDY4wRadJea/WiEy64457Sp4IYbAk7vReO5C+Xq
	 tjoeSoPcXpgFHu4PRHqUY6HYwAQU3HNrTtq5HCRhKlveTBBmTNyfoR9IrlWDN7vdew
	 FCKxPO9FcXwAxqHwIxGpVKLnQl4g6LVlnOHWzQSWJySTaG3ChV6r26sTSbuX2UmJwh
	 yPBpJGmg+Rceg==
Date: Tue, 26 Nov 2024 11:11:38 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk, 
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, konradybcio@kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <2f4rkilknak7xj3lyv7jx2yi7qyuw72pjwy67tkouqcvjmyn7l@scmdo34xnkuj>
References: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
 <20241122222050.GA2444028@bhelgaas>
 <20241123090113.semecglxaqjvlmzp@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241123090113.semecglxaqjvlmzp@thinkpad>

On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> + Ulf (also interested in this topic)
> 
> On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > [+cc Rafael]
> > 
> > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > PCI core allows users to configure the D3Cold state for each PCI device
> > > through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> > > attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> > > to allow/disallow the PCI devices to enter D3Cold during system suspend.
> > >
> > > So make use of this flag in the NVMe driver to shutdown the NVMe device
> > > during system suspend if the user has allowed D3Cold for the device.
> > > Existing checks in the NVMe driver decide whether to shut down the device
> > > (based on platform/device limitations), so use this flag as the last resort
> > > to keep the existing behavior.
> > > 
> > > The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
> > > D3Cold and the users can disallow it through sysfs if they want.
> > 
> > What problem does this solve?  I guess there must be a case where
> > suspend leaves NVMe in a higher power state than you want?
> > 
> 
> Yeah, this is the case for all systems that doesn't fit into the existing checks
> in the NVMe suspend path:
> 
> 1. ACPI based platforms
> 2. Controller doesn't support NPSS (hardware issue/limitation)
> 3. ASPM not enabled
> 4. Devices/systems setting NVME_QUIRK_SIMPLE_SUSPEND flag
> 
> In my case, all the Qualcomm SoCs using Devicetree doesn't fall into the above
> checks. Hence, they were not fully powered down during system suspend and always
> in low power state. This means, I cannot achieve 'CX power collapse', a Qualcomm
> specific SoC powered down state that consumes just enough power to wake up the
> SoC. Since the controller driver keeps the PCI resource vote because of NVMe,
> the firmware in the Qualcomm SoCs cannot put the SoC into above mentioned low
> power state.
> 

Per our previous discussions, I think we concluded that we have two
cases:
a) of_machine_is_compatible("qcom,sc8280xp")
b) Everything else

In #a we have to power down NVMe as the link doesn't survive the CX
collapse, is this your #2?. For #b it's primarily a policy decision
about the tradeoff between battery and flash life (and in some cases, as
already seen in the nvme driver, some device-specific policy).

> > What does it mean that this is the "last resort to keep the existing
> > behavior"?  All the checks are OR'd together and none have side
> > effects, so the order doesn't really matter.  It changes the existing
> > behavior *unless* the user has explicitly cleared d3cold_allowed via
> > sysfs.
> > 
> 
> Since the checks are ORed, this new check is not going to change the existing
> behavior for systems satisfying above checks i.e., even if the user changes the
> flag to forbid D3Cold, it won't affect them and it *shoudn't*.
> 
> > pdev->d3cold_allowed is set by default, so I guess this change means
> > that unless the user clears d3cold_allowed, we let the PCI core decide
> > the suspend state instead of managing it directly in nvme_suspend()?
> > 
> 
> If 'pdev->d3cold_allowed' is set, then NVMe driver will shutdown the device and
> the PCI controller driver can turn off all bus specific resources. Otherwise,
> NVMe driver will put the device into low power mode and the controller driver
> has to do something similar to retain the device power.
> 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/nvme/host/pci.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index 4b9fda0b1d9a..a4d4687854bf 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
> > >  	 */
> > >  	if (pm_suspend_via_firmware() || !ctrl->npss ||
> > >  	    !pcie_aspm_enabled(pdev) ||
> > > -	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> > > +	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
> > > +	    pdev->d3cold_allowed)
> > >  		return nvme_disable_prepare_reset(ndev, true);
> > 
> > I guess your intent is that if users prevent use of D3cold via sysfs,
> > we'll use the NVMe-specific power states, and otherwise, the PCI core
> > will decide?
> > 
> 
> Not PCI core, but the controller drivers actually which takes care of powering
> down the PCI bus resources.
> 
> > I think returning 0 here means the PCI core decides what state to use
> > in the pci_pm_suspend_noirq() -> pci_prepare_to_sleep() path.  This
> > could be any state from D0 to D3cold depending on platform support and
> > wakeup considerations (see pci_target_state()).
> > 
> > I'm not sure the use of pdev->d3cold_allowed here really expresses
> > your underlying intent.  It suggests that you're really hoping for
> > D3cold, but that's only a possibility if firmware supports it, and we
> > have no visibility into that here.
> > 
> 
> I'm not relying on firmware to do anything here. If firmware has to decide the
> suspend state, it should already satisfy the pm_suspend_via_firmware() check in
> nvme_suspend(). Here, the controller driver takes care of putting the device
> into D3Cold. Currently, the controller drivers cannot do it (on DT platforms)
> because of NVMe driver's behavior.
> 
> > It also seems contrary to the earlier comment that suggests we prefer
> > host managed nvme power settings:
> > 
> >   * The platform does not remove power for a kernel managed suspend so
> >   * use host managed nvme power settings for lowest idle power if
> >   * possible. This should have quicker resume latency than a full device
> >   * shutdown.  But if the firmware is involved after the suspend or the
> >   * device does not support any non-default power states, shut down the
> >   * device fully.
> 
> This above comment satisfies the ACPI platforms as the firmware controls the
> suspend state. On DT platforms, even though the firmware takes care of suspend
> state, it still relies on the controller driver to relinquish the votes for PCI
> resources. Only then, the firmware will put the whole SoC in power down mode
> a.k.a CX power collapse mode in Qcom SoCs.
> 
> We did attempt so solve this problem in multiple ways, but the lesson learned
> was, kernel cannot decide the power mode without help from userspace. That's the
> reason I wanted to make use of this 'd3cold_allowed' sysfs attribute to allow
> userspace to override the D3Cold if it wants based on platform requirement.
> 

What do you mean "without help from userspace". Which entity in
userspace is going to help make this decision?

> This is similar to how UFS allows users to configure power states of both the
> device and controller:
> 

"Allow users to configure" is an optimization, is the purpose of this
patch to allow similar kind of optimization? Or is it supposed to allow
userspace to help solve case #a above (hardware doesn't survive CX
collapse)?

Regards,
Bjorn

> /sys/bus/platform/drivers/ufshcd/*/spm_lvl
> /sys/bus/platform/devices/*.ufs/spm_lvl
> 
> If the 'd3cold_allowed' attribute is not a good fit for this usecase, then I'd
> like to introduce a new attribute similar to UFS.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

