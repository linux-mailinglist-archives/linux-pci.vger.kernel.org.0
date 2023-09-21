Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF867A97E2
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjIUR2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjIUR1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 13:27:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1797C1702;
        Thu, 21 Sep 2023 10:01:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A02BC116D2;
        Thu, 21 Sep 2023 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695285664;
        bh=2VdLPNsimLvVm8/OS9eY5PGJy7+LPxUcwGgt59gxfqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxRvquE2e5HPBCLFPy0H0o6E9xx6fbywXnllqYBDTKVWRTLi2mp7JMvhCtcIcBY3x
         Ol1oxICfHa4EYEfwwjeGYtpYo5mOrqX3V3Y9mwJb9VQOHMFy49jqlik4yKXmCVzpMl
         LGcgit6XPqXOz4KRMx9ziyC3rhDv4L9W4AWNqrvRi87IrO3zTvwmNLO+OMu97Ln5GZ
         eXmSk8jtD7LGwZlJjN1GGKNbnxpuC/Rd/PCre5eQrhRA3d86X3UqMdQo4IMZydEyut
         2L7sEZBa5yx/S7oKM7elxZ/sanZGgxgbptJJ7UsDLB/W0b29LNAQGUWBc5beBAsL6Z
         /D4Nwe+O2G7oA==
Date:   Thu, 21 Sep 2023 10:40:55 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 4/5] PCI: epf-mhi: Add support for SA8775P
Message-ID: <20230921084055.GD2891@thinkpad>
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-5-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1695218113-31198-5-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 20, 2023 at 07:25:11PM +0530, Mrinmay Sarkar wrote:
> Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
> SA8775P has the PID (0x0306) and supports HDMA. Currently, it has
> no fixed PCI class, so it is being advertised as "PCI_CLASS_OTHERS".
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index b7b9d3e..4b349fd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -114,6 +114,23 @@ static const struct pci_epf_mhi_ep_info sm8450_info = {
>  	.flags = MHI_EPF_USE_DMA,
>  };
>  
> +static struct pci_epf_header sa8775p_header = {

static const struct...

> +	.vendorid = PCI_VENDOR_ID_QCOM,
> +	.deviceid = 0x0306,

Why are you not using a distinct device id?

- Mani

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
> +	.flags = MHI_EPF_USE_DMA,
> +};
> +
>  struct pci_epf_mhi {
>  	const struct pci_epc_features *epc_features;
>  	const struct pci_epf_mhi_ep_info *info;
> @@ -677,6 +694,7 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
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

-- 
மணிவண்ணன் சதாசிவம்
