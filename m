Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2219F2622BB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 00:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIHWj3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 18:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgIHWj3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 18:39:29 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D9120757;
        Tue,  8 Sep 2020 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599604769;
        bh=p3SCNQSZriSpfsmnFhDYpZyKCKZix6tZbg5PzqvY3yc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ABOcrC3EhkUg45HI4mWN4wDVv6kiMsASU52p1/lQoSqTnausqYnFGQZPfXOyqzJTx
         rkr/Q4fP/yZAtT3nyMb9bOOkECya3pel1+lS65Zkdt6fPo93rKLuSr1f/uUPhQ3jgi
         gcP7YWCgkoxQSlL+o8nsP42/f4sKyqjve2OkLljM=
Date:   Tue, 8 Sep 2020 17:39:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongtao Wu <wuht06@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Billows Wu <billows.wu@unisoc.com>
Subject: Re: [PATCH v2 2/2] PCI: sprd: Add support for Unisoc SoCs' PCIe
 controller
Message-ID: <20200908223927.GA647146@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599572841-2652-3-git-send-email-wuht06@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 08, 2020 at 09:47:21PM +0800, Hongtao Wu wrote:
> From: Billows Wu <billows.wu@unisoc.com>
> 
> This series adds PCIe controller driver for Unisoc SoCs.
> This controller is based on DesignWare PCIe IP.
> 
> Signed-off-by: Billows Wu <billows.wu@unisoc.com>

Last signed-off must be from developer submitting the patch, i.e.,
Hongtao Wu; see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n560

> +config PCIE_SPRD
> +	tristate "Unisoc PCIe controller - RC mode"

s/RC mode/Host mode/ to follow convention of other drivers.

> +	depends on ARCH_SPRD || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Unisoc PCIe controller uses the Designware core. It can be configured

s/Designware/DesignWare/

> +	  as an Endpoint (EP) or a Root complex (RC). In order to enable RC
> +	  mode, PCIE_SPRD must be selected.
> +	  Say Y or M here if you want to PCIe RC controller support on Unisoc
> +	  SoCs.

> +		dev_dbg(&pdev->dev,

dev_dbg(dev, ...

> +			"%2d:reg[0x%8x] mask[0x%8x] val[0x%8x] result[0x%8x]\n",
> +			i, reg, mask, val, tmp_val);
