Return-Path: <linux-pci+bounces-15557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F519B5834
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 01:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9274A1F204E0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 00:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12B634;
	Wed, 30 Oct 2024 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUeyLbYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E318D
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246692; cv=none; b=RsS/4UNtSsk70fNMg7ckkbbJjBsNJTg3Ws+x1V+dDijD3Ex8Bv253v0v8miIQZBq9ipzASNg4UbBL1EXKT6CgeNlpaRfQz2WD1iyt9bUeQEIDjcJiae1ZXcG0nE//f9Mx9ztaIzB4pu1/tDgXqTNH2axtj1sudUjcB0Y7dKI+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246692; c=relaxed/simple;
	bh=ZCoRxtA+CzWmEnDk1ezzPvNnq3fCVFY3GrWF/0bNzQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IebxzZPHwhpptbCmbR2k3blNdVS4tUwVTlsC01ynjFR2HqoEZe60n7yc9XPxRrDdtvJ1y1nNZ7XDa7x33RlynIdLxAYZscCnh0KnF637LEWSGtcY6gnlmUKRgrckz0Wn3ssvGrN/4pr1tnHfCKVad79w+a+7uMWgKc4kEJQ/yNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUeyLbYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3BEC4CEE3;
	Wed, 30 Oct 2024 00:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730246691;
	bh=ZCoRxtA+CzWmEnDk1ezzPvNnq3fCVFY3GrWF/0bNzQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jUeyLbYuz+4zv734La2QnEMG+3ldgVPMU8ak0cHxLQPlVvxsfzDtQM+G2Nv+19oyA
	 VP30PLiJDakLLrDEft8XI68mGmTKEb/LAcLSYb2zMbzHtl0GxP02PRrv7JcdxyfXpp
	 UhyslT0KAry6/Rg11hXRBYLw5p/866TbH3E3nzOp4eO5zXCv7UxLjEtXkj2jsYHLEy
	 IURrJByaUv8zgAIq5+b9sHfrJ2fEh/+QumCWK/wILRtXK2q+1Cf7QMJtwbN0CHgowf
	 7S5FevP1B3ZbYWFeW2eiFSfLZqa8lfst8mW9TyMJ6RuONcNyANFCPgdE5da8dhFWHI
	 /6XaEbqAtCrVg==
Date: Tue, 29 Oct 2024 19:04:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>
Subject: Re: [PATCH] PCI/sysfs: Fix read permissions for VPD attributes
Message-ID: <20241030000450.GA1180398@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com>

On Mon, Oct 28, 2024 at 10:05:33AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The Virtual Product Data (VPD) attribute is not readable by regular
> user without root permissions. Such restriction is not really needed,
> as data presented in that VPD is not sensitive at all.
> 
> This change aligns the permissions of the VPD attribute to be accessible
> for read by all users, while write being restricted to root only.
> 
> Cc: stable@vger.kernel.org
> Fixes: d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied to pci/vpd for v6.13, thanks!

> ---
> I added stable@ as it was discovered during our hardware ennoblement
> and it is important to be picked by distributions too.
> ---
>  drivers/pci/vpd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index e4300f5f304f..2537685cac90 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -317,7 +317,7 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
>  
>  	return ret;
>  }
> -static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
> +static BIN_ATTR_RW(vpd, 0);
>  
>  static struct bin_attribute *vpd_attrs[] = {
>  	&bin_attr_vpd,
> -- 
> 2.46.2
> 

