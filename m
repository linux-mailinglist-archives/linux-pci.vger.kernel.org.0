Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536936923CB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 17:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjBJQ6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 11:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjBJQ6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 11:58:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD679B13;
        Fri, 10 Feb 2023 08:58:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7789861E4A;
        Fri, 10 Feb 2023 16:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05647C433D2;
        Fri, 10 Feb 2023 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676048303;
        bh=vK5LExH2oZzKUBw84FeZA7l2Jodx4gUrefk1caRsn6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgTDU9cvSj60RHQKt8IGHFDJrdnn/QpCrdnFc4BkGA9TFfnvOaNZv0p31oEu5nb0J
         y275iDwKqKWh4vNwfDABcn/TN32/RD4wglk1YO0FESDatpeDqCCS/a/RHrhe7B7SXQ
         nSOxQYOjfxjMci/1nquZA4hDtXRatmkVNlXmXGnsJmZ2n6Mr2tKcsVmg2ahTmneqBF
         BRTSaGMKaA9lCdFkUxiz20SMkgLoJF97z5HXuBaDQj/zip9W2YyVOQSPAfZQbIBBo+
         1kc0S535rnJzRWR6CXQp/7qDbdAs9zetZqnSyF/suxRbQgT/CcfkLYHZfRD9B8yGFX
         THQWWykTpPzWg==
Date:   Fri, 10 Feb 2023 22:28:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/11] sm8550: Add PCIe HC and PHY support
Message-ID: <Y+Z3qs3uuad4ViIu@matsya>
References: <20230208180020.2761766-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208180020.2761766-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08-02-23, 20:00, Abel Vesa wrote:
> For changelogs please look at each patch individually.
> 
> Abel Vesa (11):
>   dt-bindings: phy: Add QMP PCIe PHY comptible for SM8550
>   phy: qcom-qmp: pcs: Add v6 register offsets
>   phy: qcom-qmp: pcs: Add v6.20 register offsets
>   phy: qcom-qmp: pcs-pcie: Add v6 register offsets
>   phy: qcom-qmp: pcs-pcie: Add v6.20 register offsets
>   phy: qcom-qmp: qserdes-txrx: Add v6.20 register offsets
>   phy: qcom-qmp: qserdes-lane-shared: Add v6 register offsets
>   phy: qcom-qmp-pcie: Add support for SM8550 g3x2 and g4x2 PCIEs

Applied to phy-next, thanks

>   dt-bindings: PCI: qcom: Add SM8550 compatible
>   PCI: qcom: Add SM8550 PCIe support
>   arm64: dts: qcom: sm8550: Fix PCIe PHYs and controllers nodes
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    |  40 ++
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  30 +-
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts       |  10 +
>  arch/arm64/boot/dts/qcom/sm8550.dtsi          |  52 +--
>  drivers/pci/controller/dwc/pcie-qcom.c        |  25 +-
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 346 +++++++++++++++++-
>  .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h   |  15 +
>  .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h    |  23 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h    |  16 +
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h |  18 +
>  .../phy-qcom-qmp-qserdes-ln-shrd-v6.h         |  32 ++
>  .../phy-qcom-qmp-qserdes-txrx-v6_20.h         |  45 +++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |   6 +
>  13 files changed, 611 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> 
> -- 
> 2.34.1

-- 
~Vinod
