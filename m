Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320627D6A95
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjJYL5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjJYL5d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 07:57:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE42183
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 04:57:29 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c5071165d5so51865851fa.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698235048; x=1698839848; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLjK8RH2hQrcnxdXwxL9ujbIfgaQvug2oCqsCmeP5e0=;
        b=XzEv5su2C+jLr2qHcY4g+0bw4W8dYoIlhyPUNa3nexL3RJNr/sMvkVOKrMLXk51keZ
         cc6zVSpwZxB3V2KFxAM2mcL18PpacTmXF2meYmSUTKLy8iXGRSRTGg/7IMI2A/jSUb2A
         GGd9Se+gaXwu5+5k6eIvrr29I5dna89nAOd25Y1d59IOGBaI+a1xKEXRKjrWWKpgTjSc
         uZaVMmv308yF1OwLLfZ0bTp47Fs/UMo4t7JwyhThGkUqYpdJfiG0wJIVybv7IRkkoppG
         3rCvielW3RLqKAVpVo/VJ+bdz7r3w4WHJRa6C77xWVNr434HTrJ575hsQR5lqWHI1oJN
         szhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235048; x=1698839848;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLjK8RH2hQrcnxdXwxL9ujbIfgaQvug2oCqsCmeP5e0=;
        b=V43323FNK00pNJ20SE2TMQOz9CWbTgM0iMd8xIzT0FYvJNzsbG4SSIBSvahiKH1mcF
         jgaMll4XwFzyWMy5KEgZsugNwm6yNCW+mSpIqGQJnhgmYmVXHJu8PhfXT7zWdJh8L3Yw
         lovKxF/raQ8t8fMTXmv+WQrlq1BuQbKitYLswa7hubPXQc3EC/EhMGWEHnsUFm8/WqUA
         mMbpmnf8wKWMVmGYBNUEO3JavjLFmvVaYf1jjGC0hH84rXMMP2MSFlBu9Cg+QphzdxL7
         dXXIhBTzoCkchnODiFgQmH6n+b/zcQ3ALFpvc2EuwaeMD7N17Ej+qPcWoRcVJ++LBl54
         lj6Q==
X-Gm-Message-State: AOJu0Yz7aUMoos+zzZzCvbh/LPoFaYKMllRzK6cIMhaRsRyvyb9sPAnD
        SVYnl0A3HKZ/T/MiPAyP9eMtVg==
X-Google-Smtp-Source: AGHT+IHt+ZHyJntfYE7bZiBPM7m3Mw4gV60PtPFa/Z1UEb1CDLD4v0EPRaFHGozSPydq2e9pVmKjpA==
X-Received: by 2002:a05:651c:152:b0:2b9:ecab:d924 with SMTP id c18-20020a05651c015200b002b9ecabd924mr11483741ljd.18.1698235047783;
        Wed, 25 Oct 2023 04:57:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b00401b242e2e6sm19359165wmq.47.2023.10.25.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:57:27 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:57:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Fix double free in __pci_epc_create()
Message-ID: <2ce68694-87a7-4c06-b8a4-9870c891b580@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_epc_release() function frees "epc" so the kfree() on the next
line is a double free.

Fixes: 7711cbb4862a ("PCI: endpoint: Fix WARN() when an endpoint driver is removed")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index fe421d46a8a4..56e1184bc6c2 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -869,7 +869,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 put_dev:
 	put_device(&epc->dev);
-	kfree(epc);
 
 err_ret:
 	return ERR_PTR(ret);
-- 
2.42.0

