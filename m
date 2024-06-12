Return-Path: <linux-pci+bounces-8681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C45905A71
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B250F1C21ADF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD8D1822E4;
	Wed, 12 Jun 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HfTDW8az"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766E16E895
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215841; cv=none; b=Zs8CSRAp6jC+Y0HLs0aieVaI44NSqsGvdaYeG240RM4GVG12UL2oTaxqxKv0dV3KMXSSB0RmXgdJDBGw9QHwFJejopbgWOXbpsSL9D+kS4xwnWdDvgVpU04PZeJP8rzFfKs9BUAvlLVHHn6t+kzvFHGXReLLz6JQiOeTXsqW9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215841; c=relaxed/simple;
	bh=19kpE4LJ7lwqGa6y00OBrOrFXe93CbZPXrxtzyUyUfc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=psiieHLpmcQXz1IrQl1AneDCEkDxh+bRpvvr16kH9/sj+0cHlG0Z5UFpAsar6kZKqJN1gEKRU6bElvD6piBNnEf7J8fiq8Bni02Z4gERHuJv7Tf/PpvbY5crWNMWE2aFcloDtiJfYfkYgpSSAMfH8HrSEioZToOeFC5X83Z6ggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HfTDW8az; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45CHv3HZ021809
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 11:10:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=MdtkHIS7AhW0BixCc+/9jsteQY5oGSj+ScyLRqZ0M48=;
 b=HfTDW8azZ60VQzbknMmf3qGCwzAK/ELaiDg1w0sAC/4M+TzcgoUcxHME3gjjCnk4GmBM
 uQbrmDwci93LFZ6qguCCfLEyqQhbVKwLb4RMa5C7KUwC7YV/PvD8Gw4fFMRKbA/2tKu0
 gncoXysbsru//u4HhN1PLboTTta846wUJpkWVCPcU5XwoZKSN4J70MZbDW7WSSc39icZ
 MOM4AIL5juR9Fe3lXHLQT/RsVRL+NpPJN4BwgiKX1pt3AFN6PHg6vH5PUrvNQ+IOeilB
 8kZ3HOXcb4kh2lW20Y0/bkmaZ5ELivNMPtt7ZWCOATmPjQSLpd7GLdyl5pV6DJmIl3LI ag== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ypm8wu0qj-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 11:10:38 -0700
Received: from twshared53332.38.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 12 Jun 2024 18:10:37 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E9917F5FBC40; Wed, 12 Jun 2024 11:10:25 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <lukas@wunner.de>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/2] pcie hotplug and error fixes
Date: Wed, 12 Jun 2024 11:10:22 -0700
Message-ID: <20240612181024.3577119-1-kbusch@meta.com>
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
X-Proofpoint-GUID: rA4fWx4drcsb9OKr-lnAetL278c85E_S
X-Proofpoint-ORIG-GUID: rA4fWx4drcsb9OKr-lnAetL278c85E_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_09,2024-06-12_02,2024-05-17_01

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


