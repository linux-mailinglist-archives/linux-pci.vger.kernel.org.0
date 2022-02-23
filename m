Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17424C1B8F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 20:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbiBWTO3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 14:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244180AbiBWTO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 14:14:27 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2813F8BC
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:13:59 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 416013FCAE
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643628;
        bh=7G3yQO1ggdyvs1MDXGTTghLlHGfX3RftlATUX++IZLE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=R9QPNmTgqpJQkzBnZcufPsqKiHSK6RpPxVG70CC2MXSEzrMx/RUn55X8bTWq+fUo1
         /9tAoxuGS98iKMjxEZyxeQoGSpVPFXKZjOFI3EiHLjkDbfHUx/1+7u0W98+CPvHZt8
         J3DivFq91XKtziYwIXQtMix8IeaWLzqaA+1dioFy1mvlHR4M07QcxuZTtK8mzDswPK
         1o7d4EYZ3xxs/2XCSP9nvkBKBMa4b2vLXHPKlqhQx3ICwrNnE/7v4Np1l1UsaO/bz1
         h4im8BaUKR2DENCCGIcNHmiTg+EaBOULnDsMvKZ0jmKQzabdkMK7NMnHv3R9qOCquD
         sJepQs5NiVfwQ==
Received: by mail-ej1-f71.google.com with SMTP id m4-20020a170906160400b006be3f85906eso7479749ejd.23
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7G3yQO1ggdyvs1MDXGTTghLlHGfX3RftlATUX++IZLE=;
        b=EipK6l18I8M2s0RKcthZEfzN7spv1yiy0Ww0SkqOr5Lzkf7EZ6iog6Ln/948/noTEw
         eDXaohfPtv8qjSGdGBtSd1aPHaIdo1oLVXSltEJ7Iz8oy0hPgSQpX5aKicedJ5KA4R5F
         NRoaJffSgSzlk0xC1jNz/OahnzI13s7d2ctAKl86qtKoe9pBvrLNPak+d3bpw7JmXc00
         U7NMs5XFoGSUh+6tn5zOoRg3ajBU6wUvrpmOCjhga+aE7H4MVWNxz6KVtH3JaoyCt/GR
         CShZSF2rri+GhIFA+ZXj6fz4Z9a8L5TfASEej6N3fHpcsmJV7S3temWj+TH9Cn4uwD1G
         +Stg==
X-Gm-Message-State: AOAM530jS+oBshCEzyKv258jahoqx83QeJJC79NG63pTQKHwj0OTwRpL
        k4hobvdjhsXH/o51ZTqiRUhSOxdIhxK2iRWtz1dN4VnsxBODmKjSCQ5drBuC/Mrty7lYNTu9Y0E
        Byrbk3rTt9kh5PCzFs6jfRPR67JEYP6kZwvvZvw==
X-Received: by 2002:a17:907:3e1d:b0:6d1:cb2e:a5f7 with SMTP id hp29-20020a1709073e1d00b006d1cb2ea5f7mr912416ejc.34.1645643627835;
        Wed, 23 Feb 2022 11:13:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGBRIhr5hXOOi9m1HuHlbXHVVNJ7NbK5fFuNrM/4KQXFCcM1cXqPM7bQRPgfLpUUwT4AX8Nw==
X-Received: by 2002:a17:907:3e1d:b0:6d1:cb2e:a5f7 with SMTP id hp29-20020a1709073e1d00b006d1cb2ea5f7mr912389ejc.34.1645643627533;
        Wed, 23 Feb 2022 11:13:47 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q5sm212611ejc.115.2022.02.23.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:47 -0800 (PST)
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
Subject: [PATCH v2 00/11] Fix broken usage of driver_override (and kfree of static memory)
Date:   Wed, 23 Feb 2022 20:12:59 +0100
Message-Id: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
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

Hi,

This is a continuation of my old patchset from 2019. [1]
Back then, few drivers set driver_override wrong. I fixed Exynos
in a different way after discussions. QCOM NGD was not fixed
and a new user appeared - IMX SCU.

It seems "char *" in driver_override looks too consty, so we
tend to make a mistake of storing there string literals.

Changes of latest since v1 (not the old 2019 solution):
=======================================================
https://lore.kernel.org/all/708eabb1-7b35-d525-d4c3-451d4a3de84f@rasmusvillemoes.dk/
1. Add helper for setting driver_override.
2. Use the helper.

Dependencies (and stable):
==========================
1. All patches, including last three fixes, depend on first patch
   introducing the helper.
2. The last three commits - fixes - are probably not backportable
   directly, because of this dependency. I don't know how to express
   it here, since stable-kernel-rules.rst mentions only commits as
   possible dependencies.

[1] https://lore.kernel.org/all/1550484960-2392-3-git-send-email-krzk@kernel.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (11):
  driver: platform: add and use helper for safer setting of
    driver_override
  amba: use helper for safer setting of driver_override
  fsl-mc: use helper for safer setting of driver_override
  hv: vmbus: use helper for safer setting of driver_override
  pci: use helper for safer setting of driver_override
  s390: cio: use helper for safer setting of driver_override
  spi: use helper for safer setting of driver_override
  vdpa: use helper for safer setting of driver_override
  clk: imx: scu: fix kfree() of static memory on setting driver_override
  slimbus: qcom-ngd: fix kfree() of static memory on setting
    driver_override
  rpmsg: fix kfree() of static memory on setting driver_override

 drivers/amba/bus.c              | 24 +++---------------
 drivers/base/driver.c           | 44 +++++++++++++++++++++++++++++++++
 drivers/base/platform.c         | 24 +++---------------
 drivers/bus/fsl-mc/fsl-mc-bus.c | 22 +++--------------
 drivers/clk/imx/clk-scu.c       |  7 +++++-
 drivers/hv/vmbus_drv.c          | 24 +++---------------
 drivers/pci/pci-sysfs.c         | 24 +++---------------
 drivers/rpmsg/rpmsg_internal.h  | 13 ++++++++--
 drivers/rpmsg/rpmsg_ns.c        | 14 +++++++++--
 drivers/s390/cio/css.c          | 24 +++---------------
 drivers/slimbus/qcom-ngd-ctrl.c | 12 ++++++++-
 drivers/spi/spi.c               | 20 +++------------
 drivers/vdpa/vdpa.c             | 25 +++----------------
 include/linux/device/driver.h   |  1 +
 include/linux/platform_device.h |  6 ++++-
 include/linux/spi/spi.h         |  2 +-
 16 files changed, 123 insertions(+), 163 deletions(-)

-- 
2.32.0

