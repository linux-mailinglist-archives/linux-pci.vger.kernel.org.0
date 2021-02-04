Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBB830EFE1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 10:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhBDJop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 04:44:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234315AbhBDJol (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 04:44:41 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1149XtIm065989;
        Thu, 4 Feb 2021 04:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=tfb6Fkvp+Z82tZSPVDzQf4C8wqzxCA07JtAsUJkdV6M=;
 b=RK22oWOfA2YXbmKfPSvktV26f29tY8mAYPJJlRpdvqlFxX9hXwODjeuF5zvRwxy0TygW
 tbKsAZN1zkgjenB/mruXSUF+1gtjcvXWSgKTZajneSUdiU61WrTeQNe2s5LnZU9Ht0o9
 Jbt8AHUoI78BWIydTD/vM6Im9alt6xdbb9ddOmzjt4cmgts+eQktC6lRABCTUm3HtHNr
 PEC3JgWaHTzL5rFwTqrzfYUgf2A4CaSdoLEHrrbSXlLrsJHvPp2bQRBHAjvtZbEBN6sI
 SI7uehXRYCAaxnOtOrC07Z8f4td/plMAwYQ8SF1sgap32TjSYxpvFNrLo3tK9JGNgzGB ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gcu8jrej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 04:44:00 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11493hYF065573;
        Thu, 4 Feb 2021 04:43:59 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gcu8jrds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 04:43:59 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1149gxX3007373;
        Thu, 4 Feb 2021 09:43:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 36cy38afsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 09:43:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1149hjYR28180986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 09:43:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DC444204B;
        Thu,  4 Feb 2021 09:43:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C05042047;
        Thu,  4 Feb 2021 09:43:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 09:43:54 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: [RFC v2 1/1] PCI: Add s390 specific UID uniqueness attribute
Date:   Thu,  4 Feb 2021 10:43:53 +0100
Message-Id: <20210204094353.63819-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204094353.63819-1-schnelle@linux.ibm.com>
References: <20210204094353.63819-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_05:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040057
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The global UID uniqueness attribute exposes whether the platform
guarantees that the user-defined per-device UID attribute values
(/sys/bus/pci/device/<dev>/uid) are unique and can thus be used as
a global identifier for the associated PCI device. With this commit
it is exposed at /sys/bus/pci/zpci/unique_uids

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 25c9c39770c6..812dd9d3f80d 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -375,3 +375,12 @@ Description:
 		The value comes from the PCI kernel device state and can be one
 		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
 		The file is read only.
+What:		/sys/bus/pci/zpci/unique_uids
+Date:		February 2021
+Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
+Description:
+		This attribute exposes the global state of UID Uniqueness on an
+		s390 Linux system. If this file contains '1' the per-device UID
+		attribute is guaranteed to provide a unique user defined
+		identifier for that PCI device. If this file contains '0' UIDs
+		may collide and do not provide a unique identifier.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fb072f4b3176..61de66ab59cf 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -425,6 +425,24 @@ static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
 }
 static BUS_ATTR_WO(rescan);
 
+#if defined(CONFIG_S390)
+static ssize_t unique_uids_show(struct bus_type *bus, char *buf)
+{
+	return sprintf(buf, "%i\n", zpci_unique_uid);
+}
+static BUS_ATTR_RO(unique_uids);
+
+static struct attribute *zpci_bus_attrs[] = {
+	&bus_attr_unique_uids.attr,
+	NULL,
+};
+
+static struct attribute_group zpci_bus_group = {
+	.name = "zpci",
+	.attrs = zpci_bus_attrs,
+};
+#endif
+
 static struct attribute *pci_bus_attrs[] = {
 	&bus_attr_rescan.attr,
 	NULL,
@@ -436,6 +454,9 @@ static const struct attribute_group pci_bus_group = {
 
 const struct attribute_group *pci_bus_groups[] = {
 	&pci_bus_group,
+#if defined(CONFIG_S390)
+	&zpci_bus_group,
+#endif
 	NULL,
 };
 
-- 
2.17.1

