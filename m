Return-Path: <linux-pci+bounces-26620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB83A99B64
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 00:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A587AFA41
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 22:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDE21ACED3;
	Wed, 23 Apr 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZopDPhYn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A52701BE
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446762; cv=none; b=KX9aT7XTfQbypjNOyrMOs6l+1+llStUfvOpSG7E36FX9v/RQ87SwBti/jOJzaAyDecUNfkJ50G9IR3zmjKSzrYsQfRDa6KKe9nUSJy9+QRY1GW590sMFXWKWekSLEIA2JdWKy79TE+eAfcFLzfSEedhbeTd9hxwpq0Kplqu0YsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446762; c=relaxed/simple;
	bh=TQFjGrVWFdsVHsMd5yyXhlvTRRegEqckCVZ8F/WuOys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pIhRy/d1ZMNIac4wJIG3eLokDSey3Ck4XawatCDd05mxg95tB6oK48ppij/RnZTdrC4KyV4kEOqGESmuBNteO0ofpJkHCl2a7F0uYt329vK8IwWMIl0ZuK/srcgk+LkDyUH4NZ2rk9RfU4eSGcNLJ5gPBlgv2eVLn+WHL93Xp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZopDPhYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB07C4CEE2;
	Wed, 23 Apr 2025 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745446762;
	bh=TQFjGrVWFdsVHsMd5yyXhlvTRRegEqckCVZ8F/WuOys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZopDPhYnuE4in3/OkN9BYhtRbctjpelgEGOk7RqEBPDSEaqkVXFqSVSPHgApk7lDa
	 D9Of7RYx99mOrh0GUSa+bVr7exTpCg2OG4dk9t8RFLqjP8hqGM5XA/P+vDiabPoQcG
	 VOkuLwQxMUKJPs3c3ij9Xr+99JxP+iJwxDfWOJVKrKWPFZOLI9UC4/njuiRfehKyc9
	 5d52LEYH/bMKvgcQekzaeDOLyTl82/EPf8WFPGB/26I9kN4GUikmRFkKkmlF2Tb2tZ
	 ii1YX/03zMTas8fmY4+6GHcrgkXOaxUd28CDybemt6OB3gt4eLFm6rqDhCjGbqarsw
	 sREjXFrICG1wQ==
Date: Wed, 23 Apr 2025 17:19:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, kw@linux.com, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH RESEND] misc: pci_endpoint_test: Defer IRQ allocation
 until ioctl(PCITEST_SET_IRQTYPE)
Message-ID: <20250423221920.GA460034@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAjhC8nEJjy1XyIT@ryzen>

On Wed, Apr 23, 2025 at 02:46:03PM +0200, Niklas Cassel wrote:
> On Tue, Apr 22, 2025 at 12:53:19PM -0500, Bjorn Helgaas wrote:
> > On Sun, Apr 20, 2025 at 09:31:46AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, 16 Apr 2025 16:28:26 +0200, Niklas Cassel wrote:
> > > > Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
> > > > and 'no_msi'") changed so that the default IRQ vector requested by
> > > > pci_endpoint_test_probe() was no longer the module param 'irq_type',
> > > > but instead test->irq_type. test->irq_type is by default
> > > > IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE)).
> > > > 
> > > > However, the commit also changed so that after initializing test->irq_type
> > > > to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type, if
> > > > the PCI device and vendor ID provides driver_data.
> > > > 
> > > > [...]
> > > 
> > > Applied, thanks!
> > > 
> > > [1/1] misc: pci_endpoint_test: Defer IRQ allocation until ioctl(PCITEST_SET_IRQTYPE)
> > >       commit: 9d564bf7ab67ec326ec047d2d95087d8d888f9b1
> > 
> > a402006d48a9c ("misc: pci_endpoint_test: Remove global 'irq_type' and
> > 'no_msi'") appeared in v6.15-rc1, and apparently caused a regression
> > that some driver fails to probe on such platforms.
> > 
> > Since a402006d48a9c caused a regression and hasn't appeared in a
> > release yet, this sounds like a candidate for v6.15 via pci/for-linus?
> 
> I agree:
> https://lore.kernel.org/linux-pci/Z_0mUhHzGqNrMBGg@ryzen/
> 
> > I can move it if you agree.  I *would* like to have a little more
> > detail about the regression, e.g., the affected driver, so I can
> > justify merging this after the merge window.
> 
> All drivers without any driver_data defined, i.e.:
>         { PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),},
>         { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
>         { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
>         { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
>         { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
> 
> 
> For those platforms, without this patch, you will get:
>   pci-endpoint-test 0001:01:00.0: Invalid IRQ type selected
>   pci-endpoint-test 0001:01:00.0: probe with driver pci-endpoint-test failed with error -22

So I guess this means it's "only" the host side
pci_endpoint_test_driver that won't probe, and the problem only
happens on the host controllers listed above or controllers with
programmable Vendor/Device ID that are set to match one of these?

I cherry picked this patch to pci/for-linus for v6.15, thanks!

Mani, this was the only patch on pci/misc-endpoint, so I deleted the
branch.

Bjorn

