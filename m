Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E692E3957A9
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEaJBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 05:01:32 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:45462 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhEaJBb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 05:01:31 -0400
Received: from [77.244.183.192] (port=63376 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lndm3-0005h2-23; Mon, 31 May 2021 10:59:51 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pci@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2 0/4] PCI: dwc: pci-dra7xx: miscellaneous improvements
Date:   Mon, 31 May 2021 10:59:30 +0200
Message-Id: <20210531085934.2662457-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an series of mixed improvements to the DRA7 PCI controller driver:
allow building as a loadabel module, allow to get and enable a clock and a
small cleanup.

Luca

Luca Ceresoli (4):
  PCI: dwc: Export more symbols to allow modular drivers
  PCI: dra7xx: Make it a kernel module
  PCI: dra7xx: Remove unused include
  PCI: dra7xx: Get an optional clock

 drivers/pci/controller/dwc/Kconfig            |  6 ++---
 drivers/pci/controller/dwc/pci-dra7xx.c       | 22 +++++++++++++++++--
 .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
 drivers/pci/controller/dwc/pcie-designware.c  |  1 +
 4 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.25.1

