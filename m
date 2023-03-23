Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADCF6C5B41
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 01:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCWAMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 20:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCWAM0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 20:12:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F80434F4D;
        Wed, 22 Mar 2023 17:11:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j11so25583982lfg.13;
        Wed, 22 Mar 2023 17:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679530309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nYCkHAsN3JrF68S01DrynayfL1Jyb7WCod+z/Y3H2No=;
        b=UReGMPhbM2n9pWALFzS1ncK2UDdmdcBDjv/VT2DMUe6/7gh85hvxWUuv7VNGDdxUkw
         bwWVoGbj9DofIhFE5Oi4/LRu2cQsrvXYmhqrT4t1v3UIU57DtU4kCLRXH5VQ5Or2Mj8H
         9scxNqBrU17PRtN67nR5XOVdOnwgP8twk1WHnnKYiupozmblhhRK0M8B8uKSIo+NqYqb
         8pty7I8ttBkVKGNix0CJ1YtUEkO0W4aO2asoYHfISz0a/hvrcT1siikRVU7arTi8ycI0
         DZuEHJNwNLBELo0bTTYlYdI94mjET6TVPuHvD3md2OtjchjDszjTEMjUVKkdu/bLPYQV
         Zclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679530309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYCkHAsN3JrF68S01DrynayfL1Jyb7WCod+z/Y3H2No=;
        b=bLc3ziV5pLt5g48FfDcuEZTvFSI9vWnyGiyFsfz1vF4ttT0k7xe69asikzN7v4wkHM
         g0j9wbeuTTHyossctAo7rPq66/K1eJ+9LdZ6B/CUU9QmSyCTjZe5M0n1cWH5auEhjXSh
         AuR4rX2T7zvC58K7Sbq+YyizKqvg5BPoH17ur5DPw+6bH5ZAzw+jQRXcnJFfhACt/TXs
         EdkF/A8me07WNVA0MjT1eYbi1Q6lV0QUqWAMB2c1m8ij+0eQMaHnDVGquVlQ+QjCzY0H
         oZ3jS2A2SPZUP5OCyMq6w6yzODr5KwHI5zeHdN4Iqibk8hi4Uh0X1QvEyZ2oWEMfh7Gv
         2drQ==
X-Gm-Message-State: AO0yUKWKVh/G5uiuAqrST1WErgBPB50jscp0Z2UEvvBkZrU/z7BSmeN6
        DgGn9o3FHjgGiuRP7bsKSj0=
X-Google-Smtp-Source: AKy350bDuYFrnVk394IZKDlUf38O/h63IIdgWnxEF5JXKF4nDJRgmGsB2j8L2Iqx3XraDJb6ZG1suQ==
X-Received: by 2002:a19:ee13:0:b0:4dd:9e4a:4c3b with SMTP id g19-20020a19ee13000000b004dd9e4a4c3bmr2545136lfb.17.1679530308868;
        Wed, 22 Mar 2023 17:11:48 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id o15-20020ac2434f000000b004dd6c325311sm2747359lfl.248.2023.03.22.17.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:11:48 -0700 (PDT)
Date:   Thu, 23 Mar 2023 03:11:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] PCI: dwc: Introduce region limit from DT
Message-ID: <20230323001146.xbqbav2fu2qelsub@mobilestation>
References: <20230313124016.17102-1-enachman@marvell.com>
 <20230313124016.17102-9-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124016.17102-9-enachman@marvell.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 13, 2023 at 02:40:16PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Allow dts override of region limit for SOCs with older Synopsis
> Designware PCIe IP but with greater than 32-bit address range support,
> such as the Armada 7020/7040/8040 family of SOCs by Marvell,
> when the DT file places the PCIe window above the 4GB region.
> The Synopsis Designware PCIe IP in these SOCs is too old to specify the
> highest memory location supported by the PCIe, but practically supports
> such locations. Allow these locations to be specified in the DT file.
> DT property is called num-regionmask , and can range between 33 and 64.

The implemented algorithm doesn't prevents you from specifying the
outbound MW base above 4GB. It prevents you from overflowing the limit
address which is of the 32-bits width only for the chips older v4.60a
and if the INCREASE_REGION_SIZE IP-core synthesize parameter is set to
zero.

In other words you must make sure that dma-ranges/ranges entries size
when combined with the source address doesn't cause the limit address
overflow (4GB boundary cross in your case). For instance, you want to
map 0x1F0000000 CPU-address region of 512MB size to 0x0 PCIe address. In
that case you'd specify the ranges property like this:
< ranges = <0x82000000 0 0 0x1 0xf0000000 0 0x20000000>;
The CPU-base address is ok since iATU always supports 64-bit base
addresses. But after you add 0x20000000 to 0x1f0000000 you'll get the
4GB boundary overflow (0x210000000) which can't be described with the
32-bit limit address CSR. In this particular case the maximum range
size you can specify is 0x10000000 (256MB).

Anyway judging by the patch content you do nothing but hacking the
ranges entries sanity check procedure which I don't think is a good
thing to do.

-Serge(y)

> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
> v4:
>    1) Fix blank lines removal / addition
> 
>    2) Remove usage of variable with same name as dt binding property
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 53a16b8b6ac2..9773c110c733 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -735,8 +735,10 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
>  	int max_region, ob, ib;
> -	u32 val, min, dir;
> +	u32 val, min, dir, ret;
>  	u64 max;
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
>  
>  	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
>  	if (val == 0xFFFFFFFF) {
> @@ -781,7 +783,13 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  		dw_pcie_writel_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT, 0xFFFFFFFF);
>  		max = dw_pcie_readl_atu(pci, dir, 0, PCIE_ATU_UPPER_LIMIT);
>  	} else {
> -		max = 0;
> +		/* Allow dts override of region limit for older IP with above 32-bit support: */
> +		ret = of_property_read_u32(np, "num-regionmask", &val);
> +		if (!ret && val > 32) {
> +			max = GENMASK(val - 33, 0);
> +			dev_info(pci->dev, "Overriding region limit to %u bits\n", val);
> +		} else
> +			max = 0;
>  	}
>  
>  	pci->num_ob_windows = ob;
> -- 
> 2.17.1
> 
> 
