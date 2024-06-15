Return-Path: <linux-pci+bounces-8862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCD909A02
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 23:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915CD1F212B2
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA221CAAC;
	Sat, 15 Jun 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKSGlNtX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014361870;
	Sat, 15 Jun 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718486766; cv=none; b=n3LwwSgVDpf30G24KJWaIbGrDx8WY46ltyB0J4ba7kEAUsBjJ/XvcCZHlQWdhHarnlpJ95rn7kC9tQ/uDCGRy95BL+0Fb5Vgy/DP29E7FoKMpPBqjJRKqbCucMLbycyfTFSJPEQjy1c+d1JshUuPUgaSvSnp13HqmSzvL/ux/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718486766; c=relaxed/simple;
	bh=IWW9A/n8TsLEyGyRo81wdPtnXrZ48OmSjXppUhL7hvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p6lMb4oonp7txXDC8kxgLdyLliHhvta/ibWuddMAZXIEH0WjJaWdc4n0LXK1RSJamiXYC673xvl0iSTmj+ay8f7g4U+OlGT7p0IjDGGWVqjdzoWa3nHjEZz67gQX7yvvvK7C/SqaKlRF0bK0fdE3Hfog3tg6KR9C4IyGvooAI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKSGlNtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC87C116B1;
	Sat, 15 Jun 2024 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718486765;
	bh=IWW9A/n8TsLEyGyRo81wdPtnXrZ48OmSjXppUhL7hvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qKSGlNtXmQRJZ0DD6CG1dYBKaax7NCCEn7bW22dvIEPYZYzPsmnJGt+crImsHs3n/
	 JcVLnB8MXdk2JPf+qaeO4QFhdKfNY2YRcE8xVOd+TL51PXr4hyFk8y+eTNVE6YhAv+
	 o/8QQo+V2REqlgsiw4AbHqZ92UN9Eu3Ab+Tr8aHv063AvfOmHPIZI8b7JC0T5LGS67
	 xV+YP1VCc0VyePvyJO0H9DazI+LSXEcQxmFEXoZ/FQ905vl/gBkFIh1Jqglcg4qTlh
	 /edTSTgNd4WLNyb/S96QtYPVcypOP/YPQqcbdALxlq3M02vKd4knSWyjF5Lh9NG0wG
	 5wEEgR9wLf02A==
Date: Sat, 15 Jun 2024 16:26:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Songyang Li <leesongyang@outlook.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Cancel compilation restrictions on function
 pcie_clear_device_status
Message-ID: <20240615212603.GA1157372@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB2754862E7F9F4DE1B25BF357B4C32@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>

On Sat, Jun 15, 2024 at 11:13:07AM +0800, Songyang Li wrote:
> On Wed, 12 Jun 2024 15:14:32 -0500, Bjorn Helgaas wrote:
> > I think all current any callers of pcie_clear_device_status() are also
> > under CONFIG_PCIEAER, so I don't think this fixes a current problem.
> > 
> > As you point out, it might make sense to use
> > pcie_clear_device_status() even without AER, but I think we should
> > include this change at the time when we add such a use.
> > 
> > If I'm missing a use with the current kernel, let me know.
> 
> As far as I know, some PCIe device drivers, for example,
> [net/ethernet/broadcom/tg3.c],[net/ethernet/atheros/atl1c/atl1c_main.c],
> which use the following code to clear the device status register,
> pcie_capability_write_word(tp->pdev, PCI_EXP_DEVSTA,
>                 PCI_EXP_DEVSTA_CED |
>                 PCI_EXP_DEVSTA_NFED |
>                 PCI_EXP_DEVSTA_FED |
>                 PCI_EXP_DEVSTA_URD);
> I think it may be more suitable to export the pcie_clear_device_status()
> for use in the driver code.

If we want to use this from drivers, it would make sense to do
something like this patch, and this patch could be part of a series to
call it from the drivers.

But at the same time, we should ask whether drivers should be clearing
this status themselves, or whether it should be done by the PCI core.

Bjorn

