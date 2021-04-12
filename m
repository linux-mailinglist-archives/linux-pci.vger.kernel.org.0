Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4664C35C9E2
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbhDLPbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 11:31:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30960 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242880AbhDLPbm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 11:31:42 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CFUnNF024627;
        Mon, 12 Apr 2021 08:31:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pfpt0220;
 bh=WQ9KSSMw3gB00CLH3olvDGSrpriCskWfLG2Cr5CDGCc=;
 b=NopksMsnpvNeFASozXqYMosPw8oLDNdA1HQf6kCBZxN8/s+srhsRqC8IZVHNQx8SXpwk
 ppBzfgY5FZJ08suk6iDeV1r7cbBwhdWKb7CFjZnsYCkyVr0cVh2Ud1kn84AVBXsVnuIY
 QApAwmdyseQ6QE9EQrFCqW20Xr0+DSWiYu+J+see/OLNYsSTruSiKJNRmYugA/fE0pkR
 FlPVfUA4dK6i7PkDOnv7A8Y5rPvP/EnF9sMjqLDFVfryB+Rb/AA+IQpOf+OioBjYglOO
 jXn5ueDVcTyUgS+QV4bqbw8VLdpDqLsIHhTbl9ENORqWbjqL+Gom/1VhK6/J4Zqy3xu1 pw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 37vpuu0d45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 08:31:07 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:05 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 08:31:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 08:31:05 -0700
Received: from nw-bp.marvell.com (nw-bp.marvell.com [10.5.24.22])
        by maili.marvell.com (Postfix) with ESMTP id E820A3F7043;
        Mon, 12 Apr 2021 08:31:00 -0700 (PDT)
From:   <bpeled@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <kostap@marvell.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <oferh@marvell.com>, <bpeled@marvell.com>
Subject: =?UTF-8?q?=5B=E2=80=9DPATCH=E2=80=9D=200/5=5D=20Asynchronous=20linkdown=20recovery?=
Date:   Mon, 12 Apr 2021 18:30:51 +0300
Message-ID: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GYgbJt9xgemEcw8e4LGjCaA058OcTG64
X-Proofpoint-ORIG-GUID: GYgbJt9xgemEcw8e4LGjCaA058OcTG64
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
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

Ben Peled (5):
  PCI: armada8k: Disable LTSSM on link down interrupts
  PCI: armada8k: Add link-down handle
  PCI: armada8k: add device reset to link-down handle
  dt-bindings: pci: add system controller and MAC reset bit to    
    Armada 7K/8K controller bindings
  arm64: dts: marvell: add pcie mac reset to pcie

 Documentation/devicetree/bindings/pci/pci-armada8k.txt |   6 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi          |   7 ++
 drivers/pci/controller/dwc/pcie-armada8k.c             | 126 ++++++++++++++++++++
 3 files changed, 139 insertions(+)

-- 
2.7.4

