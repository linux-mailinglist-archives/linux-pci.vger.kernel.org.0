Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52227D8F4B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjJ0HLu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 03:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjJ0HLs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 03:11:48 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AA71AA
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 00:11:38 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231027071134epoutp0117111cf39278fedd867246cbe07657b0~R5VaW0pkm0792907929epoutp01L
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 07:11:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231027071134epoutp0117111cf39278fedd867246cbe07657b0~R5VaW0pkm0792907929epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698390694;
        bh=7JjQM+jXPDeAWO7cnPKWg+z9w0uX9M70ogat1wp9lHM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oTlhOw6TdnYoICFMwsaGzKJXAcCSV1FpxSD29bFW1wTYu4Fxqini0WZGGu2tTr3bL
         FumJRvtO0a8aTGx/sYYxIaPzv241OLpBy4J5iBsEstQ2SBqijyT8Eyb+H7xuhGFRz7
         gKpPXVB7UueeHgcJXHVLKAUlSJJ5r/PhXs0XDxC8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231027071134epcas5p10e019c8c875964a5a68a037eb9015edc~R5VZ2NHLh2311123111epcas5p1l;
        Fri, 27 Oct 2023 07:11:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SGv3S5ngGz4x9Pp; Fri, 27 Oct
        2023 07:11:32 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.10.10009.4A26B356; Fri, 27 Oct 2023 16:11:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231027063600epcas5p1782ac9604b0c5e097ab4a45da97e2a97~R42WgbpHa1097210972epcas5p17;
        Fri, 27 Oct 2023 06:36:00 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231027063600epsmtrp1c92ad008fdaa6b67c52a8afe403e98ff~R42WfmAUi0051100511epsmtrp1S;
        Fri, 27 Oct 2023 06:36:00 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-0f-653b62a4b60a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.FE.07368.F4A5B356; Fri, 27 Oct 2023 15:35:59 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231027063558epsmtip2446f8bd111b513bd2731176edf779cc2~R42UyOiV13177531775epsmtip2u;
        Fri, 27 Oct 2023 06:35:58 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     <jingoohan1@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>
Cc:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pankaj.dubey@samsung.com>
In-Reply-To: <20231009062052.5407-1-shradha.t@samsung.com>
Subject: RE: [PATCH] PCI: exynos: Change macro names to exynos specific
Date:   Fri, 27 Oct 2023 12:05:56 +0530
Message-ID: <0b4701da089f$d930d790$8b9286b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHePu0kvTSN+lKzECkL49kYbCkH+ALSVT9ssD4uoUA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmhu6SJOtUg+N/dSwezNvGZrGkKcNi
        xZeZ7BZ7X29lt2jo+c1qsenxNVaLy7vmsFmcnXeczWLG+X1MFi1/WlgsFm39wm7xf88Odgce
        j52z7rJ7LNhU6rFpVSebx51re9g8nlyZzuSxeUm9R9+WVYwenzfJBXBEZdtkpCampBYppOYl
        56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2qpFCWmFMKFApILC5W0rez
        KcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOeNx/haVgj2vFmVef
        GRsYp1p3MXJySAiYSGy+tZANxBYS2M0o8WGSZhcjF5D9iVHiy79LLBDON0aJg4tuM8F0TNxx
        kRUisZdR4tK252wQzgtGidbuFcwgVWwCOhJPrvxhBkmICKxjlDj2p5MdJMEssIZRYnJ3FIjN
        KWAlsWfpdkYQW1jAXeL/hY9gzSwCqhK3V99mBbF5BSwlWvd3MUPYghInZz5hgZgjL7H97Rxm
        iJMUJH4+XQZUzwG0zEqidXkhRIm4xNGfPWA3SAic4ZC4tH0rC0S9i8Sa2f+h3hGWeHV8CzuE
        LSXxsr8Nyk6XWLl5BtT8HIlvm5dA1dtLHLgyhwVkF7OApsT6XfoQYVmJqafWMUHs5ZPo/f0E
        qpxXYsc8GFtZ4svfPVAnSErMO3aZdQKj0iwkn81C8tksJC/MQti2gJFlFaNkakFxbnpqsWmB
        UV5qOTzCk/NzNzGCk7KW1w7Ghw8+6B1iZOJgPMQowcGsJMIb6WORKsSbklhZlVqUH19UmpNa
        fIjRFBjcE5mlRJPzgXkhryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKYPiYO
        TqkGppjk5scXTcvLs4za3kYHzDghLit9po/xw4aF0Y9LWXfmSix0+K/9MM87oXLmuYTvkg77
        n6yU+96h1XeuPPVsw9x1pw+euhsU05Xd9rRpz4qjFe9b/vj4u6zjeeffInOtcm9yfNXx0nsW
        z/eznJfV3bWuov+XisepqbsDrcK+uhdL3V7yM+1IMq9ZklqN1oviVz/+3O2dVvrsw7RFb35M
        POK2+HH2xNcL5n0867T6+6H5v1+Wdc96sftOwfdSK2O+7gaHo3dyo28L/pmvKfUzzWbKgbPN
        sTvl3zmfuixjsaXiC/ukOYwvxbvyXtbUcs1yT82ZvPRN1sK9r18Leb45peQ909iAw1dJ96+D
        3S1jM3klluKMREMt5qLiRACMdazuUwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvK5/lHWqweI5NhYP5m1js1jSlGGx
        4stMdou9r7eyWzT0/Ga12PT4GqvF5V1z2CzOzjvOZjHj/D4mi5Y/LSwWi7Z+Ybf4v2cHuwOP
        x85Zd9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo2/LKkaPz5vkAjiiuGxSUnMyy1KL9O0S
        uDIe919hKdjjWnHm1WfGBsap1l2MnBwSAiYSE3dcZAWxhQR2M0pMflcLEZeU+HxxHROELSyx
        8t9z9i5GLqCaZ4wS345OZQFJsAnoSDy58ocZJCEisI1RYnZLL1iCWWADo8S2A3kQHd2MEo1b
        14Ct4BSwktizdDsjiC0s4C7x/8JHZhCbRUBV4vbq22A1vAKWEq37u5ghbEGJkzOfQA3Vluh9
        2MoIYctLbH87hxniPAWJn0+XAfVyAF1hJdG6vBCiRFzi6M8e5gmMwrOQTJqFZNIsJJNmIWlZ
        wMiyilEytaA4Nz032bDAMC+1XK84Mbe4NC9dLzk/dxMjODK1NHYw3pv/T+8QIxMH4yFGCQ5m
        JRHeSB+LVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8hjNmpwgJpCeWpGanphakFsFkmTg4pRqY
        Vk5jkHtU9P7AuYNZSx5Xs35xeLT78eIL+0QfJjzkLWt+KXcx6cwjntV/InUnt6mYr1geO2Nn
        7BvuO0fyjS7Gdfupr+ZpCdTLyeD27DIK+K0XvtJi5brI/imaP3v3p71/K1UuKBwyqX1etIlT
        V1G54Enevb4Hip+JfLx7lbvo/LQGZYErSq9PCd+L0fT3Y87Z/W578Ndmn9c7hcs0VK8/VpGu
        mX3+1fZvn9ct9F9nEO917O2dA6uVXdjKj7Zf3dPoUs++k/FDvdIvKW+Zc8lT5ecu5p307MCl
        Y7y8vafLlSpXOZkkFMn8nT2vh31+p9/TIw2y2yb2p35eeX+CrmI50/59pVc/HFOWkSjNnZOx
        UomlOCPRUIu5qDgRAHvCJvE7AwAA
X-CMS-MailID: 20231027063600epcas5p1782ac9604b0c5e097ab4a45da97e2a97
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231009062058epcas5p4dc1fb50210c920137ac906b0bdf99e1b
References: <CGME20231009062058epcas5p4dc1fb50210c920137ac906b0bdf99e1b@epcas5p4.samsung.com>
        <20231009062052.5407-1-shradha.t@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gentle reminder to review this patch. Thanks in advance!

> -----Original Message-----
> From: Shradha Todi [mailto:shradha.t@samsung.com]
> Sent: 09 October 2023 11:51
> To: jingoohan1@gmail.com; lpieralisi@kernel.org; kw@linux.com;
> robh@kernel.org; bhelgaas@google.com; krzysztof.kozlowski@linaro.org;
> alim.akhtar@samsung.com
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org;
> pankaj.dubey@samsung.com; Shradha Todi <shradha.t@samsung.com>
> Subject: [PATCH] PCI: exynos: Change macro names to exynos specific
> 
> Prefix macro names in exynos file with the term "EXYNOS" as the current
> macro names seem to be generic to PCIe.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 116 ++++++++++++------------
>  1 file changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> b/drivers/pci/controller/dwc/pci-exynos.c
> index 6319082301d6..9e42cfcd99cc 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -26,30 +26,30 @@
>  #define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
> 
>  /* PCIe ELBI registers */
> -#define PCIE_IRQ_PULSE			0x000
> -#define IRQ_INTA_ASSERT			BIT(0)
> -#define IRQ_INTB_ASSERT			BIT(2)
> -#define IRQ_INTC_ASSERT			BIT(4)
> -#define IRQ_INTD_ASSERT			BIT(6)
> -#define PCIE_IRQ_LEVEL			0x004
> -#define PCIE_IRQ_SPECIAL		0x008
> -#define PCIE_IRQ_EN_PULSE		0x00c
> -#define PCIE_IRQ_EN_LEVEL		0x010
> -#define PCIE_IRQ_EN_SPECIAL		0x014
> -#define PCIE_SW_WAKE			0x018
> -#define PCIE_BUS_EN			BIT(1)
> -#define PCIE_CORE_RESET			0x01c
> -#define PCIE_CORE_RESET_ENABLE		BIT(0)
> -#define PCIE_STICKY_RESET		0x020
> -#define PCIE_NONSTICKY_RESET		0x024
> -#define PCIE_APP_INIT_RESET		0x028
> -#define PCIE_APP_LTSSM_ENABLE		0x02c
> -#define PCIE_ELBI_RDLH_LINKUP		0x074
> -#define PCIE_ELBI_XMLH_LINKUP		BIT(4)
> -#define PCIE_ELBI_LTSSM_ENABLE		0x1
> -#define PCIE_ELBI_SLV_AWMISC		0x11c
> -#define PCIE_ELBI_SLV_ARMISC		0x120
> -#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
> +#define EXYNOS_PCIE_IRQ_PULSE			0x000
> +#define EXYNOS_IRQ_INTA_ASSERT			BIT(0)
> +#define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
> +#define EXYNOS_IRQ_INTC_ASSERT			BIT(4)
> +#define EXYNOS_IRQ_INTD_ASSERT			BIT(6)
> +#define EXYNOS_PCIE_IRQ_LEVEL			0x004
> +#define EXYNOS_PCIE_IRQ_SPECIAL		0x008
> +#define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
> +#define EXYNOS_PCIE_IRQ_EN_LEVEL		0x010
> +#define EXYNOS_PCIE_IRQ_EN_SPECIAL		0x014
> +#define EXYNOS_PCIE_SW_WAKE			0x018
> +#define EXYNOS_PCIE_BUS_EN			BIT(1)
> +#define EXYNOS_PCIE_CORE_RESET			0x01c
> +#define EXYNOS_PCIE_CORE_RESET_ENABLE		BIT(0)
> +#define EXYNOS_PCIE_STICKY_RESET		0x020
> +#define EXYNOS_PCIE_NONSTICKY_RESET		0x024
> +#define EXYNOS_PCIE_APP_INIT_RESET		0x028
> +#define EXYNOS_PCIE_APP_LTSSM_ENABLE		0x02c
> +#define EXYNOS_PCIE_ELBI_RDLH_LINKUP		0x074
> +#define EXYNOS_PCIE_ELBI_XMLH_LINKUP		BIT(4)
> +#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
> +#define EXYNOS_PCIE_ELBI_SLV_AWMISC		0x11c
> +#define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
> +#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
> 
>  struct exynos_pcie {
>  	struct dw_pcie			pci;
> @@ -105,49 +105,49 @@ static void
> exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)  {
>  	u32 val;
> 
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
> +	val = exynos_pcie_readl(ep->elbi_base,
> EXYNOS_PCIE_ELBI_SLV_AWMISC);
>  	if (on)
> -		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> +		val |= EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
>  	else
> -		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
> +		val &= ~EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
> +	exynos_pcie_writel(ep->elbi_base, val,
> EXYNOS_PCIE_ELBI_SLV_AWMISC);
>  }
> 
>  static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep,
> bool on)  {
>  	u32 val;
> 
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
> +	val = exynos_pcie_readl(ep->elbi_base,
> EXYNOS_PCIE_ELBI_SLV_ARMISC);
>  	if (on)
> -		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> +		val |= EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
>  	else
> -		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
> +		val &= ~EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
> +	exynos_pcie_writel(ep->elbi_base, val,
> EXYNOS_PCIE_ELBI_SLV_ARMISC);
>  }
> 
>  static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)  {
>  	u32 val;
> 
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
> -	val &= ~PCIE_CORE_RESET_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_STICKY_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_NONSTICKY_RESET);
> +	val = exynos_pcie_readl(ep->elbi_base,
> EXYNOS_PCIE_CORE_RESET);
> +	val &= ~EXYNOS_PCIE_CORE_RESET_ENABLE;
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_CORE_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_STICKY_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 0,
> EXYNOS_PCIE_NONSTICKY_RESET);
>  }
> 
>  static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)  {
>  	u32 val;
> 
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
> -	val |= PCIE_CORE_RESET_ENABLE;
> +	val = exynos_pcie_readl(ep->elbi_base,
> EXYNOS_PCIE_CORE_RESET);
> +	val |= EXYNOS_PCIE_CORE_RESET_ENABLE;
> 
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_STICKY_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_NONSTICKY_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_APP_INIT_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_APP_INIT_RESET);
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_CORE_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_STICKY_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 1,
> EXYNOS_PCIE_NONSTICKY_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 1,
> EXYNOS_PCIE_APP_INIT_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 0,
> EXYNOS_PCIE_APP_INIT_RESET);
>  }
> 
>  static int exynos_pcie_start_link(struct dw_pcie *pci) @@ -155,21 +155,21
> @@ static int exynos_pcie_start_link(struct dw_pcie *pci)
>  	struct exynos_pcie *ep = to_exynos_pcie(pci);
>  	u32 val;
> 
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_SW_WAKE);
> -	val &= ~PCIE_BUS_EN;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_SW_WAKE);
> +	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_SW_WAKE);
> +	val &= ~EXYNOS_PCIE_BUS_EN;
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_SW_WAKE);
> 
>  	/* assert LTSSM enable */
> -	exynos_pcie_writel(ep->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
> -			  PCIE_APP_LTSSM_ENABLE);
> +	exynos_pcie_writel(ep->elbi_base,
> EXYNOS_PCIE_ELBI_LTSSM_ENABLE,
> +			  EXYNOS_PCIE_APP_LTSSM_ENABLE);
>  	return 0;
>  }
> 
>  static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)  {
> -	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_PULSE);
> +	u32 val = exynos_pcie_readl(ep->elbi_base,
> EXYNOS_PCIE_IRQ_PULSE);
> 
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_PULSE);
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_IRQ_PULSE);
>  }
> 
>  static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg) @@ -182,12
> +182,12 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
> 
>  static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)  {
> -	u32 val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
> -		  IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
> +	u32 val = EXYNOS_IRQ_INTA_ASSERT | EXYNOS_IRQ_INTB_ASSERT |
> +		  EXYNOS_IRQ_INTC_ASSERT | EXYNOS_IRQ_INTD_ASSERT;
> 
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_PULSE);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_LEVEL);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_SPECIAL);
> +	exynos_pcie_writel(ep->elbi_base, val,
> EXYNOS_PCIE_IRQ_EN_PULSE);
> +	exynos_pcie_writel(ep->elbi_base, 0,
> EXYNOS_PCIE_IRQ_EN_LEVEL);
> +	exynos_pcie_writel(ep->elbi_base, 0,
> EXYNOS_PCIE_IRQ_EN_SPECIAL);
>  }
> 
>  static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> @@ -244,9 +244,9 @@ static struct pci_ops exynos_pci_ops = {  static int
> exynos_pcie_link_up(struct dw_pcie *pci)  {
>  	struct exynos_pcie *ep = to_exynos_pcie(pci);
> -	u32 val = exynos_pcie_readl(ep->elbi_base,
> PCIE_ELBI_RDLH_LINKUP);
> +	u32 val = exynos_pcie_readl(ep->elbi_base,
> +EXYNOS_PCIE_ELBI_RDLH_LINKUP);
> 
> -	return (val & PCIE_ELBI_XMLH_LINKUP);
> +	return (val & EXYNOS_PCIE_ELBI_XMLH_LINKUP);
>  }
> 
>  static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
> --
> 2.17.1


