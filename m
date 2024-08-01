Return-Path: <linux-pci+bounces-11145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A29454FA
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 01:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0711C229BF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 23:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634914D294;
	Thu,  1 Aug 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNJEQ/Vs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78625757;
	Thu,  1 Aug 2024 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722555839; cv=none; b=i/ml/cOvEkIEkVnOK5A5uF5JEPkL+LTWpZjJJlrn2WA9+ZSgDCZX65W2B8/yBH8D3I3vymHlmE1qodd3TwDDsA6bhswVUgRj7916ZXQMksQQml+6BhGxmZdgMF91gVdCr7rQyt5GHZf5YzYDaX2VgRivVrWl6YIAcgcDjNU94O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722555839; c=relaxed/simple;
	bh=SzHZxUFqNTMwJ8KvcmNhUWoSQkRJhCngR3KcpXsTVtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RzRKleUcRZxolx4+Ja3Lb+GKqbJ3Ps0fUCh9vrVBcx9Nq/HLj8D3rhunHFlxy63qSKs3dN2jm28ZHvrcNLvvc92OoMjMdwjPiBORnP/wHAo57Zn0j2MR6ZrlQbND2FhdjCimiudHPrrsnq+D9El+ARFDfFLrknX+8mTQV/tJHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNJEQ/Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FF0C32786;
	Thu,  1 Aug 2024 23:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722555838;
	bh=SzHZxUFqNTMwJ8KvcmNhUWoSQkRJhCngR3KcpXsTVtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tNJEQ/VsvtHIHxdmKdpBRb3helOv8NpY3l32E6cWqkxuxoB1VS5vRgmOkFtn1EJ9q
	 ZIxXUm0oqmHNdKDhk/aBQYyaxF/0UHh8fmOIXMgOaB6RshS65woz3yIE9M0NKrXU96
	 6mc2kNXLbTzm2sqlpZl5kg0rwOBRUoDBzJ0SdGlGmkvJZOlpVK0F0D4E7JgGen3Da7
	 o9T6xuoSHK9ApLJRsgxJKI40kXlZ64c+mDIv/Pc1+YSuoN/nkkWBqe2CZqfZHkLrNG
	 IuLKDhGAEBO8D2ITYpwaxrfgTkquK55iqj+YGfD3fEcmuXjHhb3nzBvxB5bBXDiilz
	 o9wKKtT9lUEEA==
Date: Thu, 1 Aug 2024 18:43:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: steven <steven_ygui@163.com>
Cc: linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: does dtb not support pci acs enable?
Message-ID: <20240801234356.GA128584@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429b2adf.a5a3.190cb82e4ae.Coremail.steven_ygui@163.com>

[+cc ARM, IOMMU folks; I don't know the answer, but maybe they do]

On Fri, Jul 19, 2024 at 11:01:11PM +0800, steven wrote:
> Hello,
> 
> I am a new person in PCI, I am trying to do something for iommu
> group on arm64 platform, I found if I boot the linux (5.10 kernel)
> kernel using UEFI + ACPI, it will work correctly. But if I boot it
> using UEFI + DTB, the iommu group not work, only one group present.
> 
> I read the code, found that pci_acs_enable is set to 1 during
> acpi_init, but I can not find any code for dtb booting, so it will
> return "disable_acs_redir " during call pci_enable_acs. 
>
> static void pci_enable_acs(struct pci_dev *dev)
> {
>     if (!pci_acs_enable)
>         goto disable_acs_redir;
> 
>     if (!pci_dev_specific_enable_acs(dev))
>         goto disable_acs_redir;
> 
>     pci_std_enable_acs(dev);
> 
> 
> 
> 
> SO, is it not support in dtb?
> 

