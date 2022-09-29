Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC55EFDFD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 21:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiI2Teu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiI2Tes (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 15:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9697127B13;
        Thu, 29 Sep 2022 12:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B7E562137;
        Thu, 29 Sep 2022 19:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F64AC433C1;
        Thu, 29 Sep 2022 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664480083;
        bh=ftFtLtOspwgqgTbXDSLqy6SZVZ1aeu7XTbZXv9O9dLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MPsao7USOSJZOcWuvkBjbP+iLkkxCvLjpAtNSa//G7ewHh9HGu1wlHMb3Ik2AklsV
         ERyQHpIACMnLGbvDLyxvYSqVhtbJKAVYZioMT5mmNVdpWht4wpi67jD3aeyZAE0SfN
         /59hif1HupHFwlXyrtaUooHUcmmY41OZwQ5QHNTnxMlD1OMVoVpDeAMl+vRYJ+9nLm
         fsw/DlGn80iTppE/Atsf/wSYbutbitAbonKrLgJMmcApO/4iNDcK9e/KcU2+fb71Sf
         kGZ3OzPoTTbuOp063hC4xYktTIxNfk3/i82UibD0kJQkmIr/GonYdEqkzd/I53WK/8
         JFFf/fzQiZBqA==
Date:   Thu, 29 Sep 2022 14:34:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/PM: Switch D3hot delay to use usleep_range()
Message-ID: <20220929193441.GA1918838@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921212735.2131588-1-willmcvicker@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 21, 2022 at 09:27:35PM +0000, Will McVicker wrote:
> From: Sajid Dalvi <sdalvi@google.com>
> 
> The PCIe r6.0, sec 5.9 spec requires a 10ms D3hot delay (defined by
> PCI_PM_D3HOT_WAIT) for transitions to or from D3hot. So let's switch to
> usleep_range() for the delay time to improve the delay accuracy.
> 
> This patch is based off of a commit from Sajid Dalvi <sdalvi@google.com>
> in the Pixel 6 kernel tree [1]. Testing on a Pixel 6, found that the
> 10ms delay for the Exynos PCIe device was on average delaying for 19ms
> when the spec requires 10ms. Switching from msleep() to usleep_range()
> therefore decreases the resume time on a Pixel 6 on average by 9ms.
> 
> Note: some ancient Intel chips do have a quirk that sets the delay to
> 120ms. Using usleep_delay() may add a few extra milliseconds for those
> chips.
> 
> [1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3
> 
> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Applied to pci/pm for v6.1, thanks, Will!

> ---
>  drivers/pci/pci.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> v4:
>  * Drop use of msleep() in favor of always using usleep_range().
>  * Update the commit message.
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
> index 516bf0c2ca02..2127aba3550b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -66,13 +66,15 @@ struct pci_pme_device {
>  
>  static void pci_dev_d3_sleep(struct pci_dev *dev)
>  {
> -	unsigned int delay = dev->d3hot_delay;
> -
> -	if (delay < pci_pm_d3hot_delay)
> -		delay = pci_pm_d3hot_delay;
> -
> -	if (delay)
> -		msleep(delay);
> +	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
> +	unsigned int upper;
> +
> +	if (delay_ms) {
> +		/* Use a 20% upper bound, 1ms minimum */
> +		upper = max(DIV_ROUND_CLOSEST(delay_ms, 5), 1U);
> +		usleep_range(delay_ms * USEC_PER_MSEC,
> +			     (delay_ms + upper) * USEC_PER_MSEC);
> +	}
>  }
>  
>  bool pci_reset_supported(struct pci_dev *dev)
> 
> base-commit: fcf773ae8016c6bffe5d408d3eda50d981b946e6
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 
