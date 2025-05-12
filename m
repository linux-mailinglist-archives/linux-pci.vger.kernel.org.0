Return-Path: <linux-pci+bounces-27581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D4AB3932
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 15:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB0E175153
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F420322;
	Mon, 12 May 2025 13:28:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF5293472
	for <linux-pci@vger.kernel.org>; Mon, 12 May 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056532; cv=none; b=pUL1Lvyu4rpgYSRez5RTVkteIK1gqeMmy+qwbbepnMBiCUnMs495KirCTTLoH3/5h6q9R0VDEou+Rc84mESN7M5DthDFDlYoTWUNAUQmFDiR+77jfWSBu8oIaNb6KZErrRyI3yczu1TpUviHUWbGhp7v/9YRrQafsVr8SHvsATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056532; c=relaxed/simple;
	bh=cjg5Nyvk3DTo1FNcNaSVZp1aUeCUSxeKdkJ57MXgsX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDmmNElPdqFz2xqPx4xrnlNjVUrP3XhKe1VJiIj8FonjPqFLZyiu4F1aduF7tpEHnZJFeGTtbOZGSmztLtTKrv3HdZxGFweKlkM2SWIKAD3rU/rm5w9ICG3HHVHo8+/AoG1sb0qIZMPQJs0beAL497sz9k/WoPtCJe0pvBmIk7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id ABB792C06E34;
	Mon, 12 May 2025 15:28:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3161B4A8A1; Mon, 12 May 2025 15:28:40 +0200 (CEST)
Date: Mon, 12 May 2025 15:28:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Borislav Petkov <bp@alien8.de>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] Revert "iommu/amd: Prevent binding other PCI drivers
 to IOMMU PCI devices"
Message-ID: <aCH3iLGyEl81d9i2@wunner.de>
References: <cover.1745572340.git.lukas@wunner.de>
 <9a3ddff5cc49512044f963ba0904347bd404094d.1745572340.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3ddff5cc49512044f963ba0904347bd404094d.1745572340.git.lukas@wunner.de>

Dear AMD IOMMU maintainers,

Just a gentle reminder:

Please consider ack'ing the patch below, for merging through the pci tree.

The patch removes code which prevents driver binding to the pci_dev
exposed by an AMD IOMMU.  No other IOMMU driver does that or needs that.

The code was added to work around breakage introduced by 991de2e59090:
With that commit, resume from system sleep was broken when a driver was
bound to the AMD IOMMU (e.g. vfio-pci).  The commit has since been
reverted, so there is no apparent reason to continue preventing
driver binding to the AMD IOMMU.

Random drivers are not supposed to fiddle with the match_driver flag
in struct pci_dev and having the AMD IOMMU driver do that is a
maintance burden.

So unless there's a reason to keep this code, please ack the patch below.

Thank you!

Lukas

On Fri, Apr 25, 2025 at 11:24:21AM +0200, Lukas Wunner wrote:
> Commit 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
> pcibios_free_irq()") changed IRQ handling on PCI driver probing.
> It inadvertently broke resume from system sleep on AMD platforms:
> 
>   https://lore.kernel.org/r/20150926164651.GA3640@pd.tnic/
> 
> This was fixed by two independent commits:
> 
> * 8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is enabled")
> * cbbc00be2ce3 ("iommu/amd: Prevent binding other PCI drivers to IOMMU
>                  PCI devices")
> 
> The breaking change and one of these two fixes were subsequently reverted:
> 
> * fe25d078874f ("Revert "x86/PCI: Don't alloc pcibios-irq when MSI is
>                  enabled"")
> * 6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq() and
>                  pcibios_free_irq()"")
> 
> This rendered the second fix unnecessary, so revert it as well.  It used
> the match_driver flag in struct pci_dev, which is internal to the PCI core
> and not supposed to be touched by arbitrary drivers.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> I would have cc'ed Jiang Liu (author of the commit reverted here)
> but his Intel e-mail address appears to no longer be working.
> Someone with the same name has recently started to contribute
> using an Alibaba e-mail address, but I'm not sure it's the same
> person.
> 
>  drivers/iommu/amd/init.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index dd9e26b..33b6e12 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2030,9 +2030,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  	if (!iommu->dev)
>  		return -ENODEV;
>  
> -	/* Prevent binding other PCI device drivers to IOMMU devices */
> -	iommu->dev->match_driver = false;
> -
>  	/* ACPI _PRT won't have an IRQ for IOMMU */
>  	iommu->dev->irq_managed = 1;
>  
> -- 
> 2.47.2

