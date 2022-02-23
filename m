Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3D4C1BA4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 20:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbiBWTOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 14:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244227AbiBWTOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 14:14:47 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E086D4131C
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:14:07 -0800 (PST)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B87C3407CE
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 19:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643646;
        bh=fyZde4QL+5WSjtUcZmZyQ9LOCmYULjkOm0dq/nBIuzo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=AVfo1n4gcz5sP9eSVoxh14pYI1VX2wWnk4L7C/U/uZ5DBrFbr93K51NjBc0D3dyLh
         K7U8lLhV2vcy7jOWYSJTLyvkgEgcSMfacnuZFh5ViY3YMjdiEQdThUb8KFy3WgyasZ
         UthdQVK140ASKfr/E+P60quTHgNwvQjYNMFAFcd/Gqro3A2wqWJz7zEoNCN62X1p8a
         x6tMgiqdYN36KnPALVnlk2scPEehEStq1mZ2yUy/toJxAmnZVSaIsjCEae07FYYFPp
         azQSClC3UWWPkg1EvGy+fz+srUcH+GAFwoEbTtp4RXZ3e73i3zpaaz0Gn2xbemmk0J
         fKu64BCA0M1fQ==
Received: by mail-lf1-f71.google.com with SMTP id q25-20020a056512211900b004422b53ec42so329lfr.5
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyZde4QL+5WSjtUcZmZyQ9LOCmYULjkOm0dq/nBIuzo=;
        b=N9V4tzPCfJlw24DaFPrX3ms+CUME1K+2JgIxkSBb+cuA4g37f/7Pz9DfOB8PIX3bkw
         V59JTntmCyjH/V93Veq/os6UgVVIVQD0ecjdtL8xBrS2qDDtOlSpInYfHx5SGoYAz7Rt
         2lhrqsJE5FKIjUIVkOFtqn1sgFDyfgdpbx1mlpLQkw+scOCi1EZRhC30zjXWCG6dng17
         hBFvtcqaeAoe05tC4Xzuuw4Vu53GUmXnq2P95Ocb6wSlH+bbTef0+3MYXjw5F421ipEo
         95dCUHPKrdraMJ+MJK8Rss8K8vEBcARhTe6Ju7kvXGuPPXvCbTtO+mM9Y1t8YWJ7q8qz
         Ssqg==
X-Gm-Message-State: AOAM5322mkQ0MYNy5/XZt8qrueGm4z7HKXiYYTUQdu3tNrSjKZO7dvDh
        5boOLV/EFcl3kdWpSQipcJED2Du0tu2e74BMylnKkD78fzUNlYivyqUq0TR+JWe7/XclLcy0Km1
        9SlKi2Q8GAJNYsGLPGLtFzmy4sQQwnHJAgX8cFw==
X-Received: by 2002:a17:906:a384:b0:6ce:c3f4:c59a with SMTP id k4-20020a170906a38400b006cec3f4c59amr870070ejz.580.1645643635869;
        Wed, 23 Feb 2022 11:13:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQC18HONgcYdOr4fLdW/4QMQU7ra3n8dm0IepMHQhTlzr1OkJDjXXGMuSAKvUFTDXd0c3row==
X-Received: by 2002:a17:906:a384:b0:6ce:c3f4:c59a with SMTP id k4-20020a170906a38400b006cec3f4c59amr870048ejz.580.1645643635630;
        Wed, 23 Feb 2022 11:13:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q5sm212611ejc.115.2022.02.23.11.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:54 -0800 (PST)
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
Subject: [PATCH v2 03/11] fsl-mc: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:13:02 +0100
Message-Id: <20220223191310.347669-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 drivers/bus/fsl-mc/fsl-mc-bus.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..d93f4f680f82 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -166,8 +166,7 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
-	char *driver_override, *old = mc_dev->driver_override;
-	char *cp;
+	int ret;
 
 	if (WARN_ON(dev->bus != &fsl_mc_bus_type))
 		return -EINVAL;
@@ -175,22 +174,9 @@ static ssize_t driver_override_store(struct device *dev,
 	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
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
+	ret = driver_set_override(dev, &mc_dev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

