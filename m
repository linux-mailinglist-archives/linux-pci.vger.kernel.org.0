Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612C4301B67
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jan 2021 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbhAXLeW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jan 2021 06:34:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbhAXLeV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Jan 2021 06:34:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BDBF22C9C;
        Sun, 24 Jan 2021 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611488021;
        bh=vxdDZMAQDli/WcN3g4JeooaCMGpNlxHeGoV2DoyFPqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwAu9lyKuSsxJx0k1kvlouzyLpFsXa5QkaRtdPhDtorT9dA5qze4jvXGzJBmma3ku
         qSt5HZ+sGmL8DVUbaypO6Pft85HA4pbvgXdMHuRlYytPtw5tZWwpCVzHFh4I1z3Kgo
         +EYQlu9bPJsR39hkw46JYbXNO9V8X0Vg2bbHSQl0SsdiJqDtF5ixli/Lwi9/uTaF6o
         shGHpvcHPV4EbOOM9ThK+W7OhPIvYc9TT4Esm4pHkPvLmJ8ndQ0a1Kz907xOD8+J0X
         v0LQ3xS6hZOqsabLBOnsGJgJx+Hjun3wyaEI+gYdsje7q6HKrDKOG+fCjHxcD/zVaI
         9ffJayFPWLQQA==
Date:   Sun, 24 Jan 2021 13:33:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com,
        cyril.jean@microchip.com
Subject: Re: [PATCH v20 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20210124113337.GA5038@unreal>
References: <20210122145137.29023-1-daire.mcnamara@microchip.com>
 <20210122145137.29023-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122145137.29023-4-daire.mcnamara@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 22, 2021 at 02:51:36PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>
> Add support for the Microchip PolarFire PCIe controller when
> configured in host (Root Complex) mode.
>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/Kconfig               |   10 +
>  drivers/pci/controller/Makefile              |    1 +
>  drivers/pci/controller/pcie-microchip-host.c | 1115 ++++++++++++++++++
>  3 files changed, 1126 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-microchip-host.c

<...>

> +builtin_platform_driver(mc_pcie_driver);
> +MODULE_LICENSE("GPL v2");

We had this discussion lately, it should be "GPL" without "v2".

Thanks
