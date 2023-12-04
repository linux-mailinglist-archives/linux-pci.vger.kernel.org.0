Return-Path: <linux-pci+bounces-401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CB6802F30
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 10:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F881C2097D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8BD1D553;
	Mon,  4 Dec 2023 09:48:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16AE102
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 01:48:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YR-0003eL-U4; Mon, 04 Dec 2023 10:47:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YP-00DUAY-7m; Mon, 04 Dec 2023 10:47:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA5YO-00DwUu-Uh; Mon, 04 Dec 2023 10:47:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>
Subject: [PATCH 0/3] PCI: Convert to platform remove callback returning void (part II)
Date: Mon,  4 Dec 2023 10:47:39 +0100
Message-ID: <cover.1701682617.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=HER5u4CcDvqjuT8TWaO45fZszFD6KrIs3cuq7J/Iew4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbaA6UrxysEt7PeGPJGUpo5kf9d0CFHPjBia9s 1mo/kjCUAGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW2gOgAKCRCPgPtYfRL+ TpxjCACC3Lu0fHKd7SIpInpxAqRp36wASD8tPT80kNfnKBR2o9AtkfH8tdmFleAqisIfc8ZBF+b axU8XhTEdXJhF4RZcuqLG68ghUY09hozoZ4myRh4HaJU44oTT7X1XgFRVVntqRsq/lchbFG2GwY Ylp5uLg6bAJSM60oJBIqHRlvD3U+7alaSevt9oXUVhKUWm+Av6+/woX9badU0fzezNZ7RSBIdg+ mZZvxr7duLhZBaZ3qHojnqErtdnqAGKINci+HnWKrIdXsqK9KzLrsqBBeId++7afJYSW6iXiJem YUh7WHJaVrCFnEjJF8wnRagOheuIJNV1EqqB1zvAAChVw/1s
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

Hello,

back in March I sent a series[1] with the intention to convert all of
drivers/pci to .remove_new(). I missed these three drivers because my
coccinelle script didn't handle __exit_p. (The drivers don't use
__exit_p in the mean time since the follwing commits:

	200bddbb3f52 ("PCI: keystone: Don't discard .remove() callback")
	3064ef2e88c1 ("PCI: kirin: Don't discard .remove() callback")
	83a939f0fdc2 ("PCI: exynos: Don't discard .remove() callback")

.)

There are no interdependencies between these patches.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pci/20230321193208.366561-1-u.kleine-koenig@pengutronix.de
    merged in v6.5-rc1~111^2

Uwe Kleine-König (3):
  PCI: exynos: Convert to platform remove callback returning void
  PCI: keystone: Convert to platform remove callback returning void
  PCI: kirin: Convert to platform remove callback returning void

 drivers/pci/controller/dwc/pci-exynos.c   | 6 ++----
 drivers/pci/controller/dwc/pci-keystone.c | 6 ++----
 drivers/pci/controller/dwc/pcie-kirin.c   | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)


base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
-- 
2.42.0


