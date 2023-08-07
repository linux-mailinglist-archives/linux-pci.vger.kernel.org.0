Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720687719CD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 07:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjHGF5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 01:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHGF5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 01:57:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F1D172E
        for <linux-pci@vger.kernel.org>; Sun,  6 Aug 2023 22:56:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686c06b806cso2580364b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 06 Aug 2023 22:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691387786; x=1691992586;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hK3UyFydAHSGIJkcyMvn8TqqL0Fsk9vt5oznPUXGDM=;
        b=HNH+rI7Q9X1+btJCgt35E/IR4R3RMA0m9iOt1s1OrrFC0BHFjM+EKstFAD33HZ7Dq2
         VsG8OOPd9bG2Omy1JGzCkbmipSDyCROM+iNa0toAAYJS4JULR2RCVc++dkrQ7PKEwPr7
         LrcL1Lihc7Y7BWe/QaPoBiBmcHAqijda1SQeDrcIFT+jFVwlnqhSsPp3998a4P/2Y4+Y
         DGftWwZhw48B1xazIjTIDb4a3SEYJPrReJqnJx5NbFgrQHKUBs3tqOSsxXFdJdeIwy/5
         OOE32QMosDCWb1vN2w3Va6Jb7DsbegkXJvDOCDRk8hqy7zmrbDrNaqXiE/lkYYRU0dRL
         KBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691387786; x=1691992586;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hK3UyFydAHSGIJkcyMvn8TqqL0Fsk9vt5oznPUXGDM=;
        b=k6kLF20kTkyPQPRjfx+6vKQThVCGnTVOxACl5og0s+z64crYggV9ppXSCcEBOExFHf
         JxxsX5og+KtEuE7R9VyN1fvHSnWKS/SFAQ2iof/smCKcW+IDeHQHrKergNQPdIJ6N3VI
         VWovLldNjaijSHXrF4RdZXQjCzvsBOfmisGxjXMertNsP3fn0JrwCc68+wXwcaW2hxIP
         +A5K+f2NQk+v053w0LEGwCJPyAjY17RDM8GTQ5uSdqEJu1Ttj0WmRmjgzTh0ReOl50zM
         cckBaKFPFMkadD2FVZTkKFEA1kdRe+wbm79PIlqzfhWcXt++GN6NcFP1p5sb0l0taOSp
         mwbg==
X-Gm-Message-State: AOJu0Yz50+0SeiUvr0PbcSdIlMT1RTLnxcBfNRJWgBdG5r8aacwRE3Rr
        rz8dfvSm1XtKXL0NWg2KoPAqRYCCDCUPq3DmYrPvvsjme7ZuRU8rszY6/HmNJUxpJF/yNObyxlx
        P5XU9TYYWCkumwmppLOmxlLAGRXMNeUA9tJ2pjPsPOfXjQf36M3Q9yOhqPQKP/umsodJTzm1912
        BMTo+Wq04ekQ==
X-Google-Smtp-Source: AGHT+IH7lsAXC6CAHf+Lo13cxjPnkTABszlkF43xj33/yxMjt8XFiQRUd7L/wq0dfMx7VFI68zjyeg==
X-Received: by 2002:a05:6a20:918e:b0:140:f855:5cde with SMTP id v14-20020a056a20918e00b00140f8555cdemr1916106pzd.33.1691387786015;
        Sun, 06 Aug 2023 22:56:26 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c9-20020aa78c09000000b006874c47e918sm5264320pfd.124.2023.08.06.22.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 22:56:25 -0700 (PDT)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     linux-pci@vger.kernel.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, p.zabel@pengutronix.de, palmer@dabbelt.com,
        fancer.lancer@gmail.com, zong.li@sifive.com,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v3] PCI: fu740: Set the number of MSI vectors
Date:   Mon,  7 Aug 2023 05:56:21 +0000
Message-Id: <20230807055621.2431-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The iMSI-RX module of the DW PCIe controller provides multiple sets of
MSI_CTRL_INT_i_* registers, and each set is capable of handling 32 MSI
interrupts. However, the fu740 PCIe controller driver only enabled one set
of MSI_CTRL_INT_i_* registers, as the total number of supported interrupts
was not specified.

Set the supported number of MSI vectors to enable all the MSI_CTRL_INT_i_*
registers on the fu740 PCIe core, allowing the system to fully utilize the
available MSI interrupts.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Changelog
v3:
- refined the commit message
v2:
- recast the subject and the commit message
---
 drivers/pci/controller/dwc/pcie-fu740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 0c90583c078b..1e9b44b8bba4 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -299,6 +299,7 @@ static int fu740_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pci->pp.ops = &fu740_pcie_host_ops;
+	pci->pp.num_vectors = MAX_MSI_IRQS;
 
 	/* SiFive specific region: mgmt */
 	afp->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
-- 
2.17.1

