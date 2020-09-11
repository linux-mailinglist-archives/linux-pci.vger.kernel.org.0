Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9316265BF7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKIuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 04:50:16 -0400
Received: from mx.socionext.com ([202.248.49.38]:29476 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgIKIuP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 04:50:15 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Sep 2020 17:50:13 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 68CB260060;
        Fri, 11 Sep 2020 17:50:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Sep 2020 17:50:13 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id AE0571A050A;
        Fri, 11 Sep 2020 17:50:12 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/3] PCI: dwc: Move iATU register mapping to common framework
Date:   Fri, 11 Sep 2020 17:50:00 +0900
Message-Id: <1599814203-14441-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series is split from the previous patches:
https://www.spinics.net/lists/linux-pci/msg97608.html
"[PATCH v6 0/6] PCI: uniphier: Add features for UniPhier PCIe host controller"

This moves iATU register mapping in the Keystone driver to common
framework. And this adds "iatu" property description to the dt-bindings
for UniPhier PCIe host controller.

This has been confirmed with PCIe version 4.80 controller on UniPhier platform.
Please test this series on Keystone platform.

Kunihiko Hayashi (3):
  dt-bindings: PCI: uniphier: Add iATU register description
  PCI: dwc: Add common iATU register support
  PCI: keystone: Remove iATU register mapping

 .../devicetree/bindings/pci/uniphier-pcie.txt        |  1 +
 drivers/pci/controller/dwc/pci-keystone.c            | 20 ++++----------------
 drivers/pci/controller/dwc/pcie-designware.c         |  8 +++++++-
 3 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.7.4

