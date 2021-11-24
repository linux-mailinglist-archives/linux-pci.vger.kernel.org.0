Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5FE45CF15
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 22:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhKXVex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 16:34:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232011AbhKXVew (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 16:34:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F2FD6102A;
        Wed, 24 Nov 2021 21:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637789502;
        bh=WCZ4yTBKXfWqJohVhEawc3NtcpMy9WsJ7M3psiMqSWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fmy9A1nJ8sTb29ElGQ5VUiKIPLN8hzS6hXdsZqvZzAv1BNa/AWGAnmY+RSA1vHojm
         4J/iF1OUNflMiRT/E78BMnHJT1FbQd2tA7qP9EouNvcLXPSbC2WzfU4ps4NC53V0zR
         JiZqbkv9uRqIVHIul6eZ8uIn48IB2sU3eEUBIZRypFzjC22f8np9MkL4GEeu3md0+K
         Qr7An73p8oBuVAhmWMJXOAJ/a3J7CPF1ezS6G7vUMBMqdQADAkotv2+DSMQ3qU0lWt
         jEmhyh3iS5Y/eOFr3PXv6GK9+nTwfl2WR4KfvEUWx6L+0VSBq1WePYajALy8bZ6Dma
         I86aY39GPIJbA==
Date:   Wed, 24 Nov 2021 15:31:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <20211124213140.GA2306664@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123220315.itoh4izu56yrrjlh@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 02:03:15PM -0800, Ben Widawsky wrote:
> On 21-11-23 12:21:28, Bjorn Helgaas wrote:
> > On Fri, Nov 19, 2021 at 04:02:47PM -0800, Ben Widawsky wrote:

> > > 2. Hostbridge port. 
> > > ...
> > >    It has n downstream ports,
> > >    each of which are known as CXL 2.0 root ports.
> > 
> > This sounds like a "host bridge port *contains* these root ports."
> > That doesn't sound right.
> 
> What sounds better? A CXL 2.0 Root Port is CXL capabilities on top
> of the PCIe component which has the PCI_EXP_TYPE_ROOT_PORT cap. In
> my mental model, a host bridge does contain the root ports. Perhaps
> I am wrong about that?

"A host bridge contains the root ports" makes sense to me.
"A host bridge *port* contains root ports" does not.

The PCIe spec would describe this as a "Root Complex may support one
or more [Root] Ports" (see PCIe r5.0, sec 1.3.1).

In PCIe, a "Port" is "an interface between a component and a PCI
Express Link."  It doesn't contain other Ports.

Sounds like CXL is the same here, and using the same terminology
(assuming that's what the CXL spec does) will reduce confusion.

> > > 3. Switch port. A switch port is similar to a hostbridge port except
> > >    register access is defined in the CXL specification in a platform
> > >    agnostic way. The downstream ports for a switch are simply known as
> > >    downstream ports. The enumeration of these are entirely contained
> > >    within cxl_port.
> > 
> > In PCIe, "Downstream Port" includes both Root Ports and Switch
> > Downstream Ports.  It sounds like that's not the case for CXL?
> 
> In CXL 2.0, it's fairly close to true that switch downstream ports
> and root ports are equivalent. From today's driver perspective they
> are equivalent. Root ports have some capabilities which switch
> downstream ports do not.

Same as PCIe.

> > > 4. Endpoint port. Endpoint ports are similar to switch ports with the
> > >    exception that they have no downstream ports, only the underlying
> > >    media on the device. The enumeration of these are started by cxl_pci,
> > >    and completed by cxl_port.
> > 
> > Does CXL use an "Upstream Port" concept similar to PCIe?  In PCIe,
> > "Upstream Port" includes both Switch Upstream Ports and the Upstream
> > Port on an Endpoint.
> 
> Not really. Endpoints aren't known as ports in the spec and they
> have a decent amount of divergence from upstream ports. The main
> area where they do converge is in the memory decoding capabilities.
> In fact, it might come to a point where we find adding an endpoint
> as a port does not make sense, but for now it does.

Since a PCIe "Port" refers to the interface between a component and a
Link, PCIe Endpoints have Upstream Ports just like switches do.  I'm
guessing CXL is the same.

The part about "endpoint ports have no downstream ports" is what
doesn't read well to me because ports don't have other ports.

This section is about the four types of ports in a system.  I'm
trying to match those up with spec terms, either PCIe or CXL.  It
sounds like you intend bullet 3 to include both Switch Upstream Ports
and Switch Downstream Ports, and bullet 4 to be only Endpoint Ports
(which are Upstream Ports).

> > I hope this driver is not modeled on the PCI portdrv.  IMO, that
> > was a design error, and the "port service drivers" (PME, hotplug,
> > AER, etc) should be directly integrated into the PCI core instead
> > of pretending to be independent drivers.
> 
> I'd like to understand a bit about why you think it was a design
> error. The port driver is intended to be a port services driver,
> however I see the services provided as quite different than the ones
> you mention. The primary service cxl_port will provide from here on
> out is the ability to manage HDM decoder resources for a port. Other
> independent drivers that want to use HDM decoder resources would
> rely on the port driver for this.

I'll continue this part in the later part of the thread.

> > > + *		* - Switch
> > > + *		  - Switch Upstream Port
> > > + *		  - Switch Downstream Port
> > > + *		* - Endpoint
> > > + *		  - Endpoint Port
> > > + *		  - N/A
> > 
> > What does "N/A" mean here?  Is it telling us something useful?
> 
> This gets rendered into a table that looks like the following:
> 
> | component  | upstream             | downstream             |
> | ---------  | --------             | ----------             |
> | Hostbridge | ACPI0016             | Root Port              |
> | Switch     | Switch Upstream Port | Switch Downstream Port |
> | Endpoint   | Endpoint Port        | N/A                    |

Makes sense, thanks.  I didn't know how to read the ReST and thought
this was just a list, where N/A wouldn't make much sense.

Bjorn
