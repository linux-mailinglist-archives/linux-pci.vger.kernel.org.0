Return-Path: <linux-pci+bounces-4679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C23387695E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 18:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8101F21A25
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC7282E1;
	Fri,  8 Mar 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvgArpE9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA22577B;
	Fri,  8 Mar 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917970; cv=none; b=EpvSXbFqtMQ9fQsTTmCE08oWKTVIH+at9/8A6za/S0rcHpwhmpCAVHRBhG/N1ElsI61RgPv7TFC8+Slt7zBFGFAErcf4o+4aQ0PMD6mkhD4aknKv/umfYLXTiPBeIZu4g2McicxnxfwGX/BneN8UMVLeaKR3hmxp9/f9/z8Oa3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917970; c=relaxed/simple;
	bh=o9jKbV+qWJZiyHs8Dp7ObPKvEvfHzfmkdKtij/tsuvs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eU9qP6wmrTsSCWuJ0AchaQUz6p9NuXEsTrIG8sMezz7910YxWBBNiBrOG2uiPhw/jNuOHGx/9nooNsjpWQxZg3Gx5Eyw7HdZBEQdNvQZ450W8uoDaFHQd70MTvQvWP/ZBDBVa17Sg1g9SHy52ZcjiSk8q0KNwJif99o9TGXOFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvgArpE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38169C433F1;
	Fri,  8 Mar 2024 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709917970;
	bh=o9jKbV+qWJZiyHs8Dp7ObPKvEvfHzfmkdKtij/tsuvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pvgArpE92csb1qHOBWR39XgQ2ALiSR8Kbr0FhcX6NGWhcrHPTNrC+4CFnnDLojmlb
	 400Xmok+nIyMft3aKrMvcz4rqgsQWsxONBwU0HzRAWoqaPOgjjWpLRd/MJHr89XyY7
	 slTA0Q9f/XlW5DggtE4T0ZZg8+auPJHQkQjDIxfJl5+yzyljkdr6krD3FdPl+Ebzhx
	 boyDwrWkmVtFewBhK122GkzKEf7zX9iznpTM26gvXsh4wBzim4+JDa+O4KU5ZQbB2I
	 un/euThlLtrnliBO4hw1B0VakjT13D/H+Azq1XgpZfTIsGLH5LkP/gJzWf24eYgFUr
	 dnqMaMHihV1hg==
Date: Fri, 8 Mar 2024 11:12:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v2] PCI: dwc: Enable runtime pm of the host bridge
Message-ID: <20240308171248.GA685266@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e83ed3e5-0c31-cfae-6f75-211709e79aa5@quicinc.com>

On Fri, Mar 08, 2024 at 08:38:52AM +0530, Krishna Chaitanya Chundru wrote:
> On 3/8/2024 3:25 AM, Bjorn Helgaas wrote:
> > [+to Rafael, sorry, another runtime PM question, beginning of thread:
> > https://lore.kernel.org/r/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com]
> > 
> > On Thu, Mar 07, 2024 at 07:28:54AM +0530, Krishna Chaitanya Chundru wrote:
> > > On 3/6/2024 1:27 AM, Bjorn Helgaas wrote:
> > > > On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
> > > > > The Controller driver is the parent device of the PCIe host bridge,
> > > > > PCI-PCI bridge and PCIe endpoint as shown below.
> > > > > 
> > > > > 	PCIe controller(Top level parent & parent of host bridge)
> > > > > 			|
> > > > > 			v
> > > > > 	PCIe Host bridge(Parent of PCI-PCI bridge)
> > > > > 			|
> > > > > 			v
> > > > > 	PCI-PCI bridge(Parent of endpoint driver)
> > > > > 			|
> > > > > 			v
> > > > > 		PCIe endpoint driver
> > > > > 
> > > > > Since runtime PM is disabled for host bridge, the state of the child
> > > > > devices under the host bridge is not taken into account by PM framework
> > > > > for the top level parent, PCIe controller. So PM framework, allows
> > > > > the controller driver to enter runtime PM irrespective of the state
> > > > > of the devices under the host bridge.
> > > > 
> > > > IIUC this says that we runtime suspend the controller even though
> > > > runtime PM is disabled for the host bridge?  I have a hard time
> > > > parsing this; can you cite a function that does this or some relevant
> > > > documentation about how this part of runtime PM works?
> > > > 
> > > Generally controller should go to runtime suspend when endpoint client
> > > drivers and pci-pci host bridge drivers goes to runtime suspend as the
> > > controller driver is the parent, but we are observing controller driver
> > > goes to runtime suspend even when client drivers and PCI-PCI bridge are
> > > in active state.
> > 
> > It surprises me that a device could be suspended while children are
> > active.  A PCI-PCI bridge must be in D0 for any devices below it to be
> > active.  The controller is a platform device, not a PCI device, but I
> > am similarly surprised that we would suspend it when children are
> > active, which makes me think we didn't set the hierarchy up correctly.
> > 
> > It doesn't seem like we should need to enable runtime PM for a parent
> > to keep it from being suspended when children are active.
>
> Here we are not enabling runtime PM of the controller device, we are
> enabling runtime PM for the bridge device which is maintained by the
> PCIe framework. The bridge device is the parent of the PCI-PCI
> bridge and child of the controller device. As the bridge device's
> runtime PM is not enabled the PM framework is ignoring the child's
> runtime status.

OK, it's the host bridge, not the controller.

I'm still surprised that the PM framework will runtime suspend a
device when child devices are active.

And further confused about managing the host bridge runtime PM in a
controller driver.  Which other callers of pci_alloc_host_bridge() or
devm_pci_alloc_host_bridge() will need similar changes?

> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -16,6 +16,7 @@
> > > > >   #include <linux/of_pci.h>
> > > > >   #include <linux/pci_regs.h>
> > > > >   #include <linux/platform_device.h>
> > > > > +#include <linux/pm_runtime.h>
> > > > > 
> > > > >   #include "../../pci.h"
> > > > >   #include "pcie-designware.h"
> > > > > @@ -505,6 +506,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > > >          if (pp->ops->post_init)
> > > > >                  pp->ops->post_init(pp);
> > > > > 
> > > > > +       pm_runtime_set_active(&bridge->dev);
> > > > > +       pm_runtime_enable(&bridge->dev);
> > > > > +
> > > > >          return 0;
> > > > > 
> > > > >   err_stop_link:

