Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80241768A38
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 05:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGaDGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 23:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaDGk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 23:06:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8510D3
        for <linux-pci@vger.kernel.org>; Sun, 30 Jul 2023 20:06:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686efa1804eso2813590b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 30 Jul 2023 20:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690772792; x=1691377592;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DPILlssAxcfrx8+GCIwznuFbu8EdT82LOOYIlFZUOk=;
        b=aELs+bth2qiCtrqQzZJtWefFs/CKZXCqMomYuaEKdre1MhfcrG2s16tqWErZx0OCN/
         LBOLjzwVZglA/sh+9lwOcI51NJzJGFb7KOCCGwmIDRvQyNZkJNoJrsL6sOFlG8FiMRDo
         KMyWVAd4M6W7riQfg+yVlazQJpD2dAC6Ra+vf6K7R5lSYQGRe+7WKTxd7J/bOQMBjJfm
         rSI3WVMIjo/X34bK2Oyr6tuaTJcOhJBpL7BP4crxH2TwdGgQEtbwHr8tPDU83971Xw5+
         2XfWy/IiPYYuUhaVjzfu/1LptCo3cvLOLsc+GVbrc331w2s70Sc9lti6o6TJIiwRZPri
         9kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690772792; x=1691377592;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DPILlssAxcfrx8+GCIwznuFbu8EdT82LOOYIlFZUOk=;
        b=OyvBLzWT27VmxBxLRxTN4AKFZKsgVHyTjWMD2T3s1xubsWOdjZsBPWCvdaxhY5iJyo
         /cDxfxVl60s1gL9oEABdXeIT4NgKO0hnfRddia78iX0Kyr1zlVs3znyruilM7omspz3w
         bw9ULo0uGO912bmFKxvwauhJCWmOTl2hfJ44lQ50+UxINTJvmjL+S6aCj3ZYN/g6l5Z3
         syobrTVqHsz2DFsk9xgp5klnr106CHUWgmqTrzKDpKnNYaJKANfNhLbVfXUlhDYl/c+/
         kYmyzsQPYn0C01/g54ARDEIl10UelAh0bUKEoOAiryas5ICfVrRxyIlX42hRmmpwOBez
         GHVA==
X-Gm-Message-State: ABy/qLZoL8LTr4rhwq0BRjrOYD4mmG1tYUzMNLRo/kLXEfTAIXtkHM92
        8QUCwbVbRpYJsjX+P6aDxT3r6A+FNQRp+CXpYl5WqmJS4YLRZ9MVlH/UEK3xXSWz1dx+2Yxzhs7
        BxjJhsSIBdsGyOeRR/E5CsLlr6FkvtDiQx5ONEG6/ryHWjyFrZbW33DI0N7buSwKLBlSYipbXnr
        1ins6tNWN38Q==
X-Google-Smtp-Source: APBJJlFtIvSv8gZVh8Mknzy2Cv4H7nSL2/iWauPWgaZlcbXqqf8Ew+5uQJD8KWCGF4sQM2dtDyTbZQ==
X-Received: by 2002:a05:6a20:96c9:b0:12d:d615:9279 with SMTP id hq9-20020a056a2096c900b0012dd6159279mr7235855pzc.25.1690772791750;
        Sun, 30 Jul 2023 20:06:31 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001b896686c78sm7291052plg.66.2023.07.30.20.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 20:06:31 -0700 (PDT)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     linux-pci@vger.kernel.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, p.zabel@pengutronix.de, palmer@dabbelt.com,
        fancer.lancer@gmail.com, zong.li@sifive.com,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v2] PCI: fu740: Set the number of MSI vectors
Date:   Mon, 31 Jul 2023 03:06:26 +0000
Message-Id: <20230731030626.13283-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The iMSI-RX module of DW PCIe controller provide sets of MSI_CTRL_INT_i_*
registers, and each set can handle 32 MSI interrupts. However, since we
didn't specify the total number of supported interrupts for the fu740 PCIe
controller, the driver previously only enable 1 set of MSI_CTRL_INT_i_*
registers.
This patch sets the supported number of MSI vectors to enables all the
MSI_CTRL_INT_i_* registers on the fu740 PCIe core.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Changelog
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

