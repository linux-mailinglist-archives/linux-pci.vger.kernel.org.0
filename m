Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9A30EFDC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 10:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhBDJol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 04:44:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233668AbhBDJol (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 04:44:41 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1149ZJJo169754;
        Thu, 4 Feb 2021 04:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=CQWMxx1hmeEzZhBunnvHM8lC+epV/QzR0n+V3uXocnA=;
 b=K0XRuCMP+ibOb/RUkSXGLHh+ug1O/wObOV/S8gy3RFl0R+atX69AnKWc+EzgDa0lz0HH
 V2Lj5XtfLjgvGGa5qrXmh9Mg4BPZpmHqFLdwHQs08zt+hHywjRN9H9N10gGHs4EPG9uP
 /SmnyplZB7DtFPmVxY6QNqoYNBhwJFXrKezYajoNRlP8wuTtFGOdNRxrJkY0Shtfn/ae
 zxjt4GqxftBOCtPTF7UAmlM6J46eeXm2AqXif7Sgbnw5chTv2wLTDXSeGVChRAHKKOtI
 RhvzmffBWLChHlFts39TAuKRSMJZjh9sfcD5ky797zjb3D7RKUdBo3nCP4TdLyVGPqBI RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gddfj80k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 04:43:59 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1149b0rG178779;
        Thu, 4 Feb 2021 04:43:59 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gddfj7yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 04:43:59 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1149hvHC001971;
        Thu, 4 Feb 2021 09:43:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 36g8ker4ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 09:43:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1149hjDR28180982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 09:43:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EDB242045;
        Thu,  4 Feb 2021 09:43:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B74E242047;
        Thu,  4 Feb 2021 09:43:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 09:43:53 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: [RFC v2 0/1] s390/pci: expose UID checking state in sysfs
Date:   Thu,  4 Feb 2021 10:43:52 +0100
Message-Id: <20210204094353.63819-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_05:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040060
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

this is a follow-up to my previous RFC of exposing our s390 specific UID
Checking attribute at /sys/bus/pci/zpci/unique_uids. As suggested by Greg
(thanks!) this version changes things to use named attributes directly without
resorting to any raw kobject handling, as a result the code moves to
drivers/pci/pci-sysfs.c with a CONFIG_S390 ifdef. Also I've changed the wording
to be more restrictive about what this attribute means. Instead of directly
calling out its current use to determine if UIDs are used as PCI domains it now
only explicitly claims that /sys/bus/pci/devices/<dev>/uid is guaranteed to be
a unique user-defined (in the zVM/KVM/LPAR configuration not Linux user-space)
identifier for the PCI function.

We've had some more internal discussion on this and are also considering to
instead put this attribute at /sys/firmware/zpci/unique_uids but as far as
I can see this strictly requires the use of raw kobject handling and loses us
the direct relation with PCI so I wanted to give this just one more shot and
get your opinion on it.

Thanks,
Niklas


Niklas Schnelle (1):
  PCI: Add s390 specific UID uniqueness attribute

 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.17.1

