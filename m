Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C085750006
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 09:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGLHXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 03:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGLHXR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 03:23:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38121997
        for <linux-pci@vger.kernel.org>; Wed, 12 Jul 2023 00:23:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e97fcc60so4558692b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Jul 2023 00:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689146596; x=1691738596;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQTPcNrfCcar0utR0dgjImybcWvn1D1GKmm5UmT+rQ8=;
        b=jCsH2VkkWFXd2/XB1LOvniCmwtqrKQIZb712GQRfHsY+a6r7Tdp/yYYneBZNxDvKDc
         7tZdcxUpxGAi04+IauFc7w12TebZV1pKtIKxQOQokQQJzz+nazN34Uy4sgKKS0nExVfj
         +VWtu022HqQFBOCw7iNKf1cMXO8wewMW0BhPe+JR+jfB8p2VjKZLWJtK6TNp2LzT4Hcn
         cnMpd82MzubkRwPEAHYrTimFBwcUOzHIDMI++cTZ7ZfOnURajeGhCHD9YWxHcn7QTmhJ
         5zGkWvPRzzBasics0LGshDoCNw3Fg8WbpeUghZ4diDfoEGXWsHN3xeguTYTqPKpe8Zs6
         ceXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689146596; x=1691738596;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQTPcNrfCcar0utR0dgjImybcWvn1D1GKmm5UmT+rQ8=;
        b=MsYge/XujbTAwxEGlZfzZJxB2QAudm9wF3pMVjSf7nutoizKuUYFSb4wGsRbcCQM91
         XRjz8L2weHq+azxvmN0poBqxt7z/1VFh8TIWkmFMN4lJ3SoHQzcx5fFZZCAyhN7X/tJ/
         10ojRl6nK7z5o2laL2YN06rnmmrike85OBAn8lvv6y3p0sGzEdqskVFg4GB/YeAPiRN4
         HsV5H3cx5nosfOVrqb2mslFjkoRGxTUgS4nmFBqkJ/y9dtDksaLXq30+WUmSVq4xRH+I
         vw/o3tIz0k5MKkhgG0UkaFQZheWEK0rf05d4SwlQx+DsZ432vAZkykqqyBm3w6HfpKTj
         edtg==
X-Gm-Message-State: ABy/qLbBMjWVXfKNvkWmFzVT26/9E89SDaYmyAUHxSL87LTFQJnHUX/M
        U5A05Wtf44vznMxCghKrbkepAFCw6Fpv1Z8I7rEGPaaWZeN469PhpiJ810bhNmNi4rhDabhLHqg
        OS+eT7NKOFqezl+8TuZjykX8V4yA1GPfNbax+bGU0DS8h1g53H8MYpU9vZm6Ywqdd5itZrgFBc/
        tkhukx5RTohg==
X-Google-Smtp-Source: APBJJlHBKxPKJWR+d+3Kkd6OXkUbg7lo2B6PeftlbNSYNdf+6r8kH6f4pXcsIHqzZPd3UBTNaD2WBQ==
X-Received: by 2002:a05:6a21:998a:b0:12a:30da:59 with SMTP id ve10-20020a056a21998a00b0012a30da0059mr16693220pzb.45.1689146595848;
        Wed, 12 Jul 2023 00:23:15 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001b9e8e09605sm3207216plw.11.2023.07.12.00.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 00:23:15 -0700 (PDT)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     linux-pci@vger.kernel.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, p.zabel@pengutronix.de, palmer@dabbelt.com,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH] PCI: fu740: Set the number of msix vectors
Date:   Wed, 12 Jul 2023 07:23:11 +0000
Message-Id: <20230712072311.27433-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The fu740 PCIe has 256 msix vectors. We need to specify it in driver code
to enable more msix vectors.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
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

