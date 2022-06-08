Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428E5543D64
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 22:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiFHULj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiFHULi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 16:11:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EDA12AF6
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 13:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62C7561CC2
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 20:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5128EC34116;
        Wed,  8 Jun 2022 20:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654719096;
        bh=8k4Ru3Gy+AFvhMwirgmAMtpZOoo6pJniIfpDb3kJRPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DAy4R+MJ0Y+hlxmsGMa5Ux3JBpY6hkerKaxsCZV9sSxlCMFbPS+sKQjmoLU5jopkK
         pXERrkV50Nvjo8yDk8Kt+SYyzRXUPtCPuIwvu0z1oIWkIwD+5X/xWtFMQhuodWi7QF
         iz0B+zrXCFWlDfypWQznJyfGu6qottYir6tHFycALC7cCiE6krAyn3jJeRdxu8Utdf
         R4Q6F6Y4r3CGVVAUQT2i7n26posKRQk9RDn/REa3jtszJBuEPtpet2emxXKv8Zlg2f
         DH3Q1UB9BCbaZV5Xcy4KraNzWb7tkf3Og/nh+gEjaFHwWN/ysWBLCfxaF7lg9agESL
         WGVzaV1BHMNkw==
Date:   Wed, 8 Jun 2022 15:11:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com,
        kbusch@kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/ERR: handle disconnected devices in
 report_error_detected
Message-ID: <20220608201134.GA417165@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601074024.3481035-1-hch@lst.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 01, 2022 at 09:40:24AM +0200, Christoph Hellwig wrote:
> When a device is already unplugged by pciehp by the time that the AER
> handler is invoked, the PCIe device will lready be in the
> pci_channel_io_perm_failure state.  In that case we should simply
> return PCI_ERS_RESULT_DISCONNECT instead of trying to do a state
> transition that will fail.
> 
> Also untangle the state transition failure from the lack of methods to
> improve the debugging output in case it will happen ever again.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied with Sathy's reviewed-by to pci/err for v5.20, thanks!

> ---
>  drivers/pci/pcie/err.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 0c5a143025af4..59c90d04a609a 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -55,10 +55,14 @@ static int report_error_detected(struct pci_dev *dev,
>  
>  	device_lock(&dev->dev);
>  	pdrv = dev->driver;
> -	if (!pci_dev_set_io_state(dev, state) ||
> -		!pdrv ||
> -		!pdrv->err_handler ||
> -		!pdrv->err_handler->error_detected) {
> +	if (pci_dev_is_disconnected(dev)) {
> +		vote = PCI_ERS_RESULT_DISCONNECT;
> +	} else if (!pci_dev_set_io_state(dev, state)) {
> +		pci_info(dev, "can't recover (state transition %u -> %u invalid)\n",
> +			dev->error_state, state);
> +		vote = PCI_ERS_RESULT_NONE;
> +	} else if (!pdrv || !pdrv->err_handler ||
> +		   !pdrv->err_handler->error_detected) {
>  		/*
>  		 * If any device in the subtree does not have an error_detected
>  		 * callback, PCI_ERS_RESULT_NO_AER_DRIVER prevents subsequent
> -- 
> 2.30.2
> 
