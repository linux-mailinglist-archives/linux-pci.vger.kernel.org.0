Return-Path: <linux-pci+bounces-44711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 442ACD1D09C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 09:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C10A9301739D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAFA37997A;
	Wed, 14 Jan 2026 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSmb6aZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575635F8C9;
	Wed, 14 Jan 2026 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378336; cv=none; b=GvN+MjB9bpnkUqVgXtHF2ECtFha4g53Zud3QjPQLg5k7883RIi5xm9zVdon+lwkzpoqG4gIiHVBXVJ/V+3+5Q9k9SAL20rknjBw5+7OYg4ha7i2W+iZhtPN6nV3ZOlEmU+0Xa85HrzVBdNtNCogsbGQq6CZsaO5krgidJ45Nqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378336; c=relaxed/simple;
	bh=+Wx5DvCtyXRheBdpFCLlGYUgXdHnSl8iM5hk+jx6avg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANO+u+F9k3AEp3gTngCWdTVRSvfJT/n49/EFgTGeOI3hrMHb1IAXPjxyPx8/P3GcgMRsv5ekWELPrM3tm7xO9Ae55MyBqknlHXfkcx5JtPw5zWTGQ4H3R2LaDnYbbeZN5sMeGd9qDFVMTLM/uQ8EKELWCduigsHEMZsglNZesWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSmb6aZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04A3C4CEF7;
	Wed, 14 Jan 2026 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768378335;
	bh=+Wx5DvCtyXRheBdpFCLlGYUgXdHnSl8iM5hk+jx6avg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSmb6aZZdQ+beaYwBhNQG+OCHaPBfAznvdRrhjxyF7bYOYh3s1BRC0a2S0Y4DR0CO
	 DZ1mxs/7jwZfH4b0M2jey4tn7nGCnHt+B0494yD4vkikPUBgpxCx7vyS8VYhSU0ZCA
	 fb8ga76CaBnNIIpG7HI2Uo9kiggsQ/DruPi4IzF2Lffd8mMmkf0Q8HuJ67QB66d8SJ
	 yj1eg5Tgynnz28bOcbSuNSiGTTe5RfJUN8MdNH7oqobDQo3RR/9t7R5X4y2sHK3WNZ
	 G/z4VDaTMfkFsdL9dhdEiLOEavrwecdFVIU7Tf19TLA0mFclcnfsoU1Eu6RqnTrOIn
	 EhV1WUWdtuYqg==
Date: Wed, 14 Jan 2026 13:42:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: liziyao@uniontech.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, niecheng1@uniontech.com, zhanjun@uniontech.com, 
	guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, kernel@uniontech.com, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Lain Fearyncess Yang <fsf@live.com>, 
	Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
	stable@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v6] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
Message-ID: <vebnovol2s7cqigr3vq5kvapjsy7qiiusbtxqlq6qduxs4xxhk@afsqi4v3ur55>
References: <20260114-loongson-pci1-v6-1-ee8a18f5d242@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114-loongson-pci1-v6-1-ee8a18f5d242@uniontech.com>

On Wed, Jan 14, 2026 at 10:05:45AM +0800, Ziyao Li via B4 Relay wrote:
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
> clocks and lanes in power management. We hope this can prevent similar
> problems in future driver changes (similar checks may be implemented
> in other GPU, storage controller, NIC, etc. drivers).
> 
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

Dumb question: Why can't you just copy the Root Port's 'supported_speeds'
directly:

	pdev->supported_speeds = pdev->bus->self->supported_speeds;

- Mani

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
> -- 
> Ziyao Li <liziyao@uniontech.com>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

