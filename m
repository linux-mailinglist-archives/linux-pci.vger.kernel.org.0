Return-Path: <linux-pci+bounces-27582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45140AB3986
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0ED1889E9F
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01C29375D;
	Mon, 12 May 2025 13:43:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5C2920B9;
	Mon, 12 May 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057386; cv=none; b=D5s+vvjWwKsyknC3ahSqpCN+eAdtSm3jXlVMTFfGCv1Gxl7ktQpmv47Wq4y4dQme6H/2ehs05vzI91p/Dr3M6W2kmqydieT3oM6F1Vd5bOz9cR1kZ1ysmwfnhexzs8ZFXLvNoHHBR5M6UTMuqqtg4Y7WqxIB4IRDtFWNfSY7Jl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057386; c=relaxed/simple;
	bh=/oZGeOpr451hVHqDr+ryQaywE9Qrhm/laxNZuHQTJ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui05KynpLiVYr6/7f4jnFoKZ/7aYYeRsHbK/b60plOlcS1cAcMDEjuQJSeo15CupgbDbieXcd00RUeXuqWXfB2JfwdEP+gYXw89mI+75SRkwJXvb0bro8KtAlmvHdtu4XWXdBXPM42qUUzlq7yIMsrXpQN+puyRL7rXbdSx2ETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 314852C06842;
	Mon, 12 May 2025 15:42:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B5CAD45043; Mon, 12 May 2025 15:43:01 +0200 (CEST)
Date: Mon, 12 May 2025 15:43:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Update Link Speed after retraining
Message-ID: <aCH65bOzLKMdMzQR@wunner.de>
References: <20250512130125.9062-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512130125.9062-1-ilpo.jarvinen@linux.intel.com>

On Mon, May 12, 2025 at 04:01:24PM +0300, Ilpo Järvinen wrote:
> PCIe Link Retraining can alter Link Speed. While bwctrl listens for
> Link Bandwidth Management Status (LBMS) to pick up changes in Link
> Speed, there is a race between pcie_reset_lbms() clearing LBMS after
> the Link Training and pcie_bwnotif_irq() reading the Link Status
> register. If LBMS is already cleared when the irq handler reads the
> register, the interrupt handler will return early with IRQ_NONE and
> won't update the Link Speed.
> 
> When Link Speed update originates from bwctrl,
> pcie_bwctrl_change_speed() ensures Link Speed is update after the
                                                   ^^^^^^
Nit: updated

> retraining. ASPM driver, however, calls pcie_retrain_link() but does
> not update the Link Speed after retraining which can result in stale
> Link Speed.
> 
> To ensure Link Speed is not left state after Link Training, move the
                                   ^^^^^
Nit: stale

> call to pcie_update_link_speed() from pcie_bwctrl_change_speed() into
> pcie_retrain_link().

Actually aspm.c is compiled into the kernel even if CONFIG_PCIEPORTBUS=n,
so it's possible to have ASPM support without also having the bandwidth
controller.  And in that case it could likewise happen that retraining
by aspm.c results in a different link speed which needs to be updated.

Hence the discussion in the commit message and code comments about
a race with the bandwidth controller's IRQ handler seems somewhat
misleading.  Yes, if the bandwidth controller is enabled it will
pick up the new speed if aspm.c's retraining results in a speed change,
but may fail to do so because of the race.  But aspm.c needs to update
the link speed regardless because the bandwidth controller may not
even be enabled in the first place.

> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://lore.kernel.org/linux-pci/aBCjpfyYmlkJ12AZ@wunner.de/
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Code change itself is fine and

Reviewed-by: Lukas Wunner <lukas@wunner.de>

> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4718,6 +4718,11 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>   * @pdev: Device whose link to retrain.
>   * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE, for status.
>   *
> + * Trigger retraining of the PCIe Link and wait for the completion of the
> + * retraining. As link retraining is known to asserts LBMS and may change
                                                 ^^^^^^^
Nit: assert

Thanks,

Lukas

