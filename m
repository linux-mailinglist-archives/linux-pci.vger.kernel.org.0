Return-Path: <linux-pci+bounces-13821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0794C990364
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9943FB22752
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721720FAA1;
	Fri,  4 Oct 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oLcUbZTl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F520FA99
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046707; cv=none; b=nTfdYmh5cfkCBksINf3jk+kOX4XKiT26uJMCD8rR0/CE7m4FD2sNnb3Gf1c7JDySbJvFjQI0OfhEtUSlVYJsbIU3IOAH2Y0WYFxvXFGiiNRsDSN9TCCIv4/ZZOxCwpwM9PAjR47yci5Tq+Sru85BypHKkdsVCtDm4EnictMdWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046707; c=relaxed/simple;
	bh=81lZz6tvQXAZ8py6IHRzmNqwYHG/0FHSLJkeNNpuEjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuOZMwETkXYtTMTPatzbF4KuiObn9D1qqpcEOEZIUzESUN569zDoEf9SPsSAyAifDY2q1tKXczuPmBYHy6JTq0U85TCU04HX4cQ0KmcTc78cRmtdpq+xycQbrU/9EUq7znwRRK34BDP8Q8gHG72tNMKtRiwNM7EiSWMlifk2Rjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oLcUbZTl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so1553928f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2024 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728046704; x=1728651504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wq33e40qq5B5EGnE1SLGXv5afGtNdJFNQ/iJq5Jz7zc=;
        b=oLcUbZTlb3HhIavsJXgSmHAE091Gi7EQio7jc/C7NN6dUKtINImO1+sIZeIxCdBVqc
         voW/9gIovd/Bx0tdlpf5FFkRP7ZZcDegtlCU7f1LcJHQ1zsquin8EoSVnxr9HyJvkALJ
         NfIrqNWOmDcK9Yvb2csBRCqfF0jrzh8j6K4yg4wsIUs3NX5dkc8kxRBzqu1RUCz2yx6H
         No+/wq3IfwG/mAKYE7U6FYvLQ75SpLwjYIGZdMviafaBPPS+G4v0RKI8+3CbHae0Q3u3
         Zplzss3F9aO0RC1+CpNMrXXgKfwXrkzxiKWYLeTG9NozFzenp3EGl9Kf1Cez9yu9JCSP
         SkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728046704; x=1728651504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq33e40qq5B5EGnE1SLGXv5afGtNdJFNQ/iJq5Jz7zc=;
        b=V0jk0sTl6WMRqGZGpbSSUe0lPafEtbDNd7zb0ngeWAc+3rZMF0Dq5U+4tjSwIftlqo
         KjbDEfWVIOa+QD5eZtFU3tOS6Ow3kAD/FL2Lk5HQ1sKZVOSJZq0rv+JjkY0yIHXO5VoS
         fd3TcyBd4dxDs4jIPSeTXls6vt/G7u1fdp19U0gwdZCAna9LApn0Ty/2y08j8OEXZpA5
         MsNLu+GiQNNvGkW6YmBOm7W2Pc5tFO147zCPk7tQ36/4o4VmSMlOUvDQCCc4sWAA/jQv
         4l/HFdebFMw53ztyKuARW5oWy98PoiLu6SWpRB1nIdfMDGanAs9ljsPBYqqsCVvEzAy+
         MtXA==
X-Gm-Message-State: AOJu0YyorE/VYq2B6PkzPBW+Ph8VSeb2mZ1FQYRZeKEjHpKirqCEdwct
	Nn74SeGLnL7b2NTroUTo/EnsX06vsytgkSCNZRYSOdqb2V69fLaLsZsRYY75b28+E7Ka8IS/+F2
	3
X-Google-Smtp-Source: AGHT+IFtD2pF+3S+hWKaj35gJuRRUik/oqclbdt4ZgQcGB8oQY5sk3Cx9/zxl70fxbiUrrsytYJcsw==
X-Received: by 2002:adf:8b5c:0:b0:374:c142:80e7 with SMTP id ffacd0b85a97d-37d0e6bba99mr1881280f8f.1.1728046703929;
        Fri, 04 Oct 2024 05:58:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:80ea:d045:eb77:2d3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d20bcsm3197815f8f.100.2024.10.04.05.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:58:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] PCI/pwrctl: pwrseq: don't use OF-specific routines
Date: Fri,  4 Oct 2024 14:58:21 +0200
Message-ID: <20241004125821.47525-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver doesn't need to use OF interfaces directly. Replace the
single usage of an of_ function and replace it with a generic device
property variant. Drop the of.h header and pull in property.h instead.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bjorn: This may conflict with [1] but this should go for v6.13 while [1]
is a fix that's targetting v6.12. If git doesn't figure it out then the
resolution is trivial, just add <linux/property.h> in both and drop
<linux/of.h>.

[1] https://lore.kernel.org/linux-pci/20241004125227.46514-1-brgl@bgdev.pl/

 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
index a23a4312574b..d3f960612cf3 100644
--- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -6,9 +6,9 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pci-pwrctl.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwrseq/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -35,7 +35,7 @@ static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
+	data->pwrseq = devm_pwrseq_get(dev, device_get_match_data(dev));
 	if (IS_ERR(data->pwrseq))
 		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
 				     "Failed to get the power sequencer\n");
-- 
2.43.0


