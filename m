Return-Path: <linux-pci+bounces-43141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4448ECC4898
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 18:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD8B93044131
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119BD324B30;
	Tue, 16 Dec 2025 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ki2YJ+vd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BCE2F7468;
	Tue, 16 Dec 2025 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904695; cv=none; b=pAL6iRI/LqaQi8D6BOYm6en5+0jq4+3KOh7trpf7LL62sGn+IfLq+xZZ5r8lDIxggMsGbs3ugBRfJaa6NVbM1oCYL6CmIaE+uXi88dEPbrsaiyML+Fa4+R5hQRr5ktDZU4BBnkRRO1TRy/CN8i+hYLrdxAruHmk8TOUerQ0cdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904695; c=relaxed/simple;
	bh=JSKmZh43t535aDBzLTONnQn3+h8TvyyPjhpTy93Wy2k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UBvOYY2fMNo1skegONvc3tjxzY0ZUXUKL8NZvhbQQlR2QzDcJa8IhvP5NKSTqac7oIod2AW8eH6QnNhcctfu70BCyMET9MHNqCjwicAgealzMTPOQTDwgjpwxIl8cXkCgRjChJWzVkvJGpZ8B//nUy8fB3pqpd+X8PCCTF89Dus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ki2YJ+vd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG8es23025635;
	Tue, 16 Dec 2025 17:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Jm/uGORFgz04aIOKV5Slyh9BoCns
	Rw5KiZ47ift5Hxo=; b=Ki2YJ+vd3K6Q/FLL6k3Hfb60zli6CqkIxtptOKaRkL/+
	2+u3/a4X6ZAUceNrLKAD12PNcq+fQMkU2abOHOka8enfI+q4VwtXmRHCbguW8WUG
	96gSROQIk5aMNHfv3SJhMDXqx4P2hpqtgZA8x8mH6tYTlECAcy8ZdJT5dRUxubnv
	t3yV3TH+fgKiMaz0FewJrH3Oq1PVKnJPJBjSBfGKW3VAX5MeOgPi9eDGwzwAIpdO
	FadisHwPEB2EX/3ia+6lLvRq0G/zB1UzAvV/VBZ/Z2WVlY+dymi2iUdqym5AiTRG
	0FOEq7RwVDt+06+5moUkNmvwBwOzfMi9nbVppJtgYA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv8dj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 17:04:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGH4mcj010877;
	Tue, 16 Dec 2025 17:04:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv8dhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 17:04:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGGBIUt012788;
	Tue, 16 Dec 2025 17:04:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juy5pa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 17:04:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BGH4hSG43581744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:04:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77B772004B;
	Tue, 16 Dec 2025 17:04:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EBED20040;
	Tue, 16 Dec 2025 17:04:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Dec 2025 17:04:43 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v2 0/2] PCI: AtomicOps: Fix pci_enable_atomic_ops_to_root()
Date: Tue, 16 Dec 2025 18:04:41 +0100
Message-Id: <20251216-fix_pciatops-v2-0-d013e9b7e2ee@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmRQWkC/1XMQQqDMBCF4avIrBuZpESlq95DpMQ4rQPVhMSKR
 XL3ptJNl/8M79shUmCKcCl2CLRyZDfnUKcC7GjmBwkecoNCpaXEStx5u3nLZnE+ipqaChuytsc
 z5IkPlP8H13a5R46LC+9DX+X3+oMk/kOrFChosLoxuu4rRdcnz6+t5H4qrZugSyl9AHSmu0KsA
 AAA
X-Change-ID: 20251106-fix_pciatops-7e8608eccb03
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>, Leon Romanovsky <leon@kernel.org>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX+BEudRYYVAOF
 3vf9ZUPYzaKTK1kHBE4gLCKJ421ewprmQDwH+tE6vNn783O8EdiZMZmcvuM0ReWRDVethdzKXuX
 kPwZixWaMSVPG/8UxcVeuRKbFvVChengSAm+LjSDIC50r4FQzgj0hGb/Q91gKhrfyS4hy6kxOpg
 kXFw6zuziAfHOFcjaPCL3sGYuA0HolvIDiURcexo8YQn6j2SMiCuTIqFLkd55tTdrXZUp2qd4W3
 FRcMw9DRhdTnLGO/Kt0aOCya+PwUFcx4y/ajG2CkFgdeS1+pJYAstV7BGGGw0Kfha1TFaJIvR3B
 5NJQ/HDdKvjNDwG4Hr+smKE44ZzGjP0raHc873yh27bacaNzX4cJrd8XR6hfKYQD7kgBBSr8Cf7
 vrcFTbp0AH+oRfXNikaty8xo/qC9lw==
X-Proofpoint-ORIG-GUID: v4IUPvNaloUwxEnaw9mGPChGFVI64mSo
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=69419131 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=AXBlPMOSM4AmvKD3g9wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YweaWI9enJTufc_DD9dBRPmVg_r8kRYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

Hi Bjorn et al.

this series addresses a few issues that have come up with the helper
function that enables Atomic Op Requests to be initiated by PCI
enpoints:

A. Most in-tree users of this helper use it incorrectly [0].
B. On s390, Atomic Op Requests are enabled, although the helper
   cannot know whether the root port is really supporting them.
C. Loop control in the helper function does not guarantee that a root
   port's capabilities are ever checked against those requested by the
   caller.

Address these issue with the following patches:
Patch 1: Make it harder to mis-use the enablement function,
Patch 2: Addresses issues B. and C.

I did test that issue B is fixed with these patches. Also, I verified
that Atomic Ops enablement on a Mellanox/Nvidia ConnectX-6 adapter
plugged straight into the root port of a x86 system still gets AtomicOp
Requests enabled. However, I did not test this with any PCIe switches
between root port and endpoint.

Ideally, both patches would be incorporated immediately, so we could
start correcting the mis-uses in the device drivers. I don't know of any
complaints when using Atomic Ops on devices where the driver is
mis-using the helper. Patch 2 however, is fixing an obseved issue.

[0]: https://lore.kernel.org/all/fbe34de16f5c0bf25a16f9819a57fdd81e5bb08c.camel@linux.ibm.com/
[1]: https://lore.kernel.org/all/20251105-mlxatomics-v1-0-10c71649e08d@linux.ibm.com/

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Changes in v2:
- rebase to 6.19-rc1
- otherwise unchanged to v1
- Link to v1: https://lore.kernel.org/r/20251110-fix_pciatops-v1-0-edc58a57b62e@linux.ibm.com

---
Gerd Bayer (2):
      PCI: AtomicOps: Define valid root port capabilities
      PCI: AtomicOps: Fix logic in enable function

 drivers/pci/pci.c             | 43 +++++++++++++++++++++----------------------
 include/uapi/linux/pci_regs.h |  8 ++++++++
 2 files changed, 29 insertions(+), 22 deletions(-)
---
base-commit: 40fbbd64bba6c6e7a72885d2f59b6a3be9991eeb
change-id: 20251106-fix_pciatops-7e8608eccb03

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>


