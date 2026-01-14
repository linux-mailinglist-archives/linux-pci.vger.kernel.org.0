Return-Path: <linux-pci+bounces-44717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 807E0D1D4D3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 09:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99B63304BB77
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445B3803D6;
	Wed, 14 Jan 2026 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ma1yLjDj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38E37FF53;
	Wed, 14 Jan 2026 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381070; cv=none; b=i0Tow/pcCnMDmB0BV/G+f+iOgFyyZflRnlVyZTfUL5nahZp+EhQYlr2mc4/3tnTdZgpx0sEvhR7S5YSF+V8+utwp0yLRw3/pozaHRsqJIhfG4dCZiGr2ing+rj534f64DEc4Ek5oDGSJ3ldNMC0+rsfYWmfhkP1fmCUHyqf9hSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381070; c=relaxed/simple;
	bh=/H3cNyvUgb5WJleTsjKD35Uwv1aJqxNsQFOjAff5dnE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P6Fv+OMkwKH0CFD6VepWN0+z2fRl54TNRA2PPF2HyXoP/hQu1TG125WPlX7AvDjgCmei1smHBYExOeWube/xN98wot4+oB7IqhlncRFSZFxGf18RTlBd56x9CzFXEWDDDV5+d/fVyUqyG9RXtWWMPIF1fCFclO2CLf9IsheDDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ma1yLjDj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768381067; x=1799917067;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/H3cNyvUgb5WJleTsjKD35Uwv1aJqxNsQFOjAff5dnE=;
  b=ma1yLjDjs10huTskV0iOoJAncVjGo9UQuC4DAqgIYDo8WwossBWFyXFy
   ezQdZfDXgEdmstwlOTQ/S8bPBhzqQYE2JG66Iwkqwmm66JlLxROq8rrPC
   eJhn1g3C0AmZRey1kvOoh2HGyrUt2C94F0t4IiJqS2fUhblFtdDvIDzo9
   XbCUkkEmoTYbLbx0sXnsZ7d52Z1nbHpaHm2naQSKty6E1/qvX3LbrplYA
   kGmTvNOOH1es5fUQbpb5J3EIq8aXQna/ev8w/QzL3HTu+cN4OFRP9Z2pe
   aF+po3W3p/X7zH9Jyo2yP9GaEgdr/JNT9wVAGxgXfGRFr5CjhkQDzIUix
   w==;
X-CSE-ConnectionGUID: SMcbSpklRIWcG6AcFWDLXA==
X-CSE-MsgGUID: 4JLVniQKSManzuyw49R1UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68882746"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="68882746"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:57:36 -0800
X-CSE-ConnectionGUID: S3mwMVM5RDqfyUhov/xqPA==
X-CSE-MsgGUID: 5sa/DecdRZeHQmWFxKUJQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="205045228"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.107])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:57:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Jan 2026 10:57:26 +0200 (EET)
To: Ziyao Li <liziyao@uniontech.com>
cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, niecheng1@uniontech.com, 
    zhanjun@uniontech.com, guanwentao@uniontech.com, 
    Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev, 
    kernel@uniontech.com, Lain Fearyncess Yang <fsf@live.com>, 
    Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>, 
    Xi Ruoyao <xry111@xry111.site>, stable@vger.kernel.org, 
    Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v6] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
In-Reply-To: <20260114-loongson-pci1-v6-1-ee8a18f5d242@uniontech.com>
Message-ID: <a7ea73e2-dcc6-4cd3-a29e-818a8a67b367@linux.intel.com>
References: <20260114-loongson-pci1-v6-1-ee8a18f5d242@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Jan 2026, Ziyao Li via B4 Relay wrote:

> From: Ziyao Li <liziyao@uniontech.com>
> 
> Older steppings of the Loongson-3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
> as only 2.5 GT/s, despite the upstream bus supporting speeds from
> 2.5 GT/s up to 16 GT/s.
> 
> As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
> than one speed is supported"), bwctrl will be disabled if there's only
> one 2.5 GT/s value in vector `supported_speeds`.
> 
> Also, the amdgpu driver reads the value by pcie_get_speed_cap() in
> amdgpu_device_partner_bandwidth(), for its dynamic adjustment of PCIe
> clocks and lanes in power management.

> We hope this can prevent similar
> problems in future driver changes (similar checks may be implemented
> in other GPU, storage controller, NIC, etc. drivers).

This sentence would naturally continue the next paragraph underneath, in 
its current position it feels discontinuous, "this" is dangling without 
clear anchor to what it refers to, etc.

> Manually override the `supported_speeds` field for affected PCIe bridges
> with those found on the upstream bus to correctly reflect the supported
> link speeds.
> 
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
> Cc: stable@vger.kernel.org
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

-- 
 i.

> ---
> Changes in v6:
> - adjust commit message
> - Link to v5: https://lore.kernel.org/r/20260113-loongson-pci1-v5-1-264c9b4a90ab@uniontech.com
> 
> Changes in v5:
> - style adjust
> - Link to v4: https://lore.kernel.org/r/20260113-loongson-pci1-v4-1-1921d6479fe4@uniontech.com
> 
> Changes in v4:
> - rename subject
> - use 0x3c19/0x3c29 instead of 3c19/3c29
> - Link to v3: https://lore.kernel.org/r/20260109-loongson-pci1-v3-1-5ddc5ae3ba93@uniontech.com
> 
> Changes in v3:
> - Adjust commit message
> - Make the program flow more intuitive
> - Link to v2: https://lore.kernel.org/r/20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com
> 
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com
> - Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-loongson.c
> - Fix falling through logic and add kernel log output by Xi Ruoyao
> ---
>  drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index bc630ab8a283..a4250d7af1bf 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -176,6 +176,42 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
>  
> +/*
> + * Older steppings of the Loongson-3C6000 series incorrectly report the
> + * supported link speeds on their PCIe bridges (device IDs 0x3c19,
> + * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting speeds
> + * from 2.5 GT/s up to 16 GT/s.
> + */
> +static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
> +{
> +	u8 old_supported_speeds = pdev->supported_speeds;
> +
> +	switch (pdev->bus->max_bus_speed) {
> +	case PCIE_SPEED_16_0GT:
> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_8_0GT:
> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_5_0GT:
> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_2_5GT:
> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
> +		break;
> +	default:
> +		pci_warn(pdev, "unexpected max bus speed");
> +
> +		return;
> +	}
> +
> +	if (pdev->supported_speeds != old_supported_speeds)
> +		pci_info(pdev, "fixing up supported link speeds: 0x%x => 0x%x",
> +			 old_supported_speeds, pdev->supported_speeds);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
> +
>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>  {
>  	struct pci_config_window *cfg;
> 
> ---
> base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
> change-id: 20250822-loongson-pci1-4ded0d78f1bb
> 
> Best regards,
> 

