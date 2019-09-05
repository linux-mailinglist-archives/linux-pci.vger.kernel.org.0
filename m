Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A21AA8A8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfIEQT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 12:19:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42004 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbfIEQSF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 12:18:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so2062704pfi.9
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2019 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8hOfhOr51aqScCCWWbh9I9oRm+jyZZGT7N1Ouypdt4=;
        b=Kf9BCxH5tyFR8Sxb6davF0tw/g0BJcQ2LTgqYDRkCXe99lige8xFTOyajGrEfuPQ/R
         I0jfW+xyceHiuUmlk5yy9H/wHaQBHzqM6/NCd+6TYi2hTFJcP+V9Qy+4KG7IN1UQJXhm
         SHxD8duKsNPol28y9SdpztaPVTFslQB1ZJ4shENKHGBsNtllukJz/Fvv4h2tEY0T/gDA
         A2nAqicaFTIrh+VxqbojFsyy6M/2eC5AmJiZLPVyY+LXna6RGps4ro7SxWrWHOr8M3f3
         r5tzdOU8n4cY0b4Asgrm+yIMVuJn8WX1xgQ9ScuHQJtGCR5wLKwPCsSipBa/U9NOB1IX
         2SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8hOfhOr51aqScCCWWbh9I9oRm+jyZZGT7N1Ouypdt4=;
        b=XmZfAEHYXMluF7fzl5ZyMxlE1QIwZKN5oKGRV6jS+gKIs8IxR2K7O5Tf59DpJ5iben
         Rl7EBRdaCnRoFuMAOLwLToD7WvIgKmPHJ35gBY02KvPfXzBDV3JSZmZhLAffWYYp3gDq
         DwJ7sZ8Jw4tnCdm29Gd5GUaHkmtN8C0/K0DH/hcJU0B0mVK1L1lSPd5UC1D5DEqKtKNC
         SkJxjLUMTqKvuoscXv+Q48Cru3fR3mY8r5SjgFUzbryrWOmsx4ZyINvC6KFC00KcgA7P
         oq/PhXj3asj5KW1SU0EKZRe0dvFUAEHHQSXAVGvfrMgd/he+H8TkoeQGkbMbzpkL3Q1N
         IvOQ==
X-Gm-Message-State: APjAAAUOY4oGK3v6oVovxIYARu1JoOn1qtjDTEzRmsn1wKblpLB58tpd
        R5yvQ1JxP5PV6L8GtiunPXAvjw==
X-Google-Smtp-Source: APXvYqzPIZoynm5wH2XSzFsQu6YuhHmdV6ACJ/jbefAUC4vneQ0qioQJzoA1wj/k15d4/pVhs+puhw==
X-Received: by 2002:a63:df06:: with SMTP id u6mr3817337pgg.96.1567700284680;
        Thu, 05 Sep 2019 09:18:04 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m129sm6324005pga.39.2019.09.05.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 09:18:04 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [BACKPORT 4.14.y 03/18] drm/omap: panel-dsi-cm: fix driver
Date:   Thu,  5 Sep 2019 10:17:44 -0600
Message-Id: <20190905161759.28036-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905161759.28036-1-mathieu.poirier@linaro.org>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

commit e128310ddd379b0fdd21dc41d176c3b3505a0832 upstream

This adds support for get_timings() and check_timings()
to get the driver working and properly initializes the
timing information from DT.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../gpu/drm/omapdrm/displays/panel-dsi-cm.c   | 56 +++++++++++++++++--
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 92c556ac22c7..905b71719d65 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -25,6 +25,7 @@
 #include <linux/of_gpio.h>
 
 #include <video/mipi_display.h>
+#include <video/of_display_timing.h>
 
 #include "../dss/omapdss.h"
 
@@ -1099,6 +1100,36 @@ static void dsicm_ulps_work(struct work_struct *work)
 	mutex_unlock(&ddata->lock);
 }
 
+static void dsicm_get_timings(struct omap_dss_device *dssdev,
+			      struct videomode *vm)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+
+	*vm = ddata->vm;
+}
+
+static int dsicm_check_timings(struct omap_dss_device *dssdev,
+			       struct videomode *vm)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	int ret = 0;
+
+	if (vm->hactive != ddata->vm.hactive)
+		ret = -EINVAL;
+
+	if (vm->vactive != ddata->vm.vactive)
+		ret = -EINVAL;
+
+	if (ret) {
+		dev_warn(dssdev->dev, "wrong resolution: %d x %d",
+			 vm->hactive, vm->vactive);
+		dev_warn(dssdev->dev, "panel resolution: %d x %d",
+			 ddata->vm.hactive, ddata->vm.vactive);
+	}
+
+	return ret;
+}
+
 static struct omap_dss_driver dsicm_ops = {
 	.connect	= dsicm_connect,
 	.disconnect	= dsicm_disconnect,
@@ -1109,6 +1140,9 @@ static struct omap_dss_driver dsicm_ops = {
 	.update		= dsicm_update,
 	.sync		= dsicm_sync,
 
+	.get_timings	= dsicm_get_timings,
+	.check_timings	= dsicm_check_timings,
+
 	.enable_te	= dsicm_enable_te,
 	.get_te		= dsicm_get_te,
 
@@ -1120,7 +1154,8 @@ static int dsicm_probe_of(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
 	struct omap_dss_device *in;
-	int gpio;
+	struct display_timing timing;
+	int gpio, err;
 
 	gpio = of_get_named_gpio(node, "reset-gpios", 0);
 	if (!gpio_is_valid(gpio)) {
@@ -1137,6 +1172,17 @@ static int dsicm_probe_of(struct platform_device *pdev)
 		return gpio;
 	}
 
+	err = of_get_display_timing(node, "panel-timing", &timing);
+	if (!err) {
+		videomode_from_timing(&timing, &ddata->vm);
+		if (!ddata->vm.pixelclock)
+			ddata->vm.pixelclock =
+				ddata->vm.hactive * ddata->vm.vactive * 60;
+	} else {
+		dev_warn(&pdev->dev,
+			 "failed to get video timing, using defaults\n");
+	}
+
 	in = omapdss_of_find_source_for_first_ep(node);
 	if (IS_ERR(in)) {
 		dev_err(&pdev->dev, "failed to find video source\n");
@@ -1171,14 +1217,14 @@ static int dsicm_probe(struct platform_device *pdev)
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
-	r = dsicm_probe_of(pdev);
-	if (r)
-		return r;
-
 	ddata->vm.hactive = 864;
 	ddata->vm.vactive = 480;
 	ddata->vm.pixelclock = 864 * 480 * 60;
 
+	r = dsicm_probe_of(pdev);
+	if (r)
+		return r;
+
 	dssdev = &ddata->dssdev;
 	dssdev->dev = dev;
 	dssdev->driver = &dsicm_ops;
-- 
2.17.1

