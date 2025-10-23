Return-Path: <linux-pci+bounces-39157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40700C02197
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06EF3A1667
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB25334C0F;
	Thu, 23 Oct 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EMv5dT+v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F1325489;
	Thu, 23 Oct 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232870; cv=none; b=Y5x13mlltFs/I7iIhLJJNqezUxVfKTX1JcnIMsj2XvTVkMAD8XxSUQLEAJCwTkYkcUc6JyE5MfnOtb/kNr06XG1x/z6jJB+LVOI19XjKjBpmqNrsl31uLL8m6Nqkjm0UN6R7fg0Tpimr4tnxx2pk3IiiT+yL0nFqhhnB23DvA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232870; c=relaxed/simple;
	bh=P1gORhg67l42KpfjthYHZoNTnyF5hzXreO8zVJBGwHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+N9X4avkY6UC0wz9+BsBaHuMH1yJwxi/scNEV9YRcU0XLRsB182aq7H1nMDD/gnhqGz7CQwbcb5fIdWp/VP5EuHF24KzOvp6xBdnbn3prUu1saPKjeU65sSKrWpTlTl8QAxalQx7ppQANCEeIJ2vWi0zOizya4GR+Y/srMFWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EMv5dT+v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7kbm1015153;
	Thu, 23 Oct 2025 15:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i3igiv
	he7Sa+5qhiSjEfJz+c8CvOwFYhjI2s0Wxk8G4=; b=EMv5dT+vUsOPTaIfu1FLeB
	jz4nSXigVqqeTWp/cOILy3oGhdbvhD5HFBruJ119jPd09M9bMKprd7FA1RXoZr3R
	g9Qjr8RLLVq+/NSJx4SB8aLqoBG3opmAuJ2fHOcTCge6BJB6CoasYhlsPAYBBM1i
	TlmJ43+4DiQ8IWhtz8LkZcfSyCLy6+3ojic/3ujbcAsbbcGAxImU9LryWGJMbOi9
	4+zk+e+3oWgEdGiqKlHmtrPb53tqJNTml6iUKr7WeVu5+AKEpPkyEQyAlfU0tu7Q
	HHEqe+WcTdDsyObcLYmgvPVwPkbRePRx4nQPGCHpRA+QyBNVQqvULKICH2rA/jJA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sb0s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:20:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NEe4va006157;
	Thu, 23 Oct 2025 15:20:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sb0s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:20:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59ND3OJD014685;
	Thu, 23 Oct 2025 15:20:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sentb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:20:55 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NFKrwE23069288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:20:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A8D858055;
	Thu, 23 Oct 2025 15:20:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94F9358043;
	Thu, 23 Oct 2025 15:20:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 15:20:50 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 23 Oct 2025 17:20:41 +0200
Subject: [PATCH v4 1/2] PCI: Fix isolated PCI function probing with ARI and
 SR-IOV
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-ari_no_bus_dev-v4-1-8482e2ed10bd@linux.ibm.com>
References: <20251023-ari_no_bus_dev-v4-0-8482e2ed10bd@linux.ibm.com>
In-Reply-To: <20251023-ari_no_bus_dev-v4-0-8482e2ed10bd@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Huacai Chen <chenhuacai@kernel.org>,
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
        jailhouse-dev@googlegroups.com,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=P1gORhg67l42KpfjthYHZoNTnyF5hzXreO8zVJBGwHA=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDJ+uZ8zcdv2xULHaHpmicq+eR/krnInilr9Mqu5sLywM
 Ll6Xl9pRykLgxgXg6yYIsuiLme/dQVTTPcE9XfAzGFlAhnCwMUpABOxu8PI8Gk///kcryT3AjZ/
 jor2qxnXDbZaz93L09I5u/qZzsI/bAz/fWx5NgZ9KL13jbexb4N83O/NRXc6tDb8tW2+tkz/SrQ
 7MwA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AwsNJ_TshV-1RDVD1mGxR-9L1LOovLe5
X-Proofpoint-GUID: yyFb5Ai2nwV3I_OT3T6CBfnZYC6zNUwe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5UKpl2pPPvts
 /YreVtscr6EESetTuazypoVuTVRYdNLPsNooP+uppXz8JGKhyLcMrGoP/XL0u/C2ED+UV+RMb6u
 +jYVX/9toECqHIpY4IWxhrTumPv4yyV494PQWA4ddBh9xYFaVHdOrVOwAA3QNcjzSGhobJH/B0d
 b9NCK7+3lKCHuKNFJWHOxkk8X/mqkoliKgIyqocgBRznRzENlL9yK9xHsR/BY6jmTbx39tWgcWp
 0HgIpQsdADlOis9MUzCcfGqky4N2jaxqFrxoKT548EU2GV7A0HEBrDq3yG1rSb1AnSBiFrdgmyL
 /BiuPm8GmBEibcIB2k5BZ6Z6aCSVFEWwOjEsg38FkMyDCnzThXFnEa+hhrNq6l2qLgatYGS50Oh
 6UB4YkEaY8dsoNiWqXY9a+CgNAfNTg==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fa47d8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=gNLU74_c1yUKsMQYS-8A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

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

Fixes: 189c6c33ff42 ("PCI: Extend isolated function probing to s390")
Link: https://lore.kernel.org/linux-pci/d3f11e8562f589ddb2c1c83e74161bd8948084c3.camel@linux.ibm.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ce98e18b5a876afe72af35a9f4a44d598e8d500..13495b12fbcfae4b890bbd4b2f913742adf6dfed 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2808,16 +2808,18 @@ static int next_ari_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
 	return next_fn;
 }
 
-static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
+static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn, bool isolated)
 {
-	if (pci_ari_enabled(bus))
-		return next_ari_fn(bus, dev, fn);
+	if (!isolated) {
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
@@ -2857,12 +2859,14 @@ static int only_one_child(struct pci_bus *bus)
  */
 int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
+	bool isolated_functions;
 	struct pci_dev *dev;
 	int fn = 0, nr = 0;
 
 	if (only_one_child(bus) && (devfn > 0))
 		return 0; /* Already scanned the entire slot */
 
+	isolated_functions = hypervisor_isolated_pci_functions();
 	do {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
@@ -2876,10 +2880,10 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 			 * a hypervisor that passes through individual PCI
 			 * functions.
 			 */
-			if (!hypervisor_isolated_pci_functions())
+			if (!isolated_functions)
 				break;
 		}
-		fn = next_fn(bus, dev, fn);
+		fn = next_fn(bus, dev, fn, isolated_functions);
 	} while (fn >= 0);
 
 	/* Only one slot has PCIe device */

-- 
2.48.1


