Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097A459C086
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiHVN2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiHVN2R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 09:28:17 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22063E9A;
        Mon, 22 Aug 2022 06:28:15 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A17661A2999;
        Mon, 22 Aug 2022 15:28:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 676081A23C3;
        Mon, 22 Aug 2022 15:28:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B0690180031C;
        Mon, 22 Aug 2022 21:28:12 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, vkoul@kernel.org,
        marcel.ziswiler@toradex.com, kishon@ti.com
Cc:     hongxing.zhu@nxp.com, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1 0/2] Fix the wrong order of phy callbacks 
Date:   Mon, 22 Aug 2022 21:10:54 +0800
Message-Id: <1661173856-1192-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refer [1], phy_init() must be called before phy_power_on().
This series used to fix the wrong order of the phy_init() and phy_power_on(),
introduced by commit 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
Tested on i.MX8MM EVK board when one NVME device is used.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/phy-core.c?id=v5.19-rc1#n233

[PATCH v1 1/2] PCI: imx6: Fix the wrong order of phy_init() and
[PATCH v1 2/2] phy: freescale: imx8m-pcie: Fix the wrong order of
