Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2D12BA668
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKTJmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 04:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbgKTJmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 04:42:06 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28CD7223B0;
        Fri, 20 Nov 2020 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605865326;
        bh=XLxancgRgYpetl+23BnIP7WdgIKeWO32EF7mXEcNHJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCRPqje2mvonSCEr0psJ0aJHBWvQqNjhGk63jIYaQJnJnesIbfkxphhSJ0kNOlBD2
         0VWha/Gg3P2L80zsigzGuzHdGQkjsiTl3kJv3hgBAwufyQWIDNEbp+hUH8iALq5Qv7
         02krMiW8R8ku3U7BY1LteHGEiLnuJuflxxERBg/g=
Date:   Fri, 20 Nov 2020 15:11:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 4/5] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
Message-ID: <20201120094152.GC2925@vkoul-mobl>
References: <20201113170139.29956-1-m.szyprowski@samsung.com>
 <CGME20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47@eucas1p1.samsung.com>
 <20201113170139.29956-5-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113170139.29956-5-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13-11-20, 18:01, Marek Szyprowski wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Rework this driver to support PCIe PHY
> variant found in the Exynos5433 SoCs.

I am expecting this series to go thru PCI tree, so:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
