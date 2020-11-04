Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBE12A6FC2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 22:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgKDVjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 16:39:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44291 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgKDVjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 16:39:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id m26so132022otk.11;
        Wed, 04 Nov 2020 13:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5vjviz4cUkV9jIFnE7mhKccDmjPsW3HbVR4DQ2krNcU=;
        b=Rx3Q22FKtH9tI6gF60zNEwJtNXzDrOA8UXyoFJGWWvJ8IQ5QB2b1ItgRKHRxIFRkZJ
         ITPEtHK6isR6J5xFHPJ/HUuOi9Rw6YTa8lRlwneBwteGnoNQt5hanHfvYkLLJJro61V1
         1rvkQyuBe4R9jjadTjjKz/3oX+jpjxquj5sFO9Bld4CY7r7GezgjqXilm+kHMCXnx3NQ
         ageppdJ+hYdHMvbO9YAQCWy2t9exzx4U3i6BFIIZtRErJXuxiW0ax63dMBNwxvZWIGYY
         UwfzVEjZ82DXCiPdhYb+8NHg/CgIgb0weXcpuiP29QEV5Umtzi14wCCQRhneTcyZYadl
         9gxg==
X-Gm-Message-State: AOAM532gpe3eDe/t8zXvhBHmhmBv3sxRnbnWnlDg6EYX5JSNhYljRy0z
        XrLBgsyCpLOTi4f6D8ealw==
X-Google-Smtp-Source: ABdhPJyhOJM+/5TPFCeFTvgky5T5x9ZpBZtSzlyPQUFq8Ak4HQ2d1o2or8PK8Xk629kJut5IgcAOHQ==
X-Received: by 2002:a9d:400b:: with SMTP id m11mr18569402ote.175.1604525984733;
        Wed, 04 Nov 2020 13:39:44 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm827675ooi.41.2020.11.04.13.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:39:44 -0800 (PST)
Received: (nullmailer pid 4168819 invoked by uid 1000);
        Wed, 04 Nov 2020 21:39:43 -0000
Date:   Wed, 4 Nov 2020 15:39:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 5/6] pci: dwc: pci-exynos: rework the driver to
 support Exynos5433 variant
Message-ID: <20201104213943.GA4167813@bogus>
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
 <CGME20201029134040eucas1p1d9ab30c75ac9243346b4786e7048d6be@eucas1p1.samsung.com>
 <20201029134017.27400-6-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029134017.27400-6-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 29, 2020 at 02:40:16PM +0100, Marek Szyprowski wrote:
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
> 	   removed MSI related code, rewrote commit message, added help]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pci/controller/dwc/Kconfig      |  10 +-
>  drivers/pci/controller/dwc/pci-exynos.c | 353 ++++++++++--------------
>  drivers/pci/quirks.c                    |   1 +
>  3 files changed, 147 insertions(+), 217 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
