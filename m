Return-Path: <linux-pci+bounces-33554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8765B1D976
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9211718C1A3C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E86233701;
	Thu,  7 Aug 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c88eQYTU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7A1EB5B;
	Thu,  7 Aug 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574958; cv=none; b=XXdnm1E8D2t8FOH0EO3UcKDz+uWPa8O+e5MgtfkGWBfl+W8C+ohmHLG/l/b4BdkCEHSEfZRhR8g8DDtHimikbnvEqZipSmufJB7O6DmUcuaGJqhMz1SvcbC9v48V5zzfJdD85ugcb1e5/j7oH9BiN1AinSHkKvC1da8qRFcp2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574958; c=relaxed/simple;
	bh=genfLilDQilTlrVR+XjImpQdVjsDL45CfUIKqnfk+5E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OmhEEAu9n4huoVqBKY6+XfzLOEHZeezUjwFr1JZd5/Nj2qGvn6z/dIhQGQzMKz8cwiUXBJHg30MkXmfz8C3XKT8wdL4mwt8vStmaF48JgaALzIAN0SQMmWtaC1M6AOUIT/bRU2LA43Nv7d4ZCsbN1rDtB2Ldo+wk5u6VscQToCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c88eQYTU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5778csZI021572;
	Thu, 7 Aug 2025 13:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=y3+fywtBg7WA4g2vIVfSuzo1cv1w
	/rMDMqYu2v+Dabg=; b=c88eQYTU5kYHu2kzEIaOcgGzXPUwEE6Cf1Hj31bDnbpB
	PCwXQDMFGqjHb1e2Xl8cbNDwt7UIce6pb8rqTotHV8Uuh6E199wJBO5NanSwRyzn
	q+w4xiCxGM9GkYy3KQsT+pwECZwkWapnRq9XMEaH/mWtli3V8UHvAiHQ54XZf+za
	cbEI5GA80rl0QguSMBvMpcurrkGng/8jWfTbGSUvs50RHo5GGlGkJf6DnSwGLNkx
	Yt2Es8vX17bKsyIsBleDcXaKl5SyKZoq2D9BVHrZrN56diphU94whURjxkTUslFr
	nQfuu6uh+xf1E3m2kX9s7EOsRPm+RVHYeg9pim2HUw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq622fym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:55:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577DnxdR022588;
	Thu, 7 Aug 2025 13:55:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq622fyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:55:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 577DjUMV001627;
	Thu, 7 Aug 2025 13:55:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwr0vm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:55:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577Dtjed24707804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 13:55:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 462B358062;
	Thu,  7 Aug 2025 13:55:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 712C95805A;
	Thu,  7 Aug 2025 13:55:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 13:55:42 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 0/3] PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI
 recovery
Date: Thu, 07 Aug 2025 15:55:37 +0200
Message-Id: <20250807-add_err_uevents-v5-0-adf85b0620b0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFmwlGgC/23QTQrCMBAF4KtI1kYmP02iK+8hUtpkogFtJdFQk
 d7dKEIXcfkG5nvDvEjCGDCR3epFIuaQwjiU0KxXxJ674YQ0uJIJB96AZJp2zrUYY/vAjMM9UeW
 Nk05bhK0lZesW0YfpKx6OJZ9Duo/x+S3I7DP9WVxWVmaUUSGMdKrXemvV/hKGx7QJ/XVjxyv5e
 JkvhuKiNjgF2omOW29QM+b+GWIxtIDaEMVoJPSsMRY0+H+GXAwD9V+yLIZVXPbeGSVMdcc8z2+
 4gbhAfgEAAA==
X-Change-ID: 20250417-add_err_uevents-6f8d4d7ce09c
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Linas Vepstas <linasvepstas@gmail.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=genfLilDQilTlrVR+XjImpQdVjsDL45CfUIKqnfk+5E=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKmbIg1SJr82zwgzr6o7XfzXyGLXbq7WBrPaTy69SIkJ
 J2nt0awo5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgIlMb2b4H9MyX+rrE87HlfpB
 NaXt57w5p8tHNC3qv3bLePmCSbO57jEybPLROi1xRLDVT2TPW8/l/PwtC+a2Py5OWMOeeV9nQhE
 jDwA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEwOCBTYWx0ZWRfXypIpd6Ht8VBA
 4ArXLqP2NeA+aCDpkBLKklqTGdIxkINzfNJFQjXXXSf1ErVwcYbTBHpj9cXIWyais+yCLk9MkB3
 ckOecV26LKsFKvyfHHmgFWqGo7/iIQ7SGSNZuqMkyDbVjCpzTvd9cTb/eQeICPisBcxg8arCujq
 zSB+vJUNXsp048WZgbg8sIdsSV+uPBXI6dtalMZDb7t+SEpeTEtQWROtxzcuc5sqK8V4Q2obLxn
 UwC1g4rXhvhgfMdwsv1lLtf2bdbO56yLzNyIBxfDJ+4butBi83tPhh4+9069fRzLMpkqlB0Ppmp
 Wuxe8gxVJo2x0iC77SwJ0a85d6YIv1UaJsGJi5oX287BqiN2wPiF6+owwznm2YaneW6/ElcvhD/
 HHtg65EWEnt+RRUfj/+mart8NEX4/jpo46e14Vyum4DORBHZB93XnSKUlCDyN3XiUW8dYJLZ
X-Proofpoint-GUID: mjFpNY3XYbn_IxSgE3fyv19oNXETZZ82
X-Authority-Analysis: v=2.4 cv=BIuzrEQG c=1 sm=1 tr=0 ts=6894b064 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Ot2KE7TKgi5QPKB6m9EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8dDb7rlIF5q5c9sp3xjcYHl_LrCS16l-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070108

Hi Bjorn, Lukas, Mahesh,

This series adds issuing of uevents during PCI recovery on s390. In
developing this I noticed that pci_uevent_ers() ignores
PCI_ERS_RESULT_NEED_RESET. I think this will result in AER not generating a uevent
at the beginning of recovery if drivers request a reset via the voting
on error_detected() returns. This is fixed in the first patch and relied
upon by the s390 recovery code as it also uses the result of
error_detected() though with one device/driver at a time.

Thanks,
Niklas

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v5:
- Add R-b from Lukas Wunner for EEH
- Improve commit message for EEH (Lukas Wunner)
- Move the EEH patch to the end so the reference to s390 relies on the
  as is and not future state ;)
- Link to v4: https://lore.kernel.org/r/20250807-add_err_uevents-v4-0-c624bfd8638d@linux.ibm.com

Changes in v4:
- Add change in EEH to use the return of error_detected() in the uevent
  just like AER and the new s390 code
- Add R-b from Lukas
- Link to v3: https://lore.kernel.org/r/20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com

Changes in v3:
- Reworded cover letter
- Rebase on v6.16
- Link to v2: https://lore.kernel.org/r/20250623-add_err_uevents-v2-0-a3a2cf8e711d@linux.ibm.com

Changes in v2:
- Add a patch fixing pci_uevent_ers() mistakenly ignoring PCI_ERS_RESULT_NEED_RESET
- Use the result of error_detected() for initial pci_uevent_ers()
- Drop fixes tag in s390 patch
- Rebase and re-test on current master
- Link to v1: https://lore.kernel.org/r/20250424-add_err_uevents-v1-1-3384d6b779c6@linux.ibm.com

---
Niklas Schnelle (3):
      PCI/AER: Fix missing uevent on recovery when a reset is requested
      PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI recovery
      powerpc/eeh: Use result of error_detected() in uevent

 arch/powerpc/kernel/eeh_driver.c | 2 +-
 arch/s390/pci/pci_event.c        | 3 +++
 drivers/pci/pci-driver.c         | 3 ++-
 include/linux/pci.h              | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250417-add_err_uevents-6f8d4d7ce09c

Best regards,
-- 
Niklas Schnelle


