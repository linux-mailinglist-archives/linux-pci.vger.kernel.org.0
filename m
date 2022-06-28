Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBCF55E71B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346619AbiF1ObP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345211AbiF1ObN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:31:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2A43123E;
        Tue, 28 Jun 2022 07:31:09 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SEHSFG003066;
        Tue, 28 Jun 2022 14:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Fn+4yQI4FI5DQIfDEpp5Q/cZNvdG9LB2yZSnfKlqZPg=;
 b=qx5HCfFspgoKajlgbiMe1uXS6Fy+TRV0A6GrG6JzvuYRzpZGWzNyAEnRBN5D1iRdP7yy
 XZWqtZighKoztHqlj3Eofbkd8SPMgdiB+hGoKTmKx/FeqtcEFOt2Ao4WB2nJP1U+U3Q+
 5mzrEefXxdKjXuahA6TVocxiYr1pHiDfASvtaP4ZdKJVdWEBkJ/MUXvpuaNk68pG3rkH
 FtpnVhhedqnWJw9UPR6pTWK8Qva85jNRfdUTX9LCcFt+Bp3EYH2T+EaJgsseC2mnVrgo
 VzhQ36dwQKzsB94ygPivENJFSjREEsM2Vq/PhPQLtByOh1lo4ueyvElZfUF/bEpEeM6S Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h039d8gcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:06 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25SEHphi005301;
        Tue, 28 Jun 2022 14:31:06 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h039d8gbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SEL0am007215;
        Tue, 28 Jun 2022 14:31:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt08w099-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SEV0wn24052146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 14:31:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8E39A405F;
        Tue, 28 Jun 2022 14:31:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7788AA4054;
        Tue, 28 Jun 2022 14:31:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jun 2022 14:31:00 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] PCI: Rework pci_scan_slot() and isolated PCI functions
Date:   Tue, 28 Jun 2022 16:30:55 +0200
Message-Id: <20220628143100.3228092-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vo2EDyzjxD1PkJ7VkejKTUTd_oGZnsq3
X-Proofpoint-GUID: 4uLeYoZvn_uiEhrtXqhJC6KMY7hSdf0L
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=710 priorityscore=1501 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

In an earlier version[0], I sought to apply the existing jailhouse special case
for isolated PCI functions to s390. As Bjorn noted in[1] there appears to be
some potential for cleaning things up and removing duplication.

This series attempts to do this cleanup (Patches 1 through 3) followed by enabling
isolated PCI functions for s390 (Patches 4 and 5).

Testing:
- On s390 with SR-IOV and a ConnectX NIC with PF 1 but not PF 0 passed throug
  i.e. the isolated function case. Also of course with just VFs and an NVMe.
- On x86_64 on a desktop system where ARI is disabled and with an SR-IOV NIC
  with non-contiguous VFs as well as the usual other PCI devices.

Thanks,
Niklas

[0] https://lore.kernel.org/linux-pci/20220404095346.2324666-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/linux-pci/20220408224514.GA353445@bhelgaas/

Changes v5 -> v6:
- Added a patch (2) which separates the ARI case into its own function
- Some whitespace changes to remove unnecesssary empty lines
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

Niklas Schnelle (5):
  PCI: Clean up pci_scan_slot()
  PCI: Split out next_ari_fn() from next_fn()
  PCI: Move jailhouse's isolated function handling to pci_scan_slot()
  PCI: Extend isolated function probing to s390
  s390/pci: allow zPCI zbus without a function zero

 arch/s390/pci/pci_bus.c    | 82 +++++++++---------------------------
 drivers/pci/probe.c        | 86 ++++++++++++++++++--------------------
 include/linux/hypervisor.h |  8 ++++
 3 files changed, 68 insertions(+), 108 deletions(-)

-- 
2.32.0

