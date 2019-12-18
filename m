Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3D123C65
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 02:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfLRB2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 20:28:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46333 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLRB2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2019 20:28:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id p67so231882oib.13;
        Tue, 17 Dec 2019 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oac13lDHKPYhqdCSX7cOIT1M4QFi8+B0sBEHAI2Jyb0=;
        b=CAiLpUlAcqhkJYOyzG2FNvyOtSmgY5rytLGp4VL64ePmQEappZeDDq5Y8eqa9tJruO
         594P8okBQLzfihNxZX2screRRl06LsJkCnXhU2ZY+m5l0maF5P4hmCcwqO9PdfCtwsk3
         cRquaPcuB9bXChiIsFTcJ8LsKi+24iBnc/vqiKaZrzs/LobA0bNqVorVE7ph14l1BOFb
         BIRQ9e1PPaJNGPQ9/2wj1JtiUtHZrui6FFekY+nuvokxg2etia754w1ATvwomsqAbRxd
         dApJWoxZGIW0lm7Ax6MYCvk5cGBMljvR7XTdxTCMFSYORNv7zukkCxkYSolxKZUf5E6h
         I7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oac13lDHKPYhqdCSX7cOIT1M4QFi8+B0sBEHAI2Jyb0=;
        b=KDf6V1Y/GzpZRC7SlXwxv27oXBiYVRJSAf0ADyecYMZWCL8DQjHThK4wPDl2LF7IWA
         OvQfxShtwreDfVBUd5DVtFGirP0VwBO2IRog2jINh50G5FIXgtsDw0Ax9pHTbukcrg4p
         nUBb+eq81rPITAtnfrde4u4ImnYomEG6Ic0zjE3RAWZt2ysmk2qXy+OwP0gSTqypL+mt
         /MDzws/ukSTFTPe5zE00KU1viLFqgyioczKtNUCdK+mspeoPLnwTaJT2gDKJFjWiuZQH
         msikKt7Kil731oSyYFlY1VBrajXYnPRNOWkxXt46c/qK3I31TTk+ZHxI51PnJskzaaei
         CDCg==
X-Gm-Message-State: APjAAAUqqCZNhaG81Z/LxTt84spySNhjKvHsFof3a+TIjWK74i41n4v8
        3jqXpfeW5PlBYhYd4xkR46m+Q+vX
X-Google-Smtp-Source: APXvYqziaXBRz5W6ed4dD2X8sjQS+yEEugK2smhVHUjAC8lVQ+Jc2/7gca7deShKApoYt+WelMwJnA==
X-Received: by 2002:aca:d985:: with SMTP id q127mr66396oig.132.1576632479968;
        Tue, 17 Dec 2019 17:27:59 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 91sm227827otb.7.2019.12.17.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 17:27:59 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ley Foon Tan <lftan@altera.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, rfi@lists.rocketboards.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] PCI: altera: Adjust indentation in altera_pcie_valid_device
Date:   Tue, 17 Dec 2019 18:27:52 -0700
Message-Id: <20191218012752.47054-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clang warns:

../drivers/pci/controller/pcie-altera.c:196:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
         return true;
         ^
../drivers/pci/controller/pcie-altera.c:193:2: note: previous statement
is here
        if (bus->number == pcie->root_bus_nr && dev > 0)
        ^
1 warning generated.

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Fixes: eaa6111b70a7 ("PCI: altera: Add Altera PCIe host controller driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/815
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pci/controller/pcie-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index b447c3e4abad..24cb1c331058 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -193,7 +193,7 @@ static bool altera_pcie_valid_device(struct altera_pcie *pcie,
 	if (bus->number == pcie->root_bus_nr && dev > 0)
 		return false;
 
-	 return true;
+	return true;
 }
 
 static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
-- 
2.24.1

