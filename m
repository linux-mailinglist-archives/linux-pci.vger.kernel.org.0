Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAA7B48B7
	for <lists+linux-pci@lfdr.de>; Sun,  1 Oct 2023 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjJARDi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Oct 2023 13:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjJARDh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Oct 2023 13:03:37 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30C4E6
        for <linux-pci@vger.kernel.org>; Sun,  1 Oct 2023 10:03:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqS-0005BE-PV; Sun, 01 Oct 2023 19:03:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqM-00AKTT-4F; Sun, 01 Oct 2023 19:02:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqL-0079nM-Qh; Sun, 01 Oct 2023 19:02:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Siva Reddy Kallam <siva.kallam@samsung.com>,
        Surendranath Gurivireddy Balla <suren.reddy@samsung.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc:     Rob Herring <robh@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 0/4] pci: Fix some section mismatches
Date:   Sun,  1 Oct 2023 19:02:50 +0200
Message-Id: <20231001170254.2506508-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sA6ad3X5iUkL2qhJAsZsIuRXKnigfYSc+1OexbjnF7Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlGaY2LW3MWmF/XhhO25KC7SqNqPeRdiMhhtCt5 JFtEgodsDmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRmmNgAKCRCPgPtYfRL+ TsN5B/4zTs7MkS4yfa2lME9woY5tX1qcMTZyYSeWgqw1OdHyEvE/SYViuzwKlp2vAE9PcxDVVHQ TzTp2TIZuP+5GmotKGAZtFLrUuTAIStIW0zQvAr2cJXKkFVS+OPQRJlDxspdKJ7RmSDmmwiAkuN N6lyzgCTvjPPzI4kCccSkFoPrMLSs2fyz9PG7Mq5sqMwarULlU6eUR6+Kh7u47Jpnk+Xe315tK9 BElLPFR3bMkpTtejhaTUFSU4EmKAVFMjZV7G2wo4XX22gjcb3L7WyXW683Frf0V8HDtJGwctePT 5v7OJrHLn5/9VqK2CaE5nOlcAh2Is7i7dBqHEGGVbKIb4BcM
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

modpost checks about section mismatches are about to get stronger, see
https://lore.kernel.org/linux-kbuild/20230930165204.2478282-1-u.kleine-koenig@pengutronix.de
.

With the above patch applied, enabling the exynos and kirin drivers as
modules result in a warning about their remove functions that is fixed
here. The keystone driver is a bit special as it can only be enabled
built-in and used __refdata on its driver struct. It also had a similar
issue for .probe fixed in the last patch.

IMHO all four patches qualify for backporting to stable.

Best regards
Uwe

Uwe Kleine-König (4):
  PCI: exynos: Don't put .remove callback in .exit.text section
  PCI: kirin: Don't put .remove callback in .exit.text section
  PCI: keystone: Don't put .remove callback in .exit.text section
  PCI: keystone: Don't put .probe callback in .init.text section

 drivers/pci/controller/dwc/pci-exynos.c   | 4 ++--
 drivers/pci/controller/dwc/pci-keystone.c | 8 ++++----
 drivers/pci/controller/dwc/pcie-kirin.c   | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.40.1

