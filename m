Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D1C4DB43E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 16:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356957AbiCPPKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 11:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357016AbiCPPKW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 11:10:22 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D305673DB
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 08:09:07 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C95A23F603
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443345;
        bh=yPtLMahnwKOtCcXgH/ktoILLnjecC9LZzwZsY57u2dU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=E6JurAgOcU8o4z3jUmp6SeRj0WMYrsthL41tAVw52Q4Pzj5J116Y2VBZxZx7jAPGS
         nm4zStgm/0Q4hi/bweJtb+l8fpJNW2/YHSIA+xO9Y/pQrUwJ0B1nmtXm9nOgL+bsoG
         svtsUPBfhxXUfQ4w85geyCYoPk+LI/BJZU55q+SxQZ2cEHG1oEqZLgNG24PAuICJ0q
         Q9mHDCdyqdk+SLFC1IEzbXY7O5SEIrN2cZLg+z3n444NXRtQbb3GPndAG5IpKMGze3
         yn+UTarFTQ5K8eI7EwqjfPyMHUTah/IfdKS3AcFZo9JvO9MF6Xrvq411dHQopL7zLN
         AqHCdaLnMORQg==
Received: by mail-wr1-f69.google.com with SMTP id 8-20020adf8108000000b00203d97ba415so672240wrm.5
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 08:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPtLMahnwKOtCcXgH/ktoILLnjecC9LZzwZsY57u2dU=;
        b=RmY5vxbjKtk+02to0YNfpYgzIB1JrlBlIUCma/L6hUEGj0mcx4L/F7wOsw6ZzDqkFM
         Sq15wF6dsN9klwE1G1RR74cW9KekcC9nTTdhd16syZRToXOhwLIJL0f50df+icV9ghN8
         Zec/AOaMlYrTE7R1As8fQ4MSXhVSelUJiNoml2YfTLCuHxzvM5Fr+DT6q2F32rV6016F
         KEQowEWwFcQBkDjlNrKR8wnNuOeyrtE6T1V+qHE8XrJFk3iT/5JEme1iSclkoO4JorKu
         ICSejsXYVXufguc6gR5jJO8YA8V1l74dAx2Y9VTQIA2jmDvbop4rN8MPEeoXP/SBZu3l
         iOkw==
X-Gm-Message-State: AOAM531VZX+j+3wYNPDNXJdWhSBLCW3TqlnBcVA4qPDgBlMmCqtF/VdW
        7BHZFaWMjXXo6LcIrle/KZrxFKI1eGgdKvYjd3dhrf7tOvsF4bd0aQAmimsnGZdU0Xg2UwPonR5
        Y3TQombgKRWLrALlmpfnOH6No4ef1husyovAZEg==
X-Received: by 2002:a05:600c:1e1e:b0:38b:b31f:7fc with SMTP id ay30-20020a05600c1e1e00b0038bb31f07fcmr6700391wmb.191.1647443335038;
        Wed, 16 Mar 2022 08:08:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLttuQcgADlzoGu5HiDZ52KZb2YEjo0lDq9KqKlAOh9CGx+bAznJO89SsLTaClQchjThu5dg==
X-Received: by 2002:a05:600c:1e1e:b0:38b:b31f:7fc with SMTP id ay30-20020a05600c1e1e00b0038bb31f07fcmr6700371wmb.191.1647443334858;
        Wed, 16 Mar 2022 08:08:54 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b001f04e9f215fsm1895105wrm.53.2022.03.16.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:08:53 -0700 (PDT)
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
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 07/11] spi: Use helper for safer setting of driver_override
Date:   Wed, 16 Mar 2022 16:07:59 +0100
Message-Id: <20220316150803.421897-1-krzysztof.kozlowski@canonical.com>
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

Use a helper to set driver_override to the reduce amount of duplicated
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 26 ++++----------------------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6937cf2d59e0..34f311224c47 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -71,29 +71,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	const char *end = memchr(buf, '\n', count);
-	const size_t len = end ? end - buf : count;
-	const char *driver_override, *old;
-
-	/* We need to keep extra room for a newline when displaying value */
-	if (len >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, len, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
+	int ret;
 
-	device_lock(dev);
-	old = spi->driver_override;
-	if (len) {
-		spi->driver_override = driver_override;
-	} else {
-		/* Empty string, disable driver override */
-		spi->driver_override = NULL;
-		kfree(driver_override);
-	}
-	device_unlock(dev);
-	kfree(old);
+	ret = driver_set_override(dev, &spi->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 5f8c063ddff4..f0177f9b6e13 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -138,6 +138,8 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	for driver coldplugging, and in uevents used for hotplugging
  * @driver_override: If the name of a driver is written to this attribute, then
  *	the device will bind to the named driver and only the named driver.
+ *	Do not set directly, because core frees it; use driver_set_override() to
+ *	set or clear it.
  * @cs_gpiod: gpio descriptor of the chipselect line (optional, NULL when
  *	not using a GPIO line)
  * @word_delay: delay to be inserted between consecutive
-- 
2.32.0

