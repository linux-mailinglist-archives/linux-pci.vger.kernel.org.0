Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363C1614C4C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 15:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiKAOKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiKAOKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 10:10:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59DE1AF1A;
        Tue,  1 Nov 2022 07:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DF62B81D9F;
        Tue,  1 Nov 2022 14:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E0FC433C1;
        Tue,  1 Nov 2022 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667311840;
        bh=mlVeu1Ne59sKBF/PzA58tEMoYoFfmj0wPNUSof98OKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H8Vmc0WsTY2I85vQ+MjkbMlhzhoUsCxYNVxghx0seQz/7nK3yT/IWKwUKvKvgxJ5n
         J9aHV21ZURNtSHjXfCa/zxI+gCTdUm4o/CDQ1rFSmCZS7z35yNWWwR6GSKhX8gYN1j
         C3XS0JWEqC5GcnwUdtYPA7n61Ls+vDF350Iq6BJ916qOnsKpLowoWkZJdIzWfRJjrl
         nCJTy/laSWtOVHwwJh3Xx+qi2I/hoMSBakMVzDEiAyQRvYF2f1WZ0iOjYGDkWeaC1Q
         4z7kQyMZoXiytiF9e9dIZrnGKWdBqoWNuqLnD61Awpay4uvgeD6rcAr1SH18ZeMHbR
         Z/47fscS30Lcw==
Date:   Tue, 1 Nov 2022 09:10:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mani@kernel.org,
        quic_hemantk@quicinc.com, bhelgaas@google.com,
        loic.poulain@linaro.org, dnlplm@gmail.com, yonglin.tan@outlook.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Re: [PATCH v3] PCI: Add vendor ID for QUECTEL
Message-ID: <20221101141038.GA1255580@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3af61b4.1f11.18431cf918d.Coremail.slark_xiao@163.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 02:09:57PM +0800, Slark Xiao wrote:
> At 2022-11-01 12:46:19, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Tue, Nov 01, 2022 at 10:10:52AM +0800, Slark Xiao wrote:
> >> n MHI driver, there are some companies' product still do not have their
> >> own PCI vendor macro. So we add it here to make the code neat. Ref ID
> >> could be found in link https://pcisig.com/membership/member-companies.
> >> 
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> ---
> >> v3: Separate different vendors into different patch.
> >> 
> >> v2: Update vendor ID to the right location sorted by numeric value.
> >> ---
> >>  drivers/bus/mhi/host/pci_generic.c | 6 +++---
> >>  include/linux/pci_ids.h            | 2 ++
> >>  2 files changed, 5 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> >> index caa4ce28cf9e..81ae9c49ce2a 100644
> >> --- a/drivers/bus/mhi/host/pci_generic.c
> >> +++ b/drivers/bus/mhi/host/pci_generic.c
> >> @@ -555,11 +555,11 @@ static const struct pci_device_id mhi_pci_id_table[] = {
> >>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
> >>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
> >>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
> >> -	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
> >>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> >> -	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
> >>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> >> -	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> >>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> >>  	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
> >>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
> >> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> >> index b362d90eb9b0..3c91461bcfe4 100644
> >> --- a/include/linux/pci_ids.h
> >> +++ b/include/linux/pci_ids.h
> >> @@ -2585,6 +2585,8 @@
> >>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
> >>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
> >>  
> >> +#define PCI_VENDOR_ID_QUECTEL		0x1eac
> >
> >Why did you ignore the comment at the top of this file saying that new
> >entries are not needed to be added, especially for just one user?
>
>  Actually I didn't see this notice before committing this patch. I even discussed 
> it with the maintainer for several times and nobody show me this rule.
> I have a concern, some IOT module vendors, like QUECTEL, CINTERION(THALES),
> SIERRA,ROLLING and so on, they only produce IOT modules without other 
> hardware with PCIe  interface, and they applied for their own VID. But they
> can't get a their own VENDOR MARCO? This seems unreasonable.
> This change should be harmless and  make the code neat.
> This is my opinion.

Sorry, this is my fault.  I have merged or acked several vendor ID
additions recently, but I don't really backport changes like Greg
does, so I'm not as sensitized to the churn and merge issues.

Bjorn
