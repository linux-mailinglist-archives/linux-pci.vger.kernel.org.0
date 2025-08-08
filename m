Return-Path: <linux-pci+bounces-33640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3CEB1ECF1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99E6722419
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F399D287254;
	Fri,  8 Aug 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF90Y6YB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B13286D5C;
	Fri,  8 Aug 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670191; cv=none; b=XN7E/p7NsxtUTa2+SiwtJQtAsItQ8BaUgilZ8RYLUoaBqe5Fyb4eoIYzdNV+SAZVwScFZ+/I+qpAJ+WlNUOZh8YrcQKRbdA6vvxbsEfoRlM0wFlw56+MKX/nC2Y4Ds8RyQehjIl1VroLEaxrOCHYOr3Rmb3WTB7G191BXr+/cKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670191; c=relaxed/simple;
	bh=iBBShj+kZsRTtO2PKybZxG3EHNwRqduCpGMyk73b6/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WtdVNZ7DLJT9XKf+KL/ND+aaZx3OTtr410QWkHC63Q8FjY/KPt8wpAUtvNcRtcx3dWEX8EFa+ygUhveZGR7RqyCH4KTfPGHrFOUkO4KwXycqUsV2Bu1Fd4KIjzhhmZ0SoAAEsLyRpoCLgyofbSZ9WTb5uQkUGU6wNCDRP/f+J3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF90Y6YB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D68CC4CEED;
	Fri,  8 Aug 2025 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754670191;
	bh=iBBShj+kZsRTtO2PKybZxG3EHNwRqduCpGMyk73b6/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XF90Y6YBtOHMrMWFtvVMPMjrlIPH9OCiu6I9jwKmgiryJUklB6n5n8haO86ChYETg
	 RVFT/dCEyS81iOEmaT1bbvHuoVoAQwPvB6ZTq01EjUqsS+bo6NJqW9UIXKZzSBLFRj
	 ox6jVPQXTDNBSIvLu5DwlghT6Cny8OM2oRx6d1tupOrQzu2tk7yIKFaKSj0Kg9UKMR
	 A8aT9qSq4O6MOJ/v/AQtxiJCxeeJMi9Dat4G6XW6okDfrDzz5hFtMSeU+rDhRYvV8u
	 HnzdeOa7Z6uLpU17/SsIGmVwrGXc+bqcxXLlW32JGqqAI9Nf7OeQtJF8Pi9p5cVAFG
	 JWtWOvr5V8lzQ==
Date: Fri, 8 Aug 2025 11:23:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, lizhi.hou@amd.com,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3 4/9] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
Message-ID: <20250808162309.GA91528@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71d109a1-211a-45ee-8525-03f1859b789a@tuxon.dev>

On Fri, Aug 08, 2025 at 02:25:42PM +0300, Claudiu Beznea wrote:
> On 08.07.2025 19:34, Bjorn Helgaas wrote:
> > On Fri, Jul 04, 2025 at 07:14:04PM +0300, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> >> Base Specification 4.0. It is designed for root complex applications and
> >> features a single-lane (x1) implementation. Add documentation for it.
> > 
> >> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml

> >> +        pcie@11e40000 {
> >> +            compatible = "renesas,r9a08g045s33-pcie";
> >> +            reg = <0 0x11e40000 0 0x10000>;
> >> +            ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>;
> >> +            dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0 0x38000000>;
> >> +            bus-range = <0x0 0xff>;
> ...

> >> +            device_type = "pci";
> >> +            num-lanes = <1>;
> >> +            #address-cells = <3>;
> >> +            #size-cells = <2>;
> >> +            power-domains = <&cpg>;
> >> +            vendor-id = <0x1912>;
> >> +            device-id = <0x0033>;
> > 
> > Some of this is specific to a Root Port, not to the Root Complex
> > as a whole.  E.g., device-type = "pci", num-lanes, vendor-id,
> > device-id, are Root Port properties.  Some of the resets, clocks,
> > and interrupts might be as well.
> > 
> > I really want to separate those out because even though this
> > particular version of this PCIe controller only supports a single
> > Root Port, there are other controllers (and possibly future
> > iterations of this controller) that support multiple Root Ports,
> > and it makes maintenance easier if the DT bindings and the driver
> > structures are similar.
> 
> I'll ask the Renesas HW team about the resets and clocks as the HW
> manual don't offer any information about this.
> 
> If they will confirm some of the clocks and/or resets could be
> controlled as part of a port then patch 3/9 "PCI: of_property:
> Restore the arguments of the next level parent" in this series will
> not be needed anymore. Would you prefer me to abandon it or post it
> as individual patch, if any?

[PATCH v3 3/9] ("PCI: of_property: Restore the arguments of the next
level parent") isn't specific to Renesas RZ/G3S and it doesn't look
like it has anything to do with clocks or resets.  I don't understand
the patch well enough to know whether you should keep it, but it does
look like you should post it separate from the RZ/G3S driver.

When the devicetree contains required information specific to Root
Ports, I would prefer that to be in a separate "pcie@x,y" stanza, even
if there are clocks or resets that apply to all Root Ports.

"num-lanes" is obviously specific to an individual Root Port because
a Root Complex doesn't have lanes at all.  But in the case of RZ/G3S,
I'm not sure "num-lanes" is required in the devicetree; I don't see it
being used in the driver.  If it's not needed, I would just omit it.

It looks like the driver *does* need "vendor-id" and "device-id"
though, and those also are specific to a Root Port because a Root
Complex is not a PCI device and doesn't have its own Vendor or Device
ID.  So I would like them to be in a per-Root Port stanza.  If there
are resets or clocks that affect a Root Port but not the Root Complex
as a whole, they should also be in the Root Port stanza.

Bjorn

