Return-Path: <linux-pci+bounces-6362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E278A8811
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8714EB248F4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5E140E29;
	Wed, 17 Apr 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVnoXhsq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DEE1474A1
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369017; cv=none; b=LnVXZgsE9FbLSIO2r0s/UKyYOPS9HtSwq8TiRWM6cF+1UVGKAabgH25wtpJ9J+dPKHj+eBzTOqgo7SnyuPCEqPmZ8FAZfpK2ij4/J3pDhDXCcDJHaBWyCBt7jYNqrP0gZhvvdN0iGjci8VCeZ/HP+ZsmyRc9cUHYCYc75XCCNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369017; c=relaxed/simple;
	bh=Qs3zfHqaMl9WiCEbm8l0HczQgD1T3m81MGE54n2UYzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uWDP51LoOYqXWUqONLalQjkmIhSEGZCbVJevzopoPCJ2tYFqlZPBbPzQUkxGI+Mws5HxhjhwLS3LmlMzqBYYrzIHFtqf7L9xiPpZVewG7fZbh5hAebo4HsuxyjnvFbgIlsB00ijk+QgdznIK4hdluPiecJkWL3KU3hOtXbTEnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVnoXhsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDDCC32781;
	Wed, 17 Apr 2024 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369017;
	bh=Qs3zfHqaMl9WiCEbm8l0HczQgD1T3m81MGE54n2UYzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RVnoXhsq2DIFd/m2EOMhL3jUacFn2RPoPFUFJvyIndPx5/bAH7hZqJkcLNBsYBz2O
	 n7maP97hth0+R258CgkYKm+yloVQ1zbWVs6TpPEkry9mhVXNwK0oIH/XokTaKwhne1
	 6wJQVG3WxkmhAMt2/AxQthd7lphb/eHnTdl722GT9SyLd/JdrhVnCU6XxVhMmOPwy7
	 B+ZvWPNCLb27HCaLuec/hbpntQp6XIl38vVQWE/0EYHMMwVAykFVYAg6CyETpnW48H
	 cjIhWigSzmRUatYwvf/HcIl1zEziI5LJgsD38/257uwRMtTjCNiCNLjiUQwFr6WK18
	 TY2LVUqmSyj1w==
Date: Wed, 17 Apr 2024 10:50:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Annotate pci_cache_line_size variables as
 __ro_after_init
Message-ID: <20240417155014.GA204365@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb214ae-4c51-46b0-85f0-dba7ebe77743@gmail.com>

On Sat, Apr 13, 2024 at 11:05:52PM +0200, Heiner Kallweit wrote:
> Annotate both variables as __ro_after_init, enforcing that they can't
> be changed after the init phase.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/pci.c   | 4 ++--
>  include/linux/pci.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5f8edba78..e7ac4474b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -142,8 +142,8 @@ enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
>   * the dfl or actual value as it sees fit.  Don't forget this is
>   * measured in 32-bit words, not bytes.
>   */
> -u8 pci_dfl_cache_line_size = L1_CACHE_BYTES >> 2;
> -u8 pci_cache_line_size;
> +u8 pci_dfl_cache_line_size __ro_after_init = L1_CACHE_BYTES >> 2;
> +u8 pci_cache_line_size __ro_after_init;
>  
>  /*
>   * If we set up a device for bus mastering, we need to check the latency
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 69b10f2fb..cf63be0c9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2334,8 +2334,8 @@ extern int pci_pci_problems;
>  
>  extern unsigned long pci_cardbus_io_size;
>  extern unsigned long pci_cardbus_mem_size;
> -extern u8 pci_dfl_cache_line_size;
> -extern u8 pci_cache_line_size;
> +extern u8 pci_dfl_cache_line_size __ro_after_init;
> +extern u8 pci_cache_line_size __ro_after_init;

Is __ro_after_init required on the declaration, too?  I see a few uses
in .h files, but not very many, and I would think it would be a linker
thing that applies to the definition, where space is allocated.

>  /* Architecture-specific versions may override these (weak) */
>  void pcibios_disable_device(struct pci_dev *dev);
> -- 
> 2.44.0
> 

