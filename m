Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303F1334B9B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 23:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCJWbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 17:31:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231584AbhCJWac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 17:30:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AMPNIm164288;
        Wed, 10 Mar 2021 17:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=1iQoD3fd5RgR2RgIABs5t23f6KOHvmQUvhztTuamw7M=;
 b=F3iYUm0Wa8vf97RmOiyFDe5RdhYDm5NC201r1lY96Ieh8xz+xQK0AFJYcKQQMBAg39od
 ivDOzBFY1s0cUfUt801kfKgtZJYltoQMQ6dDxD4D7LneelzQ/+qiuGCQ3m4IFN5an9sK
 WfIDypg4/ZRWsVuV4VGmRMRB+LlyOhgwJwlhUyqHR58B+0e8QjupbfZleEMyGIJkfnMe
 t81WsxA/FGvkPWb1b/DrnfmIiOBmUBxTRncpDdr+URJHMAq0aFgjZPU/hAZ9waaRr1Ix
 mOKZzonG24dcLBDhCClFBEKvOBQ5pFwFk3AfhB6JvSybxnYPlwuiLNw3rLFwAhiGrmo1 qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3774mpm2cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:30:26 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12AMQLaM166441;
        Wed, 10 Mar 2021 17:30:25 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3774mpm2cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:30:25 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AMHQwa009210;
        Wed, 10 Mar 2021 22:30:25 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3768s2618x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 22:30:25 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AMUN2820381978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 22:30:23 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7806D6E056;
        Wed, 10 Mar 2021 22:30:23 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35D276E050;
        Wed, 10 Mar 2021 22:30:23 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 22:30:23 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mmc@linux.ibm.com,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH] rpadlpar: fix potential drc_name corruption in store functions
Date:   Wed, 10 Mar 2021 16:30:21 -0600
Message-Id: <20210310223021.423155-1-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_12:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1011 impostorscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100105
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both add_slot_store() and remove_slot_store() try to fix up the drc_name
copied from the store buffer by placing a NULL terminator at nbyte + 1
or in place of a '\n' if present. However, the static buffer that we
copy the drc_name data into is not zeored and can contain anything past
the n-th byte. This is problematic if a '\n' byte appears in that buffer
after nbytes and the string copied into the store buffer was not NULL
terminated to start with as the strchr() search for a '\n' byte will mark
this incorrectly as the end of the drc_name string resulting in a drc_name
string that contains garbage data after the n-th byte. The following
debugging shows an example of the drmgr utility writing "PHB 4543" to
the add_slot sysfs attribute, but add_slot_store logging a corrupted
string value.

[135823.702864] drmgr: drmgr: -c phb -a -s PHB 4543 -d 1
[135823.702879] add_slot_store: drc_name = PHB 4543°|<82>!, rc = -19

Fix this by NULL terminating the string when we copy it into our static
buffer by coping nbytes + 1 of data from the store buffer. The code has
already made sure that nbytes is not >= MAX_DRC_NAME_LEN and the store
buffer is guaranteed to be zeroed beyond the nth-byte of data copied
from the user. Further, since the string is now NULL terminated the code
only needs to change '\n' to '\0' when present.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/pci/hotplug/rpadlpar_sysfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index cdbfa5df3a51..375087921284 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -34,12 +34,11 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (nbytes >= MAX_DRC_NAME_LEN)
 		return 0;
 
-	memcpy(drc_name, buf, nbytes);
+	memcpy(drc_name, buf, nbytes + 1);
 
 	end = strchr(drc_name, '\n');
-	if (!end)
-		end = &drc_name[nbytes];
-	*end = '\0';
+	if (end)
+		*end = '\0';
 
 	rc = dlpar_add_slot(drc_name);
 	if (rc)
@@ -65,12 +64,11 @@ static ssize_t remove_slot_store(struct kobject *kobj,
 	if (nbytes >= MAX_DRC_NAME_LEN)
 		return 0;
 
-	memcpy(drc_name, buf, nbytes);
+	memcpy(drc_name, buf, nbytes + 1);
 
 	end = strchr(drc_name, '\n');
-	if (!end)
-		end = &drc_name[nbytes];
-	*end = '\0';
+	if (end)
+		*end = '\0';
 
 	rc = dlpar_remove_slot(drc_name);
 	if (rc)
-- 
2.27.0

