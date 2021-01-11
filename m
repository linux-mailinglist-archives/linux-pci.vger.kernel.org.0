Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4792F0F82
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jan 2021 10:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbhAKJyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 04:54:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728444AbhAKJyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 04:54:17 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10B9WFen015032;
        Mon, 11 Jan 2021 04:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=O1aHWxRMTkGLyiDkpdEfZ0bQIlK6a4X0sjNLBBGtuPo=;
 b=tVc2CdFZHRkIB8GyIMv18nMK5VTg8eVzQ99cuVKSuKaFbFr1PtBI5DHq72/D9VsY0r66
 xN4Eav/HVK2qPGHnf7ErUV+sUgqX37dFpEidEGxIu8e/r7oN42Cw1Ye92oKdbA0GKOso
 PdAYdhgecBmWWNDXKjV4NvyoZVeyJJtQU9Kx6zM8WHS2P/pICQZJXhMmumKU/dgoQkGx
 /4JlfV2idvw7CYteEysgv1q7E6QptNX0RqCfSTHJt/akjU2F1strWGYIIm7r7UdkhTRv
 pvtcnPrGlbxqI+gZsHEv86cVI1FTeNMkH+RG4RgVJKOjNB2ZiWiwK5tlofTz+f/k2OL7 bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360kg6srer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 04:53:37 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10B9WrB3016974;
        Mon, 11 Jan 2021 04:53:36 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360kg6srbs-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 04:53:36 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10B9W44V006893;
        Mon, 11 Jan 2021 09:39:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 35ydrd9qsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 09:39:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10B9cwt524445398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 09:38:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71FC4AE055;
        Mon, 11 Jan 2021 09:38:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29C2DAE045;
        Mon, 11 Jan 2021 09:38:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jan 2021 09:38:58 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: [RFC 0/1] PCI: s390 global attribute "UID Checking"
Date:   Mon, 11 Jan 2021 10:38:56 +0100
Message-Id: <20210111093857.24070-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-09_13:2021-01-07,2021-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110055
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Hi Kernel Hackers,

With the below patch I'm proposing to expose a global (i.e. not device
bound) runtime attribute of the s390 PCI implementation (zPCI) called
"UID Checking".  You can find some background information on what this
attribute means and why it is important at the end of this mail. The
reason I'm writing to you about it however is that this is the first
global PCI attribute we would like to expose to user space and I'm
searching for a good place to put it.
The proposed patch uses "/sys/bus/pci/zpci/uid_checking" which from
our perspective would be a great choice but I realize that there
currently are no platform specific attributes directly under
"/sys/bus/pci" so this clearly requires some discussion. What's your
thought on this and do you know of any other platform specific global
PCI attributes as I couldn't find any?

Best regards,
Niklas Schnelle

Background:
On s390 OSs always run under at least a machine level hypervisor
(LPAR).  Simpliefied by usually running from SAN this makes VM
migration possible at every level. For PCI this has created the need
to allow PCI IDs to be stable across machines and to be partly user
defined such that the setup of an existing VM on one machine can be
recreated on another machine.
In particular the Domain part of the PCI ID can be user defined by
setting a per device value called UID. Since this was a late addition
and isn't used by all OSs and since UIDs need to be unique if used as
Domains, there is an additional global platform supplied runtime value
called "UID Checking".  This value indicates if UIDs are guaranteed to
be unique and set which triggers Linux to use the UIDs as PCI Domains
otherwise PCI Domains are simply incremented as necessary.
This "UID Checking" setting is thus very important e.g. when deciding
how network interface names are generated as it indicates if the
domain part of the PCI ID will remain stable across reboots and
migrations.  Once exposed we will propose a patch to udev/systemd to
use the "UID Checking" attribute to prefer network interface names
which can be guaranteed to be stable and re-creatable for migration.

Niklas Schnelle (1):
  s390/pci: expose UID checking state in sysfs

 Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++++
 arch/s390/include/asm/pci.h             |  3 +++
 arch/s390/pci/pci.c                     |  4 +++
 arch/s390/pci/pci_sysfs.c               | 34 +++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

-- 
2.17.1

