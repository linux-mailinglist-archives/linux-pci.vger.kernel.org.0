Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8F296C13
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461342AbgJWJ0z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 05:26:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33430 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461149AbgJWJ0z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 05:26:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id w23so898254edl.0;
        Fri, 23 Oct 2020 02:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Twa6UWRVJhEeoSRAOmH5AvQNaRPLtaHALxjahIiGuSY=;
        b=daKhNi8MQh+uRlQ9Tx0HToNPhrr+PGgqMVM9SKp3zM1bimb0AiF96bAvf6bv7NpujY
         8cqTfb3CLFhvJDQkKyXGJTxlTeWP1oU+Sv9PBlKw+uf87xSeCyxApeJokWS0ZoUh2ci2
         0NbzsF7lsMtdzqVlXi4mW910trmyBIGn+/fXie817eIizq6HaBFHBDPYpodin3d0uLXb
         OkhyEHtnOuBOKFYaxySxXlYmgBOZ3M31ZZZEoWTUf/e2FWG20L8LAwo8bsZAoZpEIlln
         /jQT/3b+O69cXYq1mxJGzhA8gsBhrPKaIqnM0fsF8xWN2/5xSJUfjx/jZK3YSOxTUJA9
         1fTg==
X-Gm-Message-State: AOAM531xYmY8LtHRWTCuqGZXF2eGKhnNjT7xHAZWye9ulx0LMrmJ9BMu
        VMsvCXOTXizHTOn2rX+lUYgaDGIuBto=
X-Google-Smtp-Source: ABdhPJwxFQX2v2rs+eNF9jt9s5CbifmdPA1NtE+iHwkC5sG80SLrmex/1EgIxmo2jMevupnnwQ/A2A==
X-Received: by 2002:a50:e881:: with SMTP id f1mr1317562edn.58.1603445212897;
        Fri, 23 Oct 2020 02:26:52 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id b8sm463598edv.20.2020.10.23.02.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:26:51 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:26:49 +0200
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
Subject: Re: [PATCH v2 2/6] dt-bindings: pci: add the samsung,exynos-pcie
 binding
Message-ID: <20201023092649.GA19257@kozik-lap>
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
 <CGME20201023075755eucas1p290b7bc020e46b86fe5e7591877f87117@eucas1p2.samsung.com>
 <20201023075744.26200-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023075744.26200-3-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 09:57:40AM +0200, Marek Szyprowski wrote:
> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
> variant). Based on the text dt-binding posted by Jaehoon Chung.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos-pcie.yaml     | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
