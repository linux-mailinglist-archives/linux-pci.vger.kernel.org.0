Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D013292F30
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 22:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgJSUJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 16:09:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35705 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJSUJE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 16:09:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id w141so1378106oia.2;
        Mon, 19 Oct 2020 13:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QMKtewLYPP6tMQVtj4mNNEqIIxGrRSZg6gyxLvKazTE=;
        b=ND7b09LvutXyqsW0OmNitlL6mwcO+IKCLgeCu0E7KvvvWUHgamNkdR1GaqQkwVBRjN
         KFY2CGrqu58dn/4139gMsLnskaN0zKyFF5AfOVMGAGnRcYJAye97QaN6lHelVHIiGOxq
         aBN0JUEclgMw1LJpfkjyGrZ3h4nT6wtRouJe8WDLRLIvOzaphFobp7tlQ3ClAt4anZjI
         oHCaghuwQAQKR4dsLa3FCi7arGWDLexpFll/fbLEcrUFPhohDEDc4iEiUyD5F34Nj5s/
         6o8hGv/YJqEySEO+b5udER2d1QhoRD4ZNoK2YcG5XLWQxl4bviXYDXjUGR24WD7SfZye
         UX1A==
X-Gm-Message-State: AOAM533xdLGJK4itAI/eNquyU7UtIvGiuZnGZ+Xfi9FcJsm4Xiqtmf2K
        g/OXJVIP1WzO/IuWVzDbVUia/d1SXQ==
X-Google-Smtp-Source: ABdhPJz/VKBoYDlXHVBPp/z69rzZd2jUBU4G1RSqcEx3aclXL/87oJay7IsitKDGtyVmSbSSsSbATA==
X-Received: by 2002:aca:cdd8:: with SMTP id d207mr730753oig.64.1603138143247;
        Mon, 19 Oct 2020 13:09:03 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j75sm219474oih.10.2020.10.19.13.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:09:02 -0700 (PDT)
Received: (nullmailer pid 3523438 invoked by uid 1000);
        Mon, 19 Oct 2020 20:09:01 -0000
Date:   Mon, 19 Oct 2020 15:09:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie-phy binding
Message-ID: <20201019200901.GA3522961@bogus>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094739eucas1p17424b1224bf2a1a5b16c33deb4209166@eucas1p1.samsung.com>
 <20201019094715.15343-4-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-4-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 19 Oct 2020 11:47:12 +0200, Marek Szyprowski wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Add dt-bindings for the Samsung Exynos PCIe PHY controller (Exynos5433
> variant).
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
> 	   rewrote commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/phy/samsung,exynos-pcie-phy.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

./Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml:51:4: [error] no new line character at the end of file (new-line-at-end-of-file)
make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentation/devicetree/bindings/processed-schema-examples.json] Error 123
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1384137

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

