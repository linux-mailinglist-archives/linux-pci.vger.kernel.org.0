Return-Path: <linux-pci+bounces-9895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85BB929837
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 15:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C481C20885
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74A2B9D7;
	Sun,  7 Jul 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqL5zi4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B822F08;
	Sun,  7 Jul 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720360458; cv=none; b=Lld05hiJ/XPkB57/szdwp7+2UaffZKspPmKnyp0rEhH+P2MxwMGRJDuS1fEPFNWgXinIbkAV7hPOUAqM2/Z9pWIGemChaNW79srpAVCu74lcLr4+20J1x5l29pleLcAWQVn2044k43eAy2oo+Lu3FLJQjhF+QqqaFBtQaRuzUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720360458; c=relaxed/simple;
	bh=mJtYwIyTH1Cl3luVj92E509Bkm9G9lB/Y+G3HLsYxZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TerCKcCS+p03qZvRj8DM5VxUo8zbH3WPcdZWoXowy715Selv6TCYCag8Oqk76LBZLKlhuV66e2SDRhXTRbHBmmfSGBo3i9d99hdEg+IgouyXQVBFrnxfisDny3YF+EQdo3rSrvnnNtZcD64RDLnJnS6oFY8GxgLi/HwGKyObjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqL5zi4p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4265ddc879aso8319195e9.0;
        Sun, 07 Jul 2024 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720360455; x=1720965255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUkGzF60F/FwgVDH3DZUnbQ1ZrjYBH0b66MEdw03IpI=;
        b=SqL5zi4pslT9BkCFPRDF35Pj2+CMe5o8ACy9RgneT0OtpTUDis4yL7ORSwPzSJwTNx
         5R1BQqhKHFPReqlknUcdVZK2QqzcvFVuua0ikvIL2q1I0zv0R7r5U07Gs5m3pgUQl64w
         DnNLK6vW3Dcx/dfWzPeFPvLiCZFS1eBcjwn+DFOZeHa/9fN+nKeNVJgX4bLkrcByMu65
         Hyd65Oy/WVdLL15OJuabU7fRwyiu878+I77+HDVLzZrI6VpEb0wMmmiowe3J83dAfLoj
         OIaT0T5TovwrJa2xuCV4rmLMicaKXNehgIY/HMQnKAdXqO3bWDX1m4Bu25A7VfRjTk+v
         JBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720360455; x=1720965255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUkGzF60F/FwgVDH3DZUnbQ1ZrjYBH0b66MEdw03IpI=;
        b=X7PDMEyogvGEqLSZdUMsBAcZc/x/0bF6ywveIAh3/QJoKYAdN6th+7PlqjH84ABjnV
         oDCpXADS5Ot9HSjPnFXcWDzMyZdSTU/s4jbZR8QJYpPuchzMTCtBMa0i6+j5rob5vMBq
         2LUn2SnygzuTFZvCH99Z1kB776jmyMM2Lrqsbl9nADRTDqU5HfykC9XT7XbqN8BO/I6a
         Ok/K1ApRG424AYVSVeO2bfQ0Hrq6wbWPzAg782EUFQ7BRGUeXHILFeLidH7vSbJVrczH
         dcCZjvrQZPzBHbXkqLRzhftAQUtiy1a0hCyYIjPfHj51fjOwzxxNyTDwUhEeoEDoaDOD
         JWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzWHSZixBC/wm7zK7y2fb+Ck+uN1cBiYqfnLy9GgYDf2zhXLYlnQcVOxNcAd3tyA4NuHhH19tDIh0DZ3owLzUJo02HzlXJQ1+BGsHl
X-Gm-Message-State: AOJu0Yy2wYyAhXUVCh2zSP+SRl/pYhCoWl8vzYYlq/kDVdYTzOCIwJYC
	sP5m8zzBuwSe8M+2Q49v9DW1vAxGwkFp7gOMqDZrDqj1OPpJzLKR
X-Google-Smtp-Source: AGHT+IHLjtPx1vGQdZ7dzXeEPtmsSsKqmDdD9cvjCl5pe1qPz7rMRyIMBvmQWuX8uXd4Upk0eJNlPQ==
X-Received: by 2002:a05:600c:6a83:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-4266876849fmr5434355e9.17.1720360454921;
        Sun, 07 Jul 2024 06:54:14 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-768b-c763-2748-445c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:768b:c763:2748:445c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc49fsm129684005e9.39.2024.07.07.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 06:54:14 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 07 Jul 2024 15:54:02 +0200
Subject: [PATCH v2 2/2] PCI: kirin: use
 for_each_available_child_of_node_scoped()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240707-pcie-kirin-dev_err_probe-v2-2-2fa94951d84d@gmail.com>
References: <20240707-pcie-kirin-dev_err_probe-v2-0-2fa94951d84d@gmail.com>
In-Reply-To: <20240707-pcie-kirin-dev_err_probe-v2-0-2fa94951d84d@gmail.com>
To: Xiaowei Song <songxiaowei@hisilicon.com>, 
 Binghui Wang <wangbinghui@hisilicon.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720360450; l=1398;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=mJtYwIyTH1Cl3luVj92E509Bkm9G9lB/Y+G3HLsYxZ0=;
 b=72sreDZlcGjLGlHJGn7sZ7uRrzywLJsgsi334+tfHEJ6Da2hLceINLORC8jiBBMoImK6LbJ7C
 CF4iuTYrYwFA/Q+Ra7xJ6chDJr0QKqStRF1vB/utZolh08Ug/tg9PTr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The scoped version of the macro automatically decrements the child node
refcount on early exits, removing the need for the `goto` and
`of_node_put()`.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index e00152b1ee99..7c591f50d0b2 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -446,7 +446,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				    struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child, *node = dev->of_node;
+	struct device_node *node = dev->of_node;
 	void __iomem *apb_base;
 	int ret;
 
@@ -471,17 +471,13 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 		return ret;
 
 	/* Parse OF children */
-	for_each_available_child_of_node(node, child) {
+	for_each_available_child_of_node_scoped(node, child) {
 		ret = kirin_pcie_parse_port(kirin_pcie, pdev, child);
 		if (ret)
-			goto put_node;
+			return ret;
 	}
 
 	return 0;
-
-put_node:
-	of_node_put(child);
-	return ret;
 }
 
 static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,

-- 
2.40.1


