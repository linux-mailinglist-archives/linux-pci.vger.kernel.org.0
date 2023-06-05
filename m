Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB93F721B2A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 02:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjFEAQD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 20:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEAQC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 20:16:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD4CC;
        Sun,  4 Jun 2023 17:16:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5189446e87.3;
        Sun, 04 Jun 2023 17:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685924160; x=1688516160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzSjw8F20zkus7IMaZD3WdxXaK1UZ+BakPD8EiwsgME=;
        b=DqBsPEhWZ0Ie7WNBC1Fc0q3q7QrcsvgpEN8zbVGdasZ78OGSuUvTLHeohiNOaY7x0T
         S28MHx5OyvY+YxEUVEhGGcSJEn2XN+QPgjK612nshjsgj09VJnw8XKtKSDu1Qhq4pu+C
         iTpSPOB5Z2EX/f+4RdxebisJMo4xp8rQPKbB+hFLbdqTk4oqx2KEJkxP3NLXkKSMwNCa
         ehim9Bx1MIXNXXzQlLOF/iQj7rfjYPBHJy8gPvoP29zfcO5wIzuh23buHG51hoomw7wJ
         spiurDgM6+ZD4zAvcJJgEfcYe39qeEiE7rGir/8Trx4l0yawuwO18UfdgN9kMV4sFkkc
         /nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685924160; x=1688516160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzSjw8F20zkus7IMaZD3WdxXaK1UZ+BakPD8EiwsgME=;
        b=E7R6jzRBjnK+PO4M8N6bFLBi/UDsv3xjWqDW/WJsqhs7BBVZAWvNQCgYGgwm/+KZNF
         x7SLm92XTw356OK9OZAS+0Kuf7PNDI0bdLVEcc+nyVUVstiztx/hZ+xUCoVWAc0A3JO8
         lzZF+AjR7CUUZLxZiiG7vA9e8N5wpEsKTFsXwnatZUELPKPWsb/vFOraQvvyOm7cUVdZ
         FwAi/7hoiKvH9NVvVByAQchRSxm1cgcndQbSZ+iiBqBpXzaa5/lAVeVwU4gJ2OaUrF9J
         AwSODC+DRaDESQiKMdW3+TQEXylCV2nRLFAZiAPyuaPSy61IJl55T7RCEOpmmc9cokEr
         dh/w==
X-Gm-Message-State: AC+VfDxOYD/AM5ZtYN9RBK8atWa4tj3CmVY3C0lzLc1P8GkmKdvMUyRQ
        Or7n7BuKp5y7YrLfdpFtCzWKCbQJmT6UFw==
X-Google-Smtp-Source: ACHHUZ4GxGZYWsOWHWUHF7ycIxrCCivxtiW4n+GUBcMmWY2eJ+rub9zUy9nQTgaUCfMErm18nS4mEw==
X-Received: by 2002:ac2:5599:0:b0:4f3:b32d:f739 with SMTP id v25-20020ac25599000000b004f3b32df739mr3832900lfg.19.1685924159783;
        Sun, 04 Jun 2023 17:15:59 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id f5-20020a056512092500b004e843d6244csm919164lft.99.2023.06.04.17.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 17:15:59 -0700 (PDT)
Date:   Mon, 5 Jun 2023 03:15:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 07/22] PCI: dwc: Add outbound MSG TLPs support
Message-ID: <20230605001553.dqblit4jxyupee35@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-8-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-8-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:19PM +0900, Yoshihiro Shimoda wrote:
> Add "code" and "routing" into struct dw_pcie_outbound_atu for

structure name has been changed.

> sending MSG by iATU in the PCIe endpoint mode in near the future.
> PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
> MsgD.

So your implementation implies the data-less messages only. This note
should have been added at least to the commit log. Ideally it would be
useful to have an in-situ comment above the code setting these flags.

> PCIE_ATU_HEADER_SUB_ENABLE is set to issue the translated
> TLP header by using PCIE_ATU_{LOW,UPP}ER_TARGET registers' values.

Why is that needed? Please elaborate in the patch log.

Other than that the change looks good.

* I'll get back to the series review tomorrow.

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 5 +++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index bd85a73d354b..a7c724ba7385 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -498,7 +498,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
>  			      upper_32_bits(atu->pci_addr));
>  
> -	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> +	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
>  	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> @@ -506,7 +506,10 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>  
> -	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> +	val = PCIE_ATU_ENABLE;
> +	if (atu->type == PCIE_ATU_TYPE_MSG)
> +		val |= PCIE_ATU_INHIBIT_PAYLOAD | PCIE_ATU_HEADER_SUB_ENABLE | atu->code;
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
>  
>  	/*
>  	 * Make sure ATU enable takes effect before any subsequent config
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index b8fa099bbed3..c83d1d176e62 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -150,11 +150,14 @@
>  #define PCIE_ATU_TYPE_IO		0x2
>  #define PCIE_ATU_TYPE_CFG0		0x4
>  #define PCIE_ATU_TYPE_CFG1		0x5
> +#define PCIE_ATU_TYPE_MSG		0x10
>  #define PCIE_ATU_TD			BIT(8)
>  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
>  #define PCIE_ATU_REGION_CTRL2		0x004
>  #define PCIE_ATU_ENABLE			BIT(31)
>  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> +#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
> +#define PCIE_ATU_HEADER_SUB_ENABLE	BIT(21)
>  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
>  #define PCIE_ATU_LOWER_BASE		0x008
>  #define PCIE_ATU_UPPER_BASE		0x00C
> @@ -295,6 +298,8 @@ struct dw_pcie_ob_atu_cfg {
>  	int index;
>  	int type;
>  	u8 func_no;
> +	u8 code;
> +	u8 routing;
>  	u64 cpu_addr;
>  	u64 pci_addr;
>  	u64 size;
> -- 
> 2.25.1
> 
