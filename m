Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C05950B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 09:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF1HfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 03:35:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55227 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbfF1HfQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jun 2019 03:35:16 -0400
X-UUID: aa8ceb0559b44ced9d2a7492dd504452-20190628
X-UUID: aa8ceb0559b44ced9d2a7492dd504452-20190628
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1631612174; Fri, 28 Jun 2019 15:35:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Jun 2019 15:35:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Jun 2019 15:35:11 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>
Subject: [v2,0/2] PCI: mediatek: Add support for MT7629
Date:   Fri, 28 Jun 2019 15:34:23 +0800
Message-ID: <20190628073425.25165-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series patches modify pcie-mediatek.c and dt-bindings compatible
string to support MT7629 PCIe host.

Jianjun Wang (2):
  dt-bindings: PCI: Add support for MT7629
  PCI: mediatek: Add controller support for MT7629

 .../devicetree/bindings/pci/mediatek-pcie.txt  |  1 +
 drivers/pci/controller/pcie-mediatek.c         | 18 ++++++++++++++++++
 include/linux/pci_ids.h                        |  1 +
 3 files changed, 20 insertions(+)

-- 
2.18.0

