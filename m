Return-Path: <linux-pci+bounces-40708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F2C46DFB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 14:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FCF1890508
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABD12EBB9C;
	Mon, 10 Nov 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sAYxNKBY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DF22579E;
	Mon, 10 Nov 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781135; cv=none; b=ZbzpU0ccYEV7+rTLASUy0Z7SukS0cPaM/DjsFAaaxRNsaHwLAkTlJUsP785Ej/v4gkJ63WtBundBySmjBZ7eMsB44pF9JUST5dff0p0tFLCrmOIv/qHDe7VOwUj2cEFUk93ARTuYTcfsfB1xiTrrWqS6GREvwtoM5HV6uPAw704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781135; c=relaxed/simple;
	bh=M281PdKkCCNkCQo5UdxHcyxmHAV+Ri9XLT5PyGHe0Qw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IcakPeM2/iOv8zuLLnMuaPzg56J5ntUxgdqcDpkZMvGSwe8grfHE858s74sg/ffQx3etsjYYTKr2dzjMiCp1OFj60/mdKzeUxINfYY9jvTx4iNME1gm/QSbwQeTn09HAhjMkCc0Plb5dWhCo9lPQqZYutiBSnKv/Nl1j/KP8lRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sAYxNKBY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AADHNsZ002817;
	Mon, 10 Nov 2025 13:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=69CElqUVy8RLaqayOD8yFbTQwzhV
	KpzfxD9KPhmLy9s=; b=sAYxNKBYc/yiJ7NM6RkZRMWAir+OvafJ1i8gyUnUDPHy
	xM4GmxltIpG3UMPhBWUe1gyiZEI9gxNd9XCSWgDpVBKKIJB6fAZqPJta5xfTLTQw
	+Zy3DsCiVt3m14YIusqkZ0Njd+oZWRzTeAsZUzR04ROGYikYXXYlpLFxzj5cRE53
	Ed4VQ/8k8ecSbtGGgsnW/f00QtvNrdT67IdMk+ZK/YpRSy7T5D7pg7RHbA31aLE2
	5mQjytkE3xSTrXWPvuVMs0bsZ5hFv7ygi69kK3Jwi5f5hmcABvz6He9t6wscdOt4
	TWtV6hwrcxa5FR9OAClF/bH+h2fJ3uB7UN7+wolrPA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc70d5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 13:25:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AADHMeU029222;
	Mon, 10 Nov 2025 13:25:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc70d5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 13:25:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AACnKND014841;
	Mon, 10 Nov 2025 13:25:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpjwq1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 13:25:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AADPM2M55247146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 13:25:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B84922004D;
	Mon, 10 Nov 2025 13:25:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D05E20043;
	Mon, 10 Nov 2025 13:25:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 13:25:22 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH 0/2] PCI: AtomicOps: Fix pci_enable_atomic_ops_to_root()
Date: Mon, 10 Nov 2025 14:25:04 +0100
Message-Id: <20251110-fix_pciatops-v1-0-edc58a57b62e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALDnEWkC/x2MQQqAIBAAvyJ7TlAjk74SEWZb7UVFIwLx70nHY
 ZgpkDERZphYgYQPZQq+gewYuMv6EzntjUEJNUgpND/oXaMje4eY+YhGC4PObaKHlsSEzf+7ean
 1Aweb5NFeAAAA
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX53KRCwDSxl/h
 lyKRPSsLHBISFZe10KAgQ2aCy4J2IkN9HBI+SMTCNBQl9YSc12cSCZ4H5qT2q1CnB9gdUrNl3FG
 nTSdLcry+gpQNrwXA7QQOTgBsJLGEEbeAATx1VvzgVf+I9v5X2SMgeUyJl7kASoJm1Xst+t6bHQ
 IbOptq6FiN92YJjT5wg67LysPIPhf31R5frry2FIzYZqRNtDZG95pkmHtCYFi0DL5vBoE5a4n3B
 dEwu8QtYiYoRq/G4S2Zp0QGBwnt1odrPt1Kk1zolJmn/2uOScRn3w5EmR284lP5IDFauXzIidir
 p/BWcDIduAGW4B9WO+8SADjqdTkaGhca8eECl44lyYbUgmKBvLq9JRQvzdt9AmIViDUnVvEA6B6
 twRnRcsTSv7bXM1YE8qK+btli/0SQg==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=6911e7c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ESohFN6d5o8hY1LCVJoA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: SFNmk6CvC9OOEQ0hiYo0zNW1RPJxsJSD
X-Proofpoint-ORIG-GUID: EX6tyP_6F1B8TGWbDKEP6Rw2em64XCJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018

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
Gerd Bayer (2):
      PCI: AtomicOps: Define valid root port capabilities
      PCI: AtomicOps: Fix logic in enable function

 drivers/pci/pci.c             | 43 +++++++++++++++++++++----------------------
 include/uapi/linux/pci_regs.h |  8 ++++++++
 2 files changed, 29 insertions(+), 22 deletions(-)
---
base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
change-id: 20251106-fix_pciatops-7e8608eccb03

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>


