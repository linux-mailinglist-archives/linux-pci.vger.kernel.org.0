Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AFD323F76
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhBXOC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 09:02:26 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:44933 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbhBXNmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 08:42:46 -0500
Received: by mail-lf1-f53.google.com with SMTP id p21so3035465lfu.11;
        Wed, 24 Feb 2021 05:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dq4qL90OCu8ib/iGkBDTsJu+uvHjzn/c/ym0u/ajUA0=;
        b=k2bs7i9PURtQE7+MTG7SM9jVa6bKH+Y+0qyhPmHfxmzi70O1p7VJ2F+TseOW+ky8Zi
         D/e8wAhcD5J7KpNWGlCWsZOkk4Gp6ROoQV0KALDiMMaf6zms34UT2iod6bJYWPDfZVe3
         8EtnFTjri5B+mrziFi8mTrAAQCIJOPxzHBnIe2tOoWLupnNzQzIGczp5Avikw66OwMVM
         fXBO1NlzFP4Fi6QyqPvNLkOGCAF0HghiOn4uYbk6y0uRKPJ9x6VtOpupliFiiBdmsnWn
         ngm+9VuYforWNWPMMhWoafkFuhladcE7K9LK4y9zZHWlmEbVuJBJhdl/OOZSc+bC6bkK
         5Dww==
X-Gm-Message-State: AOAM53374yrswzPEazzWiSSGpVJwLTsP4NzyB9XfB68mOGw3yylRUw7K
        LbNauP3UkLjbnizR5UxfQOf9Liw/22TFbg==
X-Google-Smtp-Source: ABdhPJxhksCAGOk3JAcFq15JrepLPez2XrzSDA7b9WxJVd1Jzq2verZqIaVftogrwqD0KjajojtEsw==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr26874209wrq.310.1614173779234;
        Wed, 24 Feb 2021 05:36:19 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j125sm3000640wmb.44.2021.02.24.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:36:18 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:36:16 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <YDZWUGcKet/lNWlF@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-4-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224061132.26526-4-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jianjun,

Thank you for all the work here!

[...]
> + * struct mtk_pcie_port - PCIe port information
> + * @dev: pointer to PCIe device
> + * @base: IO mapped register base
> + * @reg_base: Physical register base
> + * @mac_reset: mac reset control
> + * @phy_reset: phy reset control
> + * @phy: PHY controller block
> + * @clks: PCIe clocks
> + * @num_clks: PCIe clocks count for this port

It would be "MAC" and "PHY" in the above.

[...]
> + * mtk_pcie_config_tlp_header
> + * @bus: PCI bus to query
> + * @devfn: device/function number
> + * @where: offset in config space
> + * @size: data size in TLP header
> + *
> + * Set byte enable field and device information in configuration TLP header.

The kernel-doc above might be missing brief function description.  See
the following for more concrete example:

  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation

[...]
> +static int mtk_pcie_set_trans_table(struct mtk_pcie_port *port,
> +				    resource_size_t cpu_addr,
> +				    resource_size_t pci_addr,
> +				    resource_size_t size,
> +				    unsigned long type, int num)
> +{
> +	void __iomem *table;
> +	u32 val;
> +
> +	if (num >= PCIE_MAX_TRANS_TABLES) {
> +		dev_err(port->dev, "not enough translate table[%d] for addr: %#llx, limited to [%d]\n",

The wording of this error message is a little confusing.

> +			num, (unsigned long long) cpu_addr,

No space between the bracket and the variable name.

[...]
> +	err = phy_init(port->phy);
> +	if (err) {
> +		dev_err(dev, "failed to initialize PCIe phy\n");
> +		goto err_phy_init;
> +	}
> +
> +	err = phy_power_on(port->phy);
> +	if (err) {
> +		dev_err(dev, "failed to power on PCIe phy\n");
> +		goto err_phy_on;
> +	}
[...]

It would be "PHY" in the error messages above.

[...]
> +	if (err) {
> +		dev_err(dev, "clock init failed\n");
> +		goto err_clk_init;
> +	}
[...]

A nitpick, so feel free to ignore it, of course.  What about "failed to
initialize clock" to keep the style consistent.

[...]
> +	err = mtk_pcie_startup_port(port);
> +	if (err) {
> +		dev_err(dev, "PCIe startup failed\n");
[...]

Also a nitpick.  What about "failed to bring PCIe link up"?

Krzysztof
