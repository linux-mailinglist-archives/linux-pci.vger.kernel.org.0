Return-Path: <linux-pci+bounces-13820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE0A990351
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 14:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDDD283E99
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A3155322;
	Fri,  4 Oct 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XBAFHk+s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1929422
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046362; cv=none; b=MvYl4UrHiEw9f0E2Nk6J7cxNo+Bx7yBonerK16bnSfP3CT3xMF0pgS65+0TSufc00EU0ZuiHmGYCqbi3Ma5IZkJ2saeMBE7OousXk7ZBTFblq7m2ov83YW4FGkmkyDgs9/xPB82s++oD1W/We8+U2HsRF/XjJWcHxGc37PO/aPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046362; c=relaxed/simple;
	bh=9PYW71iDSCM5kPIkNn6Mt8m5WS1qZgw9PcoQq9wIi/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIcS5l0AZyQ4oJktE3d2C3SAsVt6GKXPqIMpSHwobbJHDRDZpoa/M59gjEyqDz4LWp5iLW93VljjPmcsAAjzmq++AqZh/6d33GaVyBMUQ9VTpGG2sY5miciBrh0q1K8xUsgl6nRbfGGY3C5lAPnsNPQbLG2NUIJhFCkGg6/oIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XBAFHk+s; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so16849685e9.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2024 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728046358; x=1728651158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ItTuNJesRv8aPVVPDBG9NjVbPRogCviOxa9DraYVho=;
        b=XBAFHk+sggd97QJH5ZQ0LJR5hajQO4YirBVPJ7R5KXgNHo43jsFpJD/w8tKHQULEpu
         yCVGQkAlJLHACXiw/jN6WaleLeogaTzXbvTkejHisDuBO/ylJTUuHahg88r0t1IyGAu+
         ZHFX5nJgBxIxCCLvnzOp5vP5Rhhd5ludi9D3wWlzFX7OA229weB9It60cW76NeiMdJ/e
         Ju6cc5g/+ER+CYJS8E6WOvfwpqF0rpzm3dICN0bva6uW0kso8VZrDmDZBsXlO/cNlJUm
         YudxVk9uosWggVr/zs1NfMsvwpUrFruptjmJZIifyYTyUdY9FqVdUH10kRyQPLO8NLdK
         /COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728046358; x=1728651158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ItTuNJesRv8aPVVPDBG9NjVbPRogCviOxa9DraYVho=;
        b=TsSr3fgxkFZ/tI4WJZOd2ZRDSfmQGThvm0+MzSYM7eWvYDHEsO1zLBCNr9E7FVbHQY
         KmX75l1oNNLA+NpIlFV1WyUG1aYWTOuIgwv9jGBTNFu/cwYvLEACbuDb7IGwjRQfzakI
         IM251qoKZ7WnZcgp3G4nXV/yEzT6m2YIYU7KDPO3CzsBWND0jmK/dQwEb+8vOD0qyB2T
         WwFwY5wwPBRQK13E9+K2fdPw8fwU2MNTFDNFCrgJq30o4jf6QrD5grZqRlYLimzwPTEh
         fvEwxzwke7c/r7iGAuibbD5ZWgFIXQDeqLc4GDBWLUZ63q6O+JDp7CnE8r7ag8vRuDfX
         Mb/A==
X-Gm-Message-State: AOJu0YygHF9r6u3aJUxGmGRzTtE+wu9qrnyitSqxb4puVz1qZAxnYb8+
	fuIoqv/K/3vPDFb/Rd0GJ5LxCuCX8I1wzDsCBIwAc2/QqPg4WOP6ejBZmLfPCVk=
X-Google-Smtp-Source: AGHT+IG+2BRoSh77J4Sl0ajlbC5Py8WTVYqjuen+MLAY1ENUWyu6ojnznZ8DA20fmDDX40F92PGboQ==
X-Received: by 2002:a05:600c:511c:b0:42c:a8f8:1d58 with SMTP id 5b1f17b1804b1-42f85aa32c0mr15613935e9.7.1728046357780;
        Fri, 04 Oct 2024 05:52:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:80ea:d045:eb77:2d3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f869a39adsm15238885e9.0.2024.10.04.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:52:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH] PCI/pwrctl: pwrseq: abandon probe on pre-pwrseq device-trees
Date: Fri,  4 Oct 2024 14:52:27 +0200
Message-ID: <20241004125227.46514-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Old device trees for some platforms already define wifi nodes for the WCN
family of chips since before power sequencing was added upstream.

These nodes don't consume the regulator outputs from the PMU and if we
allow this driver to bind to one of such "incomplete" nodes, we'll see
a kernel log error about the indefinite probe deferral.

Let's check the existence of the regulator supply that exists on all WCN
models before moving forward.

Fixes: 6140d185a43d ("PCI/pwrctl: Add a PCI power control driver for power sequenced devices")
Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/all/Zv565olMDDGHyYVt@hovoldconsulting.com/
Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
index a23a4312574b..8ed613655d4a 100644
--- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 #include <linux/pci-pwrctl.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwrseq/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -31,6 +32,25 @@ static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
+	/*
+	 * Old device trees for some platforms already define wifi nodes for
+	 * the WCN family of chips since before power sequencing was added
+	 * upstream.
+	 *
+	 * These nodes don't consume the regulator outputs from the PMU and
+	 * if we allow this driver to bind to one of such "incomplete" nodes,
+	 * we'll see a kernel log error about the indefinite probe deferral.
+	 *
+	 * Let's check the existence of the regulator supply that exists on all
+	 * WCN models before moving forward.
+	 *
+	 * NOTE: If this driver is ever used to support a device other than
+	 * a WCN chip, the following lines should become conditional and depend
+	 * on the compatible string.
+	 */
+	if (!device_property_present(dev, "vddaon-supply"))
+		return -ENODEV;
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
2.43.0


