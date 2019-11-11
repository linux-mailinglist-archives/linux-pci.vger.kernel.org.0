Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F12FF6DD3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 06:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfKKFWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 00:22:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51922 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726824AbfKKFWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 00:22:08 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAB5HXlU171141;
        Mon, 11 Nov 2019 00:21:51 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5s551q76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:51 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAB5HZiJ171257;
        Mon, 11 Nov 2019 00:21:50 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5s551q6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:50 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAB5K6oM005493;
        Mon, 11 Nov 2019 05:21:48 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 2w5n35t78t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 05:21:48 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAB5LmS238732234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 05:21:48 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 394702805E;
        Mon, 11 Nov 2019 05:21:48 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 849DE2805C;
        Mon, 11 Nov 2019 05:21:47 +0000 (GMT)
Received: from ltcalpine2-lp18.aus.stglabs.ibm.com (unknown [9.40.195.201])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Nov 2019 05:21:47 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        tlfalcon@linux.ibm.com, nathanl@linux.ibm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 2/9] powerpc/pseries: Fix drc-info mappings of logical cpus to drc-index
Date:   Sun, 10 Nov 2019 23:21:29 -0600
Message-Id: <1573449697-5448-3-git-send-email-tyreld@linux.ibm.com>
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

There are a couple subtle errors in the mapping between cpu-ids and a
cpus associated drc-index when using the new ibm,drc-info property.

The first is that while drc-info may have been a supported firmware
feature at boot it is possible we have migrated to a CEC with older
firmware that doesn't support the ibm,drc-info property. In that case
the device tree would have been updated after migration to remove the
ibm,drc-info property and replace it with the older style ibm,drc-*
properties for types, indexes, names, and power-domains. PAPR even
goes as far as dictating that if we advertise support for drc-info
that we are capable of supporting either property type at runtime.

The second is that the first value of the ibm,drc-info property is
the int encoded count of drc-info entries. As such "value" returned
by of_prop_next_u32() is pointing at that count, and not the first
element of the first drc-info entry as is expected by the
of_read_drc_info_cell() helper.

Fix the first by ignoring DRC-INFO firmware feature and instead
testing directly for ibm,drc-info, and then falling back to the
old style ibm,drc-indexes in the case it doesn't exit.

Fix the second by incrementing value to the next element prior to
parsing drc-info entries.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/pseries_energy.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index a96874f..09e98d3 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -36,6 +36,7 @@ static int sysfs_entries;
 static u32 cpu_to_drc_index(int cpu)
 {
 	struct device_node *dn = NULL;
+	struct property *info;
 	int thread_index;
 	int rc = 1;
 	u32 ret = 0;
@@ -47,20 +48,18 @@ static u32 cpu_to_drc_index(int cpu)
 	/* Convert logical cpu number to core number */
 	thread_index = cpu_core_index_of_thread(cpu);
 
-	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
-		struct property *info = NULL;
+	info = of_find_property(dn, "ibm,drc-info", NULL);
+	if (info) {
 		struct of_drc_info drc;
 		int j;
 		u32 num_set_entries;
 		const __be32 *value;
 
-		info = of_find_property(dn, "ibm,drc-info", NULL);
-		if (info == NULL)
-			goto err_of_node_put;
-
 		value = of_prop_next_u32(info, NULL, &num_set_entries);
 		if (!value)
 			goto err_of_node_put;
+		else
+			value++;
 
 		for (j = 0; j < num_set_entries; j++) {
 
@@ -110,6 +109,7 @@ static u32 cpu_to_drc_index(int cpu)
 static int drc_index_to_cpu(u32 drc_index)
 {
 	struct device_node *dn = NULL;
+	struct property *info;
 	const int *indexes;
 	int thread_index = 0, cpu = 0;
 	int rc = 1;
@@ -117,21 +117,18 @@ static int drc_index_to_cpu(u32 drc_index)
 	dn = of_find_node_by_path("/cpus");
 	if (dn == NULL)
 		goto err;
-
-	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
-		struct property *info = NULL;
+	info = of_find_property(dn, "ibm,drc-info", NULL);
+	if (info) {
 		struct of_drc_info drc;
 		int j;
 		u32 num_set_entries;
 		const __be32 *value;
 
-		info = of_find_property(dn, "ibm,drc-info", NULL);
-		if (info == NULL)
-			goto err_of_node_put;
-
 		value = of_prop_next_u32(info, NULL, &num_set_entries);
 		if (!value)
 			goto err_of_node_put;
+		else
+			value++;
 
 		for (j = 0; j < num_set_entries; j++) {
 
-- 
2.7.4

