Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16233054EB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 08:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317157AbhAZXbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391020AbhAZTg7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 14:36:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E46DD21919;
        Tue, 26 Jan 2021 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611689705;
        bh=JNTauFIn9ZwI/TxoCodmHDQdXf/u0dPDmIwk5yY2k8E=;
        h=From:To:Cc:Subject:Date:From;
        b=XExB8sj5JwzPcRHySFyGS+RqsgCanqTawo7mAI4lvwLvrke5LWXZpb77RzZTMY/h1
         DrJfkuAKhAA6JruUp+7Sc9+kB39M5mvd71Q/XDXzRQTXCW0CK+chV4Zv/dZ9ECBdkA
         0SLgvn4zgKoF02BoBR21WBR/T3ipNhqTCsKO3yqKFkDVI+g5MAPu1qFFQ00QzskYVm
         1XQE07bnT0CAFtik5nKudtsmV4YZSzZSv9SSnl+1W6m05GT04RrcIp+UeN8pt3cXjK
         TtubcoCLn0J7croXIoSlKdvj8CuTI2+4IlXawYc9rCoCrc/85ddVp9mlchsHy1ECv2
         8+MMzPFoPaFxw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] MAINTAINERS: Fix 'ARM/TEXAS INSTRUMENT KEYSTONE CLOCKSOURCE' capitalization
Date:   Tue, 26 Jan 2021 13:34:57 -0600
Message-Id: <20210126193457.2907650-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix capitalization typo in 'ARM/TEXAS INSTRUMENT KEYSTONE CLOCKSOURCE'.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1e6a5ee6e6..52311efad03e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2603,7 +2603,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/clk/keystone/
 
-ARM/TEXAS INSTRUMENT KEYSTONE ClOCKSOURCE
+ARM/TEXAS INSTRUMENT KEYSTONE CLOCKSOURCE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-kernel@vger.kernel.org
-- 
2.25.1

