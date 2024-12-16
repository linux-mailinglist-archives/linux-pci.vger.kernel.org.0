Return-Path: <linux-pci+bounces-18507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B909F324F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2EE18826D4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790E204585;
	Mon, 16 Dec 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTZYHmqr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396B1C8FD7
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358205; cv=none; b=bHGpuCEDVRaxIFQKw43bFRbSxTAbpIvadtK/8d/ZckqQrBzIgQdA4m7ZGjwvr5QrHWkoMOg0iECzdzsB/Vj7zTRYQH7rikNvdH7WbaQ9LFrXXT3LOCqFcVB5fTscGJJVQH7JYaGHu/GWjwavbMB41odPpS7CK2avPIAZqi9z+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358205; c=relaxed/simple;
	bh=z85P0fZ3wuEkCrTcjsOBTbT10imUstXo3Yd2HS5R6JI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=unVRKRRsafMVskYdSzZvXTZFhezvQ0BA6qWvnWsbUhgqX9givIBkMgP3/oSVTrr64zJYXZGL2P9jIvNRA+d6WtIYYkdV08zBGH6n2VLb8BryvWX9gFN6cRDKmyr7xBQFOpaq9aLWquG49G74rePI3chb7E8JIhfa0uhNyhaq0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTZYHmqr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734358204; x=1765894204;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z85P0fZ3wuEkCrTcjsOBTbT10imUstXo3Yd2HS5R6JI=;
  b=TTZYHmqrp8xFsB4+zKjxe04IrL8HXRP0j/NnuHVLjawkIKKQ2ItGJZSh
   lvyqXzHJUqznQR7sJm3/2kAtppaTO97WeBbVRYk6G7CZhf3lCiFjzW2y1
   2fXU6twXrRIzNt3jspWNA1hmMqSgQzAnIDHyDks6qGgKrTxQK97whlFRI
   Yci+YKmVnCqv5HPdRszSaGhUr6PDNtew2kKAV93GxSplT62iQQlJYe2XE
   idZd3806dqVdDMgqZttxasXa5zfRWAUvJGXb16fve9de1aeFz08QLgQM5
   gpRlCHY21HXL1RTgNFxR+WouzZOoTKgpmE8UTFmZ9PMiHsZ4medZJgwEE
   Q==;
X-CSE-ConnectionGUID: 1uQ+IiArTEK5XmnLsBh+KA==
X-CSE-MsgGUID: PMtKctmSTq+Kw4vhijEFBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45226522"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45226522"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 06:10:03 -0800
X-CSE-ConnectionGUID: iDkZYhCYTnuWa4G8Wbv4Jg==
X-CSE-MsgGUID: On9LSFbcSl2a/iFueeRBVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97653537"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 06:10:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Dec 2024 16:09:56 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v2 1/3] PCI: Assume 2.5 GT/s if Max Link Speed
 is undefined
In-Reply-To: <1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
Message-ID: <c2cb6b11-ea32-2c63-4ee8-1fd61f567dea@linux.intel.com>
References: <cover.1734257330.git.lukas@wunner.de> <1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 15 Dec 2024, Lukas Wunner wrote:

> Broken PCIe devices may not set any of the bits in the Link Capabilities
> Register's "Max Link Speed" field.  Assume 2.5 GT/s in such a case,
> which is the lowest possible PCIe speed.  It must be supported by every
> device per PCIe r6.2 sec 8.2.1.
> 
> Emit a message informing about the malformed field.  Use KERN_INFO
> severity to minimize annoyance.  This will help silicon validation
> engineers take note of the issue so that regular users hopefully never
> see it.
> 
> There is currently no known affected product, but a subsequent commit
> will honor the Max Link Speed field when determining supported speeds
> and depends on the field being well-formed.  (It uses the Max Link Speed
> as highest bit in a GENMASK(highest, lowest) macro and if the field is
> zero, that would result in GENMASK(0, lowest).)
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35dc9f249b86..ab0ef7b6c798 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6233,6 +6233,13 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  	u32 lnkcap2, lnkcap;
>  	u8 speeds;
>  
> +	/* A device must support 2.5 GT/s (PCIe r6.2 sec 8.2.1) */
> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +	if (!(lnkcap & PCI_EXP_LNKCAP_SLS)) {
> +		pci_info(dev, "Undefined Max Link Speed; assume 2.5 GT/s\n");
> +		return PCI_EXP_LNKCAP2_SLS_2_5GB;
> +	}

After some more thinking, I realized this is probably not a good idea (I 
know you got it from me :-(). IIRC, this function is also called for 
RCiEPs and they do not have to implement these registers. I saw 
supported_speeds were 0 for many devices, for most to be more precise,
while developing bwctrl (none of those impacted bwctrl).

If I'm correct, that print out should trigger many times on a simple boot 
test so it should be easy to confirm.

-- 
 i.

> +
>  	/*
>  	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
>  	 * Speeds Vector to allow using SLS Vector bit defines directly.
> @@ -6244,8 +6251,6 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  	if (speeds)
>  		return speeds;
>  
> -	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> -
>  	/* Synthesize from the Max Link Speed field */
>  	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
>  		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
> 


