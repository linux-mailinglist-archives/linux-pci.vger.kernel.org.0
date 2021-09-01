Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414ED3FD2C3
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 07:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbhIAFRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 01:17:08 -0400
Received: from mx.socionext.com ([202.248.49.38]:19437 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhIAFRI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 01:17:08 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 01 Sep 2021 14:16:11 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 428262022042;
        Wed,  1 Sep 2021 14:16:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 1 Sep 2021 14:16:11 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 70C0AB62B7;
        Wed,  1 Sep 2021 14:16:10 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/2] PCI: endpoint: Fix core_init_notifier feature
Date:   Wed,  1 Sep 2021 14:15:59 +0900
Message-Id: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series has two fixes for core_init_notifier feature.

Fix the bug that the driver can't register its notifier function
if core_init_notifier == true and linkup_notifier == false.

If enabling the controller is delayed due to core_init_notifier, 
accesses to the controller register should be avoided rather than
enabling the controller.

Changes since v1:
- Add Acked-by and Reviewed-by lines

Kunihiko Hayashi (2):
  PCI: endpoint: pci-epf-test: register notifier if only
    core_init_notifier is enabled
  PCI: designware-ep: Fix the access to DBI/iATU registers before
    enabling controller

 drivers/pci/controller/dwc/pcie-designware-ep.c | 81 +++++++++++++------------
 drivers/pci/endpoint/functions/pci-epf-test.c   |  2 +-
 2 files changed, 42 insertions(+), 41 deletions(-)

-- 
2.7.4

