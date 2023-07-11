Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2310374F2CE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGKOy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 10:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGKOy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 10:54:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C331E5C;
        Tue, 11 Jul 2023 07:54:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so9229145e87.0;
        Tue, 11 Jul 2023 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689087293; x=1691679293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGlOt2o4Q8FcB3M3yiW6rTLz1+uV1iY2yTAo8ZK7p7Q=;
        b=q2y5LMjq7UPh5MomsYF+YZxA1DG9YdMGUbFV0hQSkL3R+VSwM98eZPUoy//uAw8H7J
         WdO5bGCHtGAjIx1FEXdRmYyFVNnLGiLuGzRVVtcoSBzz5LMYnX/dY3vPAUSJ7aB7W+ur
         MWmHEQleT0K8quajj21FqdpyzFxQuvbcLGXN0PdBT2KcPhrW4NpXURb1Mq1hbO6/lJqs
         m8FTLc+Sd6fq7iPfbGjpqz4Q9bAHCNeRXe9+JevFWcdgdEBegymxqLDI/OzNVtRC1A7Q
         0/3WSseqdUFkMep2nL8xwmBGf5R3HQd6cJO5f3B06iY5zUZSZ8ZbNUkPS4KP7N6SZrsw
         4YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689087293; x=1691679293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGlOt2o4Q8FcB3M3yiW6rTLz1+uV1iY2yTAo8ZK7p7Q=;
        b=JahW7U7J6U1MWn150Tnk0OAwdfNC1vKEB6a50xQJKJnwVVUZ+Dnfwhga5wsArPqpCj
         4guCCTHkGgrI5p7agYTem6ZpPm7kNWWJLUFE29uBvmfhtf4SSobwqqrR5TdcuczNPf4M
         TO9sIA/rzv+gOrJ0/PQpVe8AiwS9/eOwqRjuX4ebrTs/uFQDFEaafXg3VLhLqIkb8jGi
         wRvyRXGl5NXER3aHwk4cddKwFdWmnbRYjZLjxw3pDU/pNZn3KbFtx216jIixLpAwhO3/
         3RRhqOpttq9RJwBf5jksniO41O8pxRlsTTE8cS00y0U4Z5AD0YfqFfA+HVVvwbgTYL8U
         G8Qg==
X-Gm-Message-State: ABy/qLZtikugKySLK3hfWRFo3tVYy7CSO7PTe/os6HMmufOOepvoU+L4
        kP3dSl2/SnOXBFP9Zk+l/Js=
X-Google-Smtp-Source: APBJJlFTTvhc+SJ5FcDvEi9TJAR9GdLJr6xBTUK/PpCg9nPU3BIbOG6UzprSmHox6rnBDFLxE0389g==
X-Received: by 2002:a19:e059:0:b0:4f8:6d54:72f9 with SMTP id g25-20020a19e059000000b004f86d5472f9mr12251450lfj.61.1689087293391;
        Tue, 11 Jul 2023 07:54:53 -0700 (PDT)
Received: from mobilestation ([85.249.18.12])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b004fa5f4fd094sm349186lfe.266.2023.07.11.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:54:52 -0700 (PDT)
Date:   Tue, 11 Jul 2023 17:54:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17 05/20] PCI: dwc: Add outbound MSG TLPs support
Message-ID: <p6nfh7pxmtxboc5zkbojp7xryx46aezdkugykim4cjn7wfcixh@rj3wyxswzcmp>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-6-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-6-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 08:41:51PM +0900, Yoshihiro Shimoda wrote:
> Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for sending
> MSG by iATU in the PCIe endpoint mode in near the future.
> PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
> MsgD. So, this implementation supports the data-less messages only
> for now.

Looks good. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index e4ac1def7363..a531dc50abea 100644
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
> @@ -506,7 +506,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>  
> -	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> +	val = PCIE_ATU_ENABLE;
> +	if (atu->type == PCIE_ATU_TYPE_MSG) {
> +		/* The data-less messages only for now */
> +		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
> +	}
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
>  
>  	/*
>  	 * Make sure ATU enable takes effect before any subsequent config
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 85de0d8346fa..c626d21243b0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -147,11 +147,13 @@
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
>  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
>  #define PCIE_ATU_LOWER_BASE		0x008
>  #define PCIE_ATU_UPPER_BASE		0x00C
> @@ -292,6 +294,8 @@ struct dw_pcie_ob_atu_cfg {
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
