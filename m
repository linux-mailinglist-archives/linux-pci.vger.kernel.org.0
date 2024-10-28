Return-Path: <linux-pci+bounces-15498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D845E9B3D45
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 23:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B65F1F21787
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 22:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3C31EE01E;
	Mon, 28 Oct 2024 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIp28ImB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833B1EE01D
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152396; cv=none; b=IMbv9kcqqJIrVg5CDFTOBeFptr7AOWriy0MXKEl0w0OavpudW7JLTfrklhcZBiOcwsdlEyH4aSazywSOfjgF8Piv1NXl5nMhcUElxxSzd3waUZ8SsadadyNoj44+vxcF0g1Sf+6Vfr6ig6/NIEuk0+Pb+o2yDtOuvyEFcTRlD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152396; c=relaxed/simple;
	bh=r0KxdIOxII3yw4aXWGxXNwVDUfMaUmVPBXCecJMQ1P4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dJhs4wlh6IhFqn36gRbDzYV5Y2fx+hfAhXa9QhZpB/xMs9zGgaJ/GMxgWWlQUQ7r7ty1aorx7bcRwC+laHMOhqDUKp2PeuQ9tm4NnHERhusLwFKAn14YrvAE0I7ORJpgnNZB8CM1/TQYZ7wgJPpcUM+WbHZlPxKeL+BbHy9r6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIp28ImB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1618C4CEC3;
	Mon, 28 Oct 2024 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152395;
	bh=r0KxdIOxII3yw4aXWGxXNwVDUfMaUmVPBXCecJMQ1P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dIp28ImBP+45rohDN6xzjxXZXDN/6yTeq4Ny5Hjdyxv8C+8Qc4GCtdJdVH9DjfIv/
	 5126arW/819QeDIyn8e0LGfAiXqpm23OyJFqdQ30hUEp4EE5HksvmdOIurAu9/ZzZZ
	 mYhyjvmOOvy5B2qNVqYDj1aToXQVs2NTt7ifYmjqo4ce1FBGLB/wJSB1NQbrrTpZ9h
	 WuCG+RZ2zUYPoRfofOKfVV+SJyjfUK3xGpcw5HBSMUvBiTs3w7l+Xeeq1NNXT41Hpo
	 Jjiay81LCau7hMDO0EoCDdaMDau5lYQcHzz8/y1h4JErg2vXjZlmCcvku5K4Rzcgdb
	 7nXCk12t9oBFg==
Date: Mon, 28 Oct 2024 16:53:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: Re: [RFC PATCH v1 3/3] PCI: vmd: Add WA for VMD PCH rootbus support
Message-ID: <20241028215314.GA1117849@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025150153.983306-4-szymon.durawa@linux.intel.com>

In subject (and the code comment), spell out "WA" (I assume it means
workaround?)

Also make it more specific than "VMD PCH rootbus support," which
doesn't say anything about what the actual issue is.

On Fri, Oct 25, 2024 at 05:01:53PM +0200, Szymon Durawa wrote:
> VMD PCH rootbus primary number is 0x80 and pci_scan_bridge_extend()
> cannot assign it as "hard-wired to 0" and marks setup as broken. To
> avoid this, PCH bus number has to be the same as PCH primary number.

From the cover letter, I infer that whatever the issue is, it doesn't
happen when VMD is integrated into an IOC, but it does happen when VMD
is in a PCH.  These details should be in this commit log because they
are relevant to *this* patch, and the cover letter doesn't make it
into git.

Maybe the problem is that some root bus numbers are hardwired to fixed
non-zero values?  I thought we already handled that, but perhaps not.

What does the user see without this patch?  Some warning?  Failure to
enumerate some devices?  Include a hint here if possible so users can
find the fix to their issue.

> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 842b70a21325..bb47e0a76c89 100755
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -404,8 +404,22 @@ static inline u8 vmd_has_pch_rootbus(struct vmd_dev *vmd)
>  static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
>  				  unsigned int devfn, int reg, int len)
>  {
> -	unsigned int busnr_ecam = bus->number - vmd->busn_start[VMD_BUS_0];
> -	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> +	unsigned char bus_number;
> +	unsigned int busnr_ecam;
> +	u32 offset;
> +
> +	/*
> +	 * VMD WA: for PCH rootbus, bus number is set to VMD_PRIMARY_PCH_BUS
> +	 * (see comment in vmd_create_pch_bus()) but original value is 0xE1
> +	 * which is stored in vmd->busn_start[VMD_BUS_1].

Used 225 elsewhere.  Would be nice to at least use the same base (dec
vs hex), and preferably the same #define.

> +	 */
> +	if (vmd_has_pch_rootbus(vmd) && bus->number == VMD_PRIMARY_PCH_BUS)
> +		bus_number = vmd->busn_start[VMD_BUS_1];
> +	else
> +		bus_number = bus->number;
> +
> +	busnr_ecam = bus_number - vmd->busn_start[VMD_BUS_0];
> +	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
>  
>  	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
>  		return NULL;
> @@ -1023,6 +1037,14 @@ static int vmd_create_pch_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
>  	 */
>  	vmd->bus[VMD_BUS_1]->primary = VMD_PRIMARY_PCH_BUS;
>  
> +	/* This is a workaround for pci_scan_bridge_extend() code.

Use the prevailing comment style:

  /*
   * This is ...

> +	 * It assigns setup as broken when primary != bus->number and
> +	 * for PCH rootbus primary is not "hard-wired to 0".
> +	 * To avoid this, vmd->bus[VMD_BUS_1]->number and
> +	 * vmd->bus[VMD_BUS_1]->primary are updated to the same value.
> +	 */
> +	vmd->bus[VMD_BUS_1]->number = VMD_PRIMARY_PCH_BUS;
> +
>  	vmd_copy_host_bridge_flags(
>  		pci_find_host_bridge(vmd->dev->bus),
>  		to_pci_host_bridge(vmd->bus[VMD_BUS_1]->bridge));
> -- 
> 2.39.3
> 

