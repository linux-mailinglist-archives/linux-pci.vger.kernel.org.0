Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4776143F6
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 05:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKAEpc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 00:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAEpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 00:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D2C1740C;
        Mon, 31 Oct 2022 21:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DBA360F72;
        Tue,  1 Nov 2022 04:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0281BC433C1;
        Tue,  1 Nov 2022 04:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667277929;
        bh=7Tgw9cmj0X/gJHgDspc1Fx8Gx0C3tPIo/87cHLCWo0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVoFYYNvXUbe5hm+tNZ6oB3cxE/1fBZskqLiojb4VhHAcb6JOYCsxxlwlx9Rl1X2d
         Ha+BUh1uEyf9loYaV6j9UOfzWs8uwrQOaJ+NFl+azuDcyijbhyhPRZATg17rCNe0kQ
         IiVKsAM/J8hp8dCmMOcDobeizx2TF3erI+zGhHDE=
Date:   Tue, 1 Nov 2022 05:46:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com, bhelgaas@google.com,
        loic.poulain@linaro.org, dnlplm@gmail.com, yonglin.tan@outlook.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add vendor ID for QUECTEL
Message-ID: <Y2Ckm79PgcTcVVne@kroah.com>
References: <20221101021052.7532-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101021052.7532-1-slark_xiao@163.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 10:10:52AM +0800, Slark Xiao wrote:
> n MHI driver, there are some companies' product still do not have their
> own PCI vendor macro. So we add it here to make the code neat. Ref ID
> could be found in link https://pcisig.com/membership/member-companies.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v3: Separate different vendors into different patch.
> 
> v2: Update vendor ID to the right location sorted by numeric value.
> ---
>  drivers/bus/mhi/host/pci_generic.c | 6 +++---
>  include/linux/pci_ids.h            | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index caa4ce28cf9e..81ae9c49ce2a 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -555,11 +555,11 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
> -	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> -	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> -	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x2001), /* EM120R-GL for FCCL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b0..3c91461bcfe4 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2585,6 +2585,8 @@
>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>  
> +#define PCI_VENDOR_ID_QUECTEL		0x1eac

Why did you ignore the comment at the top of this file saying that new
entries are not needed to be added, especially for just one user?

thanks,

greg k-h
