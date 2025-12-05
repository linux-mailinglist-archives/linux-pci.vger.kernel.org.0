Return-Path: <linux-pci+bounces-42700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E4CA7F7D
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 15:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56FF131CE5AD
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885232ABF9;
	Fri,  5 Dec 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qJcRQRRZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AAF32E6AD;
	Fri,  5 Dec 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944966; cv=none; b=G07lTYdzWF8hUakdXei6LM1bA6a26iHaEZCD8sffLtkU/XZONnPwqNgD4otueWUmNGlSdu4JwM5U07fSKC/61cRsi5oJl0cy8CuhsVt4i8M0vu6UYxrmiMNTtaxRzWTSkISbaHouYivTzQ6NMSa6XLDweoGo0zsW+PEzk7dBzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944966; c=relaxed/simple;
	bh=sBzu10i21/6Sa32V37HZ38gzwxOa+i+lpu4pRCgONw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LU/tiIitQVw+BQLHa6rJyIU7w/uNbsYXeNKioxGCZPJp7Aeg7yVxmxws7U8sIp3H+pltr3viTf/Wn8Sv7CmDaGA82iIxwd/pOiDd69427shC5HHI4+k7BEGepZapTPCNu0Xwkttj/B+3PoOJ1CX5h2VhSkh72GHltGlQjo1x7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qJcRQRRZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5ECCgD3930767;
	Fri, 5 Dec 2025 14:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=pdZ/TQ/PcFTWWe6z
	jO2bxx4f/TGxWotGNX/3bRcBTio=; b=qJcRQRRZaI0J45qUEtKfTpV+RU5xzkCZ
	vHTnaOz1DDLlT4wNHXdKqiJXvAmMFygL9i98eAYXhsT9yu0eZdTzgymtwVmu/q19
	xHfEsoa1z/cFxEy6sB2+Fo7RereQgAH69jiFHUantDy7VrZVLoeJujWj01hmywZ+
	Tbw6EyQ9/AXDI0EY41M0Y52lQboYJLyUNbWqZPHmoKr0xh45NC1cClaV+Cb4+wAz
	P8vZXuszepHKPO6/PmJhmwkrbUU5L+M0AnbUSw+6uPAQwwSdKZ9x6+fJrSsxKgUI
	Mj8/D8EWFl/fJtKwCdcyD8RJx40VeOQY3fUk6mUIiGvWuEL/Vb9Rjw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7wnj86v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 14:28:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5Da5Kk040484;
	Fri, 5 Dec 2025 14:28:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9h2d28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 14:28:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5B5ESXOq028403;
	Fri, 5 Dec 2025 14:28:33 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4aqq9h2d15-1;
	Fri, 05 Dec 2025 14:28:33 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>,
        Casey Leedom <leedom@chelsio.com>, Ashok Raj <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        dingtianhong <dingtianhong@huawei.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Cc: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in program_hpx_type2
Date: Fri,  5 Dec 2025 15:28:29 +0100
Message-ID: <20251205142831.4063891-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512050104
X-Proofpoint-GUID: QMjcKWQ7PEubpi8226Us1LDKW41L4pEW
X-Proofpoint-ORIG-GUID: QMjcKWQ7PEubpi8226Us1LDKW41L4pEW
X-Authority-Analysis: v=2.4 cv=SbX6t/Ru c=1 sm=1 tr=0 ts=6932ec13 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=ktkD548E8Y1-oA6S7RkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwNCBTYWx0ZWRfX7O2rawPOoBA4
 JaKUtWuTJFMxj1GzkpAalpfJY7Rdaa81ixu82uMbcDlszKovDH60jP0kkM82NaCR6tOc+fqQnpy
 LXXOpKoAXaDGDBB2vJlcgecq97rHnUmwo/hZD7+V+eodoTB/MYncZSWTLw18y8KYi3uDQUumCBe
 TpdcCuKskNklGJQrZeIcMD3WjfNux+1BKySjdHDuS8ugt46fpkj24Wa9VRWtxSyk2Bj5ZBkM6Gm
 XjSOURrgjarp0ANYn4rr2b0UBxcgrF/jCPsPauCRv+Pa0fW71OEKQ7iCWUNrkYZWmCfQSnTSmah
 q8GB4bykvx7jQqBPWLtLJpYWRcNPNxu7E8Jarn7sAkgLifTONOoCWcbzHowrEVwDxX5KT5dT8f1
 Y4h4TJ7++Hw5o9ve+L+6GmokmOG5o46YEGftB3Po6w6HgmahsN4=

After commit 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if
supported"), the kernel controls enablement of extended tags
(ExtTag). Similar, after commit a99b646afa8a ("PCI: Disable PCIe
Relaxed Ordering if unsupported"), the kernel controls the relaxed
ordering bit (RO), in the sense that the kernel keeps the bit set (if
already set) unless the RC does not support it.

On some platforms, when program_hpx_type2() is called and the _HPX
object's Type2 records are, let's say, dubious, we may end up
resetting ExtTag and RO, although they were explicit set or kept set
by the OSPM [1].

The Advanced Configuration and Power Interface (ACPI) Specification
version 6.6 has a provision that gives the OSPM the ability to
control these bits any way. In a note in section 6.2.9, it is stated:

"OSPM may override the settings provided by the _HPX object's Type2
record (PCI Express Settings) or Type3 record (PCI Express Descriptor
Settings) when OSPM has assumed native control of the corresponding
feature."

So, in order to preserve the increased performance of ExtTag and RO on
platforms that support any of these, we make sure program_hpx_type2()
doesn't reset them.

[1] Operating System-directed configuration and Power Management

Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Fixes: a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if unsupported")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/pci/pci-acpi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9369377725fa0..6a2ae1b821732 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -324,15 +324,18 @@ static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 		return;
 	}
 
-	/*
-	 * Don't allow _HPX to change MPS or MRRS settings.  We manage
-	 * those to make sure they're consistent with the rest of the
-	 * platform.
+	/* Don't allow _HPX to change MPS, MRRS, ExtTag, or RO
+	 * settings.  We manage those to make sure they're consistent
+	 * with the rest of the platform.
 	 */
 	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ;
+				   PCI_EXP_DEVCTL_READRQ  |
+				   PCI_EXP_DEVCTL_EXT_TAG |
+				   PCI_EXP_DEVCTL_RELAX_EN;
 	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
-				    PCI_EXP_DEVCTL_READRQ);
+				    PCI_EXP_DEVCTL_READRQ  |
+				    PCI_EXP_DEVCTL_EXT_TAG |
+				    PCI_EXP_DEVCTL_RELAX_EN);
 
 	/* Initialize Device Control Register */
 	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
-- 
2.43.5


