Return-Path: <linux-pci+bounces-10605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812549391A2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFC31F21265
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD1516D4EF;
	Mon, 22 Jul 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gRw4V5Ln"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F241428F1
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661617; cv=none; b=E7ZnlWhC/fahiPcq32LgJnaTw77upvu2Fa8a8Y8xlZiOcjAQNZRomwDsJwPdkI9WpcHXyWuPHAKgPxZmM8js7Vnew4ATtVAWlXXo7BUrKOGR9JbaxuzP7rClVBgKf91CUmxkBrlNUOvT+vs2H2xWMQ5ZY+5J0CTago8N3lnLLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661617; c=relaxed/simple;
	bh=J7hlY5pTzMhocCVEdLDb7gbkwdGQ5/6Et46UpcmObkw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bAoNJFHxLf/1Q7CKOPDEYGbJlMNeiqLCPzbLnyCJu/HYEod/JaGA9X3PPpCDBXPF9qbpjbEiuAYR94wvRBtw3d01mbZ8UXVTM4eDCaxfvt3uM9HZdCo37u2YNXi5a9C5jU2vQH53znVZOV+fnfxB6avFq3sDXPBEdu4W2DgbgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gRw4V5Ln; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MF5sUk032082
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=FIs
	iSRWOcNTUI874P+VqjYX5OGTgo2W5TGjqCsOlGck=; b=gRw4V5LnmP2uINf1vH3
	R02jV/1phghuTy+2fCHahO7RPIL239M0BV02G6vdjnoJ7KR4m4bC1edO1ZajiElw
	jhyQ8+P8WVhmzMMyVq8i570juW4cc9L7S2pN2CPzJKM0wfHLCqsOoHQWo/cAortI
	+CnhwmP0KmmXq3Iiv+I7uo9O3lnUE7w4nAB8Uq3K97miITKfHk5Fb6A7wMvPHhZi
	QOfgWEK4fzEnDFZAbnZXQVVBg5rYV79P8k/gxKMBE158LNJbTi9OIIDjYgzEf67/
	AuLxo7gsiPZAVPdG3kr972PD5XAo5YUu5vomJToXVx1AaO9IKL9kL+7dA6mW7mZo
	1Nw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40gabsgd8q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:14 -0700 (PDT)
Received: from twshared13822.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 15:20:11 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 13C3A10DA2D9A; Mon, 22 Jul 2024 08:20:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>
CC: <mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC 0/8] pci: rescan/remove locking rework
Date: Mon, 22 Jul 2024 08:19:28 -0700
Message-ID: <20240722151936.1452299-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: TQSSdX4373FCCbav4WzUklv_6JbCL1gs
X-Proofpoint-GUID: TQSSdX4373FCCbav4WzUklv_6JbCL1gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

This patch set targets a subset of pci bus scanning and removals that
were shown to be problematic with deep pci topologies that support
native hotplug. I've tried to capture the common pci components, but
there are definitely many subsystems accessing the topology in their own
way, many of which I can't possibly test, and I have not tried to
convert every user to this new locking scheme. However, if I did this
correctly, they should be no worse off than today!

The earlier patches are just cleanups and/or making it a little easier
to change the locking schemes. The real stuff happens from patches 7 and
8.

I've run this with lockdep enabled, tested concurrent hotplug events on
various x86 platforms with layers of pci switches. That said, as
mentioned earlier, there are many paths to here that I haven't been able
to test, so the final patch might be considered experimental.

Manual concurrent concurrent device removals is still broken. I've sent
a different patch for that here, but it does not sound like it is
acceptable:

  https://lore.kernel.org/linux-pci/20240719185513.3376321-1-kbusch@meta.=
com/T/#u

Keith Busch (8):
  pci: make pci_stop_dev concurrent safe
  pci: make pci_destroy_dev concurrent safe
  pci: move the walk bus lock to where its needed
  pci: walk bus recursively
  pci: unexport pci_walk_bus_locked
  pci: add helpers for stop and remove bus
  pci: reference count subordinate
  pci: use finer grain locking for bus protection

 drivers/pci/bus.c                | 70 ++++++++++++-------------
 drivers/pci/hotplug/pciehp_pci.c | 21 +++++---
 drivers/pci/pci-sysfs.c          |  2 +
 drivers/pci/pci.c                | 31 ++++++++---
 drivers/pci/pci.h                | 16 +++++-
 drivers/pci/pcie/aspm.c          |  7 ++-
 drivers/pci/probe.c              | 16 +++++-
 drivers/pci/remove.c             | 90 +++++++++++++++++++-------------
 include/linux/pci.h              | 11 ++++
 9 files changed, 175 insertions(+), 89 deletions(-)

--=20
2.43.0


