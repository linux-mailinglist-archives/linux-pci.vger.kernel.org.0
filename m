Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E0780210
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 01:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356312AbjHQX7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 19:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356341AbjHQX6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 19:58:45 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E823A8C;
        Thu, 17 Aug 2023 16:58:43 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-79a31d66002so131075241.3;
        Thu, 17 Aug 2023 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692316722; x=1692921522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55+40jxtA3P6XkOphpXmjT7MqNRWcdiP6Y+qR2y2ujc=;
        b=qDn4+b0HNawkSs2NxxKkhIeOhkmvQxP9CAXvBXRjHkRvKRYOyRsASjvgVnEAGrrBq0
         6S8y15U0msACFoEbuBSbnhxmbww7Vi3juvXZhbECHqC06aZn4SodAj/WvhbU0lJuCYQl
         hN2m6gk/egUW7lzy06FO2sBdODqnX3l4ltD/4ogHo0m+hw9QLwuS1/kOy8wSxNF3ps1T
         fJH81vQNi8Rb4MSWgu13lnEtQunOhr3t/5MVEnXRWD2KuWgVjFKZMw/0qdAaodKXQ9rX
         1xqEYEG4O8EzeOQGyrlVtD91uE1Dpq9ZNx5+MPl2lMGf8mscPi0dhPXLT1iPO3Gf3IBi
         94gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316722; x=1692921522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55+40jxtA3P6XkOphpXmjT7MqNRWcdiP6Y+qR2y2ujc=;
        b=bZhMgOovec4YpIvm+XW3T3e+a1pe4dQBx4Cb71Rm0lrErWZCT7Sr2XMlUeQENrhQUS
         rF4DhL+jQ9pUJOkiLUaXo48Y0w8MfoWpi8TtLYLJvicB1mUnHn/7TzEFSAF9P50bfEiF
         4EfhRXUKfC+lpnzUk32Rq3TEj5HjaMnfFbRy1K2ln/F85T+SRySahLS7smXVGqCzcgNm
         bo6WU6B7OqipKd90QGNWz+fXJPKuhZJuGg1SBR+pQ8GStR4ssVFMmcWDaEX9dvdNn7tc
         R5LRTWAU9Fk/XuUzw0qHhdH2UUeFIeEIUhos1Z94dmYS4wDQFh7gf3uSaE84hJFyAkW4
         1OpA==
X-Gm-Message-State: AOJu0Yzjo7pleFyQVKHtCM0MiOzNxMV3xnlx4vGkzZ8vZ42xjwJFhkTw
        ld8wwu5YRkFXs1yiyA/Ywok=
X-Google-Smtp-Source: AGHT+IFsTd4DINM89FbHHi3BCycS0X3bSd402Jmg0SpgktNoFaAV3+CmOUS88KSP3qlykyzXCWIEIg==
X-Received: by 2002:a67:e41a:0:b0:445:4996:1d27 with SMTP id d26-20020a67e41a000000b0044549961d27mr1612084vsf.3.1692316722052;
        Thu, 17 Aug 2023 16:58:42 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
        by smtp.gmail.com with ESMTPSA id k19-20020a67c293000000b0044bf2750d30sm135182vsj.10.2023.08.17.16.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:58:41 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 3/3] PCI/DOE: Only expose the sysfs attribute group if DOE is supported
Date:   Thu, 17 Aug 2023 19:58:10 -0400
Message-ID: <20230817235810.596458-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817235810.596458-1-alistair.francis@wdc.com>
References: <20230817235810.596458-1-alistair.francis@wdc.com>
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

Now that the new attr_is_visible() function is avaliable as part of
`struct attribute_group` we can use that to hide the attribute group
on devices that don't support DOE.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v6:
 - Add patch

 drivers/pci/doe.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 316aac60ccd5..1a021e8b3e0c 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -95,8 +95,7 @@ struct pci_doe_task {
 };
 
 #ifdef CONFIG_SYSFS
-static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
-					     struct attribute *a, int n)
+static umode_t pci_doe_sysfs_group_is_visible(struct kobject *kobj)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	unsigned long total_features = 0;
@@ -112,7 +111,17 @@ static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
 	if (total_features == 0)
 		return 0;
 
-	return a->mode;
+	return S_IRWXU | S_IRUGO | S_IXUGO;
+}
+
+static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
+					     struct attribute *a, int n)
+{
+	if (pci_doe_sysfs_group_is_visible(kobj)) {
+		return a->mode;
+	}
+
+	return 0;
 }
 
 static struct attribute *pci_dev_doe_feature_attrs[] = {
@@ -122,6 +131,7 @@ static struct attribute *pci_dev_doe_feature_attrs[] = {
 const struct attribute_group pci_dev_doe_feature_group = {
 	.name	= "doe_features",
 	.attrs	= pci_dev_doe_feature_attrs,
+	.attr_is_visible = pci_doe_sysfs_group_is_visible,
 	.is_visible = pci_doe_sysfs_attr_is_visible,
 };
 
-- 
2.41.0

