Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9733359642D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 23:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiHPVGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 17:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiHPVGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 17:06:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A388E792E4
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 14:06:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l64so10336955pge.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FvyL+59WCpfNsrurG6++W2/1BYsgLxwMZ6wbjep7BrM=;
        b=QrpK7X4SHoABxiBpWMFWRBiA/WPxdgeDc6Bv6lZfqopoGT/sCElt/sxqYtzAyaeV0L
         mot3Sp83Ry2w9+pnriu8I1dBsqEIRGLR3pOibmqUohJIv8tpkUHiCC3sV60WiqV83TiP
         2qKZvbT89e8WFxxRSU23GYgbI0FfLoZQH+kIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FvyL+59WCpfNsrurG6++W2/1BYsgLxwMZ6wbjep7BrM=;
        b=UjuVGBtG80vUz3wMlzfKjp8RpaFFUQejf7TpM2+xrQggYgd6fijaG0dDjXrF59Awoq
         9cma91h97pxlewwPTG+BGzbJyz7uVW+37euT6XoSYxhtOZxCG0eWeovkn2Nw2OgG7xFR
         Po7IACAqF0Kv1JTjh6O+ZTuXTGoVGrmzJymQpOEz5kR2lMDNZIJRVIMK1oRq9eex/q0Q
         RuIAI3xzD6ji2EP2LsOc//L5TyNvJJP0XoMYZGRqArCUDk6OwiDy4S8qrczaQJGtoXy1
         PokC+3GxU2//txMQ/r8jeIVno9iFr6sL5v0f1PIq9bh2+XNvMQWcYrhvL7mc41TOBIZq
         2bqA==
X-Gm-Message-State: ACgBeo0168x9Em9DLDbEt+pi/YVLn7Nedpz4B8zl6U6g9/QzxFAX76Zk
        ZxZdbqPscUAqd1ORi2urPxiU2w==
X-Google-Smtp-Source: AA6agR5jYJ4rp+amr2cPrhuz4DcsYmRIg31uZSonLVsilym4MgTnYTBnyZrACsr9azofUdd47iKkzg==
X-Received: by 2002:a63:1459:0:b0:411:b06f:646f with SMTP id 25-20020a631459000000b00411b06f646fmr19443495pgu.338.1660683969151;
        Tue, 16 Aug 2022 14:06:09 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:f730:6f91:6154:bee4])
        by smtp.gmail.com with UTF8SMTPSA id s23-20020a170902a51700b0016bf4428586sm9451077plq.208.2022.08.16.14.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 14:06:08 -0700 (PDT)
Date:   Tue, 16 Aug 2022 14:06:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI/PM: Switch D3Hot delay to use usleep_range
Message-ID: <YvwGvmWPrIQ557C+@google.com>
References: <20220811184001.2512121-1-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220811184001.2512121-1-willmcvicker@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 11, 2022 at 06:40:01PM +0000, Will McVicker wrote:
> From: Sajid Dalvi <sdalvi@google.com>
> 
> Since the PCI spec requires a 10ms D3Hot delay (defined by
> PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
> to 20ms, let's switch from msleep to usleep_range to improve the delay
> accuracy.
> 
> This patch came from Sajid Dalvi <sdalvi@google.com> in the Pixel 6
> kernel tree [1]. Testing on a Pixel 6, found that the 10ms delay for
> the Exynos PCIe device was on average delaying for 19ms when the spec
> requires 10ms. Switching from msleep to uslseep_delay therefore
> decreases the resume time on a Pixel 6 on average by 9ms.
> 
> [1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3
> 
> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..5ae5b3c4dc9b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -72,7 +72,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>  		delay = pci_pm_d3hot_delay;
>  
>  	if (delay)
> -		msleep(delay);
> +		usleep_range(delay * USEC_PER_MSEC,
> +			     (delay + 2) * USEC_PER_MSEC);

You could also use fsleep(), which ends up calling usleep_range()
for (usecs > 10 && usecs <= 20000).
