Return-Path: <linux-pci+bounces-15072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB929AB9A1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15A8B23AB0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225381CDFB9;
	Tue, 22 Oct 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Hp56XrPP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A01CEE8A
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637358; cv=none; b=jm9r+ZGjoEMQqEXtGaovpLNKnsWE1akTUZqosK5Y3IfhEMkpb6AE1ppubCFP72Gwb0EUdxuVsL/lsMlzV00iOZb3zzzXna55TTaY7BrV8GOrxamtmeiozzbEBvVlEDIcbL5EwSkZ17wQ9Nn4DV9UZGMHZtHZP1ZPto6aWzNUHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637358; c=relaxed/simple;
	bh=IypPAGyFtGRj0Hz4ryPlIxZLtVZFLChHM+CpWAnC10k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cbqhk8zDS311a44K2gfqyr40mj4o5bMmII9ehpU8HsRT5yVwjb6mTF/xIqmWY0XJTYUOBBrDSd8XMw097c2iUmier3vIwbAL1p1KKUcvP+pUzf1v2wAJwjYW3GrSIAZ9sJgCsnzeDD9a9zFQtMbmNBlCObijTp7rq4EEkk19qCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Hp56XrPP; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLYUat013198
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=feAYGlWcbNhzQOhHTlCxYj6AKWRGMHrwIGF1wygblmY=; b=Hp56XrPPQl7R
	SnSXXrPgLG5+mEwUrOXK6nC16mBGQFeMZFq7oWb/E/eXtQKyzw0IexfflR/UeyoN
	UNlK/J7IGUj9u3kin1ZVBEEqzmYeM23NHoxxzfViV6LV/ilbcCu+kuIBTeDAVLLn
	STGF44jlroYDLVLgA19fGT9gmOdsqlBNcro7SLfmz7+JPQAYWVx4X5QfbesAUxM0
	0j23dx2gP1Xct1vGsi9FIjvmYNSeZlvWsfrR0KPkUbxJJzRiFLPMSaCB5EnrWAGu
	eO5x0/AKb58q6/yWzpUbZScrsJGaygSTmi7pfte3r4thMrYMbbQsiyBZqi6nqLrw
	3OZJTJ/11g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42em38ge1u-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:49:15 -0700 (PDT)
Received: from twshared4872.05.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 22 Oct 2024 22:49:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id AAA1E14610C9E; Tue, 22 Oct 2024 15:48:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCHv3 5/5] pci: unexport pci_walk_bus_locked
Date: Tue, 22 Oct 2024 15:48:51 -0700
Message-ID: <20241022224851.340648-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022224851.340648-1-kbusch@meta.com>
References: <20241022224851.340648-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: 6YwAkLNpKk0cbCKoSLjyE8XLRJy2raMj
X-Proofpoint-ORIG-GUID: 6YwAkLNpKk0cbCKoSLjyE8XLRJy2raMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

There's only one user of this, and it's internal, so no need to export
it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 9c552396241e0..d015d5821cefc 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -445,7 +445,6 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*c=
b)(struct pci_dev *, void *
=20
 	__pci_walk_bus(top, cb, userdata);
 }
-EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
=20
 struct pci_bus *pci_bus_get(struct pci_bus *bus)
 {
--=20
2.43.5


