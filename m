Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70EC5ED806
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiI1Iju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 04:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiI1IjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 04:39:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264DA1D6E
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 01:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E65EB81FB2
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 08:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CFAC433D6;
        Wed, 28 Sep 2022 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664354360;
        bh=s/YcRSwr9zctteq1dmxPcXH2bnKWNhBdbSVODYGwNz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDlhN+wOGpLcYy2dzLZG3vJxpBMJqwmMmjxrkov2S4tdBv8u7Z25Q4Z0opf6P5a7q
         TkWRAzR0qGhovGIc8EwxPQwJxjsNGaWXX8a6f7AxWTl+xMTKFExqjqmSzAtKhZVXpp
         UjOXHuRRIT1t1plhO0WxKQJlY4iK1MK8FdQJ+Fr5UY9vgAGI7YhDifGHiV5MSRlMlk
         J892stCpd8yY6wVyfdAs3vRPy8jBVLZoB+xUeTTOGU6H1ZipSJsSmh/efyd0lVgaE7
         EGqsFnEKeHq8te5jM+MxVVocDoFDevcqmuK4O6ggwQU8SDgHNx/riE3NxyfTByLlD/
         DP/WgrJb5NvYA==
Date:   Wed, 28 Sep 2022 10:39:14 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/11] PCI: pciehp: Enable Command Completed Interrupt
 only if supported
Message-ID: <YzQIMpWm9GLR8YYi@lpieralisi>
References: <20220818135140.5996-1-kabel@kernel.org>
 <20220818135140.5996-3-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818135140.5996-3-kabel@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 03:51:31PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> The No Command Completed Support bit in the Slot Capabilities register
> indicates whether Command Completed Interrupt Enable is unsupported.
> 
> We already check whether No Command Completed Support bit is set in
> pcie_wait_cmd(), and do not wait in this case.
> 
> Let's not enable this Command Completed Interrupt at all if NCCS is set,
> so that when users dump configuration space from userspace, the dump
> does not confuse them by saying that Command Completed Interrupt is not
> supported, but it is enabled.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
> Changes since batch 5:
> - changed commit message, previously we wrote that the change is needed
>   to fix a bug where kernel was waiting for an event which did not
>   come. This turns out to be false. See
>   https://lore.kernel.org/linux-pci/20220818142243.4c046c59@dellmb/T/#u
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Hi Bjorn,

this patch is mixed with aardvark specific changes,
please let me know if it is fine for you to merge it.

Thanks,
Lorenzo

> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 373bb396fe22..838eb6cc3ec7 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -817,7 +817,9 @@ static void pcie_enable_notification(struct controller *ctrl)
>  	else
>  		cmd |= PCI_EXP_SLTCTL_PDCE;
>  	if (!pciehp_poll_mode)
> -		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
> +		cmd |= PCI_EXP_SLTCTL_HPIE;
> +	if (!pciehp_poll_mode && !NO_CMD_CMPL(ctrl))
> +		cmd |= PCI_EXP_SLTCTL_CCIE;
>  
>  	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
>  		PCI_EXP_SLTCTL_PFDE |
> -- 
> 2.35.1
> 
