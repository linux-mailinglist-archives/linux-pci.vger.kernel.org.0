Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB966A9759
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 13:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCCMig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 07:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCCMif (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 07:38:35 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B45CC13;
        Fri,  3 Mar 2023 04:38:34 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s22so3367333lfi.9;
        Fri, 03 Mar 2023 04:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677847112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeNXt3isbPRHGAJkEjS0qeuKPk4Ph4hfVApRfVC6Qok=;
        b=P0YjcZ3S5ACbMGzx+4FQqVrYsfJfk5OAeUWFnmhbhhMgz7Y6myjru7hBUy4wOCtezp
         /cVnh5BCBuB6qe9UctJ5/iaU0DMycOjd+/JyQMJ4k32z4yKR//VcfV/3kYkvF8ZA63hQ
         2E8GkyLcl5beiGfzTYH6A7r7Hd0U/Pnztk3O1+cCiKP/TxO/XKrAj3RDU2qL6oAKc74w
         LlhTjo2eKXUiuAKLfec8YyGpNOmoXr1+3UrFDev1FqdymopeMImPzKEtlyHUCssIw5NA
         Z/o6XxM04tfRZpp+aBZIT2WGUpY2j3hX1PGFa8d9si5tdeCtGxABmW67F7aRpPd0WCUp
         6MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677847112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeNXt3isbPRHGAJkEjS0qeuKPk4Ph4hfVApRfVC6Qok=;
        b=ZDgpkLKTEG4pDD0Ngu/Nns+ZjajnCTqTqCJPvtB8gsg82HG6F7lLWhtIzmqaY01P0N
         CxyNDimEHyNs1KjWRicFtrammK4saPuQe+U8Vz7QByayFZr2BfjkAQbN6E12oSazNW/6
         BthlTnOgp1P0x+tsbIyiFM1vvkeAbd6gA1wcuA9P1Avg3GSST+DkH93qSbV6mEMnWZ4F
         WTbuVBdOObLYSSNeRhUk6yjuuXglFzQ9iK8rzn3Bw2Inhl9UORvwaix21zUjUdgQbNs8
         S3Qc2JnOPFrPkvn1nvpvdeXwicswXc2GTTNkiNtCgnAXP/4asuOeGDYNo71DlVmKAbK3
         heFQ==
X-Gm-Message-State: AO0yUKWzZ1KUMKAveRX970Ils+3X6rGaxDoNU8qUvQKbgVVfDfoPSph2
        LfeQCAhcu64SH/FUSoMv5WY=
X-Google-Smtp-Source: AK7set8AMf7sXcYGM7UKtvCBtcTYORd/6lfdClXFLlsf4lNnLXlfUAkJ2EqaJJ7J2E5fFC/UiNTVrQ==
X-Received: by 2002:ac2:546a:0:b0:4cb:449a:31f8 with SMTP id e10-20020ac2546a000000b004cb449a31f8mr501789lfn.35.1677847112505;
        Fri, 03 Mar 2023 04:38:32 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id c4-20020a2e6804000000b002934be1a0a4sm291705lja.70.2023.03.03.04.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 04:38:31 -0800 (PST)
Date:   Fri, 3 Mar 2023 15:38:29 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com,
        Sergey.Semin@baikalelectronics.ru, lukas.bulwahn@gmail.com,
        hongxing.zhu@nxp.com, tglx@linutronix.de, m.szyprowski@samsung.com,
        jh80.chung@samsung.co, pankaj.dubey@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] Refactor Exynos PCIe driver to make it generic
Message-ID: <20230303123829.er626hqa562sal3t@mobilestation>
References: <CGME20230214121348epcas5p48a3b2b225f616d748cc20622d01edb97@epcas5p4.samsung.com>
 <20230214121333.1837-1-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214121333.1837-1-shradha.t@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shradha

On Tue, Feb 14, 2023 at 05:43:17PM +0530, Shradha Todi wrote:
> Currently pci-exynos is being used as a PCIe driver for Exynos5433
> only. This patch set refactors the driver to make it extensible to
> other Samsung manufactured SoCs having DWC PCIe controllers.
> The major change points are:
> - Renaming all common functions/structures to use "samsung" instead
>   of "exynos". Make common probe/remove/suspend/resume
> - Making clock/regulator get/enable/disable generic
> - Adding private struct to hold platform specific function ops

Just a general note regarding the DT-bindings. If you're willing to fix
some names or most importantly add new ones please follow as much as
possible to the generic interface defined in the common part of the
DW PCIe bindings schema:
Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
for instance the generic "reg-names" are "elbi" or "app" defined for
the application-dependent registers map (normally implemented via the
ELBI interface in hardware), the "appl" name is marked as vendor-specific
and should be avoided.

-Serge(y)

> 
> Shradha Todi (16):
>   dt-bindings: PCI: Rename Exynos PCIe binding to Samsung PCIe
>   PCI: exynos: Rename Exynos PCIe driver to Samsung PCIe
>   PCI: samsung: Change macro names to exynos specific
>   PCI: samsung: Use clock bulk API to get clocks
>   dt-bindings: PCI: Rename the term elbi to appl
>   arm64: dts: exynos: Rename the term elbi to appl
>   PCI: samsung: Rename the term elbi to appl
>   PCI: samsung: Rename exynos_pcie to samsung_pcie
>   PCI: samsung: Make common appl readl/writel functions
>   dt-bindings: PCI: Add phy-names as required property
>   arm64: dts: exynos: Add phy-names as DT property
>   PCI: samsung: Get PHY using non-DT version
>   PCI: samsung: Rename common functions to samsung
>   PCI: samsung: Add platform device private data
>   PCI: samsung: Add structure to hold resource operations
>   PCI: samsung: Make handling of regulators generic
> 
>  ...ung,exynos-pcie.yaml => samsung,pcie.yaml} |  15 +-
>  MAINTAINERS                                   |   4 +-
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi    |   3 +-
>  drivers/pci/controller/dwc/Kconfig            |   6 +-
>  drivers/pci/controller/dwc/Makefile           |   2 +-
>  drivers/pci/controller/dwc/pci-samsung.c      | 508 ++++++++++++++++++
>  6 files changed, 526 insertions(+), 12 deletions(-)
>  rename Documentation/devicetree/bindings/pci/{samsung,exynos-pcie.yaml => samsung,pcie.yaml} (89%)
>  create mode 100644 drivers/pci/controller/dwc/pci-samsung.c
> 
> -- 
> 2.17.1
> 
> 
