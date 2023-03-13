Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959D96B77CF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 13:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCMMm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 08:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCMMmt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 08:42:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F5367836;
        Mon, 13 Mar 2023 05:42:13 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D6OxcH020021;
        Mon, 13 Mar 2023 05:42:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=QbGEcxpzE7v7DZCBoM6Drm+kCnSyBnm30H0DxO8Czcs=;
 b=T+9ApvAj0knguCEDaX2Bt5jFvriy6TzkNgmMWZTEDvtJkRMqULN2Kre2nssCMYrM3qDg
 ysFvLLp6dkcKpMyvvpJzcXJVoKD02PlWbc0/016tWDzbfpP7GtMYlwHZqwVGdntigaAH
 NUbuqIleLmcmLjbXb2UVl8Z/sfRwwoSgxlSmtVK7hIIxlC9xr9RI+DNwNCqeTKMf08sl
 PMIifvH0GCDxhMVUjLR4CkZgm/qYRh7G/Fs4V57E9jEARa0RyKhpjNw2Jo5UuVU+2flo
 rTkx/YJsOZVstIoY0iDVoEmIj7OC3MpSiiLn1wfTWGATjcP/CiIHZfTIteSxZKrf56yV Kw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3p8t1t5gex-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:42:05 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 05:40:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 13 Mar 2023 05:40:47 -0700
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id C75165B6921;
        Mon, 13 Mar 2023 05:40:43 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v4 0/8] PCI: dwc: Add support for Marvell AC5 SoC
Date:   Mon, 13 Mar 2023 14:40:08 +0200
Message-ID: <20230313124016.17102-1-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: uBiVmoUcpxeuVSIc_FuJTX5gg8acRZlI
X-Proofpoint-ORIG-GUID: uBiVmoUcpxeuVSIc_FuJTX5gg8acRZlI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add support for AC5 SoC with MSI and in message emulated INTx mode.
There are differences in the registers addresses, blocks, DDR location
for coherent DMA allocation and additional implementation specific registers.
In addition, support cases of older Designware IP (Armada 7020) which supports
above 4GB PCIe physical memory window by use of device tree.

v4:
   1) Fix commit subject / messages formatting and naming

   2) Remove empty lines removal / addition

   3) Split patch number five from series to two patches

   4) Replace added dt-binding for DMA mask with dma-ranges

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


Elad Nachman (5):
  dt-bindings: PCI: dwc: Add dma-ranges, region mask
  PCI: armada8k: support AC5 INTx PCIe interrupts
  PCI: armada8k: support reg regions according to DT.
  PCI: dwc: Introduce configurable DMA mask
  PCI: dwc: Introduce region limit from DT

Raz Adashi (1):
  PCI: armada8k: Add AC5 SoC support

Vadym Kochan (1):
  dt-bindings: PCI: armada8k: Add compatible string for AC5 SoC

Yuval Shaia (1):
  PCI: armada8k: Add AC5 MSI support

 .../devicetree/bindings/pci/pci-armada8k.txt  |   4 +-
 .../bindings/pci/snps,dw-pcie-common.yaml     |   5 +
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   6 +
 drivers/pci/controller/dwc/pcie-armada8k.c    | 184 +++++++++++++++---
 .../pci/controller/dwc/pcie-designware-host.c |  28 ++-
 drivers/pci/controller/dwc/pcie-designware.c  |  12 +-
 6 files changed, 206 insertions(+), 33 deletions(-)

-- 
2.17.1

