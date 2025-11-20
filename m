Return-Path: <linux-pci+bounces-41811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F12C755C1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E993F4EAFB3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BEB358D21;
	Thu, 20 Nov 2025 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VhhQziU6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z08DH0jA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2516376BC2
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655189; cv=none; b=GAIRfEOfIeuhq76mmhPICzc4p88r3WEsWWEtlZcRK9RfGoMg3wDxubjqb6LkQFeJgcddP3IVXOzNieNVbuij38fwp78hoeqZXgDNRb3Qd8OpCfGgL+O0W0UeyuOzvHNogVcRCyM8xDGjGHuWwbEEDgXIXjO6ChyQ2t8hApD/A4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655189; c=relaxed/simple;
	bh=sQ267wARUqddnqyPimuaqPdCIwHTbOBLDyP6nUn1yk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVzmKoFt7RVP6Wyp4LZMX1Seskwvy2ha4crGDUjtWX11Ustr6NnEXNIlAbUB0FJbcTaXGzx7plSVWmXb0OMnJjH4KWXHigBFVVyIOhJYRgkzKOER+V5s+Aqm8lpnztjFL2cjYnqy2GA/rXbkZ/QU+ejK22CiEvsOZaALLO2inDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VhhQziU6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z08DH0jA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKAgESj416940
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 16:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XbSptmgDmD9ndHXKCNaN1I+/PRPUWSex8jF
	bdSENe4s=; b=VhhQziU6Y77eDLrQpYbZ0cPV46sDG/nQL9NVb8NNLnlg+tl/bab
	g2J1cuhbeDiNY/CUOw2wuoZbM13xNb7Len7Q+PEyEU1Nj1VzlphZRYK93/vdcp4x
	k0L6KdzDnrooDnB8SZP+EoQjU9A7t6wlrFkb1X7ivvlfcgfSag02u75O/OIoG7o7
	bGP6l2oQFkvQlcWwjdNw26faYVVdCa3vUcCcC/+lFW/6s2nF3MPt8vaTx0hkbATO
	GPYl5+hwGmqjKIXSKzyl9dpz986kL2aH2pjpl7sgb3fIrOJk6E6oG5PvlpOyL8dn
	sZYGs5EtEfXeBiU4JkjOHzWIHfojRkLuzBw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aj1fgs0qs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 16:13:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2956a694b47so18271125ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 08:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763655186; x=1764259986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XbSptmgDmD9ndHXKCNaN1I+/PRPUWSex8jFbdSENe4s=;
        b=Z08DH0jAt79DZ+sPRW0pp5XO/vrQar9Odd/AYjs/pn5VpC+4NTm460g5sY3cuzyd1q
         xbCwN3RZNDwd6Xk4UT/PhPKriRMadq/Q5XbS1TC40oHNnYYU65H7CXeMQ89OkyinXNN1
         Oj7E77FUK5f3V945bcYvGQm7OLAlkQomSnKkik9Q20q6SiA19iKpDX6ZHEG1NKsB7RrQ
         6LKrOWa7NgxSNlLDPgoHB+DeSPAOpCRTd8O6R98Oc9MCQcGnf9p1rjc3ezqgD2x5zmi7
         qfpsdlawfGMczafW0uTcLNJ8FX2PX67Z6rIP7D8qdNkfq8/LdL7eUOC/MuHz924zqByF
         v6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763655186; x=1764259986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbSptmgDmD9ndHXKCNaN1I+/PRPUWSex8jFbdSENe4s=;
        b=mH2J6YQw3Uy5WBoNm3ZR6rI5xQV9P5jwIm3P/dGj8mWiMHW0B0BYKlr0hHUfjEBTre
         uRQd1XHmfqKdOfeIzSTB/wBaJV/nGMKeVSrXyLTKYTqpkyWcTN3nMypeal5vQ0VI0nCd
         1e0dB7es9FCu5s1HcYqF0BZq+FgMywdXZ/jCl6gJEhcVm+1srCCODa/gm9IngSPfN/5k
         XdWH93RPiiKsN/4gpvJs+3nj/t9nhqYCXngxdJw5leTOX9Iv2l39s8kd8oZAFafvaY8l
         5JBTY1ed0+NsVlJB4tW6006l9sTzRxkngn3yinaBWDjmVNeMxrUXXMoVivR5BPQkV/DH
         AWhg==
X-Gm-Message-State: AOJu0Yxt0nOxZz/A46jE3Igy0Lo6uV+VFBW+VH2Q3vtlNkA3A8dRDbo7
	ycpEvDY3pLw4v+epPXCuUlRARFCrFTSKI5Li1r5Zeko40TLV0+lKbufcyDoENnZP4Hm47TfJx+v
	MzfNKYe+cm1guscq96CMGnB0Oa+sAsAzkZLT89tsinPEBSxMQLqjtUkiKqh8ZXcE=
X-Gm-Gg: ASbGncuXdpoj/dewMwMzBIhNRETtgzAsiaKS/gBfDflhw5o+gAT5pwWnkkhBp191jFS
	qfgiIp40D7XLCVrSVVS0IfeAmYq53z5MQoWsCOaZEBNGdhj2oMzBIvb7Z7LfGN8bp0vc9c2hNA8
	Ard5c9JZxCIV/E6zp0rjliZ3LuOq/ZyGcmuAEoKnvCznqEEqKHJdxeJKyiyjLjjzLpCuZ+DEUVg
	faSK2/sMpUO3gaapkEFTX1koCL2UvySWhFHKuHIYL74zjS5/f/sUAuGTP+/31XqVNfITd3Zlr1l
	U/FSIDKforZaNMQ33m2QDplWd/MNvn2C4sJLyxEEoB7Y1RCD6yL4fIbXseiERLiEPKI7EbH+s0g
	=
X-Received: by 2002:a17:903:1aad:b0:295:56da:62a4 with SMTP id d9443c01a7336-29b5b115d6amr44746105ad.45.1763655186186;
        Thu, 20 Nov 2025 08:13:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ4ZNaz+21dC23fVjAQqwdsCDkRESBRnJDV8hjtYfF3+tWY/w1+LgeCNPsOpDHIXUZkyyeWA==
X-Received: by 2002:a17:903:1aad:b0:295:56da:62a4 with SMTP id d9443c01a7336-29b5b115d6amr44745695ad.45.1763655185712;
        Thu, 20 Nov 2025 08:13:05 -0800 (PST)
Received: from work.. ([117.193.198.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2809b6sm31060135ad.76.2025.11.20.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 08:13:04 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740 NVMe SSDs
Date: Thu, 20 Nov 2025 21:42:53 +0530
Message-ID: <20251120161253.189580-1-mani@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OqlCCi/t c=1 sm=1 tr=0 ts=691f3e12 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=UMbGOA4G/0oMlBJKcU414A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=2IMlpjGaS-uQoPmQIEoA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 6lCURqlKQ3sTzwRaxWL9ZcyC_6bFIY3v
X-Proofpoint-ORIG-GUID: 6lCURqlKQ3sTzwRaxWL9ZcyC_6bFIY3v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDEwNyBTYWx0ZWRfX9xB2vEq75Wz0
 zXLXQKqkaSB43ykdm6MIdzu2ngZrPxqTY2ec6stGOEYeB4qlaEdMlFWT9i5Z3AK20wtF+n3Jxf4
 t6NrqDNuCdZ0GQ9DS354r6ovdnM97zz+UZvW7WFeC9VB7rTlQEpJLip9xMMIG1pznF0LnEtv5HQ
 VQCtmx/gduTbHG1RqI5zrcPsM5Cl0CfiRCwBySIw7GpBghJaiYDUYgeTzP8isD9LhNuYYbUMM7w
 XZcXf4D/jrGTXaOm9GNvy4btFMtLeP+xciXkHdZLDEBo7iPnBbz5aYVM91TNAg0ZYHP9jkwmnAc
 ICMjXLdcfDszH5eBHGxOcIZYYT0VUkY9ZsmbeF1TeXS21OgjhVaup/dQJOVkULbOCYRuewTt8mg
 JyfYC9hYWITId2jbH4Mzr0B/N5nxKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_06,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200107

The Sandisk SN740 NVMe SSDs cause below AER errors on the upstream Root
Port of PCIe controller in Microsoft Surface Laptop 7, when ASPM L1 is
enabled:

  pcieport 0006:00:00.0: AER: Correctable error message received from 0006:01:00.0
  nvme 0006:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  nvme 0006:01:00.0:   device [15b7:5015] error status/mask=00000001/0000e000
  nvme 0006:01:00.0:    [ 0] RxErr

Hence, add a quirk to disable L1 by removing the ASPM_L1 CAP for this SSD.

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---

Changes in v2:

* Fixed the laptop name
* Rebased on top of v6.18-rc6 for pcie_aspm_remove_cap()

 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..adc54533df7f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2527,6 +2527,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PASEMI, 0xa002, quirk_disable_aspm_l0s_l1);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1);
 
+static void quirk_disable_aspm_l1(struct pci_dev *dev)
+{
+	pcie_aspm_remove_cap(dev, PCI_EXP_LNKCAP_ASPM_L1);
+}
+
+/*
+ * Sandisk SN740 NVMe SSDs cause AER timeout errors on the upstream PCIe Root
+ * Port when ASPM L1 is enabled.
+ */
+DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5015, quirk_disable_aspm_l1);
+
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this
-- 
2.48.1


