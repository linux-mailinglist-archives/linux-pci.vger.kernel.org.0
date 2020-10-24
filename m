Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D34297A6D
	for <lists+linux-pci@lfdr.de>; Sat, 24 Oct 2020 05:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759219AbgJXDAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 23:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759218AbgJXDAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 23:00:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BDC0613CE;
        Fri, 23 Oct 2020 20:00:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j5so2009268plk.7;
        Fri, 23 Oct 2020 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=1rQHzem8JzJSLiK/P6kvchUn5WeascIuoaa3Q9B4zN8=;
        b=G9EQGzVILq0Fqy9Kp06Js+WuyeS+1woPxPCHc7RHI4m864QRXCGTeqY+O2YkPN7yUB
         3ffkD37KNfRfP1Sef/ZT+Mhq0XToGkskqXWDebCU//Zpdpf7LgmzBwMeArZmAIZw1NKe
         uKKJ8W76rrUAjTq8xRNcZovLE1Er1xAGNj4UwPSiRt0tE07GZUYN1vbJO+RDci34NFkA
         XBVik6wYGSE3ozRhbELxM/DMgqP02BPbNZSbpj7OxdXozJvQf+sfZFcredblsqXblK88
         YPw5EK+FaAk9V0t3arIcKCmOrLd9YWvNdbNVIWDbrU+mcqlgxcx4Pe9ZeWrK/XBcPoyI
         51yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=1rQHzem8JzJSLiK/P6kvchUn5WeascIuoaa3Q9B4zN8=;
        b=FK6PDs1LkQOphFOiNl1Fq0jmO/JD4QZniVRBTxqSNisXLNYyfI9nyDt533Jx1IdnSx
         jtvf0zZkyo/vg3psWwhoUh3O6bivDmeHoEQMUZ8nalBNinebbfToDW7ftUddfSstx4bv
         bJVJXPf1a1n7LJyPi5pV6dHPiULJb+7V/IgyNlYWRPgngHcUMwrXvyrwZ7aR8iLggo5Z
         Jn2co/0RDXjkW8YbQQr+Lu96sTIexO4QD1mB084idg8Q3SgHx7pohbDL5rqYVenXU5tZ
         fna8jbV7ei9Si9QqybsQK5n7pkqy1rAo8fSSMuaMa0AJjohjvaw22I8mcl26HHOdlJo0
         MuoQ==
X-Gm-Message-State: AOAM533mWzZbF6xuQGexmhgiukfPyq34xLqik7EkUCbe3jQFxLdvdMRV
        pXFG9nLHSQM9S0BbbIOFE6M=
X-Google-Smtp-Source: ABdhPJy6HdLrF9xcBLoA7JVfzbH1HYcq2FMqRxam7zgx9r/7wa0UfRsylzy3XixfnNeVQ8iTjBpXgw==
X-Received: by 2002:a17:902:b18f:b029:d5:e3d3:9b87 with SMTP id s15-20020a170902b18fb02900d5e3d39b87mr2153288plr.78.1603508443545;
        Fri, 23 Oct 2020 20:00:43 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id n6sm4368063pjj.34.2020.10.23.20.00.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 20:00:42 -0700 (PDT)
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
Subject: Re: [PATCH v2 4/6] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
Thread-Topic: [PATCH v2 4/6] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
Thread-Index: AQHWqRJm3lMlTV28pUuiNlGSJRpbVqmmEYtg
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sat, 24 Oct 2020 03:00:37 +0000
Message-ID: <SLXP216MB0477F7772CFD7C0F31A0A09BAA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
 <CGME20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f@eucas1p2.samsung.com>
 <20201023075744.26200-5-m.szyprowski@samsung.com>
In-Reply-To: <20201023075744.26200-5-m.szyprowski@samsung.com>
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

On 10/23/20, 3:59 AM, Marek Szyprowski wrote:
>=20
> From: Jaehoon Chung <jh80.chung@samsung.com>
>
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Rework this driver to support PCIe PHY
> variant found in the Exynos5433 SoCs.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: reworked the driver to support only Exynos5433 variant, rebase=
d
>	   onto current kernel code, rewrote commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/phy/samsung/phy-exynos-pcie.c | 304 ++++++++++----------------
>  1 file changed, 112 insertions(+), 192 deletions(-)

[.....]
