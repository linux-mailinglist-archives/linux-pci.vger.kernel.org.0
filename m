Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6FB22E627
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgG0G6X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 27 Jul 2020 02:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0G6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 02:58:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA2C0619D2
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2020 23:58:22 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jzx5W-0006HG-KR; Mon, 27 Jul 2020 08:58:18 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jzx5U-0004Sa-7O; Mon, 27 Jul 2020 08:58:16 +0200
Message-ID: <00892cf87c3da679d76c4632109ebcf21059d556.camel@pengutronix.de>
Subject: Re: [PATCH v9 02/12] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Jul 2020 08:58:16 +0200
In-Reply-To: <20200724203407.16972-3-james.quinlan@broadcom.com>
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
         <20200724203407.16972-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

On Fri, 2020-07-24 at 16:33 -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> A reset controller "rescal" is shared between the AHCI driver and the PCIe
> driver for the BrcmSTB 7216 chip.  Use
> devm_reset_control_get_optional_shared() to handle this sharing.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> 
> Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
> ---
>  drivers/ata/ahci_brcm.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 6853dbb4131d..d6115bc04b09 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -428,7 +428,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *of_id;
>  	struct device *dev = &pdev->dev;
> -	const char *reset_name = NULL;
>  	struct brcm_ahci_priv *priv;
>  	struct ahci_host_priv *hpriv;
>  	struct resource *res;
> @@ -452,11 +451,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  
>  	/* Reset is optional depending on platform and named differently */
>  	if (priv->version == BRCM_SATA_BCM7216)
> -		reset_name = "rescal";
> +		priv->rcdev = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
>  	else
> -		reset_name = "ahci";
> +		priv->rcdev = devm_reset_control_get_optional(&pdev->dev, "ahci");

Please use devm_reset_control_get_optional_exclusive() here.

>  
> -	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
>  	if (IS_ERR(priv->rcdev))
>  		return PTR_ERR(priv->rcdev);
>  
> @@ -479,10 +477,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> -	if (priv->version == BRCM_SATA_BCM7216)
> -		ret = reset_control_reset(priv->rcdev);
> -	else
> -		ret = reset_control_deassert(priv->rcdev);
> +	ret = reset_control_deassert(priv->rcdev);
>  	if (ret)
>  		return ret;
>  

Since you switch from _reset to _deassert/_assert here, I suspect you
should also change the out_reset error path, and the suspend/resume
functions accordingly.

regards
Philipp
