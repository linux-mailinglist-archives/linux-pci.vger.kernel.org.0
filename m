Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3538645AECE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 23:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbhKWWG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 17:06:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:26245 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbhKWWG1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 17:06:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="235377079"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="235377079"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 14:03:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="474911009"
Received: from sshetty1-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.143.221])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 14:03:16 -0800
Date:   Tue, 23 Nov 2021 14:03:15 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <20211123220315.itoh4izu56yrrjlh@intel.com>
References: <20211120000250.1663391-21-ben.widawsky@intel.com>
 <20211123182128.GA2230781@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123182128.GA2230781@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-23 12:21:28, Bjorn Helgaas wrote:
> On Fri, Nov 19, 2021 at 04:02:47PM -0800, Ben Widawsky wrote:
> > The CXL port driver is responsible for managing the decoder resources
> > contained within the port. It will also provide APIs that other drivers
> > will consume for managing these resources.
> > 
> > There are 4 types of ports in a system:
> > 1. Platform port. This is a non-programmable entity. Such a port is
> >    named rootX. It is enumerated by cxl_acpi in an ACPI based system.
> 
> Can you mention the ACPI source (static table, namespace PNP ID) here?

Done.

> 
> > 2. Hostbridge port. 
> 
> Is "hostbridge" styled as a single word in the spec?  I've only seen
> "host bridge" elsewhere.
> 

2 words. I'm sadly inconsistent with this particular word. CXL spec capitalizes
it.

> >    This ports register access is defined in a platform
> >    specific way (CHBS for ACPI platforms). 
> 
> s/This ports/This port's/
> 
> This doesn't really make sense, though.  Are you saying the register
> access *mechanism* is platform specific?  Or merely that the
> enumeration method (ACPI table, ACPI namespace, DT, etc) is
> platform-specific?
> 
> I assume "CHBS" is an ACPI static table?
> 

The registers are spec defined. The base address of those registers is defined
in a platform specific manner. Enumeration is a better word. CHBS is an ACPI
static table, yes.

> >    It has n downstream ports,
> >    each of which are known as CXL 2.0 root ports.
> 
> This sounds like a "host bridge port *contains* these root ports."
> That doesn't sound right.
> 

What sounds better? A CXL 2.0 Root Port is CXL capabilities on top of the PCIe
component which has the PCI_EXP_TYPE_ROOT_PORT cap. In my mental model, a host
bridge does contain the root ports. Perhaps I am wrong about that?

> >    Once the platform
> >    specific mechanism to get the offset to the registers is obtained it
> >    operates just like other CXL components. The enumeration of this
> >    component is started by cxl_acpi and completed by cxl_port.
> 
> > 3. Switch port. A switch port is similar to a hostbridge port except
> >    register access is defined in the CXL specification in a platform
> >    agnostic way. The downstream ports for a switch are simply known as
> >    downstream ports. The enumeration of these are entirely contained
> >    within cxl_port.
> 
> In PCIe, "Downstream Port" includes both Root Ports and Switch
> Downstream Ports.  It sounds like that's not the case for CXL?
> 

In CXL 2.0, it's fairly close to true that switch downstream ports and root
ports are equivalent. From today's driver perspective they are equivalent. Root
ports have some capabilities which switch downstream ports do not.

> Well, except above you say that a Host Bridge Port has N Downstream
> Ports, so I guess "Downstream Port" probably includes both Host Bridge
> Ports and Switch Downstream Ports.

Yes, in that case I meant a port which is downstream - confusing indeed.

> 
> Maybe you should just omit the "The downstream ports for a switch are
> simply known as downstream ports" sentence.
> 

Sounds good.

> > 4. Endpoint port. Endpoint ports are similar to switch ports with the
> >    exception that they have no downstream ports, only the underlying
> >    media on the device. The enumeration of these are started by cxl_pci,
> >    and completed by cxl_port.
> 
> Does CXL use an "Upstream Port" concept similar to PCIe?  In PCIe,
> "Upstream Port" includes both Switch Upstream Ports and the Upstream
> Port on an Endpoint.

Not really. Endpoints aren't known as ports in the spec and they have a decent
amount of divergence from upstream ports. The main area where they do converge
is in the memory decoding capabilities. In fact, it might come to a point where
we find adding an endpoint as a port does not make sense, but for now it does.

> 
> I hope this driver is not modeled on the PCI portdrv.  IMO, that was a
> design error, and the "port service drivers" (PME, hotplug, AER, etc)
> should be directly integrated into the PCI core instead of pretending
> to be independent drivers.

I'd like to understand a bit about why you think it was a design error. The port
driver is intended to be a port services driver, however I see the services
provided as quite different than the ones you mention. The primary service
cxl_port will provide from here on out is the ability to manage HDM decoder
resources for a port. Other independent drivers that want to use HDM decoder
resources would rely on the port driver for this.

It could be in CXL core just the same, but I don't see too much of a benefit
since the code would be almost identical. One nice aspect of having the port
driver outside of CXL core is it would allow CXL devices which do not need port
services (type-1 and probably type-2) to not need to load the port driver. We do
not have examples of such devices today but there's good evidence they are being
built. Whether or not they will even want CXL core is another topic up for
debate however.

I admit Dan and I did discuss putting this in either its own port driver, or
within core as a port driver. My inclination is, less is more in CXL core; but
perhaps you will be able to change my mind.

> 
> > --- a/Documentation/driver-api/cxl/memory-devices.rst
> > +++ b/Documentation/driver-api/cxl/memory-devices.rst
> > @@ -28,6 +28,11 @@ CXL Memory Device
> >  .. kernel-doc:: drivers/cxl/pci.c
> >     :internal:
> >  
> > +CXL Port
> > +--------
> > +.. kernel-doc:: drivers/cxl/port.c
> > +   :doc: cxl port
> 
> s/cxl port/CXL Port/ ?  I don't know exactly how this gets rendered by
> ReST.

I believe this is the specific tag as specified in the .c file. I can capitalize
it, but we haven't done this for other tags.

> 
> >  CXL Core
> >  --------
> >  .. kernel-doc:: drivers/cxl/cxl.h
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index ef05e96f8f97..3aeb33bba5a3 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -77,4 +77,26 @@ config CXL_PMEM
> >  	  provisioning the persistent memory capacity of CXL memory expanders.
> >  
> >  	  If unsure say 'm'.
> > +
> > +config CXL_MEM
> > +	tristate "CXL.mem: Memory Devices"
> > +	select CXL_PORT
> > +	depends on CXL_PCI
> > +	default CXL_BUS
> > +	help
> > +	  The CXL.mem protocol allows a device to act as a provider of "System
> > +	  RAM" and/or "Persistent Memory" that is fully coherent as if the
> > +	  memory was attached to the typical CPU memory controller.  This is
> > +	  known as HDM "Host-managed Device Memory".
> 
> s/was attached/were attached/
> 
> > +	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
> > +	  memory expansion and control of HDM. See Chapter 9.13 in the CXL 2.0
> > +	  specification for a detailed description of HDM.
> > +
> > +	  If unsure say 'm'.
> > +
> > +
> 
> Spurious blank line.
> 
> > +config CXL_PORT
> > +	tristate
> > +
> >  endif
> 
> > --- /dev/null
> > +++ b/drivers/cxl/port.c
> > @@ -0,0 +1,323 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +
> > +#include "cxlmem.h"
> > +
> > +/**
> > + * DOC: cxl port
> 
> s/cxl port/CXL port/ (I'm assuming this should match usage below)
> or maybe "CXL Port" both places to match typical PCIe spec usage?
> 
> Capitalization is a useful hint that this term is defined by a spec.
> 

As above, I don't mind changing this at all, but this would be inconsistent with
the other tags we have defined.

> > + *
> > + * The port driver implements the set of functionality needed to allow full
> > + * decoder enumeration and routing. A CXL port is an abstraction of a CXL
> > + * component that implements some amount of CXL decoding of CXL.mem traffic.
> > + * As of the CXL 2.0 spec, this includes:
> > + *
> > + *	.. list-table:: CXL Components w/ Ports
> > + *		:widths: 25 25 50
> > + *		:header-rows: 1
> > + *
> > + *		* - component
> > + *		  - upstream
> > + *		  - downstream
> > + *		* - Hostbridge
> 
> s/Hostbridge/Host bridge/
> 
> > + *		  - ACPI0016
> > + *		  - root port
> 
> s/root port/Root Port/ to match Switch Ports below (and spec usage).
> 
> > + *		* - Switch
> > + *		  - Switch Upstream Port
> > + *		  - Switch Downstream Port
> > + *		* - Endpoint
> > + *		  - Endpoint Port
> > + *		  - N/A
> 
> What does "N/A" mean here?  Is it telling us something useful?

This gets rendered into a table that looks like the following:


| component  | upstream             | downstream             |
| ---------  | --------             | ----------             |
| Hostbridge | ACPI0016             | Root Port              |
| Switch     | Switch Upstream Port | Switch Downstream Port |
| Endpoint   | Endpoint Port        | N/A                    |


> 
> > +static void rescan_ports(struct work_struct *work)
> > +{
> > +	if (bus_rescan_devices(&cxl_bus_type))
> > +		pr_warn("Failed to rescan\n");
> 
> Needs some context.  A bare "Failed to rescan" in the dmesg log
> without a clue about who emitted it is really annoying.
> 
> Maybe you defined pr_fmt() somewhere; I couldn't find it easily.
> 

I actually didn't know about pr_fmt() trick, so thanks for that. I'll improve
this message to be more useful and contextual.

> Bjorn

