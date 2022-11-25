Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A962E6389BD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 13:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKYM1y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 07:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYM1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 07:27:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20801DDFB;
        Fri, 25 Nov 2022 04:27:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4C2CB82A92;
        Fri, 25 Nov 2022 12:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B504C433D6;
        Fri, 25 Nov 2022 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669379269;
        bh=PVmnxrUgHUfQVAVze+UCc6oLNX2A8iRf2P5L11tfoN8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZtGpgHJfPzraVTm7xpYBum+KkpJ5ZEY5ZfvYqxbeKXjclEHVuEjPPKJ+b7ZlM7adC
         5IiEbHqztwFnRAjYQmHerigmds9daLNuTpkNf//6+M1a+XszUjkOTZtykeIgsepRH+
         RIoJoMZsq+lEzehJ0Pc2CAkt+5YLlUL9U544tSyKr1Z8Y+dqo5S01/UrxOqAlBrS1T
         AoK13jv/9IYY3xqTduLI5SrqyAHxEbYyQdJCZ1hhWY/oa4kxJjDV1jObVor2s0YU5w
         dpy+dfZK1ZPvZU5WajvzwV0OpzTdNmpm/Pk1iH9lKSolD6G2qGesbpO15upwrh3+Dg
         i/oVc+nK/O0Kw==
Message-ID: <cd9051ca-9f79-31fc-870d-04dce5139ca9@kernel.org>
Date:   Fri, 25 Nov 2022 14:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 2/5] PCI: j721e: Add per platform maximum lane settings
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, vigneshr@ti.com,
        tjoseph@cadence.com, sergio.paracuellos@gmail.com,
        pthombar@cadence.com, linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221124081221.1206167-1-mranostay@ti.com>
 <20221124081221.1206167-3-mranostay@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221124081221.1206167-3-mranostay@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Matt,

On 24/11/2022 10:12, Matt Ranostay wrote:
> Various platforms have different maximum amount of lanes that can be
> selected. Add max_lanes to struct j721e_pcie to allow for detection of this
> which is needed to calculate the needed bitmask size for the possible lane
> count.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index cc83a8925ce0..8990f58d64d5 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -47,8 +47,6 @@ enum link_status {
>  
>  #define GENERATION_SEL_MASK		GENMASK(1, 0)
>  
> -#define MAX_LANES			2
> -
>  struct j721e_pcie {
>  	struct cdns_pcie	*cdns_pcie;
>  	struct clk		*refclk;
> @@ -71,6 +69,7 @@ struct j721e_pcie_data {
>  	unsigned int		quirk_disable_flr:1;
>  	u32			linkdown_irq_regfield;
>  	unsigned int		byte_access_allowed:1;
> +	unsigned int		max_lanes;
>  };
>  
>  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> @@ -290,11 +289,13 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
>  	.quirk_retrain_flag = true,
>  	.byte_access_allowed = false,
>  	.linkdown_irq_regfield = LINK_DOWN,
> +	.max_lanes = 2,
>  };
>  
>  static const struct j721e_pcie_data j721e_pcie_ep_data = {
>  	.mode = PCI_MODE_EP,
>  	.linkdown_irq_regfield = LINK_DOWN,
> +	.max_lanes = 2,
>  };
>  
>  static const struct j721e_pcie_data j7200_pcie_rc_data = {
> @@ -302,23 +303,27 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
>  	.quirk_detect_quiet_flag = true,
>  	.linkdown_irq_regfield = J7200_LINK_DOWN,
>  	.byte_access_allowed = true,
> +	.max_lanes = 2,
>  };
>  
>  static const struct j721e_pcie_data j7200_pcie_ep_data = {
>  	.mode = PCI_MODE_EP,
>  	.quirk_detect_quiet_flag = true,
>  	.quirk_disable_flr = true,
> +	.max_lanes = 2,
>  };
>  
>  static const struct j721e_pcie_data am64_pcie_rc_data = {
>  	.mode = PCI_MODE_RC,
>  	.linkdown_irq_regfield = J7200_LINK_DOWN,
>  	.byte_access_allowed = true,
> +	.max_lanes = 1,
>  };
>  
>  static const struct j721e_pcie_data am64_pcie_ep_data = {
>  	.mode = PCI_MODE_EP,
>  	.linkdown_irq_regfield = J7200_LINK_DOWN,
> +	.max_lanes = 1,
>  };
>  
>  static const struct of_device_id of_j721e_pcie_match[] = {
> @@ -432,7 +437,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	pcie->user_cfg_base = base;
>  
>  	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
> -	if (ret || num_lanes > MAX_LANES)
> +	if (ret || num_lanes > data->max_lanes)
>  		num_lanes = 1;

num_lanes = data->max_lanes; ?

Should we also print an error message saying that invalid num-lanes
was supplied in device tree?
Is it better to error out of probe?

>  	pcie->num_lanes = num_lanes;
>  

cheers,
-roger
