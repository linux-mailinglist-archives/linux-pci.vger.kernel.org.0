Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54AAA891
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 18:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfIEQTe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 12:19:34 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:44460 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388047AbfIEQSK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 12:18:10 -0400
Received: by mail-pg1-f177.google.com with SMTP id i18so1664720pgl.11
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2019 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ld8MsvJyHX4xiXhT/vACY8V+T9SsrvyxVWLxkWmOHw=;
        b=XT3Az7zzBbgbLvMexBlhl28H1zweak4MTFSDW4Z2X3Ha/QND0Bs7fu1GlJQslffzeB
         LWlUlyWIAmzVk/+mUyPdD+4nZwAO9nk1ji12txKMyNEST223rFfRlFB6AeFPMZvq7wy/
         tXFpIGd7WBH3k/q538r3XaFEMh0s3bPPDl3wPolk9LypaKTfGB6UzVKsLLeAS07gj1rn
         fdweJBOKtEZq8Zmfgu1NcESYEF48FPKrzvVBBc5+gyUyrbJ//dUWwgy6OH85myV+ToOC
         HgL1kn+e4YWS/JFJ4yB6alQ12JjDhFV87for4spwtn7BdUdPfyqfJYpWsYs/lzpIIiIM
         3BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ld8MsvJyHX4xiXhT/vACY8V+T9SsrvyxVWLxkWmOHw=;
        b=BGZswEJWMJhBbbiPmaVrvSdAGA8VUY1gD8pjH09CN2B7AqmNebfG6HJXTvGNoSCpyV
         9Hx1kLPyy2hZunr0IhW2dp8SqOvSMDWCvE/qLwvvsHJi2PSWRkN0LqOz+o4w2B84CtCR
         n+At15ccV7YSu3OwbopB1WOSaZIfnUFUsbh1EBbUlWtpCcPhslnj6/j0UrcmLM6oeAqJ
         8yMGiN4HnRq1Wfl7dIS0CBerGBIs9CzC5sQIm9SufSdwV7rYQKGOLpTW0GyozZo61hjR
         dWTE+LjoXgLpNy49PIAo5suTD+GBBIWtRorFWwI4CSPH3ZfPq1PhvqJXN2LsA+uDh3TV
         +NXQ==
X-Gm-Message-State: APjAAAXHHdOwzMvbvdGrJz+i/9LXFSiBKoSUyg3dkdGOtyJ+hZoDH6kL
        xNYqlcY7fGmjBbQnCNChpjJH5Q==
X-Google-Smtp-Source: APXvYqwbHY2l3Y3RI4VI6wb4Zy7sVNDjcmdxm+p9Gx0FC6W1QaFVP9fXezb7/YJ8ZduZPS1+K7YUJg==
X-Received: by 2002:a63:2364:: with SMTP id u36mr3780682pgm.449.1567700289680;
        Thu, 05 Sep 2019 09:18:09 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m129sm6324005pga.39.2019.09.05.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 09:18:09 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [BACKPORT 4.14.y 07/18] mtd: spi-nor: enable 4B opcodes for mx66l51235l
Date:   Thu,  5 Sep 2019 10:17:48 -0600
Message-Id: <20190905161759.28036-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905161759.28036-1-mathieu.poirier@linaro.org>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Roman Yeryomin <leroi.lists@gmail.com>

commit d342b6a973af459f6104cad6effc8efc71a0558d upstream

Signed-off-by: Roman Yeryomin <roman@advem.lv>
Signed-off-by: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 34ecc12ee3d9..6c013341ef09 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1030,7 +1030,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "mx25l25635e", INFO(0xc22019, 0, 64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "mx25u25635f", INFO(0xc22539, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_4B_OPCODES) },
 	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
-	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
-- 
2.17.1

