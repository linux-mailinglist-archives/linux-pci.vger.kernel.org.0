Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FAE5ABAB3
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 00:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIBWNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiIBWNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 18:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD36CF54BB;
        Fri,  2 Sep 2022 15:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67DB861E11;
        Fri,  2 Sep 2022 22:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96031C433D6;
        Fri,  2 Sep 2022 22:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662156821;
        bh=AvGreharmcJ+vogcHFdK+UJeGQXyBTbk5vH6FPFTCcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bNQY3+0sUZ6jnVPVe10HsxFTQXmRDJbWjSpR7paBbqrKe75zYIopT2iqDXxh3dKVM
         ebltIMrTkO9DNqAyyoy33lDSusEclzJ2lr9WAb5sUDdLQIojMe0bDAQ/urlKUih4aU
         mPbpm5WLw9FnWjetKvVMThN+LHHy8i64UlzTQiOwrfaxKNU+xq8MGBh6R3LonpTFza
         fIRQIaH64mcp7+3KA+2+kIXmRDAo0XEiXP1DzcGA/9uFXnTZ/QOuo6yHR3BuiVCH4f
         AkqZKk+3BX9vXCfbbmdJxjWshUJFPgZtOpQk/pdepxPiCt/iVvAaWSq/UmaI67moUL
         uShulioYN/cFQ==
Date:   Fri, 2 Sep 2022 17:13:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/PM: Switch D3Hot delay to also use usleep_range
Message-ID: <20220902221340.GA379310@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817230821.47048-1-willmcvicker@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 17, 2022 at 11:08:21PM +0000, Will McVicker wrote:
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

Add the "PCIe r6.0, sec 5.9" spec reference for the 10ms delay for
transitions to or from D3hot.

s/D3Hot/D3hot/ to match other usage (at least in Linux; the spec does
use "D3Hot")

s/uslseep_range/usleep_range/

Add "()" after function names.

In the subject, "Switch ... to *also* use usleep_range": what does the
"also" mean?  It sounds like it's referring to some other place where
we also use usleep_range()?

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

I hate the fact that we have to check for those ancient Intel chips at
all, but having to read through the usleep_range() vs msleep() thing
is just painful.  

fsleep() would be much simpler, but I am sympathetic that the fsleep()
range of 10-20ms probably wouldn't get the benefit you want.

I wish Documentation/timers/timers-howto.rst included a reason why we
should use msleep() instead of usleep_range() for longer sleeps.  Is
there a reason not to do this:

   static void pci_dev_d3_sleep(struct pci_dev *dev)
   {
        unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
        unsigned int upper;

        if (delay_ms) {
                /* 20% upper bound, 1ms minimum */
                upper = max(DIV_ROUND_CLOSEST(delay_ms, 5), 1U)
                usleep_range(delay_ms * USEC_PER_MSEC,
                             (delay_ms + upper) * USEC_PER_MSEC);
        }
   }

Since the Intel quirk is for 120ms, a 20% upper bound would make the
range 120-144ms.  Would that be a problem?  Those chips are ancient;
the list is untouched since it was added in 2006.  The point of
usleep_range() is to allow the scheduler to coalesce the wakeup with
other events, so it seems unlikely we'd ever wait the whole 144ms.  I
vote for optimizing the readability over sleep/resume time for
already-broken chips.

Bjorn
