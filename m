Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC337E8A07
	for <lists+linux-pci@lfdr.de>; Sat, 11 Nov 2023 10:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjKKJXB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Nov 2023 04:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKJXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Nov 2023 04:23:01 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91503AA6;
        Sat, 11 Nov 2023 01:22:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9e62f903e88so208267666b.2;
        Sat, 11 Nov 2023 01:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699694575; x=1700299375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf1eecC3Yo7gOC7YXtpAGe0WJRP6o6FR9hdwtJ02C9s=;
        b=W87PTl0iq594q1PHel9X6InVGdMqFOPoAf6TxyjOeW2Ly1jQx1THftIe/pOiSkgFKu
         SLP6iFDnkG3FXOYvt8yAZSGJPaiUHqFL4nenhHY+XZvhlTG9YI38lnqK/LdTJlLyDkOi
         J6T+5NDb0Bo49MBdKkBV7AigoczAzjN0bjvub53wHdUNXYXdb4OlIoX8dqMVS9MDTdza
         X5Wz/bPJET3DUJMGxLuYqGLYL1n0T2azXmSYM9rnhXGsDnVdijuamQWLkup4hJgnc4B7
         cAV+6DyfOx00hEP9LEKs6ZAQeS5FN9IFsCy+tbqjLamocZl4NrxaFoUTwWyJVgTrY0l7
         zrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699694575; x=1700299375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf1eecC3Yo7gOC7YXtpAGe0WJRP6o6FR9hdwtJ02C9s=;
        b=XrJ+ij1beXCpBKJ8AlHiyony6OGBcpIlbltZs9sWxtcXTKT03rzfpopUC/7r5vhOoG
         gx66fUmkmD/FHWJwyZD8Mad8nMF4kAzsaZXjuehy8GL3QfBFpXClLSNR/TMBd9nKNGII
         vdqVgHBBAepqqsEhw+CgO6LrjjPyaPDf0t2t0PtEy+2xvwRelSDdkYAKs2FY4/Xx/m2K
         GbubrSocqfpiXkyt4SunG7U+QxR1q5YC+DJt5dcM2BazUDp7bXiXbacRYXx+Cunk64H2
         6FSe4QHk3em//WK6FNeX1Dy4SnKHfT6o5uCmRtLkqDujimQ3wRCDVzBkc1Ihv15BrE9C
         ZBIw==
X-Gm-Message-State: AOJu0Yzn1LMmdpMNB7+HDLYaU8pRjRwcbUCpyk9F9QwJofhYHUt61F67
        gxzFRE+7Cn8xaWgiBoiI8/A=
X-Google-Smtp-Source: AGHT+IEDC7DeH/pyjS24XiFRf34wIT7xA0ESvF+ILQ6b/JcaSmo/XV7xrxMQDmjA55MQzca81xr7sQ==
X-Received: by 2002:a17:906:3655:b0:9ae:5253:175b with SMTP id r21-20020a170906365500b009ae5253175bmr1053088ejb.34.1699694575052;
        Sat, 11 Nov 2023 01:22:55 -0800 (PST)
Received: from desktop.localdomain ([109.95.114.4])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906358700b009adc77fe164sm767684ejb.66.2023.11.11.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:22:54 -0800 (PST)
From:   Tadeusz Struk <tstruk@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Tadeusz Struk <tstruk@gigaio.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, stable@kernel.org,
        Tadeusz Struk <tstruk@gmail.com>
Subject: [PATCH] Documentation: PCI/P2PDMA: Remove reference to pci_p2pdma_map_sg()
Date:   Sat, 11 Nov 2023 10:22:39 +0100
Message-ID: <20231111092239.308767-1-tstruk@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tadeusz Struk <tstruk@gigaio.com>

Update Documentation/driver-api/pci/p2pdma.rst doc to
remove references to the obsolete pci_p2pdma_map_sg() function.

Fixes: 0d06132fc84b ("PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()")
Cc: stable <stable@kernel.org>
Signed-off-by: Tadeusz Struk <tstruk@gigaio.com>
---
 Documentation/driver-api/pci/p2pdma.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index 44deb52beeb4..9e54ee711b5c 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -83,10 +83,9 @@ this to include other types of resources like doorbells.
 Client Drivers
 --------------
 
-A client driver typically only has to conditionally change its DMA map
-routine to use the mapping function :c:func:`pci_p2pdma_map_sg()` instead
-of the usual :c:func:`dma_map_sg()` function. Memory mapped in this
-way does not need to be unmapped.
+A client driver only has to use the mapping api :c:func:`dma_map_sg()`
+and :c:func:`dma_unmap_sg()` functions, as usual, and the implementation
+will do the right thing for the P2P capable memory.
 
 The client may also, optionally, make use of
 :c:func:`is_pci_p2pdma_page()` to determine when to use the P2P mapping
-- 
2.41.0

