Return-Path: <linux-pci+bounces-8562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7627F902B4B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 00:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10582B263E8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 22:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DDC37143;
	Mon, 10 Jun 2024 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="epq6f6lR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DCD14D6FF
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057035; cv=none; b=Y+N/4A0lEv7xhlbiflLKQairtN0W3R51AJHO1HVnQuZ+twiOQg6eJvIUCHNL+upnCUQQ3RJxj4f+abNUm3MesSxwi+jtqnty5JGxO2Ucpl8WpFnUJCuPgAGv4Su6/3EylHL8aMpB/RwpQc6sr7naNL7my3zfl3FSTEJq53/I0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057035; c=relaxed/simple;
	bh=19kpE4LJ7lwqGa6y00OBrOrFXe93CbZPXrxtzyUyUfc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=maky0Fd71misx0RbRcoo5j+Mjh7fPRKWBHlBcR3k489dBCvEpTZGQdFBFiD3ZTNMyDMZv6ns89oW9usCHbatHPScK7JM8ozkJfG+9MivlBhXo+MiNtzgkB/OzA0No2OCOBIM5klAPzw/l893ky3s6HoprEvFqmLDqe+S7M3KGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=epq6f6lR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 45AL1KGC013339
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 15:03:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=MdtkHIS7AhW0BixCc+/9jsteQY5oGSj+ScyLRqZ0M48=;
 b=epq6f6lRYrtGOXaj2GyXFaehC4OPh4pqiNOolfG7+oQq0Bcd8xWBvhmRNfiIcwE3DVyh
 b5YzM0xnyLKggySssqFibjcBZLcqZZXhOy2bjhJEkeaTmEIZwv0jueRVHDLf2so329hF
 mJ2FIUxvCmpU1fQ+PvkdgTEVJq132eeZq0RAnbqg5CHldujT88CwGQuHmjCtHxaFwCPT
 Lj8cepJKJE0c2NCOpjQMhw8nGYnLiBxCedawrLCjgdUT18Z41IG48wFDL1/e/LqrG0uP
 PbloSl0wjy7pMWqM3X0fr0kLc5YmlqKk/Og33NXOO91MH7m454wTtR9y6iyW9r4diCGr jg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ymjywc43c-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 15:03:53 -0700
Received: from twshared19013.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 10 Jun 2024 22:03:51 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id BEF52F4E2352; Mon, 10 Jun 2024 15:03:34 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <lukas@wunner.de>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/2] pcie hotplug and error fixes
Date: Mon, 10 Jun 2024 15:03:01 -0700
Message-ID: <20240610220304.3162895-1-kbusch@meta.com>
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
X-Proofpoint-GUID: 14oX6s4fG0ndD8Ub4QOGV5hQYoBeuKTv
X-Proofpoint-ORIG-GUID: 14oX6s4fG0ndD8Ub4QOGV5hQYoBeuKTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_06,2024-06-10_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

I am working with larger pcie topologies again, and we're seeing some
failures when dealing with certain overlapping pcie events.

The topology is essentially this:

  [Root Port] <-> [UpStream Port] <-> [DownStream Port] <-> [End Device]

An error between the DSP and ED triggers DPC. There's only inband
presence detection so it also triggers hotplug. Before the error
handling is completed, though, another error seen by the RP triggers its
own DPC handling.

The concurrent event handling reveals some interesting races, and this
small patchset tries to address these in the low invasive way.

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


