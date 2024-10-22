Return-Path: <linux-pci+bounces-15070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC29AB99D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC121F23D61
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156F1CDFDB;
	Tue, 22 Oct 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Q3PhKiNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE01CDFBC
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637353; cv=none; b=OwQC2/8mRybvL4kfr+qB17Dsg2L9nvxtBbQlOcczMkGjhp+u2x2zOuUQKowNqlQFYz80HebGs7FpkAKC35JhiLOEUiB/UUkc21rcUHuZtCbyyrqvoZ2ZinHEiDXEVsdhY04swfx6iMkJqXALUzp02Xuu1V86e0gu5yliR0WeTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637353; c=relaxed/simple;
	bh=ktrDjWAXMN4WRnmWB2XKC+ppC++wi0k+v2J6WBZa99U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VRATpFtPXziRXbG4ovoi5DKgZXTi/Baj4cFyUfcxW6a7MVzSfeJtS7Jpw2OhPAj6/ZA0fvMsbzZ5wl00/5shUZMyesQpR66bWJGdyK9NSsowFSO0RcsMzNcWtcUrB/uIoqIu8I5fYN4p4ImQJmZ9tFKiThQLtFVMoeD09PCKYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Q3PhKiNU; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49MLZTXr027825
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=Gl99YozvD8cygagpQp
	wJSoJ6tIDOZHnlgfBxiok3MDw=; b=Q3PhKiNU4+MZXIpSdPUECkarRvl1V3TrQG
	MJP92u6wxTe9xOHbVLAy7aIaORO94lDilxUPwxQIspPn+oEr7mUmm0haWXsuOtKa
	W/LNBRV9ohiZySCE4fc7S8x/vyZZkdJPBjpkvUKCFj9nXijKYMVnGVIhWtgzbR9P
	9UuldFGRTdE58HmagFQ8tSgCZrtAj93V1M4h4CKyMq4fcy/XSerFcd9Rsl+yyxjS
	yrINAVr+14LZnAyKlJ3wTz7CFKiZKJwIubOsArZY3tnC2vnHkRTiE+Ak4tmPcy2K
	tdk5yQEBZ177O5yYLkGCjIKXsD02f/WYXA5Th2C1n4U8ivBLFgog==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42em3kgdv6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:10 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 22 Oct 2024 22:49:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7BDC514610C95; Tue, 22 Oct 2024 15:48:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/5] pci cleanup/prep patches 
Date: Tue, 22 Oct 2024 15:48:46 -0700
Message-ID: <20241022224851.340648-1-kbusch@meta.com>
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
X-Proofpoint-GUID: 3blKPHAr4ewmcQb-W0ZbzTR6CrlzD2eZ
X-Proofpoint-ORIG-GUID: 3blKPHAr4ewmcQb-W0ZbzTR6CrlzD2eZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

This is a subset of a previous RFC bus lock patches that are simply good
cleanups that should help make it easier to introduce different locking
later.

Changes from v2:

  Rebased to pci/next

  Added memory barriers around bit ops for patch 1.

  Added reviews.

Keith Busch (5):
  pci: make pci_stop_dev concurrent safe
  pci: make pci_destroy_dev concurrent safe
  pci: move the walk bus lock to where its needed
  pci: walk bus recursively
  pci: unexport pci_walk_bus_locked

 drivers/pci/bus.c    | 49 +++++++++++++++-----------------------------
 drivers/pci/pci.h    | 17 +++++++++++++--
 drivers/pci/remove.c | 22 +++++++++-----------
 3 files changed, 41 insertions(+), 47 deletions(-)

--=20
2.43.5


