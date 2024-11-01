Return-Path: <linux-pci+bounces-15821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E433D9B9ACC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 23:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40AB281C2D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 22:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8817115AAC1;
	Fri,  1 Nov 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0fIKdzB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79B1BDC3;
	Fri,  1 Nov 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499621; cv=none; b=R0s0ypIDbGqK5GpZfVunFwBSZ5apRz8UZGnaCpsMqwjnPJjmiF8USQ0um8LL7+Xb51Xdk2SAU1N4+ozhqhM8gUiY6/AU+VC1r0tWuOhZMISHGCXHNQ/kPG7KecHUZ62FMkvygM8JsqIR3alu4zQsLZ1+d7E+St4ejPu6urpeRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499621; c=relaxed/simple;
	bh=TeownOVZWoqsvK8YY1ymzssZK6V8djb/RJ4cWv30AtM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QlQIZv37qCCHB10SPdVTVpc4O20lp88coPoURgJCEzmISAIRkmI0+YdzeSMxDN7Pb912KucWOks6UCfIapMa/EAaEf2yvaePHL/+iEj5UbSUdzltg0A7rugWc6VLc/L1+YTjtMPK5DlZ/RutgMgzFxc8QUZj0cW3DkamG162N1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0fIKdzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00C7C4CECD;
	Fri,  1 Nov 2024 22:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730499620;
	bh=TeownOVZWoqsvK8YY1ymzssZK6V8djb/RJ4cWv30AtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a0fIKdzBKsJUVuDJ3XB77WDUYuLQVSdSqEKIdkpef/ZpWS9DvbPXamJLc0FePM+Wh
	 5p9sGYYV0I4/Zpok0ylq5RT6DMHdh8h4CQ+YF2lOLWdyWDT9rt2HZL2j9V+GindnM6
	 te4WSSF+bbonIkwrSCT2PQW9elDviFDCljk1FFmOQsP0vfEBbJBgec7Uj8NQod4aXU
	 7Zq65teX2wPPE3qBKh79cqe+YDyz13YqsrFAH/YcYg2VuNW4cKmrPbB6NuWS1wPDKj
	 IHD6r6n2HiqWAuvhH1sLbg7u6lscP6USDRkvyzoLLtl/vtD+tN6bnNSKTK1lHEovK4
	 8TECQbWWjbXfQ==
Date: Fri, 1 Nov 2024 17:20:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com, rafael@kernel.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <20241101222019.GA1318435@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f21ad43-294b-5ec0-4e92-c21d6b3cbe9a@quicinc.com>

On Fri, Nov 01, 2024 at 07:04:46AM +0530, Krishna Chaitanya Chundru wrote:
> On 10/29/2024 9:05 PM, Bjorn Helgaas wrote:
> > On Thu, Oct 17, 2024 at 09:05:51PM +0530, Krishna chaitanya chundru wrote:
> > > The Controller driver is the parent device of the PCIe host bridge,
> > > PCI-PCI bridge and PCIe endpoint as shown below.
> > > 
> > >          PCIe controller(Top level parent & parent of host bridge)
> > >                          |
> > >                          v
> > >          PCIe Host bridge(Parent of PCI-PCI bridge)
> > >                          |
> > >                          v
> > >          PCI-PCI bridge(Parent of endpoint driver)
> > >                          |
> > >                          v
> > >                  PCIe endpoint driver
> > > 
> > > Now, when the controller device goes to runtime suspend, PM framework
> > > will check the runtime PM state of the child device (host bridge) and
> > > will find it to be disabled. So it will allow the parent (controller
> > > device) to go to runtime suspend. Only if the child device's state was
> > > 'active' it will prevent the parent to get suspended.
> > > 
> > > It is a property of the runtime PM framework that it can only
> > > follow continuous dependency chains.  That is, if there is a device
> > > with runtime PM disabled in a dependency chain, runtime PM cannot be
> > > enabled for devices below it and above it in that chain both at the
> > > same time.
> > > 
> > > Since runtime PM is disabled for host bridge, the state of the child
> > > devices under the host bridge is not taken into account by PM framework
> > > for the top level parent, PCIe controller. So PM framework, allows
> > > the controller driver to enter runtime PM irrespective of the state
> > > of the devices under the host bridge. And this causes the topology
> > > breakage and also possible PM issues like controller driver goes to
> > > runtime suspend while endpoint driver is doing some transfers.
> > > 
> > > Because of the above, in order to enable runtime PM for a PCIe
> > > controller device, one needs to ensure that runtime PM is enabled for
> > > all devices in every dependency chain between it and any PCIe endpoint
> > > (as runtime PM is enabled for PCIe endpoints).
> > > 
> > > This means that runtime PM needs to be enabled for the host bridge
> > > device, which is present in all of these dependency chains.
> > 
> > Earlier I asked about how we can verify that no other drivers need a
> > change like the starfive one:
> > https://lore.kernel.org/r/20241012140852.GA603197@bhelgaas
> 
> I added those details in cover letter as you suggested to add them in
> cover letter.

Indeed I did suggest it for the cover letter, sorry for my confusion
at not finding it in the commit log.

I actually think we need something in the patch commit log itself,
since the cover letter doesn't make it into git.

And probably a comment in the code as well, since this seems to change
the requirements on the callers of pci_host_probe().

> "PM framework expectes parent runtime pm enabled before enabling runtime
> pm of the child. As PCIe starfive device is enabling runtime pm after
> the pci_host_probe which enables runtime pm of the child device i.e for
> the bridge device a warning is shown saying "pcie-starfive 940000000.pcie:
> Enabling runtime PM for inactive device with active children" and also
> shows possible circular locking dependency detected message.
> 
> As it is must to enable parent device's runtime PM before enabling child's
> runtime pm as the pcie-starfive device runtime pm is enabled after child
> runtime starfive device is seeing the warning.
> 
> In the first patch fix the pcie-starfive driver by enabling runtime
> pm before calling pci_host_probe().
> 
> All other PCIe controller drivers are enabling runtime pm before
> calling pci_host_probe() which is as expected so don't require any
> fix like pcie-starfive driver."

I'm sure that you looked at the following paths through
pci_host_common_probe(), which as far as I can tell, do not call
pm_runtime_enable() before pci_host_probe():

  apple_pcie_probe
    pci_host_common_probe
      pci_host_probe

  mc_host_probe
    pci_host_common_probe
      pci_host_probe

And the following use pci_host_common_probe() directly as their
.probe() method:

  gen_pci_driver in pci-host-common.c
  thunder_ecam_driver in pci-thunder-ecam.c
  thunder_pem_driver in pci-thunder-pem.c
  hisi_pcie_almost_ecam_driver in dwc/pcie-hisi.c
  
Are all these safe as well?  These all end up in pci_host_probe()
without having done anything to enable runtime PM on the
PCIe controller platform_device.

Looking at your diagram above, IIUC this patch enables runtime PM for
the PCIe host bridge, and the requirement is that runtime PM is
already enabled for the PCIe controller above it?

Is it always *possible* for that PCIe controller to enable runtime PM?
Might there exist PCIe controllers that cannot enable runtime PM
because they lack something in hardware or in the driver?

Maybe this patch should only enable runtime PM for the host bridge if
the controller already has runtime PM enabled?

> > I guess this sentence is basically how we verify all drivers are safe
> > with this change?
> > 
> > Since this patch adds devm_pm_runtime_enable() in pci_host_probe(),
> > can we expand this along the lines of this so it's more specific about
> > what we need to verify?
> > 
> >    Every host bridge driver must call pm_runtime_enable() before
> >    runtime PM is enabled by pci_host_probe().
> > 
> > Please correct me if that's not the right requirement.>
>
> yes this is correct requirement only. Do you want us to add this for
> this patch .

I would like to have a one-sentence statement of what the callers need
to do, including the actual function names.  Otherwise it's a pretty
big burden on reviewers to verify things.

> > > After this change, the host bridge device will be runtime-suspended
> > > by the runtime PM framework automatically after suspending its last
> > > child and it will be runtime-resumed automatically before resuming its
> > > first child which will allow the runtime PM framework to track
> > > dependencies between the host bridge device and all of its
> > > descendants.
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > > Changes in v6:
> > > - no change
> > > Changes in v5:
> > > - call pm_runtime_no_callbacks() as suggested by Rafael.
> > > - include the commit texts as suggested by Rafael.
> > > - Link to v4: https://lore.kernel.org/linux-pci/20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com/
> > > Changes in v4:
> > > - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
> > > - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
> > > Changes in v3:
> > > - Moved the runtime API call's from the dwc driver to PCI framework
> > >    as it is applicable for all (suggested by mani)
> > > - Updated the commit message.
> > > - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
> > > Changes in v2:
> > > - Updated commit message as suggested by mani.
> > > - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
> > > ---
> > >   drivers/pci/probe.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 4f68414c3086..8409e1dde0d1 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -3106,6 +3106,11 @@ int pci_host_probe(struct pci_host_bridge *bridge)
> > >   		pcie_bus_configure_settings(child);
> > >   	pci_bus_add_devices(bus);
> > > +
> > > +	pm_runtime_set_active(&bridge->dev);
> > > +	pm_runtime_no_callbacks(&bridge->dev);
> > > +	devm_pm_runtime_enable(&bridge->dev);
> > > +
> > >   	return 0;
> > >   }
> > >   EXPORT_SYMBOL_GPL(pci_host_probe);
> > > 
> > > -- 
> > > 2.34.1
> > > 

