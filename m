Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957CE5EA851
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiIZOYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiIZOXz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 10:23:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64E01181B;
        Mon, 26 Sep 2022 05:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6007FCE1130;
        Mon, 26 Sep 2022 12:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525C9C433D6;
        Mon, 26 Sep 2022 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664195677;
        bh=vW41fwAs8yIBAAXaBsitEXuJcX7gT1jTUr0chte7TQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpxSd5W9pu6Liz8eesFvgkC10k4/VfcVRY48jH0XFMXa9yYO5qo+Iho/nDlEkO4JI
         Hsc4kZStYodD31wZ3VuBO6onE9RksIfyc9hkFxzgKXxfIeQNIN18d6+k/Z9o4eyFUY
         uObqF6AZGtHyFAcT5A3ar1jx6OVpp+sJgyWfZpTv0ydPyh+4e9D2P5/BdPvCwXm5x3
         f+AqCJoRbgagsluLpXuMSPjLTNZVOAHRPWrBtTQHk4ugmPKqRTanvooUv1Daht0ktX
         nLyDzIdh/JnpXsJsCWnkfC+n+BevcRFnBbemS/+EuPmKciLJMWwIK9hjFcVjsJ3RBH
         +8avfzyeXXRVw==
Received: by pali.im (Postfix)
        id 8CA958A3; Mon, 26 Sep 2022 14:34:34 +0200 (CEST)
Date:   Mon, 26 Sep 2022 14:34:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Subject: Re: [PATCH v2] PCI: aardvark: Implement workaround for PCIe
 Completion Timeout
Message-ID: <20220926123434.2tqx4t6u3cnlrcx3@pali>
References: <20220802123816.21817-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802123816.21817-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Elad, could you please review this patch? I have implemented it
according your instructions, including that full memory barrier as you
described.

On Tuesday 02 August 2022 14:38:16 Pali Rohár wrote:
> Marvell Armada 3700 Functional Errata, Guidelines, and Restrictions
> document describes in erratum 3.12 PCIe Completion Timeout (Ref #: 251),
> that PCIe IP does not support a strong-ordered model for inbound posted vs.
> outbound completion.
> 
> As a workaround for this erratum, DIS_ORD_CHK flag in Debug Mux Control
> register must be set. It disables the ordering check in the core between
> Completions and Posted requests received from the link.
> 
> Marvell also suggests to do full memory barrier at the beginning of
> aardvark summary interrupt handler before calling interrupt handlers of
> endpoint drivers in order to minimize the risk for the race condition
> documented in the Erratum between the DMA done status reading and the
> completion of writing to the host memory.
> 
> More details about this issue and suggested workarounds are in discussion:
> https://lore.kernel.org/linux-pci/BN9PR18MB425154FE5019DCAF2028A1D5DB8D9@BN9PR18MB4251.namprd18.prod.outlook.com/t/#u
> 
> It was reported that enabling this workaround fixes instability issues and
> "Unhandled fault" errors when using 60 GHz WiFi 802.11ad card with Qualcomm
> QCA6335 chip under significant load which were caused by interrupt status
> stuck in the outbound CMPLT queue traced back to this erratum.
> 
> This workaround fixes also kernel panic triggered after some minutes of
> usage 5 GHz WiFi 802.11ax card with Mediatek MT7915 chip:
> 
>     Internal error: synchronous external abort: 96000210 [#1] SMP
>     Kernel panic - not syncing: Fatal exception in interrupt
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-aardvark.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 060936ef01fe..3ae8a85ec72e 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -210,6 +210,8 @@ enum {
>  };
>  
>  #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
> +#define DEBUG_MUX_CTRL_REG			(LMI_BASE_ADDR + 0x208)
> +#define     DIS_ORD_CHK				BIT(30)
>  
>  /* PCIe core controller registers */
>  #define CTRL_CORE_BASE_ADDR			0x18000
> @@ -558,6 +560,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  		PCIE_CORE_CTRL2_TD_ENABLE;
>  	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
>  
> +	/* Disable ordering checks, workaround for erratum 3.12 "PCIe completion timeout" */
> +	reg = advk_readl(pcie, DEBUG_MUX_CTRL_REG);
> +	reg |= DIS_ORD_CHK;
> +	advk_writel(pcie, reg, DEBUG_MUX_CTRL_REG);
> +
>  	/* Set lane X1 */
>  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
>  	reg &= ~LANE_CNT_MSK;
> @@ -1581,6 +1588,9 @@ static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
>  	struct advk_pcie *pcie = arg;
>  	u32 status;
>  
> +	/* Full memory barrier (ARM dsb sy), workaround for erratum 3.12 "PCIe completion timeout" */
> +	mb();
> +
>  	status = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
>  	if (!(status & PCIE_IRQ_CORE_INT))
>  		return IRQ_NONE;
> -- 
> 2.20.1
> 
