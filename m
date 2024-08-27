Return-Path: <linux-pci+bounces-12312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38927961801
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA0B21FBB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CE577117;
	Tue, 27 Aug 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Tg36DlMg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77291D2F51
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786939; cv=none; b=kC/nU4kbbPIwtlDObBBxj8mkCf4yHleVMalTrKqR6AJV5lK0KEturl05oTmDEf160XAD2FXX5bAo3DPmpumbLUFWRPHQZOlIhm5iWgEBSMTGubwoQJApFLmfNPHwKB2aLz8MlU5IzEptJ64BT9FZzq9hkSYPoTO2koekTviQk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786939; c=relaxed/simple;
	bh=tiCvGxXvIf6qJhtNJtaD3ZmT4CUNupTzQaXTk64jKdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5F/bgdki9Cn/MeqQKwUfOlSciqKn0CD9ZRh7AD/Jk+A4WVmGvpl+mb1czpghjwiwqw7H0uJZLQwrAOCqbMI9t3Vy+G4K1ygG43quH0XSUd3zOcSJiJLMhv4yT9vJN0mxb/mVxK0KPSiYrQ5D5aPdf1XUgf541KjdtI/Kxw3WJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Tg36DlMg; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RIpS0q023565
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=WtLjBrrKmUt0MuqC5UcDaN4lAOZ5FTZEdBCR44av+GY=; b=
	Tg36DlMgYN+c2AeEM8N/WBUNKuH/ix68+aPOhKvZpna2N9UR6rd2nV2Aev1V+xCM
	MaRxYM9wCshkqLum8ikdRSIuzHT/Aj1H6Ez2X1mCz8Yo+1M1mxdx3JhlEwHx9igQ
	+rMa0GMSIDNDvA1F5oVXc+6MJJw3pej5MZ3/GyfK23zgYlJdV/qGakqJEN9dyDqm
	6ESuSZsT+D8SB7nobWDDl59b/KJAhLMrv6KIe0MoffWNdWV+Yfv2jqvno4AOWmQE
	apW83l9rleknvOZSzcxv0VFp8pDFu47t1wVmUok8OyoEj/C6+q2FCQCH7pEWkSsl
	K53JPnCDs5rdOAj7+ycyKw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 419meg8836-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:28:57 -0700 (PDT)
Received: from twshared26656.07.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 27 Aug 2024 19:28:38 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 87F00124FD705; Tue, 27 Aug 2024 12:28:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCHv2 5/5] pci: unexport pci_walk_bus_locked
Date: Tue, 27 Aug 2024 12:28:26 -0700
Message-ID: <20240827192826.710031-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240827192826.710031-1-kbusch@meta.com>
References: <20240827192826.710031-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cENQFERb-aGWNtV2iUKz4qiZ0sdsl5oK
X-Proofpoint-ORIG-GUID: cENQFERb-aGWNtV2iUKz4qiZ0sdsl5oK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

There's only one user of this, and it's internal, so no need to export
it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8491e9c7f0586..30620f3bb0e2d 100644
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
2.43.5


