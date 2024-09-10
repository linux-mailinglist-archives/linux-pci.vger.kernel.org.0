Return-Path: <linux-pci+bounces-13018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A298B974637
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 01:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D351C1C24B91
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 23:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C01AAE34;
	Tue, 10 Sep 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrHTLWpK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD891A4F3A
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009498; cv=none; b=XlrKUYW/yD70DPItnyz5PLESxOR3TvzflmSHN9l3LVd5gQkUg7/E2Nk0kMqAxksCgdrA6jvr0KgDO0LujhkUjnDVe8fTASz6SPXDQ0xJsoX38KiDXg0GqcQFW+7UjzYmidArqcZJArkgB4ADKGSJ19Ace8FEMFmgWoo6rs7iYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009498; c=relaxed/simple;
	bh=s1AbD4HIuULxNzAhOhfWwB98+TuIwY7rIxBxdXLpHmY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gGRlYxxEW849b6q4NMF6qe2wZoOxWXPe9Eh4jY4/KPP40EHOIHXlt/K5bnRKHxiXGxQo+bdxS3fImNmQp+TyJQFiK/vJ9Ql8M3byXFbjND8Dx02DmPdcoZ/PODMCjVOR7DRl1Mg2zlkUgsv3PYYFLn9vwfcCWXgHt2mGEg8ZDHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrHTLWpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4AEC4CECC;
	Tue, 10 Sep 2024 23:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726009498;
	bh=s1AbD4HIuULxNzAhOhfWwB98+TuIwY7rIxBxdXLpHmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HrHTLWpKZH7NRFN9zyLklza9zgiskyG/D7SK5NBU40XY2k+qiEVVlcrCwIu6uw032
	 /aapUrhtoOhhGMwC0GZ0k4nxBuqP85qIOug1ITz9SXqJf7Dczs77bOPJ2IfC5My39E
	 d63C3onfiCax/a8ft69I3k8lngF1/WmK8WkDOnH62N/KIqlAYgVpyroVTeDYcM7nWr
	 wGfUhHPiahmZ92WXce20YbmoYMV1TQ4ZZw4qk7C6T2+V5r9lUBkni5naKHi750J4st
	 cM2hXAKc/k7FU9dOt5QUSI9DsaadplcG0XB9n+P5pxGl5WLGL7YTDKhsbi1WErg3Zc
	 sDybS2/97fvaQ==
Date: Tue, 10 Sep 2024 18:04:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Frank Li <Frank.li@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <20240910230455.GA608446@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU0fuoBtpmKSs4hgi9=deBazML+KSJy+cqkou6mPumjwvQ@mail.gmail.com>

On Tue, Sep 10, 2024 at 09:50:02AM -0700, Tim Harvey wrote:
> On Fri, Sep 6, 2024 at 12:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Sep 06, 2024 at 12:37:42PM -0700, Tim Harvey wrote:
> > > ...
> >
> > > I have the hardware in hand now as well as the out-of-tree driver
> > > that's being used. I can say there is nothing wrong here with legacy
> > > PCI interrupt mapping, if I write a skeleton driver that uses
> > > pci_resister_driver(struct pci_driver) its probe is called with an
> > > interrupt and request_irq on that interrupt succeeds just fine.
> > >
> > > The issue here is with the vendor's out-of-tree driver which instead
> > > is using pci_get_device() to scan the bus which returns a struct
> > > pci_dev * that doesn't have an irq assigned (like what is described
> > > in
> > > https://www.kernel.org/doc/html/v5.5/PCI/pci.html#how-to-find-pci-devices-manually).
> > > When using pci_get_device() when/how does pci_assign_irq() get
> > > called to assign the irq to the device?
> >
> > Hmmm.  pci_get_device() is strongly discouraged because it subverts
> > the driver model (it skips the usual driver probe/claim model so it
> > allows multiple drivers to operate the device simultaneously which can
> > obviously cause conflicts), and it doesn't play well with hotplug
> > (hotplug events automatically cause driver .probe() methods to be
> > called, but users of pci_get_device() have to roll their own way of
> > doing this).
> >
> > So I'm not aware of a documented/supported way to set up the INTx
> > interrupts in the pci_get_device() case.
> 
> Makes sense to me. Perhaps some changes to Documentation/PCI/pci.rst
> could explain this.

Yeah, that would be a good idea.

> Thanks for the help here, glad to find there is nothing broken here. I
> think there could have been some confusion by the user here because
> they were used to x86 assigning irq's without using
> pci_resister_driver() but they were also using a kernel param of
> pci=routeirq which looks like its an x86 only temporary workaround
> that may have made this work on that architecture.

I wondered about "pci=routirq", but I lost the trail and couldn't
figure out how that would lead to pci_assign_irq() or something
functionally equivalent.

Bjorn

