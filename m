Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A304465B51
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 01:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbhLBAuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 19:50:09 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41248 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354921AbhLBAuH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:07 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2884F1A08CC;
        Thu,  2 Dec 2021 01:46:45 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DDC221A0119;
        Thu,  2 Dec 2021 01:46:44 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 0111540007;
        Wed,  1 Dec 2021 17:46:43 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 0/4] layerscape-pci binding updates
Date:   Wed,  1 Dec 2021 18:46:32 -0600
Message-Id: <20211202004636.5276-1-leoyang.li@nxp.com>
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

Updates in v2:
- Refined the description of AER/PME in binding and updated commit
  message
- Changed AER/PME to upper case
- Added Ack from Rob

Hou Zhiqiang (2):
  dt-bindings: pci: layerscape-pci: Add a optional property big-endian
  dt-bindings: pci: layerscape-pci: Update the description of SCFG
    property

Li Yang (1):
  dt-bindings: pci: layerscape-pci: define AER/PME interrupts

Xiaowei Bao (1):
  dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for
    ls1028a

 .../bindings/pci/layerscape-pci.txt           | 47 ++++++++++++-------
 1 file changed, 30 insertions(+), 17 deletions(-)

-- 
2.25.1

