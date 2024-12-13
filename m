Return-Path: <linux-pci+bounces-18356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C409F0523
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 08:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9279168CAF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5317B500;
	Fri, 13 Dec 2024 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DmXRYRGb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F27126BFF;
	Fri, 13 Dec 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734073381; cv=none; b=P48FtSejbDZsHPBSrmQIypsUgpSLUjtbbg9V7Pf7rjCgGCSNd45P83p8scC2DOur2oAV1y96yr/iinVJARYWQQot/Y7729lVYCRXfmUz0F+FEcdMYnI7GSEJ8iI9gHVZUT1XFeNOYTg7onp1p4ZgP3eS3DS8D4Mu97bAwlkixFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734073381; c=relaxed/simple;
	bh=xWARNHWpdIw0YwmV+NPOqmqXZAziskKTF7FQ1IFdtRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WvvLp4C5WIJBA0669/OXcP2gJqWsmFobzENOfvwrJkVtTH7pZrBOIgD35FIBRQSK/2AR3CTCqdFsvbIkjjineS7SOhCjJAv+sYnUaORn/szabuEiLg5v5mL6jP9zmgRVrKWGZhZfmtLdHBmwmI3k2eTzt6Y3YCj1w7M4X968LbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DmXRYRGb; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCKhOtM009093;
	Thu, 12 Dec 2024 23:02:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Q852wDm2iEFiT0yruWVrISx
	73a9xTXKcTLWoM/d8lwY=; b=DmXRYRGb1RlpmIBMLiwOTnZp9AcIUusJJeTiV20
	YqfTKcWIqMHHYikDtMIj7Zkk3UIRSROyQHTaDqEXYS7+EWkqexkVC91nqN32T5Pj
	e8rxSSJmx6Xy+DYb8wx95ZGQpgjdBSSgJFIJZTJ+tM/ii6dFhgoFLlCO7GfVsy61
	WP9A9MJOmEee6xLc1JZJCcthn2E+ssTyODFrwFy1hI+3Uj3H2bVIQAuuOHLrSx15
	KKxT3peLL5S9z1ctzh+8HaelMUJfypd9vuinHg3PzWUev+MWqwbrCaIJ+rAcFIPJ
	cBhg4tqIsdggGORgLsPmewsKFfKrdbF7wjwusfSMhmsCFzg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43eyqh60eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 23:02:56 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 23:02:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 23:02:55 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 8720E3F7076;
	Thu, 12 Dec 2024 23:02:53 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v2] PCI : Fix pcie_flag_reg in set_pcie_port_type
Date: Fri, 13 Dec 2024 12:32:41 +0530
Message-ID: <20241213070241.3334854-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BROr9gZMnevdJfB8MYMnv1Yy4BzeNkh7
X-Proofpoint-ORIG-GUID: BROr9gZMnevdJfB8MYMnv1Yy4BzeNkh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

When an invalid PCIe topology is detected, the set_pcie_port_type function 
does not set the port type correctly. This issue can occur in 
configurations such as:

	Root Port ---> Downstream Port ---> Root Port

In such cases, the topology is identified as invalid and due to the incorrect 
port type setting, the extended configuration space of the child device becomes 
inaccessible.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
v1->v2:
	Updated commit description

 drivers/pci/probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..263ec21451d9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1596,7 +1596,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		if (pcie_downstream_port(parent)) {
 			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
 			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
+			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM << 4;
 		}
 	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
 		/*
@@ -1607,7 +1607,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
 			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
 			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
+			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM << 4;
 		}
 	}
 }
-- 
2.25.1


