Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B9745818
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGCJK0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 05:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGCJKZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 05:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBF8AB;
        Mon,  3 Jul 2023 02:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B34A60E04;
        Mon,  3 Jul 2023 09:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803E7C433C8;
        Mon,  3 Jul 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688375424;
        bh=dmZviKKLtRIO7Cf3ns+OALgiuOuzMG2UrVkETB/AT1c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EFtvaIZaLiuPBlbeeVBIeXguD2PXeAZIXK0yG8C8tQ2qJajT9CfUhpJbopnVm5NiC
         s0gX1d4tvTyZwgVoGtr/8FID1ZNEHXfAku4/khdu3yAg59ymVPeo0u1+oRcCY2L4V4
         iV7kzIf2nvTLL709du7uGrG+OY4WopinDHuuo42QwJJ3weQTc28fTEVbpaK1YcsiiP
         mJi4Yx5vlLr3QAdydnupf63Rzh3873ehn8j9j4NkZgD817aD5OPX2uOCKUJeIlx5j8
         GPvS4tRn4GWKUHVxVJrBfOfjO2/EtTZwEf9vXttvRels+S+XRybNh87V30dtKI8Mba
         hdQBF+q0HPk2Q==
Message-ID: <64367911-21d1-d688-0994-4fd557b0a307@kernel.org>
Date:   Mon, 3 Jul 2023 18:10:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI
 address
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/3/23 17:58, Rick Wertenbroek wrote:
> A 32-bit mask was used on the 64-bit PCI address used for mapping MSIs.
> This would result in the upper 32 bits being unintentionally zeroed and
> MSIs getting mapped to incorrect PCI addresses if the address had any
> of the upper bits set.
> 
> Replace 32-bit mask by appropriate 64-bit mask.
> 
> Fixes: dc73ed0f1b8b ("PCI: rockchip: Fix window mapping and address translation for endpoint")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/8d19e5b7-8fa0-44a4-90e2-9bb06f5eb694@moroto.mountain/
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Cc: stable@vger.kernel.org

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/pci/controller/pcie-rockchip.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index fe0333778fd9..627d08b34827 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -158,7 +158,9 @@
>  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>  #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
>  
> -#define PCIE_ADDR_MASK			0xffffff00
> +#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
> +#define MIN_AXI_ADDR_BITS_PASSED		8
> +#define PCIE_ADDR_MASK			GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)
>  #define PCIE_CORE_AXI_CONF_BASE		0xc00000
>  #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
>  #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
> @@ -185,8 +187,6 @@
>  #define AXI_WRAPPER_TYPE1_CFG			0xb
>  #define AXI_WRAPPER_NOR_MSG			0xc
>  
> -#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
> -#define MIN_AXI_ADDR_BITS_PASSED		8
>  #define PCIE_RC_SEND_PME_OFF			0x11960
>  #define ROCKCHIP_VENDOR_ID			0x1d87
>  #define PCIE_LINK_IS_L2(x) \

-- 
Damien Le Moal
Western Digital Research

