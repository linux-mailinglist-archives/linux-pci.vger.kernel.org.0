Return-Path: <linux-pci+bounces-39158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A3C02134
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE831A646C6
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E303370F0;
	Thu, 23 Oct 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f3dkbZQd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561B33374C;
	Thu, 23 Oct 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232870; cv=none; b=WlUpOtfsTQl4D1xHDBwyaXc0/dQRZT3/z7DHtlAI0/DtkDp8QHIy/hmduEK9/nsu6O52/QUYBnf+WtVc1jR280m0Duz4WY+UGWcbl2J1GUmaBfvtiVCqRYhJA9Bp1SA2dvyZOqpCQn7l6fUNywPA/wHz3MbGkxrCQyQb94QwKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232870; c=relaxed/simple;
	bh=BYb7xuVoSyultx4DlCUy4uvLkrktc8Bom/DND+zE5Z0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=blGeNXPgLpU7j+XpQRoqMQcqSH7frjR+VFaNc3NpjJ1P3QkrA28IiIJleZhP+SVzqtQs9vdwpFTcKP5IFyyYD6yRSVP3y++bVFMY1fX4odsYSm3G51fldi7L4WJMxxk9eqjNC3yjJ1RwU2nrFquYCae9oax9iqlYSRQ4iHGwwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f3dkbZQd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N86h5O010024;
	Thu, 23 Oct 2025 15:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=kEBe9mUJWO2XS82G5NZUz8/+A0G7
	iJdz+oms7mK5oWk=; b=f3dkbZQdCIszpjactf15bOrmk99Ax/SLrDIHwq+YqCep
	JvqIBlkwclUcO+QyVCLaWJOT7PZEfylmzjoWBRQ670tv81FfvGEzavJNvE4BgFa0
	atTNrDlmETNS/i6dQBopYb+nPlSDJZO4bh+FvGYU5JyO9xpbkMErqjKFJXMLxc5u
	rFVEgQmyBmWO6yHJQt2rns1jxcqFXnyKm7f5vYnwkQ3NMaBu65ZyWY6Gqxhh5ucP
	G0GPQ90BmVSnocE0WocWRDUSuZSh5OATzo9iDQSxa9mbh2NqzOAwj5Yi71C7JtU1
	t4G6r8GkC5ywuyWrZVwlpUHCx8SaFekZttCq8l0Wgg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w1gb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:20:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NF8Wwn019219;
	Thu, 23 Oct 2025 15:20:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w1gb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:20:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59ND9nAP014676;
	Thu, 23 Oct 2025 15:20:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sent7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:20:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NFKbU130933584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:20:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AE6858055;
	Thu, 23 Oct 2025 15:20:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2BD458043;
	Thu, 23 Oct 2025 15:20:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 15:20:47 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v4 0/2] PCI: Fix isolated function probing and enable ARI
 for s390
Date: Thu, 23 Oct 2025 17:20:40 +0200
Message-Id: <20251023-ari_no_bus_dev-v4-0-8482e2ed10bd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhH+mgC/23P0QqCMBTG8VeJXTfZzqZzXfUeETJ1ywOpseUow
 ndvShFUl/8Pzg/OgwTr0Qay2zyItxEDjkMKud2QpjPDyVJsUxNgIJkCSY3HahiregpVayPNoQY
 DyglZFCQdXbx1eFvBwzF1h+E6+vvqR76sL0qwbypyyqlqLVeFKpx2dn/GYbplWPdZM/Zk4SJ8C
 M3LHwISUYrGGa05K8H9I8SbyJnk6ocQiaiNLNNL2hipvol5np9DJXtkNgEAAA==
X-Change-ID: 20240724-ari_no_bus_dev-52b2a27f3466
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Huacai Chen <chenhuacai@kernel.org>,
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
        jailhouse-dev@googlegroups.com,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=BYb7xuVoSyultx4DlCUy4uvLkrktc8Bom/DND+zE5Z0=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDJ+uZ+NdrwQsWtzLFt64WelRXs937I3OPz2S7t4VfqV0
 KYLIb8XdJSyMIhxMciKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjAR9xBGhve/owrUHy/93ikw
 R4Gtu2DenM9T03q273i5Sed83/3aW5yMDB0NP6bGyXVvvu1xJKPY9OvPH9v+Ol9eNSNZxSFX2uY
 IMw8A
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U4UQobL0buWUJUotGSDdum7ot8fFSVik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9c/XJ8faq6PS
 Pp0LFH7zLFF3UKcJJwYrm1ZJaTmE/dc3lXbcFRwavNaBSCqHO6IigQ98iBzLG6blalr4/9U9gjY
 JgeQoqYE0SUMhpuduEv+9IeE2TuF3YkegW3QSwUQUQaG4FprIK6RSzQI5sm1kt1nBnCIl0/YH9N
 a9ntpfob7AFl5DnoDw9zFDcfFzFAajQNmcnLPJBeJjVTcKTkf2Wlji/TyXb+txvJy5veWDb5xy4
 xdnpeeDhY2J/pgs06sVd7okFWUqpsSpfomypexIcr5SL7aBXnBFSYHk2Yq3FmcfUZCONpmb8QM8
 TdH4cuet2pI9STndeYSD5HCMrfgelWnGvHvgIFz0iwN7IhWCavs/EgQLCRxo129APj7+LPOd+wC
 4ROT6RG8En3pUH6h3q3CaR5Ge1k7ZA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68fa47d5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hLx8FqHbWYRF7YI4eHsA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: jFahKdE41NQYbbKuOIJDD_Pj10-2SaU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

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
 drivers/pci/probe.c     | 21 +++++++++++++--------
 include/linux/pci.h     |  4 ++--
 5 files changed, 34 insertions(+), 12 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20240724-ari_no_bus_dev-52b2a27f3466

Best regards,
-- 
Niklas Schnelle


