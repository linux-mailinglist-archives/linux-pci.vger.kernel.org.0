Return-Path: <linux-pci+bounces-17601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F12AE9E2EBA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20F1B2E1C2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EBB209F44;
	Tue,  3 Dec 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gitIX0AS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B91209678;
	Tue,  3 Dec 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261535; cv=none; b=hegd0JWXfDBjvnUTOBQzEABSgGMmT9DHa79EPJ/8VdCvQRKfE5ocsMa4b77FvK+u4QfbT+PKzm1I7mC3vOOGS0zVafbma0boGLuhsRKaO6aJIK7m1IMJD0pGeB7OS1QXlJyLnk6w4LSNTKC32bAU7cJBVVAM/u/8xDkcpR5LKm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261535; c=relaxed/simple;
	bh=DhgiLvL+m2Tn8uWHAPtO3YZr1lqo8Pn2CqNnVLXGezo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E1XPocgiWrS50TvdQu9HMUGK8EjLob8sH5QI3gNab2RnkE6Iuk/gctj4s9bYM4oziQqoXYx7xFKK/29MyJllINFLOq1/HiiqeythSN3PmZ02i5LoSsAo9+8ZADlZobCKOA6lLczMyBECRpqE4OCRpPvydgrnQbQkOs0uulW8ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gitIX0AS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FC5C4CED8;
	Tue,  3 Dec 2024 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733261535;
	bh=DhgiLvL+m2Tn8uWHAPtO3YZr1lqo8Pn2CqNnVLXGezo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gitIX0ASrfazwTlGTVTkgLagyLqVELlLQtQiyC3aU8MXV9pjLuCSwvIbzDGT9/hi/
	 4EDY4cMwfPDvSARii4qbITxZ8oZEhpZhrmwSdCigp7Wgd1T78uFhGdPbvWeR3A44rk
	 TvCmfTR6GsxL5Ax2ZdjVF5NIk4cSmPHQCHjgxKYnOpAuY467WcRPsBnFoLqW2rmRx9
	 0xTJL27kdVK+i0J5501uyKMo/Jf08P7gteoRJO0HKuSlrPSNU1yU2sFDrIEju9Ob23
	 Q+WG0KwrlS7lkHiUjdhFk2FXOLYDm233WMp+XC6Xhz2H2vaOm6nf18Q9kApz1BrXD8
	 NBu7eKTkLENuA==
Date: Tue, 3 Dec 2024 15:32:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: Constify 'struct bin_attribute'
Message-ID: <20241203213213.GA2965613@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>

On Mon, Dec 02, 2024 at 08:02:56PM +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> The usage of read_new/write_new/bin_attrs_new is a transition mechanism
> and will be reverted after the transition is complete.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Applied to pci/constify for v6.14, thanks.

Logan, I converted your response at
https://lore.kernel.org/all/003d2d13-13be-4f05-80f8-61e14ddb9c83@deltatee.com/
to include "Reviewed-by".

Let me know if that's not what you intended.

> ---
> Thomas Weißschuh (4):
>       PCI/sysfs: Constify 'struct bin_attribute'
>       PCI/VPD: Constify 'struct bin_attribute'
>       PCI/P2PDMA: Constify 'struct bin_attribute'
>       PCI/ACPI: Constify 'struct bin_attribute'
> 
>  drivers/pci/hotplug/acpiphp_ibm.c |  6 +++---
>  drivers/pci/p2pdma.c              |  6 +++---
>  drivers/pci/pci-sysfs.c           | 42 +++++++++++++++++++--------------------
>  drivers/pci/vpd.c                 | 14 ++++++-------
>  4 files changed, 34 insertions(+), 34 deletions(-)
> ---
> base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
> change-id: 20241201-sysfs-const-bin_attr-pci-be2425e1a856
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 

