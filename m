Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5AB292545
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgJSKON (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 06:14:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40501 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJSKON (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 06:14:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id h5so10710475wrv.7;
        Mon, 19 Oct 2020 03:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9St9YBwaIdNG1DkrmYoDAHtzZomOtz2yYrj1dmUwNYY=;
        b=sLY2mPBKtWF+IC6vn3Z3lj5t53/pnOvYR6PVDQHLjUESQF/nY9f8mYbnnlkgNZHzEw
         2z1HjM/Qb7Yxk0NYB4I7PmwWFbj+LvLaEqM3IB4J8ICJrM0Zb37SdRsdMe/Uh9GTtwCL
         V/r+I9URn0e8pxbF+uiWsADE/XIJpkhEHeMIIsWB/23LYXF5RgtRyP/BUdcfKTFwfbLu
         fNOMOg2g5XhqYG96f+rl4MX8LN2egHljxCPUScRn2ee9M4KMyX9aGwfqwXOIEasPGCyR
         q3GeJZlXKHseOQaNP/sxlQJof/gElU8wwwIOWiI0pXOlUi3qSYgk/Fc+fB8xt9gfi10F
         /Chw==
X-Gm-Message-State: AOAM533cyJVg9EyJe+uWEC4HfXxPaEgEjSWcJ7LVcoF8VV8KxkfQkSJc
        /UIP6gK1VJBTHectVoWsLck=
X-Google-Smtp-Source: ABdhPJwZex/zba0ZWy7QZHYxMyR4SAGsYleqSCpR5G7pfpF1D737D02ETx1kE5+7SBYa8h63QQAUTA==
X-Received: by 2002:adf:f1c8:: with SMTP id z8mr20204114wro.371.1603102450855;
        Mon, 19 Oct 2020 03:14:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id q6sm16106138wma.0.2020.10.19.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 03:14:09 -0700 (PDT)
Date:   Mon, 19 Oct 2020 12:14:07 +0200
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
Subject: Re: [PATCH 3/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie-phy binding
Message-ID: <20201019101407.GC51073@kozik-lap>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094739eucas1p17424b1224bf2a1a5b16c33deb4209166@eucas1p1.samsung.com>
 <20201019094715.15343-4-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-4-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:47:12AM +0200, Marek Szyprowski wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Add dt-bindings for the Samsung Exynos PCIe PHY controller (Exynos5433
> variant).
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
> 	   rewrote commit message]

The same as for 2/6 - conversion of TXT to YAML is like a new patch.  It
is quite significant work.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/phy/samsung,exynos-pcie-phy.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> new file mode 100644
> index 000000000000..ce92d1e687e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/samsung,exynos-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC series PCIe PHY Device Tree Bindings
> +
> +maintainers:
> +  - Jaehoon Chung <jh80.chung@samsung.com>
> +
> +properties:
> +  "#phy-cells":
> +    const: 0
> +
> +  compatible:
> +    enum:
> +      - samsung,exynos5433-pcie-phy

enum->const

Best regards,
Krzysztof
