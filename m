Return-Path: <linux-pci+bounces-8687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13387905B29
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6871F22445
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F6961674;
	Wed, 12 Jun 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cK020B3c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2925FB9B
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217440; cv=none; b=P1E0DfNabxHbpp1R6BPj8IzaKEPIxLyBYrd1V+M9PnMs30VPBPonmm8wUamEJjFCJsFmXa5C9l8ZW/BV7yfPCQMXKBT+g2ra/ysJ+GbcBplzfSW8MUGFE2LSFqiCz52sEWU/8RtWL5LJyte/N6ZtYRd0KfkL3WsleDpZIuet8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217440; c=relaxed/simple;
	bh=4EBHqAxy5eCF5IRX5nVf1m0eQyTiWpFPGAIrZ37kmzQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=scYCAEU58y+VJGkOY9fdttuB44bYJiZ49srDukjFR9wBY2U1WEMMu0GAgj7B7YXBZ3YQfx0I2LiGrIjlf6QLEM69LQnhB3W3BxQuheFdp1DNmrU0aNljV9VVRrq8TjvOFptmLz/QfCWuSN0aIiC6j9ZxlqIr7/kIloUOKcN84SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cK020B3c; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45CHv5H2021936
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 11:37:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=7e/Ke2u6sTB5fa2kQWQnX5KXkbS3W0FYIu39MwvgQOk=;
 b=cK020B3cfLb2HD14iNpSBkm+y5Mt3SKZCvaRz1RNmhLepYZckKMYRKiFVAXoEpuW6cuN
 uxCbXk+nF7SD7R5PcUc6DS1ZDYgcPQk8SNwXo2wVZCEQRlU+tB3YWv9UMu9L+5LnXX5f
 b0TqluRIm3qu6w3Zpt5dQSfrK9OKA9tMNnQRCB3nUS/cw906xyPk1lY8Y3Tspmk4HyiL
 zi3selR7rNbWzxhbRYLHvgXgilVRCi0ElldchHix00pI+ocCtRW6fGNKUzbGBGSBXNVO
 82h06yphbgBaVZcrvF+Pl7Yl/wUzGM2IbTwcIGnjh7VNQuBGxF2f5Xir9Cw1WMsjg86d jw== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ypm8wu6qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 11:37:17 -0700
Received: from twshared23916.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 12 Jun 2024 18:37:17 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0E42AF5FC61B; Wed, 12 Jun 2024 11:16:30 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <lukas@wunner.de>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] pcie hotplug and error fixes
Date: Wed, 12 Jun 2024 11:16:23 -0700
Message-ID: <20240612181625.3604512-1-kbusch@meta.com>
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
X-Proofpoint-GUID: _f9morF9jqwUZ3v0TKaiib6R1-Jd5w9b
X-Proofpoint-ORIG-GUID: _f9morF9jqwUZ3v0TKaiib6R1-Jd5w9b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_09,2024-06-12_02,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

We' failures when dealing with certain overlapping pcie events. The
topology is essentially this:

  [Root Port] <-> [UpStream Port] <-> [DownStream Port] <-> [End Device]

An error between the DSP and ED triggers DPC. There's only inband
presence detection so it also triggers hotplug. Before the error
handling is completed, though, another error seen by the RP triggers its
own DPC handling.

The concurrent event handling reveals some interesting races, and this
patchset tries to address these without fundamentally changing the
locking scheme.

v1->v2:

  Fixed compiler error for !CONFIG_PCI (lkp)

Keith Busch (2):
  PCI: pciehp: fix concurrent sub-tree removal deadlock
  PCI: err: ensure stable topology during handling

 drivers/pci/hotplug/pciehp_pci.c | 12 +++++++++---
 drivers/pci/pci.h                |  1 +
 drivers/pci/pcie/err.c           |  8 +++++++-
 drivers/pci/probe.c              | 24 ++++++++++++++++++++++++
 include/linux/pci.h              |  2 ++
 5 files changed, 43 insertions(+), 4 deletions(-)

--=20
2.43.0


