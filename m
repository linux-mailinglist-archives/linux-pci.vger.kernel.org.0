Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8145A53C4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 20:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiH2SI5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 14:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiH2SIy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 14:08:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E13D97EF8
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2022 11:08:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c2so8781376plo.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2022 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=1CjHaWXJyBHtPBi2K/FlVmBWu0GfOoz/im+WiYsLat0=;
        b=rpiEl9LnKwpk4GzBzAdq6LK9zK4MnFYsWT11M+cVYWqPCxdG5YQr2OviS8EqENg0Tt
         FlpjDkR1KPn+YEFYg4bQ3FcQ9+7BKkKqaV+hiRbooAmHvR6GqQ0cNZvWpaImjnew5Rc1
         fPMZOoOY20EAn2A+kEasaSBp+y340h0xFcW96hkzzL7esuxWGAvyZ2z4n0aOkBPvlTX9
         dLrrXfnB0Dfu8xOmv+9wuPQfEH5JJTChZY+jjbRDWqLawz65hV+vQJbGwr4HTShDDBKw
         3HZL1ZzwrHJj1jK/Fd/zgYJ8nkFDtWWZ9vZG3Wv9wb9DAp/Hwuqlri2Jc32Mj7Ctzgnh
         9pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1CjHaWXJyBHtPBi2K/FlVmBWu0GfOoz/im+WiYsLat0=;
        b=PUEHHKnCKlJ34RXcO/NVMyft9OsuUqNEq9f6C2bwNT8NIZpifJ8bs9/zHVSy9Iyb6C
         AE5ugVDngAo8lnvW83ISAFIKLf0BLZqkic2QWCorbGZ+rCuE7WXLI3ifPHQCYVujo1xq
         1GEoqCA7ixEVOfNR9xHlofOstEAeF7E9YiTJniLUOXj8GY1RStNUtWEZ0vINgSgJ33Qr
         5zoZt7MdQdp/PzI/PYU6fvscD8xRidZ90L2yKYWpkFBjhEh758ekOyFGSel9jf9UKous
         dfyJ8M5vx8603uBJAq9V/9RSwEfy8dZe4psMPSAtY3GId4Zfy9YQIy65jjlLAHMn/NIw
         dQAg==
X-Gm-Message-State: ACgBeo2Zhk7bKinYijOs6EfEMOd8ep1BraioMUz4oickUY9rw2bWA8qd
        g2v6YKlu7O5NSmZMsqJ8AnIS2e6RfM40/A==
X-Google-Smtp-Source: AA6agR736M5UZ+SEgVaavf+RxSstqF52isXKQJF2xEVMgKxGmu5LmJ4I/LbCGLii/UXmgY/mDMGWbQ==
X-Received: by 2002:a17:902:da84:b0:173:195:5401 with SMTP id j4-20020a170902da8400b0017301955401mr17518320plx.28.1661796531789;
        Mon, 29 Aug 2022 11:08:51 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b00536f0370db8sm7172457pfv.212.2022.08.29.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 11:08:51 -0700 (PDT)
Date:   Mon, 29 Aug 2022 18:08:47 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel-team@android.com, Sajid Dalvi <sdalvi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/PM: Switch D3Hot delay to also use usleep_range
Message-ID: <Yw0Ar1DplE2h07gB@google.com>
References: <20220817230821.47048-1-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817230821.47048-1-willmcvicker@google.com>
X-Spam-Status: No, score=-12.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/17/2022, Will McVicker wrote:
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
>  drivers/pci/pci.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> v3:
>  * Use DIV_ROUND_CLOSEST instead of bit manipulation.
>  * Minor refactor to use max() where relavant.
> 
> v2:
>  * Update to use 20-25% upper bound
>  * Update to use usleep_range() for <=20ms, else use msleep()
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..cfa8386314f2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -66,13 +66,19 @@ struct pci_pme_device {
>  
>  static void pci_dev_d3_sleep(struct pci_dev *dev)
>  {
> -	unsigned int delay = dev->d3hot_delay;
> +	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
>  
> -	if (delay < pci_pm_d3hot_delay)
> -		delay = pci_pm_d3hot_delay;
> +	if (delay_ms) {
> +		if (delay_ms <= 20) {
> +			/* Use a 20% upper bound with 1ms minimum */
> +			unsigned int upper = max(DIV_ROUND_CLOSEST(delay_ms, 5), 1U);
>  
> -	if (delay)
> -		msleep(delay);
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

Hi Bjorn,

I'm just checking up on this patch in case it got lost in your inbox. Please
take a look and let me know if you have any concerns.

And thanks again for the reviews Matthias!

Regards,
Will
