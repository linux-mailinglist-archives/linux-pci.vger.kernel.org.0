Return-Path: <linux-pci+bounces-35177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FBBB3CA89
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E369201E05
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5624822069E;
	Sat, 30 Aug 2025 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="C26iWGLB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3CB1EA7D2
	for <linux-pci@vger.kernel.org>; Sat, 30 Aug 2025 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552974; cv=none; b=Rs9GEEb4R76MfiE0T4E9Uxuv4n8tlbWRcoUHZR0bLpk/9BLoTBLflpSNA/Q3Jcmj1nE11UuOFLrGKItHiezMRTV/Sgb/5tEnJDHjWgwq3N6PTPKKsDY31zC8VzelgImSyq0fBv8NBemGVIQqt5u6VSbPnlSE4L92rjFxvxclKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552974; c=relaxed/simple;
	bh=EhTo+AkxghtGQeoauvHl7muD4tuRwCvwI5SjHZj9hbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYUMk/YM28HC8nE2doq3JCictURPLBOmVghjvIMRgigG0nQnhaA7lP2y64urb8zhbxDSzEOPiHqMMbcK9eR7jHS2K9tqY8pyuMm7y18pvRTFx1T4AkGiRMnOIpieLemMstdjMkckSePwH+kUkckZkFYGeBp1yG01KggGGTC7jJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=C26iWGLB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3cbb0df3981so1452923f8f.3
        for <linux-pci@vger.kernel.org>; Sat, 30 Aug 2025 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756552969; x=1757157769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CVU5GfSW4Woi3wwFw2mUWG9xUFL6KXEOJ4qolNKKJ4=;
        b=C26iWGLB5vTmdPjAwCnIrIwuRnVCRBdfy0VXmi6fD5iEnhKTvtGxIhzRxZzq3XRni8
         OglinoRgAfs6rPH7zhHZBuDmE3hqHyemXWW91MmZ20jrJQudZfZlQQmv9vQKb8ueQwyu
         qnb8piLYQfo9WZ0hI1I7va1Pkg4vX9cKwQrcSg9LQ0Pa7yEYexqqGnjJ8fE5W0bdfyAU
         n2ORJ8BzDsbk/EW7WqWuXUFMLVuz/jJou7WcBC4WDx3YgrEnSA6gHd8nNhVMBM4XyGIr
         tOqpz0guD1KfU6mv9AjKtg1MW6Pvic304RApegYoUaUJknlCS/n0UFLc2l4gZZpPfRab
         lzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552969; x=1757157769;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CVU5GfSW4Woi3wwFw2mUWG9xUFL6KXEOJ4qolNKKJ4=;
        b=qkYZd4e+6y4WstT7ZtdSEov2L5AGtC5k9ZWr2vFti46q/Ey+mvMbWN7Je2PrAqMXKZ
         FuorhE0Mm3KtwCs8fCZTR+LITj2vu3T9cU+D6v+t6w8cvoR3dKHr8Hl2gfxXp/6O6/jY
         SPdirQ94dMyxiJSkbtIxAI2hGv1/ymyx/uyOErSdsyMCK9w5yOF5UV3GS21MY2kLo3ne
         eULegJ0x6o4V8UrS8SjWB7rkE/aGlTUuh7cOK6WbAZoN7pBrisJY3ZY9YcdQR7vAtadl
         ixny8AhA3Ge+cohpVhI/9nESmVc6gLUhTBo3JqUIYJ0ZJt+tEF110PfDnc83oAyt4qIT
         slig==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7BRuwGBWm7X+wfJztawVynHoSxsASZVMdsKikE7VSnDrk4Vki/EOCrUOsZVUlN/O3FAsAwj8TFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzhUss+pq4zX6Y9hlXZCi0wXEa+wlzfReXmmjbSE/vMeWwqMC
	wIytT3F6SczR0bQoB+jrh1iHRFFcMdZ6sCF02qJuqofiEbX8KKXX9+CEATtf0ciFwg0=
X-Gm-Gg: ASbGnctR09R1pyPSbCHLuvVllhWVYcPNKLGAgwkNGo6XB0JZCf2OP9o2gCPjHyB7ybR
	cQq4FohNj/FmkDbUlu2/umvAU/15sOh2YNtnYeSUcIXnfLj9YF17p8zJG4QOZ9o+InA4w4I+ohS
	Wzy5h9tt1ZvBuww9RXRdmSiL3Veryg8zem1Hs475yxgHz5TZrmtznndZffY4rebn7ftz1xkrlsb
	hvfFy6lfKpupQwcYGRoVS51GpdeDZl9XCJcsVAgvo/RQ77WSjuzSs+xeniYYcDqHUtL/p3bAi/U
	bsVLQc5WHMvt8mTDkx5tJ13Hkm8x9NGPnRBdipaHyVHxNi4eSqOBXxnZy11nUF/BOZo9OXRWuAz
	yfuLGQmY1hwj8DkB9MVapDC58A5V293kuNwp5dOVfSw==
X-Google-Smtp-Source: AGHT+IFs70HJFIeJ38MFLK17bjW/kAlj/k66sRyiTG1idrWyAzqFZb3JfRHFCjTPYnkYClUlxJLPDw==
X-Received: by 2002:a5d:5f4c:0:b0:3c4:2a56:14db with SMTP id ffacd0b85a97d-3d1dfb11144mr1071593f8f.41.1756552968338;
        Sat, 30 Aug 2025 04:22:48 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7a938e75sm57559435e9.4.2025.08.30.04.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 04:22:47 -0700 (PDT)
Message-ID: <8ef466aa-b470-4dcb-9024-0a9c36eb9a6a@tuxon.dev>
Date: Sat, 30 Aug 2025 14:22:45 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-6-claudiu.beznea.uj@bp.renesas.com>
 <ddxayjj5wcuuish4kvyluzrujkes5seo7zlusmomyjfjcgzcyj@xe3zzzmy2zaj>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <ddxayjj5wcuuish4kvyluzrujkes5seo7zlusmomyjfjcgzcyj@xe3zzzmy2zaj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.08.2025 09:59, Manivannan Sadhasivam wrote:
> On Fri, Jul 04, 2025 at 07:14:05PM GMT, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>> only as a root complex, with a single-lane (x1) configuration. The
>> controller includes Type 1 configuration registers, as well as IP
>> specific registers (called AXI registers) required for various adjustments.
>>
>> Hardware manual can be downloaded from the address in the "Link" section.
>> The following steps should be followed to access the manual:
>> 1/ Click the "User Manual" button
>> 2/ Click "Confirm"; this will start downloading an archive
>> 3/ Open the downloaded archive
>> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
>> 5/ Open the file r01uh1014ej*-rzg3s.pdf
>>
>> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
> 
> [...]
> 
>> +static bool rzg3s_pcie_child_issue_request(struct rzg3s_pcie_host *host)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_REQISS,
>> +			       RZG3S_PCI_REQISS_REQ_ISSUE,
>> +			       RZG3S_PCI_REQISS_REQ_ISSUE);
>> +	ret = readl_poll_timeout_atomic(host->axi + RZG3S_PCI_REQISS, val,
>> +					!(val & RZG3S_PCI_REQISS_REQ_ISSUE),
>> +					5, RZG3S_REQ_ISSUE_TIMEOUT_US);
>> +
>> +	return !!ret || (val & RZG3S_PCI_REQISS_MOR_STATUS);
> 
> You don't need to do !!ret as the C11 standard guarantees that any scalar type
> stored as bool will have the value of 0 or 1.

OK, will drop it anyway as suggested in another thread.

> 
>> +}
>> +
> 
> [...]
> 
>> +static void __iomem *rzg3s_pcie_root_map_bus(struct pci_bus *bus,
>> +					     unsigned int devfn,
>> +					     int where)
>> +{
>> +	struct rzg3s_pcie_host *host = bus->sysdata;
>> +
>> +	if (devfn)
>> +		return NULL;
> 
> Is it really possible to have devfn as non-zero for a root bus?

I will drop it.

> 
>> +
>> +	return host->pcie + where;
>> +}
>> +
> 
> [...]
> 
>> +static int rzg3s_pcie_msi_setup(struct rzg3s_pcie_host *host)
>> +{
>> +	size_t size = RZG3S_PCI_MSI_INT_NR * sizeof(u32);
>> +	struct rzg3s_pcie_msi *msi = &host->msi;
>> +	struct device *dev = host->dev;
>> +	int id, ret;
>> +
>> +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA, 0);
>> +	if (!msi->pages)
>> +		return -ENOMEM;
>> +
>> +	msi->dma_addr = dma_map_single(dev, (void *)msi->pages, size * 2,
>> +				       DMA_BIDIRECTIONAL);
>> +	if (dma_mapping_error(dev, msi->dma_addr)) {
>> +		ret = -ENOMEM;
>> +		goto free_pages;
>> +	}
>> +
>> +	/*
>> +	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.4.5.2 Setting
>> +	 * the MSI Window) the MSI window need to be within any AXI window. Find
>> +	 * an AXI window to setup the MSI window.
> 
> Are you really finding the AXI window or just making sure that the MSI window
> falls into one of the AXI window?

I'm making sure the MSI windows falls into one of the enabled AXI windows.

> 
> And I believe it is OK to have more than one MSI window within an AXI window.

This IP supports a single MSI window that need to fit into one of the
enabled AXI windows.

> 
>> +	 */
>> +	for (id = 0; id < RZG3S_MAX_WINDOWS; id++) {
>> +		u64 base, basel, baseu;
>> +		u64 mask, maskl, masku;
>> +
>> +		basel = readl(host->axi + RZG3S_PCI_AWBASEL(id));
>> +		/* Skip checking this AXI window if it's not enabled */
>> +		if (!(basel & RZG3S_PCI_AWBASEL_WIN_ENA))
>> +			continue;
>> +
>> +		baseu = readl(host->axi + RZG3S_PCI_AWBASEU(id));
>> +		base = baseu << 32 | basel;
>> +
>> +		maskl = readl(host->axi + RZG3S_PCI_AWMASKL(id));
>> +		masku = readl(host->axi + RZG3S_PCI_AWMASKU(id));
>> +		mask = masku << 32 | maskl;
>> +
>> +		if (msi->dma_addr < base || msi->dma_addr > base + mask)
>> +			continue;
>> +
>> +		break;
>> +	}
>> +
>> +	if (id == RZG3S_MAX_WINDOWS) {
>> +		ret = -EINVAL;
>> +		goto dma_unmap;
>> +	}
>> +
>> +	/* The MSI base address need to be aligned to the MSI size */
>> +	msi->window_base = ALIGN(msi->dma_addr, size);
>> +	if (msi->window_base < msi->dma_addr) {
>> +		ret = -EINVAL;
>> +		goto dma_unmap;
>> +	}
>> +
>> +	rzg3s_pcie_msi_hw_setup(host);
>> +
>> +	return 0;
>> +
>> +dma_unmap:
>> +	dma_unmap_single(dev, msi->dma_addr, size * 2, DMA_BIDIRECTIONAL);
>> +free_pages:
>> +	free_pages(msi->pages, 0);
>> +	return ret;
>> +}
>> +
> 
> [...]
> 
>> +static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
>> +{
>> +	u32 cs2, link_speed, remote_supported_link_speeds, tmp;
>> +	u32 pcie_cap = RZG3S_PCI_CFG_PCIEC;
>> +	u8 ltssm_state_l0 = 0xc;
>> +	u16 lcs;
>> +	int ret;
>> +
>> +	/*
>> +	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.6.3 Caution
>> +	 * when Changing the Speed Spontaneously) link speed change can be done
>> +	 * only when the link training and status state machine in the PCIe Core
>> +	 * Link is L0.
> 
> "...only when the LTSSM is in L0."

Ok

> 
>> +	 */
>> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, tmp,
>> +				 FIELD_GET(RZG3S_PCI_PCSTAT1_LTSSM_STATE, tmp) == ltssm_state_l0,
>> +				 PCIE_LINK_WAIT_SLEEP_MS,
>> +				 PCIE_LINK_WAIT_SLEEP_MS *
>> +				 PCIE_LINK_WAIT_MAX_RETRIES * MILLI);
>> +	if (ret) {
>> +		dev_dbg(host->dev,
>> +			"Could not set max link speed! LTSSM not in L0, state=%lx\n",
> 
> You should drop 'Could not set max link speed' since the caller is printing a
> similar error.

Ok, I'll drop.

> 
>> +			FIELD_GET(RZG3S_PCI_PCSTAT1_LTSSM_STATE, tmp));
>> +		return ret;
>> +	}
>> +
>> +	lcs = readw(host->pcie + pcie_cap + PCI_EXP_LNKSTA);
>> +	cs2 = readl(host->axi + RZG3S_PCI_PCSTAT2);
>> +
>> +	link_speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, lcs);
>> +	remote_supported_link_speeds = FIELD_GET(RZG3S_PCI_PCSTAT2_SDRIRE, cs2);
>> +
>> +	/*
>> +	 * Return if link is @ 5.0 GT/s or the connected device doesn't support
>> +	 * it.
>> +	 */
>> +	if (link_speed == PCI_EXP_LNKSTA_CLS_5_0GB ||
>> +	    !(remote_supported_link_speeds != GENMASK(PCI_EXP_LNKSTA_CLS_5_0GB - 1, 0)))
>> +		return 0;
>> +
>> +	/* Set target Link speed to 5.0 GT/s */
> 
> Instead of setting the link speed to 5 GT/s always, you should honor the link
> speed set in DTS by making use of of_pci_get_max_link_speed() API.

Will check it.

> 
>> +	rzg3s_pcie_update_bits(host->pcie, pcie_cap + PCI_EXP_LNKCTL2,
>> +			       PCI_EXP_LNKCTL2_TLS,
>> +			       FIELD_PREP(PCI_EXP_LNKCTL2_TLS,
>> +					  PCI_EXP_LNKCTL2_TLS_5_0GT));
>> +
>> +	/* Request link speed change */
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PCCTRL2,
>> +			       RZG3S_PCI_PCCTRL2_LS_CHG_REQ |
>> +			       RZG3S_PCI_PCCTRL2_LS_CHG,
>> +			       RZG3S_PCI_PCCTRL2_LS_CHG_REQ |
>> +			       FIELD_PREP(RZG3S_PCI_PCCTRL2_LS_CHG,
>> +					  PCI_EXP_LNKCTL2_TLS_5_0GT - 1));
>> +
>> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT2, cs2,
>> +				 (cs2 & RZG3S_PCI_PCSTAT2_LS_CHG_DONE),
>> +				 PCIE_LINK_WAIT_SLEEP_MS,
>> +				 PCIE_LINK_WAIT_SLEEP_MS *
>> +				 PCIE_LINK_WAIT_MAX_RETRIES * MILLI);
>> +
>> +	/*
>> +	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.6.3 Caution
>> +	 * when Changing the Speed Spontaneously) the PCI_PCCTRL2_LS_CHG_REQ
>> +	 * should be de-asserted after checking for PCI_PCSTAT2_LS_CHG_DONE.
>> +	 */
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PCCTRL2,
>> +			       RZG3S_PCI_PCCTRL2_LS_CHG_REQ, 0);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>> +{
>> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>> +	struct resource_entry *ft;
>> +	struct resource *bus;
>> +	u8 subordinate_bus;
>> +	u8 secondary_bus;
>> +	u8 primary_bus;
>> +
>> +	ft = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>> +	if (!ft)
>> +		return -ENODEV;
>> +
>> +	bus = ft->res;
>> +	primary_bus = bus->start;
>> +	secondary_bus = bus->start + 1;
>> +	subordinate_bus = bus->end;
>> +
>> +	/* Enable access control to the CFGU */
>> +	writel(RZG3S_PCI_PERM_CFG_HWINIT_EN, host->axi + RZG3S_PCI_PERM);
>> +
>> +	/* Update vendor ID and device ID */
> 
> Are you really updating it or setting it? If you are updating it, are the
> default IDs invalid?

Default IDs are valid (at least on RZ/G3S) but Renesas specific. Renesas
wants to let individual users to set their own IDs.

> 
>> +	writew(host->vendor_id, host->pcie + PCI_VENDOR_ID);
>> +	writew(host->device_id, host->pcie + PCI_DEVICE_ID);
>> +
>> +	/* HW manual recommends to write 0xffffffff on initialization */
>> +	writel(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
>> +	writel(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
>> +
>> +	/* Update bus info. */
>> +	writeb(primary_bus, host->pcie + PCI_PRIMARY_BUS);
>> +	writeb(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
>> +	writeb(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);
>> +
>> +	/* Disable access control to the CFGU */
>> +	writel(0, host->axi + RZG3S_PCI_PERM);
>> +
>> +	return 0;
>> +}
>> +
> 
> [...]
> 
>> +static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host, bool probe)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	/* Initialize the PCIe related registers */
>> +	ret = rzg3s_pcie_config_init(host);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Initialize the interrupts */
>> +	rzg3s_pcie_irq_init(host);
>> +
>> +	ret = reset_control_bulk_deassert(host->data->num_cfg_resets,
>> +					  host->cfg_resets);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for link up */
>> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
>> +				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS),
>> +				 PCIE_LINK_WAIT_SLEEP_MS,
>> +				 PCIE_LINK_WAIT_SLEEP_MS *
>> +				 PCIE_LINK_WAIT_MAX_RETRIES * MILLI);
>> +	if (ret) {
>> +		reset_control_bulk_assert(host->data->num_cfg_resets,
>> +					  host->cfg_resets);
>> +		return ret;
>> +	}
>> +
>> +	val = readl(host->axi + RZG3S_PCI_PCSTAT2);
>> +	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
>> +
>> +	val = FIELD_GET(RZG3S_PCI_PCSTAT2_STATE_RX_DETECT, val);
>> +	dev_info(host->dev, "PCIe x%d: link up\n", hweight32(val));
>> +
>> +	if (probe) {
>> +		ret = devm_add_action_or_reset(host->dev,
>> +					       rzg3s_pcie_cfg_resets_action,
>> +					       host);
> 
> Oh well, this gets ugly. Now the devm_add_action_or_reset() is sprinkled
> throughout the driver :/
> 
> As I said earlier, there are concerns in unloading the driver if it implements
> an irqchip. So if you change the module_platform_driver() to
> builtin_platform_driver() for this driver, these devm_add_action_or_reset()
> calls become unused.

They can still be useful in case the probe fails. As the initialization
path is complicated, having actions or resets looks to me that makes the
code cleaner as the rest of devm_* helpers.

I can drop it and replace with gotos and dedicated functions but this will
complicate the code, AFAICT.

Please let me know how would you like me to proceed.

> 
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void rzg3s_pcie_set_inbound_window(struct rzg3s_pcie_host *host,
>> +					  u64 cpu_addr, u64 pci_addr, u64 size,
>> +					  int id)
>> +{
>> +	/* Set CPU window base address */
>> +	writel(upper_32_bits(cpu_addr), host->axi + RZG3S_PCI_ADESTU(id));
>> +	writel(lower_32_bits(cpu_addr), host->axi + RZG3S_PCI_ADESTL(id));
>> +
>> +	/* Set window size */
>> +	writel(upper_32_bits(size), host->axi + RZG3S_PCI_AWMASKU(id));
>> +	writel(lower_32_bits(size), host->axi + RZG3S_PCI_AWMASKL(id));
>> +
>> +	/* Set PCIe window base address and enable the window */
>> +	writel(upper_32_bits(pci_addr), host->axi + RZG3S_PCI_AWBASEU(id));
>> +	writel(lower_32_bits(pci_addr) | RZG3S_PCI_AWBASEL_WIN_ENA,
>> +	       host->axi + RZG3S_PCI_AWBASEL(id));
>> +}
>> +
>> +static int rzg3s_pcie_set_inbound_windows(struct rzg3s_pcie_host *host,
>> +					  struct resource_entry *entry,
>> +					  int *index)
>> +{
>> +	u64 pci_addr = entry->res->start - entry->offset;
>> +	u64 cpu_addr = entry->res->start;
>> +	u64 cpu_end = entry->res->end;
>> +	u64 size_id = 0;
>> +	int id = *index;
>> +	u64 size;
>> +
>> +	while (cpu_addr < cpu_end) {
>> +		if (id >= RZG3S_MAX_WINDOWS)
>> +			return dev_err_probe(host->dev, -EINVAL,
> 
> -ENOSPC
> 
>> +					     "Failed to set inbound windows!\n");
> 
> "Failed to map inbound window for resource (%s), entry->res->name"

Ok

> 
>> +
>> +		size = resource_size(entry->res) - size_id;
>> +
>> +		/*
>> +		 * According to the RZ/G3S HW manual (Rev.1.10,
>> +		 * section 34.3.1.71 AXI Window Mask (Lower) Registers) the min
>> +		 * size is 4K.
>> +		 */
>> +		size = max(size, SZ_4K);
>> +
>> +		/*
>> +		 * According the RZ/G3S HW manual (Rev.1.10, sections:
>> +		 * - 34.3.1.69 AXI Window Base (Lower) Registers
>> +		 * - 34.3.1.71 AXI Window Mask (Lower) Registers
>> +		 * - 34.3.1.73 AXI Destination (Lower) Registers)
>> +		 * the CPU addr, PCIe addr, size should be 4K aligned and be a
>> +		 * power of 2.
>> +		 */
>> +		size = ALIGN(size, SZ_4K);
>> +
>> +		/*
>> +		 * According to the RZ/G3S HW manual (Rev.1.10, section
>> +		 * 34.3.1.71 AXI Window Mask (Lower) Registers) HW expects first
>> +		 * 12 LSB bits to be 0xfff. Subtract 1 from size for this.
>> +		 */
>> +		size = roundup_pow_of_two(size) - 1;
>> +
>> +		cpu_addr = ALIGN(cpu_addr, SZ_4K);
>> +		pci_addr = ALIGN(pci_addr, SZ_4K);
>> +
>> +		rzg3s_pcie_set_inbound_window(host, cpu_addr, pci_addr, size,
>> +					      id);
>> +
>> +		pci_addr += size;
>> +		cpu_addr += size;
>> +		size_id = size;
>> +		id++;
>> +	}
>> +	*index = id;
>> +
>> +	return 0;
>> +}
> 
> [...]
> 
>> +static int rzg3s_pcie_parse_map_ranges(struct rzg3s_pcie_host *host)
>> +{
>> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>> +	struct resource_entry *win;
>> +	int i = 0;
>> +
>> +	resource_list_for_each_entry(win, &bridge->windows) {
>> +		struct resource *res = win->res;
>> +
>> +		if (i >= RZG3S_MAX_WINDOWS)
>> +			return dev_err_probe(host->dev, -EINVAL,
> 
> -ENOSPC

Ok

> 
>> +					     "Failed to set outbound windows!\n");
> 
> "Failed to map outbound window for resource (%s), res->name"

Ok

> 
>> +
>> +		if (!res->flags)
>> +			continue;
>> +
>> +		switch (resource_type(res)) {
>> +		case IORESOURCE_IO:
>> +		case IORESOURCE_MEM:
>> +			rzg3s_pcie_set_outbound_window(host, win, i);
>> +			i++;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
> [...]
> 
>> +static int rzg3s_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct pci_host_bridge *bridge;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct device_node *sysc_np __free(device_node) =
>> +		of_parse_phandle(np, "renesas,sysc", 0);
>> +	struct rzg3s_pcie_host *host;
>> +	int ret;
>> +
>> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
>> +	if (!bridge)
>> +		return -ENOMEM;
>> +
>> +	host = pci_host_bridge_priv(bridge);
>> +	host->dev = dev;
>> +	host->data = device_get_match_data(dev);
>> +	platform_set_drvdata(pdev, host);
>> +
>> +	host->axi = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(host->axi))
>> +		return PTR_ERR(host->axi);
>> +	host->pcie = host->axi + RZG3S_PCI_CFG_BASE;
>> +
>> +	ret = of_property_read_u32(np, "vendor-id", &host->vendor_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = of_property_read_u32(np, "device-id", &host->device_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	host->sysc = syscon_node_to_regmap(sysc_np);
>> +	if (IS_ERR(host->sysc))
>> +		return PTR_ERR(host->sysc);
>> +
>> +	ret = regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>> +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>> +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_add_action_or_reset(dev, rzg3s_pcie_sysc_signal_action,
>> +				       host->sysc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = rzg3s_pcie_resets_prepare(host);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret)
>> +		return ret;
>> +
> 
> Do you really need to do resume_and_get()? If not, you should do:

It it's needed to enable the clock PM domain the device is part of.

> 
> 	pm_runtime_set_active()
> 	pm_runtime_no_callbacks()
> 	devm_pm_runtime_enable()
> 
>> +	ret = devm_add_action_or_reset(dev, rzg3s_pcie_pm_runtime_put, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	raw_spin_lock_init(&host->hw_lock);
>> +
>> +	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_intx_setup,
>> +				    rzg3s_pcie_msi_enable, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msleep(PCIE_RESET_CONFIG_WAIT_MS);
>> +
>> +	bridge->sysdata = host;
>> +	bridge->ops = &rzg3s_pcie_root_ops;
>> +	bridge->child_ops = &rzg3s_pcie_child_ops;
>> +	ret = pci_host_probe(bridge);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_add_action_or_reset(dev, rzg3s_pcie_host_remove_action,
>> +					host);
>> +}
>> +
>> +static int rzg3s_pcie_suspend_noirq(struct device *dev)
>> +{
>> +	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
>> +	const struct rzg3s_pcie_soc_data *data = host->data;
>> +	struct regmap *sysc = host->sysc;
>> +	int ret;
>> +
>> +	ret = pm_runtime_put_sync(dev);
>> +	if (ret)
>> +		return ret;
> 
> Since there are no runtime callbacks present, managing runtime PM in the driver
> makes no sense.

The PCIe device is part of a clock power domain. Dropping
pm_runtime_enable()/pm_runtime_put_sync() in this driver will lead to this
IP failing to work as its clocks will not be enabled/disabled. If you don't
like the pm_runtime_* approach that could be replaced with:

devm_clk_get_enabled() in probe and clk_disable()/clk_enable() on
suspend/resume. W/o clocks the IP can't work.

Please let me know what approach is prefered here.


> 
>> +
>> +	ret = reset_control_bulk_assert(data->num_power_resets,
>> +					host->power_resets);
>> +	if (ret)
>> +		goto rpm_restore;
>> +
>> +	ret = reset_control_bulk_assert(data->num_cfg_resets,
>> +					host->cfg_resets);
>> +	if (ret)
>> +		goto power_resets_restore;
>> +
>> +	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>> +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>> +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
>> +	if (ret)
>> +		goto cfg_resets_restore;
>> +
>> +	return 0;
>> +
>> +	/* Restore the previous state if any error happens */
>> +cfg_resets_restore:
>> +	reset_control_bulk_deassert(data->num_cfg_resets,
>> +				    host->cfg_resets);
>> +power_resets_restore:
>> +	reset_control_bulk_deassert(data->num_power_resets,
>> +				    host->power_resets);
>> +rpm_restore:
>> +	pm_runtime_resume_and_get(dev);
>> +	return ret;
>> +}
>> +
> 
> [...]
> 
>> +static struct platform_driver rzg3s_pcie_driver = {
>> +	.driver = {
>> +		.name = "rzg3s-pcie-host",
>> +		.of_match_table = rzg3s_pcie_of_match,
>> +		.pm = pm_ptr(&rzg3s_pcie_pm_ops),
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe = rzg3s_pcie_probe,
>> +};
>> +module_platform_driver(rzg3s_pcie_driver);
> 
> Use builtin_platform_driver() as this driver is not supposed to be removed due
> to concersn with irqchip.

Ok

Thank you,
Claudiu

> 
> - Mani
> 


