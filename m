Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F4296C1A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 11:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461419AbgJWJ23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 05:28:29 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:40867 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461303AbgJWJ23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 05:28:29 -0400
Received: by mail-ej1-f65.google.com with SMTP id z5so1432682ejw.7;
        Fri, 23 Oct 2020 02:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPuEY713o3UutUERO11Xp2e4yjYgZSU01XlNzEzL3Qo=;
        b=abS2awKRoJHDUf2lIiX7T5dcNm4TAL0ny1vjLoagp1rSGqAStMWJZec6y0GY58Fxf+
         raFE3ss8tIbdyPAsWI+d7i51HrlC9YRbRptnO/vHbnZMcTW9eMXnaKPfu2FkfyJ1Na0v
         6jYLJj/cCfOcjHp0InLi2ksHsgalvhbls04jDdYxO6RuqlHBucoZo/10x3SJ2ZmTL+PL
         UVOfTTiMCG/zwZ7mJhFx/ujaNCFz7dom454fM1t3BlcR/VC70OoSgrBA5brcDX0x1lG0
         +cjpAhMV+0K5/6BDlH0uhWFbkW1AhjyCzGS7tnIgO7ipbWqCCkCI7ys1nVGbVsiqZCp+
         wBZg==
X-Gm-Message-State: AOAM533DQejuABiaDCPbVFpYOSHLzv0rdWoT6ckEP7CvGbZ0FizVfQmP
        HjMDjjGW+XgOSLPxnyT2cUI=
X-Google-Smtp-Source: ABdhPJyD2TcAuJSXLs7ms8T/6qRFnEJhxitOhdxO0MxZGwV8iNIs1IzWT6KBf3b7WuO5BrP+fmb65w==
X-Received: by 2002:a17:907:4301:: with SMTP id nh1mr989136ejb.397.1603445306643;
        Fri, 23 Oct 2020 02:28:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id p16sm462604edu.74.2020.10.23.02.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:28:25 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:28:20 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/6] dt-bindings: phy: add the samsung,exynos-pcie-phy
 binding
Message-ID: <20201023092820.GB19257@kozik-lap>
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
 <CGME20201023075755eucas1p165641c7528ea987a2e1d9d28198c0e9e@eucas1p1.samsung.com>
 <20201023075744.26200-4-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023075744.26200-4-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 09:57:41AM +0200, Marek Szyprowski wrote:
> Add dt-bindings for the Samsung Exynos PCIe PHY controller (Exynos5433
> variant). Based on the text dt-binding posted by Jaehoon Chung.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/phy/samsung,exynos-pcie-phy.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
