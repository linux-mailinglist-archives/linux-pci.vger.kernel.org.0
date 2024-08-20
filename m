Return-Path: <linux-pci+bounces-11883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A0A95887F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 16:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685AC284BBC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1A1917D6;
	Tue, 20 Aug 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C44z1zFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BC1917F1;
	Tue, 20 Aug 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162709; cv=none; b=HyJfAstbVzMmxeb2W6PkcQt5G+7CBM2pohPsaUIPLF7u5Qs8YRlrtlLGLBjNSp/sgaK+pYilk8WNFQa+cwD7dLaq4og2faYC8LIpFRhoB+6xSD5l+iRBm+HKj24lN/ydgjl0yomOplqzthurNKu6ikMrJkf7EwQMUDScOqs4T+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162709; c=relaxed/simple;
	bh=GY1Zzrx7cTTeDwEgR46i0zevjI7E6ZV8mQxL73UdiPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T8QbXC7nZhu8/qciZEKvK+oZQw2mIYYWQijTzig2TQr+cxhD5to0WFboyO6DmLoq4oBV+MH6ixbtU7qo5Ovgo0DtlmN4ktdk7yWZeySuuLriPPmuqyb3CnNimSTfvUc5aNsgn42ITvEiNTBsE/6DoaGao/wgKyLdX+WCKRvUBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C44z1zFQ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3eabcd293so10682081fa.2;
        Tue, 20 Aug 2024 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724162705; x=1724767505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EpVsKFQ5NF4ow0WMsc/fFRx9SO54pTzDAAtSk8M82To=;
        b=C44z1zFQH9yaDM+HCDJMLeduhx82OSuxd/9uq45ll57mED2k87IMhBB/LnyCYhyP2p
         /H2Oz9j4Mc97AW36j2ceZvrFAQsW5bmizhSwWbuNOmk78WjaoJA/PwcRI/LrC5o3F2Ea
         UONWBzTGf7KAjFnfYyqZI82VTmHtNtWhnqm2Hp84CKCk1kmP1r55QvWC724p0Q6bLRTS
         35OtAyE6TVWD3YKJ0ar55nqebJccEis+13OwTilWCqoI8NtPyTfTHKA+yGMuKOICuDGk
         gO1SWM0eGi3AA8+a9ZrH3HApi4Gqz7oZOzShHcYTbeajst39hNNX2ZHPmr0f48jIemOo
         UlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724162705; x=1724767505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpVsKFQ5NF4ow0WMsc/fFRx9SO54pTzDAAtSk8M82To=;
        b=mKm3PRPdrDbXvJ0uRLJcz7nb9sM/x2PF7GV9XRy2dtbHqDwLJEg0FrR60XH/bQp4Ua
         TKvR1zuGLpDriqVwkyXTtBcsiGl7q4Qpm4U++diXEyT3XJjc87lex6+Rg2jVenvfQs07
         MegT00ajvRfHo16FdaJU4RWMdyTekqxCexDVcKhRM7mqGm+632d60o/By7vJARWEf5RQ
         P1QVXglb7bBDt6GqCYeA5rZZRM5NINqr5ZNG7x97OeFtbYy+cjnV7OBi+PX6gMUga2tL
         n5ZlWdFArdKMVEtw5ShivVr9/BQdnYODtdY5s9KhJQ7LcFGe+KqTBN60YE8ufnDvNOvc
         EsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV3KTuEdwFK1hDhOJL2WYvk+njDVmIzOR3qr8KoF0uwzpD0HLkbi5VKTs/SQsZsMbBuHXJJ1jNKLuK9ZgbkafxYcZA3Z/Gm+JI5iiBEw3Xe9wasIvCIcLagyi4V+86MSz0+h9+dNGz
X-Gm-Message-State: AOJu0YxDMMpHN9Kg70RRd31z7Gf5DfbIEO1LGgGFoeUbfAVMc55o6/97
	U06L7/Z+z7Md9bzjUGdaqavJtcISLj9R1GkD82rskeknau5nAy6Rb9ifLupf
X-Google-Smtp-Source: AGHT+IFY1TsBmitACLqYyEqO/YS03tngiajm+rIfQ7sMYhGmY0hDJjdKGRTr8cL35/r6R0VF/c0Rgg==
X-Received: by 2002:a05:651c:544:b0:2f1:a7f8:810f with SMTP id 38308e7fff4ca-2f3be5de18cmr100618031fa.36.1724162704707;
        Tue, 20 Aug 2024 07:05:04 -0700 (PDT)
Received: from SP-RaptorLake.dyn.int.numascale.com (fwa5c9b-54.bb.online.no. [88.92.155.54])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2f3b77039ffsm17908081fa.77.2024.08.20.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:05:04 -0700 (PDT)
From: Steffen Persvold <spersvold@gmail.com>
To: Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: spersvold@gmail.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: host-generic: Fix NULL pointer dereference on 32-bit CAM systems
Date: Tue, 20 Aug 2024 16:04:23 +0200
Message-Id: <20240820140423.29410-1-spersvold@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAM (legacy) host drivers also need to refer to pci_ecam_add_bus and
pci_ecam_remove_bus functions to get mapped resources on 32-bit systems.
This is because 32-bit systems have separate iomap resources per bus
segment and pci_ecam_add_bus is the one that sets that up. Move the
pci_ecam_ops for CAM mode to ecam.c so we can refer the static functions.

This fixes :

[    1.356001] pci-host-generic 30000000.pci: host bridge /soc/pci@30000000 ranges:
[    1.365324] pci-host-generic 30000000.pci:      MEM 0x0040000000..0x004fffffff -> 0x0040000000
[    1.375556] pci-host-generic 30000000.pci:      MEM 0x0050000000..0x006fffffff -> 0x0050000000
[    1.386132] pci-host-generic 30000000.pci: ECAM at [mem 0x30000000-0x30ffffff] for [bus 00-ff]
[    1.399490] pci-host-generic 30000000.pci: PCI host bridge to bus 0000:00
[    1.407073] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.413648] pci_bus 0000:00: root bus resource [mem 0x40000000-0x4fffffff]
[    1.421718] pci_bus 0000:00: root bus resource [mem 0x50000000-0x6fffffff pref]
[    1.430647] Unable to handle kernel NULL pointer dereference at virtual address 00000800
[    1.439441] Oops [#1]
[    1.442152] CPU: 0 PID: 1 Comm: swapper Not tainted 6.9.7+ #43
[    1.448753] Hardware name: Digilent Nexys-Video-A7 RV32 (DT)
[    1.454968] epc : pci_generic_config_read+0x40/0xb0
[    1.460652]  ra : pci_generic_config_read+0x2c/0xb0
[    1.466322] epc : c038db9c ra : c038db88 sp : c1c3bc20
[    1.472095]  gp : c18726d0 tp : c1c5c000 t0 : 0000006e
[    1.477859]  t1 : 00000063 t2 : 00000000 s0 : c1c3bc30
[    1.483604]  s1 : 00000004 a0 : 00000800 a1 : 00000800
[    1.489348]  a2 : 00000000 a3 : 00000008 a4 : c1d15800
[    1.495090]  a5 : 00000002 a6 : 0000008a a7 : c1809ec0
[    1.500844]  s2 : c1c3bc38 s3 : 0000ea60 s4 : 00000008
[    1.506600]  s5 : c1ce4a00 s6 : 00000006 s7 : c11c7460
[    1.512353]  s8 : 00000008 s9 : c0800108 s10: 00000000
[    1.518095]  s11: 00000000 t3 : 3ffff7ff t4 : 00000000
[    1.523833]  t5 : 00000001 t6 : 00000000
[    1.528252] status: 00000100 badaddr: 00000800 cause: 0000000d
[    1.534729] [<c038db9c>] pci_generic_config_read+0x40/0xb0
[    1.541096] [<c038da04>] pci_bus_read_config_dword+0x50/0xb0
[    1.547623] [<c0391e94>] pci_bus_generic_read_dev_vendor_id+0x3c/0x1ec
[    1.555010] [<c039245c>] pci_scan_single_device+0xa4/0x11c
[    1.561273] [<c0392570>] pci_scan_slot+0x9c/0x23c
[    1.566716] [<c039388c>] pci_scan_child_bus_extend+0x58/0x2f4
[    1.573275] [<c0393db0>] pci_scan_root_bus_bridge+0x64/0xe8
[    1.579650] [<c0393e54>] pci_host_probe+0x20/0xc8
[    1.585104] [<c03bc6f4>] pci_host_common_probe+0x144/0x1e4
[    1.591396] [<c042ec20>] platform_probe+0x54/0x9c
[    1.596957] [<c042b5c8>] really_probe+0xbc/0x418
[    1.602367] [<c042bb0c>] __driver_probe_device+0x70/0xfc
[    1.608507] [<c042bbe0>] driver_probe_device+0x48/0xf0
[    1.614487] [<c042be98>] __driver_attach+0xbc/0x264
[    1.620190] [<c0428d04>] bus_for_each_dev+0x84/0xf8
[    1.625868] [<c042aeec>] driver_attach+0x28/0x38
[    1.631269] [<c042a510>] bus_add_driver+0x140/0x278
[    1.636956] [<c042cf48>] driver_register+0x70/0x15c
[    1.642666] [<c042e8f8>] __platform_driver_register+0x28/0x38
[    1.649332] [<c081b694>] gen_pci_driver_init+0x24/0x34
[    1.655241] [<c0801424>] do_one_initcall+0x88/0x164
[    1.660943] [<c0801768>] kernel_init_freeable+0x1dc/0x264
[    1.667199] [<c0699f34>] kernel_init+0x28/0x138
[    1.672578] [<c06a0b5c>] ret_from_fork+0x14/0x24
[    1.678399] Code: 0463 0605 0793 0010 8663 04f4 0793 0020 8663 02f4 (2503) 0005
[    1.686462] ---[ end trace 0000000000000000 ]---
[    1.691591] Kernel panic - not syncing: Fatal exception

Signed-off-by: Steffen Persvold <spersvold@gmail.com>
---
 drivers/pci/controller/pci-host-generic.c | 11 +----------
 drivers/pci/ecam.c                        | 13 +++++++++++++
 include/linux/pci-ecam.h                  |  3 +++
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index 41cb6a05..3b7da1c3 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -14,15 +14,6 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
-static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
-	.bus_shift	= 16,
-	.pci_ops	= {
-		.map_bus	= pci_ecam_map_bus,
-		.read		= pci_generic_config_read,
-		.write		= pci_generic_config_write,
-	}
-};
-
 static bool pci_dw_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct pci_config_window *cfg = bus->sysdata;
@@ -58,7 +49,7 @@ static const struct pci_ecam_ops pci_dw_ecam_bus_ops = {
 
 static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-cam-generic",
-	  .data = &gen_pci_cfg_cam_bus_ops },
+	  .data = &pci_generic_cam_ops },
 
 	{ .compatible = "pci-host-ecam-generic",
 	  .data = &pci_generic_ecam_ops },
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 1c40d250..97430664 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -208,6 +208,19 @@ const struct pci_ecam_ops pci_generic_ecam_ops = {
 };
 EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
 
+/* CAM ops */
+const struct pci_ecam_ops pci_generic_cam_ops = {
+	.bus_shift	= 16,
+	.pci_ops	= {
+		.add_bus	= pci_ecam_add_bus,
+		.remove_bus	= pci_ecam_remove_bus,
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
+EXPORT_SYMBOL_GPL(pci_generic_cam_ops);
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 /* ECAM ops for 32-bit access only (non-compliant) */
 const struct pci_ecam_ops pci_32b_ops = {
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 3a4860bd..7ebec8ce 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -77,6 +77,9 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 /* default ECAM ops */
 extern const struct pci_ecam_ops pci_generic_ecam_ops;
 
+/* default CAM ops */
+extern const struct pci_ecam_ops pci_generic_cam_ops;
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
 extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only */
-- 
2.40.1


