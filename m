Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B09F74800D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 10:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGEIqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjGEIqY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 04:46:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11049133;
        Wed,  5 Jul 2023 01:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A32AA6149D;
        Wed,  5 Jul 2023 08:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426B2C433C7;
        Wed,  5 Jul 2023 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688546783;
        bh=TrDgTUVhADoSsAO2/sNZ+F/3nrvrfuljDS6R5BUFlqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0+vVsH3AhB/AXyyE2VaWHL77fjGb9huGVzPLh4BVkJWt2lr2ii/t8H+KuQf0s6CS
         Zw1KPnwuYyrhImeN1ZhndHzTVMH0KPrJsFYeyYRueACZ5pT1HxChw6uE31eC0DWz+w
         KmrujmRpC7AEtoFiRnr/xJW3Jr9yVhuJoyPo+dK1bLPJKyysyp6XwGyAeMO8aGWfMy
         iOJA2JBskgNU9gopvIRbAnp1VeSEpMt174zXetABgZyd1SGFpqw5iiVboRScCdx7cL
         FbfcnVQrOI464HqZplDCV4Je7snRf5FCOc2hKj+CVucweQHllQypi44FecnC01DU7H
         O72RoaRKM+oJQ==
Date:   Wed, 5 Jul 2023 14:16:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for PCIe
Message-ID: <20230705084606.GF11854@thinkpad>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 01:47:05PM +0530, Mrinmay Sarkar wrote:
> Update the relavent DT bindings for PCIe, add new config to the phy
> driver add pcie and phy nodes to the .dtsi file and enable then in 
> board .dts file for the sa8775p-ride platform.
> 
> Mrinmay Sarkar (6):
>   dt-bindings: PCI: qcom: Add sa8775p compatible
>   dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY
>   PCI: qcom: Add support for sa8775p SoC
>   phy: qcom-qmp-pcie: add support for sa8775p
>   arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
>   arm64: dts: qcom: sa8775p-ride: enable pcie nodes

Please note that the dts patches should come before driver patches.

- Mani

> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    |  28 ++
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  19 +-
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |  68 ++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 201 ++++++++++-
>  drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 328 ++++++++++++++++++
>  .../qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h    |   1 +
>  .../phy-qcom-qmp-qserdes-txrx-v5_20.h         |   2 +
>  8 files changed, 645 insertions(+), 3 deletions(-)
> 
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
