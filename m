Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801F045A6A2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhKWPlx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhKWPlx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B37C061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso1937377wmr.5
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=de8FKkQcemEU7BVzPONU+rHtUf38IfJLEI5YvuosGm4=;
        b=qD6TNL9yrinXdBjDlfAy1ugP3DI2X69IHoqGXuFO0taNnK4lQVTYNLwxJK8ZFjw3Tv
         DfwS6WNohSR4J1t215pxg404qMZRGokycZnXzttUBn6NDFaaJl1mvixP+i/SuyLoACTf
         PymjsSCifNjIJ/HNSGP8ElJnkHw1FllW2Vam2a335T/tx/nLO4P4DP85+2D2b5gZjpFq
         xYbfmfcHkqGN3jzfzFfaPscV9dCxag41YdxQIiDqwARaKck7IxW8IdRkoFS8iaRy9OZM
         9vXarL4yas/wPDYDKTxUl9h/3hGWB1+y6WinukZKb6aseFJfcLQJ3EtB3g1Nurp0kQhk
         bknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=de8FKkQcemEU7BVzPONU+rHtUf38IfJLEI5YvuosGm4=;
        b=T8r38uA7Db5khGcli6og6axEr5kt2G7hgHamEMBWBolLW8AvWr2e2CQBMsSBU6eGJ4
         RXGLe//SZTlGsCftrcJFEGyjfXT4JKWdw6Vx+HCoB5n9ImdPjGz6pyEppKTFwFKAD8DB
         2kGSYR4BmlOzMtrHn8txm4mVIedEQq4/x+WFg58BTSdD1H0l14pAAFwOLLE76+iGV4OR
         QQj59mmeJh8OKATboHxCUvyhhbbqJfnRtEqzEBnJniXK8zUzOCJGtdurjcL7NCQZrUzT
         PqNEVdRp93uhEMae0stxutZ6GuywN8RyPv/0OmQEvjsi/0uRaosJLs0HeR8WunxsRWSx
         vYIA==
X-Gm-Message-State: AOAM532BMbRNuHgpiU1F4NNHEztLOmQCtfMmsINs2V5VcDTxK6gRah40
        Yyppn4x49j7M7FVyasBXwI4r08r1TX/iLQ==
X-Google-Smtp-Source: ABdhPJyA3Namga1WRNdHfqotkW5/Y+TSXuFf7RXsHQGZ0Kc5mF0PoZPvc3UjkqGEZTRiRiXV2jnoYQ==
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr4307564wmr.101.1637681923584;
        Tue, 23 Nov 2021 07:38:43 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id g5sm18281696wri.45.2021.11.23.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:43 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/4] PCI: j721e: Remove cast of void* type
Date:   Tue, 23 Nov 2021 16:38:35 +0100
Message-Id: <a4d327d25a6ced035ca7fbdcc75fd211927854a3.1637533108.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637533108.git.ffclaire1224@gmail.com>
References: <cover.1637533108.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function of_device_get_match_data() return void*, so no cast type is
required. Remove cast type struct j721e_pcie_data*.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 918e11082e6a..0aa1c184bd42 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -367,7 +367,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 
-	data = (struct j721e_pcie_data *)of_device_get_match_data(dev);
+	data = of_device_get_match_data(dev);
 	if (!data)
 		return -EINVAL;
 
-- 
2.25.1

