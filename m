Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0643E4DE1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 22:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhHIUds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 16:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234411AbhHIUdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 16:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1BDB60F38;
        Mon,  9 Aug 2021 20:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628541205;
        bh=DFiNEUy2lvl0A6Ke0FlRdCTRadumSQO3fJWSprWIjkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IPtXplkkizVttFmHqlKMMFVrf/9c28Yq43Zod3JrNDwkRD6vsFt7in9VpcExI6znz
         YoJLbOclV7GGtf3DQoNfEnIGkfppFNgBtwGZ4c5kOP8Ly4aW7LX/fMgTKcd4Zwi5gx
         DVqlkFbvbNjB2HZ8A9uVNJXUocSQb21qDkD4E+yM9p9y7mPIGwUeYwtcXWwo9itZ5p
         2LOYzvN/u/RSkAhNNJ4m2D/Y6shJp3G7P7ewVxVZ1kYaehrZ6rFn+4bGJSHEEWPIZ7
         XFLMY3N8Bh3e0CGavp3WrAS4smZFoIu5ySgfUXuhKQ1eNdU4kTeFeAH+VLy80TJJuZ
         b3tCIaSJlRbeg==
Date:   Mon, 9 Aug 2021 15:33:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add ACPI config space quirk
Message-ID: <20210809203323.GA2184624@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d4732b9-e8df-3803-2db7-c6eef1196269@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 09, 2021 at 02:48:17PM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 8/9/21 12:42 PM, Bjorn Helgaas wrote:
> > On Fri, Aug 06, 2021 at 09:55:27PM -0500, Jeremy Linton wrote:
> > > Hi,
> > > 
> > > On 8/6/21 5:21 PM, Bjorn Helgaas wrote:
> > > > On Thu, Aug 05, 2021 at 04:11:59PM -0500, Jeremy Linton wrote:
> > > > > The PFTF CM4 is an ACPI platform that is following the PCIe SMCCC
> > > > > standard because its PCIe config space isn't ECAM compliant and is
> > > > > split into two parts. One part for the root port registers and a
> > > > > moveable window which points at a given device's 4K config space.
> > > > > Thus it doesn't have a MCFG (and really any MCFG provided would be
> > > > > nonsense anyway). As Linux doesn't support the PCIe SMCCC standard
> > > > > we key off a Linux specific host bridge _DSD to add custom ECAM
> > > > > ops and cfgres. The cfg op selects between those two regions, as
> > > > > well as disallowing problematic accesses, particularly if the link
> > > > > is down because there isn't an attached device.
> > > > 
> > > > I'm not sure SMCCC is *really* relevant here.  If it is, an expansion
> > > > of the acronym and a link to a spec would be helpful.
> > > > 
> > > > But AFAICT the only important thing here is that it doesn't have
> > > > standard ECAM, and we're going to work around that.
> > > 
> > > I will reword it a bit.
> > > 
> > > > I don't see anything about _DSD in this series.
> > > 
> > > That is the "linux,pci-quirk" in the next patch.
> > 
> > The next patch doesn't mention _DSD either.  Is it obfuscated by
> > being inside fwnode_property_read_string()?  If so, it's well and
> > truly hidden; I gave up trying to connect that with ACPI.
> 
> Right, the fwnode stuff works as a DT/ACPI abstraction for reading values
> from firmware tables. In this case the ACPI definition looks something like:
> 
> Device(PCI0) {
> ...
>   Name (_DSD, Package () {
>   ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>     Package () {
>     Package () { "linux-pcie-quirk", "bcm2711" },
>   }
>   })
> 
> ...
> }
> 
> Which explains a bit of why the underlying code is a bit uh... complicated.

Wow, that's ... special.

I think I would include "ecam" or something in the name.  There might
be a variety of quirks, e.g., "P2PDMA allowed between root ports",
that could reasonably fit under "linux-pcie-quirk".
