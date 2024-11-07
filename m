Return-Path: <linux-pci+bounces-16252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8D89C0A2B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA0E1F2293D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C15212D0C;
	Thu,  7 Nov 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmn+U1lQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7229CF4;
	Thu,  7 Nov 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993680; cv=none; b=TSpdgAZ/MTy/lj7xnSgY7yksDhLGH377KK0wLMRAKRXHc7nkwLf48bNGWreM31DAdDs1UXkZN3MU7mUr4QYF5JDbSY2EWvOjHtpcrPBxsPKYVEVonXtD6QqMm29N6fabE3dijabvvxu/0gJb6NFZn8O9GjplO7IQYwsdlxgBJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993680; c=relaxed/simple;
	bh=jZhjHoB+nmcMqdQ5Wsc7E6yYEuLOTJLi4fNU7sXH7pw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LeQc+dm4xm/dhkVUXZotN621eypBd4wEFUfhQiiV/yzoPWwD/fbZtfuFlzde6vQZniFB6Fg0vOdhWcl0Cep4pYLenBJuSKqsUXcgh1EC19q7LX0ycXDVMmzHdHaGv4ddtav4uzmZSlN0+Npjdz6lqVbAykkZR1E5iEVOUq9WyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmn+U1lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE76C4CECC;
	Thu,  7 Nov 2024 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730993679;
	bh=jZhjHoB+nmcMqdQ5Wsc7E6yYEuLOTJLi4fNU7sXH7pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qmn+U1lQvTG5t/YpiszQ0HL5PrL/4zwnnqJZpocmg+x5muIsT+gHFlb7KRA49ytoa
	 bcNJO7A9L5h6OgObsfE3hf0YvIVQCkufJ6qYg69q1CQldcqw7btjWn/xaFSxUEyTZt
	 xFR/tBoo/n9WNFdTsQyqyEzvFXN/9pOtGqLLLvKXLCERgQwGd3IjPTBElU0rZ9lc4Y
	 884BnugI8TX4QJXgfS8ggfQ5R0AuQ7wVC41RWaFGLuMv8S//sQEarXRCOlfCmyC8Lo
	 pqfg8fwGzh89U1rZqTfZsSMrrQpXqVUmE2dTEbTZUTMOFdzq58aQjPB4Q6/q61Ioj8
	 pmgF/x8Fth24A==
Date: Thu, 7 Nov 2024 09:34:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: bhelgaas@google.com, macro@orcam.me.uk, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC] PCI: Fix the issue of link speed downgrade after link
 retraining
Message-ID: <20241107153438.GA1614749@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107143758.12643-1-guojinhui.liam@bytedance.com>

[+cc Lukas, -cc stable]

On Thu, Nov 07, 2024 at 10:37:58PM +0800, Jinhui Guo wrote:
> The link speed is downgraded to 2.5 GT/s when a Samsung NVMe device
> is hotplugged into a Intel PCIe root port [8086:0db0].
> 
> ```
> +-[0000:3c]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d
> |           ...
> |           +02.0-[3d]----00.0  Samsung Electronics Co Ltd Device a80e
> ```
> 
> Some printing information can be obtained when the issue emerges.
> "Card present" is reported twice via external interrupts due to
> a slight tremor when the Samsung NVMe device is plugged in.
> The failure of the link activation for the first time leads to
> the link speed of the root port being mistakenly downgraded to 2.5G/s.
> 
> ```
> [ 8223.419682] pcieport 0000:3d:02.0: pciehp: Slot(1): Card present
> [ 8224.449714] pcieport 0000:3d:02.0: broken device, retraining non-functional downstream link at 2.5GT/s
> [ 8225.518723] pcieport 0000:3d:02.0: pciehp: Slot(1): Card present
> [ 8225.518726] pcieport 0000:3d:02.0: pciehp: Slot(1): Link up
> ```

No need for markdown in commit logs.  Drop timestamps (I don't think
they are telling us anything useful here).  Indent quoted material a
couple spaces.

Nothing here looks specific to the Intel Root Port or the NVMe device;
I assume any hot-added device could see the same problem, at least
with pciehp.

> To avoid wrongly setting the link speed to 2.5GT/s, only allow
> specific pcie devices to perform link retrain.

s/pcie/PCIe/

> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/pci/quirks.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dccb60c1d9cc..59858156003b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -91,7 +91,8 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  	int ret = -ENOTTY;
>  
>  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
> -	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> +	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting ||
> +		!pci_match_id(ids, dev))
>  		return ret;
>  
>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> @@ -119,8 +120,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  	}
>  
>  	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
> -	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
> -	    pci_match_id(ids, dev)) {
> +	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
>  		u32 lnkcap;
>  
>  		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
> -- 
> 2.20.1
> 

