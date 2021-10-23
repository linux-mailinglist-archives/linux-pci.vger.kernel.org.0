Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD244383F3
	for <lists+linux-pci@lfdr.de>; Sat, 23 Oct 2021 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJWOpW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Oct 2021 10:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhJWOpW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 23 Oct 2021 10:45:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8D8660720;
        Sat, 23 Oct 2021 14:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635000183;
        bh=Pty1qEs4hu91HWBg4f2Rf1XF2qA/p+8vS9csr9QVK+w=;
        h=Date:From:To:Cc:Subject:From;
        b=MviOO+ALhR+FGFZybD1eqQABkyzGGie7QlgfbMCWtdqM9d++scuYn9QcR5w8Ba2lD
         Hpb7OPx0cD7VyaOEiSuQvz3ZPhoTiIiWb1ucodt7q5PRkjjqFqo+cy6ViS8joffIzA
         U/dujKhUK91+t73iztVKMbPU+Miv+USuqwkJVQ+RMuOI9u8efaMl4CoPw8+JATU+bo
         WYofEySzDYfAUhauBo2Ga8aLDp2tO45/O0G/6XLUAihH6WYKfW/3tfSMGIhvZVEVnV
         acXogm++F59RoR3kBcxeIFzRoj0cr9BQfUsFcIEf+YZtEOdCBU0Gf+K6v05zribNXF
         F7CFJaOL+JcWg==
Received: by pali.im (Postfix)
        id 4658B883; Sat, 23 Oct 2021 16:43:00 +0200 (CEST)
Date:   Sat, 23 Oct 2021 16:42:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: Change PCI DTS scheme for port/link specific properties
Message-ID: <20211023144252.z7ou2l2tvm6cvtf7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Rob!

I think that the current DT scheme for PCI buses and devices defined in
Linux kernel tree has wrong definitions of port/link specific properties:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/pci.txt

Port or link specific properties are at least: max-link-speed,
reset-gpios and supports-clkreq. And are currently defined as properties
of host bridges.

Host Bridge contains one or more PCIe Root Ports (each represented as
PCI Bridge device) and to each PCIe Root Port can be connected exactly
one PCIe Upstream device.

PCIe Upstream device can be either endpoint PCIe card or it can be also
PCIe switch is consists of exactly one Upstream Port (represented as PCI
Bridge device) and then one or more Downstream Port devices (each
represent as PCI Bridge device). To each Downstream Port can be
connected again exactly one PCIe Upstream device.

Port or link specific properties (e.g. max-link-speed, reset-gpios and
supports-clkreq) define "the PCIe link" between the Root/Downstream
device and Endpoint/Upstream device. And it is basically Root/Downstream
device which configures the port or link. So I think that these
properties should not be in Host Bridge DTS node, but rather in DTS node
which represents Root Port (or Downstream Port in case of PCIe switches).

Mauro wrote in another email, that he has PCIe topology with
single-root-port host bridge to which is connected multi-port PCIe
switch and he needs to control reset-gpios of devices connected to
downstream ports of PCIe switch.

Current pci.txt DT scheme is fully unsuitable for this kind of setup as
basically PCIe switch is completely independent device of host bridge
and so host bridge really should not define in its node properties which
do not belong to host bridge itself.

Rob, what do you think, how to solve this issue?

I would suggest to define that max-link-speed, reset-gpios and
supports-clkreq properties should be in node for Root Port and
Downstream Port devices and not in host bridge nodes.

So DTS for PCIe controller which has 2 root ports where to first root
port is connected PCIe switch with 2 cards and to second root port is
connected just endpoint card:

pcie-host-bridge {
	compatible = "vendor-controller-string"; /* e.g. designware, etc... */

	pcie-root-port-1@0,0 {
		reg = <0x00000000 0 0 0 0>; /* root port at device 0 */
		reset-gpios = ...; /* resets card connected to root-port-1 which is pcie-switch-1-upstream-port */
		max-link-speed = <3> /* link between root-port-1 and switch is GEN3 */

		pcie-switch-1-upstream-port@0,0 {
			reg = ...; /* upstream port at device 0 */

			pcie-switch-1-downstream-port-1@X,0 {
				reg = ...; /* downstream port 1 at switch specific address */
				reset-gpios = ...; /* resets card connected to switch's port 1 */
				max-link-speed = <1> /* link between this port and card is GEN1 */

				/* optional node for endpoint card */
				/* pcie-card@0,0 { ... }; */
			};

			pcie-switch-1-downstream-port-2@Y,0 {
				reg = ...; /* downstream port 2 at switch specific address */
				reset-gpios = ...; /* resets card connected to switch's port 2 */
				max-link-speed = <1> /* link between this port and card is GEN1 */

				/* optional node for endpoint card */
				/* pcie-card@0,0 { ... }; */
			};
		};
	};

	pcie-root-port-2@1,0 {
		reg = <0x00000800 0 0 0 0>; /* root port at device 1 */
		reset-gpios = ...; /* resets card connected to root-port-2 */
		max-link-speed = <2> /* link between root-port-2 and card below is just GEN2 */

		/* optional node for endpoint card */
		/* pcie-card@0,0 { ... }; */
	};
};

Any opinion?
