Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0638624643
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 16:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKJPqd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 10:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiKJPqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 10:46:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D94F31231
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 07:46:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1376BB821FC
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 15:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E36AC433D6;
        Thu, 10 Nov 2022 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668095186;
        bh=8+ybaYZAUyINGuNsj7DH9SA7OaDsVF3+kjAbxxrzbwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFObpICzgxHrbiI23QIbQIxFbcwkqzzf+460dzMmU7oKyit2Zoy3yQWsvKeYBW8vL
         ybdco3UZaSFPxq+dleMn4rgk9GbwfQ0QjGazOlphdoIfgDewCYfb1uQs3xbNh0Kujk
         eDLl+FVX/22WM9qxdlToCDDm7Xz5wBInCLTfdXD5+Q8qQUlxZoMqqd86yu/yq3Beia
         VJgBDqh4GPTUEt7ff0+9sUICM1+CanCKfePnv/73SMqK4v4AWrGExzw2F9giAIC8Bx
         zIZHNmxTCt0Jyhjc6dfOqppHLlceyZzYaUX5gcbamHGVQ5K/sG0eovd8Qoi2tcsdZV
         qevBGuGVi++FQ==
Date:   Thu, 10 Nov 2022 16:46:21 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     vigneshr@ti.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/4] PCI: j721e: Add per platform maximum lane settings
Message-ID: <Y20czRFAkngbbC19@lpieralisi>
References: <20221109082556.29265-1-mranostay@ti.com>
 <20221109082556.29265-2-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109082556.29265-2-mranostay@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 09, 2022 at 12:25:53AM -0800, Matt Ranostay wrote:
> Various platforms have different maximum amount of lanes that
> can be selected. Add max_lanes to struct j721e_pcie to allow
> for error checking on num-lanes selection from device tree.

https://lore.kernel.org/linux-pci/CAL_JsqJ5cOLXhD-73esmhVwMEWGT+w3SJC14Z0jY4tQJQRA7iw@mail.gmail.com

Why have you reposted this patch ?

Lorenzo

> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index a82f845cc4b5..875224d34958 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -48,8 +48,6 @@ enum link_status {
>  
>  #define GENERATION_SEL_MASK		GENMASK(1, 0)
>  
> -#define MAX_LANES			2
> -
>  struct j721e_pcie {
>  	struct cdns_pcie	*cdns_pcie;
>  	struct clk		*refclk;
> @@ -72,6 +70,7 @@ struct j721e_pcie_data {
>  	unsigned int		quirk_disable_flr:1;
>  	u32			linkdown_irq_regfield;
>  	unsigned int		byte_access_allowed:1;
> +	unsigned int		max_lanes;
>  };
>  
>  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> @@ -291,11 +290,13 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
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
> @@ -303,23 +304,27 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
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
> @@ -433,7 +438,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	pcie->user_cfg_base = base;
>  
>  	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
> -	if (ret || num_lanes > MAX_LANES)
> +	if (ret || num_lanes > data->max_lanes)
>  		num_lanes = 1;
>  	pcie->num_lanes = num_lanes;
>  
> -- 
> 2.38.GIT
> 
