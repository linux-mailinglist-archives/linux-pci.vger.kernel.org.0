Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281054DB414
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 16:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352263AbiCPPIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 11:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356954AbiCPPIJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 11:08:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E637BD6
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 08:06:47 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E6CB53F94B
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443205;
        bh=BsP1eItj+J1d4aDzpqEMBIF5j1znYVUHQj+VHIPIFgg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WS3M4frvuluzZshD01wz5LS7RawSzQWIzcQ3WGgWEPmLPeRtljZIzYWEWmt2cA/Oc
         QlXSqJ3So0rvmLAJoy5OFe1tjXRnTKs9/mnKQWyM3waKOsEnvAW7NGSjsR/GcFT/3h
         et5FO4jKUwNGX9NTAk8F9VAEJKr4SFJiql8L2inM12MAACPyM712s3MtiUmCfDdVCM
         FrkJA/iBIL8hg2wkxOhgT3BegH1mgxEONEAnlOQbqW8cVGGikQUl1PtKMYBrOCL65I
         Zh/AvrEC6e3mOejguujELJTgHjK4i5r7OsgMzvlYnUWMWVRNZZkw5XN0Hl2g1fIuyd
         2YjXHTq/jQGyw==
Received: by mail-ed1-f70.google.com with SMTP id s9-20020a50d489000000b00418d556edbdso1492513edi.4
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 08:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsP1eItj+J1d4aDzpqEMBIF5j1znYVUHQj+VHIPIFgg=;
        b=QP08VYYN148az58bjmLID2BmfVvoY1ssywe2sxBqdjD9JkibGch9gl2bCcr/Vv2+F1
         WipoJOy+dyalHbTY3PNLuLi50zYoY6tDZ8oErVu+/HHXYoTD1sZN38eEMDDt8dx+5wFo
         lVKhnbvtBToS3lB4liNqnzMDyq4YiY9PI8H55DhNNptAt2sDex+0PTk0PjqAp44sTyyp
         t1vPFm6UqoVpUMsm98poFmxg5QbYL1m5PoAbt0cjARxnR3pDpH67UqP3SZHum0nmehy0
         rKPcxoLN4UutBcl7+Gq4MH4uFJCQkyMF2f9YUzh9ZrTl+GMK0lLgsP7GGdeGO4kz731t
         aC3g==
X-Gm-Message-State: AOAM533YOT8/WUgjls822vR2klfoiXSWNu5uymGe2u7eDwt4MYsOl455
        h6yZEL1nC08GDXeNdqBU8IV3pPUwEzy6gvPH+XO7YfMZXB3yCZEknXDLI25+Fz8jUdZa0aZjUAz
        pJNTOmMw2sBxX3PQbQCxFDKfc2BafRl15h+FRbw==
X-Received: by 2002:adf:f68d:0:b0:203:7b96:a7ff with SMTP id v13-20020adff68d000000b002037b96a7ffmr326827wrp.101.1647443193782;
        Wed, 16 Mar 2022 08:06:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoarwZUHPsM12itXV7mRUexTXGgAuLA6KWe3K/HjtbGdnXbQ8PTTCIoN4L2QaZn0F+apvl9w==
X-Received: by 2002:adf:f68d:0:b0:203:7b96:a7ff with SMTP id v13-20020adff68d000000b002037b96a7ffmr326805wrp.101.1647443193616;
        Wed, 16 Mar 2022 08:06:33 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d59ae000000b00203dcc87d39sm3130155wrr.54.2022.03.16.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:06:32 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v5 03/11] fsl-mc: Use driver_set_override() instead of open-coding
Date:   Wed, 16 Mar 2022 16:05:25 +0100
Message-Id: <20220316150533.421349-4-krzysztof.kozlowski@canonical.com>
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

Use a helper to set driver_override to reduce the amount of duplicated
code.  Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 25 ++++---------------------
 include/linux/fsl/mc.h          |  6 ++++--
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..ba01c7f4de92 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -166,31 +166,14 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
-	char *driver_override, *old = mc_dev->driver_override;
-	char *cp;
+	int ret;
 
 	if (WARN_ON(dev->bus != &fsl_mc_bus_type))
 		return -EINVAL;
 
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
-	if (strlen(driver_override)) {
-		mc_dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		mc_dev->driver_override = NULL;
-	}
-
-	kfree(old);
+	ret = driver_set_override(dev, &mc_dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 7b6c42bfb660..7a87ab9eba99 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -170,7 +170,9 @@ struct fsl_mc_obj_desc {
  * @regions: pointer to array of MMIO region entries
  * @irqs: pointer to array of pointers to interrupts allocated to this device
  * @resource: generic resource associated with this MC object device, if any.
- * @driver_override: driver name to force a match
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  *
  * Generic device object for MC object devices that are "attached" to a
  * MC bus.
@@ -204,7 +206,7 @@ struct fsl_mc_device {
 	struct fsl_mc_device_irq **irqs;
 	struct fsl_mc_resource *resource;
 	struct device_link *consumer_link;
-	char   *driver_override;
+	const char *driver_override;
 };
 
 #define to_fsl_mc_device(_dev) \
-- 
2.32.0

