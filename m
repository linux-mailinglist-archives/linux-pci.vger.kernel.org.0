Return-Path: <linux-pci+bounces-45073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 376E4D3848B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 19:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AADCC30051B2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C434D3AD;
	Fri, 16 Jan 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lTM1qJBy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313392222D0
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588926; cv=none; b=G+jlrd/RvSCJwcGaClxjDj22wjQJC5dC5WiWheuXq5zoSOHL75Zrugq4gJm2dK5xx8cpkxy8+5v+cuvs6fLiSyuziL1GWSRsHsF3rbkXGbTVjzq1VHo2eDC0tPZVT6yKPmRDGT/ipp/BKzGpXSgHnPhPNFgoZV0RNJrNcR6hNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588926; c=relaxed/simple;
	bh=A2aFqxWidasA3PmXwS6pvWfzipgU4A2kXi7BI9sz4UA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1e3VYeOWcawYINu31SwMde/Y6PriCWSL9TqElO+9aUWrUk7NNywGUZDaimGGB8uX5Qt4YBYC1Wnd30+M0RDhgihh+wHQ/dMhQ4X/bS+BtOKwEAMOoJfJdJHb552UXMWi9Zq13sVGCCQwXa0kbNEaYr69h6NFwwf6osztbz5Jfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lTM1qJBy; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GG9I2U544896
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 10:42:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=S2L9+G1ruedPPKGUMh
	Kwro0OTWtYLf7d1bjft8hZduY=; b=lTM1qJByTdI3u6Ax4E0mhlUurUFHeOWdar
	hz1PGhUlJAWDKPZfD3nVZtKoRUPvLybywtkF88Xk+c5CX66Gf0A4iOekq9a2A4r1
	/w60NK2FC4gBbJEkSn3aa0foEjOwHcFV/FAX7/GTqm/AM91BQVTVV+a6NTqKQ+b6
	dC4CXoS9gTEMYbf5+0PT3IiKP0cqkZrP0QoPOpLDHDxDyVaExtLxNUVxf5i0Ggko
	cZNkBTBxfYR2R2ie7lZStjXDCdrpKOi+VESrnzZglPIIP83UDSK6k+tGUdhWUnZ6
	6ilzi6Aw6mHE4sO90N5ZAKh6sMWcKFDLqZ3gghumdsefUM95rd+g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bqrks99bs-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 10:42:04 -0800 (PST)
Received: from twshared17475.04.snb3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 16 Jan 2026 18:42:02 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 70F4664FEFD4; Fri, 16 Jan 2026 10:41:51 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <alex@shazbot.org>, <lukas@wunner.de>,
        <helgaas@kernel.org~/patches/pci-slot-locking>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 1/2] pci: fix slot trylock error handling
Date: Fri, 16 Jan 2026 10:41:49 -0800
Message-ID: <20260116184150.3013258-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: owaVqYHiUOE1SbwYldV3pNHyFmTinK4K
X-Authority-Analysis: v=2.4 cv=bf9mkePB c=1 sm=1 tr=0 ts=696a867c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=kmZ5IrMMQd9YCwZnqSMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEzOCBTYWx0ZWRfX29REQ2Y5wPdc
 aSIRDIyFkQKByJrBw7DiEWbS+TnIsNY0VACVT2uDd/z9NjJZu86gBU9kCbJPgvpE8cvXeNNzFKw
 Az8rEwzxJdqZwOzTcnJcNDzGOi4osuhqeA8gtDw451F9hCiRi02xednvgKki+KJcE5Ejpv4Rhlv
 e3HEkA98X/YRYD6AmNyPJPXXD65mRbOqYDS5H1ExhQCEOk+VOmA4s7JpwH7DT5HMcyKbubgEb7L
 2vhDpqw/mLvfEFtN3OUvSrtYuF0cC79dzT3tf0TxW05zOFM+R2HRsBXcNDbJSMKI+daoSugZkEQ
 0JsNyYSc98HR5a7+aiB9bGFYG9s2yi6yUAX399H5JTEyKWI7eyJ7WqrTaUS0WQTsWlFv1Dm/QM4
 CowTe2nbGFiOPK6LqBpWzWUI6wm4bLVF432kGl8kn/V4Tg5l68IHhhdpvBwvq3xrHEXViaA8+nE
 HUVOIBdvVD6MZcHGmuQ==
X-Proofpoint-GUID: owaVqYHiUOE1SbwYldV3pNHyFmTinK4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_07,2026-01-15_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The device lock isn't held if pci_bus_trylock() fails, so the code had
been attempting to improperly unlock it.

Fixes: a4e772898f8bf2 ("PCI: Add missing bridge lock to pci_bus_lock()")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 72d88ea95f3cc..3378221c5723a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5494,10 +5494,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		if (!dev->slot || dev->slot !=3D slot)
 			continue;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
 		} else if (!pci_dev_trylock(dev))
 			goto unlock;
 	}
--=20
2.47.3


