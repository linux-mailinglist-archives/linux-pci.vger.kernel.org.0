Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77DEE765E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfJ1Qdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41916 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391042AbfJ1Qdq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id 94so7158952oty.8;
        Mon, 28 Oct 2019 09:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sCm5472cF93KvMaJ0/jgH3kNxAHKfGtxH8J6nHodQ0=;
        b=li1Yh0kr3Lwj5X/+Yew+8AIysgS83Fod8n/Suc/6KEgeMmyk+Fp35riW+1an9dFGLj
         BJuMbKxwFigCAA9V2TXB7DYzxlLESPrshSbTvJyUHMPp3ld6ygGWH4+gZKR5Xp/bshGv
         KupfOg8oYiYlGFq37l8c9pPVoFu5Lxpwunscmc5e5GRME1f1PqSiDBqAiYfg6QAMBvVi
         p69WzGlxT/xyvKGQUrIHoRqXtfacRo2HV0SdNuj4RO8Ga5VHsiAiJEWOJl/kKaKOoAbq
         s5+bgyqJboFd2UcXHRSc9JuyCR6VPOT2oyxJahcUG6ph3Xiyh+oCYonUoWJP20Lt+DK4
         O3zQ==
X-Gm-Message-State: APjAAAWY3JfcNKiuzLKrV7LB6ArkTqPSohPagBdgjJ78hpDj011EnVpp
        D3fwlXyO39OA18HNqQAPfg==
X-Google-Smtp-Source: APXvYqy/Xq0iUAE5skdxW7RQgS/cS0GZT0jx1F5IzTA54s6xqljQwh3to6yMnbySIthX+LfaHcMHpQ==
X-Received: by 2002:a9d:ef0:: with SMTP id 103mr14011546otj.2.1572280425906;
        Mon, 28 Oct 2019 09:33:45 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v3 18/25] PCI: versatile: Enable COMPILE_TEST
Date:   Mon, 28 Oct 2019 11:32:49 -0500
Message-Id: <20191028163256.8004-19-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit a574795bc383 ("PCI: generic,versatile: Remove unused
pci_sys_data structures") the build dependency on ARM is gone, so let's
enable COMPILE_TEST for versatile.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 70e078238899..f5de9119e8d3 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -135,7 +135,7 @@ config PCI_V3_SEMI
 
 config PCI_VERSATILE
 	bool "ARM Versatile PB PCI controller"
-	depends on ARCH_VERSATILE
+	depends on ARCH_VERSATILE || COMPILE_TEST
 
 config PCIE_IPROC
 	tristate
-- 
2.20.1

