Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45714FC4C7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiDKTMr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349545AbiDKTMi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 15:12:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468261EECB;
        Mon, 11 Apr 2022 12:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D37F56146F;
        Mon, 11 Apr 2022 19:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0A9C385A3;
        Mon, 11 Apr 2022 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649704222;
        bh=9O9lMuq+VYGLjiYdPSNFx3ZzewzReFiujsIsDEEGTOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KOyoiOYgtsPQe8CLrIxswda+TPXOcKCfpaMkl3lFMCDNhAtBBla+nNmSnMN5Ph/iV
         HRA5OQ1/s5X1EaOBZ5+gbMXT1G9uHx2kN7W9T9oGzfxHIZCVflt7zl4fYbcqoTtgzj
         KKzwOX5J6StC7+56BSJobiQcp0fgvaajyUu1j8knAcCSXmH1gC0ZRn1Ox3SJ93RtUg
         7fzungoi4XlDv0qVAoag2X6Pg3ZrzLiIVnlSDVYHMO/W/HOcXyhq488Xcg3rDa6gsz
         xTxx5fwn8wVq7i+J4KzN492eWKHRX0VD/qZoLu7mrH10sJ9EqmVfzZDLqcSv3mk6oF
         x4iMEIhSR56MA==
Date:   Mon, 11 Apr 2022 14:10:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shlomo Pongratz <shlomopongratz@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, logang@deltatee.com,
        bhelgaas@google.com, jgg@nvidia.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: Re: [PATCH V7 1/1] Intel Sky Lake-E host root ports check.
Message-ID: <20220411191020.GA530971@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410105213.690-2-shlomop@pliops.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 10, 2022 at 01:52:13PM +0300, Shlomo Pongratz wrote:
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

Applied to pci/p2pdma as below, thanks!

> ---
>  drivers/pci/p2pdma.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 30b1df3c9d2f..187047be83a0 100644
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
> @@ -350,10 +354,19 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
>  
>  	if (!root)
>  		return NULL;
> -	if (root->devfn != PCI_DEVFN(0, 0))
> -		return NULL;
>  
> -	return root;
> +	/* Verify that the device is a host bridge or a root port
> +	 * It is assumed that host bridges have a 0 devfn, (common practice)
> +	 * but some of the entries in the whitelist are root ports that can
> +	 * have any devfn
> +	 */
> +	if (root->devfn == PCI_DEVFN(0, 0))
> +		return root;
> +
> +	if (pci_pcie_type(root) == PCI_EXP_TYPE_ROOT_PORT)
> +		return root;
> +
> +	return NULL;
>  }
>  
>  static bool __host_bridge_whitelist(struct pci_host_bridge *host,

commit 1af7c26c59eb ("PCI/P2PDMA: Whitelist Intel Skylake-E Root Ports at any devfn")
Author: Shlomo Pongratz <shlomopongratz@gmail.com>
Date:   Sun Apr 10 13:52:13 2022 +0300

    PCI/P2PDMA: Whitelist Intel Skylake-E Root Ports at any devfn
    
    In 7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to
    the whitelist"), Andrew Maier added Skylake-E 2031, 2032, and 2033 Root
    Ports to the pci_p2pdma_whitelist[], so we assume P2PDMA between devices
    below these ports works.
    
    Previously we only checked the whitelist for a device at devfn 00.0 on the
    root bus, which is often a "host bridge".  But these Skylake Root Ports may
    be at any devfn and there may be no "host bridge" device.
    
    Generalize pci_host_bridge_dev() so we check the first device on the root
    bus, whether it is devfn 00.0 or a PCIe Root Port, against the whitelist.
    
    [bhelgaas: commit log, comment]
    Link: https://lore.kernel.org/r/20220410105213.690-2-shlomop@pliops.com
    Tested-by: Maor Gottlieb <maorg@nvidia.com>
    Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Andrew Maier <andrew.maier@eideticom.com>

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d2f..462b429ad243 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -326,15 +326,16 @@ static const struct pci_p2pdma_whitelist_entry {
 };
 
 /*
- * This lookup function tries to find the PCI device corresponding to a given
- * host bridge.
+ * If the first device on host's root bus is either devfn 00.0 or a PCIe
+ * Root Port, return it.  Otherwise return NULL.
  *
- * It assumes the host bridge device is the first PCI device in the
- * bus->devices list and that the devfn is 00.0. These assumptions should hold
- * for all the devices in the whitelist above.
+ * We often use a devfn 00.0 "host bridge" in the pci_p2pdma_whitelist[]
+ * (though there is no PCI/PCIe requirement for such a device).  On some
+ * platforms, e.g., Intel Skylake, there is no such host bridge device, and
+ * pci_p2pdma_whitelist[] may contain a Root Port at any devfn.
  *
- * This function is equivalent to pci_get_slot(host->bus, 0), however it does
- * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
+ * This function is similar to pci_get_slot(host->bus, 0), but it does
+ * not take the pci_bus_sem lock since __host_bridge_whitelist() must not
  * sleep.
  *
  * For this to be safe, the caller should hold a reference to a device on the
@@ -350,10 +351,14 @@ static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
 
 	if (!root)
 		return NULL;
-	if (root->devfn != PCI_DEVFN(0, 0))
-		return NULL;
 
-	return root;
+	if (root->devfn == PCI_DEVFN(0, 0))
+		return root;
+
+	if (pci_pcie_type(root) == PCI_EXP_TYPE_ROOT_PORT)
+		return root;
+
+	return NULL;
 }
 
 static bool __host_bridge_whitelist(struct pci_host_bridge *host,
