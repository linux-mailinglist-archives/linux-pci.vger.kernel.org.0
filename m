Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E3B435F7F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 12:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhJUKru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 06:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhJUKrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 06:47:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2B2460F9E;
        Thu, 21 Oct 2021 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634813133;
        bh=1MK9BXA7JWARnl0O9y6KyH5YzDwUZkQB6sHYmBqTrdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7GLPKmUv3zdswlYOSlvmYa40RNIcOtr84teq9XxEE53NzvQf2HIipaM5mhYHqYpM
         Eh/i9uEuFKaCMqx+1/M8gstuWRX3yry5ho4pTubUNB3TvkB+RQocFMHloYsco0kE3J
         RJ9+f51wJWL0UXXwQ7L/OIg13bwwr7m1fGw8LU1kIM+hNPZ7EOUXUnA3KI9ncIh3zn
         G6EUtOhCUGH/HQBKRhlyN36T3rQvEy7MWFVYrvQJwQCOdpKh0vcmPWU8sMuKeN0R8C
         vLydU4uumpcjm93bi/ZZvjug/utCRYr26L/ApnIG9mPGLTIgClEUk1xpFSVE+TNDV8
         nbI3C4yK9iacQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mdVZj-002z5K-6h; Thu, 21 Oct 2021 11:45:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v15 11/13] PCI: kirin: Disable clkreq during poweroff sequence
Date:   Thu, 21 Oct 2021 11:45:18 +0100
Message-Id: <f403e590843de1a581cade2d534d34715706f54e.1634812676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634812676.git.mchehab+huawei@kernel.org>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The logic at kirin_pcie_gpio_request() enables some clkreq
GPIO lines. Disable them during power-off.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v15 00/13] at: https://lore.kernel.org/all/cover.1634812676.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index f4ea27b37968..4c3fa02b7108 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -687,6 +687,9 @@ static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
 	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
 		return hi3660_pcie_phy_power_off(kirin_pcie);
 
+	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++)
+		gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
+
 	phy_power_off(kirin_pcie->phy);
 	phy_exit(kirin_pcie->phy);
 
-- 
2.31.1

