Return-Path: <linux-pci+bounces-44035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E970CF419A
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 15:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC9D83004626
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF4242D95;
	Mon,  5 Jan 2026 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSdfxUhl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920919DF4D;
	Mon,  5 Jan 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622639; cv=none; b=Y7w8Ev7kA5ZagtjXOz7NKnZlW6XYCqSHYd1pqpF7q3qm5VXH3SvHT8R1SxBcez6vZM8ExEHd6OLxQzaO0hCrBfLLmVv9Ys7A5BIz+FLfPFQzYBY07OgD8a8vFaslEirQp1fwUEhPX+VUoqPhr+NXxgzpuYnkal+ORKffioVgIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622639; c=relaxed/simple;
	bh=swfbx1sxZFbl2gBzvMcXE5KVCqJ9EAtLmDJTmDGg4U0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C0iWTncThgqsGBqGZ5bZ8Xk7yMkMUm4aXBCBHhUjH5m3NZULJU774DUpWhXaFMpYSGXQlB4hiVbxuGcl0qN4kigykAScONwsCr8aHq5Wi8lj98b8exJSIzYdytGYBwDZzA/ZTSX5OrmQoDdkfOVjSqJk6o4facIBgiZ6WOQDVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSdfxUhl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767622636; x=1799158636;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=swfbx1sxZFbl2gBzvMcXE5KVCqJ9EAtLmDJTmDGg4U0=;
  b=gSdfxUhlYygxrLk7F43qHcb+/RDI1BPODTeabQj13kSx9AreGRK9lSy3
   Cgfz+YZ+5PPGlxDj2xOASxC/QgK9u8MdzNG4bkoxS4ZtwVUWiXtQASt0L
   hxbrhkiMttiZTCJMypDGHZslBYJTYtby1hbTugIfurLlWws6qX3OC8wkn
   HILWWdIUnzk+X1DqJGj/+DWS51EWBCMiM81Y0BL7I7LRDr0QYuKBvipG7
   JItNe8nkaSm9qceTxXIqgLKo4YL4VeQ2ZKrimiEFFzlZ7ZGvKIhvdGpzt
   xdnbGAKCIp88h20YEFe+nMApj79Fh2NqzhdJ7N3GVlb76aAfu2lrCwXCw
   Q==;
X-CSE-ConnectionGUID: WSQK5bXNRyaEEzp9Amxybg==
X-CSE-MsgGUID: vF9pLyi+ReODsyG+Nb1hdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79621206"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="79621206"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 06:17:11 -0800
X-CSE-ConnectionGUID: swAqwZH9TR2l6es3u20rGw==
X-CSE-MsgGUID: KXT20lA7Q667Y9q59Rds3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="203365148"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 06:17:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Jan 2026 16:17:03 +0200 (EET)
To: Ziyao Li <liziyao@uniontech.com>
cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, niecheng1@uniontech.com, 
    zhanjun@uniontech.com, guanwentao@uniontech.com, 
    Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Lain Fearyncess Yang <fsf@live.com>, 
    Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>, 
    Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v2] PCI: loongson: Override PCIe bridge supported speeds
 for older Loongson 3C6000 series steppings
In-Reply-To: <20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com>
Message-ID: <2d36653c-0f5d-21d4-b974-112ccb599d68@linux.intel.com>
References: <20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 4 Jan 2026, Ziyao Li via B4 Relay wrote:

> From: Ziyao Li <liziyao@uniontech.com>
> 
> Older steppings of the Loongson 3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
> only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
> up to 16 GT/s.
> 
> As a result, certain PCIe devices would be incorrectly probed as a Gen1-
> only, even if higher link speeds are supported, harming performance and
> prevents dynamic link speed functionality from being enabled in drivers
> such as amdgpu.

What do you mean here? Does "dynamic link speed functionality" refer to 
bwctrl? (If that's the case, can you write it out explicitly as the 
connection is not obvious and I've heard the AMD GPUs do manage link 
speed autonomously too so you might be referring to that too.)

I don't see amdgpu using supported_speeds for anything, I guess the 
connection comes through pcie_get_speed_cap() which is seemingly used by 
amdgpu code (if that's the case, please include that into the 
explanation)?
 
> Manually override the `supported_speeds` field for affected PCIe bridges
> with those found on the upstream bus to correctly reflect the supported
> link speeds.

It's nice to see this field becoming useful for this kind of cases too, I 
kind of foresaw it happening one day when I added it. :-)

> This patch was originally found from AOSC OS[1].
> 
> Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
> Tested-by: Lain Fearyncess Yang <fsf@live.com>
> Tested-by: Ayden Meng <aydenmeng@yeah.net>
> Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> [Xi Ruoyao: Fix falling through logic and add kernel log output.]
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Link: https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0433d73175a17f493454
> [Ziyao Li: move from drivers/pci/quirks.c to drivers/pci/controller/pci-loongson.c]
> Signed-off-by: Ziyao Li <liziyao@uniontech.com>
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> ---
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com
> - Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-loongson.c
> - Fix falling through logic and add kernel log output by Xi Ruoyao
> ---
>  drivers/pci/controller/pci-loongson.c | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index bc630ab8a283..75a1b494b527 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -176,6 +176,45 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
>  
> +/*
> + * Older steppings of the Loongson 3C6000 series incorrectly report the
> + * supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
> + * only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
> + * up to 16 GT/s.
> + */
> +static void quirk_loongson_pci_bridge_supported_speeds(struct pci_dev *pdev)
> +{
> +	u8 supported_speeds = pdev->supported_speeds;
> +
> +	switch (pdev->bus->max_bus_speed) {
> +	case PCIE_SPEED_16_0GT:
> +		supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;

I'd have named the variable old_supported_speeds and adjusted 
pdev->supported_speeds here directly (I actually assumed it is what 
you're doing here and it took a while for me to even notice you only write 
the changes back later, I had to remove a few incorrect review comments 
written on basis of that wrong assumption :-)).

> +		fallthrough;
> +	case PCIE_SPEED_8_0GT:
> +		supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_5_0GT:
> +		supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_2_5GT:
> +		supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
> +		break;
> +	default:
> +		pci_warn(pdev, "unexpected max bus speed");

Missing \n

> +		return;
> +	}
> +
> +	if (supported_speeds != pdev->supported_speeds) {
> +		pci_info(pdev, "fixing up supported link speeds: 0x%x => 0x%x",

Missing \n

> +			 pdev->supported_speeds, supported_speeds);
> +		pdev->supported_speeds = supported_speeds;
> +	}
> +}

-- 
 i.


