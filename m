Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5629E4C1BF3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 20:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiBWTQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 14:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244319AbiBWTQZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 14:16:25 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF04161F
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:15:55 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 555234099C
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 19:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643749;
        bh=oRXS+YkCrSg6HXmKQBekF6bqmCpfytEa7gv0higjFpc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YMJOTpWLQottgvpeky2LUTcHMrKn/HEqsgcLPV/czmSsXghZT+62PVGYmFLpp1Aok
         eIyuVUF5bjtpbZljxtSFcUMLXkQSFQAxgE9RR9Dyo/VhvKMX6dPt108/n8cyFsBV09
         3EPDRWtYwj9X9E9DvSVzxf9pbtMktAMyordpx4kdCh7hHomBaIrbPPI0lJrIdhWDyk
         pQ1o4NyMxDNgPpxW3TnQPu7HEX/qktINnbi7pTG5avk4zTS9zJQnSGbHnSfaMyW4sD
         As42QQeBDQCZfHrHSh1muACVuP0F+QBxPHGwRVyqNuVs7ydob7jd1gTxJm/Nu8ZUaF
         sLX2Rm49RkonQ==
Received: by mail-ej1-f70.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo7441044ejc.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRXS+YkCrSg6HXmKQBekF6bqmCpfytEa7gv0higjFpc=;
        b=feHuetI1T6mnwgz0iu9CU2gRC6wLvWXCqbdR7fbspes6PW/9GlNBC07+9+2ek7ozyI
         JoyGHqJf8HZR+IONDgI0D0u5W/PBm+Rl7yc1XbM9yl1eTVB5e/8bVTcfGVfedG+M6Jhd
         y9qaHb3rBR+hcmj8osQGDuIRDiLhR0a0VVon8C7iSfBU8kIVWp+KuUalZtzsQ1xQoHdJ
         nABI2h9B/WcIhKr+5+8RC0mP82So3C4dNqQfOPRJv9sTNgjWPlsopbeB8TpMW6IvS871
         ICDfTcFXJlp7t268gIwrRQP+qHEHw/llHGeoG8XWiHK8bNbDEcR+VlfDd9yfwFG3769X
         rTXQ==
X-Gm-Message-State: AOAM531RfS45UhVbPXcZ8dcqeyZm/+5RJoZeWVLbIxfT0yyXgdwj65kb
        hz39eRxHmbv+hPRM+CNJ2EayjHOSL1arX4HVBvNLfTqEJbzH2K07h+7kS/J1VZxZPH/C2HcqICL
        PgqdSzqtBlkwJAsS94ATjYxczeXHI0OLP3wBOGA==
X-Received: by 2002:a05:6402:3487:b0:40f:fa53:956c with SMTP id v7-20020a056402348700b0040ffa53956cmr894429edc.22.1645643729012;
        Wed, 23 Feb 2022 11:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5CjazTLBKPiBmuMFKmO+Lmp6CQ3NgkMty7AAh8YmijE7P+oo2dQqmhFhNHN6v7AVbA25vYw==
X-Received: by 2002:a05:6402:3487:b0:40f:fa53:956c with SMTP id v7-20020a056402348700b0040ffa53956cmr894395edc.22.1645643728802;
        Wed, 23 Feb 2022 11:15:28 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:28 -0800 (PST)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 10/11] slimbus: qcom-ngd: fix kfree() of static memory on setting driver_override
Date:   Wed, 23 Feb 2022 20:14:40 +0100
Message-Id: <20220223191441.348109-4-krzysztof.kozlowski@canonical.com>
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

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 7040293c2ee8..e1a8de4d41fb 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1434,6 +1434,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	const struct of_device_id *match;
 	struct device_node *node;
 	u32 id;
+	int ret;
 
 	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
 	data = match->data;
@@ -1455,7 +1456,16 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		}
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
-		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
+
+		ret = driver_set_override(&ngd->pdev->dev,
+					  &ngd->pdev->driver_override,
+					  QCOM_SLIM_NGD_DRV_NAME);
+		if (ret) {
+			platform_device_put(ngd->pdev);
+			kfree(ngd);
+			of_node_put(node);
+			return ret;
+		}
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
 
-- 
2.32.0

