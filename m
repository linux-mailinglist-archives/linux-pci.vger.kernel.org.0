Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864C57E70C0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 18:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjKIRtf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Nov 2023 12:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKIRtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2023 12:49:35 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA7268D
        for <linux-pci@vger.kernel.org>; Thu,  9 Nov 2023 09:49:32 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231109174931epoutp01f2a3f14204223b601b6986260ec7c9b5~WBbH8QiSu0119501195epoutp01G
        for <linux-pci@vger.kernel.org>; Thu,  9 Nov 2023 17:49:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231109174931epoutp01f2a3f14204223b601b6986260ec7c9b5~WBbH8QiSu0119501195epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699552171;
        bh=GQPGTCJTLTSEdi/5JKW1h6q+xJIJju1ejA/iyYvB/Gs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WITY7BPYd5IJG1oXRKOTs7lGQ9W4VeXDaCmRQXCn/fLWO29LnTUQTTOT7JlDgo/m7
         VqqZ+bKXihT8ukwL3lf1+9X8lelPfc+D8Moe673jwT/HIDimtoFd1iYzvAPUw7q0wS
         Flf+t/mZc/oloffKqbNaspYd7tOBF7eF+rv2Sm3w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231109174930epcas5p4f6dcd153c2f5d79047879cce118a43cf~WBbHTbjrn2406224062epcas5p4a;
        Thu,  9 Nov 2023 17:49:30 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SR8bY3dSnz4x9Pp; Thu,  9 Nov
        2023 17:49:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.B5.19369.9AB1D456; Fri, 10 Nov 2023 02:49:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231109174928epcas5p369f0ea4d67dc5c77bfc85b739c2928e2~WBbFKWDya2320923209epcas5p3C;
        Thu,  9 Nov 2023 17:49:28 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231109174928epsmtrp1a4eb91fcb2b8be4d8b85f5aebaa0c1e2~WBbFJtvSd1669316693epsmtrp1a;
        Thu,  9 Nov 2023 17:49:28 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-ab-654d1ba96dd4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.D5.18939.8AB1D456; Fri, 10 Nov 2023 02:49:28 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231109174926epsmtip2c06847f1bf6b2132c37275cc5a393f4d~WBbDcAhR92451224512epsmtip2b;
        Thu,  9 Nov 2023 17:49:26 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Shradha Todi'" <shradha.t@samsung.com>, <jingoohan1@gmail.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>
Cc:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pankaj.dubey@samsung.com>
In-Reply-To: <20231009062052.5407-1-shradha.t@samsung.com>
Subject: RE: [PATCH] PCI: exynos: Change macro names to exynos specific
Date:   Thu, 9 Nov 2023 23:19:25 +0530
Message-ID: <029b01da1335$15c46d80$414d4880$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHePu0kvTSN+lKzECkL49kYbCkH+ALSVT9ssFNZfMA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmhu5Kad9Ug9OnpCyWNGVYrPgyk91i
        7+ut7BYNPb9ZLTY9vsZqcXnXHDaLs/OOs1nMOL+PyaLlTwuLxaKtX9gt/u/ZwW7Re7jWgcdj
        56y77B4LNpV6bFrVyeZx59oeNo8nV6YzeWxeUu/Rt2UVo8fnTXIBHFHZNhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlApyoplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjPOzHzMXLDHtWLOk10s
        DYzTrLsYOTkkBEwkDl9ZzQZiCwnsYZRYsS+zi5ELyP7EKLH34CJ2OOf85I+MXYwcYB2/d3lC
        NOxklDg2nwui5gWjxP1by1hAEmwCuhI7FrexgSREBPYySrxadpQRJMEssIZRYnJ3FIjNKWAl
        sWfpdrC4sIC7xP8LH5lBFrAIqEh8eWsEEuYVsJQ4sbaVEcIWlDg58wkLxBh5ie1v5zBDfKAg
        8fPpMlYQWwRo5MdvO5khasQlXh49wg5Rc4JD4kO3BoTtIvHuwEWouLDEq+NboGwpiZf9bewQ
        P3pILPojBRHOkHi7fD0jhG0vceDKHBaQEmYBTYn1u/QhNvFJ9P5+wgTRySvR0SYEUa0q0fzu
        KguELS0xsbubFWb42Vc8ExgVZyF5axaSt2YhOX8Wwq4FjCyrGKVSC4pz01OTTQsMdfNSy+Fx
        nZyfu4kRnIi1AnYwrt7wV+8QIxMH4yFGCQ5mJRHeCyY+qUK8KYmVValF+fFFpTmpxYcYTYFh
        PZFZSjQ5H5gL8kriDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYMpJ
        3+WrX6ws6Og9Ya9meu3mWf+Y+a2/H73EwvLdxWLJ05IzU1J2vXH9d1fn2nrzuTsmtNjOSa8w
        jMxy//G4u35n2505Ygm9HwQnOLMVlx3V2drbvuGL05YDm2aZToyrOtfrV9f6/6Pi0jevMro+
        SIfXZyz6/NDz04Jls0NbVnAcrXE9yDMvaGVhxfHbf/L4xe4z6u+K/NPlqSW560es+/aNM1i5
        6jo5Et5amc3R53710vBJjlXoaUHre00PW6xWHD9eOD1mSWLVWZe026WHtzqx/JapEz759IW4
        RE+Q8aS4tdE//LVedLEkPFBaffh+ahnv0RXaMTIxL+o/unw4rxl1IE3U7ne2Zt1qHodlq5RY
        ijMSDbWYi4oTAYYXV51NBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvO4Kad9Ug+/T+SyWNGVYrPgyk91i
        7+ut7BYNPb9ZLTY9vsZqcXnXHDaLs/OOs1nMOL+PyaLlTwuLxaKtX9gt/u/ZwW7Re7jWgcdj
        56y77B4LNpV6bFrVyeZx59oeNo8nV6YzeWxeUu/Rt2UVo8fnTXIBHFFcNimpOZllqUX6dglc
        GWdmPmYu2ONaMefJLpYGxmnWXYwcHBICJhK/d3l2MXJxCAlsZ5T4sesNWxcjJ1BcWuL6xgns
        ELawxMp/z9khip4xSlx+t5UFJMEmoCuxY3EbG0hCROAoo8TR3X2sIAlmgQ2MEtsO5EF0dDNK
        NG5dA5bgFLCS2LN0OyOILSzgLvH/wkdmkDNYBFQkvrw1AgnzClhKnFjbyghhC0qcnPmEBWKm
        tsTTm0+hbHmJ7W/nMENcpyDx8+kysPEiQOM/ftvJDFEjLvHy6BH2CYzCs5CMmoVk1Cwko2Yh
        aVnAyLKKUTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzgetYJ2MC5b/1fvECMTB+MhRgkOZiUR
        3gsmPqlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTI4m
        KfPfJ7saljhe3vH12Nofcu+fX0ny+1L44qSU00Rvvst6h0uD4tYa5XSbXPwn/8DZ96pgxdFN
        s5ZH1d+dn5WivCujLTg2asvNz6ZzJ8R6BnDUTFsnsD5I+F2wQGd1/rL4d9JFn1aW3Zh7R8Hj
        z1mVjqbS9DmJ4W/toierJUi8Dnw39dlmxa7ITW/KGCvEF2scbCiKbjbbKuY/J2qio7/wlHOu
        LyTrF2hs0eJja8vI/v1Wqapqgh+v6dvPGx9y15xyO3/xUG6dePvtHWvjBQ+XWXgLbr/7huXY
        pTbNiJ1vj033adEXmHXfJG07c8qe6ybfrpypCfPwuX+wiSd9fZTwr/0CdWte97PeXiIsr8RS
        nJFoqMVcVJwIAEs1ujU2AwAA
X-CMS-MailID: 20231109174928epcas5p369f0ea4d67dc5c77bfc85b739c2928e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231009062058epcas5p4dc1fb50210c920137ac906b0bdf99e1b
References: <CGME20231009062058epcas5p4dc1fb50210c920137ac906b0bdf99e1b@epcas5p4.samsung.com>
        <20231009062052.5407-1-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Shradha Todi <shradha.t@samsung.com>
> Sent: Monday, October 9, 2023 11:51 AM
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

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

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


