Return-Path: <linux-pci+bounces-21754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA719A3A346
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD673A6B4D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB926F459;
	Tue, 18 Feb 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ADU7NDKf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05713B7B3
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897696; cv=none; b=XsuYIiSAvkgwqpHftxc6iSvt9ulvIHHSr2MVOyTBc+fUou24WvlvDJYdQuyA7tCdaAonlzXWrHK8voMmDLR+/XP+xi4zrutC39hYSy17xR6dWE0bS4rtBn1elDDNB1unIXwhreajvmzaeI2pbSl25cxsBi4ZsGYjsSreA3ENqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897696; c=relaxed/simple;
	bh=/gfnpCwzco0kYRSRjLioSIVGN3zvvaSZ5nsd5ix6tpE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DeJILpWvezzLnsYSFmKuDXsm7wRA0SYxk6XPpIwMjZnYDzbe2O/OMIjQ7aoTOBXAXm/1zERrpWxpUQtTXwTSbSPYDOYFIO9i68+ci+4ZSscESImGQutb0U/eeTBUzUezAwJBBkdSryNoTXhxvOBomVlb+cKLNRnv+284K3Xu6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ADU7NDKf; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 51IFuYuc003173
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 08:54:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=QAiWA5YCGjtWyq8wuq
	oxqVW4BNAVD6zB9qMqX4+m2lc=; b=ADU7NDKfAqMdpHsO524vnftD6UkKpNtzEg
	y2Sz3/Ka2S/w98HoLjTgHorvhwLeo6BfCMP8NKNUw6pbZxZftLKMRsx8qpHZ/t9q
	/QGNzILRU2Qg5q+eQQwyLxL0QmUofKWeh+PjCbe7GK0dlsIssZTDqoKQrjhqLYkw
	ZEz3tB6m3f51BQ/3e6KWz3WVv3Q/FdSe+VowxfCJ+rq6yTFUuYPS4PiXP+9ZCscD
	59gXa4Gvk3ny3L84iw8cnKh2VpmIZzbRxVabJbWgYvB125wAzDAvnVsxaV+oJ4ui
	o/7qgXPMGb8tkFvUBxYLPgEqsZzBrMsOcLR8zaxyGgZAL3VUIVrQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 44vvdsgx4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 08:54:53 -0800 (PST)
Received: from twshared3076.40.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 18 Feb 2025 16:54:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 4EC24182CD338; Tue, 18 Feb 2025 08:54:45 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <ilpo.jarvinen@linux.intel.com>, <lukas@wunner.de>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2] pci: allow user specifiy a reset poll timeout
Date: Tue, 18 Feb 2025 08:54:44 -0800
Message-ID: <20250218165444.2406119-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IkRdcv0Cz96-HPw5tDVNcz9xjshPZrAG
X-Proofpoint-ORIG-GUID: IkRdcv0Cz96-HPw5tDVNcz9xjshPZrAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

The spec does not provide any upper limit to how long a device may
return Request Retry Status. It just says "Some devices require a
lengthy self-initialization sequence to complete". The kernel
arbitrarily chose 60 seconds since that really ought to be enough. But
there are devices where this turns out not to be enough.

Since any timeout choice would be arbitrary, and 60 seconds is generally
more than enough for the majority of hardware, let's make this a
parameter so an admin can adjust it specifically to their needs if the
default timeout isn't appropriate.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  The user interface is in seconds granularity just to be more user
  friendly. I don't think anyone needs millisecond granularity here.
  This also required clamping the value to prevent any possible overflow
  from bad user values.

  Replaced the macro aliasing the kernel param variable to just directly
  use the param variable. The variable is also renamed to match the
  define that it's replacing.

 .../admin-guide/kernel-parameters.txt          |  3 +++
 drivers/pci/pci.c                              | 18 ++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index fb8752b42ec85..148d0f37b6594 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4843,6 +4843,9 @@
=20
 				Note: this may remove isolation between devices
 				and may put more devices in an IOMMU group.
+		reset_wait=3Dnn	The number of seconds to wait after a reset
+				while seeing Request Retry Status.  Default is
+				60 (1 minute).
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a37..b0ee84b90a22e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -75,7 +75,7 @@ struct pci_pme_device {
  * limit, but 60 sec ought to be enough for any device to become
  * responsive.
  */
-#define PCIE_RESET_READY_POLL_MS 60000 /* msec */
+static int pci_reset_ready_poll_ms =3D 60000;
=20
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
@@ -4549,7 +4549,7 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
=20
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "FLR", pci_reset_ready_poll_ms);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
=20
@@ -4616,7 +4616,7 @@ static int pci_af_flr(struct pci_dev *dev, bool pro=
be)
 	 */
 	msleep(100);
=20
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "AF_FLR", pci_reset_ready_poll_ms);
 }
=20
 /**
@@ -4661,7 +4661,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool p=
robe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
=20
-	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, "PM D3hot->D0", pci_reset_ready_poll_ms);
 }
=20
 /**
@@ -4928,7 +4928,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_de=
v *dev, char *reset_type)
 			return -ENOTTY;
=20
 		return pci_dev_wait(child, reset_type,
-				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
+				    pci_reset_ready_poll_ms - PCI_RESET_WAIT);
 	}
=20
 	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
@@ -4940,7 +4940,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_de=
v *dev, char *reset_type)
 	}
=20
 	return pci_dev_wait(child, reset_type,
-			    PCIE_RESET_READY_POLL_MS - delay);
+			    pci_reset_ready_poll_ms - delay);
 }
=20
 void pci_reset_secondary_bus(struct pci_dev *dev)
@@ -6841,6 +6841,12 @@ static int __init pci_setup(char *str)
 				disable_acs_redir_param =3D str + 18;
 			} else if (!strncmp(str, "config_acs=3D", 11)) {
 				config_acs_param =3D str + 11;
+			} else if (!strncmp(str, "reset_wait=3D", 11)) {
+				unsigned long val;
+
+				val =3D clamp(simple_strtoul(str + 11, &str, 0),
+					    1, INT_MAX / MSEC_PER_SEC);
+				pci_reset_ready_poll_ms =3D val * MSEC_PER_SEC;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
--=20
2.43.5


