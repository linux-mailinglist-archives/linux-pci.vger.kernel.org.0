Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B780C1EEFC2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 05:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgFEDMr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 23:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDMr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2020 23:12:47 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D0EC08C5C0;
        Thu,  4 Jun 2020 20:12:46 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b5so8183100iln.5;
        Thu, 04 Jun 2020 20:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Bwy3kLbPJLykuSYZEsLy4fGgrjBMNY4QghQaNEXTtao=;
        b=minHNrYKJRdYHWBYj4vN7Rb/TAGIa2odYSuDObBhK7QokvuNPQVPNbVaVi5uKij9JM
         HzQsSfEMUepG6RwIwvXO3Z/Kz3a8Ene3LxdZvVs7eGjVyywQJ3teK8k8ZZv/tBnq8Enp
         VX3KgHaVBkC/0QG+z6+hxrNZhB9Na00xSC+4wHVcmydicW8DgzzrcsmNlRUa/Sq783Se
         KyyGvIewIje/bwRFDs5ZkbPpxhuT0SLEsvhTuPxMrci1betWf68FX7C6QA5kK5wMqY1k
         qjQEesTBNeE0g8H0257ofiIw7KGD0OYRc3Yp7qGGg2oDvMsRcbBQPokXsQJRiwRASJ0J
         hEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bwy3kLbPJLykuSYZEsLy4fGgrjBMNY4QghQaNEXTtao=;
        b=V/YbDdtKVbBSRNeNWSKZb7TMspWoIMsmyp8glrYp+MRqWsiyUJR3Hdfn9/Z7/CZy35
         KAUpDf4z01dY5z2ChJEj7fpIhbalRF0vtc1xcaq/nSnzaSJwZz4YFTY1U4x9ObDGbT2D
         KQg/aNccBv3aD7uxDs271AuTmqvDx1opeaeqeNJek8huqydkx963rluKWDmoQeZ2qmrI
         lBlnrDV1Qa8tsc391BKYEmmfiY1hkcDh8ei2dnJigSywFK8Y6Wl8YGxPsHoGtcLX7L1X
         HcvYwkNfTlpMA6JV5ox+4djqsC/qoLZisCQc/X0EldJ2YnSK4Ls5iiTiBrITCgjcFh7w
         bhZg==
X-Gm-Message-State: AOAM531WGTQH8V5cYyyNu2ct0LKwv+By8UNE5kWa7ViMnNqrwP1RGNVD
        OuTeROAOCqqQS+kKi3AIT/o=
X-Google-Smtp-Source: ABdhPJymLCD7irIm72PYWJoFekESbRyoxTq1Bfb0WvWMHqV/VHJFkRKN3Wuo/+2aJY3jVun6wOy0HA==
X-Received: by 2002:a92:cb91:: with SMTP id z17mr6552981ilo.305.1591326765968;
        Thu, 04 Jun 2020 20:12:45 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id k126sm767149iof.50.2020.06.04.20.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 20:12:45 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] PCI: tegra: handle failure case of pm_runtime_get_sync
Date:   Thu,  4 Jun 2020 22:12:39 -0500
Message-Id: <20200605031239.6638-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/pci/controller/pci-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 3e64ba6a36a8..3d4b448fd8df 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2712,6 +2712,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err < 0) {
 		dev_err(dev, "fail to enable pcie controller: %d\n", err);
+		pm_runtime_put_sync(pcie->dev);
 		goto teardown_msi;
 	}
 
-- 
2.17.1

