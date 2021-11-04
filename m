Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD043445BD2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 22:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhKDVul (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 17:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231950AbhKDVuk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 17:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B627F60F45;
        Thu,  4 Nov 2021 21:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636062482;
        bh=XUWkBUYQH1sVQ6/UxiW1zJVuZf29aMTBuB8+gR8Mgco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qLZa9FaCjMfC5DSo1Cq5o12BkRNaLMha2tFsgq9zmB17Q2y9SkQwJpvuLBzsG9W9b
         Snv69wAgNvlrxuacq5H/XmPoICBJ0R7qemZdolOBZQLPyvc3ciL64JGPIoH3c4wZp0
         A1xWwvHeLbaTBnINUbGUktuCUPVMcXt/dZ4BawX073QixG/l507+vYgdBOx6Hw6rh8
         LDOt+46C6qf05s33LD18qibSUqqll10yUFy0OOKe4m1dhz7odkqYIiY3IXQdldoyf5
         Oc6wsb/GqQGbPKH+OJUbKI215ceDRdcBwc0o+Q3W4PQmYYpzgVZjIBBc26/JwxgBiC
         wWBpnBjvoWmLg==
Date:   Thu, 4 Nov 2021 16:48:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v15 01/13] PCI: kirin: Reorganize the PHY logic inside
 the driver
Message-ID: <20211104214800.GA814298@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2f4aa6bbb71d5c9af0139704672f75f12644fc.1634812676.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 21, 2021 at 11:45:08AM +0100, Mauro Carvalho Chehab wrote:
> The pcie-kirin PCIe driver contains internally a PHY interface for
> Kirin 960.
> 
> As the next patches will add support for using an external PHY
> driver, reorganize the driver in a way that the PHY part
> will be self-contained.
> 
> This could be moved to a separate PHY driver, but a change
> like that would mean a non-backward-compatible DT schema
> change.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> +static int hi3660_pcie_phy_init(struct platform_device *pdev,
> +				struct kirin_pcie *pcie)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hi3660_pcie_phy *phy;
> +	int ret;
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	pcie->phy_priv = phy;
> +	phy->dev = dev;
> +
> +	/* registers */
> +	pdev = container_of(dev, struct platform_device, dev);

Is there something missing here?  "pdev" isn't referenced below.
Noticed by Krzysztof.

> +	ret = hi3660_pcie_phy_get_clk(phy);
> +	if (ret)
> +		return ret;
> +
> +	return hi3660_pcie_phy_get_resource(phy);
> +}
