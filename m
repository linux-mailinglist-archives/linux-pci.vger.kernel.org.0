Return-Path: <linux-pci+bounces-9455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1949791CF37
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 23:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B434A1F219A8
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407C13B597;
	Sat, 29 Jun 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAGGW/eK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA413A258;
	Sat, 29 Jun 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719696874; cv=none; b=GdiIyeR3snWI8jnMTWsx+rkFGSyN1dEM10sUiArH3hxF0F0IDRu+xt1X0HWnedNVEvGW49926B9h2YVkXh4AG1MIHCbTtHidyWifrMGTprf8GvXyOTU6RLVgRDALqbf2im74t6eoF7AkYbBGv3BSAdlP38gqggXPoqKwq1l30M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719696874; c=relaxed/simple;
	bh=brAlC7GMJ52jyyUcexG5QqXWVvYk3xfdSHoPpTs+Hm0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VcSeKboEXCaJMZ6Xy7lsWAZbz60oq9yzZm1BdnntWrguecNpMV96aYt0bTSeT8T6RyNHhMP4EIceINOni3aEWgQlGsj2098epb6htZ6hiypNoWWn5kqNpK5PDAOKL/oC78LjFsf0tCGD+jWYgd8viMEJcfg2vYRHLomnhIpSKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAGGW/eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11732C2BBFC;
	Sat, 29 Jun 2024 21:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719696874;
	bh=brAlC7GMJ52jyyUcexG5QqXWVvYk3xfdSHoPpTs+Hm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kAGGW/eKuwYX2q/7m3gDl2n6UmKMTFpyU4Mt/SgF7jMcMNAXzxlmylg0w1Ys9hTAv
	 aniObAIzSOxTvwx226nyWyGh2oHd5zU6VvtgRI35IuiHZ8WlqaYVZkXB0r/yil78zS
	 YyGW29Z4N9/qNazLfD1H/63r+ihkUMwLqN0eSan2mG/dD2N2Dx6CwqvUWHam/+kKVf
	 HrOGDYL2th9E6k90vG0cbVHkf0DAGZWgr1Bgx59BS5T6EiLtQCLkfMSyVUvA4Ey2WE
	 RC6PnkVub878djH1cB7bL/kAAo4ty0IdJ5RQOdoH2v43Clj5aQv136i9YLyWTxTkM/
	 Teg2cN0hcFwQw==
Date: Sat, 29 Jun 2024 16:34:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lkp@intel.com,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] PCI: Enable io space 1k granularity for intel cpu
 root port
Message-ID: <20240629213432.GA1485157@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240627005856.11449-1-zhoushengqing@ttyinfo.com>

On Thu, Jun 27, 2024 at 12:58:56AM +0000, Zhou Shengqing wrote:
> This patch add 1k granularity for intel root port bridge.Intel latest
> server CPU support 1K granularity,And there is an BIOS setup item named
> "EN1K",but linux doesn't support it. if an IIO has 5 IOU (SPR has 5 IOUs)
> all are bifurcated 2x8.In a 2P server system,There are 20 P2P bridges
> present.if keep 4K granularity allocation,it need 20*4=80k io space,
> exceeding 64k.I test it in a 16*nvidia 4090s system under intel eaglestrem
> platform.There are six 4090s that cannot be allocated I/O resources.
> So I applied this patch.And I found a similar implementation in quirks.c,
> but it only targets the Intel P64H2 platform.
> 
> Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> ---
>  drivers/pci/probe.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5fbabb4e3425..909962795311 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -461,6 +461,9 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
>  	u32 buses;
>  	u16 io;
>  	u32 pmem, tmp;
> +	u16 ven_id, dev_id;
> +	u16 en1k = 0;
> +	struct pci_dev *dev = NULL;
>  	struct resource res;
>  
>  	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
> @@ -478,6 +481,26 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
>  	}
>  	if (io) {
>  		bridge->io_window = 1;
> +		if (pci_is_root_bus(bridge->bus)) {
> +			list_for_each_entry(dev, &bridge->bus->devices, bus_list) {
> +				pci_read_config_word(dev, PCI_VENDOR_ID, &ven_id);
> +				pci_read_config_word(dev, PCI_DEVICE_ID, &dev_id);
> +				if (ven_id == PCI_VENDOR_ID_INTEL && dev_id == 0x09a2) {
> +					/*IIO MISC Control offset 0x1c0*/
> +					pci_read_config_word(dev, 0x1c0, &en1k);
> +				}
> +			}
> +		/*
> +		 *Intel ICX SPR EMR GNR
> +		 *IIO MISC Control (IIOMISCCTRL_1_5_0_CFG) — Offset 1C0h
> +		 *bit 2:Enable 1K (EN1K)
> +		 *This bit when set, enables 1K granularity for I/O space decode
> +		 *in each of the virtual P2P bridges
> +		 *corresponding to root ports, and DMI ports.
> +		 */
> +		if (en1k & 0x4)
> +			bridge->io_window_1k = 1;
> +		}

I still think this is not going to work because I don't want this kind
of device-specific clutter in this generic path. The pcibios_*
interfaces are history that we'd like to get rid of also, but it would
be better than putting it here.

Please follow english conventions as much as you can, e.g., space
after "*" in comments, space after period at end of sentence,
capitalize first word of sentence, blank line between paragraphs.
Most of this you can see by looking at other comments.

>  		pci_read_bridge_io(bridge, &res, true);
>  	}
>  
> -- 
> 2.39.2
> 

