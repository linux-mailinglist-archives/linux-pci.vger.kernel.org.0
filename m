Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27AB3304EC
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 23:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhCGWKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 17:10:45 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36297 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhCGWKQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 17:10:16 -0500
Received: by mail-wr1-f48.google.com with SMTP id u14so9436489wri.3;
        Sun, 07 Mar 2021 14:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w0FBb8CnoCr7tqR94rY/v8Qic5qKjXRNMAaFBeahA3I=;
        b=Vk3g/KrWqq6McpeFshG5xJjZBAIetpzZKsAz8iYGNa9JkXgW1VuO3CZR8c+D84XWey
         HZB0Ns7/vRhWZqVvrm30u1DJxAe+3rpoig/zgGGx4UwV2S8FFWvf3Pc9C6m4LxtGBhN5
         u8YtqfY2p3DarXmtvoytreNfJ+3J3hf4ZQPbez2KYfBRhsLj8mpQCTFAdHgGrX2is9Xw
         cGKzBfHIInJzWO0Zwk+InO7S3bql0vw/9M7Xej2gTsrHTbQCdXOxQS6vfYowF1Kydv4e
         IN40PizAcxHksWrd73Cvhs5VAnKx5wHDaRfz0csCsFNaYSTtEI3g8d4tG/Gwng57FdX5
         ec4w==
X-Gm-Message-State: AOAM532wZlQg92ouPni/5ngYrMV+zPs++CvuBHolzbTq9FHpZdGB7VMS
        gBje/wCWoEMhPHYL5t1Qu9w=
X-Google-Smtp-Source: ABdhPJz1EuAgHQbWUMttHlGdzXLBLuK8NfZzUmdIXnw5+kar1/RkTecBM2iv5KBusGCU6NdnIeRj6g==
X-Received: by 2002:adf:a2d3:: with SMTP id t19mr19655343wra.299.1615155014465;
        Sun, 07 Mar 2021 14:10:14 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m14sm16525603wmi.27.2021.03.07.14.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 14:10:14 -0800 (PST)
Date:   Sun, 7 Mar 2021 23:10:12 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
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
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 5/5] PCI: dwc: Move dw_pcie_msi_init() from each users
 to designware host
Message-ID: <YEVPRDt1By8TG9O5@rocinante>
References: <20200924190421.549cb8fc@xhacker.debian>
 <20200924190742.76939458@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924190742.76939458@xhacker.debian>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> may lose power during suspend-to-RAM, so when we resume, we want to
> redo the latter but not the former. If designware based driver (for
> example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> previous msi page will be leaked. From another side, except
> pci-dra7xx.c we can move the dw_pcie_msi_init() from each users to
> designware host, I.E move the msi page allocation and mapping to
> dw_pcie_host_init() and move the PCIE_MSI_ADDR_* programming to
> dw_pcie_setup_rc(). After this moving, we solve the msi page leakage
> as well.
[...]

A small nitpick.  All the "designware" should be "DesignWare" both in
the commit message and the subject.  Similarly, "msi" would be "MSI",
and "I.E" would become "i.e.,".  If you ever sent another version of the
patch, that is.

See the following for reference:
  https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

Krzysztof
