Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99427910FF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 07:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352255AbjIDFod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 01:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjIDFoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 01:44:32 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993D412A;
        Sun,  3 Sep 2023 22:44:28 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1d4c9494b42so770452fac.0;
        Sun, 03 Sep 2023 22:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693806268; x=1694411068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAm78ZzPbw4FrS4zLROjKE8sBNAUiQROVAB/OHMO/JA=;
        b=N3R2WRoVFeKdzL6bGYC4FUx+wZRmyEh709QnuXnN+278ZWWr6tqkI9u9SIOCYTr6An
         9Fq6a+J9KbQXWgftT0wxGEui/w8qfIzAKZ7t1HATYJHbHSRkpdDf0vVP6yOr/DbDL0pC
         fxd0tbk63m4zvbdX/USrXdE7Owxn1g50j0sfIHW0qv707JHTRFqlBgJcxrvEVRgcKeIS
         G9PGmeZN+N6v/H9ENQY1pfFOlDLDicGAMhK4KYRVmLpyVQA2fkrtIebYQAP7RSY31Ti4
         FRgR/a3RlcByP/XE0R2BHFmeS+fKPiVO0XIQw114CvuYZjMnjH/3z1bJQns1cRtStJ+7
         YcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693806268; x=1694411068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAm78ZzPbw4FrS4zLROjKE8sBNAUiQROVAB/OHMO/JA=;
        b=jfb0WkYcG+/Sol+qtUUPmFnQHxqryHJ1/FRx96VBSiX+KvJ+3p7TzU01RrGQyZ8O2H
         zCsn1svoZuXtz7QBaIlmwKHIp5tCyFNGD7YBSS9aIqr8TJW+D4izBNDZAomv19RiRpcg
         HQyL1ufJrxtCGts8uR8D/8TyJAD1bVmxxq48Xn+scCF+zTrT5lxSamPkOddwJr5aMMbL
         jEcHVnZq8JiZT0J7N9N+piyLJgzZmKLiIcjJ019Rm2H8QsVVq6ac958+aopchjSdrEh8
         UGBR745F/+XB8b7wCkIqwCSp5otYz5rwmOdbQkqFIfezgluobwcrbzIZBc59nU9whMEA
         A8LQ==
X-Gm-Message-State: AOJu0YwkaiChlgYgHmHU1t6BmkJWHPF76aHg7MwYA1Z+O+6gfoHXODQl
        9kSzoW/Zgsk0JjFa0eqQrT8=
X-Google-Smtp-Source: AGHT+IG5OgF+rGnOBB4RQPUgu9ojBdvDZBMqkEApWzrmc2Uo9PqinWkxfaFWap0Q4z8+LYr2PI22Xw==
X-Received: by 2002:a05:6870:b6a3:b0:1d0:d44f:46d4 with SMTP id cy35-20020a056870b6a300b001d0d44f46d4mr12271687oab.28.1693806267879;
        Sun, 03 Sep 2023 22:44:27 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net. [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
        by smtp.gmail.com with ESMTPSA id h3-20020a63b003000000b0056c466b09a4sm6803450pgf.59.2023.09.03.22.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 22:44:27 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 3/3] PCI/DOE: Allow enabling DOE without CXL
Date:   Mon,  4 Sep 2023 15:43:29 +1000
Message-ID: <20230904054329.865151-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904054329.865151-1-alistair.francis@wdc.com>
References: <20230904054329.865151-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe devices (not CXL) can support DOE as well, so allow DOE to be
enabled even if CXL isn't.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v7:
 - Initial patch

 drivers/pci/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 49bd09c7dd0a..a1223f46a902 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -117,7 +117,10 @@ config PCI_ATS
 	bool
 
 config PCI_DOE
-	bool
+	bool "Enable PCI Data Object Exchange (DOE) support"
+	help
+	  Say Y here if you want be able to communicate with PCIe DOE
+	  mailboxes.
 
 config PCI_ECAM
 	bool
-- 
2.41.0

