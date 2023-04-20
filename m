Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1239A6E8E6C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjDTJpX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 05:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjDTJoy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 05:44:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D0B59C6;
        Thu, 20 Apr 2023 02:43:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so1096046b3a.2;
        Thu, 20 Apr 2023 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681983819; x=1684575819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22leYJ3fAb4IkKSKuxkJCnb9O++TiihTGfleYhQ+ChY=;
        b=If5DiSAjADKIt80CoPoUC7iaYoGdq5Nj5LLX+iGoVlCAZ2X5aNSHBb8xfEix3dC2JP
         D7NwB+Y+b6ExmBuaF78sOefmi8Yolc9RKHBwNWZMPPJ9C9cBcFQnnIluJXUdU7N9xlMz
         Og29T+R3u+33FLsc+NKrv7XNo7k7GCpsoGrjfWvKMrouBBCcJAKV3CAcOSCx0LGqruD4
         vGgl+cRKRegFAabNJ2T5iAgE6ObmpVrdxw/2S5IfxpPYYh/81f7g/+7iHJetwHmZB8Tv
         Y0W1wlvLWm+n2Ja6/AB4SyupmbkeJkjXOIShJzT+fUGx8h/3M2+gqcNO4sOrmiO4UaYU
         iruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983819; x=1684575819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22leYJ3fAb4IkKSKuxkJCnb9O++TiihTGfleYhQ+ChY=;
        b=LeOl8n4xLYdGJvrLKCR/8Sn1G0rRqznQWIJo5nUfaZIjZZzXMupPz2yhsHgOusapbN
         CrhyuNOBFeTHVVhJkszLf9Rxq3FDseehxgBwZsQszPDoApieUERWwgN/x1NobNKo6rQJ
         StEFrONNScpWy7jzRUAKOSU9MF6M1iWjdgGvgC/VRhEW+oF2PE+3jdMlGSqXyD4eZojC
         K+gUwDonZCh3Y+Qu20JA67PkDgXH1dsjz8d8eTbugxMCtjaR1utaM+N9C5K42HkOegP5
         5xmK1seTiSstGCtmaqyyhIfoeDmZmp2C+Zh+wXsLm5tcL15zQg22E4WNBBxvB7/dRCMo
         dppg==
X-Gm-Message-State: AAQBX9fIn45hHiKOdo7B40mOok/Mtryt/LU+npvfcLBjm7KNImwuPnX5
        jfaGeSjd2Ny915AKvWtbqQk=
X-Google-Smtp-Source: AKy350aGNh2hdLifle8goSpF0ODdFVS27BI1Q0FBH3+lufe55qzou2nU9g+HcSbIZKEUn/ZR3zP7/Q==
X-Received: by 2002:a05:6a00:1818:b0:63d:24e4:f9c with SMTP id y24-20020a056a00181800b0063d24e40f9cmr773922pfa.17.1681983819179;
        Thu, 20 Apr 2023 02:43:39 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id t1-20020a62d141000000b0063b8ce0e860sm874336pfl.21.2023.04.20.02.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:43:38 -0700 (PDT)
From:   korantwork@gmail.com
To:     dlemoal@kernel.org, helgaas@kernel.org,
        nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2 1/2] PCI: vmd: Fix one uninitialized symbol error reported by Smatch
Date:   Thu, 20 Apr 2023 17:43:31 +0800
Message-Id: <20230420094332.1507900-2-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230420094332.1507900-1-korantwork@gmail.com>
References: <20230420094332.1507900-1-korantwork@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xinghui Li <korantli@tencent.com>

There is one uninitialized symbol error reported by smatch:
"drivers/pci/controller/vmd.c:931 vmd_enable_domain()
error: uninitialized symbol 'ret'."

Fix it by assigning ret with pci_reset_bus return.

Fixes: 0a584655ef89 ("PCI: vmd: Fix secondary bus reset for Intel bridges")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/pci/controller/vmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 990630ec57c6..1a36e9a52b93 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -927,7 +927,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		if (!list_empty(&child->devices)) {
 			dev = list_first_entry(&child->devices,
 					       struct pci_dev, bus_list);
-			if (pci_reset_bus(dev))
+			ret = pci_reset_bus(dev);
+			if (ret)
 				pci_warn(dev, "can't reset device: %d\n", ret);
 
 			break;
-- 
2.31.1

