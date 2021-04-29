Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4B736EB94
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhD2Nsr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhD2Nsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 09:48:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ACFC06138B;
        Thu, 29 Apr 2021 06:48:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a11so3884809plh.3;
        Thu, 29 Apr 2021 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PlH3+2vfZTyuFfAqFBDTmRaRDdNNygl3Tgthx29aiWE=;
        b=C0AkQKD0SAMi4Wyu71J5JywvoQzblYpGXd4pTiwkoBY3JmovzQKSQaKYVb8Jd2UDHb
         gagiQtYRjqKVBxw5zTR5vGN9ucSKnzuNWiixecHwx1D3q8E/JwwKH0/T8E6ykWJUi+nQ
         Mw1IKlzIchnCInVjXwXRkae3CUsX4B+aiyTTIj403sEi+K+vg9TPyE5UeCM8lRNv6Fc2
         SgOmVEVGVw1relf9JjfDWdz8RGkMkkKvi08uw/nO1aYBW0eqEH1kiHS4xlBtjIqjLBSV
         hRVXwGw6I2qcFtYYJ28dVdWrOvJOMRmiwKkcTYwZIDsjcfeGXkP4QeO6FLzIUCzjThOg
         8Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PlH3+2vfZTyuFfAqFBDTmRaRDdNNygl3Tgthx29aiWE=;
        b=XXuOcglCxi7AOIAnP7KwQAIgm1xAxLu9FJ6je988NGUABqIAUbw4b3ZEVqZmJEHaBs
         2SxYsetEC6oCGLQ1S49STBJ4BiSfL1IBkz+n/PK7dsRmtu2rFZvGy7xIwMdABvsJrSeV
         80a15X4LzoVMqSLn/GJ6fFUnnLL2kYAZoEs4ZX86GkJTG4sdgnrBjPGS3K/Q0PvojJej
         YJTcIGOpieGPVmOq3N0YSSGFB137C7qYX1ZIpNqkBBDirMmstIN7ast2pDyRbFlq/Bk1
         wGBXyRaroiImSnGR2lzY1n+AK8vNBS5Bav905RdBsxvHC3zXidtfDYVYHVXyK6UZKwpi
         uVNQ==
X-Gm-Message-State: AOAM533InAWbWO99BikUpbm6wt3+koKeGUGsGHBRWFOPdvaKSFfEfW0T
        XtAmPIzjxSDO3vJY0jFLOcU=
X-Google-Smtp-Source: ABdhPJxcrHPq0Yh2vzbld5D+XYsyxSrLVwVp1i8jSMbpNjL77MDoBAE9H02D6VqQOX42z8fGsjVxsA==
X-Received: by 2002:a17:903:1243:b029:ed:8298:7628 with SMTP id u3-20020a1709031243b02900ed82987628mr6112715plh.11.1619704080057;
        Thu, 29 Apr 2021 06:48:00 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.149])
        by smtp.googlemail.com with ESMTPSA id n9sm37175pgt.35.2021.04.29.06.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 06:47:59 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH] PCI: mediatek: Verify whether the free_ck clock is ungated or not
Date:   Thu, 29 Apr 2021 19:17:49 +0530
Message-Id: <20210429134749.75157-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Verify that the free_ck clock is ungated on device resume
by checking return value of clk_prepare_enable().

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 23548b517..9b13214bf 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1154,11 +1154,14 @@ static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
 	struct mtk_pcie_port *port, *tmp;
+	int ret;

 	if (list_empty(&pcie->ports))
 		return 0;

-	clk_prepare_enable(pcie->free_ck);
+	ret = clk_prepare_enable(pcie->free_ck);
+	if (ret)
+		return ret;

 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		mtk_pcie_enable_port(port);
--
2.31.1
