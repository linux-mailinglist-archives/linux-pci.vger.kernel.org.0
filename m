Return-Path: <linux-pci+bounces-34983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3432B39864
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 11:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2736F1898F1F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536C2DF6F4;
	Thu, 28 Aug 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj2K4HSD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF72E1C6B;
	Thu, 28 Aug 2025 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373769; cv=none; b=ESydlLNGyw4yCOIynMvEuIRKcOi2AbE7RrDdgBRK8b3oSNeniuKOrKGDwmA/p9ZOd+Yl9Zhd+yMQE4b8UYVaPaG9WVBqukHT0dZKvcvil08JMOhd52dI0reRtlFuc4+JOsB28kuMoxcf3uDb3QrSVnY7MwI0RieUhnXjNldmiMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373769; c=relaxed/simple;
	bh=Zqe5NyJGM5DuXfJFzXIjySbvszRtTgEYzWlIVzR3ZzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtsNHoq49V019tFds/4UuDZ+V4IibLuZqibCGBMNOHsOcO0rrDCOGDS1gKKzjHMGHlSoxJgCFeCG1WyVDJPO5ystjxc54iaWePafKvukZuNyVXdPKbJ7Fy46eQu5PKlGRIx++iVyjQA87dA0+Fn97yDdHSwRPeziux9eax2dEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj2K4HSD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so3860755e9.1;
        Thu, 28 Aug 2025 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756373766; x=1756978566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FP5C/uwDhoET18gZlFmnkES6rxYq0JTCYgBo43rCuT8=;
        b=Gj2K4HSDLUgoE/DKjzaa+gCSSy5NJi6w2T25ftKz3FyFqqnMHfsO0Ph/QMw3usdVE7
         UCzEBWCuciVYKC4LtsaSgAnJvvl1cI14ZwOXOXGbeeVDrsZI18luSv/xmduxn5U6w2Tf
         LuB8dPyjI1qroN+q61gCqBUaH+1WFNEhaHQwkf82ieJtKgjX1LxPyAU0wNhmhsg0EL1j
         YUyGNKnDQvWy2+8+fYcwQUKfWcGPRxp3ufXrH8yHGXy1hgsiyj0+b1TFTc7OpA/RzdG2
         Kdv/zj7DZN/JsBQFER5xcpBCOvEkbtPY4SmgC/jPQ3gzn2b1YyxBvRxh7SO/dhI8pflc
         QN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756373766; x=1756978566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP5C/uwDhoET18gZlFmnkES6rxYq0JTCYgBo43rCuT8=;
        b=JVPQLaN+ucT4W/ydZkSMtLkUJ8vlQxRSd6Fjetyn8oXv4l3jT8I4lWIMxGt6x8d6Gi
         4g4utOH7zRSV5eVKbB9wauATziT9ixg5kDPp16ygmOlHkIerSamyjEqH5qzlqj/0wFRO
         SIlZNlbuVHl6QyoAoSLsN+NbgUrEzl12oj29p6StMmVSAZDyh82GvW400UaL77/x1mZc
         ytupOvRLMPgBFKnCWoRsZQWi1eqm1N4aVGdD0qK0TTu2XXxrOBV880L7BxLUnmtl6ORo
         /Ef3J0vJPbrqwpJTtClSkMQhvZXfjvdBrBNazntvkjwgreRrvGa27Mn1aPwx5kECg2RM
         na1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4OC9/5y2P8O13e/GD/iGvEi2EywFgaR7iZNmKiBYcq0HmT/s9Hnf9XxD9aIuKhn73FBW1tQ7xL+Zz@vger.kernel.org, AJvYcCV9mbqD/V1acc7rz3jdintmLBUtneLVdTfS2Zg/K3CsUeq3hBKUI/kwoYtJ81hJ3u8kcvTdLs/vzgHDOFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6rqpMz0Xtr+1a/M4xt23Mt7qTfdI7iRYqFViEl7HEUYzqaY+
	XBVzRBuor0M4QrFknb0kQHfm7/nM14RNrcL24Yhh9AXUwHtovio9uawD
X-Gm-Gg: ASbGnctifBGH/DavShRA4zM8xRwFXGUPIyxChOzW21bbXontOQaI5VOATixzFYaqys3
	lE8J2hPwsjfKV8Gm3oc2rdiJSaKsuzY/weCAX/uLt7KJBMygBI3Gt7IH4HOMhQBJyF3yEJt64r+
	prvgfxj9dB7GH9zYvgX9R9Rn+qzlb/vmoSQmr8BMkgqAMZEn0AO4ggfvAglN9vTY/WbrOgZGvnH
	PSVWr9yJiV1HJfGHSXvd0iq9mJyJnBuNxLHS7AEgwBc9h2B6VZWEDfUnKW4E2J23K2OU2hPxL4d
	A9a1PEvikdbG/yJ7MRS9w4aSiqUxK/gRG5HXKmEAcCQXdgS2ZXP8Ze/Ll0qLFG5DUvBN5tiLHuM
	lyTDbVMStQDqHQQsYpb477Ry53XpB+ykpZFOujcIO
X-Google-Smtp-Source: AGHT+IEFV/z3r9BTmwygjo3zipt0zXBJ/VUQG/wcWv0r20u8uWchiAq+0WjEu8B7xnDjs3QaAVzI1w==
X-Received: by 2002:a05:600c:4687:b0:45b:47e1:ef71 with SMTP id 5b1f17b1804b1-45b517f8e7fmr195579685e9.36.1756373765821;
        Thu, 28 Aug 2025 02:36:05 -0700 (PDT)
Received: from pc.. ([102.208.164.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cce1724939sm6083546f8f.26.2025.08.28.02.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:36:05 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: logang@deltatee.com,
	kurt.schwemmer@microsemi.com,
	bhelgaas@google.com
Cc: julia.lawall@inria.fr,
	kelvin.cao@microchip.com,
	wesley.sheng@microchip.com,
	stephen.bates@microsemi.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] PCI: switchtec: Replace manual locks with guard
Date: Thu, 28 Aug 2025 12:35:55 +0300
Message-ID: <20250828093556.810911-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace lock/unlock pairs with guards to simplify and tidy up the code

Generated-by: Coccinelle SmPL

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/pci/switch/switchtec.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index b14dfab04d84..5ff84fb8fb0f 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -269,10 +269,9 @@ static void mrpc_event_work(struct work_struct *work)
 
 	dev_dbg(&stdev->dev, "%s\n", __func__);
 
-	mutex_lock(&stdev->mrpc_mutex);
+	guard(mutex)(&stdev->mrpc_mutex);
 	cancel_delayed_work(&stdev->mrpc_timeout);
 	mrpc_complete_cmd(stdev);
-	mutex_unlock(&stdev->mrpc_mutex);
 }
 
 static void mrpc_error_complete_cmd(struct switchtec_dev *stdev)
@@ -1322,18 +1321,18 @@ static void stdev_kill(struct switchtec_dev *stdev)
 	cancel_delayed_work_sync(&stdev->mrpc_timeout);
 
 	/* Mark the hardware as unavailable and complete all completions */
-	mutex_lock(&stdev->mrpc_mutex);
-	stdev->alive = false;
-
-	/* Wake up and kill any users waiting on an MRPC request */
-	list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
-		stuser->cmd_done = true;
-		wake_up_interruptible(&stuser->cmd_comp);
-		list_del_init(&stuser->list);
-		stuser_put(stuser);
-	}
+	scoped_guard (mutex, &stdev->mrpc_mutex) {
+		stdev->alive = false;
+
+		/* Wake up and kill any users waiting on an MRPC request */
+		list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
+			stuser->cmd_done = true;
+			wake_up_interruptible(&stuser->cmd_comp);
+			list_del_init(&stuser->list);
+			stuser_put(stuser);
+		}
 
-	mutex_unlock(&stdev->mrpc_mutex);
+	}
 
 	/* Wake up any users waiting on event_wq */
 	wake_up_interruptible(&stdev->event_wq);
-- 
2.43.0


