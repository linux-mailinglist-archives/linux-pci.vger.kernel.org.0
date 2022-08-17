Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9D597676
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 21:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiHQT2N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 15:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiHQT2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 15:28:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B732DCD
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 12:28:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m2so12829576pls.4
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=umb965eWziPmmyD95lXKb60+lJ80uHNRMc3mpL9TRI0=;
        b=jKmpKArYJ+nvOMrJfs5HHMevZ+pZK8rqvSw1ltcp8a/5tZyHrbQe9+KdVRN6t1F/da
         XPPCaYB2WI7VAPf/53TihtloROd0KOeA8WtufQrjGJfwCX8nTNINFEcfdgs7WxF2lHDo
         Ax6yB5iMZmJ/628gReyPJ7q87vN2BkKnWpalI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=umb965eWziPmmyD95lXKb60+lJ80uHNRMc3mpL9TRI0=;
        b=DZFHfZ0f9fp4wJ2v7XnBeVLCrPMH0f66C8qb8SC9uai0g5HQdl6vB1Fsm7oot9JHcx
         LxTzjg8olztaOpDBu88ItqTjBbUd9a4MPkfbuKUgBtdIGsksur/LZcyiEePeDU+ziHc2
         0tk9emP9TEa8cq1EKf5LDNRJRBQl6WVH7pIZGRQd5V5i6NTxuPfDrCvRH1Ho5msTWy4O
         OCqi3aDx4pOLEXhLoDaRsA/gYt9+vq0HjCkuko+RoupG5At2B3baKLbgG29OwpKNRSrk
         B9q/sI42aXAzah+XqpWAWxlzKH2Xl5zde7ysjltTebdocp8LSmUQ+Eg2UPyuzB6CfEE4
         NWyQ==
X-Gm-Message-State: ACgBeo3HcSI+nNitXJk2tR0dLL8BI4vJxmwIGrZgfTtacGYb2c2JUFAd
        V5aiJvGEKMt2HFzty0fwbDrMZA==
X-Google-Smtp-Source: AA6agR5c06tNLRcOvix3lX25Pf+qxcyBsG1XTPzrP34qGcVPDg6kVbP6puqX3xCx4v0Qh2bIdYmIdA==
X-Received: by 2002:a17:902:e848:b0:16f:8f:9027 with SMTP id t8-20020a170902e84800b0016f008f9027mr28032820plg.66.1660764491142;
        Wed, 17 Aug 2022 12:28:11 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:536d:1358:1673:4c2d])
        by smtp.gmail.com with UTF8SMTPSA id t6-20020a1709027fc600b0017294d80f11sm296838plb.91.2022.08.17.12.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 12:28:10 -0700 (PDT)
Date:   Wed, 17 Aug 2022 12:28:09 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/PM: Switch D3Hot delay to also use usleep_range
Message-ID: <Yv1BSfkd6WUh2SFp@google.com>
References: <20220817185202.1689955-1-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817185202.1689955-1-willmcvicker@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Will,

On Wed, Aug 17, 2022 at 06:52:02PM +0000, Will McVicker wrote:
> From: Sajid Dalvi <sdalvi@google.com>
> 
> Since the PCI spec requires a 10ms D3Hot delay (defined by
> PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
> to 120ms, let's add support for both usleep_range and msleep based on
> the delay time to improve the delay accuracy.
> 
> This patch is based off of a commit from Sajid Dalvi <sdalvi@google.com>
> in the Pixel 6 kernel tree [1]. Testing on a Pixel 6, found that the
> 10ms delay for the Exynos PCIe device was on average delaying for 19ms
> when the spec requires 10ms. Switching from msleep to uslseep_range
> therefore decreases the resume time on a Pixel 6 on average by 9ms.
> 
> [1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3
> 
> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/pci/pci.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..97a042ca9032 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -63,16 +63,26 @@ struct pci_pme_device {
>  };
>  
>  #define PME_TIMEOUT 1000 /* How long between PME checks */
> +#define MAX(a, b) ((a) >= (b) ? (a) : (b))

no need to define this macro, you can use max() from
include/linux/minmax.h instead.

>  
>  static void pci_dev_d3_sleep(struct pci_dev *dev)
>  {
> -	unsigned int delay = dev->d3hot_delay;
> +	unsigned int delay_ms = dev->d3hot_delay;
>  
> -	if (delay < pci_pm_d3hot_delay)
> -		delay = pci_pm_d3hot_delay;
> +	if (delay_ms < pci_pm_d3hot_delay)
> +		delay_ms = pci_pm_d3hot_delay;

nit: since you are already touching this code you could change it to:

	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);

>  
> -	if (delay)
> -		msleep(delay);
> +	if (delay_ms) {
> +		if (delay_ms <= 20) {
> +			/* Use a 20-25% upper bound with 1ms minimum */
> +			unsigned int upper = MAX((delay_ms >> 3) << 1, 1);

Not sure this optimization of using bit shifts instead of the clearer do_div()
is really needed here. pci_dev_d3_sleep() is not a super hot code path IIUC.

> +
> +			usleep_range(delay_ms * USEC_PER_MSEC,
> +				     (delay_ms + upper) * USEC_PER_MSEC);
> +		} else {
> +			msleep(delay_ms);
> +		}
> +	}
>  }
>  
>  bool pci_reset_supported(struct pci_dev *dev)
> 
> base-commit: 274a2eebf80c60246f9edd6ef8e9a095ad121264
> -- 
> 2.37.1.595.g718a3a8f04-goog
> 
