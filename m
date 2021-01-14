Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470AC2F5CAB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 09:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbhANIxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 03:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbhANIxS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jan 2021 03:53:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90DDC239A1;
        Thu, 14 Jan 2021 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610614357;
        bh=HfT5kq3zEmUNElPzCNa0BiPdm8D62tWA6D8bZUBBB28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9GwJC98HdR0xjoM5pZYBKbJsAChO1k/KflCRHZ45+kDDt/DRqPEC12yWJg6PrRZP
         jHiF/EYxm7ipia9RuF5TivwNBwKqHt6phe0lMOLb7WhXQy9jxYhVdpTe/k0dT0pi8u
         /WCCL2Px1CZHlNB6I3OyIE64194qLjHdAldDb/4EKCdh7J0mNX5jjEn3cjfZrtL0b1
         6TvOI7s0wxnRtHDEro9FOucOA0yV9o08hgBAPG8RykH45QQcbxsx2b/+n5jscxC4EL
         xDAls5lLpo3p1uY1D9Fe90/I0pqi/xVoQy/9BoJ5+WElotG7Mdi2uoQKGMi/WmsoqV
         UKIFqWISiEVAw==
Date:   Thu, 14 Jan 2021 10:52:33 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Hongtao Wu <wuht06@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: Re: [RESEND PATCH v5 2/2] PCI: sprd: Add support for Unisoc SoCs'
 PCIe controller
Message-ID: <20210114085233.GO4678@unreal>
References: <1610612968-26612-1-git-send-email-wuht06@gmail.com>
 <1610612968-26612-3-git-send-email-wuht06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610612968-26612-3-git-send-email-wuht06@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 14, 2021 at 04:29:28PM +0800, Hongtao Wu wrote:
> From: Hongtao Wu <billows.wu@unisoc.com>
>
> This series adds PCIe controller driver for Unisoc SoCs.
> This controller is based on DesignWare PCIe IP.
>
> Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig     |  12 ++
>  drivers/pci/controller/dwc/Makefile    |   1 +
>  drivers/pci/controller/dwc/pcie-sprd.c | 293 +++++++++++++++++++++++++++++++++
>  3 files changed, 306 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

<...>

> +static struct platform_driver sprd_pcie_driver = {
> +	.probe = sprd_pcie_probe,
> +	.remove = __exit_p(sprd_pcie_remove),
                   ^^^^^^ why is that?

> +	.driver = {
> +		.name = "sprd-pcie",
> +		.of_match_table = sprd_pcie_of_match,
> +	},
> +};
> +
> +module_platform_driver(sprd_pcie_driver);
> +
> +MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
> +MODULE_LICENSE("GPL v2");

I think that it needs to be "GPL" and not "GPL v2".

Thanks

> --
> 2.7.4
>
