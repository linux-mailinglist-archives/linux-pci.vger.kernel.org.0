Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E509B280CE6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 06:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJBEs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 00:48:58 -0400
Received: from mx.socionext.com ([202.248.49.38]:24372 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgJBEs6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 00:48:58 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 02 Oct 2020 13:48:57 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 1B6FF180B3C;
        Fri,  2 Oct 2020 13:48:57 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 2 Oct 2020 13:48:57 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id CC8CA1A0509;
        Fri,  2 Oct 2020 13:48:56 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/3] PCI: endpoint: Add endpoint restart management support
Date:   Fri,  2 Oct 2020 13:48:44 +0900
Message-Id: <1601614127-13837-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add new functions to manage recovery of configuration for endpoint controller
and restart the controller when asserting bus-reset from root complex (RC).

This feature is only available if bus-reset (PERST#) line is physically
routed between RC and endpoint, and the signal from RC also resets
the endpoint controller.

This series is only for UniPhier PCIe endpoint controller at this point.

Kunihiko Hayashi (3):
  PCI: endpoint: Add 'started' to pci_epc to set whether the controller
    is started
  PCI: endpoint: Add endpoint restart management
  PCI: uniphier-ep: Add EPC restart management support

 drivers/pci/controller/dwc/Kconfig            |   1 +
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |  34 +++++++-
 drivers/pci/endpoint/Kconfig                  |   9 ++
 drivers/pci/endpoint/Makefile                 |   1 +
 drivers/pci/endpoint/pci-epc-core.c           |   2 +
 drivers/pci/endpoint/pci-epc-restart.c        | 114 ++++++++++++++++++++++++++
 include/linux/pci-epc.h                       |  22 +++++
 7 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/endpoint/pci-epc-restart.c

-- 
2.7.4

