Return-Path: <linux-pci+bounces-39623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43CC197FA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 10:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6CEE5647B4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709A32A3E1;
	Wed, 29 Oct 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="THI4zuKe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1D329C5A;
	Wed, 29 Oct 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730927; cv=none; b=KsrHAzlpYNwIKWhKE1VugHjTj/4pUNq6RjF8/UNIAe5okyQPRTjO+IUaVDxZice4Y3ztEOXT7hpvoD0Muo4GknnzOCMe+jl0YhvYuCJgDcZfiKQWBfZO3ZMqIh5nyGc0Ff6d6Uw6EcAGG6oS7Bvajd9YnoL3QhfAP6TAInJHfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730927; c=relaxed/simple;
	bh=zebgDL1IcHI2ZG9RSDXvOGsOCN/mpPlOx9sHfMn/uaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VO/bUNYu09pyu4B9rWVj5x9cJGhjAzm5LrW1njPDj9dlAlXVl30xFJSslHRWm4ZuwbwlgvaEcuWXxiTiKZ4tn7IeUhHeT8G9BQNfmAP9gRILtFDxgcmeNj0nLwhTC1TEWtPwNxgv75jTirc7rLBiVcqpL0bagE+VED9ORzd3a7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=THI4zuKe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJmAlv025673;
	Wed, 29 Oct 2025 09:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=vFIxpZ2i6gYS+xu9QRifiMuBvZuK
	+8hzNrZaMlIqadE=; b=THI4zuKet4OHuKxcOnnmfO2JTL9yJgb7Q7RILRGhITqs
	YatXJcmlJGCBN0b4WQ0eiZaDbgqq2mNdIBUh9f2v0Oqe5He0Y6/0RuTmRHQLZqAP
	feIHDaTPNkW/+XFOHbomOCUzY/bBSXkqjLMWYNuu13/9UPmvRvnnnd8cS1K6hjVF
	ZlUczcF0f6u+g3t2rj4ZHh1y1ByoN4m57gHV+fOHzI+RAVl8UgsdtBYrGyj00Wi/
	yap4voFW6jYZlpLEtBh9PTMdFNebGNxyx/63rjzmeiupzh1LNk0RtrtIMrr17Lqa
	uW6MgTO5+TC48Y6h+s6eX7RoKVk5NISw6H4yDmY6qw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acjjfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 09:41:51 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59T9XvEI013505;
	Wed, 29 Oct 2025 09:41:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acjjfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 09:41:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T5LwF1023836;
	Wed, 29 Oct 2025 09:41:49 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx2mag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 09:41:49 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T9fm4l51184096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:41:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47E7458056;
	Wed, 29 Oct 2025 09:41:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D706958052;
	Wed, 29 Oct 2025 09:41:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 09:41:45 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 0/2] PCI: Fix isolated function probing and enable ARI
 for s390
Date: Wed, 29 Oct 2025 10:41:30 +0100
Message-Id: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAErhAWkC/23P3WoDIRCG4VsJHtego7tqjnofJSy6js1As1u0k
 YSw914T+gPZHL4fzANzZQUzYWG7zZVlrFRonlp0Lxs2Hvz0jpxiawYCtDCguc80TPMQTmWIWHk
 HATyYpHTfs3b0mTHR+Q6+7VsfqHzN+XL3q7ytP5QSj1SVXHITUZre9MklfP2g6XTeUjhux/nIb
 lyFf8JJuyKgEVaNyTsnhYX0jFC/RCe0NCtCNSJ4bdtLznttnhH6j5AC1IrQXHCrLSBglCLER2J
 Zlm+AUd/jeQEAAA==
X-Change-ID: 20240724-ari_no_bus_dev-52b2a27f3466
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Huacai Chen <chenhuacai@kernel.org>,
        Bibo Mao <maobibo@loongson.cn>,
        linux-s390 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev,
        Farhan Ali <alifm@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tianrui Zhao <zhaotianrui@loongson.cn>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2807;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=zebgDL1IcHI2ZG9RSDXvOGsOCN/mpPlOx9sHfMn/uaY=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIZH4bb8NX1bEv59Pc98+ITz6tEI2/+LC1b4Lzv/K+Ft
 nyxG21COkpZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZjIymSG//5GlpP+Hq1p3bS0
 vEHtxOnFLUHT9xfFCC9bYWeX/nyy3T6GvyJ/6x6wKBXZvL/tbdQmV9o2M9BIYlK5Wq53qckPM+W
 VTAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=6901e15f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hLx8FqHbWYRF7YI4eHsA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: HoaeCE1EYQAsXwP-clUtGnvtFf97dVTr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX6bZ6cnUNLXwN
 oz/iKWkrPvuOyhlslfB5RuakY31wGepm8wBSaBD7p5P7ONxWzAn1duKG75/FLKPPOEGWGXRnkfu
 yEq1xN8HYmi/1RxLXGP4gSa4dS6IVAoeWzY1dQ0raOcxb68q57zkPoIUivpzOrGIueWtmjuEWwo
 rLOJazQXo+i8+4+9BBmZ2Wr54AX2nBRRxNKRFX8u1YFf1MwmGYSdo5xfis7r2mQ+NJy/ugJf9Em
 QTy5RsWfG1rV/Gvt49ee3OdzgjISVRLEegPaA+Edcnf9yI+7iml+SR4ZloahsrYCcv0f7TGWH8n
 MTccRtLihu3peEUjYPwkCxOrJ8/M9Sza6MTqkSnJ63vyPBdyI6EK7k60bFHlxE0DU1ypwx7nfyQ
 Ucv7dzOGE/XI7Aw/pEc4ykwqs3mRwQ==
X-Proofpoint-GUID: 1Xq8k7ywf5PUk7-A3R9oPQriASyrV26q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

Hi Bjorn,

This series originally aimed to correctly detect ARI as being used on
s390. I had missed however that this, in a pretty obious manner, breaks
the isolated function probing resulting devices not getting probed. For
example if a partition/system only has a PF with devfn 1 passed-through.
Additionally the fix may (TBD) help with an issue that LoongArch has
encountered when using isolated function probing and tried to fix by
limiting it to bus 0 ([0]). If it does fix this it may make sense to
apply this separately from the second patch.

Besides the effect on s390 the second patch should also ensure that VFs
on a virtual bus created via virtfn_add_bus() correctly present ARI as
enabled. Sadly I don't have access to any device to test this.

Speaking of testing. For the first patch I can reproduce the AER
scenario described by only applying the second patch. The SR-IOV
scenario I encountered in the past before commit 25f39d3dcb48 ("s390/pci:
Ignore RID for isolated VFs") and tested the fix now with a partial
revert hack of that commit.

I also tested the series on x86_64 both on a Ryzen AI 340 based laptop
and a Xeon Sapphire Rapids based system (including with SR-IOV on
a ConnectX-6 DX).

Thanks,
Niklas

[0] https://lore.kernel.org/linux-pci/20251014074100.2149737-1-chenhuacai@loongson.cn/

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v5:
- Rename variables to match "fn" abbreviation
- Add Cc stable
- Rebase on v6.18-rc3
- Link to v4: https://lore.kernel.org/r/20251023-ari_no_bus_dev-v4-0-8482e2ed10bd@linux.ibm.com

Changes in v4:
- Add fix of isolated function probing with ARI enabled and in certain
  cases with SR-IOV devices.
- Link to v3: https://lore.kernel.org/r/20250417-ari_no_bus_dev-v3-1-ba48f349aa47@linux.ibm.com

Changes in v3:
- Move setting of ari_enabled on s390 to bus creation and clear it in
  pcibios_add_device() if the capability is not available.
- Rebase on v6.15-rc2
- Link to v2: https://lore.kernel.org/r/20240918-ari_no_bus_dev-v2-1-83cfa991082f@linux.ibm.com

Changes in v2:
- Rebased on v6.11
- Link to v1: https://lore.kernel.org/r/20240730-ari_no_bus_dev-v1-1-7de17676f9fe@linux.ibm.com

---
Niklas Schnelle (2):
      PCI: Fix isolated PCI function probing with ARI and SR-IOV
      PCI: s390: Handle ARI on bus without associated struct pci_dev

 arch/s390/pci/pci.c     |  7 +++++++
 arch/s390/pci/pci_bus.c | 10 ++++++++++
 drivers/pci/pci.c       |  4 ++--
 drivers/pci/probe.c     | 22 ++++++++++++++--------
 include/linux/pci.h     |  4 ++--
 5 files changed, 35 insertions(+), 12 deletions(-)
---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20240724-ari_no_bus_dev-52b2a27f3466

Best regards,
-- 
Niklas Schnelle


