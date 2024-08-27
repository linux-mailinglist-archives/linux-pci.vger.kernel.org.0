Return-Path: <linux-pci+bounces-12313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D5961800
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F241F21EEC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711551D2F66;
	Tue, 27 Aug 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F9HsNWNv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D681CFEDC
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786939; cv=none; b=ZnNanRKcE+dhbO8I6l9N9EvgxnZCCRTTk4tRiU5S6ZV6/4YyzOxxy4ZigkOcwI+P1/RqlpJxmFdA9DnxgEMYgcn4eisQYZHXtplP/z/4PZWdcYeEM4NBaDKX6sHpToPVz0F8/tpZ+M1TLjcOSLhap+P5A927sKyGK5qEcEUZBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786939; c=relaxed/simple;
	bh=/+XXrLUPIGPlKoUFzFCUJTERaOeZmv7BzsXRN6Gk9WE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lJyXsoAVb+x6cBodg/LbX+kj12YFARin/AHXwA/k4ltYYRupr9pqoyXZ83+u3OgucpJDEpmUXZR39kS9sMC89QCANluqvZBEdJ/yprS0gAyz2zLBCvUUBna3Be0XYI+P55s81RG0NDnChmObd15BgUki3mclC3PtkhcEk6uoVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F9HsNWNv; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RDnVUx017853
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=QYv
	psy9zeDQd10W+yE4akz7XIdSd7SiqQGlm/Dip/o0=; b=F9HsNWNv5kuDb0vLUd3
	t2ZrA19clUtBFrNPcm2xI5QEgevf78WZc8HxwbiXYZG48oZPwNEL7chqFRr2SMLk
	ZRkUswxVCdQXRL1Lan9XYZITsYSzrY9boG3i7B6KZcVgIZFKMcLNIoW8PmYrLc7y
	8wJpz/HJrGRgHYB5meG29603SPRluq3daY1ldtMvRI/i+WRZDW2AVlJ0G7xH3Fc6
	xUD9m79JIo0k5E4p8it5vMncM7PjJlb7EtK0ZWvmVuLLOElhILzViW10GqbSi1J0
	g6MmqmFHCGQ2iTF4VV5Jt+MxoMx0e/X2xMLx/oHjuK7OYvrZo0QHCIcR0p4UtB9Q
	GZg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4193s562hh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:56 -0700 (PDT)
Received: from twshared16760.32.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 27 Aug 2024 19:28:32 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 5C0FE124FD6F9; Tue, 27 Aug 2024 12:28:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/5] pci cleanup/prep patches
Date: Tue, 27 Aug 2024 12:28:21 -0700
Message-ID: <20240827192826.710031-1-kbusch@meta.com>
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
X-Proofpoint-GUID: RATcoKX92MQZQw1WGh0ahb8GIP4LM7m2
X-Proofpoint-ORIG-GUID: RATcoKX92MQZQw1WGh0ahb8GIP4LM7m2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

This is a subset of a previous RFC bus lock patches that are simply good
cleanups that should help make it easier to introduce different locking
later.

Changes from v1:=20

  Added the reviews and some minor commit log changes

  Dropped the more invasive patches for a later time

Keith Busch (5):
  pci: make pci_stop_dev concurrent safe
  pci: make pci_destroy_dev concurrent safe
  pci: move the walk bus lock to where its needed
  pci: walk bus recursively
  pci: unexport pci_walk_bus_locked

 drivers/pci/bus.c    | 49 +++++++++++++++-----------------------------
 drivers/pci/pci.h    | 15 ++++++++++++--
 drivers/pci/remove.c | 20 ++++++++----------
 3 files changed, 38 insertions(+), 46 deletions(-)

--=20
2.43.5


