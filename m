Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C6947C6C1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 19:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbhLUSls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 13:41:48 -0500
Received: from st43p00im-zteg10071901.me.com ([17.58.63.169]:36248 "EHLO
        st43p00im-zteg10071901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241405AbhLUSlr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 13:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1640112107; bh=C6huN6VL+o6HN6uRKRvyI2bxo42cj05WhgpeugHXIjI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=LBrureV0sljUGf30ywAB6zXiR9tCpvjxe2oCGD3T6VUqdPoUvdyoH0I7xZPlalYso
         0jsWHRjQn/iSXoV112/FjCWMWF6pSmp3p0sdWcMgaqtLZaMMb+elTIC1UfcXxGBx6Y
         K027XDAV2kW3sYVEfNLcJkUTacKkesUOh/SXl5XsR4kFEKv17CG/oOwxTpg6cmx0/+
         4DVybzk6KH00kQUcthxEAuhCdGXsW7J38mRqz5tsvRR99kUF828lRkBatitM0+5aEk
         f7Kt5LZSaWcezNUD6Myf821RB3G/ttd03Jm62yf+L6II5HNRVf87FibJl1Ng+DoQCr
         mte7RzNdLc6pw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id 5F9DC84084B;
        Tue, 21 Dec 2021 18:41:46 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH v2 0/5] Introduction of PCIe support on STi platform
Date:   Tue, 21 Dec 2021 19:40:58 +0100
Message-Id: <20211221184103.279437-1-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-21=5F04:2021-12-21=5F01,2021-12-21=5F04,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112210091
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The STi platform SoC embed a designware based PCIe controller.
This serie include the driver for the controller and DT for the
stih407-family and for the stih418-b2264 into which it is used.

Within the DT and the binding, only st,stih407-pcie compatible is
used.
Rob, could you clarify if I need to mention both compatible (st,stih407-pcie
and snps,dw-pcie) or if st,stih407-pcie is enought ?

v2: update of the pcie-st driver to add possibility to build as module
    and remove the __init of the probe

Alain Volmat (5):
  dt-bindings: pci: st-pcie: PCIe controller found on STi platforms
  pci: dwc: pcie-st: Add PCIe driver for STi platforms
  MAINTAINERS: add entry for ST STI PCIE driver
  ARM: dts: sti: add the PCIe controller node within stih407-family
  ARM: dts: sti: enable PCIe on the stih418-b2264 board

 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
 .../devicetree/bindings/pci/st,st-pcie.yaml   | 112 +++++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/stih407-family.dtsi         |  40 ++
 arch/arm/boot/dts/stih418-b2264.dts           |   5 +
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-sti.c         | 386 ++++++++++++++++++
 8 files changed, 562 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/st,st-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-sti.c

-- 
2.25.1

