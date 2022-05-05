Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB90951C40C
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiEEPlg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiEEPld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 11:41:33 -0400
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218BD15815;
        Thu,  5 May 2022 08:37:52 -0700 (PDT)
Received: from [192.168.1.17] (unknown [84.238.208.205])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id BF412D2AA;
        Thu,  5 May 2022 18:37:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1651765070; bh=uVBey31bxdTj1jCCK+/s43l7HdKmJ0V7+XbcUggK3zA=;
        h=Date:Subject:To:Cc:From:From;
        b=nkIpo+HObdOmz3xtRL3k69eQ5gV3avmAx9tAxhZakfllVMMRQJLx0GpYxbf7XKTnm
         Wf6qbPwZ7Z912uWgMvVyb9htTfP6OpOCQIsHX4XkodBxZ8RqIBBaIVbSRMmm+8Ku7g
         urirEqfGJmmDX2wZwRRDLLZbGIbIdivxe+H8kes5t47FZMFEuVnApJLBgPXtcuGDpP
         rN6n7+KZ+rP8vaHVz0CzGt53tQKEjQmSNkDTioHzmbFWuLbiph0DEOIRNMWQP2rWtj
         vM+NysPthpGf/2duhomPGxxlfd1j7IFDqEOMlMnI0VkWn7e9S5/SqzkBMrnMdAiFoL
         9T6z5/LVoNoWA==
Message-ID: <ace7dd07-cf2f-fa74-866f-50f7da0b89bb@mm-sol.com>
Date:   Thu, 5 May 2022 18:37:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 0/7] PCI: qcom: Fix higher MSI vectors handling
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Dmitry!

On 5/5/22 16:54, Dmitry Baryshkov wrote:
> I have replied with my Tested-by to the patch at [2], which has landed
> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> Add support for handling MSIs from 8 endpoints"). However lately I
> noticed that during the tests I still had 'pcie_pme=nomsi', so the
> device was not forced to use higher MSI vectors.
> 
> After removing this option I noticed that hight MSI vectors are not
> delivered on tested platforms. After additional research I stumbled upon
> a patch in msm-4.14 ([1]), which describes that each group of MSI
> vectors is mapped to the separate interrupt. Implement corresponding
> mapping.
> 
> Since we can not expect that other platforms will use multi-IRQ scheme
> for MSI mapping (e.g. iMX and Tegra map all 256 MSI interrupts to single
> IRQ), it's support is implemented directly in pcie-qcom rather than in
> the core driver.
> 
> The first patch in the series is a revert of  [2] (landed in pci-next).
> Either both patches should be applied or both should be dropped.
> 
> Patchseries dependecies: [3] (for the schema change).
> 
> Changes since v6:
>  - Fix indentation of the arguments as requested by Stanimir

<cut>

> 
> Dmitry Baryshkov (7):
>   PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8
>     endpoints"
>   PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
>   PCI: dwc: Add msi_host_deinit callback
>   PCI: dwc: Export several functions useful for MSI implentations
>   PCI: qcom: Handle MSIs routed to multiple GIC interrupts
>   dt-bindings: PCI: qcom: Support additional MSI interrupts
>   arm64: dts: qcom: sm8250: provide additional MSI interrupts

For PCI qcom driver:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    |  45 +++++-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |  11 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  72 +++++----
>  drivers/pci/controller/dwc/pcie-designware.h  |  12 ++
>  drivers/pci/controller/dwc/pcie-qcom.c        | 138 +++++++++++++++++-
>  5 files changed, 246 insertions(+), 32 deletions(-)
> 

-- 
regards,
Stan
