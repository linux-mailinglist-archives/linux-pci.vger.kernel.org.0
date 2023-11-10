Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CAD7E83B1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 21:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKJUZl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 15:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKJUZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 15:25:41 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C4D64
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 12:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
        MIME-Version:Date:Message-ID:cc:content-disposition;
        bh=IZhdXZpRvXVjzUGUTMzNYJDrWB8Xh1Z4rSMeXjMeAP4=; b=qGqvLpuPBP5m30kp7plypo2tnJ
        EBkG2JcHmCopxqiVE474VYJddel+kad9lIA6XdeLKIkDRrRgpuOhOwlXYgkDsbamDaszF6jR7fGzV
        POA+ayMo1Ihg/P3UekbT6r9QT06MhjFrSI00CSUMH5iF2dty/JqWhjgOdrrMnjqjPYOlKVw1pO7ST
        n0moEfK3U20Fbd6pmsC+wBjulN4wY0GISLVoXrzIV6l+pw+jlJgw32Ls7GvnyFyVaIE4/AkL1r1zz
        doJlXW+D1VhuGVG2MCbIXHYitYeQfa070rxjduAd4Nncees6eRpMoxiUs2tM3Fqs1tm/bwpSGyK/t
        +lHrHNZw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1r1Y4L-002EXU-4I; Fri, 10 Nov 2023 13:25:33 -0700
Message-ID: <dc15dc87-d199-4295-96b4-b972f4965bd5@deltatee.com>
Date:   Fri, 10 Nov 2023 13:25:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To:     Daniel Stodden <dns@arista.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        linux-pci@vger.kernel.org
References: <20231110201917.89016-1-dns@arista.com>
 <20231110201917.89016-2-dns@arista.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20231110201917.89016-2-dns@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dns@arista.com, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 1/1] switchtec: Fix stdev_release crash after suprise
 device loss.
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-11-10 13:19, Daniel Stodden wrote:
> A pci device hot removal may occur while stdev->cdev is held open. The
> call to stdev_release is then delivered during close or exit, at a
> point way past switchtec_pci_remove. Otherwise the last ref would
> vanish with the trailing put_device, just before return.
> 
> At that later point in time, the device layer has alreay removed
> stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
> counted one. Therefore, in dma mode, the iowrite32 in stdev_release
> will cause a fatal page fault, and the subsequent dma_free_coherent,
> if reached, would pass a stale &stdev->pdev->dev pointer.
> 
> Fixed by moving mrpc dma shutdown into switchtec_pci_remove, after
> stdev_kill. Counting the stdev->pdev ref is now optional, but may
> prevent future accidents.
> 
> Signed-off-by: Daniel Stodden <dns@arista.com>

Nice catch, thanks!

The solution looks good to me, though I might quibble slightly about
style: I'm not sure why we need two helper functions (disable_dma_mrpc()
and switchtec_exit_pci()) that are only called in one place. I'd
probably just open code both of them.

Other than that:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan

> ---
>  drivers/pci/switch/switchtec.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index e69cac84b605..002d0205d263 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1247,17 +1247,17 @@ static void enable_dma_mrpc(struct switchtec_dev *stdev)
>  	iowrite32(SWITCHTEC_DMA_MRPC_EN, &stdev->mmio_mrpc->dma_en);
>  }
>  
> +static void disable_dma_mrpc(struct switchtec_dev *stdev)
> +{
> +	iowrite32(0, &stdev->mmio_mrpc->dma_en);
> +	flush_wc_buf(stdev);
> +	writeq(0, &stdev->mmio_mrpc->dma_addr);
> +}
> +
>  static void stdev_release(struct device *dev)
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
> @@ -1301,7 +1301,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>  		return ERR_PTR(-ENOMEM);
>  
>  	stdev->alive = true;
> -	stdev->pdev = pdev;
> +	stdev->pdev = pci_dev_get(pdev);
>  	INIT_LIST_HEAD(&stdev->mrpc_queue);
>  	mutex_init(&stdev->mrpc_mutex);
>  	stdev->mrpc_busy = 0;
> @@ -1587,6 +1587,16 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
>  	return 0;
>  }
>  
> +static void switchtec_exit_pci(struct switchtec_dev *stdev)
> +{
> +	if (stdev->dma_mrpc) {
> +		disable_dma_mrpc(stdev);
> +		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
> +				  stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
> +		stdev->dma_mrpc = NULL;
> +	}
> +}
> +
>  static int switchtec_pci_probe(struct pci_dev *pdev,
>  			       const struct pci_device_id *id)
>  {
> @@ -1646,6 +1656,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
>  	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>  	dev_info(&stdev->dev, "unregistered.\n");
>  	stdev_kill(stdev);
> +	switchtec_exit_pci(stdev);
> +	pci_dev_put(stdev->pdev);
> +	stdev->pdev = NULL;
>  	put_device(&stdev->dev);
>  }
>  
