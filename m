Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA01645AB34
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 19:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbhKWSYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 13:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhKWSYj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 13:24:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3E9D60D42;
        Tue, 23 Nov 2021 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637691691;
        bh=EPgazr6O4P09PJXN6mRHrVgpXNUBn3rHoDGlKauo9uY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=evsvsjPYVCWphTOJs5o5TwCAN5zHsLyzLr7/8/uUBB8RA/e/s/0wlt8WQWQguKEH1
         I8scXjtDWVHpL+cZdYqlHvCM2GLeDkUbnWMx6AZvGV6eJc9Mg/dnr5RGox5ZRM+iT6
         lg06I4cNt85Et7dUbuw7LMQ/ScMIJr6afBK0FXoH2UnatTOK3jzZBjWgpPAdUoSqT/
         qERp56vy/M1TESMO2OBLfZlCet95DXFgdMMy4LDtym7ifIi0ZokbLKJ6xpnUD4n1xB
         J5KFWBtFGKvHJXCUbSY4LShQGxx9hD04v/0kLEjJxZ+gJhJ8KFSqd2QeFFlX/o8nhE
         Yq3P4fwK8VZFw==
Date:   Tue, 23 Nov 2021 12:21:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <20211123182128.GA2230781@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120000250.1663391-21-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 04:02:47PM -0800, Ben Widawsky wrote:
> The CXL port driver is responsible for managing the decoder resources
> contained within the port. It will also provide APIs that other drivers
> will consume for managing these resources.
> 
> There are 4 types of ports in a system:
> 1. Platform port. This is a non-programmable entity. Such a port is
>    named rootX. It is enumerated by cxl_acpi in an ACPI based system.

Can you mention the ACPI source (static table, namespace PNP ID) here?

> 2. Hostbridge port. 

Is "hostbridge" styled as a single word in the spec?  I've only seen
"host bridge" elsewhere.

>    This ports register access is defined in a platform
>    specific way (CHBS for ACPI platforms). 

s/This ports/This port's/

This doesn't really make sense, though.  Are you saying the register
access *mechanism* is platform specific?  Or merely that the
enumeration method (ACPI table, ACPI namespace, DT, etc) is
platform-specific?

I assume "CHBS" is an ACPI static table?

>    It has n downstream ports,
>    each of which are known as CXL 2.0 root ports.

This sounds like a "host bridge port *contains* these root ports."
That doesn't sound right.

>    Once the platform
>    specific mechanism to get the offset to the registers is obtained it
>    operates just like other CXL components. The enumeration of this
>    component is started by cxl_acpi and completed by cxl_port.

> 3. Switch port. A switch port is similar to a hostbridge port except
>    register access is defined in the CXL specification in a platform
>    agnostic way. The downstream ports for a switch are simply known as
>    downstream ports. The enumeration of these are entirely contained
>    within cxl_port.

In PCIe, "Downstream Port" includes both Root Ports and Switch
Downstream Ports.  It sounds like that's not the case for CXL?

Well, except above you say that a Host Bridge Port has N Downstream
Ports, so I guess "Downstream Port" probably includes both Host Bridge
Ports and Switch Downstream Ports.

Maybe you should just omit the "The downstream ports for a switch are
simply known as downstream ports" sentence.

> 4. Endpoint port. Endpoint ports are similar to switch ports with the
>    exception that they have no downstream ports, only the underlying
>    media on the device. The enumeration of these are started by cxl_pci,
>    and completed by cxl_port.

Does CXL use an "Upstream Port" concept similar to PCIe?  In PCIe,
"Upstream Port" includes both Switch Upstream Ports and the Upstream
Port on an Endpoint.

I hope this driver is not modeled on the PCI portdrv.  IMO, that was a
design error, and the "port service drivers" (PME, hotplug, AER, etc)
should be directly integrated into the PCI core instead of pretending
to be independent drivers.

> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -28,6 +28,11 @@ CXL Memory Device
>  .. kernel-doc:: drivers/cxl/pci.c
>     :internal:
>  
> +CXL Port
> +--------
> +.. kernel-doc:: drivers/cxl/port.c
> +   :doc: cxl port

s/cxl port/CXL Port/ ?  I don't know exactly how this gets rendered by
ReST.

>  CXL Core
>  --------
>  .. kernel-doc:: drivers/cxl/cxl.h
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index ef05e96f8f97..3aeb33bba5a3 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -77,4 +77,26 @@ config CXL_PMEM
>  	  provisioning the persistent memory capacity of CXL memory expanders.
>  
>  	  If unsure say 'm'.
> +
> +config CXL_MEM
> +	tristate "CXL.mem: Memory Devices"
> +	select CXL_PORT
> +	depends on CXL_PCI
> +	default CXL_BUS
> +	help
> +	  The CXL.mem protocol allows a device to act as a provider of "System
> +	  RAM" and/or "Persistent Memory" that is fully coherent as if the
> +	  memory was attached to the typical CPU memory controller.  This is
> +	  known as HDM "Host-managed Device Memory".

s/was attached/were attached/

> +	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
> +	  memory expansion and control of HDM. See Chapter 9.13 in the CXL 2.0
> +	  specification for a detailed description of HDM.
> +
> +	  If unsure say 'm'.
> +
> +

Spurious blank line.

> +config CXL_PORT
> +	tristate
> +
>  endif

> --- /dev/null
> +++ b/drivers/cxl/port.c
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "cxlmem.h"
> +
> +/**
> + * DOC: cxl port

s/cxl port/CXL port/ (I'm assuming this should match usage below)
or maybe "CXL Port" both places to match typical PCIe spec usage?

Capitalization is a useful hint that this term is defined by a spec.

> + *
> + * The port driver implements the set of functionality needed to allow full
> + * decoder enumeration and routing. A CXL port is an abstraction of a CXL
> + * component that implements some amount of CXL decoding of CXL.mem traffic.
> + * As of the CXL 2.0 spec, this includes:
> + *
> + *	.. list-table:: CXL Components w/ Ports
> + *		:widths: 25 25 50
> + *		:header-rows: 1
> + *
> + *		* - component
> + *		  - upstream
> + *		  - downstream
> + *		* - Hostbridge

s/Hostbridge/Host bridge/

> + *		  - ACPI0016
> + *		  - root port

s/root port/Root Port/ to match Switch Ports below (and spec usage).

> + *		* - Switch
> + *		  - Switch Upstream Port
> + *		  - Switch Downstream Port
> + *		* - Endpoint
> + *		  - Endpoint Port
> + *		  - N/A

What does "N/A" mean here?  Is it telling us something useful?

> +static void rescan_ports(struct work_struct *work)
> +{
> +	if (bus_rescan_devices(&cxl_bus_type))
> +		pr_warn("Failed to rescan\n");

Needs some context.  A bare "Failed to rescan" in the dmesg log
without a clue about who emitted it is really annoying.

Maybe you defined pr_fmt() somewhere; I couldn't find it easily.

Bjorn
