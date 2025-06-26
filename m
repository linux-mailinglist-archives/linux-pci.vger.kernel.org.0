Return-Path: <linux-pci+bounces-30688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C135CAE95FB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 08:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856F31885F2A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F41E232367;
	Thu, 26 Jun 2025 06:11:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BF2264B0;
	Thu, 26 Jun 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918282; cv=none; b=o1+W4X7znlsy4/56gQUiYLh6wbGfzUkS7CyfIOeYfYAy5Qr7rPMrQgPCN+qUR75VxoGTm+2ixmVT7Ttsjz2IHjNufZwRZE260BhY8WEmOZOt6ldUgHgDLXbBtciOXAcFHy3iB0HDLTrZ9zbh4VY3U1KWQuqZGiSUzkOP96i+TFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918282; c=relaxed/simple;
	bh=YjBNwjuDDGIEARDlIG3mMEgJiZszeROBIi4mjqVfmi0=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=S8AGcIlnK+dO6iqCQDiXYMU4CI6m0iy45Chc5lmP5/gsQWuWxaUyi0Q/jpje2nHmHrGUwt6bK0BueJjFoN+YPil248Rxq7wcLzeSYQt/mkPs3R/W5Ab7dKr7SBM2RtwO6CTO4xrxsCS2bgVX8EPYyP4mLrvurEfDrBmvoaD5InY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bSSx91gNRz8RVF9;
	Thu, 26 Jun 2025 14:11:09 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 55Q6AaTi045249;
	Thu, 26 Jun 2025 14:10:36 +0800 (+08)
	(envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 26 Jun 2025 14:10:38 +0800 (CST)
Date: Thu, 26 Jun 2025 14:10:38 +0800 (CST)
X-Zmail-TransId: 2af9685ce45e5dd-13d4a
X-Mailer: Zmail v1.0
Message-ID: <20250626141038445ZnnRRHX3QpBjC7RGFRlrw@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <kishon@kernel.org>,
        <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liu.song13@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSByZW1vdGUvc3RyZWFtLWV2ZW50OiBGaXggYSBtZW1vcnkgbGVhayBpbgoKIHJlbW90ZVN0cmVhbUNhbGxiYWNrRnJlZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 55Q6AaTi045249
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 685CE47D.000/4bSSx91gNRz8RVF9

From: Liu Song <liu.song13@zte.com.cn>

The ff callback is never called in remoteStreamCallbackFree() because
cbdata->cb can not be NULL. This causes a leak of 'cbdata->opaque'.

The leak can be reproduced by attaching and detaching to the console of
an VM using `virsh console`.

ASAN reports the leak stack as:
Direct leak of 288 byte(s) in 1 object(s) allocated from:
    #0 0x7f6edf6ba0c7 in calloc (/lib64/libasan.so.8+0xba0c7)
    #1 0x7f6edf5175b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x615b0)
    #2 0x7f6ede6d0be3 in g_type_create_instance (/lib64/libgobject-2.0.so.0+0x3cbe3)
    #3 0x7f6ede6b82cf in g_object_new_internal (/lib64/libgobject-2.0.so.0+0x242cf)
    #4 0x7f6ede6b9877 in g_object_new_with_properties (/lib64/libgobject-2.0.so.0+0x25877)
    #5 0x7f6ede6ba620 in g_object_new (/lib64/libgobject-2.0.so.0+0x26620)
    #6 0x7f6edeb78138 in virObjectNew ../src/util/virobject.c:252
    #7 0x7f6edeb7a78b in virObjectLockableNew ../src/util/virobject.c:274
    #8 0x558251e427e1 in virConsoleNew ../tools/virsh-console.c:369
    #9 0x558251e427e1 in virshRunConsole ../tools/virsh-console.c:427

Signed-off-by: Liu Song <liu.song13@zte.com.cn>
---
 src/remote/remote_daemon_stream.c | 2 +-
 src/remote/remote_driver.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/remote/remote_daemon_stream.c b/src/remote/remote_daemon_stream.c
index 453728a66b..a5032f9a43 100644
--- a/src/remote/remote_daemon_stream.c
+++ b/src/remote/remote_daemon_stream.c
@@ -437,13 +437,13 @@ int daemonAddClientStream(virNetServerClient *client,
         return -1;
     }

+    virObjectRef(client);
     if (virStreamEventAddCallback(stream->st, 0,
                                   daemonStreamEvent, client,
                                   virObjectUnref) < 0)
         return -1;

     virObjectRef(client);
-
     if ((stream->filterID = virNetServerClientAddFilter(client,
                                                         daemonStreamFilter,
                                                         stream)) < 0) {
diff --git a/src/remote/remote_driver.c b/src/remote/remote_driver.c
index 2690c05267..9ac13469e9 100644
--- a/src/remote/remote_driver.c
+++ b/src/remote/remote_driver.c
@@ -5336,7 +5336,7 @@ static void remoteStreamCallbackFree(void *opaque)
 {
     struct remoteStreamCallbackData *cbdata = opaque;

-    if (!cbdata->cb && cbdata->ff)
+    if (cbdata->ff)
         (cbdata->ff)(cbdata->opaque);

     virObjectUnref(cbdata->st);
-- 
2.27.0

