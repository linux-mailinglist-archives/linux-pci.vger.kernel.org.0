Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A41C7533
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgEFPmI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 11:42:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729668AbgEFPmI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 11:42:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046F2Qod060973;
        Wed, 6 May 2020 11:42:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30uvm97051-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 11:42:01 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 046FdOPj007467;
        Wed, 6 May 2020 11:41:46 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30uvm9703w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 11:41:45 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 046FexB6027812;
        Wed, 6 May 2020 15:41:42 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5sg8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 15:41:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 046FeUs065732886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 May 2020 15:40:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08C35A404D;
        Wed,  6 May 2020 15:41:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D47A0A4055;
        Wed,  6 May 2020 15:41:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 May 2020 15:41:39 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [RFC 0/2] Enable PF-VF linking with pdev->no_vf_scan (s390)
Date:   Wed,  6 May 2020 17:41:37 +0200
Message-Id: <20200506154139.90609-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_07:2020-05-05,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=461 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060117
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

Best regards and your feedback is welcome,
Niklas Schnelle

Niklas Schnelle (2):
  PCI/IOV: Introduce pci_iov_sysfs_link() function
  s390/pci: create links between PFs and VFs

 arch/s390/include/asm/pci.h     |  3 +-
 arch/s390/include/asm/pci_clp.h |  3 +-
 arch/s390/pci/pci_bus.c         | 69 ++++++++++++++++++++++++++++++++-
 arch/s390/pci/pci_clp.c         |  1 +
 drivers/pci/iov.c               | 39 ++++++++++++-------
 include/linux/pci.h             |  8 ++++
 6 files changed, 105 insertions(+), 18 deletions(-)

-- 
2.17.1

