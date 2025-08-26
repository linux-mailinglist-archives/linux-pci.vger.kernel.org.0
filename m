Return-Path: <linux-pci+bounces-34729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F47CB357A8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 10:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A203BDC54
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E5D2FF663;
	Tue, 26 Aug 2025 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ag05Ny52"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189262FF178;
	Tue, 26 Aug 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198354; cv=none; b=JuyIBwz1Qpvw1YMQl4XzlIjjtFIEpyV/s7hulEKERVg++tAQ6Feey9nt0lBbdIqI3PkDd7Yu+c4Y+jDU7VCBp1dlci7cp/uEn9qiWuAeepocCm2L/9dXpmiqBCKhtZuaHY+zUns1sJ/wKiUbdfDvTQTdOKDdcsFr1dxVRSX/U3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198354; c=relaxed/simple;
	bh=uPSnFWjP93OlOHNb0U2GXbYLGlUaN0IDpxSA8DZ8fWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XaKPHxtOpLnBd0mgz3XKyM8GSKXP95d0tz2Gv51DHktgWle/qekYn88D98PrsZxSxnd2nZZo0Zq70r+Mzl/PpsEfs7Gmi9RW4Ln/YdcZth5qOD6NIGtEgR4be29nEmM8EDtQFxzzFDuV0NrP0PsEPYfuHewjPf7YhdqeuDA/tdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ag05Ny52; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PLFCYs025258;
	Tue, 26 Aug 2025 08:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/dry19
	cSbKRzRgN4fBXALbB7LumyJnU0023BDWDoRmc=; b=ag05Ny52DY3i0rBEEYOu8X
	TvbKkgmjAiwsONUaAkCsaIkemULqXXrLGVtF9rTbi148pxe6Xaqcwo7+OjiTiXix
	5DYDPgkplSx4CeOcKMGtrKX82Jw3mFGpaOUZ3CH0j9dYlGRmUF9LPkz8Gj8JO7SU
	CfDM6QQfiWbwXGXehehMAsqgSz5b3f2/anlrkHXfYU4F2R7Om0BuBmgj9pe0hdys
	47wjQvAR5da+FGQfU2k2oPxiC2IyRe2JlaIRdKPgEKBf4gMU0BBP4qBPuQz/laMZ
	GMI9E09FGjdW8t+kEEvIjUqVnM5zZ/LaJfIeCcTMEu9KFzUaioFITnea5sunMv0w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hpwcne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:52:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8dDBb018006;
	Tue, 26 Aug 2025 08:52:29 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp39mpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:52:29 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57Q8qIAh27918848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 08:52:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA1395803F;
	Tue, 26 Aug 2025 08:52:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C3A558060;
	Tue, 26 Aug 2025 08:52:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Aug 2025 08:52:24 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 26 Aug 2025 10:52:09 +0200
Subject: [PATCH 2/2] PCI: Add lockdep assertion in
 pci_stop_and_remove_bus_device()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-pci_fix_sriov_disable-v1-2-2d0bc938f2a3@linux.ibm.com>
References: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
In-Reply-To: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=uPSnFWjP93OlOHNb0U2GXbYLGlUaN0IDpxSA8DZ8fWM=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDLWlh655WP5OL9e86vn4TmXJ7Qd0bR/rblZz+LSgSZWm
 5K1hgmTO0pZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZiIwTNGhq0NzQHnhFg1I15f
 fhvU9TIz8dnBYtPHO93VF0soTjjUv57hD+fzshdMd9KTgydN5Q38eVLaM2nv6bImrhCW28fFZap
 aeQA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX/7Klb27MA+g2
 kgyczieKQjvEfDrg99lMncpVE4Ukkl1v/VHBlEX0rSuOCO8efnBp79sU3FvejM14LPmV0vmva5i
 3kCE6H9/rAFdXytVMGXTbQNvgKNS/xTk0EPeR3zMV29DS4IW2oatQ0meJY51QJ3bSsBv/bbYB5h
 zYfnxByfwEUsfkqnfdGmqQLxUHjAQWOdVxJc2E+81a0blYl7xciYH4hpywSLQznAUpofRafNNgd
 RrL8TbTcymJZygC75RXaTPNxfA8Jn0pp8PhwZxsdXjP+t+zLT/wwEeYTMn0h1YxmYC0V5k0mcUj
 VTJdNhi2OvZfL59sJjOZZhsk2zqswKEdJz7CxzfH7B+FQxCf98zV2Ows4YveaNuETNUrssEac+c
 y+iqnMbK
X-Proofpoint-ORIG-GUID: GQ2rtOk-gZYTxgnyDXCCIh0aSX4PzUax
X-Proofpoint-GUID: GQ2rtOk-gZYTxgnyDXCCIh0aSX4PzUax
X-Authority-Analysis: v=2.4 cv=Ndbm13D4 c=1 sm=1 tr=0 ts=68ad75cd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=6IiXL9Pwt5ywoM8SLSYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

Removing a PCI devices requires holding pci_rescan_remove_lock. Prompted
by this being missed in sriov_disable() and going unnoticed since its
inception add a lockdep assert so this doesn't get missed again in the
future.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/pci.h    | 2 ++
 drivers/pci/probe.c  | 2 +-
 drivers/pci/remove.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e9f61f0c489ec58de2ce17d21c0c6..1ad2e3ab147f3b2c42b3257e4f366fc5e424ede3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -84,6 +84,8 @@ struct pcie_tlp_log;
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
+extern struct mutex pci_rescan_remove_lock;
+
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f41128f91ca76ab014ad669ae84a53032c7c6b6b..2b35bb39ab0366bbf86b43e721811575b9fbcefb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3469,7 +3469,7 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * pci_rescan_bus(), pci_rescan_bus_bridge_resize() and PCI device removal
  * routines should always be executed under this mutex.
  */
-static DEFINE_MUTEX(pci_rescan_remove_lock);
+DEFINE_MUTEX(pci_rescan_remove_lock);
 
 void pci_lock_rescan_remove(void)
 {
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 445afdfa6498edc88f1ef89df279af1419025495..0b9a609392cecba36a818bc496a0af64061c259a 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -138,6 +138,7 @@ static void pci_remove_bus_device(struct pci_dev *dev)
  */
 void pci_stop_and_remove_bus_device(struct pci_dev *dev)
 {
+	lockdep_assert_held(&pci_rescan_remove_lock);
 	pci_stop_bus_device(dev);
 	pci_remove_bus_device(dev);
 }

-- 
2.48.1


