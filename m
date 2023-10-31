Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4231A7DC58F
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 05:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjJaE6E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 00:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjJaE6C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 00:58:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3428C9E;
        Mon, 30 Oct 2023 21:58:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7551EC433C7;
        Tue, 31 Oct 2023 04:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698728279;
        bh=vPWQWJfyhiQnh4+ZjNGf+AuE1H2xx2JWs58swbGwmp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAPSYSqTmzZarZx3thoV1X9VqFpYA+u6JdtjVT6jpI0uqAX7HT7qjuO62Cu8FYVEu
         nYqBZvTgzhq8DQVIf5PuwSxNy08mJHaGRL/OYPT5jjQlOoS31KbcNTx5lIeD2KBs5r
         nXPabgvVYIFuExbE1toMXbEja+XmVb3/YIFpLmP3Gdl0bJWH4UD5TSWx068A5KewaJ
         c5+pFsYRLUUK8E7HPM9N4YkOyb7RvXE2XMc+fDXAHuUTQqLlBSu5vVOEA7RCq0lCON
         C9fgn3Hp+Tao4suXnvwxpMNX9RS+1lUnvZUZzWZOYZZo91Lj07nWdcST3yF97cbCxq
         WXtRfTcUuzang==
Date:   Tue, 31 Oct 2023 10:27:40 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: Re: [PATCH v5 0/4] arm64: qcom: sa8775p: add cache coherency support
 for SA8775P
Message-ID: <20231031045740.GA11778@thinkpad>
References: <1698727267-22131-1-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1698727267-22131-1-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 10:11:02AM +0530, Mrinmay Sarkar wrote:
> This series is to enable cache snooping logic in both RC and EP
> driver and add the "dma-coherent" property in dtsi to support
> cache coherency in SA8775P.
> 

You just merged the cover letter of two different series. No, you are not
enabling cache snooping in this series.

Please take time to review all the changes and cover letter before posting.

- Mani

> 
> This series adds the relavent DT bindings, new compatible string,
> add support to EPF driver and add EP PCIe node in dtsi file for
> ep pcie0 controller.
> 
> v4 -> v5:
> - add maxItems to the respective field to constrain io space and
>   interrupt in all variants.
> 
> v3 -> v4:
> - add maxItems field in dt bindings
> - update comment in patch2
> - dropped PHY driver patch as it is already applied [1]
> - update comment in EPF driver patch
> - update commect in dtsi and add iommus instead of iommu-map
> 
> [1] https://lore.kernel.org/all/169804254205.383714.18423881810869732517.b4-ty@kernel.org/
> 
> v2 -> v3:
> - removed if/then schemas, added minItems for reg,
>   reg-bnames, interrupt and interrupt-names instead.
> - adding qcom,sa8775p-pcie-ep compitable for sa8775p
>   as we have some specific change to add.
> - reusing sm8450's pcs_misc num table as it is same as sa8775p.
>   used appropriate namespace for pcs.
> - remove const from sa8775p_header as kernel test robot
>   throwing some warnings due to this.
> - remove fallback compatiable as we are adding compatiable for sa8775p.
> 
> v1 -> v2:
> - update description for dma
> - Reusing qcom,sdx55-pcie-ep compatibe so remove compaitable
>   for sa8775p
> - sort the defines in phy header file and remove extra defines
> - add const in return type pci_epf_header and remove MHI_EPF_USE_DMA
>   flag as hdma patch is not ready
> - add fallback compatiable as qcom,sdx55-pcie-ep, add iommu property
> 
> 
> Mrinmay Sarkar (4):
>   dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
>   PCI: qcom-ep: Add support for SA8775P SOC
>   PCI: epf-mhi: Add support for SA8775P
>   arm64: dts: qcom: sa8775p: Add ep pcie0 controller node
> 
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 46 ++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
>  drivers/pci/endpoint/functions/pci-epf-mhi.c       | 17 ++++++
>  4 files changed, 126 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
