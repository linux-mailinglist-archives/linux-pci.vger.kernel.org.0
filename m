Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD704DB46E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 16:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356987AbiCPPKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 11:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357037AbiCPPK1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 11:10:27 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA7A6583F
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 08:09:12 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7CB0C3F60E
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443348;
        bh=pKuO1Pnb8DTWNu323Li1Km8nI1auNgT3IB1hncz5HlI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=p72fYGXGER+bSUwgR/xmNgPEGfFXE8avM62ZXb0E7syzySxOwslp3dzKtglyqC9iK
         w9joGLA2AkoN3Q0rB1H6+ONS1d8+UzQTwN+SZlwmf17+n260ATm42lOoR+tSBm6F7G
         tNCn7b8hKnMyHGuzXGpQnVPLuTxjO9h0lbbNOnhtZD0CAAJntj76dEPjonNFfX03hn
         oPQiO6e/N4iQikPlVv8J1zHp7iyvfG94TxKj0dqOmZlFImH3S6MJXyGN6HIhmVDxUU
         NFTGYIv2nFcS/r7bY9/+EdhAaWVqxywzGdCAgTfPuloh1E+TmPXjsUDdvY2qJjxm2v
         N6+zLE8iDBRHQ==
Received: by mail-wm1-f72.google.com with SMTP id o19-20020a05600c379300b0038c7117460dso598520wmr.6
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 08:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKuO1Pnb8DTWNu323Li1Km8nI1auNgT3IB1hncz5HlI=;
        b=mDp8Gdf0BM4mBnRFKMo9WxBekeHPjdhOv0QKVHhA+Nwn5KPwt3YFMUIU7rQwcOtpFB
         GxWkr62UtSWvozog0uM7OAc0wNhOo/r+VtLz+KD2VG4IxiFS3x/2iklf1gHO/setbcce
         +LmFH2k/VeQ6ebSuO8/0UD2H+CdGmN8QStXI2DiWPcyl+3NCvURuNMR4yFFHtPBAAXC6
         1vRHkDnaTxHMJQyZeBExczH3sMli9VHJ6mey+vZt4hLN+oIJKpYF3P+DQbXSMJi5zxf5
         u5jAtXWovA2uzrUaKQ9SxUqV+CHRf1eZYqBb1oYQyEPaXqnPED/USkcsrF+XxIidTqnL
         Y+Aw==
X-Gm-Message-State: AOAM530NTBR/91BX4XoDxXgjSzqiSptw6X87yFnistDtSee/ABnYXFKd
        5zNMOg7kK2pwpv0TO2BixmM5SROSZj47jItlKjL17evRVBYLDu9A0SJsr32wOZF9CLGpRWeXlNa
        m72DJaW+ochKaygiRP/80YsS+9//ARQrBYw5WbQ==
X-Received: by 2002:a05:600c:3508:b0:38b:cc1f:a99b with SMTP id h8-20020a05600c350800b0038bcc1fa99bmr6311336wmq.197.1647443348129;
        Wed, 16 Mar 2022 08:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvsOYZ+nBmu9loCTPKjgh/9mwESfnIbe8Inxn1yryPkv1+wBIJxw3Cp/IL2PJnd3eHgVih9w==
X-Received: by 2002:a05:600c:3508:b0:38b:cc1f:a99b with SMTP id h8-20020a05600c350800b0038bcc1fa99bmr6311319wmq.197.1647443347937;
        Wed, 16 Mar 2022 08:09:07 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b001f04e9f215fsm1895105wrm.53.2022.03.16.08.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:09:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 11/11] rpmsg: Fix kfree() of static memory on setting driver_override
Date:   Wed, 16 Mar 2022 16:08:03 +0100
Message-Id: <20220316150803.421897-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c     |  3 ++-
 drivers/rpmsg/rpmsg_internal.h | 11 +++++++++--
 drivers/rpmsg/rpmsg_ns.c       | 14 ++++++++++++--
 include/linux/rpmsg.h          |  6 ++++--
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 79368a957d89..95fc283f6af7 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -400,7 +400,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index d4b23fd019a8..dd1f4ed616b6 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -95,9 +95,16 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
 static inline int rpmsg_ctrldev_register_device(struct rpmsg_device *rpdev)
 {
 	strcpy(rpdev->id.name, "rpmsg_ctrl");
-	rpdev->driver_override = "rpmsg_ctrl";
+	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
+				  "rpmsg_ctrl", strlen("rpmsg_ctrl"));
+	if (ret)
+		return ret;
 
-	return rpmsg_register_device(rpdev);
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
+
+	return ret;
 }
 
 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index 762ff1ae279f..95a51543f5ad 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -20,12 +20,22 @@
  */
 int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_ns");
-	rpdev->driver_override = "rpmsg_ns";
+	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
+				  "rpmsg_ns", strlen("rpmsg_ns"));
+	if (ret)
+		return ret;
+
 	rpdev->src = RPMSG_NS_ADDR;
 	rpdev->dst = RPMSG_NS_ADDR;
 
-	return rpmsg_register_device(rpdev);
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
+
+	return ret;
 }
 EXPORT_SYMBOL(rpmsg_ns_register_device);
 
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 02fa9116cd60..20c8cd1cde21 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -41,7 +41,9 @@ struct rpmsg_channel_info {
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @src: local address
  * @dst: destination address
  * @ept: the rpmsg endpoint of this channel
@@ -51,7 +53,7 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
-	char *driver_override;
+	const char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
-- 
2.32.0

