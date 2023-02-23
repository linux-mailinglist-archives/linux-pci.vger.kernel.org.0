Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7CC6A0F12
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 19:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBWSGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 13:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBWSGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 13:06:06 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBBD4FAA8;
        Thu, 23 Feb 2023 10:06:05 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NHVA6G027360;
        Thu, 23 Feb 2023 10:05:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=cJtPNFCr0v5OLJisx3imEHbO/0vzHn18+sJHW6lT7c4=;
 b=GnmvEx+F8PNvPJYX+Bzerv9J+NqwE8YUSw0ee1BNDIX0t9atYbCm2hvPkJtu7JZPGvN/
 NMWmFxsSpr7Dc9Tr3qpvDL+CeYhx8jXqSZxU7qqG8B1BGZgdi5PFY6vuhwBxhkHOFpCv
 KAptZzGhSn61EUDsSBSfrZnWuTE9rITytivsAXIqWPYQCuBpKW/t7brJXuM8O5w9SNZ1
 mbChzsle+Z0MJNUTQz1rc4b2WoI0IZ1rq1tLpMjIkOfInNsGxKjeYsqty3pQ5drfo2Lw
 43244P2jrgmhQcg14FForwE5YjPjlEWxhX2dTYhKDWGi/UCg6AWtSAwVP6PybX9w4S2i Gw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nwy5h2cuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:05:51 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 10:05:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 23 Feb 2023 10:05:49 -0800
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 2D5AD3F7092;
        Thu, 23 Feb 2023 10:05:46 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v3 0/7] PCI: dwc: Add support for Marvell AC5 SoC
Date:   Thu, 23 Feb 2023 20:05:24 +0200
Message-ID: <20230223180531.15148-1-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: _hXnW85fch48t-qUSZlTLyCx5p93Ha95
X-Proofpoint-ORIG-GUID: _hXnW85fch48t-qUSZlTLyCx5p93Ha95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_11,2023-02-23_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add support for AC5 SoC with MSI and in message emulated legacy mode.
There are differences in the registers addresses, blocks, DDR location
for coherent DMA allocation and additional implementation specific registers.
In addition, support cases of older Designware IP (Armada 7020) which supports
above 4GB PCIe physical memory window by use of device tree.

v3:
   1) Add dt bindings for DMA and region mask bits

   2) Support AC5 Legacy PCIe interrupts

   3) Introduce Configurable DMA mask

   4) Introduce region limit from DT

v2:
   1) add patch with adding compatible string for dt-bindings description

   2) fix W1 warnings which caused by unused leftover code

   3) Use one xlate function to translate ac5 dbi access. Also add
      mode description in comments about this translation.

   4) Use correct name of Raz

   5) Use matching data to pass the SoC specific params (type & ops)

Elad Nachman (4):
  dt-bindings: PCI: dwc: add DMA, region mask bits
  PCI: dwc: support AC5 Legacy PCIe interrupts
  PCI: dwc: Introduce Configurable DMA mask
  PCI: dwc: Introduce region limit from DT

Raz Adashi (1):
  PCI: armada8k: Add AC5 SoC support

Vadym Kochan (1):
  dt-bindings: PCI: armada8k: Add compatible string for AC5 SoC

Yuval Shaia (1):
  PCI: armada8k: Add MSI support for AC5 SoC

 .../devicetree/bindings/pci/pci-armada8k.txt  |   4 +-
 .../bindings/pci/snps,dw-pcie-common.yaml     |  10 +
 drivers/pci/controller/dwc/pcie-armada8k.c    | 184 +++++++++++++++---
 .../pci/controller/dwc/pcie-designware-host.c |  23 ++-
 drivers/pci/controller/dwc/pcie-designware.c  |  13 +-
 5 files changed, 197 insertions(+), 37 deletions(-)

-- 
2.17.1

