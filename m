Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101C45ACE0D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbiIEIks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 04:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiIEIkZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 04:40:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824311403F;
        Mon,  5 Sep 2022 01:39:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w8so12059806lft.12;
        Mon, 05 Sep 2022 01:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=whKQuPxuNlc3vZdhtpMpbA8dF2eoaMeKKG4hpG8oBcM=;
        b=G3VyjQclSxs/IijXYJTaubBQO3bYU0PLLCLmzT9wsXJuSGO8umrikYnfY6h7sWlpoi
         87UGTNZVb5lDWS1Rkt6yKDAIeQtZOBE2UDjLXrVPK61z/GhZmU6K+wpLpfEahtKGUfHE
         Ga+4eeyBRi1e9exxEuEpgXhxUalJIyGOSpybP3q3w/MLP3zyUr87dauIuUamGZeQ6N/Y
         UoySAI8ljjQp7oPW2zRNOl0xkiUohsBZRO7xrEb7EdFyR7ME+DvX6usutFojdOt3mXvv
         M8vFvJYL8MM7PmHspB/f+Vc844hhmJMG22dgEbTXt9kiByh/+rywjv5EihWm6HQCdMEw
         0BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=whKQuPxuNlc3vZdhtpMpbA8dF2eoaMeKKG4hpG8oBcM=;
        b=yqamm/OX9IXe4pFdl1IJT7F0b+Z+RCyQ5ZH2RyPeMgfhnMdloTX/mf9gfSo665ZJNq
         CbyXvyme/crIl6+etO4F22AkTXidqqcCNpR9J4dHqlXu9UxKKAN3T7KI13hzTh1WBJzK
         D4U5oxkjQyTnafsbr7TyMxRsLnwOgrmMuO0WKKIGQ6E14mmzF/Cj72dmuakQvYkS6Idu
         wQc8j/hMomFSdQdFiqOLJXoURGd1qfjlrNsLBhViYvFGD9I5tnXR06/EJbdBSF8QlDTv
         NchOw6+TH31eSbY1o7r9ismhameuUzCnbzjvSUpKhhXKerqUexFvNqmN61OSMVM4oHX8
         du7Q==
X-Gm-Message-State: ACgBeo2HsMiLoAEB0daD2wupNxIwQ3VAUw6qZkxh784p+75TuP5xckDE
        owwqWx6gu9s8knzKYfJNYSpoxh0J5L4=
X-Google-Smtp-Source: AA6agR44ycbYeXR5cUT1iKr474kunWwJe7pC1Y1qR9XbJ6baC6OvIaai0+Y7yHNf+033tIXO/pB2Yw==
X-Received: by 2002:a05:6512:304c:b0:494:8cd2:73bb with SMTP id b12-20020a056512304c00b004948cd273bbmr7270274lfb.207.1662367182157;
        Mon, 05 Sep 2022 01:39:42 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.80.58])
        by smtp.gmail.com with ESMTPSA id 25-20020ac25f59000000b004946a38be45sm1124636lfz.50.2022.09.05.01.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:39:41 -0700 (PDT)
Subject: Re: [PATCH v5 07/12] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20220905071257.1059436-1-yoshihiro.shimoda.uh@renesas.com>
 <20220905071257.1059436-8-yoshihiro.shimoda.uh@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e615a35a-c052-aeff-8cfd-3efae677d48a@gmail.com>
Date:   Mon, 5 Sep 2022 11:39:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220905071257.1059436-8-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 9/5/22 10:12 AM, Yoshihiro Shimoda wrote:

> Since reading value of PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL was
> 0x00000000 on one of SoCs (R-Car S4-8), it cannot find the eDMA.
> So, directly read the eDMA register if edma.red_base is not zero.

   s/red/reg/?

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 72f9620a374d..08f91a6bbe4b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -844,8 +844,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> -	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> +	if (pci->edma.reg_base) {
>  		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
>  
>  		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
[...]

MBR, Sergey
