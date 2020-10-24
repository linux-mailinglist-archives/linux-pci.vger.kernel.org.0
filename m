Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E2F297A6A
	for <lists+linux-pci@lfdr.de>; Sat, 24 Oct 2020 04:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759209AbgJXC7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 22:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759179AbgJXC7o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 22:59:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0BC0613CE;
        Fri, 23 Oct 2020 19:59:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c17so239448pjo.5;
        Fri, 23 Oct 2020 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=2vJO8R3lZs4KpedqI0G36Uf0dGNihvDZe+9D8dSAvUk=;
        b=I7VG7qH7hear8+HL3g53OvCclOzwH7gXPbvPT/WUxwHwMD3X+GbmkqCTFRPzNAyVeQ
         DX0RvRndxBeA9YhBydG8ozgPuPVuUKQjPEa/8x+lI5ZQMc1elYRH21P5PQIoIK1kCUMi
         iQij/7A+rcEHPG6wWogvWQkzUVN8deObkgP08Q0i1t6Fz963lv+VTe0+V/DHNVkkEr3a
         ZAyE0egbZiRss14Dhku387/VjTf3LLErXBTwc6Gcl1WFMQmnOGbBe7zfkj3UNkb24JiZ
         w+D0E49oRVVLHQo1nlHGp6B38uwGfx4VfwS/nFxrpNmYy7rA3rG+lyaRgjsNyeY5Yqvw
         r2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=2vJO8R3lZs4KpedqI0G36Uf0dGNihvDZe+9D8dSAvUk=;
        b=YWCU7IAXu3K1i6PeTxiqEHf/0jsCKplBL7X81Ch/ilkAzOGXV/cXRzMqs04lBaqOMC
         JlE+C7viuv5cLGIt67dn+j+bPpkbz9qqbjcCYEib/8IqiWMtCvFtgW2W7z03AyFPjSZS
         JwR+eJpiUDSQwaOTFAtOsjS/EqAaPo8lb4ygOvo6RBcd3k4x/3V+tvUz6HH/XI6hZhTg
         3A5/xrb3+EIcfl+YVGA4vcY+WtfZsqOPPAjgPw6C8n1o8wsG1HFXfEOpt0ixntNkx6qy
         F4tixDh8Aa/QmfB9IyhttamzE4mqAu8bEaDy90dl/h3qgrIlr7oygRHFkrJuNyPgidVg
         zJ0g==
X-Gm-Message-State: AOAM532dUOKo20IPj2lSstab/3+QM9fKl+gGs1Pg3tjMwDOItmDW9Rjd
        nzZ+HFN8jf/GsKgkxp1Aruo=
X-Google-Smtp-Source: ABdhPJwkxgR2TVQfNecLbsAXUk8T3HUXZTbebd82ieEDo/zraOq9nJnpjvY8yYOk1gNK39/xE9ZxuQ==
X-Received: by 2002:a17:902:6bc7:b029:d5:f149:f2e0 with SMTP id m7-20020a1709026bc7b02900d5f149f2e0mr2306673plt.34.1603508384266;
        Fri, 23 Oct 2020 19:59:44 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id 10sm4650998pjt.50.2020.10.23.19.59.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 19:59:43 -0700 (PDT)
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
Subject: Re: [PATCH v2 1/6] dt-bindings: pci: drop samsung,exynos5440-pcie
 binding
Thread-Topic: [PATCH v2 1/6] dt-bindings: pci: drop samsung,exynos5440-pcie
 binding
Thread-Index: AWI0ZnA3zn//KNIhGksYxL11Iw2wX2l5LTQyaXktNDLiUwO1RQ==
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sat, 24 Oct 2020 02:59:38 +0000
Message-ID: <SLXP216MB0477DC8CC4B46200B69BDE86AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
 <CGME20201023075754eucas1p2a4c9c5467f25a575bec34984fe6bb43b@eucas1p2.samsung.com>
 <20201023075744.26200-2-m.szyprowski@samsung.com>
In-Reply-To: <20201023075744.26200-2-m.szyprowski@samsung.com>
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
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Drop the obsolete bindings for
> exynos5440-pcie.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  .../bindings/pci/samsung,exynos5440-pcie.txt  | 58 -------------------
>  1 file changed, 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5=
440-pcie.txt
[.....]
