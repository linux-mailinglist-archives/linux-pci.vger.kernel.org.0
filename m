Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF53034E30F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 10:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhC3IWn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 04:22:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39858 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231187AbhC3IW1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 04:22:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9032B20526A;
        Tue, 30 Mar 2021 10:22:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D191B202FF2;
        Tue, 30 Mar 2021 10:22:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 934E0402EC;
        Tue, 30 Mar 2021 10:22:13 +0200 (CEST)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [RESEND v4 0/2] add one regulator used to power up pcie phy
Date:   Tue, 30 Mar 2021 16:08:19 +0800
Message-Id: <1617091701-6444-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes:
Only add "Reviewed-by: Lucas Stach <l.stach@pengutronix.de>" in the
first patch. No other changes. Make it easier to be integrated later.

[RESEND v4 1/2] dt-bindings: imx6q-pcie: add one regulator used to
[RESEND v4 2/2] PCI: imx: clear vreg bypass when pcie vph voltage is
