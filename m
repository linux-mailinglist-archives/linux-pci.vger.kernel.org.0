Return-Path: <linux-pci+bounces-11148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BDD945511
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 02:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1A41F23126
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB108F47;
	Fri,  2 Aug 2024 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDTBVVFH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7B8825;
	Fri,  2 Aug 2024 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722556845; cv=none; b=CY2TNB9l+M0FhbVqblsXT9XcHaa5BjeipnQh5tlf5/SM85bwgkxOLv+j1rYolB71WTlVe71iuF5IA5JyCf2cUvXnhAUSHko9Sh3XvdyuMCmckamgseuL67Il2ABoecg/nUkMfNQh48o4KgaMXnPIasbDcQjmwF/mppQPYFHoNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722556845; c=relaxed/simple;
	bh=s9DRmZAOjs8AFVIVEvu7ZHkhOe+Yhnnol1+u2YrsI4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CQs0aCx7K+lxqsPQuerT3sQW+F5adcYQopXEm7IbTViASbnKv23ZwlA0V13+i+7ifCc+LrgUt31jv2yxD8Engc2hjoLVtKEpEzBk9GxqiZMi7miaCJSE8MtPl0OByHIvkjx2Clyb2ZmJg7gNnX3EMPFOMrOs7VyWLD2RWk5snyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDTBVVFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B54C32786;
	Fri,  2 Aug 2024 00:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722556845;
	bh=s9DRmZAOjs8AFVIVEvu7ZHkhOe+Yhnnol1+u2YrsI4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oDTBVVFHbNgvAsqzccEjJwB3Gxz1M7zwtaO75XU4AJ3GbWZT8F6Qs47EQkH4Ea3SS
	 X1D1s1EsQTP2UIC4JI9Bd4HJ61jTjUDAC82yYwzhtFCLCjqUcyhJj4bpCeFJREhFXq
	 7mWDjpcPmD38iJ/4Dcv5WpiApvrGIlOaw2DPgSekOLLEjAUoaUhpq3I78JGhBiyUfF
	 4WBbM6hcgXxi7Z6WIynbpghAcdU6DEc8nBhygyqvVLmCcu+ucEN6bgSLKfJ1xNHerI
	 lD3cB913uRGQbB0UTZZ1udq8kawz9D2pMEgNROnCGK+RrovM23UuNIwtPJtP6Axlft
	 C1wjYApIs7ktA==
Date: Thu, 1 Aug 2024 19:00:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: steven <steven_ygui@163.com>
Cc: linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	Vidya Sagar <vidyas@nvidia.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>
Subject: Re: does dtb not support pci acs enable?
Message-ID: <20240802000042.GA129381@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801234356.GA128584@bhelgaas>

On Thu, Aug 01, 2024 at 06:43:59PM -0500, Bjorn Helgaas wrote:
> [+cc ARM, IOMMU folks; I don't know the answer, but maybe they do]

[+cc Vidya, Pavan, also see this recent thread:
https://lore.kernel.org/r/PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com]

> On Fri, Jul 19, 2024 at 11:01:11PM +0800, steven wrote:
> > Hello,
> > 
> > I am a new person in PCI, I am trying to do something for iommu
> > group on arm64 platform, I found if I boot the linux (5.10 kernel)
> > kernel using UEFI + ACPI, it will work correctly. But if I boot it
> > using UEFI + DTB, the iommu group not work, only one group present.
> > 
> > I read the code, found that pci_acs_enable is set to 1 during
> > acpi_init, but I can not find any code for dtb booting, so it will
> > return "disable_acs_redir " during call pci_enable_acs. 
> >
> > static void pci_enable_acs(struct pci_dev *dev)
> > {
> >     if (!pci_acs_enable)
> >         goto disable_acs_redir;
> > 
> >     if (!pci_dev_specific_enable_acs(dev))
> >         goto disable_acs_redir;
> > 
> >     pci_std_enable_acs(dev);
> > 
> > 
> > 
> > 
> > SO, is it not support in dtb?
> > 

