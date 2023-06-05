Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB0D72245D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjFELPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 07:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjFELPy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 07:15:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4CAB8;
        Mon,  5 Jun 2023 04:15:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso2236144e87.0;
        Mon, 05 Jun 2023 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685963744; x=1688555744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipUAqk5N5TaomtE4YOav9jh5920OM/6bRcdglUb8rJY=;
        b=ZfCISteK0Ys2VDeuZm/CRKcvpV/XKeCHnKVXvNHO+vAqt3l4bRRznMv3fHqT66FuVK
         5JdE0hWyccgIls/Kxi7xgEiwrxHqz3i+Jv5Yx/Gc3eWIRP6aw6zdTHvaMXwHSqbwzcPq
         Exyr5wU4tvlCqXN3er0/2mf8p96oQc93SfRoTE/B/ePG1tepag3byYcYsjbZFrkD1WqZ
         arsjoGUqCllqSiekTV7NKgqh3+xJ1ekWZEhbMksF5D5daGQ0n65x0gEVfhzi0l/QIMEi
         q7cxGjFTMOJNv1XJTj+pMlpWMlfTLvpufeyU7r0NC1WjezEFiZOzF7Ok5MxubB43Csuf
         ppxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963744; x=1688555744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipUAqk5N5TaomtE4YOav9jh5920OM/6bRcdglUb8rJY=;
        b=BTGP/Wp/VRbDdhDuWOxcwWJkH8savPMb5nA/4dkg1MbbTwOa1H1cW3sh4TeH4KhXPC
         r8Om3J7S76szKQunVFi+RWKesddph1voSQeDs1oRQeJLidP0PGLPAl2VQAnWyqemGrS+
         /0aczikAYYyy87b3dC4y45NxolsDrxVnwL2XcStjHZLkoC0cjoxM9wqWfJb4RtwZhhNp
         eq0b4IsigWbOg8DnDjcwtf1ybbcr9pFHK5enncLEA3V2Ny+YbM1vxXBAFv7y6TiUJqvR
         iQGzmIxwn3+/rap4aRlz3JtJAXNGgBdd8QZDq7EGNCO0yszIzi9KiBPUmvCPNuDuwJgo
         6NgA==
X-Gm-Message-State: AC+VfDzSKHtVt5JHSiE1VuFaX3qyMwALGzvBjQ4c4knQm5OMNFSy119k
        kx8tnzq9aaAYH7I+H123V2M=
X-Google-Smtp-Source: ACHHUZ6vFSdacuvwRlJ8e+cnVGLfUTu6uwhfOSJIv7sLPBeFOfPkBbowH5QmVdUtDjrBudDzyvCT6w==
X-Received: by 2002:a19:ee0e:0:b0:4f3:b61a:a941 with SMTP id g14-20020a19ee0e000000b004f3b61aa941mr4746615lfb.51.1685963744230;
        Mon, 05 Jun 2023 04:15:44 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id u14-20020ac2518e000000b004f11eb32f20sm1094805lfi.13.2023.06.05.04.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:15:43 -0700 (PDT)
Date:   Mon, 5 Jun 2023 14:15:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 13/22] PCI: dwc: Add EDMA_UNROLL capability flag
Message-ID: <20230605111541.sup6ebomse75iae2@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-14-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-14-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:25PM +0900, Yoshihiro Shimoda wrote:
> Renesas R-Car Gen4 PCIe controllers have an unexpected register value on
> the dbi+0x97b register. So, add a new capability flag "EDMA_UNROLL"
> which would force the unrolled eDMA mapping for the problematic
> device, 

> as suggested by Serge Semin.

Drop this. Suggested-by tag already means that.

> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
>  drivers/pci/controller/dwc/pcie-designware.h | 5 +++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 8b2978c6eb23..e405bfae0191 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -881,8 +881,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
>  	 * thus no space is now reserved for the eDMA channels viewport and
>  	 * former DMA CTRL register is no longer fixed to FFs.
> +	 *
> +	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason

> +	 * may have zeros in the eDMA CTRL register even though the HW-manual

s/may have/have
(your comment is about a particular device which for sure has the
denoted problem.)

Other than that the change looks good. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> +	 * explicitly states there must FFs if the unrolled mapping is enabled.
> +	 * For such cases the low-level drivers are supposed to manually
> +	 * activate the unrolled mapping to bypass the auto-detection procedure.
>  	 */
> -	if (dw_pcie_ver_is_ge(pci, 540A))
> +	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
>  		val = 0xFFFFFFFF;
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 06e044e2163a..2639206b4c18 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -54,8 +54,9 @@
>  
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> -#define DW_PCIE_CAP_IATU_UNROLL		1
> -#define DW_PCIE_CAP_CDM_CHECK		2
> +#define DW_PCIE_CAP_EDMA_UNROLL		1
> +#define DW_PCIE_CAP_IATU_UNROLL		2
> +#define DW_PCIE_CAP_CDM_CHECK		3
>  
>  #define dw_pcie_cap_is(_pci, _cap) \
>  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> -- 
> 2.25.1
> 
