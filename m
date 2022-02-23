Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92824C1BCB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 20:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiBWTP7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 14:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiBWTP6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 14:15:58 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F3403C2
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:15:30 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9C9F540812
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643727;
        bh=H2keAgAmU9ZqqGFkafNbZlkvfevlWycDJlQlht8xanA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=AF9ts47nu/KhofkG8rPZ1YuCPSGC1Sq6rcWghVxg5/oyUv9Qh4jWfW3nkIYvyWKkN
         R3OjpM+fxUh7JOi3NrLE6kefH5S+GAX9xd1o8oXGVe0t8IwyEedpguE/5J3LApT42J
         fmto43y+r6abksqrcB2pF7VoAFLpgq7hbltUSnBPSkRTjtrpGiEEb6lWA7U5TGulqv
         oBhD3O+CQhkRJkATgzt4Yh1u039PsfWSkTjDH22LretlXQPtFfjXQyfnokrU+3aReY
         El77HS7AV0A5gF8fHuiHPtpny9WX3HMKYYShNEN1mpb/J2mPszeq59krN/PtcHgUd2
         LlF1qf0AFcGWQ==
Received: by mail-ej1-f70.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo7440777ejc.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2keAgAmU9ZqqGFkafNbZlkvfevlWycDJlQlht8xanA=;
        b=gOn6LfbjlrBA+aRfGeLpi+ar0JLIZam6idJaBt4V+TjrnK7JmmfpFCxnO67BUNhMLX
         HOkRFTZJjjIwpvVmPxJPJPDSgmKR36cXNySKPpJrltwA0moMfqOThK6oHlLdiod1yyL/
         ZUky8WLQKoAu8FSevTzkjYl8PJy3xw2st6aEOmCQr9VXaZ5ddLLSEr3Zm0QzorgdEJmZ
         oS155OiU/eBDZGzKA8Q4mwDsHRDBHUiWXfGSl2pAhamKwbUCANkySIQNFCNpd6Hpedt7
         9FzfEx+i44fFM4UJe+WvJ8ffJZJLcE4PxpQVy91dwUuqJawn6BDqg01YsfSKALiU+GmS
         oh3w==
X-Gm-Message-State: AOAM533kAyobdVZuhQxCIPsp1R+H4o8oCWXfwk0o8Gm90NHLTpqdtJvt
        9vGNG8zChZR7LDXinPxaHKfBkwyYKnSrNz4Y4OvLeW+Y0yN/uWv5G1otktTce8DSG/VH/e2aZGi
        Dtd6Unup+Vb3f3qYFw/XPSyqa1Xnj2cJVJij2XQ==
X-Received: by 2002:a17:906:684a:b0:6ce:c1b4:b503 with SMTP id a10-20020a170906684a00b006cec1b4b503mr894511ejs.355.1645643725345;
        Wed, 23 Feb 2022 11:15:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpQByhmcToLCr1i/g+5dfeJyrnQroTWuW6ciExOrKYOzQiErT2Fu468xjrk+1eigQXSikm5Q==
X-Received: by 2002:a17:906:684a:b0:6ce:c1b4:b503 with SMTP id a10-20020a170906684a00b006cec1b4b503mr894476ejs.355.1645643725160;
        Wed, 23 Feb 2022 11:15:25 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:24 -0800 (PST)
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
Subject: [PATCH v2 08/11] vdpa: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:14:38 +0100
Message-Id: <20220223191441.348109-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/vdpa/vdpa.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9846c9de4bfa..76ce2dcae7cb 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -77,32 +77,15 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	const char *driver_override, *old;
-	char *cp;
+	int ret;
 
 	/* We need to keep extra room for a newline */
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
+	ret = driver_set_override(dev, &vdev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

