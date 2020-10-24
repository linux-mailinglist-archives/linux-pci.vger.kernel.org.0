Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9998D297A7D
	for <lists+linux-pci@lfdr.de>; Sat, 24 Oct 2020 05:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759322AbgJXDMp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 23:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759320AbgJXDMp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 23:12:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48276C0613CE;
        Fri, 23 Oct 2020 20:12:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l2so236237pjt.5;
        Fri, 23 Oct 2020 20:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=zTBRtgT7pbWlqs1vi69+HR0XTTRLAETUhmExxew5NDo=;
        b=ZpZKjdJtSqcsG89NdJQp0+s02MLtTNI1vpHpSP7oKzdakHEcSKkvY7CcHhj5zms+jS
         l9y4mKUj4WTaUKiYUlGX5SdYjTKc3Aq4oSzUSPj3rdneVz3SyraFboXN4SX8mgI5XLLh
         OPf15zn6cf/vEf1/lhFTbatI8uncx9PzX6wvpWEagn8Eo/3TPAoLoeBfyL03cgwEAft8
         Ungpe1hhZmMvlxUyPODGJMX+hnlgfCXCSOKsoq2U+AYQbrz4AW3VesOhTKYzBWSnZ7JK
         hVkUTsJbcnS/1qPyjMgloBhCg/zYdep+btUB7LEtGjiXQh6mi1pwh+s1+zhw6tCnGyy0
         JAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=zTBRtgT7pbWlqs1vi69+HR0XTTRLAETUhmExxew5NDo=;
        b=h0NdEHSMPa8C39kL+8lG+TWvLiWu0Bx0KHDmgigpAQY1JIfakpNnuh0l4xsxeKqtf0
         r3J/xHkeKlIDpOWpiNx/zFd6hNAdT3mYx9AWgv+JUOxebZArXM0ViIg+wcjL5iVDqFE8
         le/W5W/dYfmwPUIMI7zWTCNn9/HF7oHozABXBtLMqtwSaeKdbbluc4Z8PAVUe3z1OZgJ
         kHDTFxImthTxiQgl52ubOYP01VmKkSq1gPSBLHWKZm4dqDqnvFP/i+BIrASo2YNDnr/S
         +Qoe/e2Ph8LeV8pw+FWI/a8KINiZfh5Y7hxPmMGn1JpRv7uX1zHbeQ/8V9GD+mdfYqnw
         8c1A==
X-Gm-Message-State: AOAM531gk+FA+gVpV3qFhfAkEGka7cPQIEfzpl56Z5bgES/dSe9y3Hhu
        g4kBJwRMqWUGM058gIdPfOM=
X-Google-Smtp-Source: ABdhPJzQmQEnxa9/l+9Lq4CzVsMG9+8m/ikAGTD954YrN3sd7D9wuPDi6xuu6zomPp9QihOAFq344g==
X-Received: by 2002:a17:902:7c86:b029:d5:f680:f756 with SMTP id y6-20020a1709027c86b02900d5f680f756mr2165248pll.39.1603509162822;
        Fri, 23 Oct 2020 20:12:42 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id j12sm4204812pjs.21.2020.10.23.20.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 20:12:41 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v2 5/6] pci: dwc: pci-exynos: rework the driver to support
 Exynos5433 variant
Thread-Topic: [PATCH v2 5/6] pci: dwc: pci-exynos: rework the driver to
 support Exynos5433 variant
Thread-Index: ATYzNHA3LqEW/SeHeSezfbTZ8+mXqGl5LTQyaXktNDK6VWtTUg==
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sat, 24 Oct 2020 03:12:35 +0000
Message-ID: <SLXP216MB047790A7FD4D1E7304493343AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
 <CGME20201023075756eucas1p18765653e747842eef4b438aff32ef136@eucas1p1.samsung.com>
 <20201023075744.26200-6-m.szyprowski@samsung.com>
In-Reply-To: <20201023075744.26200-6-m.szyprowski@samsung.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/23/20, 3:58 AM, Marek Szyprowski wrote:
>=20
> From: Jaehoon Chung <jh80.chung@samsung.com>
>
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Rework this driver to support DWC PCIe
> variant found in the Exynos5433 SoCs.
>
> The main difference in Exynos5433 variant is lack of the MSI support
> (the MSI interrupt is not even routed to the CPU).
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: reworked the driver to support only Exynos5433 variant,
>	   simplified code, rebased onto current kernel code, added
>	   regulator support, converted to the regular platform driver,
>	   removed MSI related code, rewrote commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pci/controller/dwc/Kconfig      |   3 +-
>  drivers/pci/controller/dwc/pci-exynos.c | 358 ++++++++++--------------
>  drivers/pci/quirks.c                    |   1 +
>  3 files changed, 145 insertions(+), 217 deletions(-)

[....]

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index 242683cde04a..58056fbdc2fa 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -2,26 +2,23 @@
>  /*
>   * PCIe host controller driver for Samsung Exynos SoCs
>   *
> - * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> + * Copyright (C) 2013-2020 Samsung Electronics Co., Ltd.
>   *		https://www.samsung.com
>   *
>   * Author: Jingoo Han <jg1.han@samsung.com>
> + *	   Jaehoon Chung <jh80.chung@samsung.com>

Would you explain the reason why you add him as an author?
If reasonable, I will accept it. Also, I want gentle discussion, not aggres=
sive one.
Thank you.

Best regards,
Jingoo Han

>   */

[....]
