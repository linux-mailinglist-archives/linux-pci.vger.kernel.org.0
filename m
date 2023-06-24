Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA94673CB4E
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFXOT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 10:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFXOT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 10:19:56 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D66C1997;
        Sat, 24 Jun 2023 07:19:55 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-66c729f5618so302178b3a.1;
        Sat, 24 Jun 2023 07:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687616394; x=1690208394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Lt8rVZcLBBLvWmzWUEEsEG7voRn3Ez10TeZpg/RjPk=;
        b=DLXa7stn4xDzA/kZn7A5zou3oXjJ3VH7bciBdDMbhkhymIzzxx4sP/rulplQLLe18M
         GyIqWB067HXraJy/T3GTRfYYW4RXr+yWdhtbG+venKvKAvxXl0F84v+1QOZaRP2SgKjf
         +GkIghCOdtdIrYw/Q2qOFJVFe/724YH+nIzD64mgnRSnkJJtjFn0Gd4iUT+ccb7qr/xB
         VFgIxuUyYlydkRQL7xAGF4xIG0Q8eYsT3FgVyj4QAKbXsOl7jxMKa5oG7G/Lykwhwgia
         BLtm0qpwXCOH6ny8pQp5lhEWu47qAk4gnZ5HO2fj0NFLpNPDSggTeilqtzx/AAuYZK5K
         YY1A==
X-Gm-Message-State: AC+VfDzE2J7T8MiUN/AqHun7c6WiNQe8qYZlUWhogskJHx217XoGlgMD
        qQAomgUfuvXcaF/hL9ZMK4A=
X-Google-Smtp-Source: ACHHUZ7V4ur+WjVdxiJp9SMnFICVdY4GzXniERNA4mlZ5oQMqFI4aBU4506d4ioclwCaJARbESzQrw==
X-Received: by 2002:a17:902:c44c:b0:1b0:2d08:eb51 with SMTP id m12-20020a170902c44c00b001b02d08eb51mr1857911plm.12.1687616394388;
        Sat, 24 Jun 2023 07:19:54 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id bg6-20020a1709028e8600b001b3d0aff88fsm1296336plb.109.2023.06.24.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 07:19:53 -0700 (PDT)
Date:   Sat, 24 Jun 2023 23:19:52 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Toan Le <toan@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 00/15] PCI: Convert to platform remove callback returning
 void
Message-ID: <20230624141952.GB2636347@rocinante>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> this series adapts the platform drivers below drivers/pci to use the
> .remove_new() callback. Compared to the traditional .remove() callback
> .remove_new() returns no value. This is a good thing because the driver core
> doesn't (and cannot) cope for errors during remove. The only effect of a
> non-zero return value in .remove() is that the driver core emits a warning. The
> device is removed anyhow and an early return from .remove() usually yields a
> resource leak.
> 
> By changing the remove callback to return void driver authors cannot
> reasonably assume any more that there is some kind of cleanup later.
> 
> All drivers were easy to convert as they all returned zero in their
> remove callback. Only for iproc the conversion wasn't trivial, the other
> were converted using coccinelle.
> 
> There are no interdependencies between these patches. So even if there
> are some concerns for individual patches, I ask you to apply the
> remaining set. Then I only have to care for the review feedback of the
> refused patches. (Having said that I don't expect any serious objection,
> just things like squashing or separating patches, or maybe I picked a
> wrong subject prefix.)

Applied to controller/remove-void-callbacks, thank you!

[01/15] PCI: aardvark: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/b11c76db97e7
[02/15] PCI: altera: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/3a610560aa4f
[03/15] PCI: altera-msi: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/60d03f70455c
[04/15] PCI: brcmstb: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/b169c576ad0c
[05/15] PCI: j721e: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/c86f4bd6008e
[06/15] PCI: dwc: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/221879c98698
[07/15] PCI: hisi-error: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/9a285fbbb591
[08/15] PCI: iproc: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/6f1c0a046048
[09/15] PCI: mediatek: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/5e0005409427
[10/15] PCI: mediatek-gen3: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/22626c46bb32
[11/15] PCI: mt7621: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/8c47ac2a66c4
[12/15] PCI: mvebu: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/4c3bc1b41b8f
[13/15] PCI: rockchip-host: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/2998efcd8e73
[14/15] PCI: tegra: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/c7fd95cda648
[15/15] PCI: xgene-msi: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/afbb9130d2bf

	Krzysztof
