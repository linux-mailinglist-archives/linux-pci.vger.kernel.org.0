Return-Path: <linux-pci+bounces-6457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284118AA23C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 20:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AC71F214F2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934D176FB1;
	Thu, 18 Apr 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTTj0Mz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B463174EF9;
	Thu, 18 Apr 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465934; cv=none; b=mXiNYAv834zuiALudCeJiBehQy5An8wowmMlGpmSYMST8OJ4QEcFSq0isFm3LB8GhLq8pGCX/gNJj3kRk8qbZzBw7Ntsj1VuxJVnazuLHBpvNNPAJakJlJk39iV8kxmo7BgjBUS1BhC4VxT25lPxNcAmoDFj6TDiZO/Hx2aIFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465934; c=relaxed/simple;
	bh=lKM6jp4loR9UtX0QaVbNiZZcTUL3CirpRy3Imh5A0mk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lmdbgZvGN+uJoJm3rsyJPOh+ZAOJWvTdHxp3mQN6bIdWpNOeK6DP7YUMApr87/CZLwXIow2HvRKfEIQwnpaojiUiZ1AfR0cOJSufR3RhQIrZSGS7S5s6W1WheOBVWntBAlT7c6dLpQwYZfCMWB+87Ik3ZuHlAKH8jJafpq5hY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTTj0Mz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8141DC113CC;
	Thu, 18 Apr 2024 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713465933;
	bh=lKM6jp4loR9UtX0QaVbNiZZcTUL3CirpRy3Imh5A0mk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QTTj0Mz5XF92ESwg63sIEASiwqS2+47Ysq+/8nAqQdLB+L0KxMCi60r9Jo8I95gES
	 b0EwoBKcfHO/F0zrXMqsXSpnA+pSbezCyNneX+Ys0IFLDcZ985ZhkaMECookvDHA2F
	 I7vfwa2HZCb9idOIDQ3pHE4VAELdDmfOqQWQNlJ8+DwbJ4GDDvac3ei/ltznZb2ov4
	 5uzX8izHuIgYDpSBMpeGrsVBqCXvxUL0mJRX++mrbR+C+04sMwHMI6wu1Srk2G4W2X
	 XgrrWHcOJ42xgc2fCNckIhxyV0p9nnP9Rp3CsPuyN+Hj1ZiK6nC8JeOgjmhx/NWXjD
	 yZYgWxlEN7EZg==
Date: Thu, 18 Apr 2024 13:45:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: local bus enumeration beyond a PCI device
Message-ID: <20240418184531.GA245970@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bad63409-ed2b-4cef-988b-3c143636e9fa@alliedtelesis.co.nz>

[+cc Herve]

On Thu, Apr 18, 2024 at 12:24:06AM +0000, Chris Packham wrote:
> Hi,
> 
> We've got a custom x86_64 based design that is using an ASIX9100 to 
> provide a PCI to local bus bridge. Attached to that local bus is an FPGA 
> which mostly provides some GPIOs accessed via registers on the local 
> bus. Right now we've got a custom driver that bundles everything 
> together so effectively we've got a PCI device that provides GPIOs.

What's the local bus?  The ASIX9100 (for which Google doesn't find any
details) would have a PCI interface on the primary (upstream) side.
What's the local bus on the secondary (downstream) side?  Below you
mention "PCI bridge", which normally means both the primary and
secondary sides are PCI buses.

If the local bus is not PCI, I guess the ASIX9100 would look to the OS
like an endpoint, i.e., PCI_HEADER_TYPE_NORMAL, and the ASIX9100
driver would handle any "bridge" functionality completely internally?

Maybe Herve's work at
https://lore.kernel.org/r/20240325153919.199337-1-herve.codina@bootlin.com
would be relevant?

> But as things can change based on the FPGA program I'd like some 
> flexibility to treat it separately from the PCI bridge. So really I'd 
> like to have a PCI device driver for the ASIX9100 that provides a local 
> bus controller and a (platform?) driver for the FPGA that provides the 
> GPIOs where I can have different compatibles for the different 
> implementations.
> 
> Then in the ACPI overlay I'd have something like
> 
>      Scope (\_SB.PCI0.D0B0)
>      {
>          Device (ASIX)
>          {
>              Name (_ADR, 0x0000)
> 
>              Device (FPGA)
>              {
>                          Name (_HID, "PRP0001")
>                          Name (_DSD, Package ()
>                          {
> ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                                      Package ()
>                                      {
>                                                  Package () { 
> "compatible", "my-platform-driver-for-fpga" },
>                                      }
>                          })
>              }
>          }
>      }
> 
>     Scope(\_SB)
>     {
>          Device(OTHR)
>          {
>              GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly, 
> "\\_SB.PCI0.D0B0.ASIX.FPGA",) { 0 }
>          }
>     }
> 
> Is it even possible to register a host controller for another platform bus?
> 
> Thanks,
> Chris

