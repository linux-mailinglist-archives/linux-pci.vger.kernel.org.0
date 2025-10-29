Return-Path: <linux-pci+bounces-39624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B70C19799
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 10:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CF934F4A33
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF79832ABF6;
	Wed, 29 Oct 2025 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tlp0e8JM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FA32B9A2;
	Wed, 29 Oct 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730932; cv=none; b=YAM4WdPxUx+XwH37bJQ+FhaHy1fNXKe+ink1sjz6Q5hJE6+iXB8lvpzpVuq12a6Nxqyvjt0m+WFmkjo4ilQcav7fhH98A32FBUGqPrevT94hb+PK4zXuSbtX7gtB+fnJ+XJYDoby5L/dLyIEJjNeFYCcgaTIrlKfJyA3phzXIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730932; c=relaxed/simple;
	bh=dTkcEBl5gg6N/8Ckh8bxG5upJbEHSRnm22KBHzHO/xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGtFa7aWW9gKuqa1L66g/6HciwFQi1bUfvCjLzH8/6ERvf5lFrjEqlELW+eovO+wK2cI8QDJ4bNWZgtwMYIKHnXYGKW+rDV9NAX/mJUlYnAC2kiBGYdrozrJVY4jkNMAhC9l2hwpgbRyDVsIp/l5I/LFSOYfp+gZtoBTsu2OFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tlp0e8JM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJmRgo019719;
	Wed, 29 Oct 2025 09:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FANXQu
	vOz1jl3EKXfz9ZRGyHUL7R3ni0avL0mssoaLE=; b=Tlp0e8JM+Bq5E2rIZ1AFAG
	kaJUFS12+kUa6rTJ0E0j48urPnD5Kl2wxv/8jUsivoY++JNRKB3jshc45kXmdIfu
	8tT+ynf5f18j82D388AeHtN4q/dzN7BntWPdePMnIm+A0Mp5nBRqNJ957C8Ob+o6
	/GRzsODH61gsfi1tbo6vj5ZuhTzmmXzbyBOQN5MLXF/Z+7Cx03APk5M4JwG+KrXL
	R1UjC4TekNTvSddaxa7L7koLCLbTqL+qJyxxFELCRgqCEh8jPOQIgblzCKXfp+s+
	LV10xOfDYz78JWI5pgsmR+wS69SUBACTDQaDr3Q7J4ryTtn31OfWk3kmtrJYDxzA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agjdy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 09:41:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59T9fr4g025914;
	Wed, 29 Oct 2025 09:41:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agjdxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 09:41:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T5O9XS018748;
	Wed, 29 Oct 2025 09:41:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwakq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 09:41:52 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T9fo6020382394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:41:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4A1C58052;
	Wed, 29 Oct 2025 09:41:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 810675805D;
	Wed, 29 Oct 2025 09:41:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 09:41:48 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 29 Oct 2025 10:41:31 +0100
Subject: [PATCH v5 1/2] PCI: Fix isolated PCI function probing with ARI and
 SR-IOV
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com>
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
In-Reply-To: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Huacai Chen <chenhuacai@kernel.org>,
        Bibo Mao <maobibo@loongson.cn>,
        linux-s390 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev,
        Farhan Ali <alifm@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tianrui Zhao <zhaotianrui@loongson.cn>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=dTkcEBl5gg6N/8Ckh8bxG5upJbEHSRnm22KBHzHO/xk=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIZH0YYrMta8rLfMbLuU8n+soJNWznOra1sYA2yKN+fV
 vGpou1pRykLgxgXg6yYIsuiLme/dQVTTPcE9XfAzGFlAhnCwMUpABOpqGdk6H792zzHZNMrwdn6
 eXxd0wKqt6ad8nmw6dva6+kWJxO1XzMyPI8p14s/dqPK/O3S3hO1Z+aK21QJNLI6f7SXWVvPXmH
 CCwA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=6901e161 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=gNLU74_c1yUKsMQYS-8A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 5aVzxZd_8NDjXLIEyfuoJhKssqGH9r6K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX4XdmgPEPUuv1
 9qOt8fopHetzAqds2n2TJi4oFXjwSDe5AgwYs4JDDSkDh1QlV23wTinY/CMGsdh2pI7aCxXJeUF
 7hHHI2SBlpFuFWdiW5icXyFXRnwMcQaMeuAByACItiyu/zH9rj4/o6FGpy6MifnLj5Gh3enXRVa
 13Z7HRrJiaery6HZHkZVhqjr7PNTuLHSyyim1iHGewRuwMN3PkuNgSlLWRycXhD4g+yDCHZZZIN
 8we7NakoqUsXTMMA1luhfGGUsNvfkRcUTFC+l8gigXE9tkr0NoMtmVH8IQj6Y2DtJYG8bf9M+Fk
 wTExRIyoQ8+jy54J3jOZ9buxSVenxeCFoKsnTWn8nPZRzg+NK6GH1Y3LqB2coNAvI30nKOMlkM7
 v/KMrGXTKInRNbW+VMh+YBz/3LQDHg==
X-Proofpoint-GUID: 0RaOFpgZogZcd0rF0tuH0nOjX9HR2ST2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

When the isolated PCI function probing mechanism is used in conjunction
with ARI or SR-IOV it may not find all available PCI functions. In the
case of ARI the problem is that next_ari_fn() always returns -ENODEV if
dev is NULL and thus if fn 0 is missing the scan stops.

For SR-IOV things are more complex. Here the problem is that the check
for multifunction may fail. One example where this can occur is if the
first passed-through function is a VF with devfn 8. Now in
pci_scan_slot() this means it is fn 0 and thus multifunction doesn't get
set. Since VFs don't get multifunction set via PCI_HEADER_TYPE_MFD it
remains unset and probing stops even if there is a devfn 9.

Now at the moment both of these issues are hidden on s390. The first one
because ARI is detected as disabled as struct pci_bus's self is NULL
even though firmware does enable and use ARI. The second issue is hidden
as a side effect of commit 25f39d3dcb48 ("s390/pci: Ignore RID for
isolated VFs"). This is because VFs are either put on their own virtual
bus if the parent PF is not passed-through to the same instance or VFs
are hotplugged once SR-IOV is enabled on the parent PF and then
pci_scan_single_device() is used.

Still especially the first issue prevents correct detection of ARI and
the second might be a problem for other users of isolated function
probing. Fix both issues by keeping things as simple as possible. If
isolated function probing is enabled simply scan every possible devfn.

Cc: stable@vger.kernel.org
Fixes: 189c6c33ff42 ("PCI: Extend isolated function probing to s390")
Link: https://lore.kernel.org/linux-pci/d3f11e8562f589ddb2c1c83e74161bd8948084c3.camel@linux.ibm.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ce98e18b5a876afe72af35a9f4a44d598e8d500..41dd1a339a994956a6bc7e1fea0fe0d55452a963 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2808,16 +2808,19 @@ static int next_ari_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
 	return next_fn;
 }
 
-static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
+static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn,
+		   bool isolated_fns)
 {
-	if (pci_ari_enabled(bus))
-		return next_ari_fn(bus, dev, fn);
+	if (!isolated_fns) {
+		if (pci_ari_enabled(bus))
+			return next_ari_fn(bus, dev, fn);
 
+		/* only multifunction devices may have more functions */
+		if (dev && !dev->multifunction)
+			return -ENODEV;
+	}
 	if (fn >= 7)
 		return -ENODEV;
-	/* only multifunction devices may have more functions */
-	if (dev && !dev->multifunction)
-		return -ENODEV;
 
 	return fn + 1;
 }
@@ -2859,10 +2862,12 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
 	struct pci_dev *dev;
 	int fn = 0, nr = 0;
+	bool isolated_fns;
 
 	if (only_one_child(bus) && (devfn > 0))
 		return 0; /* Already scanned the entire slot */
 
+	isolated_fns = hypervisor_isolated_pci_functions();
 	do {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
@@ -2876,10 +2881,10 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 			 * a hypervisor that passes through individual PCI
 			 * functions.
 			 */
-			if (!hypervisor_isolated_pci_functions())
+			if (!isolated_fns)
 				break;
 		}
-		fn = next_fn(bus, dev, fn);
+		fn = next_fn(bus, dev, fn, isolated_fns);
 	} while (fn >= 0);
 
 	/* Only one slot has PCIe device */

-- 
2.48.1


