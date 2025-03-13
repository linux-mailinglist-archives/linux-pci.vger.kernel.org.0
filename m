Return-Path: <linux-pci+bounces-23665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A76A5FAEF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AC5188BD14
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086BD269825;
	Thu, 13 Mar 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5w9qBku"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8532690CB;
	Thu, 13 Mar 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881737; cv=none; b=eLDGztnWdxymSgxHVjmQ3j6UAR6p5alCB3i6ikItYsXAit0uTvmZuoTj3Iu3SrIIWkvFI9gcMzbm2cLO8HHRZ1J56LsfqAn3VCmh0ZBd0PekBjd/OdGqorUjetAQ5lvksdALOnnsKhtaNOaizBahESIJFYBHCitFMxE/ToNUoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881737; c=relaxed/simple;
	bh=yeXHcZgjUGF7P1GdENNOH+WMNLvGwDA1Vl+O4Y03fFM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SA7SGCNIcKK/7Zhk86Ks4cN9juiNcdflNlEUpj/tvxsyvpb776JS+3MriO+p26hdu9o7y/a88eqZoU09q2CC2eMLUfS9QblwDKTESu5AX63z34EHm/T2ngy3/fr+zgMfHBgi/PYdF3IbzDfzpAjlUFbaNxgYlbGux/mp59/5wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5w9qBku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACE5C4CEEA;
	Thu, 13 Mar 2025 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741881737;
	bh=yeXHcZgjUGF7P1GdENNOH+WMNLvGwDA1Vl+O4Y03fFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m5w9qBkuDQVNB4YeKXrBEztJzAJGHkUy75sZhJ+lyGei4s3zeKWOv0SZtQO31Gsa9
	 9zA5dwPqruTyKckVPVI3Sc2CPa9gE2fbKxs/DYBZvmfvZmjuHwYebhNnapwDXYjgiV
	 +Ru2nP7dQP72CsjCRT8/D0/0G9JAKdUV1QsxuEZEfiAJ85SAHNurCgF+sSUsWpdVo3
	 zhPn+Jxbv3jJ+xe+TaIpsptYh5bWhvbEA+03S0nIV0ZGEoNybkj3kpr3aGaPNTBxsR
	 kLyPJeq8zLyfGsv/w3L4UI8oyVPmLWleh4wEsuh06Ft+FLVf9nk7CsKy1c7lySb3X+
	 2njSxjG5yuz0Q==
Date: Thu, 13 Mar 2025 11:02:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, rogerq@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250313160215.GA736346@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313055519.j3bpvsm6govd5ytk@uda0492258>

On Thu, Mar 13, 2025 at 11:25:19AM +0530, Siddharth Vadapalli wrote:
> On Wed, Mar 12, 2025 at 11:16:00AM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 05, 2025 at 06:50:18PM +0530, Siddharth Vadapalli wrote:
> > > Commit under Fixes assigned the value of 'linkdown_irq_regfield' for the
> > > J784S4 SoC as 'LINK_DOWN' which corresponds to BIT(1). However, according
> > > to the Technical Reference Manual and Register Documentation for the J784S4
> > > SoC [0], BIT(1) corresponds to "ENABLE_SYS_EN_PCIE_DPA_1" which is __NOT__
> > > the field for the link-state interrupt. Instead, it is BIT(10) of the
> > > "PCIE_INTD_ENABLE_REG_SYS_2" register that corresponds to the link-state
> > > field named as "ENABLE_SYS_EN_PCIE_LINK_STATE".
> > 
> > I guess the reason we want this is that on J784S4, we ignore actual
> > link-down interrupts (and we don't write STATUS_CLR_REG_SYS_2 to clear
> > the interrupt indication, so maybe there's an interrupt storm), and we
> > think some other interrupt (DPA_1, whatever that is) is actually a
> > link-down interrupt?
> 
> While it is true that actual link-down interrupts are ignored, it is not
> the case that there's an interrupt storm because the same incorrect macro
> is used to enable the interrupt line. Since the enables an interrupt for
> DPA_1 which never fires, we don't run into the situation where we are not
> clearing the interrupt (the interrupt handler will look for the same
> incorrect field to clear the interrupt if it does fire for DPA_1, but that
> doesn't happen). The 'linkdown_irq_regfield' corresponds to the
> "link-state" field not just in the J784S4 SoC, but in all SoCs supported by
> the pci-j721e.c driver. It is only in J721E that it is BIT(1)
> [LINK_DOWN macro], while in all other SoCs (J784S4 included), it is BIT(10)
> [J7200_LINK_DOWN macro since it was first added for J7200 SoC]. Matt
> probably referred to J721E's Technical Reference Manual and ended up
> incorrectly assigning "LINK_DOWN", due to which the driver is enabling
> the DPA_1 interrupt and the interrupt handler is also going to look for
> the field corresponding to receiving an interrupt for DPA_1.

So I guess without this patch, we incorrectly ignore link-down
interrupts on J784S4.  It's good to have a one-sentence motivation
like that somewhere in the commit log that we can pull out and include
in the merge commit log and the pull request.

> I can only hope that the URL will redirect to the latest version of
> the User Guide if at all it becomes invalid.

OK, thanks, I guess there's nothing more to do ;)  I guess that manual
is not really designed for collaborative development.

Thanks for the patient hand holding!

Bjorn

