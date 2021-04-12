Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6F35C80E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 15:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbhDLN7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 09:59:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238985AbhDLN7a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 09:59:30 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CDYJqD089060;
        Mon, 12 Apr 2021 09:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=I1xA9fWP2JmdBLLvaqDSq+m+noRiKWAJdZxVpnmKDns=;
 b=sPUs5pZT2isL3u8zLcv4x/SPnOlxbFY8OIWZJRAQrG7KhOCE6Ej5jaDu6B9LPFjFYOZh
 7B34vXLlU1Rz+JYYekmVYIbMYNGTu8t+LZ0yj7HV7PE/NHO2R/eL7g7QgzPBaG/K/YMs
 1clQmA/d3e6ujiQPOX6Y8fDWJ9Mo/jU7tIb3QtwIE4q69SwobEPtta3CXmAXf7vxZQNI
 kyUKjMfpBwakyXNtFo7VP6+GbNZt/7bWsOw54GcEJfnxL2ZGdr74eR/kKpWbpWfei/HU
 drjzCuJ4HUP4XlmEZdU6AlxFloxrdiJQ77+5ED9bHtqoOgUxp35NwEC4g5tPIignbAIh hQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vkdfsvxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 09:59:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CDvvVp013283;
        Mon, 12 Apr 2021 13:59:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 37u3n8sv4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 13:59:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CDx6VU49807676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 13:59:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0823B42041;
        Mon, 12 Apr 2021 13:59:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A241142042;
        Mon, 12 Apr 2021 13:59:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 13:59:05 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Narendra K <narendra_k@dell.com>
Cc:     Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: =?UTF-8?q?=5BPATCH=200/1=5D=20Use=20of=20/sys/bus/pci/devices/=E2=80=A6/index=20for=20non-SMBIOS=20platforms?=
Date:   Mon, 12 Apr 2021 15:59:04 +0200
Message-Id: <20210412135905.1434249-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TstaIQiXbtlWMLpJanMJ3PdnICOXAcz1
X-Proofpoint-ORIG-GUID: TstaIQiXbtlWMLpJanMJ3PdnICOXAcz1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_10:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120091
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Narendra, Hi All,

According to Documentation/ABI/testing/sysfs-bus-pci you are responsible
for the index device attribute that is used by systemd to create network
interface names.

Now we would like to reuse this attribute for firmware provided PCI
device index numbers on the s390 architecture which doesn't have
SMBIOS/DMI nor ACPI. All code changes are within our architecture
specific code but I'd like to get some Acks for this reuse. I've sent an
RFC version of this patch on 15th of March with the subject:

   s390/pci: expose a PCI device's UID as its index

but got no response. Would it be okay to re-use this attribute for
essentially the same purpose but with index numbers provided by
a different platform mechanism? I think this would be cleaner than
further proliferation of /sys/bus/pci/devices/<dev>/xyz_index
attributes and allows re-use of the existing userspace infrastructure.

Thanks,
Niklas Schnelle

Niklas Schnelle (1):
  s390/pci: expose a PCI device's UID as its index

 Documentation/ABI/testing/sysfs-bus-pci | 11 +++++---
 arch/s390/pci/pci_sysfs.c               | 35 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.25.1

