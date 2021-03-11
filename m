Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71353372DF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 13:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhCKMjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 07:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233453AbhCKMis (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 07:38:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1801601FC;
        Thu, 11 Mar 2021 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466328;
        bh=kiZx6X2u4fkLyNZRYPGNjVsvCuNlk6cl7UlHxmmB1sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJgsZKR1DIU5WZLHXgEhCqhcLpQQggquOzflc2nNlTmlTmFe+BkFxqUww+070b3wi
         j+z0snIPYD2fqtslQ8Xqh69Bsbhy2VdKjKDbYg3I+FeWIrhBzE+REU9ujYj8VLzAh+
         hEQbnLNv19tSPP1NcRrClSze0OI8yifmVNc4GfjUKlGc3Mub2axAY0fEVpr4lrfZiG
         4FxqF5g/duMRu8+oaSC7+lPoraPURFQjQp5RxQ/qKsB/Ve5DnB4BcfikdP4jsXNzC7
         zDk+Fr4WJxIU0bY040HiylXA0evyqD5L0guCEiIIbzise6wtDY/WCwPKCnW7r38KCA
         XdRVIIQBOl69w==
Received: by pali.im (Postfix)
        id 0C4E18A7; Thu, 11 Mar 2021 13:38:44 +0100 (CET)
Date:   Thu, 11 Mar 2021 13:38:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v8,3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
Message-ID: <20210311123844.qzl264ungtk7b6xz@pali>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-4-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224061132.26526-4-jianjun.wang@mediatek.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 24 February 2021 14:11:28 Jianjun Wang wrote:
> +static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
> +{
...
> +
> +	/* Delay 100ms to wait the reference clocks become stable */
> +	msleep(100);
> +
> +	/* De-assert PERST# signal */
> +	val &= ~PCIE_PE_RSTB;
> +	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);

Hello! This is a new driver which introduce yet another custom timeout
prior PERST# signal for PCIe card is de-asserted. Timeouts for other
drivers I collected in older email [2].

Please look at my email [1] about PCIe Warm Reset if you have any clue
about it. Lorenzo and Rob already expressed that this timeout should not
be driver specific. But nobody was able to "decode" and "understand"
PCIe spec yet about these timeouts.

> +
> +	/* Check if the link is up or not */
> +	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_REG, val,
> +				 !!(val & PCIE_PORT_LINKUP), 20,
> +				 50 * USEC_PER_MSEC);

IIRC, you need to wait at least 100ms after de-asserting PERST# signal
as it is required by PCIe specs and also because experiments proved that
some Compex wifi cards (e.g. WLE900VX) are not detected if you do not
wait this minimal time.

> +	if (err) {
> +		val = readl_relaxed(port->base + PCIE_LTSSM_STATUS_REG);
> +		dev_err(port->dev, "PCIe link down, ltssm reg val: %#x\n", val);
> +		return err;
> +	}

[1] - https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
[2] - https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/
