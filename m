Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE093EC4EE
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 22:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhHNUNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 16:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhHNUND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 16:13:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A92C0613A4;
        Sat, 14 Aug 2021 13:12:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f3so16213113plg.3;
        Sat, 14 Aug 2021 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o14OX0tO2dLrSEjdjackmVNFFUwvm1oNTxS05DtqXnA=;
        b=ZYbJg8qGT4EQ1oPORKE6ijjN2oXMvwYK6HrRSxLitNgB593s6vWhnreQAbvzfcPrmb
         xCOBcVvPW34mxxqTzpOW7tyfHrM2I12Q5IXdFoTt2ut2Yq3qaaWicnNoMQRkyab1EwKU
         p4MeYvPQWzP+fWG6WDlaTNKeKR3PQPf5tg15qKEMC86E7Q+yA596smfotOKjKlPP8qFg
         AXdsF0/vjgq1l8/tvL1pW/Zve9nkYdovcBy29ywcDJhMWHlOQPahB0FRdf6xH4JTOjk4
         dwNXBl3O8m0aGozT/miwJ9UTIgwsqlVFe6MazNS1+qmnYX0YlQ9Z/tYLknGfRtXoqubE
         BDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o14OX0tO2dLrSEjdjackmVNFFUwvm1oNTxS05DtqXnA=;
        b=Y3ypWlr6jCcNQXt/mfhXN5ouIqIS+bnB46oCNwvp38vJZ9FrVUV5bqRpD4dy3ftmdd
         b0cABIuIJbm5qAS1zfXTdfVY+B4KntAHRjYoQbZr0uNZOWLnuBVGGvK9KYoSX+Y2k2mq
         MLt6nVi9udnwAnQLovcnLUKUMyr5vbqxoNYGHqufB0UP+/Kmre8A5LCphjQCwG6mwTAC
         IXXMUUaBYxStxfDdLjDttWYFOpEAHLkmuO3ED1W2K4+SywnKZTx1JecB8KXARMstRWzG
         JXcFqlDIEomjlClxdwSHfTRWkT/JNrKijH3lQql6xVRRmBMYKoqA5AvpeSyuUGyDQuQL
         RVHw==
X-Gm-Message-State: AOAM5328Rud3aqAfb/1aYkHEyh16nLhDF8H+HAkDfpeaebRG2a1kwwRY
        edMFsGaay+feaWsKiDo/1As=
X-Google-Smtp-Source: ABdhPJzwUqAUxfvQt+hcr2T+DmiZjP/IsRG9wr0s5wM5EtOXadoheKJwbXJsxeBqB0Udy7NmTO494A==
X-Received: by 2002:a17:90a:9289:: with SMTP id n9mr152273pjo.27.1628971953068;
        Sat, 14 Aug 2021 13:12:33 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id r14sm6511132pff.106.2021.08.14.13.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 13:12:32 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Shuah Khan <skhan@foundation.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] PCI: No space before tabs
Date:   Sun, 15 Aug 2021 01:42:07 +0530
Message-Id: <272d96f7b06f2fbbb6d6361b3cec837cccaa23de.1628957100.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628957100.git.aakashhemadri123@gmail.com>
References: <cover.1628957100.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix checkpatch.pl WARNING: please, no space before tabs

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/pci/slot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 8d1a983027b7..d7a60135168e 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(pci_hp_create_module_link);
 
 /**
  * pci_hp_remove_module_link - remove symbolic link to the hotplug driver
- * 	module.
+ * module.
  * @pci_slot: struct pci_slot
  *
  * Helper function for pci_hotplug_core.c to remove symbolic link to
-- 
2.32.0

