Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E322C47EAB0
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 03:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351046AbhLXC44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 21:56:56 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41550 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351000AbhLXC44 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Dec 2021 21:56:56 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AE67200B6A;
        Fri, 24 Dec 2021 03:56:55 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C47DB200B07;
        Fri, 24 Dec 2021 03:56:54 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2D74F183ACCB;
        Fri, 24 Dec 2021 10:56:53 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     lorenzo.pieralisi@arm.com, kw@linux.com, l.stach@pengutronix.de,
        bhelgaas@google.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, robh@kernel.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v8] PCI: imx: Add the imx8mm pcie support
Date:   Fri, 24 Dec 2021 10:28:04 +0800
Message-Id: <1640312885-31142-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Based on previous review patch-set [1] and no function changes, create
one update for the last patch only after merge the comments provided
by Krzysztof.
- Clean up codes. Drop the redundant inner break, and use the dev_err_probe
  replace dev_err in _probe().
- To be consistent, let the error message to be all lower-case letters.
- Add one comment to explain that there is one single bare break for
  i.MX8MM in imx6_pcie_init_phy()

[1] https://patchwork.ozlabs.org/project/linux-pci/patch/1638432158-4119-9-git-send-email-hongxing.zhu@nxp.com/

[PATCH v8] PCI: imx: Add the imx8mm pcie support

drivers/pci/controller/dwc/pci-imx6.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
1 file changed, 73 insertions(+), 8 deletions(-)

