Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA195ADD31
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 04:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiIFCP3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIFCP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 22:15:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C6F40E10;
        Mon,  5 Sep 2022 19:15:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 145so9985389pfw.4;
        Mon, 05 Sep 2022 19:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=C9UwLm1DYBumnQhb+UjocjdgHmiXC2aRgzJr3+8Kerw=;
        b=i3rfiuKw6JULWz7xyYKov+awXpPNftyMMsivqL8Jp4hdwm7p0gIzE+NRnsqV1f8RZv
         KiTcN0/EyY8pcDogrXBkEGiXlqafR/jgamQ3FlTKrHURBgKKlt942d90JYPrpmxvOAKt
         fxlXpt6d9hiqunak5njz0pFGQunmK+bLrPaU84NljKupXaSf4Zhm6IMHPU0comDRH1Z+
         TCV28tSgZZTkhYpjssaZdrQo1x9K+x4mc+wptEnXV6G9EgmMlM4TaZL8lQuPDj3FCGjC
         p9CxsugmbOGNp1gOgz2F3w8/BeM+sQpdfQKKehYzJC0lYizZmjO4UEnsNh1MqtC/sGlg
         gwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C9UwLm1DYBumnQhb+UjocjdgHmiXC2aRgzJr3+8Kerw=;
        b=7/yhHPCeX1TIuSaYFH9wkCemF5HLRB9tka0Ey4JsHknswziWpTJ/tFAKjKUXWPZ10p
         oP2AZZpeB8yL9jdJ9T2vrs8wDx1tPKKuPXDiDqdLDJW8R4BkDhiaIyZheOST65x6AQYy
         vHuUV6Cflsi8CdDRtaOJnUx8FBbjcn7Nqq4kQxxDHd7OHzb9Sd2o4rb3Pfr3d6y6Sq5V
         J1UBb4zzVRD3egbwNTyJU5qkBtzi0s3GntOoJrxrV8OzBORmhDPD0mU3/56OLpFAyMJu
         dLnub/nw9DExYuhtd715VX7+dpDL7qAH2VDbfyudlRl1WyCDrA55e5j3L4ic9lY0by4k
         7HWQ==
X-Gm-Message-State: ACgBeo2BxMKTgQmvBEYoC+Ntwzae0PKFtXfEpFbFroI3ts3Pqu1ivzd6
        FCQ7z1ISV2qoeLM/MYP2RcM=
X-Google-Smtp-Source: AA6agR5VnBhpmecaiXIyHAsX/1VxUCgsnPEfoC61ckOOpFJd01VF8Et0zHTd1xh5BDm7t0D5giLiOg==
X-Received: by 2002:a62:ed08:0:b0:537:17a6:57aa with SMTP id u8-20020a62ed08000000b0053717a657aamr53444529pfh.6.1662430526683;
        Mon, 05 Sep 2022 19:15:26 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id x29-20020aa7957d000000b00528bd940390sm8537108pfq.153.2022.09.05.19.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:15:26 -0700 (PDT)
Date:   Mon, 5 Sep 2022 19:15:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: apple: do not leak reset GPIO on unbind/unload/error
Message-ID: <YxatO5OaI2RpxQ2M@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver allocates reset GPIO in apple_pcie_setup_port() but neither
releases the resource, nor uses devm API to have it released
automatically.

Let's fix this by switching to devm API. While at it let's use generic
devm_fwnode_gpiod_get() instead of OF-specific gpiod_get_from_of_node()
- this will allow us top stop exporting the latter down the road.

Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This patch has been pulled out of the series
https://lore.kernel.org/all/20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com/
with updated justification (leak fix vs pure API deprecation).

 drivers/pci/controller/pcie-apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index a2c3c207a04b..66f37e403a09 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -516,8 +516,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	u32 stat, idx;
 	int ret, i;
 
-	reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
-				       GPIOD_OUT_LOW, "PERST#");
+	reset = devm_fwnode_gpiod_get(pcie->dev, of_fwnode_handle(np), "reset",
+				      GPIOD_OUT_LOW, "PERST#");
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
-- 
2.37.2.789.g6183377224-goog


-- 
Dmitry
