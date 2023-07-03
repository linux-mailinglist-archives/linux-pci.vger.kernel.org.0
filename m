Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46F745A04
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 12:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGCKS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGCKS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 06:18:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C91DBE;
        Mon,  3 Jul 2023 03:18:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DF572F4;
        Mon,  3 Jul 2023 03:19:40 -0700 (PDT)
Received: from [10.57.38.117] (unknown [10.57.38.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 429EE3F762;
        Mon,  3 Jul 2023 03:18:53 -0700 (PDT)
Message-ID: <997819c6-0798-e2f9-b94b-fedfbab7fdd8@arm.com>
Date:   Mon, 3 Jul 2023 11:18:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI
 address
Content-Language: en-GB
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     dlemoal@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230703085845.2052008-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-07-03 09:58, Rick Wertenbroek wrote:
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
> ---
>   drivers/pci/controller/pcie-rockchip.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index fe0333778fd9..627d08b34827 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -158,7 +158,9 @@
>   #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>   #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
>   
> -#define PCIE_ADDR_MASK			0xffffff00
> +#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
> +#define MIN_AXI_ADDR_BITS_PASSED		8
> +#define PCIE_ADDR_MASK			GENMASK(63, MIN_AXI_ADDR_BITS_PASSED)

Nit: this probably wants to be GENMASK_ULL(), otherwise it might throw a 
warning if compile-tested for 32-bit.

Thanks,
Robin.

>   #define PCIE_CORE_AXI_CONF_BASE		0xc00000
>   #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
>   #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
> @@ -185,8 +187,6 @@
>   #define AXI_WRAPPER_TYPE1_CFG			0xb
>   #define AXI_WRAPPER_NOR_MSG			0xc
>   
> -#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
> -#define MIN_AXI_ADDR_BITS_PASSED		8
>   #define PCIE_RC_SEND_PME_OFF			0x11960
>   #define ROCKCHIP_VENDOR_ID			0x1d87
>   #define PCIE_LINK_IS_L2(x) \
