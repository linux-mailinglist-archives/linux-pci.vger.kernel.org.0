Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DBF439D6D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhJYRY3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 13:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhJYRY2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 13:24:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 261E36058D;
        Mon, 25 Oct 2021 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635182526;
        bh=Ehduh8rsnuoncesy2bv8xUGwuttZRJbErzBa2Fji4Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZHEAb34P0MRyx3iYavzTLjPxhYBrpH1pFfapcYOUCJwH5Y1OQK0yroC/j/QW9726
         aHURbTUbRcpPK7+QXL0kncF2O3S6Ydp6BL1RVjQ9FsWN/3nthGIg26wSRRkyle5g69
         lG362kVbyKBcxWrPuG32xhicps52Zjms7iM1qmdTQ9nr0e6O6+jMHRIKSFTF5Ku4EB
         si2SpCD169S5lgUEzHq2M1LI3X3Q4BYnNonpFQVV7oc+5vAEhbYKUmKeaggp8n/og8
         8e39HaLc+ZN75gwyHqXc4X24E0al9c6M51hDTAIJ5iXVyZJPXjqToMIzQt2vcw6NXt
         K04MnxJFvxYDg==
Received: by pali.im (Postfix)
        id ADA1D98A; Mon, 25 Oct 2021 19:22:03 +0200 (CEST)
Date:   Mon, 25 Oct 2021 19:22:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Change PCI DTS scheme for port/link specific properties
Message-ID: <20211025172203.yeecufmhc5c7zdgz@pali>
References: <20211023144252.z7ou2l2tvm6cvtf7@pali>
 <CAL_JsqLwGtEVrAc1SFUBfQp22Vxp8hb5Kft1B9t_nFMZ=q8M-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLwGtEVrAc1SFUBfQp22Vxp8hb5Kft1B9t_nFMZ=q8M-g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 25 October 2021 10:39:42 Rob Herring wrote:
> On Sat, Oct 23, 2021 at 9:43 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > Hello Rob!
> >
> > I think that the current DT scheme for PCI buses and devices defined in
> > Linux kernel tree has wrong definitions of port/link specific properties:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/pci.txt
> >
> > Port or link specific properties are at least: max-link-speed,
> > reset-gpios and supports-clkreq. And are currently defined as properties
> > of host bridges.
> 
> pci-bus.yaml in dtschema is what matters now and it's a bit more flexible.

I do not see any pci-bus.yaml file in linux kernel tree... It is missing
or it is external?

> > Host Bridge contains one or more PCIe Root Ports (each represented as
> > PCI Bridge device) and to each PCIe Root Port can be connected exactly
> > one PCIe Upstream device.
> >
> > PCIe Upstream device can be either endpoint PCIe card or it can be also
> > PCIe switch is consists of exactly one Upstream Port (represented as PCI
> > Bridge device) and then one or more Downstream Port devices (each
> > represent as PCI Bridge device). To each Downstream Port can be
> > connected again exactly one PCIe Upstream device.
> >
> > Port or link specific properties (e.g. max-link-speed, reset-gpios and
> > supports-clkreq) define "the PCIe link" between the Root/Downstream
> > device and Endpoint/Upstream device. And it is basically Root/Downstream
> > device which configures the port or link. So I think that these
> > properties should not be in Host Bridge DTS node, but rather in DTS node
> > which represents Root Port (or Downstream Port in case of PCIe switches).
> 
> I tend to agree, but that ship has sailed because we don't tend to
> have a RP node in DT. Most host bridges also tend to be a single RP.
> In those cases, the properties come from whatever node we have.

For, for cases with single root port on host bridge bus, it could be
possible to have these port/link properties directly in host bridge
node. As it is unambiguous what they describe and to which hw part they
belong.

> Certainly if there are multiple RPs on the host bridge bus (bus 0),
> then we need multiple child nodes for the RPs. IIRC, some host
> bindings do this already.

Yes, some of them are doing it. And it would be a good if it is a
requirement for all new multi-port bindings and pcie controller drivers.

As it is a mess if every driver define these properties by its own.
Having one common / standard driver agnostic way for defining
complicated topology is really better.

> > Mauro wrote in another email, that he has PCIe topology with
> > single-root-port host bridge to which is connected multi-port PCIe
> > switch and he needs to control reset-gpios of devices connected to
> > downstream ports of PCIe switch.
> 
> I did a lot of work on that to get it right in terms of having the
> right nodes matching the bus hierarchy and resets distributed in the
> nodes.
> 
> >
> > Current pci.txt DT scheme is fully unsuitable for this kind of setup as
> > basically PCIe switch is completely independent device of host bridge
> > and so host bridge really should not define in its node properties which
> > do not belong to host bridge itself.
> >
> > Rob, what do you think, how to solve this issue?
> >
> > I would suggest to define that max-link-speed, reset-gpios and
> > supports-clkreq properties should be in node for Root Port and
> > Downstream Port devices and not in host bridge nodes.
> >
> > So DTS for PCIe controller which has 2 root ports where to first root
> > port is connected PCIe switch with 2 cards and to second root port is
> > connected just endpoint card:
> >
> > pcie-host-bridge {
> >         compatible = "vendor-controller-string"; /* e.g. designware, etc... */
> >
> >         pcie-root-port-1@0,0 {
> 
> pcie@0,0 and 'device_type = "pci"' are needed to indicate this is a
> bridge node and apply the schema.

Ok. I probably omitted more properties here. I just wanted to show
example how link speeds and PERST# pins are defined here.

> >                 reg = <0x00000000 0 0 0 0>; /* root port at device 0 */
> >                 reset-gpios = ...; /* resets card connected to root-port-1 which is pcie-switch-1-upstream-port */
> >                 max-link-speed = <3> /* link between root-port-1 and switch is GEN3 */
> >
> >                 pcie-switch-1-upstream-port@0,0 {
> >                         reg = ...; /* upstream port at device 0 */
> >
> >                         pcie-switch-1-downstream-port-1@X,0 {
> >                                 reg = ...; /* downstream port 1 at switch specific address */
> >                                 reset-gpios = ...; /* resets card connected to switch's port 1 */
> >                                 max-link-speed = <1> /* link between this port and card is GEN1 */
> >
> >                                 /* optional node for endpoint card */
> >                                 /* pcie-card@0,0 { ... }; */
> >                         };
> >
> >                         pcie-switch-1-downstream-port-2@Y,0 {
> >                                 reg = ...; /* downstream port 2 at switch specific address */
> >                                 reset-gpios = ...; /* resets card connected to switch's port 2 */
> >                                 max-link-speed = <1> /* link between this port and card is GEN1 */
> >
> >                                 /* optional node for endpoint card */
> >                                 /* pcie-card@0,0 { ... }; */
> >                         };
> >                 };
> >         };
> >
> >         pcie-root-port-2@1,0 {
> >                 reg = <0x00000800 0 0 0 0>; /* root port at device 1 */
> >                 reset-gpios = ...; /* resets card connected to root-port-2 */
> >                 max-link-speed = <2> /* link between root-port-2 and card below is just GEN2 */
> >
> >                 /* optional node for endpoint card */
> >                 /* pcie-card@0,0 { ... }; */
> >         };
> > };
> >
> > Any opinion?
