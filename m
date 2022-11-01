Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F6261466E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKAJNy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKAJNx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 05:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA702DF5E;
        Tue,  1 Nov 2022 02:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A396156F;
        Tue,  1 Nov 2022 09:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B07C433C1;
        Tue,  1 Nov 2022 09:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667294031;
        bh=QHsGnq7GKNlqhME9hG1k+53dFj98wy8UH/SBmiMhgFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8uMcfrNm1G0d5ZNL0Bc+vQdmCcZeeUEBv2oKR89hOSce7rBSYJQKnhkx4yG5q/5e
         GKkfF34jgtC3QuTK5a4VHBy3fFwB4gq5LtJkwl1CzPI01wOCawwvprLiJZRkXmcRS4
         ji2Yh3ZyugjLxe3OthaKlS/y/ueQXWYzxfpH3yc+5YsAcgUmNtvzDTsCGodYoVuZup
         dkOXi/LeEnNwxLp15LZTqE4B7/u6CAWMpUw2thWBbrTb19H2eVCu/oLCJTyK7dYPTS
         3d+4XUUICSBM75kiOkBDyq8ynFG3PTihLJnPwjsWOAjU945YZsa5to68mgepYLTm6f
         jAOSv2z1KV+IA==
Date:   Tue, 1 Nov 2022 14:43:39 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, quic_hemantk@quicinc.com,
        bhelgaas@google.com, loic.poulain@linaro.org, dnlplm@gmail.com,
        yonglin.tan@outlook.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: Re: Re: [PATCH v3] PCI: Add vendor ID for QUECTEL
Message-ID: <20221101091339.GA54667@thinkpad>
References: <20221101021052.7532-1-slark_xiao@163.com>
 <Y2Ckm79PgcTcVVne@kroah.com>
 <3af61b4.1f11.18431cf918d.Coremail.slark_xiao@163.com>
 <Y2C7uhzVorUrfQA2@kroah.com>
 <69942131.48d4.18431f6c080.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69942131.48d4.18431f6c080.Coremail.slark_xiao@163.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 02:52:45PM +0800, Slark Xiao wrote:
> 
> 
> 
> 
> 
> At 2022-11-01 14:24:58, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Tue, Nov 01, 2022 at 02:09:57PM +0800, Slark Xiao wrote:
> >> 
> >> 
> >> At 2022-11-01 12:46:19, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >> >On Tue, Nov 01, 2022 at 10:10:52AM +0800, Slark Xiao wrote:
> >> >> n MHI driver, there are some companies' product still do not have their
> >> >> own PCI vendor macro. So we add it here to make the code neat. Ref ID
> >> >> could be found in link https://pcisig.com/membership/member-companies.
> >> >> 
> >> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> >> ---
> >> >> v3: Separate different vendors into different patch.
> >> >> 
> >> >> v2: Update vendor ID to the right location sorted by numeric value.
> >> >> ---
> >> >>  drivers/bus/mhi/host/pci_generic.c | 6 +++---
> >> >>  include/linux/pci_ids.h            | 2 ++
> >> >>  2 files changed, 5 insertions(+), 3 deletions(-)
> >> >> 
> >> >> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> >> >> index caa4ce28cf9e..81ae9c49ce2a 100644
> >> >> --- a/drivers/bus/mhi/host/pci_generic.c
> >> >> +++ b/drivers/bus/mhi/host/pci_generic.c
> >> >> @@ -555,11 +555,11 @@ static const struct pci_device_id mhi_pci_id_table[] = {
> >> >>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
> >> >>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
> >> >>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
> >> >> -	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
> >> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
> >> >>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> >> >> -	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
> >> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
> >> >>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> >> >> -	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> >> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> >> >>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> >> >>  	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
> >> >>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
> >> >> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> >> >> index b362d90eb9b0..3c91461bcfe4 100644
> >> >> --- a/include/linux/pci_ids.h
> >> >> +++ b/include/linux/pci_ids.h
> >> >> @@ -2585,6 +2585,8 @@
> >> >>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
> >> >>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
> >> >>  
> >> >> +#define PCI_VENDOR_ID_QUECTEL		0x1eac
> >> >
> >> >Why did you ignore the comment at the top of this file saying that new
> >> >entries are not needed to be added, especially for just one user?
> >> >
> >> >thanks,
> >> >
> >> >greg k-h
> >> Hi Greg,
> >>  Actually I didn't see this notice before committing this patch. I even discussed 
> >> it with the maintainer for several times and nobody show me this rule.
> >> I have a concern, some IOT module vendors, like QUECTEL, CINTERION(THALES),
> >> SIERRA,ROLLING and so on, they only produce IOT modules without other 
> >> hardware with PCIe  interface, and they applied for their own VID. But they
> >> can't get a their own VENDOR MARCO? This seems unreasonable.
> >> This change should be harmless and  make the code neat.
> >> This is my opinion.
> >
> >It causes a _LOT_ of churn and merge issues when everyone is adding new
> >entries to a single file.  Which is why, 15+ years ago, we made the
> >decision that if a vendor or device id is only needed in one file, then
> >it should not be added to the pci_ids.h file.
> >
> >No need to change that now, please just put the vendor id in the single
> >driver that it is needed in.
> >
> >thanks,
> >
> >greg k-h
> Hi Greg,
> Thanks for your explanation. 
> 
> Hi Mani,
>   Is there a need to update these vendor ids as macro in
> pci_generic.c?
> 

It is not really needed but for convenience you could add a macro in
pci_generic.c itself.

Thanks,
Mani

> Thanks.

-- 
மணிவண்ணன் சதாசிவம்
