Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569B16AC472
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCFPK3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCFPK2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:10:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFD7211C3;
        Mon,  6 Mar 2023 07:10:22 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326F2R9L008709;
        Mon, 6 Mar 2023 15:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+14sP9f8QIkBnDyR0+mQdfQHrANh9wuc+OyuyAPcZdY=;
 b=VsDASiL3bEWu4EO70Ic3QMr5h/YPRjutAGsJRTqglwQIxmkt7+nVeRda4sgh8iPGm1S1
 FKsx5N/8bu0rdVFvtw9T4PfTCz7T+UAD2DOBnnJwtTJ7zP9p3o5nlO0x+4gC54ayoMrf
 iDkO3UoJrGQONh06MAJ88UvxSObncuf/+ilK19wsgZreXr2dUGGBmP7L+Jl+jRDjYh8X
 GC7f1FlLc59nKs/cv8U60+jdsI3AvWJkyyPkX/tgQUQrQSMZVuapClIslUdxaC8aZ0qC
 3iT3ih93FJlTKXs8RrS4A7d7GWOFStY3QonF9UWgD3fvWTAoQZCogPm3VVKEhJXVk+Ur Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4wsw9518-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:21 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326F7EMu028831;
        Mon, 6 Mar 2023 15:10:20 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4wsw950a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:20 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3264Y4nn004489;
        Mon, 6 Mar 2023 15:10:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p41b0t9v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326FAFrr50594158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 15:10:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6619320049;
        Mon,  6 Mar 2023 15:10:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C11620043;
        Mon,  6 Mar 2023 15:10:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 15:10:15 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: s390: Fix user-after-free and clean up
Date:   Mon,  6 Mar 2023 16:10:10 +0100
Message-Id: <20230306151014.60913-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wNLax_wMr7i0lbDxlP1-6JZFokVtAK3k
X-Proofpoint-GUID: 91_SXp-zoMTK7K878EwBLoHr_rRxeLjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=688 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Hi Lukas,

This is v2 of my fix for a use-after-free of PCI MMIO resources in the
s390 PCI layer. As Bjorn found some redundant pci_bus_add_device() uses
and function zero special treatment I've added 3 cleanup patches in
addition to the fix itself. These are independent but in my opinion make
it easier to see the struct zpci_dev interactions with the common PCI
code. If you prefer I can of course split them off. As discussed this
version still uses the pci_rescan_remove lock to allow backporting but
I'll be looking into adding a more specific resource lock as a follow up.

Thanks,
Niklas

Changes since v1:
- Added clean up patches inspired by Bjorn's questions
- Removed return at end of function returning void

Niklas Schnelle (4):
  PCI: s390: Fix use-after-free of PCI resources with per-function
    hotplug
  s390/pci: only add specific device in zpci_bus_scan_device()
  s390/pci: remove redundant pci_bus_add_devices() on new bus
  s390/pci: clean up left over special treatment for function zero

 arch/s390/pci/pci.c     | 39 +++++++++++++--------------------------
 arch/s390/pci/pci_bus.c | 16 ++++++----------
 arch/s390/pci/pci_bus.h |  3 +--
 drivers/pci/bus.c       | 21 +++++++++++++++++++++
 include/linux/pci.h     |  1 +
 5 files changed, 42 insertions(+), 38 deletions(-)

-- 
2.37.2

