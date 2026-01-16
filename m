Return-Path: <linux-pci+bounces-45074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EBED3848C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 19:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6AEE305E3E4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354C134D4EE;
	Fri, 16 Jan 2026 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XWXDWE7j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A442040B6
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588927; cv=none; b=YH1r7nrN0NaDHT0NGkHyklMmqK5yJRqVwC/COA1ArCBxoQWIQqgKp+ZqXlf6+5jzrr7vo1cb+W6INzsVL399YsobdIL/Y0/13p+ASaIXDA6FQ7vfnqxwB+22bhO7xfKtkSsHvPmK/ONgLM46gh/PnA3MLmr7eVnJzveAqJLAP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588927; c=relaxed/simple;
	bh=qifg4/691RtNuyRgX8kif2ug/eDUKarrQrnMIFDv4fg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIV3O3zOjfPYUPuQ3iFDDLcWTn4H/y3bnRwrZFtbyJO84NdvdELxzk59Dg4wDscEhf1S+WW9EWZphxIhNYDlyUNhhk7IVyQ7TucLbSD4ur2jMgillaVfweBe05mrZspdYnzYhJiXuDj39NMmhrKF8aPwuBDQnzTqJs9YUP0eB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XWXDWE7j; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GFRB6T1278462
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 10:42:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=dZlewRssXB5oaErbpLRD11ydvtlm6fZUm6YiMQbQyU0=; b=XWXDWE7jz/Mv
	n9WYOhcV3KOiqKiQuG9WO9REdqFcHPpf5NjZsjLjyQ9JSu3z2BqMgtU7y8sEzTon
	sZG0HGYbthWhGuFvvs0Szv+/qGdfJH+BE9IZmdHAS+aDLiGEKA1W1q+QBwvsjfbg
	wjjeg5Q9maxoLiyHmNKuIlln3Ja+p9fp5N2i0TjdoBrEHZznnn06tPqsonVXFm8d
	QqbLyB70YSibj+ysiQS4y+76qsHp/3BH4f6JxsnpZ840TPFrgzGdcXo+108ubKd3
	xr5Uls6ya5g+iy1u9vm8Xy3NUfEnyEgJL8BHDAFUcGy8SbkbnoL6i3iSdu1unweT
	BMboojoVLg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bqqyx9m7j-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 10:42:05 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 16 Jan 2026 18:42:03 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 7282F64FEFD5; Fri, 16 Jan 2026 10:41:51 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <alex@shazbot.org>, <lukas@wunner.de>,
        <helgaas@kernel.org~/patches/pci-slot-locking>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 2/2] pci: fix slot reset device locking
Date: Fri, 16 Jan 2026 10:41:50 -0800
Message-ID: <20260116184150.3013258-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116184150.3013258-1-kbusch@meta.com>
References: <20260116184150.3013258-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FOIWBuos c=1 sm=1 tr=0 ts=696a867d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=QhqoAkZ32vWlSlo0vxIA:9
X-Proofpoint-ORIG-GUID: v95AczDPL4q6m07krSFBUIdHgHGu6-oP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEzOCBTYWx0ZWRfX1W1iWzAGcNHF
 FGr7sX5HJ9En/5b345gfQ7c7hOpehYOG5UaYeAlASTWKAWsN+UgnqYKY7E17BWQcNq3qWTka4L9
 N8amoTRLI60vhSxuB6spfK0T2osAepghked5TpuO6+/VDAkOwx9BfaLUVJKIfrgw68Q3KzzlKJP
 1kxbkR5VPq18HnbWkj9DmJTdWsbkTlFZdPmBWUCjCykUrm/29q1K497AsEPN6Mkb9SZEYexCyvI
 jE6jRxevfvvsZuvlUp2YCUnqMBhSnlLtyTmChUHX/l+geP1LkEZrfQyqph6YWeDCzxbj/pZQriW
 ayzMVvNMBb9J1ERZH0AP7KOVAWoGzed/plPC0AX23nPc9pKny6mJ7SFXqQ9DTq+WtiGwrjeiqgs
 SnMFXhjE+b+dELxknLnXVKma5s6ZO684//EHmhSqHy2fShMK3wBe22Kk2YfswHcG/PXgwZTt1ar
 NXNAo754oIEqrY/dCZQ==
X-Proofpoint-GUID: v95AczDPL4q6m07krSFBUIdHgHGu6-oP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_07,2026-01-15_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Like pci_bus_lock, pci_slot_lock needs to lock the bridge device to
prevent the warning:

  pcieport 0000:e2:05.0: unlocked secondary bus reset via: pciehp_reset_s=
lot+0x55/0xa0

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3378221c5723a..5f8b0d06a1459 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5460,6 +5460,8 @@ static void pci_slot_lock(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
=20
+	if (slot->bus->self)
+		pci_dev_lock(slot->bus->self);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot !=3D slot)
 			continue;
@@ -5483,12 +5485,17 @@ static void pci_slot_unlock(struct pci_slot *slot=
)
 		else
 			pci_dev_unlock(dev);
 	}
+	if (slot->bus->self)
+		pci_dev_unlock(slot->bus->self);
 }
=20
 /* Return 1 on successful lock, 0 on contention */
 static int pci_slot_trylock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge =3D slot->bus->self;
+
+	if (bridge && !pci_dev_trylock(bridge))
+		return 0;
=20
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot !=3D slot)
@@ -5511,6 +5518,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		else
 			pci_dev_unlock(dev);
 	}
+
+	if (bridge)
+		pci_dev_unlock(bridge);
 	return 0;
 }
=20
--=20
2.47.3


