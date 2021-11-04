Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36D2444BD6
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 01:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhKDAEv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 20:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhKDAEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 20:04:51 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F3C061714
        for <linux-pci@vger.kernel.org>; Wed,  3 Nov 2021 17:02:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bj27so2448388qkb.11
        for <linux-pci@vger.kernel.org>; Wed, 03 Nov 2021 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5cD27zl/hALrKaChXFpMZ/c9LLfN8f1ErNLUUyffIs=;
        b=VXDIhTem/XsKJul/x73dYrYlx9AmcxmYj4yYJXwL2J6hKTdMujG2Wwf9kd/p0TcbJu
         jCtOpBxslHMlB3RVNqx8QCa8fULUfDScDKAx1asY3LyOoaUvBKR7pyV3DgI6yq5sxthE
         K0HvvmxYE0NjYKZdRgyEKG28+G3NXkERfxSdj7ZwXun777KrNDSZdwAwBzSgtsNcbMow
         guYDrmUZhSMO5hP6OaFe9s6kGgLdYv17HF3p8ZwD+kd0RKhef8Gf1owf7Hl4e8KGPznm
         U6udnr1hwrV4AGQNPRogrXASvYzqR/tU2C0cK8p4xoYzR/+O1yj8arPZHQjPkYTlpvsO
         lJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5cD27zl/hALrKaChXFpMZ/c9LLfN8f1ErNLUUyffIs=;
        b=HIiLLRTBJfUD2IAp1/fwjbRahdcYpw9yY8OOVfCULsvY+oYc3NtV7dykPljwqQsWTA
         mMkjhPU7dgD5d1BDx27fFv4i24kEM/2zWkTS8DCNcY4CR5kcOpkJ0FrKvHrVzekOkE9n
         lPizbG6aPChQnLBizJ9Qz2KVD6QFjiSF/do/IuI0v+f1TE+lzI5UWqacyNIV+z68dMmy
         yjMQhNgGhffwby4glCDASdx9EJqeA2iGuFnd4/RCZDT106AC+sEiW+ogxPp97L8h0di5
         XclDPWfRpsgaLJzIKPdK/eD2OslW0L3I3d7ZoJTzUudsTuIP8hOrOY2Db9l8EWnawoSu
         NvdQ==
X-Gm-Message-State: AOAM530SfTW+cN+XDUIu/mxAvVQ79H2gjkYP8nB+C9VTG5uv07v0xIzD
        iq8MFmgRrwq+sWtWAcfdrZs=
X-Google-Smtp-Source: ABdhPJy/RvaoqHw/6LEdgiP9lGqhhNCSFFwMDIOzZTSYzTAoQPA8dcor10gRyzP2InrYzu0hZQWLGw==
X-Received: by 2002:a05:620a:12e5:: with SMTP id f5mr38618110qkl.453.1635984133188;
        Wed, 03 Nov 2021 17:02:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:485:504a:3210:abc8:574d:4d09])
        by smtp.gmail.com with ESMTPSA id v3sm2450520qkd.20.2021.11.03.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 17:02:12 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     hongxing.zhu@nxp.com
Cc:     l.stach@pengutronix.de, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] PCI: imx6: Allow to probe when dw_pcie_wait_for_link() fails
Date:   Wed,  3 Nov 2021 21:02:02 -0300
Message-Id: <20211104000202.4028036-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The intention of commit 886a9c134755 ("PCI: dwc: Move link handling into
common code") was to standardize the behavior of link down as explained
in its commit log:

"The behavior for a link down was inconsistent as some drivers would fail
probe in that case while others succeed. Let's standardize this to
succeed as there are usecases where devices (and the link) appear later
even without hotplug. For example, a reconfigured FPGA device."

The pci-imx6 still fails to probe when the link is not present, which
causes the following warning:

[    9.199175] imx6q-pcie 8ffc000.pcie: Phy link never came up
[    9.208701] imx6q-pcie: probe of 8ffc000.pcie failed with error -110
[    9.216214] ------------[ cut here ]------------
[    9.222057] WARNING: CPU: 0 PID: 30 at drivers/regulator/core.c:2257 _regulator_put.part.0+0x1b8/0x1dc
[    9.232411] Modules linked in:
[    9.236201] CPU: 0 PID: 30 Comm: kworker/u2:2 Not tainted 5.15.0-next-20211103 #1
[    9.244086] Hardware name: Freescale i.MX6 SoloX (Device Tree)
[    9.250284] Workqueue: events_unbound async_run_entry_fn
[    9.256067] [<c0111730>] (unwind_backtrace) from [<c010bb74>] (show_stack+0x10/0x14)
[    9.264258] [<c010bb74>] (show_stack) from [<c0f90290>] (dump_stack_lvl+0x58/0x70)
[    9.272245] [<c0f90290>] (dump_stack_lvl) from [<c012631c>] (__warn+0xd4/0x154)
[    9.279969] [<c012631c>] (__warn) from [<c0f87b00>] (warn_slowpath_fmt+0x74/0xa8)
[    9.287882] [<c0f87b00>] (warn_slowpath_fmt) from [<c076b4bc>] (_regulator_put.part.0+0x1b8/0x1dc)
[    9.297273] [<c076b4bc>] (_regulator_put.part.0) from [<c076b574>] (regulator_put+0x2c/0x3c)
[    9.306122] [<c076b574>] (regulator_put) from [<c08c3740>] (release_nodes+0x50/0x178)

Fix this problem by ignoring the dw_pcie_wait_for_link() error like
it is done on the other dwc drivers.

Tested on imx6sx-sdb and imx6q-sabresd boards.

Fixes: 886a9c134755 ("PCI: dwc: Move link handling into common code")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 26f49f797b0f..bbc3a46549f8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -779,9 +779,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		goto err_reset_phy;
+	dw_pcie_wait_for_link(pci);
 
 	if (pci->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
@@ -817,11 +815,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		}
 
 		/* Make sure link training is finished as well! */
-		ret = dw_pcie_wait_for_link(pci);
-		if (ret) {
-			dev_err(dev, "Failed to bring link up!\n");
-			goto err_reset_phy;
-		}
+		dw_pcie_wait_for_link(pci);
 	} else {
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
-- 
2.25.1

