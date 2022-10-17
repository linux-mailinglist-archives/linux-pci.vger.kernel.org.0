Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296A660110D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJQOXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 10:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiJQOXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 10:23:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542A565278;
        Mon, 17 Oct 2022 07:23:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so12818381wma.3;
        Mon, 17 Oct 2022 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqqfVLOxILFk0qEHZSQ0cmR9EC3sGib5qPhxAGrH5s4=;
        b=Mv04zLaeTr9p+iTUMg17u98X5TuNK1AMn+THpruMtXd09FdJuv5TUgpqieSS4ZTuWs
         UBrBK1hJfX8OkRrjHB+w6Dqqi6IF5tLPd8XzgoqkGer5E3FVfnR+Y5LpW69hxdwBBYSN
         QbV2jdxT8p8R6dBoIc66FtEnLfmqjvR66pmwit8CVMVQ4pjKDmX88AcfGXl89ouUNA9n
         iriLXwP/pAQ++dlNwiLoLEpP97RnIMu80UGv4slNXk9E+qmtWf65JPbdZ5HBDcIKVNW1
         XAfVsrYopWvmHHxLsC08+s0qM8vijF8o1nCRWwMpUviq/bfHOISPCrdI/MSvhN0f0on8
         ow3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqqfVLOxILFk0qEHZSQ0cmR9EC3sGib5qPhxAGrH5s4=;
        b=Vxtf7cShBko8ESV4NsvyiQsCk3SO6G/6jBszWc7UZTw3wE1otTZl5refQZQmyL/aRT
         K0m5Qy8sZp2VdwfMEiYU5BUuXSVuILWtWJTJhpdGblOUNTMqEZiAJ3X0mq3HuSf5cHCv
         ZcYfO9cd/WkOGYh2CyeS3N/glIL5YAutLr9kxKPTzgNwdbm4R3I5JdDUlY80uvfsmFsn
         NIiCS87o33gtc0m43M8XRCL+BJ0ujD6+YfyuGPRsU7La1GLOpnT5IKETDfJ2UuXr7VlW
         MYU3DbrOx8bfJ2J0TiFpmZuH9KOdoEq5JziSAqGR3BaRLJ/Gi0YmlHdgBD4cf7GF6Oq/
         xG2Q==
X-Gm-Message-State: ACrzQf1Hk9+jErh35vscEnzUzPsQFv2b5Wpw2+36nmwry5bXU/d1OolB
        8J7b61StFJ2Q7/KASV2EbQ+xTGTEkp8=
X-Google-Smtp-Source: AMsMyM4e3KIFDAkZ3q9/pGzSQzj+usjA3UMxVF0fVYZNl7X2g8zBP7DgNwAazss6E6xQrcD+a807DQ==
X-Received: by 2002:a7b:c3c4:0:b0:3c4:785a:36d7 with SMTP id t4-20020a7bc3c4000000b003c4785a36d7mr19941334wmj.138.1666016621738;
        Mon, 17 Oct 2022 07:23:41 -0700 (PDT)
Received: from chgm-pc-linux.. (089144219037.atnat0028.highway.a1.net. [89.144.219.37])
        by smtp.gmail.com with ESMTPSA id y3-20020a7bcd83000000b003b492753826sm10151613wmj.43.2022.10.17.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 07:23:40 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Christian GMEINER <Christian.GMEINER@bachmann.info>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Add Bachmann electronic GmbH vendor ID
Date:   Mon, 17 Oct 2022 16:23:37 +0200
Message-Id: <20221017142338.1445199-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Christian GMEINER <Christian.GMEINER@bachmann.info>

Signed-off-by: Christian GMEINER <Christian.GMEINER@bachmann.info>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..b93a52977d85 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -166,6 +166,8 @@
 
 #define PCI_VENDOR_ID_UBIQUITI		0x0777
 
+#define PCI_VENDOR_ID_BACHMANN_ELECTRONIC 0x0bae
+
 #define PCI_VENDOR_ID_BERKOM			0x0871
 #define PCI_DEVICE_ID_BERKOM_A1T		0xffa1
 #define PCI_DEVICE_ID_BERKOM_T_CONCEPT		0xffa2
-- 
2.37.3

