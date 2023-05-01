Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18A6F3688
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 21:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjEATOh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 15:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjEATOg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 15:14:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDBD10E9;
        Mon,  1 May 2023 12:14:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so3463302e87.1;
        Mon, 01 May 2023 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682968473; x=1685560473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sF7Ad8V7RYhDTeqP/f4uSTUoSqT+uX5qErkhAZbEf80=;
        b=h899vYfEL8srQj+dWnmiLoKQKaaLb98FV9NwU5xYSEL3UOHnHPDVhi/rxW3S3YXrCn
         AlXZRNF7iJ1zOaSVL4O2fHn/5hz/Imxj9AsI4B7gCFa8pF6ay54CbS4ymiuny9ToNWrd
         gzUCEoB6st0UMTL/bIoOOfyMw5VIJB9HeeaTMbTb4Eiow144EuMUvieziRutSRSdZ6qU
         xosfFyjXejLQiKH1PLtbnT8bioD3ATa3JbZ4yjPpr3pqF2AeJj2sv8vR4zljFqhxisfN
         XQH24r4MCOu1Q1u7jXd1OSlXzHKPLmeknjPwXjCRFjlYo/oCisU+jshKUkcxgDv6QMry
         BMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682968473; x=1685560473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sF7Ad8V7RYhDTeqP/f4uSTUoSqT+uX5qErkhAZbEf80=;
        b=Ll+mxengGta05eK5fOiVaaTUJPgo20x/q5UNBPI+4jxZkZ7VbpLEYzt9GOKawscSOO
         UuvBpDOZZuX2TPFRGxjK5P31u+ByNlH0Eu7ar8eQ8rLBi0tJMkkL7UZR0wzWU1n3FK0V
         ZwsbG3z8Z97ysh0bYntuHRSaX+Rc14IQ4JiWXcohD9boIZIOI9l8JMyVFilKBGbFfTKo
         cnFIpsfiSBpeGJeSXWwtp5rXYEETky6Z2xTkQEr4asGWDwrjANmDlQr6Nk/TzYCD1rrs
         UziMwWuEzJdPYnV4kdNY7XF5W5N0A/anAvqfU0XF0+kyjhwIuA4YholL9T1Q/rmEwVKH
         Oksw==
X-Gm-Message-State: AC+VfDzoSfUIuVgL6vjhqzkltYbGh28MZ5O1GPLBlD+LO0WaKNtiyQRp
        H+JpApMkvf25U6vYFFFB2W0=
X-Google-Smtp-Source: ACHHUZ6yLwSgIV1R/rHv9+cufQO26dDGQhy7kW+wUgYk/oYnaPw8XAn6K/UMvj7goiFSmOV+5K93Cg==
X-Received: by 2002:ac2:47e1:0:b0:4eb:79:fa5 with SMTP id b1-20020ac247e1000000b004eb00790fa5mr3878649lfp.25.1682968472822;
        Mon, 01 May 2023 12:14:32 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id q5-20020ac25105000000b004f01ae1e63esm1548371lfb.272.2023.05.01.12.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:14:32 -0700 (PDT)
Date:   Mon, 1 May 2023 22:14:30 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v14 07/21] PCI: dwc: Add members into struct
 dw_pcie_outbound_atu
Message-ID: <20230501191430.l3ao4ldwlyaidol4@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-8-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-8-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:43PM +0900, Yoshihiro Shimoda wrote:
> Add "code" and "routing" into struct dw_pcie_outbound_atu for
> sending MSG by iATU in the PCIe endpoint mode in near the future.

[PATCH v14 07/21] PCI: dwc: Add members into struct dw_pcie_outbound_atu

what about the next subject:
"PCI: dwc: Add "code" and "routing" outbound iATU settings"
or a more generic version:
"PCI: dwc: Add outbound MSG TLPs support"
?

It would have been also nice to explain in the patch log (or/and in
the code) why the "PCIE_ATU_INHIBIT_PAYLOAD" and
"PCIE_ATU_HEADER_SUB_ENABLE" flags are required to be set.

Other than that the change looks good.

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 5 +++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 782c4b34d0a3..e8d4d5bde2d3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -497,7 +497,7 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
>  			      upper_32_bits(atu->pci_addr));
>  
> -	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> +	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(atu->cpu_addr) &&
>  	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> @@ -505,7 +505,10 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
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
> index 81c7558a4718..954d504890a1 100644
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
> @@ -298,6 +301,8 @@ struct dw_pcie_outbound_atu {
>  	int index;
>  	int type;
>  	u8 func_no;
> +	u8 code;
> +	u8 routing;
>  };
>  
>  struct dw_pcie_host_ops {
> -- 
> 2.25.1
> 
