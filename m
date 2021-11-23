Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB74445A69A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhKWPlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbhKWPlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F12CC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p18so19086272wmq.5
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7h7rcOGOfizWdjjC0AXruzevZZll8UqDG0otjXjxUQA=;
        b=aB3pqOE/nb5+OctjJsSIAyLYqNUL0a4dV3rx57exPvBnWvd2DXMhLbpzCAJWE5vnyz
         mNcGAC+RZgWCrmxzskb5KlzG/8l78IuR0OLxK0KRAmnsaNwlB1JE+hQvmkKFANY1xhY4
         v9aH3+75wCDzH7U2AXasx095UXl57zDKrEXiXv3sv3zCVsG3pkNGTzfrDsuCp6VO522z
         eRIxe0s+vNAbVL2+DuFlZJuAS0wQyX3HlgikexnsrUmMIPNpz+j+c2XJsglMMgXpF/js
         Pl0vZK9xgiXLsKoqcKnrIXgysxSfmDdbZv+GRPMu6ia6XSh6X52TNr2Cutq835zjUwFU
         4VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7h7rcOGOfizWdjjC0AXruzevZZll8UqDG0otjXjxUQA=;
        b=eVW+X/jXuS2Ldsw/nrVGSQy9kHKWfhQ5KTwQaOnNyrmum+mc9U/TlT0nQq1Xp/Qs60
         eD+bxVU5D9adIm1Q8S6aYP5nwN8RPaxATzQYocgPymHzsMFsGpxYk8DPKTph2l78geK5
         yT7hziFIOV/OIvjM36QsvEQ5BgRqCM6viXV6N0WmZLI4ZIU432jvMp+5jc+iGKTJBXC+
         6sNYbQWJNrP4CbmHvKF/SrBoqDs80gbxHK7nS+0ngawK6rsHDF63EUXJEoZpAm93uoB+
         Nzqi67j0u8usor5Vxd6IT8MWq4QR6tYbwKEo1S+4byUA+7lvsgn/sHKKIkISk2MV5qs+
         w6yw==
X-Gm-Message-State: AOAM531y2ateg3O3UwqAFTzEu75s0i8FiRRjui/hiQODcAioYcM6K14G
        rXSQIbjsP6tX64tfvmSfKXU=
X-Google-Smtp-Source: ABdhPJxOthbjS68jIQxrrpVnzKx4oyowzNbodrRB7fakNKDSDHej+aTtcDDPLJQIa7rDfcMT8vEFtA==
X-Received: by 2002:a05:600c:3516:: with SMTP id h22mr4181714wmq.62.1637681889750;
        Tue, 23 Nov 2021 07:38:09 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id h15sm1959273wmq.32.2021.11.23.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:09 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/7] PCI: altera: Prefer of_device_get_match_data() over of_match_device()
Date:   Tue, 23 Nov 2021 16:37:56 +0100
Message-Id: <eaa4a5ef83e6804b6f6f69692c04dd7933d82726.1637678104.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637678103.git.ffclaire1224@gmail.com>
References: <cover.1637678103.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The altera PCI controller driver only needs "struct altera_pcie_data *"
during probe(). Replace of_match_device(), which returns "struct
of_device_id *", with of_device_get_match_data(), to get "struct
altera_pcie_data *".

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pcie-altera.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 2513e9363236..98ada2e20e02 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -767,7 +767,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	struct altera_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	int ret;
-	const struct of_device_id *match;
+	const struct altera_pcie_data *data;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
@@ -777,11 +777,11 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	pcie->pdev = pdev;
 	platform_set_drvdata(pdev, pcie);
 
-	match = of_match_device(altera_pcie_of_match, &pdev->dev);
-	if (!match)
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
 		return -ENODEV;
 
-	pcie->pcie_data = match->data;
+	pcie->pcie_data = data;
 
 	ret = altera_pcie_parse_dt(pcie);
 	if (ret) {
-- 
2.25.1

