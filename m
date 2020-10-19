Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE102925A4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 12:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgJSKVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 06:21:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36097 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgJSKVf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 06:21:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id e2so12229187wme.1;
        Mon, 19 Oct 2020 03:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Go03qU3Z4n7OqYXcuBkScogMQ8cBWutaeJI9eO7tzI=;
        b=PXwiZrME3jUKfSxbvMZeK5E5YCTL7XpzkpGbK2MraPfKRLeFy/WatRgGE41wa60c7t
         3j70nTCiBtSAtXwmtVfGReUTMk/iKm1TlxW8hXeziWe4U0deeJ+AOdDmpxKpsGeLk1Za
         mnwt2z+iwc6eN9R4CKij6Ev4gTxY8drL1L1a697LuIRkRtkG/tLyXsvsOxMIueQjuXPw
         82ePqd+gG9THxkEIumW1kRFVcWoIIGYEay+FaWgHA16GAEGHNNCW2NtfxxnK3CYtueaA
         NvOyvDV0Po3i4gVIfXpJ6QI4YMxAQ25EjCzQLCrByVuYxE4A6ngRrdttIaQ4sdieTe/H
         QpUw==
X-Gm-Message-State: AOAM531SNWzplPkSr6yZ+CEefX9IdIt3QWjmoLIZUYm0JQIiJMPjOMn5
        +eXTemt17JanxiUK7QIJPS8=
X-Google-Smtp-Source: ABdhPJwEA4cu+ZUIHRN3FLZxaaKnCKY1tJx3Afb7XhAayPJfnYBwmsYRRTiSOs3aVt1G3TGXsPgKGg==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr17572921wmk.91.1603102893247;
        Mon, 19 Oct 2020 03:21:33 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id u5sm18902794wru.63.2020.10.19.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 03:21:32 -0700 (PDT)
Date:   Mon, 19 Oct 2020 12:21:30 +0200
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
Subject: Re: [PATCH 5/6] pci: dwc: pci-exynos: rework the driver to support
 Exynos5433 variant
Message-ID: <20201019102130.GE51073@kozik-lap>
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
 <CGME20201019094740eucas1p2cd873b29bc19708f9a712d955cba62fe@eucas1p2.samsung.com>
 <20201019094715.15343-6-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019094715.15343-6-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 11:47:14AM +0200, Marek Szyprowski wrote:
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
> 	   simplified code, rebased onto current kernel code, added
> 	   regulator support, converted to the regular platform driver,
> 	   removed MSI related code, rewrote commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pci/controller/dwc/Kconfig      |   3 +-
>  drivers/pci/controller/dwc/pci-exynos.c | 358 ++++++++++--------------
>  drivers/pci/quirks.c                    |   1 +
>  3 files changed, 145 insertions(+), 217 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
