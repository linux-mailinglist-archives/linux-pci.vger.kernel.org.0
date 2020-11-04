Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED542A6FC3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 22:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgKDVjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 16:39:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36370 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbgKDVjx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 16:39:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id d9so17807395oib.3;
        Wed, 04 Nov 2020 13:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0GjcO0LXhbWpQpB54W5WhX2joq9YbQFz1TRI+rNI3DE=;
        b=oT3SJqbU+aaoyiv/GzZcc4tQHEm87Bl5lDmPR3rd/PI6RcdW4Mz7xx+Z+Ffrn0aWIB
         kftPKi2/syV0UroRYiAvjog6tDBN9wIOhWZ8RVgI4Tcvm02L0Hcjdd4dw7EsfRGcD+Qo
         Mmg7nIoFiJcEXufmXhFeIFYXD8sxLaGLaz5xFMkUmsu+Gemw6JljKW2yRsCVw1WuIsDt
         BEVyUNgqVaX375LxPpAj2FFGEDoULcbXCJ6hIhgkhmjKH9916P7pW0nrd+m4oC6Y4gUi
         tTLfxXBaHvXO5FaL1ZPWbh5HUGtHsxnsu0Evg6z5xZYxt3BjFlpetuQc8KmOVHNOufyD
         hZOw==
X-Gm-Message-State: AOAM533WFokA1T/+SqqwXkHD3wNJ8xWS8h7xDnuisL7MjpR4t5vSI6+8
        n1UjqXxn7Ncw4mEE1xj81+plKpPVYg==
X-Google-Smtp-Source: ABdhPJwHYbu/9XtGIbsBCS4HflbdiacDO6YTBqPMDVPRfdaL650TepVQ9UJ22/TceHS3Dr7TP9DQCw==
X-Received: by 2002:aca:3a43:: with SMTP id h64mr3590880oia.73.1604525992877;
        Wed, 04 Nov 2020 13:39:52 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n18sm740113otk.33.2020.11.04.13.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:39:52 -0800 (PST)
Received: (nullmailer pid 4169070 invoked by uid 1000);
        Wed, 04 Nov 2020 21:39:51 -0000
Date:   Wed, 4 Nov 2020 15:39:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/6] dt-bindings: phy: add the samsung,exynos-pcie-phy
 binding
Message-ID: <20201104213951.GA4169027@bogus>
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
 <CGME20201029134038eucas1p2d550a45ff3222ccb72d15d5c89d4f938@eucas1p2.samsung.com>
 <20201029134017.27400-4-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029134017.27400-4-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 29 Oct 2020 14:40:14 +0100, Marek Szyprowski wrote:
> Add dt-bindings for the Samsung Exynos PCIe PHY controller (Exynos5433
> variant). Based on the text dt-binding posted by Jaehoon Chung.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/phy/samsung,exynos-pcie-phy.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
