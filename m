Return-Path: <linux-pci+bounces-44210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0DCFF3F9
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 18:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CC84302C9CB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 17:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4292F375142;
	Wed,  7 Jan 2026 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="qfDtnwS+"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-103.ptr.blmpb.com (sg-1-103.ptr.blmpb.com [118.26.132.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0127C36CDFA
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808630; cv=none; b=ILY3kRRg6HiKxFr7yJ59d4fdAtYBaeGta5FepKoWkfYV2M9qOOiGFjijLdv6fO+N7CPhr9WJz9nL6qLymT4YTB8zfBm4dRDiyfFlM1kCy0L0B3wr7AHCeWDTby3wi9Oayvq04Bk+91bk3ligQG553MqjJCQliKc9qUlIEy1tbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808630; c=relaxed/simple;
	bh=ZYug4yNuU4av7KeoafX84stshFAma87Mg8qQ3P2JQKk=;
	h=References:Mime-Version:In-Reply-To:Cc:Message-Id:Content-Type:
	 From:Subject:Date:To; b=Y7ZndCxubWfdwxVlArZb9Y1/Va9h4Cc9CNh1kPuqbUCOX4yJN9bTVDGOg+kPfxdEGdr+/cwy7FDW1ccX7ddYU7ojZK20DeE1H3DlB0U+qgSW717Xr8atEYrU+Q6MElitbbCa1Jss1ylgh8+LPzGSsBpDwE74sNbt+sw8BDi1pe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=qfDtnwS+; arc=none smtp.client-ip=118.26.132.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767808621; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3lqZAckEjBHvH7t1Qq0KweacFxTKdPPI8/L7We/Rsrw=;
 b=qfDtnwS+ohbPccRDv/69ufj6qlXMhnB4FxeGzE8dVQWZJEA2A5Hl1kkFDfZwQQD6LiXGwk
 44SxyfoPLaxN2zPsVI9ypKC/VlQxVeC+1t6FY5OWu7uCwLJfGc+DZqoCWtjT5C7K9NjR7n
 M8nLHtWXS9Vk6w3awho+dV63Vclqst2Yltp+pnW2HWEYK+wzGJNqQH4IM4ehx7saXrKixJ
 OhQE2e4a+6uExv0qrhcQ4YYlI+Qmb+RoGxKSiU6JcYdUMUQwhh0g2CvkmfSuyHa+ducLlR
 VjQw/1QdVCMdD4ANyBPk40HpC7Bz0WgR3RNQED4uuX6k58g/UHazRQg4gffuxQ==
X-Lms-Return-Path: <lba+2695e9e6b+ac39da+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
References: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
Cc: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>
Message-Id: <20260107175548.1792-2-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [PATCH 1/3] driver core: Introduce helper function __device_attach_driver_scan()
Date: Thu,  8 Jan 2026 01:55:46 +0800
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: <dakr@kernel.org>, <alexander.h.duyck@linux.intel.com>, 
	<alexanderduyck@fb.com>, <bhelgaas@google.com>, <bvanassche@acm.org>, 
	<dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>, 
	<helgaas@kernel.org>, <rafael@kernel.org>, <tj@kernel.org>

Introduce a helper to eliminate duplication between
__device_attach() and __device_attach_async_helper();
a later patch will reuse it to add NUMA-node awareness
to the synchronous probe path in __device_attach().

No functional changes.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/base/dd.c | 71 ++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 349f31bedfa1..896f98add97d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -962,6 +962,44 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	return ret == 0;
 }
 
+static int __device_attach_driver_scan(struct device_attach_data *data,
+				       bool *need_async)
+{
+	int ret = 0;
+	struct device *dev = data->dev;
+
+	if (dev->parent)
+		pm_runtime_get_sync(dev->parent);
+
+	ret = bus_for_each_drv(dev->bus, NULL, data,
+			       __device_attach_driver);
+	/*
+	 * When running in an async worker, a NULL need_async is passed
+	 * since we are already in an async worker.
+	 */
+	if (need_async && !ret && data->check_async && data->have_async) {
+		/*
+		 * If we could not find appropriate driver
+		 * synchronously and we are allowed to do
+		 * async probes and there are drivers that
+		 * want to probe asynchronously, we'll
+		 * try them.
+		 */
+		dev_dbg(dev, "scheduling asynchronous probe\n");
+		get_device(dev);
+		*need_async = true;
+	} else {
+		if (!need_async)
+			dev_dbg(dev, "async probe completed\n");
+		pm_request_idle(dev);
+	}
+
+	if (dev->parent)
+		pm_runtime_put(dev->parent);
+
+	return ret;
+}
+
 static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 {
 	struct device *dev = _dev;
@@ -982,16 +1020,8 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	if (dev->p->dead || dev->driver)
 		goto out_unlock;
 
-	if (dev->parent)
-		pm_runtime_get_sync(dev->parent);
+	__device_attach_driver_scan(&data, NULL);
 
-	bus_for_each_drv(dev->bus, NULL, &data, __device_attach_driver);
-	dev_dbg(dev, "async probe completed\n");
-
-	pm_request_idle(dev);
-
-	if (dev->parent)
-		pm_runtime_put(dev->parent);
 out_unlock:
 	device_unlock(dev);
 
@@ -1025,28 +1055,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			.want_async = false,
 		};
 
-		if (dev->parent)
-			pm_runtime_get_sync(dev->parent);
-
-		ret = bus_for_each_drv(dev->bus, NULL, &data,
-					__device_attach_driver);
-		if (!ret && allow_async && data.have_async) {
-			/*
-			 * If we could not find appropriate driver
-			 * synchronously and we are allowed to do
-			 * async probes and there are drivers that
-			 * want to probe asynchronously, we'll
-			 * try them.
-			 */
-			dev_dbg(dev, "scheduling asynchronous probe\n");
-			get_device(dev);
-			async = true;
-		} else {
-			pm_request_idle(dev);
-		}
-
-		if (dev->parent)
-			pm_runtime_put(dev->parent);
+		ret = __device_attach_driver_scan(&data, &async);
 	}
 out_unlock:
 	device_unlock(dev);
-- 
2.20.1

