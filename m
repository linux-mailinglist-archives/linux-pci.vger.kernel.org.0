Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9506283617
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfHFQBu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 12:01:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51984 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHFQBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2019 12:01:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so78761921wma.1;
        Tue, 06 Aug 2019 09:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BYSLhg5cqJdI/Qakd7sQwghpIb3plM/wekPJNZB95U=;
        b=X8vaBzf/Y76GVt7YmME7wBTCO0ehItVLkV5G/9kN6eU8mPXYUozcBBBNDMYnDf3EFw
         SWUNrGKAVjdx/K2bu1AePiYdakcdC7AJ2mbQ3LsAT9IhJQBNhb9JeST9CfzrAaBzVZ6s
         b0fqGsUCiye9tDp8P4SoudMI4HQpU10iz1+q1v5yhnihpj2oV2EMuk1GLYDIESx+bGp3
         ZGJHvBGojCc7M8eagIZJ8S6o7Sme4ahDSDC3usLnH3d0Qj44qe3R28D2rlCiFLnKOYWk
         CiAZl/wFeN7oRMhEH/7RsAhZdIdsv+gN+9LVIdw1qHXQtPZMlk7umzP3I38VgnwERJEq
         w54Q==
X-Gm-Message-State: APjAAAXfjSwpuAzaAAd6Y347f1x+L0ZPAG3cnT1Mmeiu6CupK72HMiBU
        DVnByczk5RRKneLLR67ur+Y=
X-Google-Smtp-Source: APXvYqxeuzoa2DLBzGVGm9OW8kXz3P0h8I74oSH2Q9hyJT47ssuRyoCLCXVTpKaKuLNcb5ViZgMX9w==
X-Received: by 2002:a05:600c:2117:: with SMTP id u23mr5462928wml.117.1565107308156;
        Tue, 06 Aug 2019 09:01:48 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id b203sm129380410wmd.41.2019.08.06.09.01.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:01:47 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390/pci: PCI_IOV_RESOURCES loop refactoring in zpci_map_resources
Date:   Tue,  6 Aug 2019 19:01:37 +0300
Message-Id: <20190806160137.29275-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch alters the for loop iteration scheme in zpci_map_resources
to make it more usual. Thus, the patch generalizes the style for
PCI_IOV_RESOURCES iteration and improves readability.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/s390/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index b0e3b9a0e488..c7fea9bea8cb 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -431,13 +431,13 @@ static void zpci_map_resources(struct pci_dev *pdev)
 	}
 
 #ifdef CONFIG_PCI_IOV
-	i = PCI_IOV_RESOURCES;
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		int bar = i + PCI_IOV_RESOURCES;
 
-	for (; i < PCI_SRIOV_NUM_BARS + PCI_IOV_RESOURCES; i++) {
-		len = pci_resource_len(pdev, i);
+		len = pci_resource_len(pdev, bar);
 		if (!len)
 			continue;
-		pdev->resource[i].parent = &iov_res;
+		pdev->resource[bar].parent = &iov_res;
 	}
 #endif
 }
-- 
2.21.0

