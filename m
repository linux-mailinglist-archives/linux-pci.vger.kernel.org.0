Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB42F53B73F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiFBKan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiFBKaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 06:30:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7395068FAC;
        Thu,  2 Jun 2022 03:30:25 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2529maG9025906;
        Thu, 2 Jun 2022 10:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=P5GSW7S1bGcTV0o4nVQux7Wo07UtirM3gAsmxixkw3o=;
 b=EkvTGvCAyrrcTolf7U6JtrfwaZC89H+2Pc3pXRmvTtwdCsg7GKqjk9aNJn5AUcP+yWhz
 2/EER8qC7vU7uB8zj63ArEppDQErvJiyJprR2Ij5+aGgGP+4k1YqesgdoFxM0kJXrDB1
 0RJcE6uLj401t5a5XVfBDKN6O7JLmDysqE9SKe7ZhJvl2IqsYXfd/U8za00MB376Xwnu
 4wJxp0UP9zHzo/vxASZNvaNiEEdq3AyJK/GAbjEN9OvrI9L13s8hEGdbfLlT/nPvFGfp
 TpmkTe+yT7TQ2bLPJjnLxyhkumrYek08k0Qi3bfCltHeEFACVm997Eq6OUH5a813IxWK 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3getwcgpvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:22 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 252AUEPO032096;
        Thu, 2 Jun 2022 10:30:22 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3getwcgpus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 252AKCO2030097;
        Thu, 2 Jun 2022 10:30:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3gdnetthcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 252AUGSP15532394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jun 2022 10:30:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C678A4040;
        Thu,  2 Jun 2022 10:30:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3008CA4055;
        Thu,  2 Jun 2022 10:30:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jun 2022 10:30:16 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 0/4]  PCI: Rework pci_scan_slot() and isolated PCI functions
Date:   Thu,  2 Jun 2022 12:30:12 +0200
Message-Id: <20220602103016.1499031-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1y2APSimufeVSDJ1XvyZ1vUJW44hCiF-
X-Proofpoint-ORIG-GUID: iiizanPZKKKYT0rOTOReoknxm-Xm9NTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxlogscore=766 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206020042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Hi Jan,

In an earlier version[0], I sought to apply the existing jailhouse special case
for isolated PCI functions to s390. As Bjorn noted in[1] there appears to be
some potential for cleaning things up and removing duplication though.

This series attempts to do this cleanup (Patches 1 and 2) followed by enabling
isolated PCI functions for s390 (Patches 3 and 4). If need be I can of course
split the cleanup off but for now I kept it as one as that's what I have
been testing.

Testing:
- On s390 with SR-IOV and a ConnectX NIC with PF 1 but not PF 0 passed throug
  i.e. the isolated function case. Also of course with just VFs and an NVMe.
- On x86_64 on a desktop system where ARI is disabled and with an SR-IOV NIC
  with non-contiguous VFs as well as the usual other PCI devices.

Thanks,
Niklas

Changes v4 -> v5:
- Remove unintended whitespace change in patch 1
Changes v3 -> v4:
- Use a do {} while loop in pci_scan_slot() as it is simpler (Bjorn)
- Explicitly check "fn == 0" as it is not a pointer or bool (Bjorn)
- Keep the "!dev" check in the ARI branch of next_fn() (Bjorn)
- Moved the "fn == 0 && !dev" condition out of next_fn() into pci_scan_slot().
  This allows us to keep the "!dev" case in the ARI branch and means there are
  no new conditions in next_fn() making it easier to verify that its behavior
  is equivalent to the existing code.
- Guard the assignment of dev->multifunction with "fn > 0"
  instead of "nr > 0". This matches the existing logic more closely and works
  for the jailhouse case which unconditionally sets dev->multifunction for
  "fn > 0". This also means fn == 0 is the single "first iteration" test.
- Remove some unneeded whitespace in patch 2

Changes v2 -> v3:
- Removed now unused nr_devs variable (kernel test robot)

Niklas Schnelle (4):
  PCI: Clean up pci_scan_slot()
  PCI: Move jailhouse's isolated function handling to pci_scan_slot()
  PCI: Extend isolated function probing to s390
  s390/pci: allow zPCI zbus without a function zero

 arch/s390/pci/pci_bus.c    | 82 ++++++++++----------------------------
 drivers/pci/probe.c        | 64 +++++++++++++----------------
 include/linux/hypervisor.h |  8 ++++
 3 files changed, 55 insertions(+), 99 deletions(-)

-- 
2.32.0

