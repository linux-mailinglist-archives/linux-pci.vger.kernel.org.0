Return-Path: <linux-pci+bounces-42485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E6C9BC4F
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 15:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7401346D57
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB43325705;
	Tue,  2 Dec 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqURRuOX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4YavabN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CD32471F
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685397; cv=none; b=pow+hDHGzjxBa2+5wZD+dScEy26MhBVmhU6B7bk8w3N31sqtysOG/qaFwMbABpSays2RmnbUFpnAbR3n3GAbmOUukdFujLDm9Vsjds/lGDY1Fswp4RLLYaozKMMnef3I31a299BHJODsGx3/UGexMd15J/yxfo/DIOwSCrLRaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685397; c=relaxed/simple;
	bh=oM0ISSThfe2iHQAvvM0MrsB3sAcFN54Yba1v/k79Xuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmFQXCdv9AEFTMUn2YJj+aVmcEJAGCvL+oI48nBK6c7t8jfL8xKzDLGvZ9coebBSNPz4dtfGEqf+zppS0521ys5vtfF7MBS/KLoSkGXSEIVERe7H2d0tp1vjObEsGWQRNUjqmJv4hrUM8QXJXdCb8cUXQAVrWYIkEsNPKP3Us8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqURRuOX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d4YavabN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2AVdGx3660575
	for <linux-pci@vger.kernel.org>; Tue, 2 Dec 2025 14:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRDphVVsp5LhUNJNYA7xXoCBYkOqQfNzQnKNHXq8CQY=; b=lqURRuOXFyU9HwQd
	5vMP3R/f1zVgh/LEL0Dr+73H90MfYxQ6gDxM75foN0k3QKGXV85Xt92Bvd5NEM4X
	BVkcpGQg2I05Hd1iExWRT0LMAB70uHjV69eBdQVmbAA6FX8T4VbdfcqfVxwRf+fQ
	stweY1l7ixy0vztj5VU44bTpJecgb+wqsBD5KGi1RkzqcAR/cP/vOzK92exv9HTL
	w+kHfFiePCCSK47pk8pZK817SdfwjfEvXNVQ/tEYFj41avdSaFPGKINiwMmfc9cc
	cuM7uMtnja0iyswsLYW/++t3DTkHFyzNUuZ2PTECPRYHUwlUDNYUmWUM31kKbQay
	eypvpw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asxeegnsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 14:23:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7d24bbb9278so8061187b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 06:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764685392; x=1765290192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRDphVVsp5LhUNJNYA7xXoCBYkOqQfNzQnKNHXq8CQY=;
        b=d4YavabN7wYoQIukNSo1bvfVbAp1J9jYIpYaQJwEUz3BQptG54u+t0A8bxFVNL9RQV
         VZquFWIEYfBt2RjgmERN69fk01zSwiVwcm0MA8KNgXECYo1fmOGSQ7MFB7E2SB+7un6L
         ip7ouhAVnHbiAYQsAGG6niUO5pkmqzMMe/72tcRugDpUSdnqFO3HDHC3IoqvHRCqNU3M
         YF3PIvKgILNfl+OuGACXC6CvZDbTMio9YhewhltqK5dYSt+tDY1twJA1aJ4uP5Tj7Gbu
         RTEQGH0kWAwlpXGQtiCdhbHgpCBUqd6QpnJ4ZdpWN+K7eysK0tS+FV42mAYz5eUnAIPT
         zMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685392; x=1765290192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GRDphVVsp5LhUNJNYA7xXoCBYkOqQfNzQnKNHXq8CQY=;
        b=SCqQZcvwcqMu4kWpMWzyG7wIAadpsx7DzkDDXRaC6Vts9KRacCb0Cz2eOX3XER+ToD
         s6XEEF+PTrv+FNCfc4ixItSCFB8MHtU/ypVQAnZNxfJtoA8X2XDSBeUpYnAGsYsHgrJc
         T6/LBW+U/n4sOtsYx07M7z6XiSspShHT7Sx+v9JG03kJVd8Chag3Rf4zg4uJiodBBreE
         A5u5k5hvWC/nt6HJ1+CkvQ4KTqRpgUeeuSmnP/EM41aWuafzR+QeGTVTlmRirVFWDcd5
         eDuplZYwIdJmLrsWjmD06StD2dTjI8Q0MPa9Sf1V6+iNrJtNl0LeCqEo1OHwyxjbrE4w
         OtNg==
X-Gm-Message-State: AOJu0Yy3lkOHWgjhyWQ6x4q3UaTLJcIPuPX9n0adgNmg1OuEfz2RpY6U
	8/Y5ab//NgvAk4n/HHsCiNPMMM3DukxPJTxOkVImifX+QPSg/6KyOZ5Y7jioduaeMrauH3A5aGf
	0m5cZbWSAp2+s1ul2MGX7lmyKHrHMKg3ZC5m+/Y/7dACRNMJYVq045N4sAvKwq30=
X-Gm-Gg: ASbGncs+ogJmo0KtvkHc6onUYE2CWXxmUIpVGavEOReinwwRY7d1ppQtPT3DtPix7nS
	ajvxPtNc4gy58lfNieFGinyS6WKxNVFqOM157VHgZN5iL07JVDeahF7yFPeU7IUcEomWnTGsa11
	aK32YZ7JC9GjwfWq6iOOfmbJ0Wvi8+mP5tuqO3/kq+2PsGOmWXzfQADTZAnX3wb7YPgmOUwWjj8
	h4fmQAzDl7XBMCF6GrQ621eyI80+HgU82+/VEJz+OryWKCNYOOfI0KCQ+hdNOWBfOKVfx/FthvG
	7VllFSSn9keKl3UZ86wUnV1ymtWmjHwtXHfbCz0OfHJz2rvyFWqRqortBjscRdxVqzVKryVv3FC
	SP3x43hAwc1wl/u2hkQPsUDG2PrBWGF7PbUMA3fc=
X-Received: by 2002:a05:6a21:6da2:b0:35e:5a46:2d6b with SMTP id adf61e73a8af0-36150e26ca3mr50873147637.8.1764685392312;
        Tue, 02 Dec 2025 06:23:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmRMklphSE8VVuEbGA85j8N7H5uZ2KxuEkKiykxwE99ZSiS5YgQWecQiu6eqV5ikDDhCSWqg==
X-Received: by 2002:a05:6a21:6da2:b0:35e:5a46:2d6b with SMTP id adf61e73a8af0-36150e26ca3mr50873103637.8.1764685391735;
        Tue, 02 Dec 2025 06:23:11 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a4821sm15659084a12.29.2025.12.02.06.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 06:23:11 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 02 Dec 2025 19:52:50 +0530
Subject: [PATCH v2 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-pci_acs-v2-3-5d2759a71489@oss.qualcomm.com>
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
In-Reply-To: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Xingang Wang <wangxingang5@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7289;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=oM0ISSThfe2iHQAvvM0MrsB3sAcFN54Yba1v/k79Xuc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpLvZATIoifLli8Kza8XkZceVvVn5inlfSqDTzg
 jYBy9E0vLuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaS72QAAKCRBVnxHm/pHO
 9VgeB/oChngyIc4/wh1yLoqGtD6dV1a075pZRLSOe/aIThC1e6M72oVl5MWzn4DMh312D+aGUYd
 kdjWoaWP6z+xvgW7myDelsL+9jXCVVqEwqRlhxy/ukeCTn01PxAl+Gnq8O9IEe2ZvvfCXNH61/t
 QNOJFFDGx0yrXdGqur8orEi7i1RageUArTpIx7ZK280arIuuRb3MCZDukRvT0hRabB9ooBJrouh
 s/kVg7j6Vm4rX+INquiU70DiFwBHwMDpeO98bNnI4ZsNgLHTo8G2IiGeyD8kwcBkeQfq9+Pa01g
 fSg1DijCOd6l4rzpBnfMEKUr7dzXl07JGQAMfUryxby6S6PT
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: xEAorUEMeTkCbkBd1BiWi6GSx65OgTca
X-Authority-Analysis: v=2.4 cv=TMRIilla c=1 sm=1 tr=0 ts=692ef651 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=8ziBJk15IZ5r+wOU3RLduA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=DsWDNE5MgSBdAu1L5fIA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: xEAorUEMeTkCbkBd1BiWi6GSx65OgTca
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDExNSBTYWx0ZWRfX07bA2POdh576
 DhytPJq0kDVDgI1TUZQ3qYW9p0kMbMdPD7TI+tSkbzVca8SLsTCz5m2ORUp7bFoIi5sNbA1APdi
 IVxxhPK2l6dHJG5O1rpjocyA8dTXSU4Mqiy8DkBZelvg87RYeRO7S3fmvuXRY2plYSHhiqxNk0n
 UPra7VZ7eSrrBEUKCiVwpGLna9ks2ieJ9cLHCeXS/m3x6tDFOj5IdMdCI6RyaZQUQTqqDipbyP4
 pmG4mTydZqci0jaQLjuqbffjedj4qkCeMF7i5kgZQxneHNtR62Kgs6rea+OKl7OcY6hj6TwIPYS
 u+Mh7NwgvZB1+uYQdaROEVBe95JBvW6OOl+VUA+wuClPDMJ47SpA3hndx4etQGlEmzWYS68719i
 UtrdyM53pW2lzksgkkK2xUyrtNexwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020115

Some IDT switches behave erratically when ACS Source Validation is enabled.
For example, they incorrectly flag an ACS Source Validation error on
completions for config read requests even though PCIe r4.0, sec 6.12.1.1,
says that completions are never affected by ACS Source Validation.

Even though IDT suggests working around this issue by issuing a config
write before the first config read, so that the device caches the bus and
device number. But it would still be fragile since the device could loose
the IDs after the reset and any further access may trigger ACS SV
violation.

Hence, to properly fix the issue, the respective capability needs to be
disabled. Since the ACS Capabilities are RO values, and are cached in the
'pci_dev::acs_capabilities' field, add a new field for broken caps, set it
in quirks and use it to remove the broken capabilities in pci_acs_init().
This will allow pci_enable_acs() helper to disable the relevant ACS ctrls.
It should be noted that the quirk should be of the fixup_header level, so
that it gets called before pci_acs_init().

With this, the previous workaround can now be safely removed.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci.c    |  1 +
 drivers/pci/pci.h    |  1 -
 drivers/pci/probe.c  | 12 -----------
 drivers/pci/quirks.c | 61 ++++++++++++----------------------------------------
 include/linux/pci.h  |  1 +
 5 files changed, 16 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4eb5b487c982..6ed35affea06 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3681,6 +3681,7 @@ void pci_acs_init(struct pci_dev *dev)
 		return;
 
 	pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabilities);
+	dev->acs_capabilities &= ~dev->acs_broken_cap;
 }
 
 void pci_rebar_init(struct pci_dev *pdev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 972b28fc5455..56ba7d60d658 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -430,7 +430,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int rrs_timeout);
 bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 					int rrs_timeout);
-int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_timeout);
 
 int pci_setup_device(struct pci_dev *dev);
 void __pci_size_stdbars(struct pci_dev *dev, int count,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9cd032dff31e..6f8142cf9487 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2517,18 +2517,6 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {
-#ifdef CONFIG_PCI_QUIRKS
-	struct pci_dev *bridge = bus->self;
-
-	/*
-	 * Certain IDT switches have an issue where they improperly trigger
-	 * ACS Source Validation errors on completions for config reads.
-	 */
-	if (bridge && bridge->vendor == PCI_VENDOR_ID_IDT &&
-	    bridge->device == 0x80b5)
-		return pci_idt_bus_quirk(bus, devfn, l, timeout);
-#endif
-
 	return pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..a5956726a49f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5778,59 +5778,26 @@ DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
 
 /*
- * Some IDT switches incorrectly flag an ACS Source Validation error on
- * completions for config read requests even though PCIe r4.0, sec
- * 6.12.1.1, says that completions are never affected by ACS Source
- * Validation.  Here's the text of IDT 89H32H8G3-YC, erratum #36:
+ * Some IDT switches behave erratically when ACS Source Validation is enabled.
+ * For example, they incorrectly flag an ACS Source Validation error on
+ * completions for config read requests even though PCIe r4.0, sec 6.12.1.1,
+ * says that completions are never affected by ACS Source Validation.
  *
- *   Item #36 - Downstream port applies ACS Source Validation to Completions
- *   Section 6.12.1.1 of the PCI Express Base Specification 3.1 states that
- *   completions are never affected by ACS Source Validation.  However,
- *   completions received by a downstream port of the PCIe switch from a
- *   device that has not yet captured a PCIe bus number are incorrectly
- *   dropped by ACS Source Validation by the switch downstream port.
+ * Even though IDT suggests working around this issue by issuing a config write
+ * before the first config read, so that the switch caches the bus and device
+ * number, it would still be fragile since the device could loose the IDs after
+ * the reset.
  *
- * The workaround suggested by IDT is to issue a config write to the
- * downstream device before issuing the first config read.  This allows the
- * downstream device to capture its bus and device numbers (see PCIe r4.0,
- * sec 2.2.9), thus avoiding the ACS error on the completion.
- *
- * However, we don't know when the device is ready to accept the config
- * write, so we do config reads until we receive a non-Config Request Retry
- * Status, then do the config write.
- *
- * To avoid hitting the erratum when doing the config reads, we disable ACS
- * SV around this process.
+ * Hence, a reliable fix would be to assume that these switches don't support
+ * ACS SV.
  */
-int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l, int timeout)
+static void pci_disable_acs_sv(struct pci_dev *dev)
 {
-	int pos;
-	u16 ctrl = 0;
-	bool found;
-	struct pci_dev *bridge = bus->self;
-
-	pos = bridge->acs_cap;
-
-	/* Disable ACS SV before initial config reads */
-	if (pos) {
-		pci_read_config_word(bridge, pos + PCI_ACS_CTRL, &ctrl);
-		if (ctrl & PCI_ACS_SV)
-			pci_write_config_word(bridge, pos + PCI_ACS_CTRL,
-					      ctrl & ~PCI_ACS_SV);
-	}
+	pci_info(dev, "Disabling broken ACS SV\n");
 
-	found = pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
-
-	/* Write Vendor ID (read-only) so the endpoint latches its bus/dev */
-	if (found)
-		pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
-
-	/* Re-enable ACS_SV if it was previously enabled */
-	if (ctrl & PCI_ACS_SV)
-		pci_write_config_word(bridge, pos + PCI_ACS_CTRL, ctrl);
-
-	return found;
+	dev->acs_broken_cap |= PCI_ACS_SV;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IDT, 0x80b5, pci_disable_acs_sv);
 
 /*
  * Microsemi Switchtec NTB uses devfn proxy IDs to move TLPs between
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c6ee1dfdb0fb..246c0ca34308 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -544,6 +544,7 @@ struct pci_dev {
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u16		acs_capabilities; /* ACS Capabilities */
+	u16		acs_broken_cap; /* Broken ACS Capabilities */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */

-- 
2.48.1


