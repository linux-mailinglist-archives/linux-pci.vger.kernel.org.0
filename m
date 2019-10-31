Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728E5EAC93
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 10:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJaJgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 05:36:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38095 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfJaJgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Oct 2019 05:36:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so2465467plq.5
        for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2019 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpBkpuyfEz89me+buFs+WwtT8XRjvBF3yFBftzqlsQk=;
        b=JdLYApaHHSdUFo4j1OUWJrbghTLy5sNyEB5YolVD7rb4pjkaCXORZ6YsgpbuJrlo/V
         tvEBmGb12tib+aqhP4RKjJlaJURPv05T12dWome0EoDMZk6g2GiuCOLpyreiYTFdP8bq
         +xMNuDjKk97ONXGcpxwQQ2atL3vymdgSlRC2fqUwrH3+/m605N+EH8wvpFfCfltDOyEh
         AlAVWF4FLDs9arQtYXkNFDNZyzLcnc68HEV4e5RUxtvpfuXI5feUTnUgM5YwuURQfidK
         W1Ct8JUM3rdyYYHN2IYoDYqXYZLhWkIn+uZ3HuSvTlU4m/K1RMEm/URF2xTfWTUYBXYx
         xciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpBkpuyfEz89me+buFs+WwtT8XRjvBF3yFBftzqlsQk=;
        b=tUYkweN4O+xqFTYO4t/48ZgNwazwMvWDGAdJ2oW0EMI2XwoVfgNLzlKLvs/zFbRq5M
         XcYsKr9pThSb11xjhxiKFT6ach5ajxINmAHD8ZS1maRB0bD7Vk6Iz+w9oTXkyioKB5Yu
         bzLu3cRLHr7527cRJJwtf7DtmP7D6OAzS3h3IiLA8AtOBirvx1NR68zRbtDKpml+6o2J
         AzIO137vMAhhopPMegdVL9xa+sHz/ZOxtk9Yvxwxrhw6zLXBwdu1PN/HFscGMaMGoNGk
         68tunlPL9R+Ej0O6c95tUBmf8vXnnwCFbN338Hycnx7mzLxtnP2tsylvRNYIklxhgdYW
         kFOg==
X-Gm-Message-State: APjAAAXjT7XIQ7hV9VSUbqm4V0pFmWzDj9hh5aI+YgFqpp2OlTWaeh27
        a80GHVN0l0WeBUCF/83Nzx4Ucg==
X-Google-Smtp-Source: APXvYqwnFWHm7nPbOa+XzFm1q9aR2vjbqEZF/KUN16CVmZa8X1+clj8plDglCup4NMBtOxDqkW3Y3A==
X-Received: by 2002:a17:902:9347:: with SMTP id g7mr5320801plp.291.1572514557950;
        Thu, 31 Oct 2019 02:35:57 -0700 (PDT)
Received: from starnight.endlessm-sf.com (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id b23sm5240079pju.16.2019.10.31.02.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 02:35:57 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>, stable@vger.kernel.org
Subject: [PATCH v2] Revert "nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T"
Date:   Thu, 31 Oct 2019 17:34:09 +0800
Message-Id: <20191031093408.9322-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 253eaf4faaaa ("PCI/MSI: Fix incorrect MSI-X masking on
resume") is merged, we can revert the previous quirk now.

This reverts commit 19ea025e1d28c629b369c3532a85b3df478cc5c6.

Fixes: 19ea025e1d28 ("nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T")
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204887
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: stable@vger.kernel.org
---
v2:
  Re-send for mailing failure

 drivers/nvme/host/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..94bfbee1e5f7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2404,16 +2404,6 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
-	},
-	{
-		/*
-		 * This Kingston E8FK11.T firmware version has no interrupt
-		 * after resume with actions related to suspend to idle
-		 * https://bugzilla.kernel.org/show_bug.cgi?id=204887
-		 */
-		.vid = 0x2646,
-		.fr = "E8FK11.T",
-		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
 	}
 };
 
-- 
2.23.0

