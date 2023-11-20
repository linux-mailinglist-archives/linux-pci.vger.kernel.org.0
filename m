Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364127F1F27
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 22:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjKTVZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 16:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjKTVZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 16:25:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EACCA
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 13:25:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F5BC433C8;
        Mon, 20 Nov 2023 21:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700515548;
        bh=d/b/xn8b0WJzWG5uN8sMb7gJ/CgzTs8o4/I7odB32BE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YhfMjI6j4tbFeUN+fOZxAgSHotR5eC1GF8bDmlHZQEFNhZoinnX0EvdF37pDLadH2
         /Gus31N9JtDwEUsU9pvwHzk7AAqrAI5cYgXtmMW8ayw3MbJELg/eNPPi0atpaEdCaB
         32xRNUYgYjuFZo6tiFGDYnyDFJtAd3mavsGfcQ1IMBkd7gjVHpsGaYlfsZYyvl+sMV
         lap5P8JDklWaYEowioaC7JOZ/mckKqhWukr2We1JqLnaEpgSrkQwxpH2TTU5OCWnyS
         U0yfsACQLkGOgD8LDZw+DBMa5ppbsO+nOcRIOvMKySMlvk8S3WRO1j48aT7S1P/vhV
         Gi4v52+zPu4pQ==
Date:   Mon, 20 Nov 2023 15:25:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Stodden <dns@arista.com>
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
Message-ID: <20231120212546.GA215889@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113212150.96410-2-dns@arista.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 13, 2023 at 01:21:50PM -0800, Daniel Stodden wrote:
> A pci device hot removal may occur while stdev->cdev is held open. The
> call to stdev_release is then delivered during close or exit, at a
> point way past switchtec_pci_remove. Otherwise the last ref would
> vanish with the trailing put_device, just before return.
> 
> At that later point in time, the device layer has alreay removed
> stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a

I guess this should say the "stdev->mmio_mrpc" (not "mrpc_mmio")?

> counted one. Therefore, in dma mode, the iowrite32 in stdev_release
> will cause a fatal page fault, and the subsequent dma_free_coherent,
> if reached, would pass a stale &stdev->pdev->dev pointer.
> 
> Fixed by moving mrpc dma shutdown into switchtec_pci_remove, after
> stdev_kill. Counting the stdev->pdev ref is now optional, but may
> prevent future accidents.
> 
> Signed-off-by: Daniel Stodden <dns@arista.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks, applied to "switchtec" for v6.8.

> ---
>  drivers/pci/switch/switchtec.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index e69cac84b605..d8718acdb85f 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1251,13 +1251,6 @@ static void stdev_release(struct device *dev)
>  {
>  	struct switchtec_dev *stdev = to_stdev(dev);
>  
> -	if (stdev->dma_mrpc) {
> -		iowrite32(0, &stdev->mmio_mrpc->dma_en);
> -		flush_wc_buf(stdev);
> -		writeq(0, &stdev->mmio_mrpc->dma_addr);
> -		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
> -				stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
> -	}
>  	kfree(stdev);
>  }
>  
> @@ -1301,7 +1294,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>  		return ERR_PTR(-ENOMEM);
>  
>  	stdev->alive = true;
> -	stdev->pdev = pdev;
> +	stdev->pdev = pci_dev_get(pdev);
>  	INIT_LIST_HEAD(&stdev->mrpc_queue);
>  	mutex_init(&stdev->mrpc_mutex);
>  	stdev->mrpc_busy = 0;
> @@ -1587,6 +1580,18 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
>  	return 0;
>  }
>  
> +static void switchtec_exit_pci(struct switchtec_dev *stdev)
> +{
> +	if (stdev->dma_mrpc) {
> +		iowrite32(0, &stdev->mmio_mrpc->dma_en);
> +		flush_wc_buf(stdev);
> +		writeq(0, &stdev->mmio_mrpc->dma_addr);
> +		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
> +				  stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
> +		stdev->dma_mrpc = NULL;
> +	}
> +}
> +
>  static int switchtec_pci_probe(struct pci_dev *pdev,
>  			       const struct pci_device_id *id)
>  {
> @@ -1646,6 +1651,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
>  	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>  	dev_info(&stdev->dev, "unregistered.\n");
>  	stdev_kill(stdev);
> +	switchtec_exit_pci(stdev);
> +	pci_dev_put(stdev->pdev);
> +	stdev->pdev = NULL;
>  	put_device(&stdev->dev);
>  }
>  
> -- 
> 2.41.0
> 
