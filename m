Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA116646B7
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 17:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjAJQ5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 11:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbjAJQ46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 11:56:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4D6175
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 08:56:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v2so1461682wrw.10
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlNxrwuGFyPGLoPwPI30O34tsYGN152NUipyHwYQGtk=;
        b=YeJaEvkxfx/MG84ZL8LfrDbZ/Aq0e/mcARdZitN9SdftgbaL8JEJTvHQvWKTDD4NtE
         TxkxlzH4u45NacTioohnwL5Qju6XbXNTYhdBmz2oT+v5FyqTtX2EbECnsqDmw0AOaQK6
         bY/JrPZy8pGNsSWiRokppn9wcGRJ77VGugy3vU2Wti93JZ2uCWd0A3+09Kv1iLZtxZp2
         jTEliGn9WSeoZ9ky+SCBgEQkgGjgh7v+kTEt9/rpbCp8A9S4MImJ6KU+PIU4qO4K10zh
         /2wMd+huU4WC1gzOffNBxmZV70EBpOA15cIhV2/8+7gTJ+z3QiN0xsPT3EWqp4TcNcDr
         JHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlNxrwuGFyPGLoPwPI30O34tsYGN152NUipyHwYQGtk=;
        b=0mHwrm/We4dG5k9vvr5VtJdM4xE47qP4Z6FdEr7JSDQUWjPZgw2CPncxAsU6Bh81yi
         9c7tBFSSguhS3L5OvAHYziUwV2z8kH4qSkyl4vrQxCsHQMLKEd7NvZ7QLMF6YYz2BgNB
         gndoxtdxdhEyNIJsfn76hTaRHFJ27nh2qG5ZcjkEnS56Ds6heW+0hXJxVoU/M1Wfhoo+
         XmZMYcatw1umFLV7oMio4R9YmVeTwf7strVh1EAYZt9d+ca/Bi2IfTSvJpyyNm9IRovP
         uf2UD5t1RN+fKxfkNQgR4hKW/r8EBZ77VDYGDOqG09tvUZAIgdVynI79H9GaCI6cSRbX
         CDsA==
X-Gm-Message-State: AFqh2kq/V7Ph8Hh1YRuODguP9pL8r1EX0y67OWSb7n8bxxkOZnc0mEDd
        H5rU8R92Om2zl8X2Hf6GEADTBs/K/FR88s8O
X-Google-Smtp-Source: AMrXdXuHqKqd7VPyUwLF0A0z0COCPVuG9BTDEIB2kMwLsPhDfNhoshPTDFgmxT7CiBm+hcCztDWZDg==
X-Received: by 2002:adf:cd0a:0:b0:2b7:26c1:e81a with SMTP id w10-20020adfcd0a000000b002b726c1e81amr11863825wrm.25.1673369815162;
        Tue, 10 Jan 2023 08:56:55 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b00268aae5fb5bsm11918066wre.3.2023.01.10.08.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:56:54 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, helgaas@kernel.org,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 1/3] PCI: Add SolidRun vendor ID
Date:   Tue, 10 Jan 2023 18:56:36 +0200
Message-Id: <20230110165638.123745-2-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230110165638.123745-1-alvaro.karsz@solid-run.com>
References: <20230110165638.123745-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add SolidRun vendor ID to pci_ids.h

The vendor ID is used in 2 different source files, the SNET vDPA driver
and PCI quirks.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b..6716e6371a1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3092,6 +3092,8 @@
 
 #define PCI_VENDOR_ID_3COM_2		0xa727
 
+#define PCI_VENDOR_ID_SOLIDRUN		0xd063
+
 #define PCI_VENDOR_ID_DIGIUM		0xd161
 #define PCI_DEVICE_ID_DIGIUM_HFC4S	0xb410
 
-- 
2.32.0

