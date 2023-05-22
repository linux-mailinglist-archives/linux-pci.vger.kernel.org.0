Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41270B8D2
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 11:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjEVJWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjEVJWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 05:22:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED1EB9;
        Mon, 22 May 2023 02:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A9F61F54;
        Mon, 22 May 2023 09:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3E9C4339B;
        Mon, 22 May 2023 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684747342;
        bh=4UAOuaxRjDW/VUdv5PEW8PO3y6sk2Abupc99dtDqXVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6eKgFClyIfM6DBk8bSWMM3kIhcX0FqIj79QDbMDa1JsTHY8WxRYwz7V6xy62/Q8O
         RmK1nRSYtsmLgE3Rkp6z84Y6gW/bPI4GNywRLtRGd1vEBrr3iIVcEa9D1pid1tKbLR
         ghIlYoHpj0ZaGXp025wa4QzbRJDTwnGZWOkyM6ifMmPC6nrOSnPTGUbpOjiEnJjSi2
         /n9hCVYUG5+GJ6oIYrWmKBse+n+M+uXFtakwEVHB7ZzHA2kK2xDkEfg5wtKhhxf9ZB
         9Cslxd1y2sv/xlJ53XtGl5iS4VPqtQAkyvbS4ZqaRJ12LXYBeBP4a6w13f7PPIgw2U
         cFJzr9JUc5eIA==
Date:   Mon, 22 May 2023 11:22:12 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Subject: Re: [PATCH V4 0/6] Add PCIe support for IPQ9574
Message-ID: <ZGs0RJ2y+3lSZLIC@lpieralisi>
References: <20230519090219.15925-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519090219.15925-1-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 19, 2023 at 02:32:13PM +0530, Devi Priya wrote:
> This series adds support for enabling the PCIe host devices (PCIe0, PCIe1,
> PCIe2, PCIe3) found on IPQ9574 platform.
> The PCIe0 & PCIe1 are 1-lane Gen3 host and PCIe2 & PCIe3 
> are 2-lane Gen3 host.
> 
> DTS patch is based on the below series
> https://lore.kernel.org/linux-arm-msm/20230517172527.1968-1-quic_devipriy@quicinc.com/
> 
> Changes in V4:
> 	- Rebased on the below series
> https://lore.kernel.org/linux-arm-msm/20230517172527.1968-1-quic_devipriy@quicinc.com/
> 	- Change logs are added to the respective patches.

Mani, all,

can I pick up patches 3 and 6 from this series ?

Lorenzo

> [V3]
> https://lore.kernel.org/linux-arm-msm/20230421124938.21974-1-quic_devipriy@quicinc.com/
> 	- Dropped the phy driver and binding patches as they have been 
> 	  posted as a separate series.
> 	- Dropped the pinctrl binding fix patch as it is unrelated to the series
> 	  dt-bindings: pinctrl: qcom: Add few missing functions.
> 	- Rebased on linux-next/master.
> 	- Detailed change logs are added to the respective patches.
> 	
> [V2]
> https://lore.kernel.org/linux-arm-msm/20230404164828.8031-1-quic_devipriy@quicinc.com/
> 	- Reordered the patches and splitted the board DT changes
> 	  into a separate patch as suggested
> 	- Detailed change logs are added to the respective patches
> 
> [V1]
> https://lore.kernel.org/linux-arm-msm/20230214164135.17039-1-quic_devipriy@quicinc.com/
> 
> Devi Priya (6):
>   dt-bindings: clock: Add PCIe pipe clock definitions
>   clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
>   dt-bindings: PCI: qcom: Add IPQ9574
>   arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
>   arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
>   PCI: qcom: Add support for IPQ9574
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    |  48 +++
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   | 113 ++++++
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 365 ++++++++++++++++++
>  drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++
>  drivers/pci/controller/dwc/pcie-qcom.c        |  57 ++-
>  include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
>  6 files changed, 645 insertions(+), 18 deletions(-)
> 
> -- 
> 2.17.1
> 
