Return-Path: <linux-pci+bounces-31287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB6AF5DA0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2571B17A20F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16E2D372F;
	Wed,  2 Jul 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SaGyCUyM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E182D46B5
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471526; cv=none; b=oNUdCktRj2HCMZle+g3yB3cGrm2NHu3RGk0fwhT72Yc603crYZBOmt3ELpSplUo4NmGiqbar6G16911dxUo8f+eXUnQTK0EolhE+iODql65NlmY/vbJsCguBQu/3qqzyeUl6sxqWOo561xHif/kU8NFwxfWPLeBNp+OFQfK0hfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471526; c=relaxed/simple;
	bh=NS3AsNMLrENn/8Ti0YYvu7N8hOzTOmgsWmxaUEYudV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+YmuQDfJuD2LtyVnR347KPYFoz1hdom7I/yWfKNLNMV8BxGK6flps3khnD7PCWw9Bzzq2+w978YmjQNdQiK3OG2RefIqZjHT7mIyBWHoTcVLt/+pPh9m4Lt2va/EwYxTYCJzOp8G2XbSM0ZCSRhlJ+do+01k9Cf8sVD2aStNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SaGyCUyM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237f5c7f4d7so8358765ad.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751471524; x=1752076324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aDzf7YBPMHw9MxikxyQTBYHEWprSFyhpDaUPtjmgAo=;
        b=SaGyCUyMIsg2HJmDVNBGyLRpY1Juq8AtaSNG7xK8qAlhnUWoOCSk9ZK8aTyifhvKcH
         c2AcfTC/C62s+RckcOz462lkaEftm41+UMYePsOmPIXLPWLtFNcEIr80PdlMbDVYli4W
         e2HVbHV4w12e2TdoqN9WWJbtme83wM+zBKoKj9gUtmWriLaNhvzM/3cEwIaOsAlSnZXi
         g2PyyrZpiMEkPlywPCY3/M8uPo1kttSdD5MHTjEVlvciDaCZZpQr6YBTrxnHqKrySfA2
         kL0KrHXjv+W6ebEgYD2kTTOq8ccbwuj5WthpnsADUpD6Rt0yJILNpMKtngOcUULYfkut
         mF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751471524; x=1752076324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aDzf7YBPMHw9MxikxyQTBYHEWprSFyhpDaUPtjmgAo=;
        b=XO2n2kx5W+BqjocoQYe+nHPTNgNFyOYZ6H/CJ7TYtpQQ9lgsV2jAtm/KBxiD3l1J5I
         dPn8TyNTbz1bx52kfXaZS0ZF/+Y7T8L2c8wQiQmFxN6YCcLLUvr4WPoGXsy09GeCxFNK
         4KJsbw1CAYD6mXmkM1eQSQCvrVrsGJqUNWikVSDJhZuRUzG/0uH0CJJuojlkb8AHokKY
         +Y07XuosRY9V8FcRXO3KDy6Vn7yYwwIdjQ0bTz0r6ZO4MwR9BiSslC7U6AAIU1iC+Rk1
         r+kR/0fU/VvBrMWXN+ilmGUbOq095V6K1p6FEV+Ec64RZEQVHa4IjCyKCiBz7U17PLwP
         4ukA==
X-Gm-Message-State: AOJu0YyXfEhAliXL5YWRu2mMvg55hlJFFk7yTEUxYKWC32wNTm/SQbuu
	T/rex9zgga7Ivu0Betz6HcUQGUV1johKZlOOAP9bGFgBDuApnNHAtM0cgNxTvzszyYg=
X-Gm-Gg: ASbGnctdFum0PPd8xIUendNgRHG9tsv6FwPm9eCqR5UpHjwBVj8ew/WqfbiyJMWZRHr
	rN9T/3ezIom3uziODuph92FndDK1jA3KXHlDSTBNXxivWxYaI400XqsijA8ONRmSE3emP/UfzHC
	9saw4WHoJ+dmKSLRkU1822fP84W7wnxCQkRk8DjN3ETvMMmob2PEYtbf8hkoBdb6ApIks4MQKNt
	TyZgOw+br7FEGmz/X8ksffCUVTHVb8GK1aD5kUNf1A2rF/RueVsq81OiYoacEI1ketJveq3jdui
	EgXdxoy+JDZlPAjtvovm47zZopjUoczFYZms8glWs9kreOcyDRPNvhb4jpn/3GMe9rPKfA1Bm3u
	AjFYs1vSH+XUBBw==
X-Google-Smtp-Source: AGHT+IG02N5Y3edvLzg/WYRMS9y/CsAqRcEkmhKjkUGNF7Bn/WzxbIB3ur8dYLHniUlWdlu646e9Dw==
X-Received: by 2002:a17:902:ea0e:b0:22f:b902:fa87 with SMTP id d9443c01a7336-23c6e50f04emr18085015ad.10.1751471524291;
        Wed, 02 Jul 2025 08:52:04 -0700 (PDT)
Received: from JC4TPG1F9W.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f32a3sm130952795ad.87.2025.07.02.08.52.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Jul 2025 08:52:03 -0700 (PDT)
From: Shuan He <heshuan@bytedance.com>
To: bhelgaas@google.com,
	cuiyunhui@bytedance.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	heshuan@bytedance.com,
	sunilvl@ventanamicro.com
Subject: [PATCH] PCI: Fix pci devices double register WARN in the kernel starting process
Date: Wed,  2 Jul 2025 23:51:12 +0800
Message-Id: <20250702155112.40124-2-heshuan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250702155112.40124-1-heshuan@bytedance.com>
References: <20250702155112.40124-1-heshuan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid the double register of pcie device (otherwise a WARNING will
be triggered), two more steps are added in the pci_proc_init function.
1. The pci_rescan_remove_lock is held to prevent the concurrent issue
with pci_bus_add_devices.
2. The PCI_DEV_ADDED bit is added to dev->priv_flags after the device is
successfully registered to procfs.

WARN Trace:
[    0.518993] proc_dir_entry '000c:00/00.0' already registered
[    0.519187] WARNING: CPU: 2 PID: 179 at fs/proc/generic.c:375 proc_register+0xf6/0x180
[    0.519214] [<ffffffff804055a6>] proc_register+0xf6/0x180
[    0.519217] [<ffffffff80405a9e>] proc_create_data+0x3e/0x60
[    0.519220] [<ffffffff80616e44>] pci_proc_attach_device+0x74/0x130
[    0.509991] [<ffffffff805f1af2>] pci_bus_add_device+0x42/0x100
[    0.509997] [<ffffffff805f1c76>] pci_bus_add_devices+0xc6/0x110
[    0.519230] [<ffffffff8066763c>] acpi_pci_root_add+0x54c/0x810
[    0.519233] [<ffffffff8065d206>] acpi_bus_attach+0x196/0x2f0
[    0.519234] [<ffffffff8065d390>] acpi_scan_clear_dep_fn+0x30/0x70
[    0.519236] [<ffffffff800468fa>] process_one_work+0x19a/0x390
[    0.519239] [<ffffffff80047a6e>] worker_thread+0x2be/0x420
[    0.519241] [<ffffffff80050dc4>] kthread+0xc4/0xf0
[    0.519243] [<ffffffff80ad6ad2>] ret_from_fork+0xe/0x1c

Signed-off-by: Shuan He <heshuan@bytedance.com>
---
 drivers/pci/proc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..6506316c8a31 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -468,9 +468,14 @@ static int __init pci_proc_init(void)
 	proc_create_seq("devices", 0, proc_bus_pci_dir,
 		    &proc_bus_pci_devices_op);
 	proc_initialized = 1;
-	for_each_pci_dev(dev)
-		pci_proc_attach_device(dev);
-
+	pci_lock_rescan_remove();
+	for_each_pci_dev(dev) {
+		if (pci_dev_is_added(dev))
+			continue;
+		if (!pci_proc_attach_device(dev))
+			pci_dev_assign_added(dev, true);
+	}
+	pci_unlock_rescan_remove();
 	return 0;
 }
 device_initcall(pci_proc_init);
-- 
2.39.5 (Apple Git-154)


