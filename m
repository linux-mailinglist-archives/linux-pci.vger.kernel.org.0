Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD41C85DB
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgEGJal (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 05:30:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgEGJal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 05:30:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04792QM0012767;
        Thu, 7 May 2020 05:30:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30uf8jwsvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 05:30:40 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04792Re7012875;
        Thu, 7 May 2020 05:30:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30uf8jwsuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 05:30:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0479Pfhf025142;
        Thu, 7 May 2020 09:30:37 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5u0n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 09:30:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0479UY7H58458566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 09:30:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F0A8A405F;
        Thu,  7 May 2020 09:30:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F34CA4055;
        Thu,  7 May 2020 09:30:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 09:30:34 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH 0/2] Enable PF-VF linking with pdev->no_vf_scan (s390)
Date:   Thu,  7 May 2020 11:30:32 +0200
Message-Id: <20200507093034.56143-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_04:2020-05-05,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=883 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070065
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Kernel Hackers,

the following series enables PF-VF linking for architectures using the
pdev->no_vf_scan flag (currently just s390). This includes kernel internal
linking with pdev->physfn as well as creation of the relevant sysfs links.
The former are required for example by libvirt to manage VFs.

The series consists of two patches against the featuress branch of
git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git

- PCI/IOV: Introduce pci_iov_sysfs_link() function

This patch factors the sysfs link creation out of pci_iov_add_virtfn() and
into a new pci_iov_sysfs_link() function. On its own it also applies
cleanly on v5.7-rc4.

- s390/pci: create links between PFs and VFs

This patch makes use of the pci_iov_sysfs_link() function introduced in the
first patch to create the sysfs PF-VF links. It exploits recent work for
multi-function support on s390 that gives us the real devfnto identify the
parent PF of a given VF.
Apart from these s390 specific support contained within arch/s390/ it also
removes the fencing off of pci_iov_remove_virtfn() by the pdev->no_vf_scan
flag making use of the common code path for clean VF removal.
While this is common code s390 is currently the only case where
pdev->no_vf_scan is true I can of course split this into a separate patch
if requested but wanted to keep this together for the discussion.
This patch will go via the s390 tree once the first patch landed.

Best regards and your feedback is welcome,
Niklas Schnelle

Changes since the RFC:
- Addressed commit message feedback (thanks Bjorn Helgaas)
- Addressed style feedback (thanks Bjorn Helgaas)
- Add Acked-by
- Fixed struct field name collision for reserved in second patch.
  (Was added as style fix).

Niklas Schnelle (2):
  PCI/IOV: Introduce pci_iov_sysfs_link() function
  s390/pci: create links between PFs and VFs

 arch/s390/include/asm/pci.h     |  3 +-
 arch/s390/include/asm/pci_clp.h |  3 +-
 arch/s390/pci/pci_bus.c         | 69 ++++++++++++++++++++++++++++++++-
 arch/s390/pci/pci_clp.c         |  1 +
 drivers/pci/iov.c               | 39 ++++++++++++-------
 include/linux/pci.h             |  8 ++++
 6 files changed, 106 insertions(+), 17 deletions(-)

-- 
2.17.1

