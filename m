Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5ED51BABF
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349871AbiEEImh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349935AbiEEImf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 04:42:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04BC49F08;
        Thu,  5 May 2022 01:38:54 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2458b0cM005238;
        Thu, 5 May 2022 08:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=P5GSW7S1bGcTV0o4nVQux7Wo07UtirM3gAsmxixkw3o=;
 b=tTAAV8xuSLnh6Us+nkfvtHpxXk0i37qFXgCnw/EYbWJMZniW2FQOZqmEUnn+HroOVIqO
 Dgdd69/0yjF9y7bPxShraMQqE32jKnOIjIpE9u2r+HIg5G+YTwUc3ufFz/tAg+tr4q+U
 yOxG8NL6AznM8TF7JXu8G5b9AkelyyMgRETnzpJYh9HnCMI/vMKCePYSpo9t1lEw5X4h
 Semr+uqzWlSIHlZaZhOwP8Qrc819S7F4P5OwMHCUC1ozYvPQKIs5wQQFvViDbsvYyHIX
 8PtcSP/q3Hbatyt+wmEBMxyzu66n0y5qG/JiG1KwBMN6LD8MZw92pgCQ1F+PKrgkb8oh MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvb7t0123-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:38:50 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2458cMkY009741;
        Thu, 5 May 2022 08:38:50 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvb7t011q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:38:49 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2458YhWw023280;
        Thu, 5 May 2022 08:38:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3frvr8nhhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:38:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2458PHuT29032934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 08:25:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A535C11C04A;
        Thu,  5 May 2022 08:38:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 612ED11C04C;
        Thu,  5 May 2022 08:38:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 May 2022 08:38:39 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH RESEND v5 0/4]  PCI: Rework pci_scan_slot() and isolated PCI functions
Date:   Thu,  5 May 2022 10:38:35 +0200
Message-Id: <20220505083839.1315705-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _99zPV2fmAPua7cJ73ySxwXNp0IBXSuS
X-Proofpoint-ORIG-GUID: iBLuncKSpOO4JoCZ8Pd93zbe-ere0TtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_02,2022-05-04_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=777
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

