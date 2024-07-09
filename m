Return-Path: <linux-pci+bounces-10023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E7792C484
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 22:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C43282A0A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80F7182A59;
	Tue,  9 Jul 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OREnGqB/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0014F108
	for <linux-pci@vger.kernel.org>; Tue,  9 Jul 2024 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556850; cv=none; b=VbA/a8EAHlgNs71xboI9rTxN2YkwD+tu0s/sOpU7OMxVDfGpvAxf7XoU7nQJVDVqr2qJg+PFC+6fzV2TXIHLZp0ucW52G/23Qbrf4eOdIjQ9S42VPU9IyE8LgIqs7UyhJVYS/jlM7LsJHKMgHWBy53NC1PiQ4W6/WQOAzwkKEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556850; c=relaxed/simple;
	bh=Grz+iCnGALIJgOkups8vD/xhHYut8O5IgcRUVEl2CYU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WndTQkCIqUCB4fQDZopWX4CCi78qxAGu+Jr8W1uC8SfINU/+YyU0Fpesvkj+biDChSs2WMM0Nz4kF9akc5DaJqn0dt/d6bEjhVYa4AerMAGSFUosLIpQNLdLQPPxkQTn38HjcxH3wZ9Qocup12eR6gT656bMoAXwwW6p4jg35Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OREnGqB/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469K8dFh027144
	for <linux-pci@vger.kernel.org>; Tue, 9 Jul 2024 13:27:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=Hyy
	KRsdN7VvUv7WDUfO7bx06ZGoHXYrPnn/wh26pnvA=; b=OREnGqB/KxJjb9WA8s+
	qL3saYbx8OHVeSWL7YIcpaRjuMNUMKxt5dSjfm/MtszfHBlXH3a+t9x9JlzJuHyu
	x0l4lUT8393Pry+AwiY0Mhfnc0pRn4Ekj5FabGYWhOOEeHMgXF5NnzcGOCAMt0Ov
	KBbv5P+ObZfMxQnK4mYM+sMuF92lPeSdDjJpcjJDzjsRqhxmPVLXhuY1rTgXQSRM
	673JBN4q+YWYsEDRfVNAFnZ/TBAjzLLTMGeFlut9xLKl6Tjvn2uBHuNSRyvv2Qun
	dTWy5VuwQ5icmJWBIyebKkIjLNUlcTZxFfJ5nEvMIiwkbn0odViWU1jiPYq1+Aht
	PuQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 408um5e354-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2024 13:27:28 -0700 (PDT)
Received: from twshared15999.02.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 9 Jul 2024 19:57:26 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 895E11060AB77; Tue,  9 Jul 2024 12:57:17 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>, <kwilczynski@kernel.org>,
        Keith Busch
	<kbusch@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RESEND PATCH] PCI: fix recursive device locking
Date: Tue, 9 Jul 2024 12:57:16 -0700
Message-ID: <20240709195716.3354637-1-kbusch@meta.com>
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
X-Proofpoint-GUID: EbV79jULbhzfX2Q9z2LblG9CFpJOjkxh
X-Proofpoint-ORIG-GUID: EbV79jULbhzfX2Q9z2LblG9CFpJOjkxh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_09,2024-07-09_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

If one of the bus' devices has subordinates, the recursive call locks
itself, so no need to lock the device before the recursion or it will
surely deadlock.

Fixes: dbc5b5c0d268f87 ("PCI: Add missing bridge lock to pci_bus_lock()"
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Sending to the correct mailing list this time, and fixed up two typos
in the commit message.

 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index df550953fa260..5ab13bf5a3caa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5488,9 +5488,10 @@ static void pci_bus_lock(struct pci_bus *bus)
=20
 	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
=20
@@ -5502,7 +5503,8 @@ static void pci_bus_unlock(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	pci_dev_unlock(bus->self);
 }
--=20
2.43.0


