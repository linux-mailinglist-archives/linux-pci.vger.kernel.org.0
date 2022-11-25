Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20566389D3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 13:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKYMc5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 07:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKYMc5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 07:32:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0F6186FE;
        Fri, 25 Nov 2022 04:32:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C39E7623B1;
        Fri, 25 Nov 2022 12:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A3DC433D6;
        Fri, 25 Nov 2022 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669379575;
        bh=p7ss/fqibxOK0PX8EdO8U+TTo07V8zCu5SpOcHojgAA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qdi5lDv2Jtp8LCdCcgMfP5C4RRZxR57BJfgLSOyiEnHVpRDME342qmcYoL6eAF7G7
         b4WKDJVKVgPaib2FJSPdZx2FRe+sDMG6W7JxggOXaP2UtZwMn7ZOjmGrMji5O2UrAu
         +EKQJ+ywNrW7vCo9rJE9J0RRIbAGEJVDDOCTwJreYZXUAF5rVl3EGb72QWqQ4cQ52X
         Xjjc0hH+1knU92nBAC0hPVMzAYNK7Cl9+ciX+yMRnJ1AU8wRBxtjxe3/bX2myovB4a
         Xcohx33ZtmFbxAgnAPKlAqKy2gcphnH0tLvDDJVtjLwzHBbDJh9NEy0JAfILoNYPIS
         9A6Gty8kU70GA==
Message-ID: <e0f4d411-2345-a13e-b7e1-fd4a5622f701@kernel.org>
Date:   Fri, 25 Nov 2022 14:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 5/5] PCI: j721e: add j784s4 PCIe configuration
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, vigneshr@ti.com,
        tjoseph@cadence.com, sergio.paracuellos@gmail.com,
        pthombar@cadence.com, linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Achal Verma <a-verma1@ti.com>
References: <20221124081221.1206167-1-mranostay@ti.com>
 <20221124081221.1206167-6-mranostay@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221124081221.1206167-6-mranostay@ti.com>
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



On 24/11/2022 10:12, Matt Ranostay wrote:
> Add PCIe configuration for j784s4 platform which has 4x lane support.
> 
> Tested-by: Achal Verma <a-verma1@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index dab3db9be6d8..c484d658c18a 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -330,6 +330,21 @@ static const struct j721e_pcie_data am64_pcie_ep_data = {
>  	.max_lanes = 1,
>  };
>  
> +static const struct j721e_pcie_data j784s4_pcie_rc_data = {
> +	.mode = PCI_MODE_RC,
> +	.quirk_retrain_flag = true,
> +	.is_intc_v1 = true,
> +	.byte_access_allowed = false,
> +	.linkdown_irq_regfield = LINK_DOWN,
> +	.max_lanes = 4,
> +};
> +
> +static const struct j721e_pcie_data j784s4_pcie_ep_data = {
> +	.mode = PCI_MODE_EP,
> +	.linkdown_irq_regfield = LINK_DOWN,
> +	.max_lanes = 4,
> +};
> +
>  static const struct of_device_id of_j721e_pcie_match[] = {
>  	{
>  		.compatible = "ti,j721e-pcie-host",
> @@ -355,6 +370,14 @@ static const struct of_device_id of_j721e_pcie_match[] = {
>  		.compatible = "ti,am64-pcie-ep",
>  		.data = &am64_pcie_ep_data,
>  	},
> +	{
> +		.compatible = "ti,j784s4-pcie-host",
> +		.data = &j784s4_pcie_rc_data,
> +	},
> +	{
> +		.compatible = "ti,j784s4-pcie-ep",
> +		.data = &j784s4_pcie_ep_data,
> +	},
>  	{},
>  };
>  

--
cheers,
-roger
