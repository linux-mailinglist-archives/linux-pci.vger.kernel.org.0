Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C97B457A03
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhKTATc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:19:32 -0500
Received: from inva021.nxp.com ([92.121.34.21]:59956 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233135AbhKTAT3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:19:29 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D3A9C200AFE;
        Sat, 20 Nov 2021 01:16:25 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 98C8D200A97;
        Sat, 20 Nov 2021 01:16:25 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id BECE440A85;
        Fri, 19 Nov 2021 17:16:24 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 0/4] layerscape-pci binding updates
Date:   Fri, 19 Nov 2021 18:16:17 -0600
Message-Id: <20211120001621.21246-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series includes two binding changes from Zhiqiang's previous
submission rebased to latest 5.16-rc1:
[PATCHv5 0/6] PCI: layerscape: Add power management support

They describe the hardware and are not necessarily connected with the PM
driver changes.  The series also includes two other binding updates to
better describe the pcie hardware.

Hou Zhiqiang (2):
  dt-bindings: pci: layerscape-pci: Add a optional property big-endian
  dt-bindings: pci: layerscape-pci: Update the description of SCFG
    property

Li Yang (1):
  dt-bindings: pci: layerscape-pci: define aer/pme interrupts

Xiaowei Bao (1):
  dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for
    ls1028a

 .../bindings/pci/layerscape-pci.txt           | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.25.1

