Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE136405D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbhDSLWy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 07:22:54 -0400
Received: from m12-11.163.com ([220.181.12.11]:51577 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235872AbhDSLWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Apr 2021 07:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Hs9dI31bm6YLOsv42Z
        M+ClLVyt3EquKg1Qs/xnQ9x6U=; b=UWYkpSBuvdGB8ZCwmRDyQC9PAUUfptPjMz
        mSH9e1jcmthLYe3V/aK1lyVspq42EhjlGkir1Gs1wEtvdt4JRy7ANmb8W6KVFARE
        4ACWNIsgfRQrr+baDCPqKjQunF6xmoZDywoPWaLoeHIg6a2QpwW+5XWYH1SaV1hf
        UuObyX6/g=
Received: from ubuntu.localdomain (unknown [117.61.19.156])
        by smtp7 (Coremail) with SMTP id C8CowADX73ftZ31g1IMEYA--.8615S2;
        Mon, 19 Apr 2021 19:22:21 +0800 (CST)
From:   Siyu Jin <jinsiyu940203@163.com>
To:     linux-pci@vger.kernel.org
Cc:     Siyu Jin <jinsiyu940203@163.com>
Subject: [PATCH] Bug fix: 500ms is not enough for pcie training
Date:   Mon, 19 Apr 2021 19:22:18 +0800
Message-Id: <20210419112218.10921-1-jinsiyu940203@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowADX73ftZ31g1IMEYA--.8615S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4fCr4rCr17Kr1xGw15urg_yoWkurbE9w
        17WF1UJ3ykWrnIka1ay3yfKrZ0vasFg3Wjka1vvF1Yya1DZr18Jr92va4DAF15Cr47AF92
        yryqvr1UGa43JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNNtxJUUUUU==
X-Originating-IP: [117.61.19.156]
X-CM-SenderInfo: 5mlq2xd1xzkiqsqtqiywtou0bp/1tbiow1511UMWyp3oAAAs-
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index f1d08a1b1591..9da831b2b7c2 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -332,7 +332,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	/* 500ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
 				 status, PCIE_LINK_UP(status), 20,
-				 500 * USEC_PER_MSEC);
+				 1000 * USEC_PER_MSEC);
 	if (err) {
 		dev_err(dev, "PCIe link training gen1 timeout!\n");
 		goto err_power_off_phy;
@@ -349,7 +349,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)

 		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
 					 status, PCIE_LINK_IS_GEN2(status), 20,
-					 500 * USEC_PER_MSEC);
+					 1000 * USEC_PER_MSEC);
 		if (err)
 			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
 	}
--
2.17.1

