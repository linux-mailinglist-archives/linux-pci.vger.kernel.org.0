Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5B932035D
	for <lists+linux-pci@lfdr.de>; Sat, 20 Feb 2021 04:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhBTDCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 22:02:32 -0500
Received: from inva020.nxp.com ([92.121.34.13]:45538 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhBTDCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Feb 2021 22:02:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F0C001A0A9D;
        Sat, 20 Feb 2021 04:01:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AA1351A0103;
        Sat, 20 Feb 2021 04:01:40 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F256040291;
        Sat, 20 Feb 2021 04:01:33 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] PCI: imx6: Limit DBI register length for imx6qp PCIe
Date:   Sat, 20 Feb 2021 10:49:47 +0800
Message-Id: <1613789388-2495-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes from v1 to v2:
- Add reviewed by Lucas and Krzysztof.
- Refine the subject and commit refer to Krzysztof comments.

drivers/pci/controller/dwc/pci-imx6.c | 1 +
1 file changed, 1 insertion(+)

[PATCH v2] PCI: imx6: Limit DBI register length for imx6qp PCIe
