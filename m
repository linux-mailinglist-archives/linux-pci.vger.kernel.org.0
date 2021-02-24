Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF35324105
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 17:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhBXPhD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 10:37:03 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39102 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbhBXOcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 09:32:05 -0500
Received: by mail-wr1-f46.google.com with SMTP id v1so2086779wrd.6;
        Wed, 24 Feb 2021 06:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/YBrPEr1lwJ23lddEC25NzuV+KrdNuFPq/A3hHw3CPA=;
        b=VbL5wlt9h/bjh8BTlOF5cqKjmyds0QHqrQ9reZ/GpDJMoZct6cs/dattBdgCvPu2ex
         SwcC3gWwDpd6AthSaOyw/AOehv0HHm8plcGZyZ1DgyuAuYD+4YsIbr4wku8OLELXgF8G
         dT/mH7SWc80l4qkwlzugKPrXmUk3JQ4M4t8VBzWaJMqht6C66ApdKV79zMmVicimRPKh
         7yMFZhNsSSGTSXjQiaTkHgVMKs5Q/a6ZpQM9/Ztn3vlBRrKSmvE5yYFCzundSq3I9BIo
         z3hxDeUuPorf8DTErxFOoW24Ou0T75rzMPy0dmj6PYnn5NAnNLD38vOqWH6mtXRN2jel
         A//A==
X-Gm-Message-State: AOAM532GhGS7jK6D9IHcgGqUdrvSqJfTRYc8yHRfw9XKYwFF/daQhA+j
        xr8hHNe+uFkHQP7y7611wY0=
X-Google-Smtp-Source: ABdhPJyzlsFi0TiJ96xPkqKJZCTCILLB53zE4mEccCvTsH8l1EMpfBxoyYXPQQOyfwXHU3MmYnxVGQ==
X-Received: by 2002:adf:b355:: with SMTP id k21mr288693wrd.156.1614177082777;
        Wed, 24 Feb 2021 06:31:22 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c2sm3973759wrx.70.2021.02.24.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:31:22 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:31:20 +0100
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
Subject: Re: [v8,5/7] PCI: mediatek-gen3: Add MSI support
Message-ID: <YDZjOHKmks9ChFQI@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-6-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224061132.26526-6-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jianjun,

[...]
> +static struct irq_chip mtk_msi_irq_chip = {
> +	.name = "MSI",
> +	.irq_enable = mtk_pcie_irq_unmask,
> +	.irq_disable = mtk_pcie_irq_mask,
> +	.irq_ack = irq_chip_ack_parent,
> +	.irq_mask = mtk_pcie_irq_mask,
> +	.irq_unmask = mtk_pcie_irq_unmask,
> +};

For consistency sake, what about aligning this like the
struct mtk_msi_bottom_irq_chip has been?  See immediately below.

[...]
> +static struct irq_chip mtk_msi_bottom_irq_chip = {
> +	.irq_ack		= mtk_msi_bottom_irq_ack,
> +	.irq_mask		= mtk_msi_bottom_irq_mask,
> +	.irq_unmask		= mtk_msi_bottom_irq_unmask,
> +	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> +	.irq_set_affinity	= mtk_pcie_set_affinity,
> +	.name			= "MSI",
> +};

Krzysztof
