Return-Path: <linux-pci+bounces-9098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C905912F1A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 23:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA0F1C218DD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 21:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D96017BB26;
	Fri, 21 Jun 2024 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B45k1JEc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F716C685;
	Fri, 21 Jun 2024 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003731; cv=none; b=NM1gnBHtgnpEwGySWt5k805Htaw57NgjSkGbTxr3TGm/VFnkZwXVYZkBlFjG6+oNf9NUnUTCYbfU3kl24FTe+B9a8YAnXeXTfxuHs9vLhEQ2A0Wsm2s5wB/h57987TGJsoGJsungsHdsYQLLsTCyOmbDgnsxQ21EuWFzzI5AcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003731; c=relaxed/simple;
	bh=cVBASPMtuHLBcpwDsbTKmBBHudrP2dbeYgIQR+ZOfyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l3MFatULNIfpo7ZdzMWwhtwoceF7herxfcQfDdc9XZElE7hXnUfAdCQMShDjWBnbxXLtEbAhmnTVeS3fmEtHRk6/OVJ807fzmthvxbdMT9/RikHP5eMLA81daGLRP3ihaAT/mbq8n6cCRWq9lpNN3PIEl3BK3YS1jOzURY0fCzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B45k1JEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981CAC2BBFC;
	Fri, 21 Jun 2024 21:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719003730;
	bh=cVBASPMtuHLBcpwDsbTKmBBHudrP2dbeYgIQR+ZOfyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=B45k1JEcwtdMWaJ1vcRCTnN2hGeH4fmzm569Nb6ZKPh9sAj3b5d6b9yx3kMsDwHrS
	 jHoBFjpdhW4yRxvOqtZOK954viLMqdInYV6rClYJbsvSfBhyC0QDYBRQ6qLht5woeO
	 PkbXgN2Y5UhjWLT368aAHgBQplLvl1vkgv8c6eIeI/Z/YtbmKEJ6t+L9LMHwBF27bJ
	 AQnYJcQnHKgh+sRIjeMpwMnRVonItYP2PWAFVIXLmDJKfMYggTtxyJeSp8TtuVpH+i
	 NshpxPZLZtNisyHAXLB6TN2ExRg7OSnKcyf8ERzE2gzATi5xjCridRX8gX3Bw+vz3q
	 1+8M6TaDTeAsQ==
Date: Fri, 21 Jun 2024 16:02:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Enable io space 1k granularity for intel cpu root
 port
Message-ID: <20240621210207.GA1405708@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621020608.28964-1-zhoushengqing@ttyinfo.com>

On Fri, Jun 21, 2024 at 02:06:08AM +0000, Zhou Shengqing wrote:
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
>  drivers/pci/probe.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5fbabb4e3425..3f0c901c6653 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -461,6 +461,8 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
>  	u32 buses;
>  	u16 io;
>  	u32 pmem, tmp;
> +	u16 ven_id, dev_id;
> +	u16 en1k = 0;
>  	struct resource res;
>  
>  	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
> @@ -478,6 +480,26 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
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

Can you implement this as a quirk similar to quirk_p64h2_1k_io()?

I don't want to clutter the generic code with device-specific things
like this.

>  		pci_read_bridge_io(bridge, &res, true);
>  	}
>  
> -- 
> 2.39.2
> 

