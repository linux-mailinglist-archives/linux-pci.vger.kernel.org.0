Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840EC393D52
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 08:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhE1Gsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 02:48:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40930 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229569AbhE1Gsh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 02:48:37 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4275A201D6F;
        Fri, 28 May 2021 08:47:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com 4275A201D6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector4; t=1622184422;
        bh=YwS4G5iPwgQpNzJLl6tLYsJ2x2Dx6Yg++Sh0zyyxTlM=;
        h=From:To:Cc:Subject:Date:From;
        b=IEANqepTzW+LLmLgtt5T2CjgCOVWBxJvZfr9kQcYf/+Hhtur6OcIfe7IIeDizh3E+
         M/kZMCvDv0ZiSPQBqf1pyr+E2751ncUzPdGF1gwjD7pDasPNoIHu1Y2VzPDHKOPBkE
         X77Ysliu/K1+kJO7obR/wSGmT2OsXvryeE0dAvp/pxgKdrYB7l4NWhWSp9U42nlfyp
         6q2zaH2fl/ihVVv1NSE0MmKcK/9GPPysertxqXo7pRR7mNhx4nrfXz2TARd/a6eSR0
         GcviaU89sGE4CoDR39MRFsruv6EQgf8UB5SffJMyd/P2Qpz5MOF6gxMinVSfF6fxqL
         1TH2ulvXXizkw==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BE02200C3C;
        Fri, 28 May 2021 08:46:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com 7BE02200C3C
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 670394029B;
        Fri, 28 May 2021 14:46:51 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v5 0/2] PCI: imx6: add one regulator used to power up pcie phy
Date:   Fri, 28 May 2021 14:29:41 +0800
Message-Id: <1622183383-3287-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt |  3 +++
drivers/pci/controller/dwc/pci-imx6.c                    | 20 ++++++++++++++++++++
2 files changed, 23 insertions(+)

[PATCH v5 1/2] dt-bindings: imx6q-pcie: Add "vph-supply" for PHY
[PATCH v5 2/2] PCI: imx6: Enable PHY internal regulator when supplied
