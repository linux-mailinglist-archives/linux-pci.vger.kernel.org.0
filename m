Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16E032C283
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 01:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhCCUy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 15:54:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12234 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357308AbhCCKtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Mar 2021 05:49:22 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1239qSnq016127;
        Wed, 3 Mar 2021 04:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bEM35y539zYTdo9MMllIZYjN9DigfWFlSWBSMTVulRk=;
 b=YU5d30IzyI+2zGSUqXZKN3wWlFNPpE3w7f5x4wshBz2zjCPP/crEzFBbZKNFxdtUVSz5
 gO0SLa1OBsVvdswq7IfeIly8H+dvvootg6lVTaLgq6c2VEm0fUryu3TzTLo7rkcuj/OQ
 rCLC26MrFTCRffM49K8qQx4xgmORUQkkPe5zxmWnajH794pMBZRVqqfHUJYzat9kAfdn
 FYejBDOMqRuMI8TB/TNnkKLo4za/EiXfAPE/7RtPrKC569fPaRdjrJ/33kqEkWGk4x+n
 z6TNgx2LLAto3fHzly3ZwH0wBuSlmJ089OnYaHgmh5ZNczfPUmp5Vln2ITAkG0QtytBf hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37287281c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 04:52:58 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1239qf7p017753;
        Wed, 3 Mar 2021 04:52:58 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3728728164-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 04:52:58 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1239qJWc028806;
        Wed, 3 Mar 2021 09:52:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 370atn1ee1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 09:52:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1239qa1a37159250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 09:52:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B862042045;
        Wed,  3 Mar 2021 09:52:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6668242041;
        Wed,  3 Mar 2021 09:52:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Mar 2021 09:52:50 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Narendra K <narendra_k@dell.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [RFC 0/1] s390/pci: expose a PCI device's UID as its index
Date:   Wed,  3 Mar 2021 10:52:49 +0100
Message-Id: <20210303095250.1360007-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=897 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030072
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On s390 each PCI device has a user-defined ID (UID).  This ID was
designed to serve as the PCI device's primary index and to match the
device within Linux to the with the view in the hypervisor
configuration. To serve as a primary identifier the UID must be unique
within the Linux instance, this is guaranteed by the platform if and
only if the UID Uniqueness Checking flag is set within the CLP List PCI
Functions response which is also currently used to determine whether the
UID is also used as the Domain part of the geographical PCI address of
the device.

As primary identifier of a PCI device, the UID serves an analogous
function as the SMBIOS instance number or ACPI index exposed as the
"index" respectively "acpi_index" device attributes. These attributes
are used by e.g. systemd/udev to set network interface names. As s390
does not use  ACPI nor SMBIOS there is no conflict and we can expose the
UID under the "index" attribute whenever UID Uniqueness Checking is
active and systemd/udev will then create "eno<UID>.." interface names.

Note: This is an evolution of an earlier patch I sent for exposing the
UID Uniqueness Checking flag directly. Thank you Greg for making me
realize that we were looking too much at just exposing platform details
instead of looking how existing interfaces could suit our purpose.

Thanks,
Niklas Schnelle

Niklas Schnelle (1):
  s390/pci: expose a PCI device's UID as its index

 Documentation/ABI/testing/sysfs-bus-pci | 11 +++++---
 arch/s390/pci/pci_sysfs.c               | 36 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.25.1

