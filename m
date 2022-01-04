Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF5E4844CD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiADPib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39668 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiADPi2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E3387CE1935;
        Tue,  4 Jan 2022 15:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B36C36AED;
        Tue,  4 Jan 2022 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310704;
        bh=LmIvwN+8OkjMH1DjfDomkvep/jAw4+oYe61KXvDecmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aS5JdUyauJXj1y6ZJEkQTtqKzc9SX++og9+vJqljHPow+7PFNvoyJJQcnMLbPNEnr
         rhvBGthKCzjV/Fs9X/6IJWH+gAqOO8UFgEFHdNlMmOU/iRtrY8ASO1e+vnDFZBpbR0
         j/tQuuA4m8KNbdwIaI16pvqvsbBSnteBKqvDroNC/yuisS0U9tOn7wxv4I7ZkcWxuj
         cdA71Mq7db2Fex+ZWyBOvS65epoxBsWiqZ+I799z6P31okCjjER9EqNPsEI40JT/LV
         22QF2DvGBMgXxagr0U4W4yJjm6cx3Ktil2+gPcQNUGGVQL68wU+oO+2v2kON56go0y
         Y9OSfiYvyHrUQ==
Received: by pali.im (Postfix)
        id 8E11A284C; Tue,  4 Jan 2022 16:38:22 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] =?UTF-8?q?MAINTAINERS:=20Add=20Pali=20Roh=C3=A1r?= =?UTF-8?q?=20as=20pci-mvebu.c=20maintainer?=
Date:   Tue,  4 Jan 2022 16:35:19 +0100
Message-Id: <20220104153529.31647-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

---
I discussed with Thomas and he ask me for taking maintenance of pci-mvebu.c driver.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..24527789d933 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14617,6 +14617,7 @@ F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
+M:	Pali Rohár <pali@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.20.1

