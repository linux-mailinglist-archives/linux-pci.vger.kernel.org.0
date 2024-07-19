Return-Path: <linux-pci+bounces-10556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D30937CC3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 20:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C51F21AF8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32439148312;
	Fri, 19 Jul 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bHktcfR7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14B147C9E
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415334; cv=none; b=BZsYuBHbdgv/mLP3qzX78HGQjQ+1o4UnFkFkRAEaMF4nN5G4TLDKkxBBshQJ42sOMWVmPdvYEoNvdavinqOtvkKjbSp9ykcJ3zRcC0eBgM977lGf0+y2JTNS/GYzgfdz/rsFs0NG7hMiqEv6s+8Gq9a5q/jnJbLQ7mIoh3inFAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415334; c=relaxed/simple;
	bh=wvhd2VtiNOSeuDibRrvVGvjkFKF3iUYnjosFyuZVcAo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZdqU9ltjCpjda3rAz8AAhZQvAWfJeHOOE0CCnuWpVVauLwzywvZJHRtvYFOEuinQ7G/F/N6CEwN6LAR+5ZzxCD24ZlkGoKGpKSJxs+5QsCsRjmXQ6mguNkKAZWrZgxzK1F/0pQFArnDLL7iB9DxmUTUkjuuE6ICuhYZwfeNILx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bHktcfR7; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JHreFx004964
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 11:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=rUa
	+Zl4xZvN76o/06tV6A9G8zIhRPAtjCjt0Y6JLuPk=; b=bHktcfR7EGSFibbNAqt
	1QJirBD+MgpcLONZs7QQpFRSYBYKkqm9da7LtwnvnejbAwBRJv0tNr4EAx62MKxF
	DZLqKlYYh/GRj+VpifSkSto3TNRR+ztlT8syMbSi9l3PaTn++r8FU/sdbaY3TqTT
	VM5jmJ4topddEgyyTpTeR8FY5+0SAVhAIJ1KW2xfE2JcoVMKsPBdkSyI9YfJPRXm
	bUsMe63e2PznQAlRm68JWn/NbyQHZ+o4y29o6cc1IUHyqyn5kpd1ye8vstCf3DoL
	GzMPnSHed3WfIwU6PgTa0oIY1QEgXodcljoKIszYkeVp/1zhiCrTyheYP5Xwvoc7
	IAA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40fvxq8ct8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 11:55:30 -0700 (PDT)
Received: from twshared18280.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 19 Jul 2024 18:55:28 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 28DEB10BF817E; Fri, 19 Jul 2024 11:55:15 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH] driver core: get kobject ref when accessing dev_attrs
Date: Fri, 19 Jul 2024 11:55:13 -0700
Message-ID: <20240719185513.3376321-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YL0HZ_TXvbOPXgP0UXaIK33aYqrdVzO8
X-Proofpoint-ORIG-GUID: YL0HZ_TXvbOPXgP0UXaIK33aYqrdVzO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

Get a reference to the device's kobject while storing and showing device
attributes so that the device is valid for the lifetime of the sysfs acce=
ss.
Without this, the device may be released and use-after-free will occur.

This is an easy problem to recreate with pci switches. Basic topology on =
a my
qemu test machine:

-[0000:00]-+-00.0  Intel Corporation 82G33/G31/P35/P31 Express DRAM Contr=
oller
           +-01.0-[01-04]----00.0-[02-04]--+-00.0-[03]--
                                           \-01.0-[04]----00.0  Red Hat, =
Inc. Virtio block device

Simultaneously remove devices 04:00.0 and 01:00.0 and you'll hit it:

 # echo 1 > /sys/bus/pci/devices/0000\:04\:00.0/remove &
 # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove

 Oops: general protection fault, probably for non-canonical address 0x6b6=
b6b6b6b6b6b9b: 0000 [#1] PREEMPT SMP PTI
 CPU: 9 PID: 359 Comm: bash Not tainted 6.10.0-rc1-00183-gea4516b2b250 #2=
56
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-14-g=
1e1da7a96300-prebuilt.qemu.org 04/01/2014
 RIP: 0010:pci_stop_bus_device+0x15/0x90
 Code: 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f =
1f 44 00 00 41 54 55 48 89 fd 53 4c 8b 67 18 4d 85 e4 74 2d <49> 8b 7c 24=
 30 49 83 c4 28 4c 39 e7 74 1f 48 8b 5f 08 e8 d4 ff ff
 RSP: 0018:ffffc90000b67dd0 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: ffff88800768c0c8 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffffff8365bc00 RDI: ffff88800768c000
 RBP: ffff88800768c000 R08: 0000000000000000 R09: 0000000000000000
 R10: ffffc90000b67df0 R11: 0000000000000003 R12: 6b6b6b6b6b6b6b6b
 R13: ffffc90000b67e90 R14: ffff8880075bccc8 R15: ffff88801082a620
 FS:  00007fe0c951e740(0000) GS:ffff88803ea80000(0000) knlGS:000000000000=
0000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000560aaac4b030 CR3: 00000000108ae004 CR4: 0000000000770ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? die_addr+0x37/0x90
  ? exc_general_protection+0x1e5/0x430
  ? asm_exc_general_protection+0x26/0x30
  ? pci_stop_bus_device+0x15/0x90
  pci_stop_and_remove_bus_device_locked+0x1a/0x30
  remove_store+0x7d/0x90
  kernfs_fop_write_iter+0x13c/0x200
  vfs_write+0x359/0x510
  ksys_write+0x69/0xf0
  do_syscall_64+0x68/0x140
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/base/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 131d96c6090be..108f2aa6eaaa9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2433,12 +2433,15 @@ static ssize_t dev_attr_show(struct kobject *kobj=
, struct attribute *attr,
 	struct device *dev =3D kobj_to_dev(kobj);
 	ssize_t ret =3D -EIO;
=20
+	if (!kobject_get_unless_zero(kobj))
+		return -ENXIO;
 	if (dev_attr->show)
 		ret =3D dev_attr->show(dev, dev_attr, buf);
 	if (ret >=3D (ssize_t)PAGE_SIZE) {
 		printk("dev_attr_show: %pS returned bad count\n",
 				dev_attr->show);
 	}
+	kobject_put(kobj);
 	return ret;
 }
=20
@@ -2449,8 +2452,11 @@ static ssize_t dev_attr_store(struct kobject *kobj=
, struct attribute *attr,
 	struct device *dev =3D kobj_to_dev(kobj);
 	ssize_t ret =3D -EIO;
=20
+	if (!kobject_get_unless_zero(kobj))
+		return -ENXIO;
 	if (dev_attr->store)
 		ret =3D dev_attr->store(dev, dev_attr, buf, count);
+	kobject_put(kobj);
 	return ret;
 }
=20
--=20
2.43.0


