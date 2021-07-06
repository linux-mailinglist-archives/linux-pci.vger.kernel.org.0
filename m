Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937883BD6A7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhGFMlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 08:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242161AbhGFMZt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jul 2021 08:25:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6324C622E9;
        Tue,  6 Jul 2021 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625574190;
        bh=wz4Bic0LSPWmrCj80ELZl2dM0eChPNGuIIo785wRWDw=;
        h=From:To:Cc:Subject:Date:From;
        b=RXfwtOXbimz822euPvZ9jCYUkxtuTtUsicRgUhnDJ/VlBQFDfty6hxF87aW0Tf7Gw
         GgGsvbXHPxBQEvWzc8021HYoSBJtcFtAb5OFuSaAoLGiXufB3IvOMxM+nB0XjcaOmp
         9xXfYA4uRF+lH6MrDeL61na0vPyl0XK4/M7JtpLfFXatgY3SEQazITSz3eIIOs5sl8
         qf/jyDqkE80a6QyL7LYofiV53/f5dtV187FLgxktsjIZoDR0KeCedMK0FTJI4AvP6F
         Ps08ZgTnkwu4i9cDTGQCS7wWg5O2t0IEY3XHI8wkafg3uVgoRYh+n8VC8SJltZ0GXM
         4sACa0d+6YT6Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m0k6W-004qMk-4w; Tue, 06 Jul 2021 14:23:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH RFC 0/1] Move PHY out of pcie-kirin driver
Date:   Tue,  6 Jul 2021 14:23:05 +0200
Message-Id: <cover.1625573452.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During the review of the Kirin 970 PCIe patch series, it was pointed that
the pcie-kirin driver has PHY logic mixed inside it:

   https://lore.kernel.org/lkml/CAL_JsqK7_hAw4aacHyiqJWE6zSWiMez5695+deaCSHfeWuX-XA@mail.gmail.com/

Probably due to that, support for those devices weren't added 
upstream.

Before trying to re-send it again, let's split the existing PHY code
for Kirin 960 (Hisi3660) from the driver.

Please notice that this change will alter the device tree, as a new PHY
descriptor will be needed, and the PHY properties from the pcie nodes
will need to switch.

This patch doesn't change the documentation yet, but it does change
the DTS file. If this change is OK, I'll resend this patch together with
the documentation changes.

Tested on a Hikey 960. After the patch, the PCI bridge is properly
displayed:

	$ lspci
	00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)

Unfortunately, currently I can't test if the bridge is working as this
bridge supports only non-SATA M.2 devices.  I'm acquiring one for
tests, but it will take a couple weeks to arrive.

Mauro Carvalho Chehab (1):
  PCI: dwc: pcie-kirin: split PHY interface from the driver

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi |  24 +-
 drivers/pci/controller/dwc/pcie-kirin.c   | 195 +++-------------
 drivers/phy/hisilicon/Kconfig             |  10 +
 drivers/phy/hisilicon/Makefile            |   1 +
 drivers/phy/hisilicon/phy-hi3660-pcie.c   | 261 ++++++++++++++++++++++
 5 files changed, 321 insertions(+), 170 deletions(-)
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-pcie.c

-- 
2.31.1


