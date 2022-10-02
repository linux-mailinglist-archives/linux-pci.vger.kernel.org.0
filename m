Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B945F246A
	for <lists+linux-pci@lfdr.de>; Sun,  2 Oct 2022 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJBR4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Oct 2022 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJBR4w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Oct 2022 13:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344093A169;
        Sun,  2 Oct 2022 10:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C485C60EE8;
        Sun,  2 Oct 2022 17:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1281FC433C1;
        Sun,  2 Oct 2022 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664733411;
        bh=qUgOK3t18tYW2UK/R1jl3lLWy7URggvB3fJyitiBEBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueqFlTo67MAaDKe+MZdg+MlYcg61prs06BSY3rtIb2kEQuBpAoPdJfV8iH5DaWtaK
         nx2zwUiuYAsFgOg+EcM9i0+Ap1wcixy1k+n2Md6vnXHIaerCvTQWzD+ke+dhfwvEGl
         uvgxXEfsPxm/oOjHqSrwqnjlXpd7NWdaRxW3a83DrUJccihA7tF6MuJsJ7Me05cyay
         NYj9GYQzReVfyBl+GoLXNCBSLdcNyQOGht2NcR2UNJ4I8EpKxGfLNpqcMbAKCNtjc3
         MXsO9FXLqd/1ki6mfVhRWGOtkNRtszkqCL+NvVglx20djL2YAoQs2KAwHq/T7zalji
         X6bdW4QY/vZ1w==
Received: by pali.im (Postfix)
        id 3F3AA225; Sun,  2 Oct 2022 19:56:48 +0200 (CEST)
Date:   Sun, 2 Oct 2022 19:56:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Wait for data link active after retraining
Message-ID: <20221002175648.jzxcvka46vylbs2d@pali>
References: <20220602065544.2552771-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602065544.2552771-1-nathan@nathanrossi.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Thursday 02 June 2022 06:55:44 Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> When retraining the link either the child or the parent device may have
> the data link layer state machine of the respective devices move out of
> the active state despite the physical link training being completed.
> Depending on how long is takes for the devices to return to the active
> state, the device may not be ready and any further reads/writes to the
> device can fail.
> 
> This issue is present with the pci-mvebu controller paired with a device
> supporting ASPM but without advertising the Slot Clock, where during
> boot the pcie_aspm_cap_init call would cause common clocks to be made
> consistent and then retrain the link. However the data link layer would
> not be active before any device initialization (e.g. ASPM capability
> queries, BAR configuration) causing improper configuration of the device
> without error.

There is the known issue in marvell pcie controllers. They completely
drop the link for PCIe GEN1 cards when Target Link Speed (Link Control2)
in Root Port is configured to 5.0 GT/s or higher value and OS issues
Retrain Link (Link Control).

I think the proper way should be to workaround root of this issue by
programming Target Link Speed in Link Control2 register to required
value, instead of hacking couple of other places which are just
implication of that issue...

I can reproduce it for example with Qualcomm Atheros ath9k/ath10k wifi
cards which have another issue that they go into "broken" state when
in-band reset (e.g. pcie hot reset or pcie link down) is issues multiple
times without longer delay.

These two bugs (first in marvell pcie controller and second in wifi
card) cause that setting kernel ASPM cause disappearing card from bus
until cpu/board reset (or pcie warm reset; if board supports it at
runtime without going to POR).

I guess you are just observing result of this issue here.

> To ensure the child device is accessible, after the link retraining use
> pcie_wait_for_link to perform the associated state checks and any needed
> delays.
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---
>  drivers/pci/pcie/aspm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9..4b8a1810be 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -288,7 +288,8 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  		reg16 &= ~PCI_EXP_LNKCTL_CCC;
>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>  
> -	if (pcie_retrain_link(link))
> +	/* Retrain link and then wait for the link to become active */
> +	if (pcie_retrain_link(link) && pcie_wait_for_link(parent, true))
>  		return;
>  
>  	/* Training failed. Restore common clock configurations */
> ---
> 2.36.1
