Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7129F6DCF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 06:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKKFWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 00:22:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbfKKFWH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 00:22:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAB5HYge080355;
        Mon, 11 Nov 2019 00:21:49 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7057j18t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:49 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAB5KSgK085735;
        Mon, 11 Nov 2019 00:21:49 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7057j180-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:49 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAB5K73i030134;
        Mon, 11 Nov 2019 05:21:48 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2w5n35xs0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 05:21:48 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAB5Ll0244106194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 05:21:47 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60CCE2805A;
        Mon, 11 Nov 2019 05:21:47 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACAA82805C;
        Mon, 11 Nov 2019 05:21:46 +0000 (GMT)
Received: from ltcalpine2-lp18.aus.stglabs.ibm.com (unknown [9.40.195.201])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Nov 2019 05:21:46 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        tlfalcon@linux.ibm.com, nathanl@linux.ibm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 1/9] powerpc/pseries: Fix bad drc_index_start value parsing of drc-info entry
Date:   Sun, 10 Nov 2019 23:21:28 -0600
Message-Id: <1573449697-5448-2-git-send-email-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573449697-5448-1-git-send-email-tyreld@linux.ibm.com>
References: <1573449697-5448-1-git-send-email-tyreld@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=630 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110051
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ibm,drc-info property is an array property that contains drc-info
entries such that each entry is made up of 2 string encoded elements
followed by 5 int encoded elements. The of_read_drc_info_cell()
helper contains comments that correctly name the expected elements
and their encoding. However, the usage of of_prop_next_string() and
of_prop_next_u32() introduced a subtle skippage of the first u32.
This is a result of of_prop_next_string() returning a pointer to the
next property value which is not a string, but actually a (__be32 *).
As, a result the following call to of_prop_next_u32() passes over the
current int encoded value and actually stores the next one wrongly.

Simply endian swap the current value in place after reading the first
two string values. The remaining int encoded values can then be read
correctly using of_prop_next_u32().

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/of_helpers.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 6df192f..66dfd82 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -45,14 +45,14 @@ struct device_node *pseries_of_derive_parent(const char *path)
 int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
 			struct of_drc_info *data)
 {
-	const char *p;
+	const char *p = (char *)(*curval);
 	const __be32 *p2;
 
 	if (!data)
 		return -EINVAL;
 
 	/* Get drc-type:encode-string */
-	p = data->drc_type = (char*) (*curval);
+	data->drc_type = (char *)p;
 	p = of_prop_next_string(*prop, p);
 	if (!p)
 		return -EINVAL;
@@ -65,9 +65,7 @@ int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
 
 	/* Get drc-index-start:encode-int */
 	p2 = (const __be32 *)p;
-	p2 = of_prop_next_u32(*prop, p2, &data->drc_index_start);
-	if (!p2)
-		return -EINVAL;
+	data->drc_index_start = be32_to_cpu(*p2);
 
 	/* Get drc-name-suffix-start:encode-int */
 	p2 = of_prop_next_u32(*prop, p2, &data->drc_name_suffix_start);
-- 
2.7.4

