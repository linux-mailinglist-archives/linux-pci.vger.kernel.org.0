Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93541B8FCF
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDZMba (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgDZMba (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Apr 2020 08:31:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAC9C09B04F;
        Sun, 26 Apr 2020 05:31:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so16395033wmc.2;
        Sun, 26 Apr 2020 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olSn8uuKdlJvKTgtfdsxs5wnzDTdwO8Geb0yVJeu3vc=;
        b=Ybc6gWHVro/taTgfZI7mWERxJc3qePuSpFpbWP1IsY+Gi1wChBi7zxNOtW0xq4leSA
         YEmJaZDgaFqOehtu1FFfb+4p8Ft5FOP8LNaRgfSOHb6fsmOUZWMqA9Q7VWcfgF7ezSgJ
         lJzCz6gTpm0aKr9zZlqJkXtZb/wy0w1rNqZKCifdXr8r3le1AFMMyzC5usgqcbqMG5Yo
         oZ7dud7tOFI88i/bHupSQUE76ByDSDXltHI2rppI2KQd406/anU6tqPF66llbkAgwyui
         OGM4HT0Hi+kU15yBflF3O6Z1JSDfoHb44J5wg/S/+M+UNvE3XvwK6b2UuQ0VtWxo3fD0
         xlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olSn8uuKdlJvKTgtfdsxs5wnzDTdwO8Geb0yVJeu3vc=;
        b=dUQ6Un4COpe3MByE3JPlJXg2d/98h6ENAL9MrfJblL6wlCx9bGOK9HLwLr+Fz6zVnL
         gpAXlRSPsmo+CdONPId4pUijmHG7W0hhH3GAt84M4irhjAUGLfuvT2hlPugcRxmvdbYK
         +gnn7VbEkBhtvtHZ4sCnGUqRsdjkC6ljFjVRcfpybvvKVuJSyp/+nDThE6a9AWnWzYI3
         uFxKIweuS9xJeiIwGZzi9zuvCLjoX+cD5YwGUjy1J5yqA63EXgUp+ixYnOQ1BRlPcPR1
         W0QpUQqHM4Cdh9KA04cq/UwczB47jIzRqXyRMthBq6qlBAQXoEbV1UCBFCJnR9zPkZ13
         x/6A==
X-Gm-Message-State: AGi0PubI+lwujgUHe7vjQOomMq1mPAJMPmubzWlD600+uOdIG9svwdJx
        YmOVf1nPkwDpgOSPcRT+DK8pzeh2
X-Google-Smtp-Source: APiQypJpy0q26KcpgmrPob1FU/GMupgO3uiQ9oP1HlluP3JKxm/Vo00/xlLD0jgQDMXPArDFBLufsA==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr20191039wmb.41.1587904287959;
        Sun, 26 Apr 2020 05:31:27 -0700 (PDT)
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id i19sm17434388wrb.16.2020.04.26.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:31:27 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: pcie-rcar: Mark rcar_pcie_resume() with __maybe_unused
Date:   Sun, 26 Apr 2020 14:31:15 +0200
Message-Id: <20200426123115.55995-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

If CONFIG_PM_SLEEP is not set, SET_SYSTEM_SLEEP_PM_OPS() is expanded to
empty macro and there is no reference to rcar_pcie_resume(), hence the
following warning is generated:

drivers/pci/controller/pcie-rcar.c:1253:12: warning: ‘rcar_pcie_resume’ defined but not used [-Wunused-function]
 1253 | static int rcar_pcie_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~

Fix this by marking this function as __maybe_unused , just like in
commit 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops")

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
      branch pci/rcar
NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
---
 drivers/pci/controller/pcie-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index b58dfe415cb3..1a0e74cad9bb 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1250,7 +1250,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int rcar_pcie_resume(struct device *dev)
+static int __maybe_unused rcar_pcie_resume(struct device *dev)
 {
 	struct rcar_pcie *pcie = dev_get_drvdata(dev);
 	int (*hw_init_fn)(struct rcar_pcie *);
-- 
2.25.1

