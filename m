Return-Path: <linux-pci+bounces-29388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4CAD48CD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 04:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B8A1894F78
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 02:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC00113D539;
	Wed, 11 Jun 2025 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf7zPpb1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20D286A9;
	Wed, 11 Jun 2025 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749608543; cv=none; b=tXrDRdQlaQjRV1jWC9xjSIrnk3cyQUEdURBxY6Eq8w358dU1LPbaiYIUiriIHxWQ435fawnN9WslBOp52ChrtCkZq1Wl2SUIj75erwNkJRRziTO3leF2iT2bkGxGL17jN4gqGVw3UThCTYiBy0jE30hRB72FN0BBp+X20O7aaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749608543; c=relaxed/simple;
	bh=wZgm6b+aaYaDHSCtiEqey06T+bU5xLWsquPRNzTnwAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PEsXhKS2Nj4K0W8LiHhOPN9j97nch7fvQ4+MyiCDpYc2CNWP5f2/5nxYSqrZJHeTT4/gyYvjegHS/ZAU1vSkMfJDmyauAIfgiwV999FGypkISHqxci8kl3LrYK1ZidjJvnr4EOG4Oki8z06ARI7DtsPxa3TovGSC3SVAY9DoA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf7zPpb1; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-53118db57b4so417975e0c.2;
        Tue, 10 Jun 2025 19:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749608541; x=1750213341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDW7FpZdddVN8iP+dZ71T1ANA9fYJqbCRdgup6n4kvE=;
        b=Gf7zPpb1XG8xDRJrVpNudpGv/ZXFFNLRcdaiNlwEV5Hi9VqY2iSyvt//s+RsTrZems
         VJeEGjIRm+eZRkT2Q21wJiLxp0UWLnPc8CJKDKkRmmSX8zHe3dkH6mcrMd5lhDAKb0Qa
         3qKQjENe5Dd6viqrvFmxvMTbHtiRAvk0owSZoCfD28c4wq6Dgqz9srwqK24OJzJMYUwv
         /nlxA0e8jgqBVTHKKSXFBX+pzqO4uQD9+WP0tf22VoQFDvb3Pghvfgn62eJ0mHTNxhYt
         uG5N0wjflbUAXyXMuH4GjbvSgRFpBQVsm7l/NwNl9Rum0QgiIDD3hj6SbIJ7xQWauXgT
         OKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749608541; x=1750213341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDW7FpZdddVN8iP+dZ71T1ANA9fYJqbCRdgup6n4kvE=;
        b=U9/l3bVQMF1SJVcBkqiRjteSK3QxxmWV1BB2P7SDahEZkGUyY4TFeDHhv2ab65j5pz
         m/dCO2N3yH+gMd7C+h8ytYkr04DbPmsMMeZVy+BDqMCV93w+oWnNWx7uplhufwS5h1cz
         fOQ6WxedenK19jbeOdYNx1GMwAWAtlXIkz7q0TEZiAW3pkIm7VxT9YXZm5NfOV6FKBQA
         uz/4eocPt08D3Zikrwf4GbfU9FgslVqyRns6SrbaTv9qD1qLXuITTfSxTTu7bLsdorwu
         SYuZi5cwwV/M1IdNDIyKhMptf9zhWCJyceHXg3QX8AA+WknIBN027KzM3n+XaitqFUxW
         Xe7w==
X-Forwarded-Encrypted: i=1; AJvYcCWFlWVou5gKIqClKLT8uFGcHxe1B8YcPM7flXau9mK0n/9nmgvo4pD0aCLwONmRUHG2PscCVJvumO0te3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70KBTQqvK/4xcR31a6ksEhY1dSn74n7ISI4d1n9Jnec25zzIC
	nkKI3S0GggJMPShTWtfw0cCtV1vpHuRsavP+02apObw5I+3JJNsatlaa
X-Gm-Gg: ASbGnctLz8KtOwrh/2vfxZY7vCUvp3FXNE23gPhnyvDIjFgwpJQBejgDFVZwjz18uKJ
	v1K9i4+v77D9ZRxe5T39ZQI8eV48N5nOht2oLHpSMcPlLQZ6JpSmnXSyy1YzpjAIlmE9AHdmxgD
	tyHlsLBLJLyzqNvkNybjdAp1V7mmEFePphWp4fDgiKhot6OZtoFKaTej+D6tcBNlYSAGC3Dc/ME
	ZRa+yAIqSGoVjPMsfMvTYwEofVXkfneg7OxdEoy/EScU2aSwegixd+v6/fEKT7CWURTJUhI/iW8
	/rDszqVjeAli2SbzXwbjIjzXMN03wDSY8A+TGhSV+D9tbuwl2+zMsPsoR5wde6BKJCSegn3m
X-Google-Smtp-Source: AGHT+IEyTeM/+4PiirQpXvijwrUccW8FXProX6fsljS4q8OsbpgRzIAF0sRJeAbEcq4CDfTy+7e7aw==
X-Received: by 2002:a05:6122:1e06:b0:530:7747:80a7 with SMTP id 71dfb90a1353d-53122e17151mr1138216e0c.9.1749608540798;
        Tue, 10 Jun 2025 19:22:20 -0700 (PDT)
Received: from pop-os.. ([201.49.69.163])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5311f41fa07sm1340765e0c.4.2025.06.10.19.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 19:22:20 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: bhelgaas@google.com,
	ngn@ngn.tf
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Subject: [RESEND PATCH] PCI: hotplug: remove resolved TODO
Date: Tue, 10 Jun 2025 23:21:23 -0300
Message-Id: <20250611022123.201839-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 8ff4574cf73d ("PCI: cpcihp: Remove unused .get_power() and
.set_power()") and commit 5b036cada481 ("PCI: cpcihp: Remove unused
struct cpci_hp_controller_ops.hardware_test") is resolved this TODO.

Remove this obsolete TODO notes.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/pci/hotplug/TODO | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index 92e6e20e8595..7397374af171 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -2,10 +2,6 @@ Contributions are solicited in particular to remedy the following issues:
 
 cpcihp:
 
-* There are no implementations of the ->hardware_test, ->get_power and
-  ->set_power callbacks in struct cpci_hp_controller_ops.  Why were they
-  introduced?  Can they be removed from the struct?
-
 * Returned code from pci_hp_add_bridge() is not checked.
 
 cpqphp:
-- 
2.34.1


