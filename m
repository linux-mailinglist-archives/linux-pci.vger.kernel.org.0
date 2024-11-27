Return-Path: <linux-pci+bounces-17384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C819DA1D5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 06:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0582D280E17
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 05:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1689E13D516;
	Wed, 27 Nov 2024 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NoZxT77x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59D13B588
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686582; cv=none; b=Ea6Qz1o8cZYqj3YEw4dJGWByoKONlcmYds0JBrXhxXXUs+L+hklxMTLe4GzGvYIvLkTn60UGy4KfaSODkP1QuDLiRdNoKflxiV9mmtrFXUBV+lwcGORbkDi1DjDdBUedMdv+7vgE2zX+3QsuY/cFawNnVo7CV1TJ0OeEnP9/BO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686582; c=relaxed/simple;
	bh=UU2YqMgaojecVoB5+K8aIIWdsikDPxmSvA17wnu2Q00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXc9HCZ5bfWvwwRLOPAIP+BAkWhQ6gAFNXKTkPflL+xoiuWK4fHn9hLq4hpv7UpwuFLMxq0oKSO+ERuYinPCJqb1OIJStspuSyLf0dGZrtbYe62vAes7kLEdGEJgKBb7dfd8RiBQQ0rekrSXiyQTJ3/NhoJx1exS37BsmZqasRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NoZxT77x; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724f1ce1732so3004133b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 21:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732686579; x=1733291379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7OijkGc9t43pKOFifLDtLZS3bjZeB1kYn3D1cmE3MDM=;
        b=NoZxT77x6oMJFNpBL3JYmy2pheJryl6zG9qik0fy2dgiZpRsXDeBiVFMvuEynEK3Dl
         WeMIzfaIb6L5izt8nz+UQhwkpfG5w0W647Pm5MH/spHTeJRW+nSQ7vvfAFlb6W6iNzHw
         lDjGnqio8qjXgLis8xqQvkQxrpX5r2VdrO9g2QHye2/7fbxOm9hvAwgz9YWLS34qxpMl
         vM2h5Bp71z8W9fSy6suW5UQ/9D4cfmiY4Q/CplC8H6LeOj9UOL6zFi0ySy+4mG31JrYP
         Ak7Gl0Ux5RSkv5Y7BNQaKcT80/1lhviA22l2c+ofiGWd2pSCqPocCDElQF55fjaogBzX
         8B4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732686579; x=1733291379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OijkGc9t43pKOFifLDtLZS3bjZeB1kYn3D1cmE3MDM=;
        b=IZfGntOtmHpgh+8ATYBoF8u2HtCQ26pUVg5XTIh8rf+FxgYiaIGowgl9FXjdQhKjI4
         juO5LoGvzqgXaa/RNUpay/My8g2wobK0zC1gmALxyMFTzT+EFn+TZLJrZJyETt/yDM2m
         g4COmEEVxb+yW64qxBGPU8xEEQ/622NwFYOjlGOiEdYyaz2E0JdBRMRsdowmIk1ESxQP
         GnrHjdqWi/6vklDb5ri28bl+99WomhV8zz2v6SOrdBRf+0Zz9qQ0y61DPKsBPLJ3xg50
         pbX5gmgvgxJ2Wn7jkMKrRFue/W0bCQiq9n9qEQJryW1Wm2AM52MKu31IoC3VBUhIkLZ0
         5uyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgndPGWjxF6MvugKP6CGDa4olF+pV/SJBcmCDlfLmHjW012U4GuOC1PGMgQ4umJg9MyonSQfYGS9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YysM1Uq11e2wusYJCYQs6To0yja7WVayEFkArwjRzdAYRgB8qxg
	Z4RBG83nL8eavfC0TFse07fpcOc7EllWGXTD+BanXliw6oQDIb+O7G03JMnLGw==
X-Gm-Gg: ASbGncvlezvFQtdg3SgSoueXwwBf/8/V0IoLBBqw4gHl5nPuvdsaN2ZqWZkSohM0YQK
	jRh7cMhmY//DSUDSEd/FduzcSSggKqiILcl9Hjf3YjAALHPMd+9+aGv9iGxDdA5N0v1MR7Ffwmc
	yZJ/MLuWPRqMk3GLYNpEmEy9Bhzcbs8L7Ge5N44fa52bKpeaOirYQEwEi/8NfdgJaU8U6OAySRy
	olWMFMeHS+1SC3z6z6181nZjD9ZWZ1+6NcXYr4QwHR3Gi8GpC1TZIdLHMTF
X-Google-Smtp-Source: AGHT+IFczRjEFE93AgEq4hJlwmfhnwAw0fnbiv9RRLxapdAANTc4eJxpreRJb4Ay/eM8ARb6SczqRQ==
X-Received: by 2002:a05:6a00:b47:b0:725:99f:9732 with SMTP id d2e1a72fcca58-72530041cd1mr2628285b3a.13.1732686579329;
        Tue, 26 Nov 2024 21:49:39 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532da6sm9688543b3a.105.2024.11.26.21.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:49:38 -0800 (PST)
Date: Wed, 27 Nov 2024 11:19:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241127054931.6crzyoq57g56rs3f@thinkpad>
References: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
 <20241122222050.GA2444028@bhelgaas>
 <20241123090113.semecglxaqjvlmzp@thinkpad>
 <2f4rkilknak7xj3lyv7jx2yi7qyuw72pjwy67tkouqcvjmyn7l@scmdo34xnkuj>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f4rkilknak7xj3lyv7jx2yi7qyuw72pjwy67tkouqcvjmyn7l@scmdo34xnkuj>

On Tue, Nov 26, 2024 at 11:11:38AM -0600, Bjorn Andersson wrote:
> On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> > + Ulf (also interested in this topic)
> > 
> > On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > > [+cc Rafael]
> > > 
> > > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > PCI core allows users to configure the D3Cold state for each PCI device
> > > > through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> > > > attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> > > > to allow/disallow the PCI devices to enter D3Cold during system suspend.
> > > >
> > > > So make use of this flag in the NVMe driver to shutdown the NVMe device
> > > > during system suspend if the user has allowed D3Cold for the device.
> > > > Existing checks in the NVMe driver decide whether to shut down the device
> > > > (based on platform/device limitations), so use this flag as the last resort
> > > > to keep the existing behavior.
> > > > 
> > > > The default behavior of the 'pci_dev:d3cold_allowed' flag is to allow
> > > > D3Cold and the users can disallow it through sysfs if they want.
> > > 
> > > What problem does this solve?  I guess there must be a case where
> > > suspend leaves NVMe in a higher power state than you want?
> > > 
> > 
> > Yeah, this is the case for all systems that doesn't fit into the existing checks
> > in the NVMe suspend path:
> > 
> > 1. ACPI based platforms
> > 2. Controller doesn't support NPSS (hardware issue/limitation)
> > 3. ASPM not enabled
> > 4. Devices/systems setting NVME_QUIRK_SIMPLE_SUSPEND flag
> > 
> > In my case, all the Qualcomm SoCs using Devicetree doesn't fall into the above
> > checks. Hence, they were not fully powered down during system suspend and always
> > in low power state. This means, I cannot achieve 'CX power collapse', a Qualcomm
> > specific SoC powered down state that consumes just enough power to wake up the
> > SoC. Since the controller driver keeps the PCI resource vote because of NVMe,
> > the firmware in the Qualcomm SoCs cannot put the SoC into above mentioned low
> > power state.
> > 
> 
> Per our previous discussions, I think we concluded that we have two
> cases:
> a) of_machine_is_compatible("qcom,sc8280xp")
> b) Everything else
> 
> In #a we have to power down NVMe as the link doesn't survive the CX
> collapse, is this your #2?. For #b it's primarily a policy decision
> about the tradeoff between battery and flash life (and in some cases, as
> already seen in the nvme driver, some device-specific policy).
> 

With this proposed usage of the 'd3cold_allowed' sysfs attribute, all devices
will enter D3Cold by default, unless overridden by userspace. So #a will be
covered by default, and #b is left to userspace.

> > > What does it mean that this is the "last resort to keep the existing
> > > behavior"?  All the checks are OR'd together and none have side
> > > effects, so the order doesn't really matter.  It changes the existing
> > > behavior *unless* the user has explicitly cleared d3cold_allowed via
> > > sysfs.
> > > 
> > 
> > Since the checks are ORed, this new check is not going to change the existing
> > behavior for systems satisfying above checks i.e., even if the user changes the
> > flag to forbid D3Cold, it won't affect them and it *shoudn't*.
> > 
> > > pdev->d3cold_allowed is set by default, so I guess this change means
> > > that unless the user clears d3cold_allowed, we let the PCI core decide
> > > the suspend state instead of managing it directly in nvme_suspend()?
> > > 
> > 
> > If 'pdev->d3cold_allowed' is set, then NVMe driver will shutdown the device and
> > the PCI controller driver can turn off all bus specific resources. Otherwise,
> > NVMe driver will put the device into low power mode and the controller driver
> > has to do something similar to retain the device power.
> > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/nvme/host/pci.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > index 4b9fda0b1d9a..a4d4687854bf 100644
> > > > --- a/drivers/nvme/host/pci.c
> > > > +++ b/drivers/nvme/host/pci.c
> > > > @@ -3287,7 +3287,8 @@ static int nvme_suspend(struct device *dev)
> > > >  	 */
> > > >  	if (pm_suspend_via_firmware() || !ctrl->npss ||
> > > >  	    !pcie_aspm_enabled(pdev) ||
> > > > -	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
> > > > +	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND) ||
> > > > +	    pdev->d3cold_allowed)
> > > >  		return nvme_disable_prepare_reset(ndev, true);
> > > 
> > > I guess your intent is that if users prevent use of D3cold via sysfs,
> > > we'll use the NVMe-specific power states, and otherwise, the PCI core
> > > will decide?
> > > 
> > 
> > Not PCI core, but the controller drivers actually which takes care of powering
> > down the PCI bus resources.
> > 
> > > I think returning 0 here means the PCI core decides what state to use
> > > in the pci_pm_suspend_noirq() -> pci_prepare_to_sleep() path.  This
> > > could be any state from D0 to D3cold depending on platform support and
> > > wakeup considerations (see pci_target_state()).
> > > 
> > > I'm not sure the use of pdev->d3cold_allowed here really expresses
> > > your underlying intent.  It suggests that you're really hoping for
> > > D3cold, but that's only a possibility if firmware supports it, and we
> > > have no visibility into that here.
> > > 
> > 
> > I'm not relying on firmware to do anything here. If firmware has to decide the
> > suspend state, it should already satisfy the pm_suspend_via_firmware() check in
> > nvme_suspend(). Here, the controller driver takes care of putting the device
> > into D3Cold. Currently, the controller drivers cannot do it (on DT platforms)
> > because of NVMe driver's behavior.
> > 
> > > It also seems contrary to the earlier comment that suggests we prefer
> > > host managed nvme power settings:
> > > 
> > >   * The platform does not remove power for a kernel managed suspend so
> > >   * use host managed nvme power settings for lowest idle power if
> > >   * possible. This should have quicker resume latency than a full device
> > >   * shutdown.  But if the firmware is involved after the suspend or the
> > >   * device does not support any non-default power states, shut down the
> > >   * device fully.
> > 
> > This above comment satisfies the ACPI platforms as the firmware controls the
> > suspend state. On DT platforms, even though the firmware takes care of suspend
> > state, it still relies on the controller driver to relinquish the votes for PCI
> > resources. Only then, the firmware will put the whole SoC in power down mode
> > a.k.a CX power collapse mode in Qcom SoCs.
> > 
> > We did attempt so solve this problem in multiple ways, but the lesson learned
> > was, kernel cannot decide the power mode without help from userspace. That's the
> > reason I wanted to make use of this 'd3cold_allowed' sysfs attribute to allow
> > userspace to override the D3Cold if it wants based on platform requirement.
> > 
> 
> What do you mean "without help from userspace". Which entity in
> userspace is going to help make this decision?
> 

The entities controlling the similar UFS 'spm_lvl' attributes (Android userspace
is one such example). Right now, most of the platforms (not just Qcom) require
the PCIe devices to be powered down during system suspend. So no userspace
intervention is required. But if someone puts the same chipsets on Android
form factor devices, then they need to teach the Android userspace to control
this attribute similar to how it is done for UFS.

> > This is similar to how UFS allows users to configure power states of both the
> > device and controller:
> > 
> 
> "Allow users to configure" is an optimization, is the purpose of this
> patch to allow similar kind of optimization? Or is it supposed to allow
> userspace to help solve case #a above (hardware doesn't survive CX
> collapse)?
> 

Both as explained above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

