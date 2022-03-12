Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509B14D6F2B
	for <lists+linux-pci@lfdr.de>; Sat, 12 Mar 2022 14:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiCLNbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Mar 2022 08:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiCLNaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Mar 2022 08:30:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399B7E3393
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 05:29:32 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B1C15405D3
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091771;
        bh=Fv0wjNs2b5QtUq9euXNEr2b5kaqy1J/ffW8/38DamY4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Cd/jriybVCnYNDZa2LHjnuMtabf5H1tXszwxqpnm45s9u4PI0MYxczPyUyEO2U0g9
         j4uRe1QoEkU6XgKJczLiEadFXq3nfJKAVwTqGFa/G/0UKamM2RY6rbFr5EOdwQuErc
         b2lJwGgKnQtO+kvVoQ9457OB9Xzx9HISeU/lO4qOVYHwFGAWHUwfT0wxZWopeJfDbu
         ZTvNlOkMvjImko7/40yx9lk7v6m1UD7S2Pbo6HuKhotOU7Kxlsmfnfl3cb2EHB7gEO
         0Rykz55Kj9BwEOnQ4TeyRxbpjTlGzHwB3Wwa6ghKvoILhfCqCF4YFUnvOz9PaFxwad
         CObkn32Q3PQLg==
Received: by mail-ej1-f72.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so6283875ejw.9
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 05:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fv0wjNs2b5QtUq9euXNEr2b5kaqy1J/ffW8/38DamY4=;
        b=cTZGsHJwTOjBV+GelhCtWjbVQhws2Z0/HCzEzrcBpg++wbQzwHMNEPA4LWfhFp/1KD
         JMVFhzeIksL4UgaoWTVKfHTxddFoT8xbw3PqNunAaT2SkC975VCjI/vyoO/788vbmRGT
         t30lMeeCfiPVa5w4j2ApLohcyl2kQXwgdjCwV0E7KY9Dl3YDZTgrzNA1owBj+9Hy7Fvr
         Mp9jkrSZjLx9lJy7jvft31oRgFKFOu/4ioldHt5wxe1UzTnp3bZ7RIrcNAG0svF7SugJ
         qmq8niOrOogzGj9wqFJtnrGMQnxl+do6tzI+WDz0p9lj9P2eaKL2Ud/5TEkl8dxN4qHU
         tqnQ==
X-Gm-Message-State: AOAM532IUWJhYLtJCtNY6BMq20USFCofbUrC8UbbSnsEOd0/VfNbwbuG
        UJgUArxYW9Y5Evbbtz60+o0xWoReywygGAAQWls9rfFlxOv3bUySP/Qu9D025lQulsBnyL/n89k
        R7sxnwUDtbmorSu7v3Z8ZGMzIdMjy2dsV5Sw8Iw==
X-Received: by 2002:a5d:458b:0:b0:1f1:f876:48e2 with SMTP id p11-20020a5d458b000000b001f1f87648e2mr10681265wrq.76.1647091760263;
        Sat, 12 Mar 2022 05:29:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDBzysSy5dJPpClWLlHuYPvBegFX8iikOsVYCIkiLzfLC7xpzwCpZjF6/7zZtW5qI29WBIOg==
X-Received: by 2002:a5d:458b:0:b0:1f1:f876:48e2 with SMTP id p11-20020a5d458b000000b001f1f87648e2mr10681251wrq.76.1647091760021;
        Sat, 12 Mar 2022 05:29:20 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v4 04/11] hv: Use driver_set_override() instead of open-coding
Date:   Sat, 12 Mar 2022 14:28:49 +0100
Message-Id: <20220312132856.65163-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use a helper to set driver_override to reduce amount of duplicated code.
Make the driver_override field const char, because it is not modified by
the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 28 ++++------------------------
 include/linux/hyperv.h |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 60ee8b329f9e..66213ce5579d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -575,31 +575,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
-	char *driver_override, *old, *cp;
-
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
-	old = hv_dev->driver_override;
-	if (strlen(driver_override)) {
-		hv_dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		hv_dev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &hv_dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index fe2e0179ed51..12e2336b23b7 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1257,7 +1257,11 @@ struct hv_device {
 	u16 device_id;
 
 	struct device device;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
-- 
2.32.0

