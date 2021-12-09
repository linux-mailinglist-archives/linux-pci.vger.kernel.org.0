Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAD446F650
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhLIWCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 17:02:52 -0500
Received: from st43p00im-ztdg10071801.me.com ([17.58.63.171]:47752 "EHLO
        st43p00im-ztdg10071801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231286AbhLIWCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 17:02:52 -0500
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 17:02:52 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639086838; bh=M0B2liDwXjvBYjwMmljDiZ2A1vTqkXdsDWnp7pT78E4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=uacvPA9+rrGAP5qyGsY+iGyF9eUKQ/WvDM9vxuA2ox5yc2SViSdHyjNUY7XlC2Hf0
         G/NoEPWZBaLIXhZgSMALGRiwK2llvZ/tIHAY2D9mBwXMuotMdA5QTNYNIhq1w8jNcR
         wjSj5dSiK8rFA0Vgcary1zQigjlsqiwJwvmyjuLjU1LEimfSke0S7/HMPhew5WT+Ax
         ha3StvybsIomO/l4x2RqQ3DElhtXb7bLMdZr3liPxOGJnL64F3o22owS2wu/YF+C1D
         yqdPnGmHrSeroGl0U/3cr+lSESPPGaKqfGl5LSp83cM7z+n1mPpYOvUx/8Ijr2aQiT
         BjE3/paBDfAsw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10071801.me.com (Postfix) with ESMTPSA id BE1F1540475;
        Thu,  9 Dec 2021 21:53:56 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH 0/5] Introduction of PCIe support on STi platform
Date:   Thu,  9 Dec 2021 22:53:45 +0100
Message-Id: <20211209215350.4207-1-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-09=5F08:2021-12-08=5F01,2021-12-09=5F08,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=963 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112090112
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

Alain Volmat (5):
  dt-bindings: pci: st-pcie: PCIe controller found on STi platforms
  pci: dwc: pcie-st: Add PCIe driver for STi platforms
  MAINTAINERS: add entry for ST STI PCIE driver
  ARM: dts: sti: add the PCIe controller node within stih407-family
  ARM: dts: sti: enable PCIe on the stih418-b2264 board

 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
 .../devicetree/bindings/pci/st,st-pcie.yaml   | 112 ++++++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/stih407-family.dtsi         |  40 ++
 arch/arm/boot/dts/stih418-b2264.dts           |   5 +
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-sti.c         | 380 ++++++++++++++++++
 8 files changed, 556 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/st,st-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-sti.c

-- 
2.25.1

