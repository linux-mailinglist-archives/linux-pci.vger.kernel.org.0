Return-Path: <linux-pci+bounces-11149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A55945518
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 02:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A82F284520
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 00:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB9EC0;
	Fri,  2 Aug 2024 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBQr975H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584FA2D;
	Fri,  2 Aug 2024 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557058; cv=none; b=ps7k2ZTsHV/h6fcstHsj9AJ+M91hM9jZ6YS7reKbDpCBviClIHrdt0gP+lwg+Y0+ZZw5M8Ucd3NBABZARRcWquEmYtsUU1Uenh3BwaqlYKSif505iJag0GoOCSkO8wstesiuG/pgH5pgOdfvQQETjB295xCHEfrFZKc8a6HHnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557058; c=relaxed/simple;
	bh=EKjukfVNaDiO/eaFTztBWwrW0E50nQGDuAM1IJJy8Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jxhG9M9uItfTj6t1BO9y1OJsyB7VLn3TbBz/MpyEcQuH+oAf+3k23bkDuWaL80ExCZiP65bK2XBZOOzgEATeXLQhd7CE+uHZ2KcCkYx9H+x7LD0jzAxaJOOBnpoaRkwLo8niM48EBEu0Si/tzRvEaM+kKquKu4At2bLz/5cUeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBQr975H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEFAC32786;
	Fri,  2 Aug 2024 00:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557058;
	bh=EKjukfVNaDiO/eaFTztBWwrW0E50nQGDuAM1IJJy8Ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qBQr975HhAlX1X0mTsJPEG4TbSmOqAMUBK11bubL7OgZ1Cc7940UVgYwCE5XM6gmo
	 tIPHO9EPmTaGgrw/y6I4oXy6M5YcD7bRWIv4OEGrVEMsaJbSo2r9Y6EnTmWyIw421E
	 bi74yBde8NDh+pOCrAgb/ZXhi9So95Cb2lgkNZN9BurhWHJZwoKeam4dtgyR5yj6+k
	 F36DxqCa3BFAdj+lRPA8Onz90jMHMcNM2YHr6GPvEiHHW8wMuRstW+OsJQuZtOwkxw
	 8R1Pn6dlAGE3Ji28n2M81uyb3M0igSi43dmNF9lY5ncbDpo9hJF1fgWorX0Q79vrw0
	 5gN0askghRxxw==
Date: Thu, 1 Aug 2024 19:04:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev, ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com
Subject: Re: [PATCH 2/2] PCI: vmd: Let OS control ASPM for devices under VMD
 domain
Message-ID: <20240802000414.GA127813@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530085227.91168-2-kai.heng.feng@canonical.com>

On Thu, May 30, 2024 at 04:52:27PM +0800, Kai-Heng Feng wrote:
> Intel SoC cannot reach lower power states when mapped VMD PCIe bridges
> and NVMe devices don't have ASPM configured.
> 
> So set aspm_os_control attribute to let OS really enable ASPM for those
> devices.
> 
> Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")

I assume f492edb40b54 was tested and worked at the time.  Is the
implication that newer Intel SoCs have added more requirements for
getting to low power states, since __pci_enable_link_state() would
have warned and done nothing even then?

Or maybe this is a new system that sets ACPI_FADT_NO_ASPM, and
f492edb40b54 was tested on systems that did *not* set
ACPI_FADT_NO_ASPM?

> Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com/
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/controller/vmd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..1dbc525c473f 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -751,6 +751,8 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
>  		return 0;
>  
> +	pdev->aspm_os_control = 1;
> +
>  	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>  
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> -- 
> 2.43.0
> 

