Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26423F6DD1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 06:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKKFWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 00:22:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfKKFWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 00:22:08 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAB5HZFT155708;
        Mon, 11 Nov 2019 00:21:56 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w70vt91va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:56 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAB5HaKu155789;
        Mon, 11 Nov 2019 00:21:55 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w70vt91ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:55 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAB5K6PD020147;
        Mon, 11 Nov 2019 05:21:54 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2w5n35xs6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 05:21:54 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAB5Lss838207838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 05:21:54 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F161828058;
        Mon, 11 Nov 2019 05:21:53 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4933128059;
        Mon, 11 Nov 2019 05:21:53 +0000 (GMT)
Received: from ltcalpine2-lp18.aus.stglabs.ibm.com (unknown [9.40.195.201])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Nov 2019 05:21:53 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        tlfalcon@linux.ibm.com, nathanl@linux.ibm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 8/9] PCI: rpaphp: Correctly match ibm,my-drc-index to drc-name when using drc-info
Date:   Sun, 10 Nov 2019 23:21:36 -0600
Message-Id: <1573449697-5448-10-git-send-email-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573449697-5448-1-git-send-email-tyreld@linux.ibm.com>
References: <1573449697-5448-1-git-send-email-tyreld@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110051
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The newer ibm,drc-info property is a condensed description of the old
ibm,drc-* properties (ie. names, types, indexes, and power-domains).
When matching a drc-index to a drc-name we need to verify that the
index is within the start and last drc-index range and map it to a
drc-name using the drc-name-prefix and logical index.

Fix the mapping by checking that the index is within the range of the
current drc-info entry, and build the name from the drc-name-prefix
concatenated with the starting drc-name-suffix value and the sequential
index obtained by subtracting ibm,my-drc-index from this entries
drc-start-index.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/pci/hotplug/rpaphp_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 129534c..951f7f2 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -248,9 +248,10 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 		/* Should now know end of current entry */
 
 		/* Found it */
-		if (my_index <= drc.last_drc_index) {
+		if (my_index >= drc.drc_index_start && my_index <= drc.last_drc_index) {
+			int index = my_index - drc.drc_index_start;
 			sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
-				my_index);
+				drc.drc_name_suffix_start + index);
 			break;
 		}
 	}
-- 
2.7.4

