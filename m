Return-Path: <linux-pci+bounces-6808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183F48B6204
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 21:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497D01C20EBD
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 19:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90713AA48;
	Mon, 29 Apr 2024 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2klRLfW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB012B73
	for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419096; cv=none; b=Wuf/ZpQa927DJySBjnmoOdP9z/+reFeixEHGlxSv+rTL9hBxWbt11JVT8GYkr8eBd0mqyjD0GqMTE6XfrpSp9/fqiQbAsWMs80l53x3Tig0aczUf6jvWMfNnheumHSpMFvtQSeqBIqBeJ35SDxdCUncEVS0EhcYrJ8wHhIHdtGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419096; c=relaxed/simple;
	bh=Y1cXuVTzlgIjK5kT8XcGJtvYE/eRJPeZE5ZXpXfnz5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl1IOlJ/yiB8dt/sIrDjCE7ojJYIQhTz0w2hizBl+b63JqiqgjJ7Jh6gk0I6xR6/VWJ5JheMBoXE2+o3SqgvqixeBVjpuHtP3B2hkllWKsu57RCUbh6KrHw0a1sYUM/j1wsNU0VjrFUMitFy7OpABoyRK1MA8aiRyR5+yM5ifHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2klRLfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD34C113CD;
	Mon, 29 Apr 2024 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714419096;
	bh=Y1cXuVTzlgIjK5kT8XcGJtvYE/eRJPeZE5ZXpXfnz5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2klRLfWPLuJ2c1skfsvvRLENTNauhAsKekFi5Y+MIcBy5hHV8UWk8Wc3TEyXua10
	 7sdNIaXKTwyaaFMR/ULzibkTU4LmBeB4BWmcKC2ZMatBbxbYOIt2hoWGt6IBbGD5zK
	 w+CildLZHrStgiNhqxBQQ1CsOfd3NWlyHeW3tM9cICBWSQAT1ZTriU6hXdEzXGro0i
	 XhPPvIZt31jnSZ4yc8G4hk4jvg0TqE7x4YfdH8X37fIPNiQTeOSXSDf11enx8Wc74j
	 yjApUbkBSRbKQ6QZOShhTpUlzC9k8kH7phWuDHBzgK9DCY4+6iZJUA9m3REwAfWpTk
	 IcOYKzcGHbXLg==
Received: by pali.im (Postfix)
	id 4D3DA7BA; Mon, 29 Apr 2024 21:31:33 +0200 (CEST)
Date: Mon, 29 Apr 2024 21:31:33 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 09/10] PCI: mvebu: Use generic PCI Conf Type 1 helper
Message-ID: <20240429193133.brosdplw4cfcfbyo@pali>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
 <20240429104633.11060-10-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429104633.11060-10-ilpo.jarvinen@linux.intel.com>
User-Agent: NeoMutt/20180716

On Monday 29 April 2024 13:46:32 Ilpo Järvinen wrote:
> Convert mvebu to use the pci_conf1_ext_addr() helper from PCI core
> to calculate PCI Configuration Space address for Type 1 access.

Exampled in other email. mvebu controller uses extended configuration
mechanism #1. mvebu_pcie_child_rd_conf/mvebu_pcie_child_wr_conf
functions are used only for accessing devices behind the PCIe root port,
hence they are for Type 1 access. But the mvebu controller register
PCIE_CONF_ADDR_OFF takes address in the configuration mechanism #1
extended format. It does not take format of the command for Type 1
access. Hence the description and the change here is wrong/misleading.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 29fe09c99e7d..1908754ee6fd 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -45,15 +45,6 @@
>  #define PCIE_WIN5_BASE_OFF	0x1884
>  #define PCIE_WIN5_REMAP_OFF	0x188c
>  #define PCIE_CONF_ADDR_OFF	0x18f8
> -#define  PCIE_CONF_ADDR_EN		0x80000000
> -#define  PCIE_CONF_REG(r)		((((r) & 0xf00) << 16) | ((r) & 0xfc))
> -#define  PCIE_CONF_BUS(b)		(((b) & 0xff) << 16)
> -#define  PCIE_CONF_DEV(d)		(((d) & 0x1f) << 11)
> -#define  PCIE_CONF_FUNC(f)		(((f) & 0x7) << 8)
> -#define  PCIE_CONF_ADDR(bus, devfn, where) \
> -	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))    | \
> -	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where) | \
> -	 PCIE_CONF_ADDR_EN)
>  #define PCIE_CONF_DATA_OFF	0x18fc
>  #define PCIE_INT_CAUSE_OFF	0x1900
>  #define PCIE_INT_UNMASK_OFF	0x1910
> @@ -361,7 +352,7 @@ static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  
>  	conf_data = port->base + PCIE_CONF_DATA_OFF;
>  
> -	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
> +	mvebu_writel(port, pci_conf1_ext_addr(bus->number, devfn, where, true),
>  		     PCIE_CONF_ADDR_OFF);
>  
>  	switch (size) {
> @@ -397,7 +388,7 @@ static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
>  
>  	conf_data = port->base + PCIE_CONF_DATA_OFF;
>  
> -	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
> +	mvebu_writel(port, pci_conf1_ext_addr(bus->number, devfn, where, true),
>  		     PCIE_CONF_ADDR_OFF);
>  
>  	switch (size) {
> -- 
> 2.39.2
> 

