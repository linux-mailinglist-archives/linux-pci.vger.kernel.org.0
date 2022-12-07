Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837E5645CA1
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 15:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLGO3r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 09:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLGO3l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 09:29:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0C856EC0
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 06:29:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCD25B81E66
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 14:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD7C433C1;
        Wed,  7 Dec 2022 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670423377;
        bh=6AueI/R7NkY5/yznLeaPmx1C6XPv/QQTTXkT55QnZhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gxquZ4G5MCdgIzZBBwRm1O3iITEHwuoqcju1+xmdA9s9FaF2e2TYyn6TGKKMvumST
         Zfn6hThPkWYG1yJbYFGzA/JkHTcjB/iw8A9JDA5/u8bD4jX/bOf7nxig/iWiBMVN6N
         4EYQTu9q6crkhxnGEpmopQB8m8RsQ3yF/yA9JrN0li/zz3V+HtolbP/qlwvdt7JRdH
         PiUm1CXfgKvM779F+XWpxaN9f3DWVvIw1fWNQksfzE5NJ6h1eMaqRNGYs/MoelwHy5
         yt+cx1rkKC4K/rbPRkZJehPO3cAxUeKJxalaEC6v1qyw1b5KdaU9HjfkeT0hLPFs+7
         Cahb1FOKE8IYA==
Date:   Wed, 7 Dec 2022 08:29:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>, pali@kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 01/10] PCI: pciehp: Enable Command Completed Interrupt
 only if supported
Message-ID: <20221207142935.GA1440263@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927141926.8895-2-kabel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 04:19:17PM +0200, Marek Behún wrote:
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
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Since this isn't directly related to aardvark or the rest of the
series, I applied this to pci/hotplug for v6.2, thanks!

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 040ae076ec0e..10e9670eea0b 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -811,7 +811,9 @@ static void pcie_enable_notification(struct controller *ctrl)
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
