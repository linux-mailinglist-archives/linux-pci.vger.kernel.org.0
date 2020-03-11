Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10D4182210
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 20:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbgCKTT0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 15:19:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41716 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgCKTT0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 15:19:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so1533562plr.8;
        Wed, 11 Mar 2020 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iN1lIy0/f67JfCi9KU7uh6n3lgkv7oAoZ5NZ3robPh0=;
        b=BfRQMt0ipgIFCsbepxc9l/xVpH3h5JT7quohnIEoWdro74//CquJsdriyla9b7QShh
         xdhsTWb+9hwl8ivWbbOHSq1aRRafUqRVsmh1R6Y0L5NZuukW/PvO/p81LYdadlpHmfPr
         3fnhkVIi6b5tCbqP534B/yAnACgpkdWA8GZpXzMMerkdn+wN1Cio3sYXjP3FwGj0mp9K
         SfnpSzxn4zW1Mk5XGUvc3b+PWSrQOU2Ct2eQnaifytiDdyzu1F5MMTpbTMthiWYkF9ZR
         hwXA0ViLm+Uw4fIAWd2KBIPc6SiX0DWe2CFpr9qpPwvViXhLGUlw3ZRRnXKWakd2PtCl
         rzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iN1lIy0/f67JfCi9KU7uh6n3lgkv7oAoZ5NZ3robPh0=;
        b=aVucX9oydasVrbpxKSSYCIJ9RmJ2910a0umlmKfvvvA0NERJTRvGHd3SDdTFMb7l3Z
         ltf2jE/NNDJOObTm9O3YH7hudfwh0VJlkV2UmJ/2TRvqpeN+QE16zTDuH5NwxrFZYhz2
         5ly2776cSrS3VR0FEf31I7f/AUPGsL3vATiNoqDsUFFLJMapu6IY3kA4PjlQhoHEIAMB
         jvHKSOY86Axucv8+mgu0soYnu3kMrmH3A1h2MD/JZGKCTbh6W9q2iWSGvHa7bCi84j4g
         e8iRdqK+4kKJsS6RfbvdDR0h0BzaG+CQ0bV55/Gi/A7JlKlVGEehN6A18TV0o8ieG2mS
         hoAQ==
X-Gm-Message-State: ANhLgQ1oxVBbV4ajhmfqB8DwThG9wPqLSEZItToC2suNQJfBH8bd+UOG
        H/BY5bY6EBJpnfIpxBLxEaQ=
X-Google-Smtp-Source: ADFU+vut3MyakqoUhMIetlzMKR/p4VXgaNSrjQMPOpcFkSKePWWm++E+Uy2ID9u1cYMxZFT24UeMyQ==
X-Received: by 2002:a17:90a:d593:: with SMTP id v19mr200036pju.177.1583954365043;
        Wed, 11 Mar 2020 12:19:25 -0700 (PDT)
Received: from localhost.localdomain ([103.46.201.94])
        by smtp.gmail.com with ESMTPSA id z17sm3792673pff.12.2020.03.11.12.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:19:24 -0700 (PDT)
From:   Aman Sharma <amanharitsh123@gmail.com>
Cc:     amanharitsh123@gmail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 2/5] pci: added check for return value of platform_get_irq
Date:   Thu, 12 Mar 2020 00:49:03 +0530
Message-Id: <53b57606d7bc2615a43b1d5159200dba0435af6d.1583952276.git.amanharitsh123@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583952275.git.amanharitsh123@gmail.com>
References: <cover.1583952275.git.amanharitsh123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
---
 drivers/pci/controller/pci-aardvark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2a20b649f40c..40a4257f0df1 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -973,6 +973,9 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->base);
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = devm_request_irq(dev, irq, advk_pcie_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
 			       pcie);
-- 
2.20.1

