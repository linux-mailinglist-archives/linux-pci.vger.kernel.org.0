Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502296A0F4F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 19:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBWSQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 13:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBWSQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 13:16:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D464FCA7
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 10:16:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cq23so45119914edb.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 10:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAKmPlt3HMp+iJ3UA1PfQ0U1bsXsZD8PkIPjZhpTYVM=;
        b=jNQj2ONFVOd9bz28/6IO4uEAjhmzYt7iZqGM1zGHKkdXFSqnmLGmBch46/lr/YlIZx
         oesU1DyGRyV35d5NZTj9WbbtW52N8Z6iLsNwIES+3O+gbbrcot/muH7kTTg096S1lJ8S
         F3WTUlhx32NqgI4KNxSZerRsYGneCEQlIW24JK2dW/gT9fju+kNuzPpDLF8FmoWNz86+
         S/UYp1OmJZHuqeOWtaoqol13M9FtuTh+Han4/9jUoJvkFRhT6YkY/h3WYrRmp++X/Sre
         IupZV3nGvSlFZGmeyjgkQEOZ8r8zUdrfXJNE5sHTs5mk9Jyq+OAkfI+RabF90TVz+ZCe
         OJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAKmPlt3HMp+iJ3UA1PfQ0U1bsXsZD8PkIPjZhpTYVM=;
        b=z7s0mcvKxm+Fgwhi3O8SOfB/MfNAaW3z9aeeINSpAmDJB77gG7x6/awVbFTioLVi5y
         +yMSoQz/a45xJGrv/IZlCGPqYuBXckAMRwBKYPSEoHTX0oego2mFaG23sgKTu2JQH/OU
         8N1IJU7wFFxJ07x+HNlmQHFlwk8mabAv8bV6CdfNXDN1jOmAFfbFifxWOOIWc6N5TMSX
         ONrJ+4HDGw8/HPVDRmcGT02eHUKAH4SF+xb353ATd7fqGAU3VErqlsM4QIUzPBo2miiJ
         b9d2qYlIhvFLySU8SacCRW4Py3/+iTZFu8GTqYdZ0/JyXyPkTlFTb1CK3m2Y3KiZoTlC
         2Nsw==
X-Gm-Message-State: AO0yUKXSdj/Ky4AvWoL3wdbVt/OfISqTikr+RvmdkXvUm/aws294VRE+
        Dcal/Ioo2gm4gbFliy9omQbrnw==
X-Google-Smtp-Source: AK7set+nIoffNUvEtSh+I8BOqy3r0e6DE7CgCN2UQ4YNUI0vZLIdUYAxyNM1aElIr5tackiZW46CXA==
X-Received: by 2002:a17:906:8601:b0:89c:d072:e33e with SMTP id o1-20020a170906860100b0089cd072e33emr18515563ejx.49.1677176202399;
        Thu, 23 Feb 2023 10:16:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z26-20020a170906945a00b008b23b22b062sm8673148ejx.114.2023.02.23.10.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 10:16:42 -0800 (PST)
Message-ID: <ab160cc9-0a52-e448-9cc6-a7424c0cf560@linaro.org>
Date:   Thu, 23 Feb 2023 19:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 7/7] PCI: dwc: Introduce region limit from DT
Content-Language: en-US
To:     Elad Nachman <enachman@marvell.com>, thomas.petazzoni@bootlin.com,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230223180531.15148-1-enachman@marvell.com>
 <20230223180531.15148-8-enachman@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223180531.15148-8-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/02/2023 19:05, Elad Nachman wrote:
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
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 53a16b8b6ac2..429594e853ae 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -401,7 +401,6 @@ static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 dir, u32 index,
>  	int ret;
>  
>  	base = dw_pcie_select_atu(pci, dir, index);
> -
>  	if (pci->ops && pci->ops->write_dbi) {
>  		pci->ops->write_dbi(pci, base, reg, 4, val);
>  		return;
> @@ -735,10 +734,13 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
>  	int max_region, ob, ib;
> -	u32 val, min, dir;
> +	u32 val, min, dir, ret, num_region_maskbits;

No need to use num_region_maskbits in function scope.

>  	u64 max;
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
>  
>  	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
> +

You need to fix this random changes in unrelated places...

Best regards,
Krzysztof

