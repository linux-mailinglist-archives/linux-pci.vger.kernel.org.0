Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C767E12AC
	for <lists+linux-pci@lfdr.de>; Sun,  5 Nov 2023 09:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjKEI4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Nov 2023 03:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEI4K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Nov 2023 03:56:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE41EE;
        Sun,  5 Nov 2023 01:56:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA76AC433C9;
        Sun,  5 Nov 2023 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699174567;
        bh=/FJtqScaHrtd80S9WXDntjorw/0XwpXE9blm9TxhbeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9drhfhNhCoarASbCXcYw5PXiPekZkdUUoBGDhMQMOWm57oZNbyQ86U1sDC6W2A4U
         /qBYYxrlg1G45/AcHA0tmKQ9F2M/0lZV4a+i6xf/oWg2BHnTUqW+L4TpfamWsgHdVb
         uyn4eZw99NNra5odll6jGIw4Urdat3eu8wMy3HAXTHQBdI93J246Vc2k52wRuD6P+c
         u3/tulwIJEtNX5tXRq++ZQZXP8uLn+NZd5r1i7Yv3kxTOo/DTjpmiMgn6h6JSBVJUE
         ag75I5JsiOunBKeRu0Njm0bcR244r5/J27ELu4pIB4szra/G8mwmWE8s/puh72y+q+
         HELhOwYDFJvKg==
Date:   Sun, 5 Nov 2023 14:25:50 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: Re: [PATCH v6 3/4] PCI: epf-mhi: Add support for SA8775P
Message-ID: <20231105085550.GC2508@thinkpad>
References: <1698729108-27356-1-git-send-email-quic_msarkar@quicinc.com>
 <1698729108-27356-4-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1698729108-27356-4-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 10:41:47AM +0530, Mrinmay Sarkar wrote:
> Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
> Reusing DID (0x0306) for SA8775P and it supports HDMA. Currently,

You should state why you are reusing the "PID" and whether it is going to be
updated in the future or not.

> it has no fixed PCI class, so it is being advertised as
> "PCI_CLASS_OTHERS".
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

With the above mentioned change,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index b7b9d3e..23ea94e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -114,6 +114,22 @@ static const struct pci_epf_mhi_ep_info sm8450_info = {
>  	.flags = MHI_EPF_USE_DMA,
>  };
>  
> +static struct pci_epf_header sa8775p_header = {
> +	.vendorid = PCI_VENDOR_ID_QCOM,
> +	.deviceid = 0x0306,               /* FIXME: Update deviceid for sa8775p EP */
> +	.baseclass_code = PCI_CLASS_OTHERS,
> +	.interrupt_pin = PCI_INTERRUPT_INTA,
> +};
> +
> +static const struct pci_epf_mhi_ep_info sa8775p_info = {
> +	.config = &mhi_v1_config,
> +	.epf_header = &sa8775p_header,
> +	.bar_num = BAR_0,
> +	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
> +	.msi_count = 32,
> +	.mru = 0x8000,
> +};
> +
>  struct pci_epf_mhi {
>  	const struct pci_epc_features *epc_features;
>  	const struct pci_epf_mhi_ep_info *info;
> @@ -677,6 +693,7 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
>  }
>  
>  static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
> +	{ .name = "sa8775p", .driver_data = (kernel_ulong_t)&sa8775p_info },
>  	{ .name = "sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
>  	{ .name = "sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
>  	{},
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
