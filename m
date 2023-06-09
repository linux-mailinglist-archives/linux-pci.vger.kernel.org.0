Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392B2729775
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjFIKuS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 06:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbjFIKuR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 06:50:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A6CC3
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 03:50:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30aebe2602fso1244127f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Jun 2023 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686307814; x=1688899814;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwQRa4qckO6ixQp2fV7L1BkurPOrWgrccG+//fvOGOk=;
        b=mdTwXfnjJwYxsIMkqgCh9ivyXno/zU9hfPaJmMw1GbPJojTGdYSAPn04sqfxupAd+U
         WTYkSF275EtRIZn55DQSQSWY/Rqdc2cqlvDVLwmy9bmMZlMfOJSz8ksPwiO9IGntduYU
         lSCh204kh3bF1mhohGHgn4dPZvZMEL/M4QDxoQQjTxQaji8dNPBSomMInPl3RRh7qPR6
         chJJqoY1ac/pTuQJFkOJyxRpX+PRnqKl4yiSuEf2cBIBOKEBRHY2uCvuDT1PrxEPCIoI
         JRqtTeYk3uT1CNyEogV/3gGKDkPJkSYBSEMKUBucXoQ9Dv/d7yX57h15ekqo+O4snjzm
         7HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686307814; x=1688899814;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwQRa4qckO6ixQp2fV7L1BkurPOrWgrccG+//fvOGOk=;
        b=cTsT6IlLJ9j6aCr8+w8mrCtc2m9jYtajsnx8qcXB3sMnTh9AsxrRhIvXZqF9DNfe8o
         otghew1lbV9JRFa0tkjhAW8VH9ARIsQXT9lZVUwuDp1BtBRffaqXFk/Q8OMwWQHtH32J
         3kqVi9hZvq5fM0n4M8ZBwUDSRwTDtzUHPXwEZQSrqLPdca8qcBCvawAvIBWr6db8EtB+
         NF5uf/FFFvTr+oqz4g20MmJ+C6SSaB2sNUitDf8HtWEaABuTy00r9TkbsWNe9umv1Auc
         Wta9cYLVv5yckPMBsN8agIh2/bDyz08iqoj+bjAOKPmC2ZMA14uf+ElWKhvkXknj4wWi
         NUlw==
X-Gm-Message-State: AC+VfDyQfzX3+tmp1vgXA2u3MrGeVfi/XSHn6Q2ABYwpf02Iognkn8xU
        V4GAeXtE4hTviwniF//aMt3I9R4GT/3nZIWE6fM=
X-Google-Smtp-Source: ACHHUZ7XJbN2Co07oOsfu9qDjkJ8aZ29vciyT48xUtdRs6Y+sT9fXC3xbCouvmEQAGoTnxZypxLhhQ==
X-Received: by 2002:a05:6000:1012:b0:306:37bf:ca5a with SMTP id a18-20020a056000101200b0030637bfca5amr732641wrx.47.1686307814208;
        Fri, 09 Jun 2023 03:50:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6246000000b0030e52d4c1bcsm4161556wrv.71.2023.06.09.03.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 03:50:13 -0700 (PDT)
Date:   Fri, 9 Jun 2023 13:50:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Damien Le Moal <dlemoal@kernel.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] PCI: endpoint: Fix an IS_ERR() vs NULL bug
Message-ID: <ca14e566-d9b7-471d-b738-56dd697b1417@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258e8de1-abff-4024-89e0-1c8df761d790@moroto.mountain>
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ioremap() function does not return error pointers, it returns NULL
on error.

Fixes: 7db424a84d96 ("PCI: endpoint: Add PCI Endpoint function driver for MHI bus")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index e7d64b9d12ff..b45db923306b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -354,8 +354,8 @@ static int pci_epf_mhi_bind(struct pci_epf *epf)
 	epf_mhi->mmio_size = resource_size(res);
 
 	epf_mhi->mmio = ioremap(epf_mhi->mmio_phys, epf_mhi->mmio_size);
-	if (IS_ERR(epf_mhi->mmio))
-		return PTR_ERR(epf_mhi->mmio);
+	if (!epf_mhi->mmio)
+		return -ENOMEM;
 
 	ret = platform_get_irq_byname(pdev, "doorbell");
 	if (ret < 0) {
-- 
2.39.2

