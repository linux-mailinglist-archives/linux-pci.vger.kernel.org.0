Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8164F8AB0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 02:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiDGWe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 18:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiDGWeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 18:34:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B113E88;
        Thu,  7 Apr 2022 15:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2130B829A7;
        Thu,  7 Apr 2022 22:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E89C385A4;
        Thu,  7 Apr 2022 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649370737;
        bh=dLO/D3nL1f64UtF+spus0K/GKQhrE9Nu7Ou/L3Uy3Og=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sp2hT5KYp7bW4QdGUrzkGf9SF8LKBQzemdv3dG17BeeB22Gnh5mcP+N63zIS3e7RZ
         oKgpzP1R1M1qhREYzqttHyuQcwC2FtahaqOThIckfBvDTHAFTfyyNl/B4f39VhB6OM
         A0yvh36KkV/qDROrWFB47X7jUWwnmP7TkrZQE32vuDZM2uwUdNssAzC0TkY1q255nH
         hmSRnLcZ2mB/g2WKn8s1ewap2863WH47CmFEbJDbULXIfBOnTRSQCNQE0x3Gs4uO23
         PiaUcM5MhJ3H+3K/7GIsw+2A56lL9DUkjTiTu7+DG6txE5ROn2Tq69Ih5IlJzlv00o
         /AUuItqOwm6zQ==
Date:   Thu, 7 Apr 2022 17:32:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shlomo Pongratz <shlomopongratz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, jgg@nvidia.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V6 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220407223215.GA265412@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403102008.7122-2-shlomop@pliops.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 03, 2022 at 01:20:08PM +0300, Shlomo Pongratz wrote:
> In commit 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C,
>  D to the whitelist")
> Andrew Maier added the Sky Lake-E additional devices
> 2031, 2032 and 2033 root ports to the already existing 2030 device.
> 
> The Intel devices 2030, 2031, 2032 and 2033 which are root ports A, B, C
> and D, respectively and if all exist they will occupy slots 0 till 3 in
> that order.
> 
> The original code handled only the case where the devices in the whitelist
> are host bridges and assumed that they will be found on slot 0.
> 
> Since this assumption doesn't hold for root ports, add a test to cover this
> case.
> 
> Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
> ---
>  drivers/pci/p2pdma.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 30b1df3c9d2f..c281bf5b304a 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -327,15 +327,19 @@ static const struct pci_p2pdma_whitelist_entry {
>  
>  /*
>   * This lookup function tries to find the PCI device corresponding to a given
> - * host bridge.
> + * host bridge or a root port.
>   *
>   * It assumes the host bridge device is the first PCI device in the
> - * bus->devices list and that the devfn is 00.0. These assumptions should hold
> - * for all the devices in the whitelist above.
> + * bus->devices list and that the devfn is 00.0. The first assumption should
> + * hold for all the devices in the whitelist above, however the second
> + * assumption doesn't always hold for root ports.
> + * For example for Intel Skylake devices 2030, 2031, 2032 and 2033,
> + * which are root ports (A, B, C and D respectively).
> + * So the function checks explicitly that the device is a root port.
>   *

> - * This function is equivalent to pci_get_slot(host->bus, 0), however it does
> - * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
> - * sleep.
> + * This function is equivalent to pci_get_slot(host->bus, 0) (except for
> + * the root port test), however it does not take the pci_bus_sem lock seeing
> + * __host_bridge_whitelist() must not sleep.
>   *
>   * For this to be safe, the caller should hold a reference to a device on the
>   * bridge, which should ensure the host_bridge device will not be freed
> @@ -350,7 +354,14 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
>  
>  	if (!root)
>  		return NULL;
> -	if (root->devfn != PCI_DEVFN(0, 0))
> +
> +	/* Verify that the device is a host bridge or a root port
> +	 * It is assumed that host bridges have a 0 devfn, (common practice)
> +	 * but some of the entries in the whitelist are root ports that can
> +	 * have any devfn
> +	 */
> +	if (root->devfn != PCI_DEVFN(0, 0) &&
> +	    pci_pcie_type(root) != PCI_EXP_TYPE_ROOT_PORT)
>  		return NULL;
>  
>  	return root;

The negative logic here makes this hard to read.  The previous code
was the same as:

  if (root->devfn == PCI_DEVFN(0, 0))
    return root;

  return NULL;

I think this patch would be easier to read if you made it:

  if (root->devfn == PCI_DEVFN(0, 0))
    return root;

  if (pci_pcie_type(root) == PCI_EXP_TYPE_ROOT_PORT)
    return root;

  return NULL;

IIUC, this patch tweaks it so we take the first device on the bus and
if it is either 00.0 or a Root Port, we search pci_p2pdma_whitelist[]
for it.
