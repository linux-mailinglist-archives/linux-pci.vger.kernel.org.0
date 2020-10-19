Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7CA292530
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 12:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgJSKIu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 06:08:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36373 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgJSKIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 06:08:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id x7so10735579wrl.3;
        Mon, 19 Oct 2020 03:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9RvapzY61O8tFKHyafywHNCO6K53DiR+u+pHA+ZQ0ig=;
        b=Bp2SJCXLXYnjObKNlClcIBKtopvkiYGJyZu4vMnTxp1ZwqdHKHUj6bZMplXCRozBMI
         BlFqXkJoZVR7cds6eQRIgJqtVI7DrULYpYfNQWkXscYvHax75zXO49MeOur7s1coquEk
         ArdMA/4j3YZNoT29/XoMN07blUMNBtso3yh6sBUC0LVL6GGR7Bcmo2YCQvHKrJAg+S1s
         gIFQGFaPDt/GQWLdkzwrUUtbkDYRg9sF05+6wKJj0ymRlMO9wNSymWSAJ6GVRSsVBYx5
         H2adt+POCwJmxVA7jkhiMbnX1kzDZx7We0rP9/kevVciqxcHSffF8PvYvLxzHRixSMlY
         kClg==
X-Gm-Message-State: AOAM530EUwjB4lfrb54RTSSIvxlIfJjkRPpN5uWjmb7EvpjLs/umfYGT
        MMoW2RXuhc8sjS/hnTmAG8Y=
X-Google-Smtp-Source: ABdhPJzx9xXkc3nm/doybY/I18Oz14gGk9trmLpuPrZrOdITbU1R4V/8GsK/VPH6bTvhVwRmgnsbOQ==
X-Received: by 2002:a5d:6110:: with SMTP id v16mr20226576wrt.219.1603102128114;
        Mon, 19 Oct 2020 03:08:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id n6sm2550513wrj.60.2020.10.19.03.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 03:08:46 -0700 (PDT)
Date:   Mon, 19 Oct 2020 12:08:45 +0200
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
Subject: Re: [PATCH 1/6] Documetation: dt-bindings: drop
 samsung,exynos5440-pcie binding
Message-ID: <20201019100845.GA51073@kozik-lap>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094738eucas1p29b377b561089cfc3eba1755d475125b9@eucas1p2.samsung.com>
 <20201019094715.15343-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-2-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:47:10AM +0200, Marek Szyprowski wrote:
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Drop the obsolete bindings for
> exynos5440-pcie.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos5440-pcie.txt  | 58 -------------------
>  1 file changed, 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
