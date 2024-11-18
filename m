Return-Path: <linux-pci+bounces-17029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D79D0A4F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 08:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C47282205
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 07:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8B197A77;
	Mon, 18 Nov 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HAcWrwUD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58E194ADB
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915001; cv=none; b=DLVRNbBjk+n4QaOlEE3XNfsUDkDryjy4th8d6IBUofMKDDXkrObcyAhwmcX7+BKvEkVLktXcJ+dsiw5EUiFaE2TWOBzTbjbbEU2ZJFZONpHuRQ+Hwe8p79XtudkvklZcWo5FncSG0WNEnww5RhvsXVMn5NgV92LwSrjLuiUVH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915001; c=relaxed/simple;
	bh=EVLI1cHGZYuRwvVqP9/Q0jGa6hZ3ryePQjA5jCLGSu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5FWdSyYp4KfOJpVMxrg1lzYoYZUtuiIPWsKFRigsx1C6KfWmry8B6zucx0VZz488ptRksAnzl0xTalITbYGS+nMtnCJ/naUuak3xhvgyw90Wx7YOGSlw4iDeO+qd5X2tXQXY+0ReUjypwRi1vmEFkm9oAiVVtyUiSgUQXuSYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HAcWrwUD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=uZ5ABmRvlpMuaxQE2uiPOT7TJhXsFP6D8Ub1SaGgoc0=; b=HAcWrw
	UD8WTuNt/d5WCErt8gVspV3U3v/442VcFrIffF53mCR5uXdvMiNbaI9rWOX7g26m
	6zTNjgTxpQHg7ZUvWMRzjjrkWLvu6Bw8wxJuiQIru9/tMnN29dmZOCLixRWz4AN3
	CFvRWkpk/gO6uOqWaLP+TiZ0e/NXETNKuKOlCazcsHCXhfYvq7mhiRM3MYdTxE4b
	za6xs6o2Yiuzg1NJULDAfO1C19XhXkIuaLcQj4d1Vf8rddrpQeJo9sUXvOp6BT1B
	mxx/4r6YAl7LhocnZFUPgSoLi9+8pvISjtpNT9GQYxbsGgxRnQGh4p+zsWkgE+/C
	AG5aJWexGrsn9/iw==
Received: (qmail 112532 invoked from network); 18 Nov 2024 08:29:41 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:41 +0100
X-UD-Smtp-Session: l3s3148p1@IqlD4SonHNYujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 11/15] PCI: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:10 +0100
Message-Id: <20241118072917.3853-12-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via 'device.h'. 'platform_device.h' works equally well. Remove the
direct inclusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 225a6cd2e9ca..3b1939c9cf46 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -23,7 +23,6 @@
 #include <linux/string.h>
 #include <linux/log2.h>
 #include <linux/logic_pio.h>
-#include <linux/pm_wakeup.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
-- 
2.39.2


