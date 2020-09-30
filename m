Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC12E27E06E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 07:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI3FgT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 01:36:19 -0400
Received: from mx.socionext.com ([202.248.49.38]:57167 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgI3FgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 01:36:18 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Sep 2020 14:36:10 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 4BA0F60060;
        Wed, 30 Sep 2020 14:36:10 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Sep 2020 14:36:10 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 801AE1A0509;
        Wed, 30 Sep 2020 14:36:09 +0900 (JST)
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
Subject: [PATCH v3 0/4] PCI: dwc: Move iATU register mapping to common framework
Date:   Wed, 30 Sep 2020 14:36:03 +0900
Message-Id: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com>
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

Changes since v2:
- dt-bindings: Fix errors from dt_binding_check

Changes since v1:
- Use to_platform_device() instead of of_find_device_by_node()
- Add Reviewed-by: line to 4th patch for keystone
- dt-bindings: Add description for uniphier-ep

Kunihiko Hayashi (4):
  dt-bindings: PCI: uniphier: Add iATU register description
  dt-bindings: PCI: uniphier-ep: Add iATU register description
  PCI: dwc: Add common iATU register support
  PCI: keystone: Remove iATU register mapping

 .../bindings/pci/socionext,uniphier-pcie-ep.yaml     | 20 ++++++++++++++------
 .../devicetree/bindings/pci/uniphier-pcie.txt        |  1 +
 drivers/pci/controller/dwc/pci-keystone.c            | 20 ++++----------------
 drivers/pci/controller/dwc/pcie-designware.c         |  5 +++++
 4 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.7.4

