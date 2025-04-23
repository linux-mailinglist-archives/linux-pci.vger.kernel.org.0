Return-Path: <linux-pci+bounces-26532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2446BA98A13
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 14:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6458A17433D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83972182;
	Wed, 23 Apr 2025 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4je2rLn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84833DB
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412368; cv=none; b=fhT35xS36xfTt/I8u1f4il0VRmS5vSqJhRJ10n5AlvLYEkN7s3S+7Zx3Shj4cR9/te8wS8YB1WJcyySzCLHzpTpgujMB3m8g1cnplK6BH4+yF2FCZ9VSkUYCZxiSUywARn22k+UAp3kt//y7ZjRFO6id8soQpRTafSBSuqKqkO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412368; c=relaxed/simple;
	bh=LTD/jq8VinGp6HdSrm1dtdPn0rxzKodMQ00DIREzG/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxBRLWP90B48GZOE2DEq1xkSXSTyUKDvcj73kbqmTTvvkonlc3w5T3Yoh+JnBoptUaMH96NYIbyp1sFM+gjzyO22j+ususO/mLSEbeWNUoLp3tu/j04bdVeedhqn6tYHJMhnkuha3zELVmori2vbqkV7KVEGc0AxGXU42NPBiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4je2rLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4245EC4CEE2;
	Wed, 23 Apr 2025 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745412367;
	bh=LTD/jq8VinGp6HdSrm1dtdPn0rxzKodMQ00DIREzG/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4je2rLnriO8PgymFeTiAW54vBFFJCplAtCpcw6Ium10/5pnAGrCq75RbfP+jR4NY
	 HCyzPVSUw++/iBCcIxE720qlNoR3VDBdBceaIYV4ZdOyxhNrvoriJ375SDJZRE1VKP
	 GTZAhLUZzvaDtmztTOOI/slCMac4UuvV6njoV90/bGfQAIB3aQT/WUH295cwVcGR+P
	 BxRPYTViZVt/fAgWPPlgl6dpSoBSKSXXSYoAYs8GGNi/s/OpD+PQeOfUARI0Sjxcyu
	 b91Hs2MP/aYc0xmHRWgqtv3IxW9U119GxqtNnPkJb//Rl/kqIpqOgE35fYtXRCRHAT
	 HSBiZaISPYZwg==
Date: Wed, 23 Apr 2025 14:46:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, kw@linux.com, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH RESEND] misc: pci_endpoint_test: Defer IRQ allocation
 until ioctl(PCITEST_SET_IRQTYPE)
Message-ID: <aAjhC8nEJjy1XyIT@ryzen>
References: <174512170695.5723.16265162524139108187.b4-ty@linaro.org>
 <20250422175319.GA373387@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422175319.GA373387@bhelgaas>

On Tue, Apr 22, 2025 at 12:53:19PM -0500, Bjorn Helgaas wrote:
> On Sun, Apr 20, 2025 at 09:31:46AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, 16 Apr 2025 16:28:26 +0200, Niklas Cassel wrote:
> > > Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
> > > and 'no_msi'") changed so that the default IRQ vector requested by
> > > pci_endpoint_test_probe() was no longer the module param 'irq_type',
> > > but instead test->irq_type. test->irq_type is by default
> > > IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE)).
> > > 
> > > However, the commit also changed so that after initializing test->irq_type
> > > to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type, if
> > > the PCI device and vendor ID provides driver_data.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] misc: pci_endpoint_test: Defer IRQ allocation until ioctl(PCITEST_SET_IRQTYPE)
> >       commit: 9d564bf7ab67ec326ec047d2d95087d8d888f9b1
> 
> a402006d48a9c ("misc: pci_endpoint_test: Remove global 'irq_type' and
> 'no_msi'") appeared in v6.15-rc1, and apparently caused a regression
> that some driver fails to probe on such platforms.
> 
> Since a402006d48a9c caused a regression and hasn't appeared in a
> release yet, this sounds like a candidate for v6.15 via pci/for-linus?

I agree:
https://lore.kernel.org/linux-pci/Z_0mUhHzGqNrMBGg@ryzen/


> 
> I can move it if you agree.  I *would* like to have a little more
> detail about the regression, e.g., the affected driver, so I can
> justify merging this after the merge window.

All drivers without any driver_data defined, i.e.:
        { PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},


For those platforms, without this patch, you will get:
  pci-endpoint-test 0001:01:00.0: Invalid IRQ type selected
  pci-endpoint-test 0001:01:00.0: probe with driver pci-endpoint-test failed with error -22


Kind regards,
Niklas

