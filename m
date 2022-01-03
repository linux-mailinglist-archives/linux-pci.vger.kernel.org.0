Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B74482ED2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 08:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiACHr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jan 2022 02:47:56 -0500
Received: from st43p00im-ztdg10071801.me.com ([17.58.63.171]:41994 "EHLO
        st43p00im-ztdg10071801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232029AbiACHr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jan 2022 02:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641196074; bh=MwMZsATWpgmG+kPynE5dyXpf6f+nL7GftB7qOw0on7Y=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Wgs5HpiCTnVU9fBVHu7pF5O2E60NBd6nTQN1DGYzs+h1XVPn47pUk36iVcz9u10z1
         zmPYRTM2Kpe5gx+3dJbe3kQZqlxyBsZxhDNAe06McjYB40FhQ9SdKB9AoT4jbN7+n7
         81/7RRfzxqnnbxxUJxYDfhvppATcZc0ok0mmGdtB4qrRj/lsKPRklBFN5XOkUZxqhD
         3iZnOihzMRQ70bAhbBqHYbjZ2Xdx14BgxuWSV/3+YBwyz1zAckPtLIdCYQvQLIbdaQ
         pmwVX+HpwjYBvAgPUB+LIA93lKNaqJeQytDbTGCY9SGpPCJnCrEEqmOCGOWmjbDdCl
         mzIuprer1iHPQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10071801.me.com (Postfix) with ESMTPSA id DAB953C097A;
        Mon,  3 Jan 2022 07:47:53 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH RESEND v2 0/5] Introduction of PCIe support on STi platform
Date:   Mon,  3 Jan 2022 08:47:26 +0100
Message-Id: <20220103074731.3651-1-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-03=5F01:2021-12-30=5F02,2022-01-03=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2201030052
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

RESEND since not all patches made their way to the mailing list on
previous attempt.

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

