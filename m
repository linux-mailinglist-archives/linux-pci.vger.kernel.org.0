Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0091223576B
	for <lists+linux-pci@lfdr.de>; Sun,  2 Aug 2020 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgHBO0G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 10:26:06 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:34712 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHBO0G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 10:26:06 -0400
Received: by mail-lj1-f177.google.com with SMTP id q7so37010850ljm.1;
        Sun, 02 Aug 2020 07:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zeiAgJxHrPijvNQknHHdvjYtJyFN1FT1e2QzBTPsm24=;
        b=IHxpd+9SwtctYq+2qUbmhS2GVrZwFbbtOnDIOWWCVSr5gVtLd8XXEjSq/+0qA4+j2H
         Sun37G5GM3LyEWWVFm0/9oN8ErxA6UeXyRirnvgka7BSQOtFKLJmNwmpT0+D0f/SbvgZ
         WS8E8v1UjoYEZKyE5dh8krKABQhbT/6ZgKOumEmvPIGAcsWzMKAUgXQM/NcD8cBtThDc
         34EuDS8nN+BNmLFgP5DmVdRIzbrk5d8y+J5ICCIlSA3A7O/GyKt7KH9bGjd50m5bzdLy
         j60sWTTKcXUt8j+3iilSAgQl0rNPnFvekzj5QXOhP0n8Gs/BbV1IpZiWR+MPp50aXmlP
         YCWQ==
X-Gm-Message-State: AOAM5300QtaptUzlR8BKNxMkGLlsCKyztYxnSl//2nBwb90T7d+GOOxv
        Vo6Q8sEnTOPURhcl4aRwkeg=
X-Google-Smtp-Source: ABdhPJz3cgcIo8JIidtc9NrocQlQwtKoNwLE3saIsQCJHhsMNawOby6x6eEuxlT5d67lW0jGLW6Kmg==
X-Received: by 2002:a2e:94d5:: with SMTP id r21mr6223757ljh.424.1596378363688;
        Sun, 02 Aug 2020 07:26:03 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 193sm4214136lfa.90.2020.08.02.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 07:26:02 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        rfi@lists.rocketboards.org
Subject: [PATCH 00/10] Remove surplus dev_err() when handing an error from platform_get_irq()
Date:   Sun,  2 Aug 2020 14:25:52 +0000
Message-Id: <20200802142601.1635926-1-kw@linux.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment a lot of error handling code would print a duplicated
error message should either the platform_get_irq() or
platform_get_irq_byname() function fails to obtain an IRQ for a device.

There is no need to call the dev_err() function directly to print
a custom message when handling an error from either of these functions
as both are going to display an appropriate error message in case of
a failure.

This series aims to remove surplus call to dev_err() when handing an
error originating from either platform_get_irq() or
platform_get_irq_byname() function as per suggestion from Coccinelle.

Related commits are commit 7723f4c5ecdb ("driver core: platform: Add an
error message to platform_get_irq*()") and commit 98051ba2b28b
("coccinelle: Add script to check for platform_get_irq() excessive
prints").

Krzysztof Wilczyński (10):
  PCI: dwc: Remove dev_err() when handing an error from
    platform_get_irq()
  PCI: mobiveil: Remove dev_err() when handing an error from
    platform_get_irq()
  PCI: tegra: Remove dev_err() when handing an error from
    platform_get_irq()
  PCI: altera: Remove dev_err() when handing an error from
    platform_get_irq()
  PCI: host-generic: Remove dev_err() when handing an error from
    platform_get_irq()
  PCI: v3-semi: Remove dev_err() when handing an error from
    platform_get_irq()
  PCI: altera-msi: Remove dev_err() when handing an error from
    platform_get_irq()
  PCI: xgene-msi: Remove dev_err() when handing an error from
    platform_get_irq()
  PCI: rockchip: Remove dev_err() when handing an error from
    platform_get_irq()
  PCI: xilinx-nwl: Remove dev_err() when handing an error from
    platform_get_irq()

 drivers/pci/controller/dwc/pci-dra7xx.c              |  8 ++------
 drivers/pci/controller/dwc/pci-exynos.c              |  9 +++------
 drivers/pci/controller/dwc/pci-imx6.c                |  4 +---
 drivers/pci/controller/dwc/pci-keystone.c            |  4 +---
 drivers/pci/controller/dwc/pci-meson.c               |  4 +---
 drivers/pci/controller/dwc/pcie-armada8k.c           |  4 +---
 drivers/pci/controller/dwc/pcie-artpec6.c            |  4 +---
 drivers/pci/controller/dwc/pcie-histb.c              |  4 +---
 drivers/pci/controller/dwc/pcie-kirin.c              |  5 +----
 drivers/pci/controller/dwc/pcie-spear13xx.c          |  5 ++---
 drivers/pci/controller/dwc/pcie-tegra194.c           |  4 +---
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c   |  5 ++---
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c |  4 +---
 drivers/pci/controller/pci-tegra.c                   |  8 ++------
 drivers/pci/controller/pci-v3-semi.c                 |  5 ++---
 drivers/pci/controller/pci-xgene-msi.c               |  2 --
 drivers/pci/controller/pcie-altera-msi.c             |  1 -
 drivers/pci/controller/pcie-altera.c                 |  4 +---
 drivers/pci/controller/pcie-rockchip-host.c          | 12 +++---------
 drivers/pci/controller/pcie-tango.c                  |  4 +---
 drivers/pci/controller/pcie-xilinx-nwl.c             | 11 ++---------
 21 files changed, 29 insertions(+), 82 deletions(-)

-- 
2.27.0

