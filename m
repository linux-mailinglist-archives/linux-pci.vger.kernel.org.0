Return-Path: <linux-pci+bounces-5103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E2588A82D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C80297D5E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9246EEA8;
	Mon, 25 Mar 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMf5Mp3A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74418E06;
	Mon, 25 Mar 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374315; cv=none; b=SNM7PFsefZfi7jozshWWnGukbasfUlfatcS4hjpC7o8Y04x7241mcfkM4bfjBsFUXg12E/qxpWhfDVNwqgjC3Ku5f+Dq5UM6o2n7tEoLSCOOm//eEbMph3xJq8YE3bScQBNyYpTR1OeNb7tHeaR9olc7eKDgZhZz9JVOSFy8XCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374315; c=relaxed/simple;
	bh=90Iz9iyrvW8Dl1oS3Fv68W9xqNcVjqXw7FwBwxU9Ewo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if9ouedcJ3csT85xVplcefeD6Q1cOFZWm6mGeGE0NkURb2RHYFPJ7iC7SG1/6xf4Rygk4TOb9uomlI3HJYmRJCzdh7KM1mrFjYvm59RYiLlgU+3/nU7OYyf9QI+rQ7SqQDesUNfAjB3mSoyzP++hvXcEj46tFTXQKeRePt0n188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMf5Mp3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D87BC433C7;
	Mon, 25 Mar 2024 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711374315;
	bh=90Iz9iyrvW8Dl1oS3Fv68W9xqNcVjqXw7FwBwxU9Ewo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMf5Mp3AFZOQGWZyqAgvH2/qFFGURd1eoGZRSmzifZNNO83wi2vaP8EzZGXVN5tWC
	 hLvRWOLGv6OecYkuZ7VQp/wcauHKCv83nCgJyqPInfaifVBn5x2xPZvA1jgvrGfr5e
	 lVqDOp/NMaYejmj6pjvGEZJwusxtfCp97fB1P0AFvovFagB0Syydpi0H1wvOMcb/rs
	 Mmrnz6hG80YNA+nF/MwFkDvkSkcYtRd/7IACuVgVgur4r0NidOtaJDbJ4YWlQv8PBY
	 4IVa8nxuuVzDpxRlgt+x3mhKCnIDmXpIZv1WexIwdyR3CEU1cRiN6Vik+Tx8/kaxgW
	 6o+4jYxTmT+vw==
Date: Mon, 25 Mar 2024 14:45:09 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com, u.kleine-koenig@pengutronix.de,
	dlemoal@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v4] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <ZgF_5fYsI5lOFjOv@ryzen>
References: <20240325053722.1955433-1-s-vadapalli@ti.com>
 <ZgFemQ8gHpB8yMef@ryzen>
 <ea0294d4-85d1-4784-acd7-dd247165f69b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0294d4-85d1-4784-acd7-dd247165f69b@ti.com>

Hello Siddharth,

On Mon, Mar 25, 2024 at 05:52:28PM +0530, Siddharth Vadapalli wrote:
> On Mon, Mar 25, 2024 at 12:23:05PM +0100, Niklas Cassel wrote:
> > On Mon, Mar 25, 2024 at 11:07:22AM +0530, Siddharth Vadapalli wrote:
> > > @@ -822,6 +788,23 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
> > >  	if (ret < 0)
> > >  		return ret;
> > >
> > 
> > > +	if (!ks_pcie->is_am6) {
> > 
> > Perhaps add a comment here stating WHY this is needed for v3.65a (!is_am6).
> > 
> > From reading the old threads, it appears that v3.65a:
> > -Has no support for iATUs. iATU-specific resource handling code is to be
> >  bypassed for v3.65 h/w. Thus v3.65a has it's own .child_ops implementation,
> >  so that pcie-designware-host.c does not configure the iATUs.
> > -v3.65a has it's own .msi_init implementation, so that pcie-designware-host.c
> >  does not call dw_pcie_msi_host_init() to configure the MSI controller.
> > 
> > While 4.90a:
> > -Does have iATU support.
> > -Does use the generic dw_pcie_msi_host_init().
> > 
> > Considering the major differences (with v3.65a being the outlier) here,
> > I think it would have been a much wiser idea to have two different glue
> > drivers for these two compatibles (ti,keystone-pcie and ti,am654-pcie-rc).
> > 
> > Right now the driver is quite hard to read, most of the functions in this
> > driver exist because v3.65a does not have an iATU and does not use the
> > generic DWC way to handle MSIs. Additionally, you have "if (!ks_pcie->is_am6)"
> > spread out all over the driver, to control quite major things, like if you
> > should overload .child_ops, or if you should set up inbound translation without
> > an iATU. This makes is even harder to see which code is actually used for
> > am654... like the fact that it actually uses the generic way to handle MSIs...
> > 
> > The driver for am654 would be much nicer since many of the functions in
> > this driver would not be needed (and the fact that you have only implemented
> > EP support for am654 and not for v3.65a). All EP related stuff would be in
> > the am654 file/driver.
> > You could keep the quirky stuff for v3.65a in the existing pci-keystone.c
> > driver.
> > 
> > (I guess if there is a function that is identical between the twos, you could
> > have a pci-keystone-common.{c,h}  that can be used by both drivers, but from
> > the looks of it, they seem to share very little code.
> 
> Thank you for reviewing the patch. I agree that two drivers will be
> better considering the !ks_pcie->is_am6 present throughout the driver.
> However, I hope you notice the fact that commit:
> 6ab15b5e7057 PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
> introduced a regression in a driver which was working prior to that
> commit for AM654. While there are flaws in the driver and it needs to be
> split to handle v3.65a and other versions in a cleaner manner, I am
> unable to understand why that is a precursor to fixing the regression.
> 
> If splitting the driver is the only way to fix this regression, please
> let me know and I will work on that instead, though it will take up more
> time.

I think you are misunderstanding me.

I think this patch is fine, except for the comment that I gave:
"Perhaps add a comment here stating WHY this is needed for v3.65a (!is_am6)."

Like:

/*
 * This is only needed for !am654 since it has its own msi_irq_chip
 * implementation. (am654 uses the generic msi_irq_chip implementation.)
 */
if (!ks_pcie->is_am6) {
	...
}


In fact, if you move this code to ks_pcie_msi_host_init(), instead of
ks_pcie_host_init(), you would not need a comment (or a if (!ks_pcie->is_am6)),
since ks_pcie_msi_host_init() is only executed by !am654.




My suggestion to split this driver to two different drivers is just because
I noticed how different they are (am654 has iATUs, uses generic msi_irq_chip
implementation and has EP-mode support. !am654 has no iATUs, its own MSI
implementation and no EP-mode support.)

So the am654 driver would look like most other DWC glue drivers.
The non-am654 driver would look mostly like it looks today, except you would
remove the EP-mode support.

However, this suggestion can of course be implemented sometime in the future
and should not be a blocker for the patch in $subject.


Kind regards,
Niklas

