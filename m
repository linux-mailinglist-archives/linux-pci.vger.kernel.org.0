Return-Path: <linux-pci+bounces-13737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCF498E609
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 00:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E038B1F234EF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C41195B1A;
	Wed,  2 Oct 2024 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH5HAFYS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5518F40;
	Wed,  2 Oct 2024 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907676; cv=none; b=nsIAd6/aVD2WAUTwaXVCDJ/yFmYRN5izRQfo+gBy5VJeNANp3UGdI55zh+KLbV7DWT1/l1eOTLNGZ3sBznRhIGsYAb1sNrU8g3/70GY7WqYCM6BimRm/9kYOvdgaGTVglwXeeSqOrIzmt7l7gFEHtpLg5KrdaRfe9ALacmQrC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907676; c=relaxed/simple;
	bh=2ig1PzUWmEcgn9cPbuVWyioLGw0sRPKOe2l6LdyKNF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NPe0E0JWAiu+4vBMaOCwBIgvLyrwjJ27aBii3zXtUkp2YrB+LZvx/sf5xRHOBpSr3MQE/OTaB2fe8h9WTm26EKQm6e37HGY/mDk6IUUckzREAb/8yQc9KMtgFNfumw4GjLGX+RQo/MSpnMa+0eyAb7wdMwiZv0E3a5Jh0EC8Ark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH5HAFYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC01C4CEC2;
	Wed,  2 Oct 2024 22:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727907676;
	bh=2ig1PzUWmEcgn9cPbuVWyioLGw0sRPKOe2l6LdyKNF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EH5HAFYSYxDNCK5w1hkNpl8+9zvqaWqV/RFYvKV9qbkTu8iADFRIZXMtOMCINW1PZ
	 Unj3kztg3Cbbxs/gMQAhvB3dn3oohfp6PC9DcdjsCvwRifgbwk6v7sIZAMNIAgk0iN
	 TCiF8bvrfwuPwIe7T096zW7UDWbcmzoGV/+sgzuRALoJnAaHkOH59VZ8+FHwgmPXxI
	 kWDsSmfyZUFhBulzzm1daWKhMmu6CuSvPwSHkxfdpMwpjNhP/et+mprjdXUsdIHDvw
	 2G/XHPGmIEMQPD89XTIX4foNyFgn2lSWhqNAuEALI5+AupMJJe9nipnb6DMlIYOuNP
	 z1RhP2V9w43Qg==
Date: Wed, 2 Oct 2024 17:21:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mayank Rana <quic_mrana@quicinc.com>,
	Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
Message-ID: <20241002222113.GA281995@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0506433c-62c5-e7c0-8c8a-55744a5e87d6@quicinc.com>

On Fri, Sep 27, 2024 at 09:26:51AM +0530, Krishna Chaitanya Chundru wrote:
> when you get time can you look into this.
> if there are no further concerns I will respin this patch.

None from me.  If Rafael thinks it's good, and your patch follows his
suggestions, we should be good to go.

> On 9/12/2024 9:00 PM, Rafael J. Wysocki wrote:
> > On Thu, Sep 12, 2024 at 2:13 PM Krishna Chaitanya Chundru
> > <quic_krichai@quicinc.com> wrote:
> > > 
> > > 
> > > 
> > > On 9/12/2024 5:27 PM, Rafael J. Wysocki wrote:
> > > > On Thu, Sep 12, 2024 at 1:52 PM Krishna Chaitanya Chundru
> > > > <quic_krichai@quicinc.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 9/12/2024 5:12 PM, Rafael J. Wysocki wrote:
> > > > > > On Fri, Aug 16, 2024 at 10:45 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > 
> > > > > > > [+cc Rafael, Mayank, Markus (when people have commented on previous
> > > > > > > versions, please cc them on new versions).  I'm still hoping Rafael
> > > > > > > will have a chance to chime in]
> > > > > > > 
> > > > > > > On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wrote:
> > > > > > > > The Controller driver is the parent device of the PCIe host bridge,
> > > > > > > > PCI-PCI bridge and PCIe endpoint as shown below.
> > > > > > > > 
> > > > > > > >            PCIe controller(Top level parent & parent of host bridge)
> > > > > > > >                            |
> > > > > > > >                            v
> > > > > > > >            PCIe Host bridge(Parent of PCI-PCI bridge)
> > > > > > > >                            |
> > > > > > > >                            v
> > > > > > > >            PCI-PCI bridge(Parent of endpoint driver)
> > > > > > > >                            |
> > > > > > > >                            v
> > > > > > > >                    PCIe endpoint driver
> > > > > > > > 
> > > > > > > > Now, when the controller device goes to runtime suspend, PM framework
> > > > > > > > will check the runtime PM state of the child device (host bridge) and
> > > > > > > > will find it to be disabled.
> > > > > > > 
> > > > > > > I guess "will find it to be disabled"  means the child (host bridge)
> > > > > > > has runtime PM disabled, not that the child device is disabled, right?
> > > > > > > 
> > > > > > > > So it will allow the parent (controller
> > > > > > > > device) to go to runtime suspend. Only if the child device's state was
> > > > > > > > 'active' it will prevent the parent to get suspended.
> > > > > > > 
> > > > > > > Can we include a hint like the name of the function where the PM
> > > > > > > framework decides this?  Maybe this is rpm_check_suspend_allowed()?
> > > > > > > 
> > > > > > > rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
> > > > > > > like it could be related, and AFAICS .ignore_children == false here,
> > > > > > > so .child_count should be relevant.
> > > > > > > 
> > > > > > > But I'm still confused about why we can runtime suspend a bridge that
> > > > > > > leads to devices that are not suspended.
> > > > > > 
> > > > > > That should only be possible if runtime PM is disabled for those devices.
> > > > > > 
> > > > > > > > Since runtime PM is disabled for host bridge, the state of the child
> > > > > > > > devices under the host bridge is not taken into account by PM framework
> > > > > > > > for the top level parent, PCIe controller. So PM framework, allows
> > > > > > > > the controller driver to enter runtime PM irrespective of the state
> > > > > > > > of the devices under the host bridge. And this causes the topology
> > > > > > > > breakage and also possible PM issues like controller driver goes to
> > > > > > > > runtime suspend while endpoint driver is doing some transfers.
> > > > > > 
> > > > > > Why is it a good idea to enable runtime PM for a PCIe controller?
> > > > > > 
> > > > > PCIe controller can do certain actions like keeping low power state,
> > > > > remove bandwidth votes etc as part of runtime suspend as when we know
> > > > > the client drivers already runtime suspended.
> > > > 
> > > > Surely they can, but enabling runtime PM for devices that have
> > > > children with runtime PM disabled and where those children have
> > > > children with runtime PM enabled is a bug.
> > > > 
> > > we are trying to enable the runtime PM of host bridge here, so that we
> > > can enable runtime PM of the controller.
> > 
> > So this is a preliminary step.  That was unclear to me.
> > 
> > > If this change got accepted the child here(host bridge) runtime pm will
> > > be enabled then i think there will no issue in enabling the runtime pm
> > > of the controller then.
> > > > > > > What does "topology breakage" mean?  Do you mean something other than
> > > > > > > the fact that an endpoint DMA might fail if the controller is
> > > > > > > suspended?
> > > > > > > 
> > > > > > > > So enable runtime PM for the host bridge, so that controller driver
> > > > > > > > goes to suspend only when all child devices goes to runtime suspend.
> > > > > > 
> > > > > > This by itself makes sense to me.
> > > > > > 
> > > > > > > IIUC, the one-sentence description here is that previously, the PCI
> > > > > > > host controller could be runtime suspended even while an endpoint was
> > > > > > > active, which caused DMA failures.  And this patch changes that so the
> > > > > > > host controller is only runtime suspended after the entire hierarchy
> > > > > > > below it is runtime suspended?  Is that right?
> > > > > > > 
> > > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > > ---
> > > > > > > > Changes in v4:
> > > > > > > 
> > > > > > > (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
> > > > > > > offset).
> > > > > > > 
> > > > > > > > - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
> > > > > > > > - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
> > > > > > > > Changes in v3:
> > > > > > > > - Moved the runtime API call's from the dwc driver to PCI framework
> > > > > > > >      as it is applicable for all (suggested by mani)
> > > > > > > > - Updated the commit message.
> > > > > > > > - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
> > > > > > > > Changes in v2:
> > > > > > > > - Updated commit message as suggested by mani.
> > > > > > > > - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
> > > > > > > > ---
> > > > > > > > 
> > > > > > > > ---
> > > > > > > >     drivers/pci/probe.c | 4 ++++
> > > > > > > >     1 file changed, 4 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > > > > > index 8e696e547565..fd49563a44d9 100644
> > > > > > > > --- a/drivers/pci/probe.c
> > > > > > > > +++ b/drivers/pci/probe.c
> > > > > > > > @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
> > > > > > > >          }
> > > > > > > > 
> > > > > > > >          pci_bus_add_devices(bus);
> > > > > > > > +
> > > > > > > > +     pm_runtime_set_active(&bridge->dev);
> > > > > > > > +     devm_pm_runtime_enable(&bridge->dev);
> > > > > > > > +
> > > > > > > >          return 0;
> > > > > > > >     }
> > > > > > > >     EXPORT_SYMBOL_GPL(pci_host_probe);
> > > > > > 
> > > > > > This will effectively prevent the host bridge from being
> > > > > > runtime-suspended at all IIUC, so the PCIe controller will never
> > > > > > suspend too after this change.
> > > > > > 
> > > > > No we are having a different observations here.
> > > > > Without this change the PCIe controller driver can go to runtime suspend
> > > > > without considering the state of the client drivers i.e even when the
> > > > > client drivers are active.
> > > > > After adding this change we see the pcie controller is getting runtime
> > > > > suspended only after the client drivers are runtime suspended which is
> > > > > the expected behaviour.
> > > > 
> > > > OK, but then when and how is it going to be resumed?
> > > 
> > > sorry I am not expert of the pm framework here, what we observed is when
> > > client drivers are trying to resume using runtime_get we see the
> > > controller driver is also getting resume properly with this change.
> > > let me dig in and see in code on how this is happening.
> > > 
> > > Bjorn has this view on this change in previous v2 version[1]
> > > "My expectation is that adding new functionality should only require
> > > changes in drivers that want to take advantage of it.  For example, if
> > > we add runtime PM support in the controller driver, the result should
> > > be functionally correct even if we don't update drivers for downstream
> > > devices.
> > > 
> > > If that's not the way it works, I suggest that would be a problem in
> > > the PM framework.
> > 
> > You can say so, but that's how it goes.
> > 
> > If there are any devices with runtime PM disabled in a dependency
> > chain, the runtime PM framework cannot follow that chain as a whole.
> > If enabling runtime PM for a device leads to this situation, it is not
> > correct.
> > 
> > > The host bridge might be a special case because we don't have a
> > > separate "host bridge" driver; that code is kind of integrated with
> > > the controller drivers.  So maybe it's OK to do controller + host
> > > bridge runtime PM support at the same time, as long as any time we add
> > > runtime PM to a controller, we sure it's also set up for the host
> > > bridge"
> > 
> > I think that you can enable runtime PM for host bridge devices in
> > general, as long as they don't need to be resumed without resuming any
> > of their children.
> > 
> > If that's the case, resuming one of its children will also cause the
> > host bridge to resume and all should be fine, although you also need
> > to ensure that system-wide suspend handling is in agreement with this.
> > 
> > I would suggest calling pm_runtime_no_callbacks() for the host bridge device.
> > 
> > > [1] https://lore.kernel.org/all/20240307215505.GA632869@bhelgaas/
> > 
> > And this is the information to put into your patch changelog:
> > 
> > 1. It is a property of the runtime PM framework that it can only
> > follow continuous dependency chains.  That is, if there is a device
> > with runtime PM disabled in a dependency chain, runtime PM cannot be
> > enabled for devices below it and above it in that chain both at the
> > same time.
> > 
> > 2. Because of the above, in order to enable runtime PM for a PCIe
> > controller device, one needs to ensure that runtime PM is enabled for
> > all devices in every dependency chain between it and any PCIe endpoint
> > (as runtime PM is enabled for PCIe endpoints).
> > 
> > 3. This means that runtime PM needs to be enabled for the host bridge
> > device, which is present in all of these dependency chains.
> > 
> > 4. After this change, the host bridge device will be runtime-suspended
> > by the runtime PM framework automatically after suspending its last
> > child and it will be runtime-resumed automatically before resuming its
> > first child which will allow the runtime PM framework to track
> > dependencies between the host bridge device and all of its
> > descendants.
> > 
> > Thanks!

