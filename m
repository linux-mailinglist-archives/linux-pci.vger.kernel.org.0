Return-Path: <linux-pci+bounces-25419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA3A7E790
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 19:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BF5189BBC9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7621423A;
	Mon,  7 Apr 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/fxj2Nh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E913C8E8;
	Mon,  7 Apr 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044795; cv=none; b=Sv0lCF8aF0j7+wTOQ7V4W6VYX5yYdXrmhGnZ05APwlpYvc+3aKluKcIQBfVS+zGT0IvVfMig6ttZcw0A0anBV0naEMhSOX6cHuMazulEwoSav2nTEPmthI6QnaOGnKj4T/ia75o8NDAfB+BQPWknrnlYqiiiykJeKEDUU4kxinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044795; c=relaxed/simple;
	bh=/5l4BinDGarHYEuUjkfx0ozu50otXKiCczW5dEwIajA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LTE+bBXmh7fSKZ95VX265jqJ3lidLYeNxPBfYiZeSvsxt1oXuCtMmOYjRj0uYGNXLhybwPnwf2zmFDLaShGEaVi0MBhTPYANbLz0lGyrU+sDC7Xn8aIuigt+Ki86LBKHRobw0SO5Ysq88KLySOHABu05r6FB9IWsBJES8jo1Vs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/fxj2Nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F73C4CEE7;
	Mon,  7 Apr 2025 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744044795;
	bh=/5l4BinDGarHYEuUjkfx0ozu50otXKiCczW5dEwIajA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t/fxj2NhB3YZ6qljNzqey3La1PfdPfgT/cFyqH/SO2VAa4PElW5NZV2fwE4EuGD3d
	 S0z38AJkDC1kApa972dpZaVJGzWT3SUbucu5nNX6Q8FoU7sh9gj5xPaZfThJZQV4u5
	 kJBIqz5m1vG0shjKDr0DAZ9WzVNszYjj2wioR0HZ7JFYkt50V36+V/cYUT8L3XFWrA
	 2zb5Nk0wf50652r9URCH8QQL02q+2uEZ+BiQFT+tD4v4IYXVctTweNYhzshIZ14ieo
	 YqMd/w4X111ey4gXoNNrcyYKE8l7TAML1+gfA3FAjjFVjpECKdPCEktXF+dFaUg1z5
	 IqCboSn1wkxFg==
Date: Mon, 7 Apr 2025 11:53:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Add sysfs support for exposing PTM context
Message-ID: <20250407165313.GA183057@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhtklncbcyphq2ljxn6w5p7wk4rdj5wxzskmlly4mrr664b2lj@w5clch5uzvd3>

On Mon, Apr 07, 2025 at 01:14:56PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 24, 2025 at 11:28:54AM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 24, 2025 at 03:34:35PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > Precision Time Management (PTM) mechanism defined in PCIe spec
> > > r6.0, sec 6.22 allows precise coordination of timing information
> > > across multiple components in a PCIe hierarchy with independent
> > > local time clocks.
> > > 
> > > PCI core already supports enabling PTM in the root port and
> > > endpoint devices through PTM Extended Capability registers. But
> > > the PTM context supported by the PTM capable components such as
> > > Root Complex (RC) and Endpoint (EP) controllers were not exposed
> > > as of now.
> > > 
> > > Hence, add the sysfs support to expose the PTM context to
> > > userspace from both PCIe RC and EP controllers. Controller
> > > drivers are expected to call pcie_ptm_create_sysfs() to create
> > > the sysfs attributes for the PTM context and call
> > > pcie_ptm_destroy_sysfs() to destroy them. The drivers should
> > > also populate the relevant callbacks in the 'struct
> > > pcie_ptm_ops' structure based on the controller implementation.
> > 
> > Can we include some motivation here, e.g., what is the value of
> > exposing this information?  Is this for debugging or bringup
> > purposes?  Can users or administrators use this for something?
> > Obviously they can read and update some internal PTM state, but it
> > would be nice to know what that's good for.
> 
> This was a request from one of the Qualcomm customers, but they
> didn't share how they are using these context. They just said that
> they want to collect the PTM timestamps for comparing with PTP
> timestamps from a different PCIe switch. That was not a worth of
> information to be mentioned in the cover letter, so I skipped it
> intentionally.

I think it is important to include a reason for merging a change.  The
mere fact that information exists is not enough reason to expose it
as a sysfs ABI.

> >  Consequently this probably can't be done by generic drivers like
> >  ACPI, and maybe this is a candidate for debugfs instead of sysfs.
> 
> Well, we can still create sysfs ABI for vendor specific features.
> Problem with debugfs is that the customers cannot use debugfs in a
> production environment.  Moreover, I cannot strictly classify PTM
> context as a debugging information.

I'm not convinced about making sysfs ABI for vendor-specific features.
I see that we do have a few existing things like this:

  Documentation/ABI/testing/sysfs-bus-pci-drivers-janz-cmodio
  Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
  Documentation/ABI/testing/sysfs-bus-pci-devices-avs

but I'm a bit hesitant to extend this model.

Bjorn

