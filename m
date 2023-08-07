Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D082771A06
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 08:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHGGLb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 02:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGGLa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 02:11:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF7B10F9;
        Sun,  6 Aug 2023 23:11:27 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37765frh001989;
        Mon, 7 Aug 2023 06:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=v6bVsBRvYVg98O9RgVNLDY/D+1vwMKKtfASX5Dxrvy0=;
 b=FAEH190pAZ5MMi35ewFtybWMMO6vZWQMeRyYZXJZkldQpVfvqC0cGg5NeznrkBOcrZac
 v4SjynkQYtjuPPIqxXfBPUbo8U618EuTR9s8MesWFrH2BQp7OF93qsmZZlisJ33gudE5
 yXbdXb1qQ0W6Spru8FLvhMvmVTeBMqn2objrn2q7ZOlJE4x3yOBkAeaA9ZvXLG+Y7DQB
 lXDZhqAhseW3PSsWrQfc6CR0UwtLPHm34WdOJoLmyLERuze2MpoUHpo0XCvAZ16VLrY+
 A0ZpmLM0SJLv2N5HOIyFxrUZa1CNbBo81LnAjVCArIhNOsJyXIyjBwSO9FBJ6vxYdKr2 zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sau1s08hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:11:21 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37766EXv004571;
        Mon, 7 Aug 2023 06:11:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sau1s082e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:11:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3774rV0W001592;
        Mon, 7 Aug 2023 06:11:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa2yjj4va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:11:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3776B1nX39780628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Aug 2023 06:11:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2876520043;
        Mon,  7 Aug 2023 06:11:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB88920040;
        Mon,  7 Aug 2023 06:10:59 +0000 (GMT)
Received: from [9.109.248.226] (unknown [9.109.248.226])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  7 Aug 2023 06:10:59 +0000 (GMT)
Subject: [PATCH v8 1/2] powerpc/rtas: Rename rtas_error_rc to
 rtas_generic_errno
From:   Mahesh Salgaonkar <mahesh@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Aug 2023 11:40:59 +0530
Message-ID: <169138864808.65607.6576358707894823512.stgit@jupiter>
User-Agent: StGit/1.5
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OhR9Ycvb8fZTOPfJRfuXemztRrpSS7dk
X-Proofpoint-GUID: i8xOCyeWt4q0P0j14EtDWGRKX6-frePv
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=866 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070055
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

rtas_generic_errno() function will convert the generic rtas return codes
into errno. Also, #define descriptive names for rtas return codes and use
it instead of numeric values.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
---

(no changes since v7)

Change in V7:
- Until v6 there was only one patch with subject "PCI hotplug: rpaphp:
  Error out on busy status from get-sensor-state". Starting from v7, adding
  this new patch to introduce rtas_generic_errno() to handle generic rtas
  error codes.
  https://lore.kernel.org/all/20220429162545.GA79541@bhelgaas/
---
 arch/powerpc/include/asm/rtas.h |   10 +++++++
 arch/powerpc/kernel/rtas.c      |   53 ++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 3abe15ac79db1..5572a0a2f6e18 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -202,7 +202,9 @@ typedef struct {
 #define RTAS_USER_REGION_SIZE (64 * 1024)
 
 /* RTAS return status codes */
-#define RTAS_BUSY		-2    /* RTAS Busy */
+#define RTAS_HARDWARE_ERROR	(-1)  /* Hardware Error */
+#define RTAS_BUSY		(-2)  /* RTAS Busy */
+#define RTAS_INVALID_PARAMETER	(-3)  /* Invalid indicator/domain/sensor etc. */
 #define RTAS_EXTENDED_DELAY_MIN	9900
 #define RTAS_EXTENDED_DELAY_MAX	9905
 
@@ -212,6 +214,11 @@ typedef struct {
 #define RTAS_THREADS_ACTIVE     -9005 /* Multiple processor threads active */
 #define RTAS_OUTSTANDING_COPROC -9006 /* Outstanding coprocessor operations */
 
+/* statuses specific to get-sensor-state */
+#define RTAS_SLOT_UNISOLATED		(-9000)
+#define RTAS_SLOT_NOT_UNISOLATED	(-9001)
+#define RTAS_SLOT_NOT_USABLE		(-9002)
+
 /* RTAS event classes */
 #define RTAS_INTERNAL_ERROR		0x80000000 /* set bit 0 */
 #define RTAS_EPOW_WARNING		0x40000000 /* set bit 1 */
@@ -425,6 +432,7 @@ extern int rtas_set_indicator(int indicator, int index, int new_value);
 extern int rtas_set_indicator_fast(int indicator, int index, int new_value);
 extern void rtas_progress(char *s, unsigned short hex);
 int rtas_ibm_suspend_me(int *fw_status);
+int rtas_generic_errno(int rtas_rc);
 
 struct rtc_time;
 extern time64_t rtas_get_boot_time(void);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index c087eeee320ff..80b6099e8ce20 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1330,33 +1330,34 @@ bool __ref rtas_busy_delay(int status)
 }
 EXPORT_SYMBOL_GPL(rtas_busy_delay);
 
-static int rtas_error_rc(int rtas_rc)
+int rtas_generic_errno(int rtas_rc)
 {
 	int rc;
 
 	switch (rtas_rc) {
-		case -1: 		/* Hardware Error */
-			rc = -EIO;
-			break;
-		case -3:		/* Bad indicator/domain/etc */
-			rc = -EINVAL;
-			break;
-		case -9000:		/* Isolation error */
-			rc = -EFAULT;
-			break;
-		case -9001:		/* Outstanding TCE/PTE */
-			rc = -EEXIST;
-			break;
-		case -9002:		/* No usable slot */
-			rc = -ENODEV;
-			break;
-		default:
-			pr_err("%s: unexpected error %d\n", __func__, rtas_rc);
-			rc = -ERANGE;
-			break;
+	case RTAS_HARDWARE_ERROR:	/* Hardware Error */
+		rc = -EIO;
+		break;
+	case RTAS_INVALID_PARAMETER:	/* Bad indicator/domain/etc */
+		rc = -EINVAL;
+		break;
+	case RTAS_SLOT_UNISOLATED:	/* Isolation error */
+		rc = -EFAULT;
+		break;
+	case RTAS_SLOT_NOT_UNISOLATED:	/* Outstanding TCE/PTE */
+		rc = -EEXIST;
+		break;
+	case RTAS_SLOT_NOT_USABLE:	/* No usable slot */
+		rc = -ENODEV;
+		break;
+	default:
+		pr_err("%s: unexpected error %d\n", __func__, rtas_rc);
+		rc = -ERANGE;
+		break;
 	}
 	return rc;
 }
+EXPORT_SYMBOL(rtas_generic_errno);
 
 int rtas_get_power_level(int powerdomain, int *level)
 {
@@ -1370,7 +1371,7 @@ int rtas_get_power_level(int powerdomain, int *level)
 		udelay(1);
 
 	if (rc < 0)
-		return rtas_error_rc(rc);
+		return rtas_generic_errno(rc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(rtas_get_power_level);
@@ -1388,7 +1389,7 @@ int rtas_set_power_level(int powerdomain, int level, int *setlevel)
 	} while (rtas_busy_delay(rc));
 
 	if (rc < 0)
-		return rtas_error_rc(rc);
+		return rtas_generic_errno(rc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(rtas_set_power_level);
@@ -1406,7 +1407,7 @@ int rtas_get_sensor(int sensor, int index, int *state)
 	} while (rtas_busy_delay(rc));
 
 	if (rc < 0)
-		return rtas_error_rc(rc);
+		return rtas_generic_errno(rc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(rtas_get_sensor);
@@ -1424,7 +1425,7 @@ int rtas_get_sensor_fast(int sensor, int index, int *state)
 				    rc <= RTAS_EXTENDED_DELAY_MAX));
 
 	if (rc < 0)
-		return rtas_error_rc(rc);
+		return rtas_generic_errno(rc);
 	return rc;
 }
 
@@ -1466,7 +1467,7 @@ int rtas_set_indicator(int indicator, int index, int new_value)
 	} while (rtas_busy_delay(rc));
 
 	if (rc < 0)
-		return rtas_error_rc(rc);
+		return rtas_generic_errno(rc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(rtas_set_indicator);
@@ -1488,7 +1489,7 @@ int rtas_set_indicator_fast(int indicator, int index, int new_value)
 				    rc <= RTAS_EXTENDED_DELAY_MAX));
 
 	if (rc < 0)
-		return rtas_error_rc(rc);
+		return rtas_generic_errno(rc);
 
 	return rc;
 }


