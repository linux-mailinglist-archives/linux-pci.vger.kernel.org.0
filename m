Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6EE34BC9F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 16:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhC1Olk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhC1Ol0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Mar 2021 10:41:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2270C061756;
        Sun, 28 Mar 2021 07:41:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m7so7773163pgj.8;
        Sun, 28 Mar 2021 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yc6QjgSudbKWQkdConiaKqiDBMnbnOx4Gm3AgRAanEM=;
        b=aLCQk5kLbjZyZx0gEfGu6LdSgR2yv5X1RaQVw9hbl6DwAsEsFg7zpq3i13Tm1Mpucr
         nwCQk1Hk7xUeynIHTybcXyS6P1LBpIn6+teRJhLTDE2nGPncn2d1RtbPYArVjJK1x9wH
         2QsSTSs5fMrfyRNdizLqjiPy2t6mOJI84qvtFcXfRDRVG3uFYgsMJIO7qsXqmkxfHVAh
         XcgNYLuH+YzeS8R6V+E/ukHJIjpBRs+XW7/ztUOSlWOFi/ukSOvzgp3YzRQkCyNE0HGp
         qrUdmf5pNVs98x/ciIKsgnGU+wKPnRI+6eBFIjT2JswuoAAuIek6GfDjAYM5lLkGeIAr
         Utdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yc6QjgSudbKWQkdConiaKqiDBMnbnOx4Gm3AgRAanEM=;
        b=DJrPpa20M7yy5Kl2swXKQzATEj7Be1PWcVgRzogD/G4LtOPrZAkXHkavlu0LXHB16E
         TcyVXafAHs7cZYwww0veAS7q/1CnuRVHBrtIf9DJ0MS1OyP7yWeeg14NA36WVcg/ZFqS
         FqC0N6R1WovykYPS9J83VX62th6IZjFCu3jdATY2WGOH7cCJc3icWFpP8v2AdYlkU+3X
         Wrf7URFIp7GYsgi/EOj8VChgzevBW/Rdv5D7RRmvzetU3H1xqkqBD5U6EXWs0W41OEfg
         gejT8Zi/2D3+5x6wTK5C1FE5H4k4oMkiJ7KgWmqnOWwECFmR3QScTCkg7I2vUIZ6pCSq
         OPLQ==
X-Gm-Message-State: AOAM532eAeC/IjGStkS7dHg8rYoD2bLn6tiv67ZFcWKaJ+k5BPuyOoQk
        +1AM0QQvewhXgayByuUzOyE=
X-Google-Smtp-Source: ABdhPJykeiLPTumSaMDTWBbwJymgj36YvDeBXU2mBDpVg49b9grcwUSnZNboFud/O2Ut7iLHs27vRw==
X-Received: by 2002:a62:5c5:0:b029:217:7019:d9e8 with SMTP id 188-20020a6205c50000b02902177019d9e8mr22158225pff.10.1616942485326;
        Sun, 28 Mar 2021 07:41:25 -0700 (PDT)
Received: from localhost (185.212.56.149.16clouds.com. [185.212.56.149])
        by smtp.gmail.com with ESMTPSA id s12sm13923980pgj.70.2021.03.28.07.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 07:41:25 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        dann.frazier@canonical.com
Subject: [PATCH] PCI: xgene: fix a mistake about cfg address
Date:   Sun, 28 Mar 2021 22:41:18 +0800
Message-Id: <20210328144118.305074-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It has a wrong modification to the xgene driver by the commit
e2dcd20b1645a. it use devm_platform_ioremap_resource_byname() to
simplify codes and remove the res variable, But the following code
needs to use this res variable, So after this commit, the port->cfg_addr
will get a wrong address. Now, revert it.

Fixes: e2dcd20b1645a ("PCI: controller: Convert to devm_platform_ioremap_resource_byname()")
Reported-by: dann.frazier@canonical.com
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 2afdc865253e..7f503dd4ff81 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -354,7 +354,8 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
 	if (IS_ERR(port->csr_base))
 		return PTR_ERR(port->csr_base);
 
-	port->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	port->cfg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(port->cfg_base))
 		return PTR_ERR(port->cfg_base);
 	port->cfg_addr = res->start;
-- 
2.30.1

