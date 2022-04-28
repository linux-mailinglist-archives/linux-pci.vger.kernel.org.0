Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2C512DC5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 10:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343877AbiD1ILF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 04:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiD1IKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 04:10:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A245F8F2;
        Thu, 28 Apr 2022 01:07:29 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S7jBE9002377;
        Thu, 28 Apr 2022 08:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=P5GSW7S1bGcTV0o4nVQux7Wo07UtirM3gAsmxixkw3o=;
 b=sHRv7KOIs8uZcsib4SMqQi8jz+8RcDagMGlbGb/d8PqjOlpd9ScIAhDsl12yjPB/UCI9
 Hv3WU5HbNkRpYBEtf4xaNK4OgJTUwUfVD8oT9ZylTnfEuAKBVJscwj/vBaS0XC+aEnDh
 N4i4g+QgfrsccHR9L6kKHfGDl4cxzC0CVTTeho8O/NhtRggCj6/SJhS64uypy4zYGXck
 GOmI5BK9HFdB1BiIr0uN89mJlWgASvDEqZTERM49ZAiGxfQnhyipg+5HS2UQYC75DbpM
 ve9tECCXqQhE2ayCTrUsZ7ufA44daQ72QOPgfz4ft4zs7r2XLHKmWxWqrLKvYRJiYph/ /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqmk7u4y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 08:07:24 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23S7ehAa028779;
        Thu, 28 Apr 2022 08:07:24 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqmk7u4x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 08:07:23 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23S7ueke006684;
        Thu, 28 Apr 2022 08:07:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3fpuyg9k91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 08:07:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23S87IDa49545654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 08:07:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAC2C4C044;
        Thu, 28 Apr 2022 08:07:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 899C44C040;
        Thu, 28 Apr 2022 08:07:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Apr 2022 08:07:18 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v5 0/4]  PCI: Rework pci_scan_slot() and isolated PCI functions
Date:   Thu, 28 Apr 2022 10:07:14 +0200
Message-Id: <20220428080718.3094464-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Amv0XS3eBV8LnTTqsNza-I_OCTb8tSZF
X-Proofpoint-ORIG-GUID: OV4Ct2rHkptg9YL5dprTnuiiEJnWYj0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=762 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204280049
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

