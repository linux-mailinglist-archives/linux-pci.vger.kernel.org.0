Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403574FE3D7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355090AbiDLOdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 10:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356530AbiDLOdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 10:33:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81725EDE2;
        Tue, 12 Apr 2022 07:30:49 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CDLtmX004723;
        Tue, 12 Apr 2022 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=QSHM0oxExdbhayixQq7iHtGg4wt5j6coomtsY+MuPbA=;
 b=alBd6kVi/b5xYwBl2wvuR38XhD+1hJb0JvkBZ1NJ1yvtGzd+k3bYmJshduaOsvVBcOiR
 4LinAs+EduWt9rKJXkiN4smfXnS6mtBruiRaCY1zfXhXEEZcgS2HyZ5F02lC1n4sIdaF
 DTOnIwe6TArl9E+n9zWeVwv54P3ITCl9+HOIG1WDEN0cxyBzP2NfrBROjGc7OAYmHsu4
 KbS7UMDt6oZvoWrKtocr88Ztu+VDSZv3/IHK4tDKmbEEzNgI0OeA8yIC9BAsTGHF8AVg
 FF99mv991Dki2rzU0pdWd+APdwhBKy9LbdmzSgfBuklP339JiIs3+O7Cs6pPmsEaOOHj +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fda8c1qk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:46 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CDWlS2017780;
        Tue, 12 Apr 2022 14:30:45 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fda8c1qjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:45 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CEE0Ni015594;
        Tue, 12 Apr 2022 14:30:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3fb1s8w1xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CEUeFV39780768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 14:30:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A7F652051;
        Tue, 12 Apr 2022 14:30:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 499B852059;
        Tue, 12 Apr 2022 14:30:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: Rework pci_scan_slot() and isolated PCI functions
Date:   Tue, 12 Apr 2022 16:30:36 +0200
Message-Id: <20220412143040.1882096-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WdETDubwFZOK-CjY7aC52NqIjxExDoMo
X-Proofpoint-GUID: oMRfQ2AwTail3vxSO-Ug0xYdcKmHOegB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_05,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=724 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Thanks,
Niklas

[0] https://lore.kernel.org/linux-pci/20220404095346.2324666-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/linux-pci/20220408224514.GA353445@bhelgaas/

Niklas Schnelle (4):
  PCI: Clean up pci_scan_slot()
  PCI: Move jailhouse's isolated function handling to pci_scan_slot()
  PCI: Extend isolated function probing to s390
  s390/pci: allow zPCI zbus without a function zero

 arch/s390/pci/pci_bus.c    | 82 ++++++++++----------------------------
 drivers/pci/probe.c        | 60 ++++++++++------------------
 include/linux/hypervisor.h |  9 +++++
 3 files changed, 51 insertions(+), 100 deletions(-)

-- 
2.32.0

