Return-Path: <linux-pci+bounces-16507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366F9C4F72
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B5D2826C7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5820899E;
	Tue, 12 Nov 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kMdxqteF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE28849C;
	Tue, 12 Nov 2024 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396622; cv=none; b=K4BSwnCTugTkJWUFH8fOUNsS6lV7neyuzKNwCX/k0b3jR5zYmC5QCM8HPWKNhzsAbe1Thju2ExlQVzQOcCAhxjJN8zRmTQxT45oiL4RHYKGDbUJLQ3NR/rANjT6y9RvhXpit7cNe+HMTx+5+O5PIZ1QNxcr4ApU2Y2LV2bNSdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396622; c=relaxed/simple;
	bh=nrV52Jj4MzKAih9n5N33OzsKPLQ1zfIXNgzJzlD37Lw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zv8Sdfd/BdVbDQZ9pFyMTd6FCxz9SLNp0+OvofkCQs2LNMZPjxwbpuW76XShkW9s2R+AA0+w1J86DFhpFL0PIZEHCxxXZ5xonl+tfMOAdmRi9UhBdeG9+TBnuK5lUEOjmwKBOo4EA8+U07M/DQyIuLeLApz1D7kPhCh+vk3gejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kMdxqteF; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABGF69W010324;
	Mon, 11 Nov 2024 23:27:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Y8kAf48zRXdfXrL1ttqlddk
	xo+AVK3OCruhgpqEThVE=; b=kMdxqteFfic58zq2IstKvz/nXzkH508W+Fjj7Hb
	pihb47+yOF2QfjxO3i0lD/riUyiMVibA1WWBEgIGho06qc+sU4+/yMIL5r+4k5Ly
	8e2NRhSo56mh/dpyaluwk3Je29EIyUCpHhlFgggkpwHimVFZvUKuuCoSad9TnUb+
	DF6jsDZ6pWEYfQoz37VeSxMvmJDNkCJPHjdJkhckqAvjKRf9ZOZ+k1PB4/nxL48N
	IQ7VDw0QXRi58YRbsXDOVE9PhmTysvuPVljkrt4DRNyYIn1ug8zri24qa25LdvD5
	U0u7jYX27rhGuf1AniH9PMA7o9ortVgIBWUGHqNqwVfL1CA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42un9d1dch-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 23:27:18 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 23:27:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 23:27:07 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id E683F3F7086;
	Mon, 11 Nov 2024 23:27:06 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <thomas.petazzoni@bootlin.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] dt-bindings: pci: change reset to reset controller phandle
Date: Mon, 11 Nov 2024 23:27:04 -0800
Message-ID: <20241112072704.767569-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sne3GhOwqsbcT6kiprYrVMuiTvo7aQvd
X-Proofpoint-ORIG-GUID: sne3GhOwqsbcT6kiprYrVMuiTvo7aQvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

replace reset bit mask and system controller
with reset controller and reset bit phandle

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 Documentation/devicetree/bindings/pci/pci-armada8k.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index a177b971a9a0..a9a71d77b261 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -24,10 +24,9 @@ Optional properties:
 - phy-names: names of the PHYs corresponding to the number of lanes.
 	Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
 	2 PHYs.
-- marvell,system-controller: address of system controller needed
-	in order to reset MAC used by link-down handle
-- marvell,mac-reset-bit-mask: MAC reset bit of system controller
-	needed in order to reset MAC used by link-down handle
+- resets: phandle reset controller with int reset controller bit.
+	  needed in order to reset MAC used by link-down handle.
+
 
 Example:
 
@@ -49,6 +48,5 @@ Example:
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		num-lanes = <1>;
 		clocks = <&cpm_syscon0 1 13>;
-		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
-		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(1)>;
+		resets = <&CP11X_LABEL(pcie_mac_reset) CP11X_PCIEx_MAC_RESET_BIT(0)>;
 	};
-- 
2.25.1


