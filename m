Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52144C5BA7
	for <lists+linux-pci@lfdr.de>; Sun, 27 Feb 2022 14:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiB0NyU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Feb 2022 08:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiB0NyS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Feb 2022 08:54:18 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBEB1403B
        for <linux-pci@vger.kernel.org>; Sun, 27 Feb 2022 05:53:39 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E67874005E
        for <linux-pci@vger.kernel.org>; Sun, 27 Feb 2022 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645970017;
        bh=npGNvoQmcQXzOf9MUvG7bOfkjnwx60Xk35PbEgCfPxw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cDWFSmZZYRtPsJ2YUaiCLsFkh01X49HLxMar5FmeYO5fYHIrCKOQuRkjvscYN2MWz
         DI0coHFZV3p5iEYQ+IM2O6KgP9XmWWpxXiM84woucYZYReMlN9MuzQxYAnsOLCa+g+
         bU2PWii9gvUJJy1Kp5IW5zmPmnV+10vY406IK1+zgPTghhZTraeyZkewyrs4Du2yNq
         skz7IBlRNp1sjoukGdChB+/SX+Egm0v6lld7YSgUFA20Zjz+kDqE1HEfRFhkYkvCic
         lo6sEdPUMxQ+qWRmBLu0+2MRswe3kCIqCBibYpn+vpqBViN2/ZUHe4y8fbe7+Fb+38
         X2y25DTZkZrVQ==
Received: by mail-ed1-f70.google.com with SMTP id x22-20020a05640226d600b0041380e16645so2335864edd.8
        for <linux-pci@vger.kernel.org>; Sun, 27 Feb 2022 05:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npGNvoQmcQXzOf9MUvG7bOfkjnwx60Xk35PbEgCfPxw=;
        b=tmndxetdF8Mvyc382mB0Yf+Hwl+MkmaAXqn1YfujbwYf5Ldn9lqbWBuXVIRWHRl/Yo
         sjltsPj3zji9ip5oWJMmak029tA9vtCYaa4TyfaLA55C9MT2f3g0iSBs32IyYh/Y64YK
         ETJAWxbD+Q4AOk+yEHfVrrhwiwVwKREFUaNIti6sRpzYfkp9/C6xPTIZZND61oEDOvmW
         R6zpcMWjkNZTuKLkqJFaTwI6h+sgsgBoXnTuEzAcPWqqUvmwxliXG7onqc8e0OvjW7zH
         ha+qcnoG4N1rAj55qyiQN7hlMHxyEN+8xEaq30Y5+iEtMug/fEP8jIEf5F2OMKK0SrdE
         scCA==
X-Gm-Message-State: AOAM531YANE4a9wzNvsTOY5FRyP2k9hHHAJJPqcCRmuHuGwF+djsWrV3
        AvZP9crO/+5yVNhpN+y5zeerw1tGmd2OpEeHL2Wx2nCe77o7WkQBnQwX9kKHGm1WhjtXFfXRyrF
        /s7nIqbrdnG5wNQObN2hDsKFq5ibsoXWz+0I9PQ==
X-Received: by 2002:aa7:d49a:0:b0:410:875c:e21b with SMTP id b26-20020aa7d49a000000b00410875ce21bmr15261507edr.357.1645970017417;
        Sun, 27 Feb 2022 05:53:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzicu7l4IEwzqhlq2xIFoxdFytokSeMFkgjaEtpJW9Dl/uL3ibJtEoSzuA4VDSoAwu8n3nm0A==
X-Received: by 2002:aa7:d49a:0:b0:410:875c:e21b with SMTP id b26-20020aa7d49a000000b00410875ce21bmr15261460edr.357.1645970017251;
        Sun, 27 Feb 2022 05:53:37 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b00412ec3f5f74sm4600760edv.62.2022.02.27.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:53:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
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
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 08/11] vdpa: Use helper for safer setting of driver_override
Date:   Sun, 27 Feb 2022 14:53:26 +0100
Message-Id: <20220227135329.145862-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use a helper for seting driver_override to reduce amount of duplicated
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/vdpa/vdpa.c  | 29 ++++-------------------------
 include/linux/vdpa.h |  4 +++-
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9846c9de4bfa..2d924a89ce28 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -77,32 +77,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	const char *driver_override, *old;
-	char *cp;
+	int ret;
 
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = vdev->driver_override;
-	if (strlen(driver_override)) {
-		vdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		vdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = driver_set_override(dev, &vdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 2de442ececae..89ec4e4d4cdc 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -64,7 +64,9 @@ struct vdpa_mgmt_dev;
  * struct vdpa_device - representation of a vDPA device
  * @dev: underlying device
  * @dma_dev: the actual device that is performing DMA
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @config: the configuration ops for this device.
  * @cf_mutex: Protects get and set access to configuration layout.
  * @index: device index
-- 
2.32.0

