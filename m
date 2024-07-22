Return-Path: <linux-pci+bounces-10607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB99391A4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7829F1C21567
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AD516DEDE;
	Mon, 22 Jul 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GrT4Ys07"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188E16DED9
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661619; cv=none; b=imXfuq4bA+g+BGpwkyP3/zZfOAVnZHCGLWG+tcqJCkQ+UUEmiLeisEkN5/OCFg7E/LkKwbJdt85MkCffPFsqvpS0XJCaWUecM7/WjUz35g085zxJcEBrNfFrKKcHVaOTXyyiJHp/vUES7aBxzuSKxwPLTqPnF3llachQkzCAzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661619; c=relaxed/simple;
	bh=Aq/OksakNqDFaeACaCs6GoCEmfoj5GUbioNnpN416kU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dk5fFd+5RNoJ6U0BicXnvI5jaHmgJoX942M32+2LxFeddDuKLHU0fPGhPKkkGsZN/zgkAIk7edjAIFnrAK8aUBtIhmD+bypdAT7nrxeD2d1uuqS5ZTxCw4XeNVcpBBQnGSUvkexC/akhKsMg+ZUpaMGeEjP8v38ZpjHa2+HpZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GrT4Ys07; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MF5tlA032112
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=8b0wf2TfMJnkGFERZwKLjfGHDKzzandulKW6DkEN7j8=; b=
	GrT4Ys078xappEYSeQ4hST0Ir4c/hIUkSSKGxVdv+ip4U3YGobF2Uc0M4rtAsrft
	cTosOPZ7oSbLVb+nPxS8aPdkmouRR2LoQOvhU+JW3a+nCBnclcB+EonWS5+AOtt0
	EzSqq86WzTh1Jg39eNH09TqEz9q0mkFe8p1RvYQZtCiGoS947HH3yEy+Cnc++ZR4
	LIlFt7w2ePlRIioXZWcX6J9vOmHBLicLBFwXNJw18WPd7vJcEiF6m2vorU/g7Yz5
	dUrU2kJ1gf1d9+KVxgpPwwN17Agzlc300k9Z5Ck5H3+eyXs0pjB7+2pp9OaZlLG3
	CR/gZNmGjkwU/3ilgcpiIA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40gabsgd9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:17 -0700 (PDT)
Received: from twshared3252.08.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 15:20:15 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id EFFC410DA2DA6; Mon, 22 Jul 2024 08:20:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>
CC: <mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC 5/8] pci: unexport pci_walk_bus_locked
Date: Mon, 22 Jul 2024 08:19:33 -0700
Message-ID: <20240722151936.1452299-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722151936.1452299-1-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Hm0vXbtog7vr4kwMwaglczbIffd-sHD4
X-Proofpoint-GUID: Hm0vXbtog7vr4kwMwaglczbIffd-sHD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

There's only one user of this, and it's internal, so no need to export
it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index b7208e644c79f..638e79d10bfab 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -435,7 +435,6 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*c=
b)(struct pci_dev *, void *
=20
 	__pci_walk_bus(top, cb, userdata);
 }
-EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
=20
 struct pci_bus *pci_bus_get(struct pci_bus *bus)
 {
--=20
2.43.0


