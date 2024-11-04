Return-Path: <linux-pci+bounces-15925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192F9BAF6B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 10:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287451F21047
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727361AB51F;
	Mon,  4 Nov 2024 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NGm/no/C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490514B06C;
	Mon,  4 Nov 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711802; cv=none; b=ERc1sGhRMC0azAXwzBpKiDZPgucX5/2K7sti+HN+CiojrBgzV3sgpINirf1P+5AIrECcakf2vyWZz9rwfexxjnXXELUtYgJ8TaapyGVNcPZRAKDghFC1uXNVpawdLmskAMEWkGxlIZg8z/MQ9UpvzZzfVOguHSAKKnHG2xD+VgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711802; c=relaxed/simple;
	bh=sW1oLLdhu3P93i3lUdlHXIgmk8ofXwGR218zPgmAIPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e4og/Qya5VJmkFi6bkI77v59Wb+aqg1qa50wTK1JS48MTpcW4eVD4qF93XRc6JFvAb6RGV8PXGbt3hPhRqxqfea96msntdDBDhLi19nidXyTghL7eWMSIb/3zX3r/x3UXUFLzI2qkIaCej/6Iw+JoXNkKUWSNB0wDzE0fmnrlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NGm/no/C; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A40kOkG011977;
	Mon, 4 Nov 2024 01:16:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=P/SgrtOrXq9m3vz3An/mm6E
	IIckisMQpwoQ3ezaHZ9k=; b=NGm/no/CpUcljoI/uzJaqWKkMyc5epPJp/EJRa4
	ZJ2kz8frzIPeXXEQoETuWsG9JES55iNnZRgnVu6bAXfxinw+LTH3Sg8sVcKDpnlx
	HF4db3EgcYUjSGpe6k0f+Dr2AXhmdHezMH7xb5plgURrD34dUSkFxfhwfqoDZjs8
	qLnGJ9C8eRdp7wSvWoRyiSszSVqj9mqFEnPDVxlPBpWr/IHzAoIllwspAUaDCvvz
	v9mY6Ts8SzqSJUkNk/RRj57BfckLbNOZFkacRe84Q7L6gYDYN3tqE7Gz16zMPPQG
	44EPOU37xp+4X0i3gxxMeoEIdxFGSxESyZQ/hqIzdzfMLPw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42p97c17r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 01:16:33 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 4 Nov 2024 01:16:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 4 Nov 2024 01:16:31 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 28DB93F705F;
	Mon,  4 Nov 2024 01:16:29 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH] PCI : Fix pcie_flag_reg in set_pcie_port_type
Date: Mon, 4 Nov 2024 14:46:27 +0530
Message-ID: <20241104091627.400120-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1CSdxfY_J70drflIktYj1_BkHkU6J3xI
X-Proofpoint-GUID: 1CSdxfY_J70drflIktYj1_BkHkU6J3xI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

The port type in set_pcie_port_type is not set proper when an invalid
topology is detected. Since the port type was not set proper, the child's
extended config space becomes inaccessible.

[   70.440438] pci 0002:00:00.0: [177d:a002] type 01 class 0x060401
[   70.463056] pci 0002:00:00.0: reg 0x38: [mem 0x600000000000-0x6000000007ff pref]
[   71.806936] pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   71.906688] pci (null): claims to be downstream port but is acting as upstream port, correcting type
[   71.916138] pci 0002:01:00.0: [177d:a002] type 01 class 0x060401
[   71.935982] pci 0002:01:00.0: reg 0x38: [mem 0x600000000000-0x6000000007ff pref]
[   72.134703] pci 0002:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   72.198956] pci_bus 0002:02: extended config space not accessible
.......
[   83.762956] pci_bus 0002:03: extended config space not accessible
[   83.792530] pci 0002:03:00.0: [177d:a065] type 00 class 0x020000
[   83.813188] pci 0002:03:00.0: reg 0x10: [mem 0x600000000000-0x6003ffffffff 64bit pref]
[   83.832490] pci 0002:03:00.0: reg 0x18: [mem 0x600000000000-0x600003ffffff 64bit pref]
[   83.848507] pci 0002:03:00.0: reg 0x20: [mem 0x600000000000-0x60000000ffff 64bit pref]
[   83.935564] pci_bus 0002:03: busn_res: [bus 03-ff] end is updated to 03
[   83.998804] pci_bus 0002:04: extended config space not accessible
[   84.025026] pci 0002:04:00.0: [177d:a063] type 00 class 0x020000
[   84.055298] pci 0002:04:00.0: reg 0x18: [mem 0x600000000000-0x600003ffffff 64bit pref]
[   84.147582] pci_bus 0002:04: busn_res: [bus 04-ff] end is updated to 04
[   84.202778] pci_bus 0002:05: extended config space not accessible
[   84.228684] pci 0002:05:00.0: [177d:a063] type 00 class 0x020000
[   84.258887] pci 0002:05:00.0: reg 0x18: [mem 0x600000000000-0x600003ffffff 64bit pref]

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
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


