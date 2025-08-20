Return-Path: <linux-pci+bounces-34372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC0B2D9F5
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050E01C218DE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB602C235B;
	Wed, 20 Aug 2025 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GKUD28Sd"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4E191
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685325; cv=none; b=RIyDqr8Ucm3x7bPwYTLhOTt2KCTYfTEKJ1Q1uWktQJuShrt5EIpveMB8QiNk3JpWPWnG9x8/FSDnsCz1aKM72ANL4tTvPSue6ZCg90LQChRPChAOj5EAkYqdo/5sK1EJD0OP0taRDTluCnU9s7h77C6L2GbxWCsSRN+Ifpf0Ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685325; c=relaxed/simple;
	bh=yPmx2NpBFo/eQiaZItuCSTDGjoPBXIBBgjdLKtn25ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9Av+KISypWaV6jdIB5mLnul4IiCtW8eviXS7mIBdYTYhNKU7jL58Gfh4jFeNHtmtaNv0zhn1AUehACBJI7FAgwaXgRJK8/bi8YGpIMPfsOavcVcByY0++cdDyi69qXejYH8UXTIqDk6budnJgsNHkYLmDXtozqG9oig6C279lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GKUD28Sd; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755685317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v1LgTQHA3Xhf/L11p5n5Wj5Gb0sAQMkBeBHPrqYHHMk=;
	b=GKUD28SdH7tZnCYITZ7dAjfgQ/NJhfPXbPhoZ0lyVgFro/MgASXLI91gcJwHhNYuklJj56
	6unNyZMaYhvJm+sF5EdqmpO38Ec7CTvug2Jc84wB6LcNk1qRoANcUphg6VT2ODvQ/hJpUy
	yX3kj6wzWNV6PV9bHRfw1Vnf7FZnkx0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dw-xdata: Use str_write_read() in dw_xdata_start() and dw_xdata_perf()
Date: Wed, 20 Aug 2025 12:21:09 +0200
Message-ID: <20250820102108.760382-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_write_read() helper function
and silence the following two Coccinelle/coccicheck warnings reported by
string_choices.cocci:

  opportunity for str_write_read(write)
  opportunity for str_write_read(write)

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/misc/dw-xdata-pcie.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
index efd0ca8cc925..a604c0e9c038 100644
--- a/drivers/misc/dw-xdata-pcie.c
+++ b/drivers/misc/dw-xdata-pcie.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/string_choices.h>
 
 #define DW_XDATA_DRIVER_NAME		"dw-xdata-pcie"
 
@@ -132,7 +133,7 @@ static void dw_xdata_start(struct dw_xdata *dw, bool write)
 
 	if (!(status & STATUS_DONE))
 		dev_dbg(dev, "xData: started %s direction\n",
-			write ? "write" : "read");
+			str_write_read(write));
 }
 
 static void dw_xdata_perf_meas(struct dw_xdata *dw, u64 *data, bool write)
@@ -195,7 +196,7 @@ static void dw_xdata_perf(struct dw_xdata *dw, u64 *rate, bool write)
 	mutex_unlock(&dw->mutex);
 
 	dev_dbg(dev, "xData: time=%llu us, %s=%llu MB/s\n",
-		diff, write ? "write" : "read", *rate);
+		diff, str_write_read(write), *rate);
 }
 
 static struct dw_xdata *misc_dev_to_dw(struct miscdevice *misc_dev)
-- 
2.50.1


