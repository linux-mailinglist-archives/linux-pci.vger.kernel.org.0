Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EA473C71E
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 08:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjFXGce (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 02:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFXGcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 02:32:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D754F2136;
        Fri, 23 Jun 2023 23:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE2C60A65;
        Sat, 24 Jun 2023 06:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE825C433C8;
        Sat, 24 Jun 2023 06:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687588351;
        bh=vayuMiTc+MU/ujyAq/i+OMj3JgFiO1kxJ5+q8YqwIGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWQjAYEkXVpK0i720w4RtqhpH+3y0Aa/ovquBpt8gnQgwvPEsSmGnyZ/blYZ1wjii
         nXbJYaDAMbbWwrB1kJBsZBHKnnMSXxqvtaYXNQSBLRsNtRCyoECWuYd/OEHfyY6Rb6
         OumrNoSyRUC+HoqRoCN7Gf967xRtvSXVSzIGUbBzU7klvIAH6oxOrWt2ZNwxCLWpIG
         l1y9qMQ+W9X5z3AAEfpkNUTSffiTLllfoxiwOQt7GSN1f/+XaK5QfYl+a6ZYfXkwfr
         Mylu++RKOarOUYnW1EWCgDhs/xQ1OVx77JQi6Pe4AJOnB0UaOn6Ga4msFVqMHClJ9j
         2H3Wa3pbWmomQ==
Date:   Sat, 24 Jun 2023 12:02:15 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        mani@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] pcie: qcom: Fix the macro
 PARF_SLV_ADDR_SPACE_SIZE_2_3_3
Message-ID: <20230624063215.GF5611@thinkpad>
References: <20230623093445.3977772-1-quic_srichara@quicinc.com>
 <20230623093445.3977772-2-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230623093445.3977772-2-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 23, 2023 at 03:04:42PM +0530, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro used for IPQ8074
> pcie slave addr size was initially set to 0x358, but
> was wrongly changed to 0x168 as a part of
> 'PCI: qcom: Sort and group registers and bitfield definitions'
> Fixing it back to right value here.
> 
> Without this pcie bring up on IPQ8074 is broken now.
> 

Subject prefix should be: "PCI: qcom: "

> Fixes: 769e49d87b15 ("PCI: qcom: Sort and group registers and bitfield definitions")

Fixes tag is referring to a wrong commit. Correct one is:
39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")

> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 4ab30892f6ef..59823beed13f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -43,7 +43,7 @@
>  #define PARF_PHY_REFCLK				0x4c
>  #define PARF_CONFIG_BITS			0x50
>  #define PARF_DBI_BASE_ADDR			0x168
> -#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
> +#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x358 /* Register offset specific to IP ver 2.3.3 */

You should just remove PARF_SLV_ADDR_SPACE_SIZE_2_3_3 and use
PARF_SLV_ADDR_SPACE_SIZE which already has the value of 0x358.

- Mani

>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
