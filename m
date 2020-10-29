Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB129F746
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 22:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgJ2V71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 17:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgJ2V70 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 17:59:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC213C0613CF;
        Thu, 29 Oct 2020 14:59:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so3513349pfc.7;
        Thu, 29 Oct 2020 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=Gm4CoEGBACnXJjBKLc6ZVWL0buEtcov92fo48y4odfE=;
        b=fgD3ZDmBkgNBYsVsGN9pPc+smybBbSZgzCfoXLEYgy/bN5JAt8q9ZjqVeUkcNjvBYO
         ursSyKea9Zsddma8ORYAVAMmEO/mZtRfMvz/P64Y4xPcyHXa1naWsRrWf5VSY3lHR7Q2
         nJdYCF/CkhrXw7BlSfBGmPRnyG9ZMYj6dmUfFh4zPt5UqKb1faFojZMnHzbUrvfroo1i
         FTR8RVse+Bn5M3raRkGndubq0Txa9bdsfIolE9hOzOWkNf53MydSP8bmS5nF4FaaRjK+
         lgNRFrCPXaSjjiANSfYY9HedUqCN4gEKHd3UXS/V+I63uhC8I6xLcdVqVQCzBj+2fYWm
         Jiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=Gm4CoEGBACnXJjBKLc6ZVWL0buEtcov92fo48y4odfE=;
        b=uSvIRrmLdRIwL5qM+Cv35vAHGYsi7XyJ8/kM4fc+YB+Wbs0XoebdUzll1OrRIqAgBc
         R9yNPcr7kVKIJE3zCcxRAokPKGnSHTwOzlpcnhs3aMhOmUYIgWUpH/aHfnsYQhVsfVGZ
         ej7m1hJo6hiWMzOR7osxB/qYsb9515I6tzUmROmZYcUT4o9yM+zN7R82oKg8cc8IZGWH
         Y7DZu22Kc0eK8uUFgYMizmTtRKGXKvcxKTuN1mvXee1MZBFhjnDU2nyt6F1DT7N2CCiK
         JfllAVvxoGmV4joiDsGLERkD0ujIkQfFy5f8vuqa1FDqOe+PFaSiYtGcn8vGktwOabBZ
         +4TQ==
X-Gm-Message-State: AOAM531XiNGjzoljRHLuKo2emq9et8e02TkAxrEfPpSA+YAqd8hdn8aT
        R1Ecca+0QvNS7Rx6iOtkino=
X-Google-Smtp-Source: ABdhPJyzki19tAZX94ARNI6m7exJYU1/M2cPiFdM0s54RuoXolGl13N9aY+6Lun21JjbpLAeoDN4KA==
X-Received: by 2002:a17:90b:8c8:: with SMTP id ds8mr1280411pjb.40.1604008766472;
        Thu, 29 Oct 2020 14:59:26 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id 17sm3909133pfj.49.2020.10.29.14.59.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 14:59:25 -0700 (PDT)
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
        Rob Herring <robh@kernel.org>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v3 5/6] pci: dwc: pci-exynos: rework the driver to support
 Exynos5433 variant
Thread-Topic: [PATCH v3 5/6] pci: dwc: pci-exynos: rework the driver to
 support Exynos5433 variant
Thread-Index: AQHWrfkuGTQpOoO6c0q3AFlQqDuUEqmvIY0p
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 29 Oct 2020 21:59:21 +0000
Message-ID: <SLXP216MB04771FD4C3D22272FF7F4465AA140@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
 <CGME20201029134040eucas1p1d9ab30c75ac9243346b4786e7048d6be@eucas1p1.samsung.com>
 <20201029134017.27400-6-m.szyprowski@samsung.com>
In-Reply-To: <20201029134017.27400-6-m.szyprowski@samsung.com>
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

On 10/29/20, 9:41 AM, Marek Szyprowski wrote:
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
>	   removed MSI related code, rewrote commit message, added help]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/controller/dwc/Kconfig      |  10 +-
>  drivers/pci/controller/dwc/pci-exynos.c | 353 ++++++++++--------------
>  drivers/pci/quirks.c                    |   1 +
>  3 files changed, 147 insertions(+), 217 deletions(-)

[...]

