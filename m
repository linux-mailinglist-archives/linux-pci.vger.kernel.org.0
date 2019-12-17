Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1921D123AF6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 00:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLQXgy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 18:36:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfLQXgy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 18:36:54 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA942176D;
        Tue, 17 Dec 2019 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576625813;
        bh=P+SwnsLC5te1dQ4th2jYZkSElf6dAPVk15zRg/6dnuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SkdCQcJymvixeemh500bFcmvQWyxa9wHvqwlNuMVe7w+bT2XPR0vaqQsGyNuTU2cW
         VmaX2i1fpSCDZ1h64VIBxtJqhY813QT/SFliZoH2PCgs+BI05dNyFQiTYSNtM5164S
         sER/6VzkUsNVQx/zTkBhumSZjPrTnQ/QhucGrdeg=
Date:   Tue, 17 Dec 2019 17:36:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
Message-ID: <20191217233651.GA3930@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-6-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
> Certain platforms like TI's J721E allow only 32-bit register accesses.
> Add read and write accessors to perform only 32-bit accesses in order to
> support platfroms like TI's J721E.

s/platfroms/platforms/

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence.c | 40 +++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h |  2 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index cd795f6fc1e2..de5b3b06f2d0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -7,6 +7,46 @@
>  
>  #include "pcie-cadence.h"
>  
> +u32 cdns_pcie_read32(void __iomem *addr, int size)
> +{
> +	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
> +	unsigned int offset = (unsigned long)addr & 0x3;
> +	u32 val = readl(aligned_addr);
> +
> +	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> +		pr_err("Invalid Address in function:%s\n", __func__);

It might be nice to have a hint about *why* it's invalid, e.g., the
addr and size values.
