Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923BE446FA8
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhKFR7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhKFR7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:59:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346A1C061570;
        Sat,  6 Nov 2021 10:56:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r12so44752665edt.6;
        Sat, 06 Nov 2021 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NM7x5Xb9QzcDyYGi0ieqwqwOgz/tPDERV+wmYTzgbd8=;
        b=PezMUUZCG/Nd21Bm0r4JVVyZ4ldBDsEguw/TaA1d2LAKwjMQ1yZz3KXQP4UYNBbCmm
         R1Gf2OR1w34XOL0HmLnGMyNyIwLMWyR3bGhP252BJ1utNy795BV/ejZ/c4CM9UY/jdPz
         S/b9c63fvYYUrxpGhi4nuwT7EnoZYaxAkQevOEGnVVCoPaEfm8saJmMidmu1HULpNNzC
         Uph2qKwhejekKSA07no0Pp2no12XbHiUN0dARMLt6D5RCtwlB2BqmFCDkYCa0Y6N1IwI
         RVLp91Ad24M3BrDaRYe3Q29Q8W6gRClyGCxedKSGOlHQyk2qz/usQNjjrSOAjWMwh2OJ
         fPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NM7x5Xb9QzcDyYGi0ieqwqwOgz/tPDERV+wmYTzgbd8=;
        b=NFeCN8remJPz/zJILLtDcc8R3F93PR5thd5DDbJ+tBTsGmG9zAUZ0dDVu15Af5+EiD
         hPb9xWjtAnm+JQ2DVtdB22qm5cqXRnweTUikJyl1hbhCYidFjZ4LJbxNToRxsJwKhHqe
         txLQoNFhQlu745e4SmBNSadFs0tElXoDYbH0SPgXB3sxYIc/4d3dRmW69Cszu72JPMbi
         1gaOMBl7pRW0LVlE6uzPFFY7sMnnp89OczqlapnrVG99k7+ordMgSRP+gZ8LkBVXiGCr
         SohMtk6Ha5BfqwGHbd8/30dIDreiNrGHuP1mKYzQOTSjCDjHq+5Wn6jCHbnTK9bG/g5X
         7zLg==
X-Gm-Message-State: AOAM5312YhmXWm+MN/dJnruJi7Ug+OdbcWfnWLIQVFPTQ4MMuFcwCnvE
        VWfBK4jsqhyt6x1j4f+Z35Y=
X-Google-Smtp-Source: ABdhPJzxBJTS6R6cN7THOk0cBLPgNYC6UegaSNRt881CTeYCn53LbAvvwxPRmv1M6fZter9hMYpvOw==
X-Received: by 2002:a17:906:6dc9:: with SMTP id j9mr72440649ejt.317.1636221385838;
        Sat, 06 Nov 2021 10:56:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id z2sm5802224ejb.41.2021.11.06.10.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:56:25 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/2] PCI/ASPM: Never enable CLKPM for insane devices
Date:   Sat,  6 Nov 2021 18:56:21 +0100
Message-Id: <20211106175621.28250-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175621.28250-1-refactormyself@gmail.com>
References: <20211106175621.28250-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

clkpm_store() makes it possible to turn off link->clkpm_disable
for devices that fails pcie_aspm_sanity_check().

 - Ceck the result of pcie_aspm_sanity_check() when setting
   link->clpm_disable within clkpm_store().

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 72cb17489e88..c81b0ef32229 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1282,7 +1282,7 @@ static ssize_t clkpm_store(struct device *dev,
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 
-	link->clkpm_disable = !state_enable;
+	link->clkpm_disable = !(state_enable && !pcie_aspm_sanity_check(pdev));
 	pcie_set_clkpm(link, policy_to_clkpm_state(link));
 
 	mutex_unlock(&aspm_lock);
-- 
2.20.1

