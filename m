Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB656032F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiF2Ohk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbiF2Ohh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:37:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF45739148
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 07:37:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i18so28411911lfu.8
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=FhyPoEQz0RKtLndhys6lAY6EI+O9m3ogiGmUxKJbM9U=;
        b=incvQV4gzroWunRWH8JH/05yomzIH8GiXh6/TrYmrMvtPWDllUAuIvwcnlDuxUIbdq
         LfW69aXFkJpIp9QHztQ97hJeWtVX5/rsH4LW28XXqsuRY91gbcwXenJeddfsE1HkSxb+
         JoxIIEmVm6m7b9SyvgfKTZvp+tcShFl3H9yuZIpZGgrHyeSycZUcw+3NoT+phs724gL4
         DiBFyusivyJoZUogPfGR1WsnmiM5HKd5HVfsdr9NX6bR4iJqgFGKhHgsn07r2yIGaItQ
         peOGw2taLt9lipJ/V0OA/2FpbYcJOOfDHfgFoRWMGfpzhgZBzSe3uxzOFqWI+LkzFCnA
         9ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=FhyPoEQz0RKtLndhys6lAY6EI+O9m3ogiGmUxKJbM9U=;
        b=LVgD0uSAylAWhIeoL9zvwDIqRPPZRwvTOZLkhoF8LvGTTo4KJceigKefH0zRaxQunp
         5wvbPSATNwjNpzfie81xvjZtdoRLDOHyiJn1M5eAaLyyWU967EDGihv9KHd41q7s58nf
         e22VeZwN2LxDxo3tUQriRnPH44/3/vxsCQLKx5jWjxHxWleIuqW1hcpa1/seilorbHpv
         1G1T2/+jfuTYYuINaFRbXbxg5+alVW4Ev2lPjkBmzq01JIVuIm+HcySVN7PmY75Xtgrj
         PKSdLG0RyrhQQXJu4Z3eEoQV4+LsDfkBg9yGyBrPtbXHdDGYJ6REMVb/y1/WpWf6eNEh
         Urxg==
X-Gm-Message-State: AJIora/xBFwokDMiloIdO5CB+exnxex1ahUvI3Hr+JrI1EM+pwZcysZY
        H5kv2kZ8NTHjKsHRRNi6DaGT5Q==
X-Google-Smtp-Source: AGRyM1tRX9vLYv7X5Wt5cAG/cVVk1Xh7kH6Us7qiN8IfkK/y+f+CJd2oU+zmfCrZv6S0nyXj5/0cLg==
X-Received: by 2002:a05:6512:2520:b0:47f:8512:19c1 with SMTP id be32-20020a056512252000b0047f851219c1mr2338958lfb.540.1656513454142;
        Wed, 29 Jun 2022 07:37:34 -0700 (PDT)
Received: from [127.0.0.1] ([94.25.229.210])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25e73000000b0047255d21205sm2619414lfr.308.2022.06.29.07.37.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2022 07:37:33 -0700 (PDT)
Date:   Wed, 29 Jun 2022 17:37:30 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: PCI: qcom: Fix reset conditional
User-Agent: K-9 Mail for Android
In-Reply-To: <20220629141000.18111-2-johan+linaro@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org> <20220629141000.18111-2-johan+linaro@kernel.org>
Message-ID: <31EAC29D-77F4-4BED-B4DB-2B5718BD0009@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 29 June 2022 17:09:51 GMT+03:00, Johan Hovold <johan+linaro@kernel=2Eor=
g> wrote:
>Fix the reset conditional which always evaluated to true due to a
>misspelled property name ("compatibles" in plural)=2E
>
>Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on ms=
m8996 platforms")
>Signed-off-by: Johan Hovold <johan+linaro@kernel=2Eorg>
>---
> Documentation/devicetree/bindings/pci/qcom,pcie=2Eyaml | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie=2Eyaml b/Doc=
umentation/devicetree/bindings/pci/qcom,pcie=2Eyaml
>index 7e84063afe25=2E=2Eed9f9462a758 100644
>--- a/Documentation/devicetree/bindings/pci/qcom,pcie=2Eyaml
>+++ b/Documentation/devicetree/bindings/pci/qcom,pcie=2Eyaml
>@@ -615,7 +615,7 @@ allOf:
>   - if:
>       not:
>         properties:
>-          compatibles:
>+          compatible:


Argh=2E Thanks for noticing and fixing the typo=2E
If necessary I can respin MSI series in a few days=2E

Anyway, for this patch:
Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>

>             contains:
>               enum:
>                 - qcom,pcie-msm8996

--=20
With best wishes
Dmitry
