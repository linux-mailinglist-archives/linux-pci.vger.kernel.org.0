Return-Path: <linux-pci+bounces-34943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73DDB38EA0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 00:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4048188AEEF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 22:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A45F2594B4;
	Wed, 27 Aug 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gnzfCXhJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B011DFF0
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334733; cv=none; b=YX+3OaJ7J4lICl+j7Cra1NAe+CYAZlL5qCqTB3XxwfLbcmSY1MNQHewg2lei56Rk+dcqgQDplQz7E5iNOpm3ju6RLvhqNqwIcZ9xUdJiXke/KeuT6XewGwXZuosfKIv0cgy36wBe8SGpxM7JmWQLx9SMqKjqUdHInIPuMczB+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334733; c=relaxed/simple;
	bh=rbv7OEDvUayWnKMyCPIegt4ZhGDHdLs82sfzsaceUwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gCdYVP5srHiaXKe1YFrrgtCA0aO9ZkP86fyOICofUQmSaHsE3DKfETd5idmV5PYjlYAhkdB0uRnYbVZwvIV0goKTtA5bt0Ael823sRRtvTgySuLIcMC3vKW9aoeAXCBcxPOgOwvj7bLKkYkS46+97jrj5ISwFWwb1+vWld6qimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gnzfCXhJ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57RMg2wS3480889
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 15:45:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=DLpczNU/VYNcl79q3j
	OoqB5ASiMjLxFRppcOmcLE53M=; b=gnzfCXhJNYCO5XuTxaKrJvA2P3Av6rOb22
	BW6NDYNSyCS6s0gQEpssYlyolPSnpTp8VU+WWS7Z0rucw35FDP59GWB/F68MuwZE
	oHoC8juQKUGMhe/8SIAkIDbIboSL2APWoB9+QJkiqLYLokPw5JYooM/NugldjS4r
	XZmRKzCyfqctxRh7CdGnLOojUPcEeityVN3x9WEse1jeHcL1gqpE0ciNT2uuiKWm
	BeZX6/Nl/qAaxNGnwSPdRuuoDmgEQa2eRNuHTEsyGeOItGxqJJmwPEHkvFIvqbHn
	Nf/5kKrKYo1jfg6kOPNXGGnfrZE1ZDGpMKWSWvpMNEtw0PxdSkLg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48t7v69gyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 15:45:30 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 22:45:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 99223110C82C; Wed, 27 Aug 2025 15:45:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] pciehp: sync interrupts for bus resets
Date: Wed, 27 Aug 2025 15:45:14 -0700
Message-ID: <20250827224514.3162098-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDE5MyBTYWx0ZWRfX7L6UPsT/EBPe
 Y6uRj0H6rWS56Kt1huf7t0wHG4hkBopCdiGWLHvbLn4SEP7YIHe6KijhoDok8T4P+KePwVQXQdy
 JO8BGceW8+0gQ0gmwUlmyApqkrC1kbjfvuq8kjCIhA4rtraNUlflhbEHGUS/KbeZwEu0+YxApWh
 oRgSUdWELgUZA0YgxBH2oAyhVIFPRb9tVU7UgiRmW97t6UtpOWAWeqZmA2BGyPs1QC31SLykvOO
 GWjmnpmaA3vstqT9SIKoNtaEw0a5v8nForLJjq3M3elZJhzV8M61p92smiRtjGLxPjV4iu7Qyms
 5ymc3o31xJHG9xqumWt1WXuP0OfLBgVJd6xnvldRYzLXTGKk138Mkyaz+7aCG4=
X-Proofpoint-GUID: JLQU-TEsY765umDs5bnbGSXh51pD89I4
X-Authority-Analysis: v=2.4 cv=ZvftK87G c=1 sm=1 tr=0 ts=68af8a8a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=BGqQOGafl0B8s3g6XfIA:9
X-Proofpoint-ORIG-GUID: JLQU-TEsY765umDs5bnbGSXh51pD89I4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Synchronize the interrupt to ensure the reset isn't going to disrupt a
previously pending handler from igoring the reset's link flap. Back to
back secondary bus resets create a window when the previous reset
proceeds with DLLLA, waking the pending pciehp interrupt thread, but the
subsequent reset tears it down while the irq thread tries to confirm the
link is active, triggering unexpected re-enumeration.

Fixes: bbf10cd686835d5 ("PCI: pciehp: Ignore belated Presence Detect Chan=
ged caused by DPC")
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
index bcc51b26d03d5..f27ff20a3c34c 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -946,6 +946,7 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_sl=
ot, bool probe)
=20
 	down_write_nested(&ctrl->reset_lock, ctrl->depth);
=20
+	synchronize_irq(ctrl->pcie->irq);
 	pci_hp_ignore_link_change(pdev);
=20
 	rc =3D pci_bridge_secondary_bus_reset(ctrl->pcie->port);
--=20
2.47.3


