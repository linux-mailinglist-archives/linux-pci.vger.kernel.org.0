Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751E273C723
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 08:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFXGeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 02:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFXGeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 02:34:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444FC2136;
        Fri, 23 Jun 2023 23:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D482060ABA;
        Sat, 24 Jun 2023 06:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E33C433C0;
        Sat, 24 Jun 2023 06:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687588456;
        bh=hkHTxFvEO+MyLUGuPjA18Dxz9O52pK222StWI/ypeW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iT2Qeuvzn29kj/TwQDmO5lbTeWJ6qdLqQ/gA2XcFWNqwdcObW4XQQP3hpHaTkpVMW
         sNWJLJAVjBiC9ZQOacg2ni3iIKWVAzLb2vptflufZ/DCFXvB2WE3aQY/Dd8KLbFU+c
         z6Jx3B1jvQOzOdxCIq/kcrMgaivmb+5PTJVx1AjEgy/4QgSWYqRZ1YLQC2/bAfMfhi
         72jndihbTgO46fYhdNnrooQ5sWXsuWIAOCZXDmG9daJBwEUY8nUAiIeCzNdd29nTg7
         VpPwF4pipLTFwuxcNm6XB01IvDrs0Rt3KQbNZRyuK4ztbtmR/S5PD94pKykDtqZYLT
         FCpZhGTEzqYhA==
Date:   Sat, 24 Jun 2023 12:04:01 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4]  IPQ8074 pcie/wcss fixes
Message-ID: <20230624063401.GG5611@thinkpad>
References: <20230623093445.3977772-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230623093445.3977772-1-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 23, 2023 at 03:04:41PM +0530, Sricharan Ramabadhran wrote:
> These are required to have pcie/wcss working on IPQ8074 based
> boards. Pcie was broken recently, first patch fixes that and
> next 2 are for adding WCSS reset and 1 for adding reserved region
> for NSS.
> 
> Will be following this up with few more dts updates and pcie
> fixes.
> 

Since there is no direct relation between pcie and clk patches, these should've
been submitted separately.

- Mani

> Sricharan Ramabadhran (4):
>   pcie: qcom: Fix the macro PARF_SLV_ADDR_SPACE_SIZE_2_3_3
>   dt-bindings: clock: qcom: Add reset for WCSSAON
>   clk: qcom: Add WCSSAON reset
>   dts: Reserve memory region for NSS and TZ
> 
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi        | 7 ++++++-
>  drivers/clk/qcom/gcc-ipq8074.c               | 1 +
>  drivers/pci/controller/dwc/pcie-qcom.c       | 2 +-
>  include/dt-bindings/clock/qcom,gcc-ipq8074.h | 1 +
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
