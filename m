Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D9B1B0431
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 10:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgDTITQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 04:19:16 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48932 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTITQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 04:19:16 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id BCD734F569;
        Mon, 20 Apr 2020 08:19:07 +0000 (UTC)
Message-ID: <13564b9a57f734524357a26665c48211e436e305.camel@aosc.io>
Subject: Re: [RFC PATCH] PCI: dwc: add support for Allwinner SoCs' PCIe
 controller
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Date:   Mon, 20 Apr 2020 16:18:58 +0800
In-Reply-To: <20200406082732.nt5d7puwn65j4nvl@gilmour.lan>
References: <20200402160549.296203-1-icenowy@aosc.io>
         <20200406082732.nt5d7puwn65j4nvl@gilmour.lan>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1587370752;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=pvH6iSsYcrlSeIVQKlxTDceU5G6X0/BLxZ6SjrM8hqs=;
        b=jWJHu3CfoBStlnD7HAMF8CReqSqLOEfzgiTCkOcL0L3EaFstbOzaX6XfzDESmGnFOaWKMx
        MFVRRdsirVgRlt+3h6O6GWmgG+K2n16Ow54t3v7gEK3myO/5F/386kvhaIiJdakasAxr8I
        1ZA+7o372FXcMxh8rqGr0ZSU7sTaK84=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

在 2020-04-06星期一的 10:27 +0200，Maxime Ripard写道：
> Hi,
> 
> On Fri, Apr 03, 2020 at 12:05:49AM +0800, Icenowy Zheng wrote:
> > The Allwinner H6 SoC uses DesignWare's PCIe controller to provide a
> > PCIe
> > host.
> > 
> > However, on Allwinner H6, the PCIe host has bad MMIO, which needs
> > to be
> > workarounded. A workaround with the EL2 hypervisor functionality of
> > ARM
> > Cortex cores is now available, which wraps MMIO operations.
> > 
> > This patch is going to add a driver for the DWC PCIe controller
> > available in Allwinner SoCs, either the H6 one when wrapped by the
> > hypervisor (so that the driver can consider it as an ordinary PCIe
> > controller) or further not buggy ones.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > There's no device tree binding patch available, because I still
> > have
> > questions on the device tree compatible string. I want to use it to
> > describe that this driver doesn't support the "native Allwinner H6
> > PCIe
> > controller", but a wrapped version with my hypervisor.
> > 
> > I think supporting a "para-physical" device is some new thing, so
> > this
> > patch is RFC.
> > 
> > My hypervisor is at [1], and some basic usage documentation is at
> > [2].
> > 
> > [1] https://github.com/Icenowy/aw-el2-barebone
> > [2] 
> > https://forum.armbian.com/topic/13529-a-try-on-utilizing-h6-pcie-with-virtualization/
> 
> I'm a bit concerned to throw yet another mandatory, difficult to
> update, component in the already quite long boot chain.
> 
> Getting fixes deployed in ATF or U-Boot is already pretty long,
> having
> another component in there will just make it worse, and it's another
> hard to debug component that we throw into the mix.
> 
> And this prevents any use of virtualisation on the platform.
> 
> I haven't found an explanation on what that hypervisor is doing
> exactly, but from a look at it it seems that it will trap all the
> accesses to the PCIe memory region to emulate a regular space on top
> of the restricted one we have?
> 
> If so, can't we do that from the kernel directly by using a memory
> region that always fault with a fault handler like Framebuffer's
> deferred_io is doing (drivers/video/fbdev/core/fb_defio.c) ?

I don't know well about the memory management of the kernel. However,
for PCIe memory space, the kernel allows simple ioremap() on it. So
wrapping it shouldn't be so easy.

And I think the maintainer of pcie-tango suffers from a even more
simple issue -- PCI config space and MMIO space are muxed. They failed
to wrap MMIO I/O, and make a warning and taint the kernel. pcie-tango
is mentioned in my previous discussion on H6 PCIe, see [1].

[1] https://www.spinics.net/lists/linux-pci/msg70064.html

> 
> Maxime

