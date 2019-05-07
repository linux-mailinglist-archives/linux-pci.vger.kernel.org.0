Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5397716306
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfEGLpg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 07:45:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39061 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfEGLpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 07:45:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so8535315pfg.6
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2019 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nM6ea8cmtv5RWHhVaSXnSo0sqLUqoa7hSGCl9ewgcl8=;
        b=IC/UknE25UgAoVDu15zMXmhNUMEBW3dDIy1CwV4GUysqeuzEmuevabyIhzn4XZdpsS
         otmtEL2WRi5gI10ilHDnwRBTqfRzPCfXqwO98sg6mgl7o6i75997udqylf/eXLOutcwG
         egYSYkbF9tOSvq0cyv3oHz52ospGjX5hUv8uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nM6ea8cmtv5RWHhVaSXnSo0sqLUqoa7hSGCl9ewgcl8=;
        b=e+kln4ecUcf6qz56/25FX9TBj1EXQDyNM8iGbJ7XVc1zBy8zXPEOr0zUP5+BLM6KB7
         X8/vYRMMHgooFKRr8O3IOqnf3AmrAVSHtjG+5ZHDM6Nx+NgaRPemqF0Fx2A0wv2dQJtY
         T84deHukGZHtdEBYkoSzsAfJ/9RrgczQyiav898RVbQHAPVTwsnmJrZZhKu1WHBoATNw
         /RdmRW5XVYEMwHJMplKI/ndswTf0YasFHNFo1/Y5n4UnLi5tC5TImaj2Cbh9KTfvbRe4
         0U14nuT2YeV2vCb4dSNTu4kMcVNn7t6xKrHohdQXv/48+bnCrn/nM8Cnq5nKZ3JKUDMF
         3dbw==
X-Gm-Message-State: APjAAAX8Nhui5bFMIQxE4Do+xd2JBNqrllxv/a2IP1XoOZVZ6yHiozQ+
        fHnPTGtACh1ZALeb/ZBS114u1hI2AslFBUXy
X-Google-Smtp-Source: APXvYqx8aAaffGjMGdERYgbsrslDjGNueVBUgOoO7DXHm7hZZDczSYwIBtd9O61BKTz5feiCMl8OEQ==
X-Received: by 2002:aa7:8b83:: with SMTP id r3mr40426998pfd.248.1557229534909;
        Tue, 07 May 2019 04:45:34 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([106.51.129.105])
        by smtp.gmail.com with ESMTPSA id d67sm22235175pfa.35.2019.05.07.04.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 04:45:33 -0700 (PDT)
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     m.karthikeyan@mobiveil.co.in, zhiqiang.hou@nxp.com,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH 1/1] PCI: mobiveil: Update maintainers list
Date:   Tue,  7 May 2019 07:45:16 -0400
Message-Id: <1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Karthikeyan M and Z.Q. Hou as new maintainers of Mobiveil controller
driver.

Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a52061..08295a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11900,7 +11900,8 @@ F:	include/linux/switchtec.h
 F:	drivers/ntb/hw/mscc/
 
 PCI DRIVER FOR MOBIVEIL PCIE IP
-M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+M:	Karthikeyan M <m.karthikeyan@mobiveil.co.in>
+M:	Z.q. Hou <zhiqiang.hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
-- 
1.8.3.1

