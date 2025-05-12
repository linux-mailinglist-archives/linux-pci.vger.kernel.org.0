Return-Path: <linux-pci+bounces-27602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB13AB45F6
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BFB4620A3
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4B7171CD;
	Mon, 12 May 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keqWDAQR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245829826E;
	Mon, 12 May 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747084181; cv=none; b=rrUj7zsI7idN4NaxntRX0mByCX3aTC5T3n7BgSh1n3zxgwZEJvkd14QWqjtZQEdiBlVVNPIWYWztCYZkEt0rkWuc4jvqorKHfxJCBhep6rudJ8PMAinoFv6qsbWIulYWv7Ahrf14h2GkS9/6x71Wf6+T2TSDI12gln2nNtfy9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747084181; c=relaxed/simple;
	bh=u/MV0bw8ZCiqsrAXerHWyETAW/s4ZNxo7OKc9ya9URA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kJFONCMm9Nj1WTiudnBe+UDwXxqucn4hCRgl2G1kdjFFY61wQwe5PtQQ8EhjeStZh6cIqeaPi0attcewbyoIqARAceZs8S50WWAudYjCceT1V7kt/GvSjJwnuSZDS/aygFsFInfpElFFiCvNG5bdaUzX1EXs2F3Eq2E76xVm5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keqWDAQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABF7C4CEE7;
	Mon, 12 May 2025 21:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747084180;
	bh=u/MV0bw8ZCiqsrAXerHWyETAW/s4ZNxo7OKc9ya9URA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=keqWDAQREe5w6fpxGeM9IrsRvsmUrOzfDAt1TzR0BD7ZINd0Mxv+v71nQyXmZ0ek7
	 OBazdx+Gs9VgOm6ycUTw3mnVP5oePvKrUb0ghTyy1mveYGcujlnxCYaKn9Z4AuG9YH
	 wXLIjZe9MK5Y0BxjbGV0uEkBlyhVBfbdawLDxTSKd7/xPdBsbQUrr7calceVwOIK5r
	 6rwdMbH4J+vCCXonG7NKnSizg7JlRFA3T3NZDPmXIdPyUNj2bOLHQ9QsM3d+6LHNoC
	 8uvGAHUESRaxazqU0Ig5yjDkkOX8DEv/3h5qAF9vxBczV345LlORQdUDRn2+NBkz+6
	 i0URln4pX6cVw==
Date: Mon, 12 May 2025 16:09:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Kenneth R. Crudup" <kenny@panix.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	You-Sheng Yang <vicamo.yang@canonical.com>,
	linux-pci@vger.kernel.org,
	Sergey Dolgov <sergey.v.dolgov@gmail.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Jian-Hong Pan <jhp@endlessos.org>,
	"David E. Box" <david.e.box@linux.intel.com>
Subject: Re: Raphael, I'd like your help upstreaming this VMD power-saving
 patch, please
Message-ID: <20250512210938.GA1128238@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b166ece-eeec-ba5d-2212-50d995611cef@panix.com>

[+cc Sergey, Nirmal, Jonathan, Jian-Hong, David]

On Sun, May 11, 2025 at 01:10:24PM -0700, Kenneth R. Crudup wrote:
> 
> Hello Raphael,
> 
> For almost two years now, I've been trying to get patches from Ubuntu that
> enable ASPM for devices behind Intel's VMD, necessary to get full lower-power
> states (including very-reduced power usage during s0ix sleep) on my Alderlake
> (et al.) laptop, upstreamed into mainline.
> 
> One such thread: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com/
> 
> Since the original set of patches on this, most of the work has been pushed
> upstream, with only this last patch required to get fully into the "CPU%LPI"
> and "SYS%LPI" (names according to "turbostat") states.
> 
> I'm surprised that with the number of VMD-enabled laptops out there (which I
> had to keep on so I could dual-boot into Win11 (the disk geometry changes if
> I disable it, rendering the Win11 partition useless)), that there haven't been
> many reports of excessive power usage in Linux during sleep; perhaps because
> many installations are running stock Ubuntu kernels (where I assume variants
> of this patch remain) it isn't an issue, but I do believe having this upstreamed
> is still valuable.
> 
> I don't have the resources you've got to test this fully for regressions, nor
> the expertise getting a patch into the kernel, so I'd like to again bring this
> up for discussion (hence the phone-book of a CC: here).
> 
> If there's anything I can do to help get this done, please let me know.
> 
> Thank you,
> 
> -Kenneth Crudup
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

> From ee3618a598a261bbc8a875557d42d6dbbbc4cdd0 Mon Sep 17 00:00:00 2001
> From: "Kenneth R. Crudup" <kenny@panix.com>
> Date: Fri, 13 Dec 2024 15:28:42 -0800
> Subject: [PATCH] PCI/ASPM: Fixup ASPM for VMD bridges
> 
> Effectively a squashed commit of:
> UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD domain
> UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
> UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead
> ---
>  drivers/pci/pcie/aspm.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 29fcb0689a91..fdc1ce2755ff 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -788,6 +788,31 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
>  		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
>  }
>  
> +/*
> + * BIOS may not be able to access config space of devices under VMD domain, so
> + * it relies on software to enable ASPM for links under VMD.
> + */
> +static bool pci_fixup_vmd_bridge_enable_aspm(struct pci_dev *pdev)
> +{
> +       struct pci_bus *bus = pdev->bus;
> +       struct device *dev;
> +       struct pci_driver *pdrv;
> +
> +       if (!pci_is_root_bus(bus))
> +               return false;
> +
> +       dev = bus->bridge->parent;
> +       if (dev == NULL)
> +               return false;
> +
> +       pdrv = pci_dev_driver(to_pci_dev(dev));
> +       if (pdrv == NULL || strcmp("vmd", pdrv->name))
> +               return false;
> +
> +       pci_info(pdev, "enable ASPM for pci bridge behind vmd");
> +       return true;
> +}
> +
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
> @@ -866,7 +891,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	}
>  
>  	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;
> +	link->aspm_default = pci_fixup_vmd_bridge_enable_aspm(parent) ?
> +		PCIE_LINK_STATE_ASPM_ALL : link->aspm_enabled;

PCIE_LINK_STATE_ASPM_ALL includes PCIE_LINK_STATE_L1_2, so I think
this potentially enables L1.2.  The L1.2 configuration depends on
T_POWER_ON and Common_Mode_Restore_Time, which depend on electrical
design and are not discoverable by the kernel.  See PCIe r6.0, sec
5.5.4:

  The TPOWER_ON and Common_Mode_Restore_Time fields must be programmed
  to the appropriate values based on the components and AC coupling
  capacitors used in the connection linking the two components. The
  determination of these values is design implementation specific.

aspm_calc_l12_info() tries to compute these values, but I don't think
it can do it correctly, and we have a related problem report where
BIOS set them correctly and then Linux came along and messed them up:

  https://lore.kernel.org/r/20250407155742.GA178541@bhelgaas

I think the only thing we can do with L1.2 is rely on values already
programmed by BIOS.  There is a _DSM method for Latency Tolerance
Reporting configuration (PCI Firmware r3.3, sec 4.6.6), but AFAICT it
only addresses the LTR Capability in upstream ports, not the
T_POWER_ON and Common_Mode_Restore_Time values.

_HPX Type 2 and 3 records (ACPI r6.5, sec 6.2.9.3 and 6.2.9.4) are
quite general and maybe there's a way to use them to configure the
L1.2 parameters, but I am skeptical that these have been implemented
in Linux and BIOSes.  At least, I don't recall any reports of problems
or of them being used.

Maybe something like this patch can be done for ASPM *except* for
L1.2?

Bjorn

