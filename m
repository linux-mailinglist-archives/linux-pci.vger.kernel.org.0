Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED7B336AD1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 04:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCKDiQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 22:38:16 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:45186 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhCKDiB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 22:38:01 -0500
Received: by mail-qk1-f169.google.com with SMTP id m186so2688496qke.12
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 19:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HoIkSwuB9kFb/7o0k8S78I/HpiyIT43O0+mWxnUnfJI=;
        b=ruiwFCdofD3I4gLRuG3xg19HYSeuCGe2mkt1rt4X1YNN3zEYzaoQSg74nOxVpy/MKW
         PAnFZrK5t3d8+CJv+8ljW9QYSQhO49LctrD8gxb8D2UPGZsabUC/jPNGHyPZVOATpCaW
         A4qxWRrI1j1hmOR/I7ENDnTwqlnzbGM6PFG35/QmNJJI3P4da/QoeeOBas1gx8q5TJ6N
         5GPe901la4BjFHmxQ7vRDkwJHRQ0iPAr+nxp/h7XYAlGFwEIqhER5K71YRwkeHcBOFZ5
         Q2cop0e3DsuQCpsIZMYPawoRBL7Ne3JmSbsQNgURFMf11z81XZykPsIT6fLrzWQ3O4L0
         iWQA==
X-Gm-Message-State: AOAM530FWuo6LIMJDxBOF1rc6Fhho+OnwS7O6XPGwSr6kOnD6m4WURqs
        JRu/mr7njtGGMRIEWfGUJuQ=
X-Google-Smtp-Source: ABdhPJyKZhUdOe1LCVxqhW5iBVJS/b2WAnNvPcpQJ7B6+4Fnw8aEHmu32vFpUVzeLUQfGiIHqbOtQQ==
X-Received: by 2002:a37:94b:: with SMTP id 72mr4823437qkj.94.1615433870050;
        Wed, 10 Mar 2021 19:37:50 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j1sm949876qti.55.2021.03.10.19.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 19:37:49 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: layerscape: Correct syntax by changing comma to semicolon
Date:   Thu, 11 Mar 2021 03:37:45 +0000
Message-Id: <20210311033745.1547044-1-kw@linux.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace command with a semicolon to correct syntax and to prevent
potential unspecified behaviour and/or unintended side effects.

Related:
  https://lore.kernel.org/linux-pci/20201216131944.14990-1-zhengyongjun3@huawei.com/

Co-authored-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 39fe2ed5a6a2..39f4664bd84c 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -154,7 +154,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = pcie->drvdata->dw_pcie_ops;
 
-	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
+	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
 
 	pcie->pci = pci;
 	pcie->ls_epc = ls_epc;
-- 
2.30.1

