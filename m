Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392264D6EE9
	for <lists+linux-pci@lfdr.de>; Sat, 12 Mar 2022 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiCLNaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Mar 2022 08:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiCLNac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Mar 2022 08:30:32 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632EE50E3A
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 05:29:27 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B42343FFE2
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 13:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091762;
        bh=7mUFbCJbIndj6M7s/RjbSIBZAkFNvJ9seQGSdX0sCHc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SFWe0Ib54AyDEwdN3xck0y8mQCGwjEqTFDjKsESpskH8T810Vt7Ec+iFQt6BUExDV
         hbP9I9a9UyunFi1tTVCWcdE9YyHVnBAbswBI4MqODcxIyyY+a4XGQXrLO6XuHBcXPd
         if2aUe+wcx7p0ltL6tzXUrgI5vj7KNigQFcQMh36ukSILsGYNXzemDDnCiq5C6S4OE
         BxTYqAtAvMMrw1FO1HyqjgTfsyO7zUVQAIGo2/2w+DCSCwUSkPzCDgKXkWtVpSC46V
         1zk15KtSSdLyaNAZL3VG7nbrqF+Mq36FQ81j3BXh0NU9fodDxoCDztSzWOAWlqchNJ
         Rh7aebQ9wEKXQ==
Received: by mail-wm1-f70.google.com with SMTP id x5-20020a1c7c05000000b00389bcc8df46so4411644wmc.0
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 05:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mUFbCJbIndj6M7s/RjbSIBZAkFNvJ9seQGSdX0sCHc=;
        b=eaH/6D7J1UMfAp0Yxzd/4LehLUZhPR4pcbYMq+FhIwWHURNjyqjdgxHD+g3zvvpc/v
         uFbhmqpJ9bGATIVP2QuW/axtD7kHkNR6g0Z6InoVWWHKdDxHCqO6XVM373foJxLytbU+
         xuPIKKDhhvNHAyeBUNTqEyqf7i1VveGJvv5woyFotpvTPWxrLWnjTsUxBORiDWMzxIMK
         8UtN/jiTdSpx2mFUx4SjSECK/HglqcTcZPDod+d/BWv0fC4WyE9TxSVPh2eXx88lDw80
         +XnJtUo7bVxpdBJZV3ma9xpWVzVEHP7VG3sI91sn693Zg0wVdMOLjDptwMffTs3QZRSm
         v6GA==
X-Gm-Message-State: AOAM532LakUxQRJaeYCJG+0qGruTNcbc4YVZgKZ9LsPglfHJh5FUhhUg
        xReWkCkvnIw2goZEhsijmsBJpiOvncrHF+7ZxO3hX0GD/hiI68hCrg7CnMfNWjeoDigtG2n2OZN
        1UlBljRo5v8VLx3Vc4eQPGB2vQ2OmfGWQlUTAYA==
X-Received: by 2002:a5d:5512:0:b0:1ef:5f08:29fb with SMTP id b18-20020a5d5512000000b001ef5f0829fbmr10682390wrv.653.1647091762092;
        Sat, 12 Mar 2022 05:29:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwL9N8cHHsfR6QUZ51LIW64l7WzEaKnb3KtvzXdONbhu6n0rj400RLdEGB8nEbZlW8twybECA==
X-Received: by 2002:a5d:5512:0:b0:1ef:5f08:29fb with SMTP id b18-20020a5d5512000000b001ef5f0829fbmr10682372wrv.653.1647091761844;
        Sat, 12 Mar 2022 05:29:21 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:21 -0800 (PST)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 05/11] PCI: Use driver_set_override() instead of open-coding
Date:   Sat, 12 Mar 2022 14:28:50 +0100
Message-Id: <20220312132856.65163-6-krzysztof.kozlowski@canonical.com>
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c | 28 ++++------------------------
 include/linux/pci.h     |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 602f0fb0b007..5c42965c32c2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -567,31 +567,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
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
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60d423d8f0c4..415491fb85f4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -516,7 +516,11 @@ struct pci_dev {
 	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
-	char		*driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char	*driver_override;
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
 
-- 
2.32.0

