Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD05278346
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 10:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgIYIyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 04:54:04 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16576 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYIyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 04:54:04 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6dafcb0001>; Fri, 25 Sep 2020 01:52:27 -0700
Received: from [10.26.74.254] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Sep
 2020 08:53:48 +0000
Subject: Re: [PATCH v2 0/5] PCI: dwc: improve msi handling
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Yue Wang" <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-arm-kernel@axis.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
References: <20200924190421.549cb8fc@xhacker.debian>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <de4d9294-4f6d-c7d1-efc7-c8ef6570bd64@nvidia.com>
Date:   Fri, 25 Sep 2020 09:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924190421.549cb8fc@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601023947; bh=fWA/VvBZqbohPm2n/wszG6Dx2YqT5L4FZiRaNfHoaCY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=fEA++s28b/AQ7mzCLkLzYFRlJF2BG2COMVrHmZ9Cjc9p5TbBFqA5BOrVtJltGemIH
         oSNwCyvZoGvaq8JWbamivR4JiDHJ/fbHitkOBJUyOKk7fhFokWkA1SANddNTwBcXbB
         rJtZyjOJgzSgh4jh1o7XcmqvLXAzSBHYcicmtJ9h9TR22K1MmS7jVQdifrj4pS6LSh
         CZ5NHyDgIi28TtEhytLl0KvjvjNJQH8L1ZdjBKU9CMVcbwGoJxuinK8SOz6YpIuAxo
         hXWH5k1Il3WIy1HCnjUYcvviC2GDIwIFEgHTYvXo7Sko+a01zKS96FQk+ozLWpbU2o
         blYdOUWHAkYjw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 24/09/2020 12:05, Jisheng Zhang wrote:
> Improve the msi code:
> 1. Add proper error handling.
> 2. Move dw_pcie_msi_init() from each users to designware host to solve
> msi page leakage in resume path.

Apologies if this is slightly off topic, but I have been meaning to ask
about MSIs and PCI. On Tegra194 which uses the DWC PCI driver, whenever we
hotplug CPUs we see the following warnings ...

 [      79.068351] WARNING KERN IRQ70: set affinity failed(-22).
 [      79.068362] WARNING KERN IRQ71: set affinity failed(-22).

These interrupts are the MSIs ...

70:          0          0          0          0          0          0          0          0   PCI-MSI 134217728 Edge      PCIe PME, aerdrv
71:          0          0          0          0          0          0          0          0   PCI-MSI 134742016 Edge      ahci[0001:01:00.0]

This caused because ...

 static int dw_pci_msi_set_affinity(struct irq_data *d,
                                    const struct cpumask *mask, bool force)
 {
         return -EINVAL;
 }

Now the above is not unique to the DWC PCI host driver, it appears that
most PCIe drivers also do the same. However, I am curious if there is
any way to avoid the above warnings given that setting the affinity does
not appear to be supported in anyway AFAICT.

Cheers
Jon 

-- 
nvpublic
