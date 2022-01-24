Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44053497DF4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 12:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiAXLaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 06:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiAXLaJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 06:30:09 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2794C06173B;
        Mon, 24 Jan 2022 03:30:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c2so22696757wml.1;
        Mon, 24 Jan 2022 03:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9azzWJBdCavSbw5TgjtlfjB5PlGBGNbxI4RRSIsW0E=;
        b=LBKdmRwaCWRUHIsb/0+WyX4eZ11Y5Gp4Vh9QQ/aORwZN52EXvit8hq9S9uZ4TY/8kB
         FVqtNhEjjRu4iMYEiAI4ntIhb8i+5jm1Z4wUz11s4reJ/SfAjkW+rCQrmWgUtEL45avT
         Z3e/ozoMPn7xIqZtkCNrvOHFTXPpt5TB4Yq7rNCQIh8vggAFLQb2UrDk3s9gLM//NlcQ
         bj0Sv/2/wNzRo1guSj7bgPje0rCjE7uSLvM3XTkC1oBVN81gNtflZbzpCso7d7XmUf+o
         p8f2wQzClQr1GwxsdLI/onEsVqp+FD6kt6WkLk/CLtr8ODNv+Gm2YwRyAxK7oONUM62P
         JjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9azzWJBdCavSbw5TgjtlfjB5PlGBGNbxI4RRSIsW0E=;
        b=e92OLhRLWSxJ1Nx53VYThNS0DCDc6OdSLEilFxam7PmU1EqJHmqw3ZAO7wiXMoYvQg
         q916hQsliwoGbZIUXPmS8Y5zk35dl356woSMjq/3a6zcR80MMc2xzj1cV1DxEyTkRrZ1
         4lWhCHVF6crXj8Wpgr+Pm8at5GIwaN4yEnpivzXD6ipDMn1bqrzGhkMdGo3Se6OeYKy3
         +weFmUsBLhCP2twOLm3lE3dri+mNm2QEiluFiZl2laPAw6ha0qKqa0mI2iy0Wm4Xzreo
         NmZefSpIX9gtAkNkQRDOmAAQ6+/nLMxbZ9Aigr67phXR6z1I724Rw0RqqKwCR1yxjFCm
         O8gQ==
X-Gm-Message-State: AOAM531hmNcu9NNpkBYXk3WvFkiS56eT1o67OtzbnWTK/bDGNn0FGum9
        nTEqx8TAMiQT6zLoCmU5b0qnV1HSqq9mrA==
X-Google-Smtp-Source: ABdhPJyApv2FYDrSGpq+392dzbL2MjgxggKUso8sgj9TVBHqqb3fZmGWD9gPo0HvEGCULCBZFAOV8g==
X-Received: by 2002:a05:600c:1c27:: with SMTP id j39mr1456962wms.96.1643023807278;
        Mon, 24 Jan 2022 03:30:07 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id y15sm3328927wrd.51.2022.01.24.03.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 03:30:06 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] PCI: mt7621: drop 'of_match_ptr' to fix -Wunused-const-variable
Date:   Mon, 24 Jan 2022 12:30:02 +0100
Message-Id: <20220124113003.406224-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124113003.406224-1-sergio.paracuellos@gmail.com>
References: <20220124113003.406224-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The of_device_id is included unconditionally by of.h header and used in the
driver as well. Remove of_match_ptr to fix W=1 compile test warning with
!CONFIG_OF:

drivers/pci/controller/pcie-mt7621.c:549:34: warning: unused variable 'mt7621_pcie_ids' [-Wunused-const-variable]

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 3824862ea144..f2e567282d3e 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -557,7 +557,7 @@ static struct platform_driver mt7621_pcie_driver = {
 	.remove = mt7621_pcie_remove,
 	.driver = {
 		.name = "mt7621-pci",
-		.of_match_table = of_match_ptr(mt7621_pcie_ids),
+		.of_match_table = mt7621_pcie_ids,
 	},
 };
 builtin_platform_driver(mt7621_pcie_driver);
-- 
2.25.1

