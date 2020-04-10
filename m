Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C891A3D83
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 02:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgDJAsA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 20:48:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41887 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgDJAr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 20:47:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id v1so532098edq.8;
        Thu, 09 Apr 2020 17:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a14CUzpnGpaGv5dqUvAXTePxj5EaRSdIRWci/5zAkWM=;
        b=T54WVr0f4ocGL79xzwZP975p3f2YyA0/5A0mdP+YGo9pmXJJXsRDk7VPwQscwpAHx1
         ZZppHBemzYJCtE2a+zH1yHdeKfugxwFT2mdIi+xKiYCCRjdMiIxyoMMx087hwYCA+4zj
         /OlxiFd56bzU1CH6KU+079LWF5Bq5o2K2QCck2uIzqgvukSiLwNw2eHGiuJU+PhxcBO4
         VJhEuRBJTelU7depw9VQqFRvtvm6uZJpm0Tw3b+D08jRWamOWnKWQH+Htft4MyLDwFrR
         T+pX8yMu0s1SVAUczekj5wwpWK5bSHhCK72ESYuJppeFhhAgW5jP90N+OgJTFT0fG0tG
         3y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a14CUzpnGpaGv5dqUvAXTePxj5EaRSdIRWci/5zAkWM=;
        b=mvEsrvuNw1XoCCNaOeWd7+pqp8WqP+UrqlXmz97IWXO3chOfwUZ9zoD12Z4YcJ2X/k
         BOOk4hW52fHKwu/nsC6m49ojnGj8lUXOkYCp2G+UpmqC4vVcF2/P0itNozfrThcLNT31
         E33b1Zv67WpqcKl82ee7tNFMwlIMNHbgqBQU1pTxaqyiX0wr+cA/eLhp8yH081CXn6Pf
         u9XupcIXc4YVdx38s7KTQB5NeNV+/X4yoISTN4M8Pc8V0oCqc+5aYTAnQT+/505903OI
         FZrAvUCFgIzBHugE0lgqYXaEI7jlt4jhzmVCNkgNLXKTm+KN//LMkBWm3rhyn+vyryGB
         wT8A==
X-Gm-Message-State: AGi0PuYKOaxTkFZsT2Atpfc2gbd1kauSQmyqkqui4dc1t1gRw7wkr3dQ
        8QYZSjkHHBQCdA4YMMzTn+pBo8X3b/lo7Cba
X-Google-Smtp-Source: APiQypLvgG31h2JAiJ4I9uBgeYyo/rkkcxrJMy4IA3mBlMc4DdltbrM21eJVNk/Yzl5aRHNkGsWTkg==
X-Received: by 2002:a17:906:48c:: with SMTP id f12mr1637382eja.93.1586479675986;
        Thu, 09 Apr 2020 17:47:55 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.googlemail.com with ESMTPSA id z16sm30523edm.52.2020.04.09.17.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:47:55 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] devicetree: bindings: pci: fsl,imx6q-pcie: rename tx deemph and swing
Date:   Fri, 10 Apr 2020 02:47:38 +0200
Message-Id: <20200410004738.19668-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200410004738.19668-1-ansuelsmth@gmail.com>
References: <20200410004738.19668-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TX Deemph and TX Swing are now defined in pci.txt, rename them to follow
the new name.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt       | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index de4b2baf91e8..937442a4c2ab 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -19,12 +19,12 @@ Required properties:
 	- "pcie_phy"
 
 Optional properties:
-- fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
-- fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default: 0
-- fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
-- fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
-- fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
-- fsl,max-link-speed: Specify PCI gen for link capability. Must be '2' for
+- tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
+- tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default: 0
+- tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
+- tx-swing-full: Gen2 TX SWING FULL value. Default: 127
+- tx-swing-low: TX launch amplitude swing_low value. Default: 127
+- max-link-speed: Specify PCI gen for link capability. Must be '2' for
   gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock outputs
   do not meet gen2 jitter requirements and thus for gen2 capability a gen2
   compliant clock generator should be used and configured.
-- 
2.25.1

