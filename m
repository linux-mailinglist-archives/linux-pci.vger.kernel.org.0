Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F827A503
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1BFn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:05:43 -0400
Received: from mx.socionext.com ([202.248.49.38]:27511 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1BFn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 21:05:43 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Sep 2020 10:05:41 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 79F07180BE1;
        Mon, 28 Sep 2020 10:05:41 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 28 Sep 2020 10:05:41 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 016A81A0507;
        Mon, 28 Sep 2020 10:05:40 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/4] PCI: dwc: Move iATU register mapping to common framework
Date:   Mon, 28 Sep 2020 10:05:29 +0900
Message-Id: <1601255133-17715-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This moves iATU register mapping in the Keystone driver to common
framework. And this adds "iatu" property description to the dt-bindings
for UniPhier PCIe host and endpoint controller.

This series is split from the previous patches:
https://www.spinics.net/lists/linux-pci/msg97608.html
"[PATCH v6 0/6] PCI: uniphier: Add features for UniPhier PCIe host controller"

This has been confirmed with PCIe version 4.80 controller on UniPhier platform.
Please comfirm this series on Keystone platform if necessary.

Changes since v1:
- Use to_platform_device() instead of of_find_device_by_node()
- Add Reviewed-by: line to 4th patch for keystone
- dt-bindings: Add description for uniphier-ep

Kunihiko Hayashi (4):
  dt-bindings: PCI: uniphier: Add iATU register description
  dt-bindings: PCI: uniphier-ep: Add iATU register description
  PCI: dwc: Add common iATU register support
  PCI: keystone: Remove iATU register mapping

 .../bindings/pci/socionext,uniphier-pcie-ep.yaml     |  3 ++-
 .../devicetree/bindings/pci/uniphier-pcie.txt        |  1 +
 drivers/pci/controller/dwc/pci-keystone.c            | 20 ++++----------------
 drivers/pci/controller/dwc/pcie-designware.c         |  5 +++++
 4 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.7.4

