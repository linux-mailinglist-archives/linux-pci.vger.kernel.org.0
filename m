Return-Path: <linux-pci+bounces-4624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E28759CB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 22:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6321F2200F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 21:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989D13B2BD;
	Thu,  7 Mar 2024 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ3YI9xs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542B964A9F;
	Thu,  7 Mar 2024 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848508; cv=none; b=K1Uciov/SIjBSGrDFZV8qltrGm4vOWKtPyTdRTAIUY1ODlbs1axcMxadUIzrfxHBouYf/pRvRDS87NLvPcZCSrXTC9GusoRzltSjNH9jCpxUjS4h8PrsFxXUmX1ipiAzW4IA14diXC/De6VQuiv7/i97xoUU+Kew6CXgBZGKXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848508; c=relaxed/simple;
	bh=ji+6eu2vEsL5PFLwf1Vo/c6h9m23l5VmdsuQsf6toAs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rwShnFvpOjGJlmI5pE/sFhPlWXvONCILfGWZEokvTPQQY9aLzakwuPz/S8KVoiIneSXmUc+OVQqozmluGPJ+j12cb7pWAI4nQENUol25v8HiLRMbRgefJPAtu1mD5X44445VepabiiJLlitEb5+2/kGV2+W1L6buPkV90QP1z5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ3YI9xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701E2C433F1;
	Thu,  7 Mar 2024 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709848507;
	bh=ji+6eu2vEsL5PFLwf1Vo/c6h9m23l5VmdsuQsf6toAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CJ3YI9xsKU7sTU3zQlSn2oj63JCFdICFfCu4TNCQHVuKukq+p+SsaPM3xC8i6r3nM
	 d+sCJm4NP3zGhuAXGeEg+3BBIB/RQqM/UcJ2A6/8eoWZC5iimleTgrVa9blhArQHk8
	 sX2GbmmE5VaPuNWo3Og88x/1+gSuTNWBzWgFTSCM1gbQ6i9xiZvmV3HauUD4hXsKIi
	 n1RK3Mqxfa5X5My8YvH4CfYqhxm68kNA3KW8mHZRs/Vn/KDu2n6YqQZ8o/7sTQfjp7
	 TDnsFI88QUrosv8esEw5Pe00YBCaNi7RpRv4JYlS1rnUH/VjmgnwRVmBhusuwld0Ii
	 0W2RJys2Yiq+A==
Date: Thu, 7 Mar 2024 15:55:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jingoo Han <jingoohan1@gmail.com>,
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
Message-ID: <20240307215505.GA632869@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be760502-446b-f4cc-776d-8751bdb75ff7@quicinc.com>

[+to Rafael, sorry, another runtime PM question, beginning of thread:
https://lore.kernel.org/r/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com]

On Thu, Mar 07, 2024 at 07:28:54AM +0530, Krishna Chaitanya Chundru wrote:
> On 3/6/2024 1:27 AM, Bjorn Helgaas wrote:
> > On Tue, Mar 05, 2024 at 03:19:01PM +0530, Krishna chaitanya chundru wrote:
> > > The Controller driver is the parent device of the PCIe host bridge,
> > > PCI-PCI bridge and PCIe endpoint as shown below.
> > >
> > > 	PCIe controller(Top level parent & parent of host bridge)
> > > 			|
> > > 			v
> > > 	PCIe Host bridge(Parent of PCI-PCI bridge)
> > > 			|
> > > 			v
> > > 	PCI-PCI bridge(Parent of endpoint driver)
> > > 			|
> > > 			v
> > > 		PCIe endpoint driver
> > >
> > > Since runtime PM is disabled for host bridge, the state of the child
> > > devices under the host bridge is not taken into account by PM framework
> > > for the top level parent, PCIe controller. So PM framework, allows
> > > the controller driver to enter runtime PM irrespective of the state
> > > of the devices under the host bridge.
> > 
> > IIUC this says that we runtime suspend the controller even though
> > runtime PM is disabled for the host bridge?  I have a hard time
> > parsing this; can you cite a function that does this or some relevant
> > documentation about how this part of runtime PM works?
> > 
> Generally controller should go to runtime suspend when endpoint client
> drivers and pci-pci host bridge drivers goes to runtime suspend as the
> controller driver is the parent, but we are observing controller driver
> goes to runtime suspend even when client drivers and PCI-PCI bridge are
> in active state.

It surprises me that a device could be suspended while children are
active.  A PCI-PCI bridge must be in D0 for any devices below it to be
active.  The controller is a platform device, not a PCI device, but I
am similarly surprised that we would suspend it when children are
active, which makes me think we didn't set the hierarchy up correctly.

It doesn't seem like we should need to enable runtime PM for a parent
to keep it from being suspended when children are active.

> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/of_pci.h>
> > >  #include <linux/pci_regs.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > 
> > >  #include "../../pci.h"
> > >  #include "pcie-designware.h"
> > > @@ -505,6 +506,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >         if (pp->ops->post_init)
> > >                 pp->ops->post_init(pp);
> > > 
> > > +       pm_runtime_set_active(&bridge->dev);
> > > +       pm_runtime_enable(&bridge->dev);
> > > +
> > >         return 0;
> > > 
> > >  err_stop_link:

Bjorn

