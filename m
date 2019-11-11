Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B9BF6DD0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 06:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfKKFWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 00:22:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726823AbfKKFWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 00:22:08 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAB5HZAT155722;
        Mon, 11 Nov 2019 00:21:51 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w70vt91sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:51 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAB5HYar155526;
        Mon, 11 Nov 2019 00:21:50 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w70vt91rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:50 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAB5K7gv012861;
        Mon, 11 Nov 2019 05:21:49 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 2w5n35prwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 05:21:49 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAB5LntO49021190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 05:21:49 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11CAE28059;
        Mon, 11 Nov 2019 05:21:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CCC828058;
        Mon, 11 Nov 2019 05:21:48 +0000 (GMT)
Received: from ltcalpine2-lp18.aus.stglabs.ibm.com (unknown [9.40.195.201])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Nov 2019 05:21:48 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        tlfalcon@linux.ibm.com, nathanl@linux.ibm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 3/9] powerpc/pseries: Add cpu DLPAR support for drc-info property
Date:   Sun, 10 Nov 2019 23:21:30 -0600
Message-Id: <1573449697-5448-4-git-send-email-tyreld@linux.ibm.com>
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

Older firmwares provided information about Dynamic Reconfig
Connectors (DRC) through several device tree properties, namely
ibm,drc-types, ibm,drc-indexes, ibm,drc-names, and
ibm,drc-power-domains. New firmwares have the ability to present this
same information in a much condensed format through a device tree
property called ibm,drc-info.

The existing cpu DLPAR hotplug code only understands the older DRC
property format when validating the drc-index of a cpu during a
hotplug add. This updates those code paths to use the ibm,drc-info
property, when present, instead for validation.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 127 +++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index bbda646..967c5e1 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -407,17 +407,67 @@ static bool dlpar_cpu_exists(struct device_node *parent, u32 drc_index)
 	return found;
 }
 
+static bool drc_info_valid_index(struct device_node *parent, u32 drc_index)
+{
+	struct property *info;
+	struct of_drc_info drc;
+	const __be32 *value;
+	u32 index;
+	int count, i, j;
+
+	info = of_find_property(parent, "ibm,drc-info", NULL);
+	if (!info)
+		return false;
+
+	value = of_prop_next_u32(info, NULL, &count);
+
+	/* First value of ibm,drc-info is number of drc-info records */
+	if (value)
+		value++;
+	else
+		return false;
+
+	for (i = 0; i < count; i++) {
+		if (of_read_drc_info_cell(&info, &value, &drc))
+			return false;
+
+		if (strncmp(drc.drc_type, "CPU", 3))
+			break;
+
+		if (drc_index > drc.last_drc_index)
+			continue;
+
+		index = drc.drc_index_start;
+		for (j = 0; j < drc.num_sequential_elems; j++) {
+			if (drc_index == index)
+				return true;
+
+			index += drc.sequential_inc;
+		}
+	}
+
+	return false;
+}
+
 static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
 {
 	bool found = false;
 	int rc, index;
 
-	index = 0;
+	if (of_find_property(parent, "ibm,drc-info", NULL))
+		return drc_info_valid_index(parent, drc_index);
+
+	/* Note that the format of the ibm,drc-indexes array is
+	 * the number of entries in the array followed by the array
+	 * of drc values so we start looking at index = 1.
+	 */
+	index = 1;
 	while (!found) {
 		u32 drc;
 
 		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
 						index++, &drc);
+
 		if (rc)
 			break;
 
@@ -717,19 +767,52 @@ static int dlpar_cpu_remove_by_count(u32 cpus_to_remove)
 	return rc;
 }
 
-static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
+static int find_drc_info_cpus_to_add(struct device_node *cpus,
+				     struct property *info,
+				     u32 *cpu_drcs, u32 cpus_to_add)
 {
-	struct device_node *parent;
+	struct of_drc_info drc;
+	const __be32 *value;
+	u32 count, drc_index;
 	int cpus_found = 0;
-	int index, rc;
+	int i, j;
 
-	parent = of_find_node_by_path("/cpus");
-	if (!parent) {
-		pr_warn("Could not find CPU root node in device tree\n");
-		kfree(cpu_drcs);
+	if (!info)
 		return -1;
+
+	value = of_prop_next_u32(info, NULL, &count);
+	if (value)
+		value++;
+
+	for (i = 0; i < count; i++) {
+		of_read_drc_info_cell(&info, &value, &drc);
+		if (strncmp(drc.drc_type, "CPU", 3))
+			break;
+
+		drc_index = drc.drc_index_start;
+		for (j = 0; j < drc.num_sequential_elems; j++) {
+			if (dlpar_cpu_exists(cpus, drc_index))
+				continue;
+
+			cpu_drcs[cpus_found++] = drc_index;
+
+			if (cpus_found == cpus_to_add)
+				return cpus_found;
+
+			drc_index += drc.sequential_inc;
+		}
 	}
 
+	return cpus_found;
+}
+
+static int find_drc_index_cpus_to_add(struct device_node *cpus,
+				      u32 *cpu_drcs, u32 cpus_to_add)
+{
+	int cpus_found = 0;
+	int index, rc;
+	u32 drc_index;
+
 	/* Search the ibm,drc-indexes array for possible CPU drcs to
 	 * add. Note that the format of the ibm,drc-indexes array is
 	 * the number of entries in the array followed by the array
@@ -737,25 +820,25 @@ static int find_dlpar_cpus_to_add(u32 *cpu_drcs, u32 cpus_to_add)
 	 */
 	index = 1;
 	while (cpus_found < cpus_to_add) {
-		u32 drc;
+		rc = of_property_read_u32_index(cpus, "ibm,drc-indexes",
+						index++, &drc_index);
 
-		rc = of_property_read_u32_index(parent, "ibm,drc-indexes",
-						index++, &drc);
 		if (rc)
 			break;
 
-		if (dlpar_cpu_exists(parent, drc))
+		if (dlpar_cpu_exists(cpus, drc_index))
 			continue;
 
-		cpu_drcs[cpus_found++] = drc;
+		cpu_drcs[cpus_found++] = drc_index;
 	}
 
-	of_node_put(parent);
 	return cpus_found;
 }
 
 static int dlpar_cpu_add_by_count(u32 cpus_to_add)
 {
+	struct device_node *parent;
+	struct property *info;
 	u32 *cpu_drcs;
 	int cpus_added = 0;
 	int cpus_found;
@@ -767,7 +850,21 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
 	if (!cpu_drcs)
 		return -EINVAL;
 
-	cpus_found = find_dlpar_cpus_to_add(cpu_drcs, cpus_to_add);
+	parent = of_find_node_by_path("/cpus");
+	if (!parent) {
+		pr_warn("Could not find CPU root node in device tree\n");
+		kfree(cpu_drcs);
+		return -1;
+	}
+
+	info = of_find_property(parent, "ibm,drc-info", NULL);
+	if (info)
+		cpus_found = find_drc_info_cpus_to_add(parent, info, cpu_drcs, cpus_to_add);
+	else
+		cpus_found = find_drc_index_cpus_to_add(parent, cpu_drcs, cpus_to_add);
+
+	of_node_put(parent);
+
 	if (cpus_found < cpus_to_add) {
 		pr_warn("Failed to find enough CPUs (%d of %d) to add\n",
 			cpus_found, cpus_to_add);
-- 
2.7.4

