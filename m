Return-Path: <linux-pci+bounces-14021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 697F1995A0C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E664CB2245D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32544215024;
	Tue,  8 Oct 2024 22:25:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2F14A82
	for <linux-pci@vger.kernel.org>; Tue,  8 Oct 2024 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728426332; cv=none; b=iUtj7pKqfk7THKHpuKBBdEV0+Dx2C1sigj5FrPy94sMqdKrRh2GP5gXZ6367pY4m54pacrwsGEQ5M1U4ZxTggfDI4PbAYpbSKXWTDjhmoUzDNtfaKaw3YL1+tu/sg2z7sqVRRjwYPWqrCo/huT5avCmVKGJJBv3CeB1w7za8YNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728426332; c=relaxed/simple;
	bh=kHfhJd2qaRTL7X3//fV3VBPCOCN35KK0vr6GRNP9Abc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo3d3L5AayzsEBiLFfM6oeef69vj3BnZriqu3NGdkKlvyaDCCO9Oei9ncIwnnep4ox7c7CtB2XXIket8XLuYsczLeHTHtoaEEhJZPnH2I43pa6oMgqu1dcqvzacbj8rWME5Y4ZQq3xrHe+FaEfvygH57gJdIQ5jOOM7ByCeE+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 2b2ae00a-85c4-11ef-a027-005056bdfda7;
	Wed, 09 Oct 2024 01:25:05 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 9 Oct 2024 01:25:05 +0300
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	manivannan.sadhasivam@linaro.org, Markus.Elfring@web.de,
	quic_mrana@quicinc.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com
Subject: Re: [PATCH v5] PCI: Enable runtime pm of the host bridge
Message-ID: <ZwWxQQgPSlVa3QH_@surfacebook.localdomain>
References: <20241003-runtime_pm-v5-1-3ebd1a395d45@quicinc.com>
 <20241003221033.GA327855@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003221033.GA327855@bhelgaas>

Thu, Oct 03, 2024 at 05:10:33PM -0500, Bjorn Helgaas kirjoitti:
> On Thu, Oct 03, 2024 at 11:32:32AM +0530, Krishna chaitanya chundru wrote:
> > The Controller driver is the parent device of the PCIe host bridge,
> > PCI-PCI bridge and PCIe endpoint as shown below.
> > 
> >         PCIe controller(Top level parent & parent of host bridge)
> >                         |
> >                         v
> >         PCIe Host bridge(Parent of PCI-PCI bridge)
> >                         |
> >                         v
> >         PCI-PCI bridge(Parent of endpoint driver)
> >                         |
> >                         v
> >                 PCIe endpoint driver
> > 
> > Now, when the controller device goes to runtime suspend, PM framework
> > will check the runtime PM state of the child device (host bridge) and
> > will find it to be disabled. So it will allow the parent (controller
> > device) to go to runtime suspend. Only if the child device's state was
> > 'active' it will prevent the parent to get suspended.
> > 
> > It is a property of the runtime PM framework that it can only
> > follow continuous dependency chains.  That is, if there is a device
> > with runtime PM disabled in a dependency chain, runtime PM cannot be
> > enabled for devices below it and above it in that chain both at the
> > same time.
> > 
> > Since runtime PM is disabled for host bridge, the state of the child
> > devices under the host bridge is not taken into account by PM framework
> > for the top level parent, PCIe controller. So PM framework, allows
> > the controller driver to enter runtime PM irrespective of the state
> > of the devices under the host bridge. And this causes the topology
> > breakage and also possible PM issues like controller driver goes to
> > runtime suspend while endpoint driver is doing some transfers.
> > 
> > Because of the above, in order to enable runtime PM for a PCIe
> > controller device, one needs to ensure that runtime PM is enabled for
> > all devices in every dependency chain between it and any PCIe endpoint
> > (as runtime PM is enabled for PCIe endpoints).
> > 
> > This means that runtime PM needs to be enabled for the host bridge
> > device, which is present in all of these dependency chains.
> > 
> > After this change, the host bridge device will be runtime-suspended
> > by the runtime PM framework automatically after suspending its last
> > child and it will be runtime-resumed automatically before resuming its
> > first child which will allow the runtime PM framework to track
> > dependencies between the host bridge device and all of its
> > descendants.
> 
> Applied to pci/pm for v6.13, thanks for your patience is working
> through this!

...

> > +	pm_runtime_set_active(&bridge->dev);
> > +	pm_runtime_no_callbacks(&bridge->dev);
> > +	devm_pm_runtime_enable(&bridge->dev);

So, potentially this might lead to a case where PM runtime is enabled and won't
be disabled on the bridge device removal. Is this a problem?

TL;DR:
I have found no explanations why error code from devm_*() call is being ignored.

> >  	return 0;


-- 
With Best Regards,
Andy Shevchenko



