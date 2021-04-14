Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124AE35F4B3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhDNNVl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 09:21:41 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:20894 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhDNNVk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 09:21:40 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EDG1vZ020128;
        Wed, 14 Apr 2021 06:21:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pfpt0220;
 bh=Qy9aN4zLoLRY1HY2tMboGlxdf3jeP2pyWyXffE/TaE8=;
 b=KdPby2kGgSfG2THoRM8xoKD6VFgsAKlRJwezjO5mFbcUK2tjyWOX3A50ukoJBi6Rxm1s
 b57hD8j3bEFIeC4LDSqUPkiwMTyHiz58encmU+0M1gS9PN4IDXooFRT/uSBnhdbBSWDd
 Xou33maOWxDdj371yfvG8yl2bxoGQ+SoFAsQaioQ83HaCs7LC7ToayY8+GdIOEgMktVD
 0Umpfdg6wfAP4RZRWVTaATKxxpQQLYCCXZPBX2X3xuj5vRhP7VjvDYsex12kAuVIlNiA
 g5E+FwvYJ3k4+jqJ6nyUojN61cJxzlnmBJkPM7OQ1bEC1KS1m5e9spympHT8URsqbsHw Og== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 37wqtm1sv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 06:21:03 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Apr
 2021 06:21:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 06:21:01 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id B67013F7040;
        Wed, 14 Apr 2021 06:20:57 -0700 (PDT)
From:   <bpeled@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <kostap@marvell.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <oferh@marvell.com>,
        Ben Peled <bpeled@marvell.com>
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=20v2=200/5=5D=20Asynchronous=20linkdown=20recovery?=
Date:   Wed, 14 Apr 2021 16:20:49 +0300
Message-ID: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JttZFIy73utjp4IY9FEVPP5pgpeWZPY4
X-Proofpoint-GUID: JttZFIy73utjp4IY9FEVPP5pgpeWZPY4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_07:2021-04-14,2021-04-14 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Peled <bpeled@marvell.com>

The following patches implement the required procedure to handle and recover from asynchronous PCIE link down events on Armada SoCs.

The procedure is defined as the following:
1) Prevent new access to the PCI-E I/F by disabling the LTSSM
2) Flush all pending transaction/access to the PCI-E I/F
3) HW reset the PCIE end point device (based on board support)
4) Reset the PCIE MAC
5) Reinitialize the PCIE root complex and enable the LTSSM

The execution of this procedure is triggered by the PCIE RST_LINK_DOWN interrupt

v1 --> v2
- Add missing device reset to link-down handle

Ben Peled (5):
  PCI: armada8k: Disable LTSSM on link down interrupts
  PCI: armada8k: Add link-down handle
  dt-bindings: pci: add system controller and MAC reset bit to    
    Armada 7K/8K controller bindings
  arm64: dts: marvell: add pcie mac reset to pcie
  PCI: armada8k: add device reset to link-down handle

 Documentation/devicetree/bindings/pci/pci-armada8k.txt |   6 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi          |   7 ++
 drivers/pci/controller/dwc/pcie-armada8k.c             | 127 ++++++++++++++++++++
 3 files changed, 140 insertions(+)

-- 
2.7.4

