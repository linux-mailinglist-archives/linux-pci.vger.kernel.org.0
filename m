Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FC650B874
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447968AbiDVNcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382090AbiDVNcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 09:32:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902C0583BA;
        Fri, 22 Apr 2022 06:29:08 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MD13mr017475;
        Fri, 22 Apr 2022 13:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6/WQleWzBeacBOxE0QPY0rywH7q5l/js+j2kCDej7vM=;
 b=KR6Oc94cWxDvef5FSHbXStRL0A6ogA3nYh3PwCgi+qTJOr1WcFIlkpf8EdMzFLWxqfGe
 AhsiTTh6LJwnbkBE9FL9J3DmbcWRpB01j5eKTxg16XHj5nildV8SB9ZC1IsT0DsxHI6h
 +lRAJaVIBf2Q7z62h2hKD/Mt79VblGDy6FSoMJytcyEVc+CZflqEdD/ujAdAGEFxkJQk
 Br1iZiIgozaBXI787p55Sy+T2N5N8te1f3Fy62nyRJxhwrD8wcSCr3koZOSErAURMnGy
 cArfs4BV2ah1eHX22rRudEkxRza8oEbdEk2t5QSmlxLXONSZS/h+s/twTWEpXkYSDC6b RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2jrp9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:04 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MDQYgs011962;
        Fri, 22 Apr 2022 13:29:04 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2jrp94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:04 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MDLxrU004710;
        Fri, 22 Apr 2022 13:29:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3ffn2hyg2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MDSweC47645114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 13:28:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8CEB4203F;
        Fri, 22 Apr 2022 13:28:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 624A742041;
        Fri, 22 Apr 2022 13:28:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 13:28:58 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 0/4] PCI: Rework pci_scan_slot() and isolated PCI functions
Date:   Fri, 22 Apr 2022 15:28:54 +0200
Message-Id: <20220422132858.1213022-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BiJXaFwkOKe_yRa1zN6quDcUVUuP-_oO
X-Proofpoint-ORIG-GUID: oo_Spt01SqxbkLM4ZXlTzAPa7-O5nQzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_03,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=753 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/pci/probe.c        | 65 +++++++++++++-----------------
 include/linux/hypervisor.h |  8 ++++
 3 files changed, 56 insertions(+), 99 deletions(-)

-- 
2.32.0

