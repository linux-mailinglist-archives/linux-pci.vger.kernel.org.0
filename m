Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6423F1BB6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 16:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbhHSOik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 10:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240520AbhHSOij (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 10:38:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 142B2610A7;
        Thu, 19 Aug 2021 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629383883;
        bh=TCOAJEPL6JlpALK+Wmf2/5K+wXqZbcrSXzG+yXZD8T4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TP1QcFIR32VbtjlwEOh6RX7CBqvMfSmWK3Y8EvQ9G/Z9Y7q9XhWivbyveWNO/5b+F
         JKMx2xZ9MNJ0bNZGdh0HmDnHk6B7TmkQ73DAnLxcZK/sv5TYlWBtrik3a55zU4jrIC
         f2gsci2xFp0JyEILrsYKRW5L+Fl9subQvOXhFSD2HqWNIMZoUKtwBPE4h+28E0ZVGT
         aGauFiibnkIDr76BhfWnJMrYs/+BFqHMmllx5CCGDSTsDCAh+GuRqjHuVj1/Wwtnai
         Uln+rzSey+dQO7+RuwIDsaLuUCFOyMpBtb/O67MxQpkuU6/Ng0CBaDxrX3hX2jKMXK
         x8nQse029X1rg==
Date:   Thu, 19 Aug 2021 09:38:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        f.fainelli@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Subject: Re: [PATCH v1] MAINTAINERS: new entry for Broadcom STB PCIe driver
Message-ID: <20210819143801.GA3202443@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818225031.8502-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 18, 2021 at 06:50:30PM -0400, Jim Quinlan wrote:
> The two files listed are also covered by
> 
> "BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
> 
> which covers the Raspberry Pi specifics of the PCIe driver.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Applied to for-linus for v5.14, thanks!

I updated the subject/commit log like this:

  MAINTAINERS: Add Jim Quinlan et al as Broadcom STB PCIe maintainers

  Add Jim Quinlan, Nicolas Saenz Julienne, and Florian Fainelli as
  maintainers of the Broadcom STB PCIe controller driver.

  This driver is also included in these entries:

    BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
    BROADCOM BCM7XXX ARM ARCHITECTURE

  which cover the Raspberry Pi specifics of the PCIe driver.

> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc0ceef87b73..0f5c8832ae49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3809,6 +3809,16 @@ L:	bcm-kernel-feedback-list@broadcom.com
>  S:	Maintained
>  F:	drivers/mtd/nand/raw/brcmnand/
>  
> +BROADCOM STB PCIE DRIVER
> +M:	Jim Quinlan <jim2101024@gmail.com>
> +M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
> +M:	Florian Fainelli <f.fainelli@gmail.com>
> +M:	bcm-kernel-feedback-list@broadcom.com
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +F:	drivers/pci/controller/pcie-brcmstb.c
> +
>  BROADCOM SYSTEMPORT ETHERNET DRIVER
>  M:	Florian Fainelli <f.fainelli@gmail.com>
>  L:	bcm-kernel-feedback-list@broadcom.com
> -- 
> 2.17.1
> 
