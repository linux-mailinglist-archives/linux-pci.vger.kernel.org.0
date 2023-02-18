Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9160269B79B
	for <lists+linux-pci@lfdr.de>; Sat, 18 Feb 2023 02:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBRByp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 20:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRByo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 20:54:44 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975444E5DD;
        Fri, 17 Feb 2023 17:54:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id eg30so10710758edb.7;
        Fri, 17 Feb 2023 17:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jA/ugla+5i3dvnVJILyKOQpQ6/ozSYeGNQWjzA1fUcA=;
        b=Jl7E5N3V1vg5Xe2YqsP/thAqBUxWlyKbRgU6XLTJmBlNxmKf2N39tTCplYEkCYpEDW
         a4qPuwdhu8FXMD6azl6e4eiKhd+XL/pAzh/4FsdstR4OaaxCQrGn+Ay+Ldp4yeFW+eFR
         PH+QvNqcNsBa2fIGML33zFJkOlcvpH4XoZbAksyiaEIxlzIEKxBYZKi1Iv2lf4AJwAmh
         GDqrAYkeL2zj/2cdb+7VzrIl9wK45GsV0zQwu/ogyKQalVMXJwohivT1KSCAohJX6XLk
         sKElerHEsgQxP7Sx553FIi+QMLkZHBwgV76rSkvGUrPGg9/JgMjIjgrTN3uppgp7LRY/
         4gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jA/ugla+5i3dvnVJILyKOQpQ6/ozSYeGNQWjzA1fUcA=;
        b=VmY0Am+YN8ScOwra05oe4CuNikvvrvAUDNDXsHd7ApMkY1jJLqVe+dp/qtCI+RDQAI
         +N+grKjfPHEz6TZAfAeAkJKFU27/0oELhiHTSrB9PtzOxtWyEzOm68tlBIuEkJFhVyW6
         MOIgz6eaxcjgz3gqurVv66u/MG1MAu9ps/4+x6fq0zirgGYNtiQcLpwe5gr88f378gHu
         A0trSpto6TCm8roHmXve+1xTzvKXGdR67XSot2giDBwu/VVK63zJtI5TD1X0pTkR+QwK
         ekTIdEy+ERg31LCAMXBxOG3koO7uTNsT8mzVebdDPD8b9cnqhJ0DjYD8aBTav/+vjboJ
         9SoA==
X-Gm-Message-State: AO0yUKWjEzHWT+kjJQMenmIcNEAmKwRH7Lj2pAnoUlAups7ZWPPA/Du/
        5IEiVbtVsjBZgz1VlTWb37C0HsP5o9bAj8e1hf4=
X-Google-Smtp-Source: AK7set/WC7LwCEzh+T+AtiNzLawBQqjdCYYN4L2e9XBfPS0ry61w+AaRFfsW28sFUqOCoj/H0XltNn8biQDp4J5EdnU=
X-Received: by 2002:a50:9f4f:0:b0:4ac:b618:7fb1 with SMTP id
 b73-20020a509f4f000000b004acb6187fb1mr1779765edf.6.1676685280999; Fri, 17 Feb
 2023 17:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20230214121333.1837-1-shradha.t@samsung.com> <CGME20230214121404epcas5p3bfa6af0151b7f319d418f7c0dbed7c5a@epcas5p3.samsung.com>
 <20230214121333.1837-2-shradha.t@samsung.com> <b40cafa1-396f-e6cd-3240-bc879d5f2c8b@linaro.org>
In-Reply-To: <b40cafa1-396f-e6cd-3240-bc879d5f2c8b@linaro.org>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Fri, 17 Feb 2023 17:54:29 -0800
Message-ID: <CAPOBaE7d7Bf5zU7-fROqT9YvG1cQDqaV+aiiZRfrq=Xr4=8gYA@mail.gmail.com>
Subject: Re: [PATCH 01/16] dt-bindings: PCI: Rename Exynos PCIe binding to
 Samsung PCIe
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shradha Todi <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        Sergey.Semin@baikalelectronics.ru, lukas.bulwahn@gmail.com,
        hongxing.zhu@nxp.com, tglx@linutronix.de, m.szyprowski@samsung.com,
        jh80.chung@samsung.co, pankaj.dubey@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 16, 2023 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>
> On 14/02/2023 13:13, Shradha Todi wrote:
> > The current DT bindings is being used for Exynos5433 SoC only.
> > In order to extend this binding for all SoCs manufactured by
> > Samsung using DWC PCIe controller, renaming this file to a more
> > generic name.
>
> Thank you for your patch. There is something to discuss/improve.
>
> >
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  .../pci/{samsung,exynos-pcie.yaml => samsung,pcie.yaml}     | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >  rename Documentation/devicetree/bindings/pci/{samsung,exynos-pcie.yaml => samsung,pcie.yaml} (93%)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
> > similarity index 93%
> > rename from Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > rename to Documentation/devicetree/bindings/pci/samsung,pcie.yaml
> > index f20ed7e709f7..6cd36d9ccba0 100644
> > --- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
>
> We keep the name rather tied to compatible, not generic. There are no
> other compatibles here, so I don't think we should rename it.

I also agree with Krzysztof Kozlowski's opinion. For renaming, we should have
strong valid reasons.

Best regards,
Jingoo Han

>
> Best regards,
> Krzysztof
>
