Return-Path: <linux-pci+bounces-16498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8052E9C4F06
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337061F25191
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC920A5EB;
	Tue, 12 Nov 2024 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AvHBHolH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661E208230;
	Tue, 12 Nov 2024 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731394791; cv=none; b=EuQOJ7cFJXvvyQQrY7VdUrVLJsvPca/eBa3nP9mddanPi5Ij9sjeDeaKqXaJ85yUWAq8THvvHGaTLKQwc2JEvwi4lCWwcJqGe3aHuulEB+GCHPkx6c1xkV6r9c9kFg5ILJMaux+hqTafUkhTjv4Is/kXpBi+M5B/jsEUufscGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731394791; c=relaxed/simple;
	bh=qDKr1SHqTFXc1zzrF8GzksnSFHcq+7ZM7dwTAabdes4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G2fd4gGQ/WEF/n9aeIBhoHQvmlSKLCDUhk8lI71aaKin4+MqVEJFayg4I0998HZ7ov9tEIPTB+glsz0FXkvwx4erZ1ryO6OAJIlpb3nPv/Wk3AWaPKciVBZnJ3pUCb8E5i5BUxGzupn/sudtMh0+X36aIOX/uCzt7kAeQgI1tQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AvHBHolH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC2V0tI026802;
	Mon, 11 Nov 2024 22:52:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=3hHOU+xmmNy0cjln+gRm3o5
	Z09CstCUYxpA5W75tJb4=; b=AvHBHolHeIZXBXzAZYxQxuqUy/Efbzo45j8zway
	3uL9bZnDXcjwoS37i3V8AV5CYgZu5kG/Lb9sqqQ29E/58P8JygY55kIR+IVqJSiH
	v9An1g2tgAtml+DgKF4L+Rn2oqiC6CFsFL5L7dzyfwsz2qszAlD8v1mBru91eoic
	hDHQpvl1sXzhjLxyqCVu8xYnGcYs8fBPHY420xbXRihOtUPWjYnyukVRgf6X9IZm
	urjTNfYzulOrioRwijeyiLoemmIL1nMZ8zFipx2ZTAChTUk/vGvN092iJbJ+Tp/8
	+UcuuHVeU8DeEkV9HNZlwMtgxnX/gSpSVGnUIHGJRxq5DYg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42uxa40bnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 22:52:34 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 22:52:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 22:52:32 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id C385A3F707E;
	Mon, 11 Nov 2024 22:52:31 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <lpieralisi@kernel.org>, <thomas.petazzoni@bootlin.com>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] dt-bindings: pci: armada: add system controller and MAC reset bit
Date: Mon, 11 Nov 2024 22:52:29 -0800
Message-ID: <20241112065229.753466-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j28e8jnXFbR5Ng1p4bFkYk-VW7Y62nLd
X-Proofpoint-ORIG-GUID: j28e8jnXFbR5Ng1p4bFkYk-VW7Y62nLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Adding Armada 7K/8K controller bindings optional system-controller
and mac-reset-bit-mask needed for linkdown procedure.

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 Documentation/devicetree/bindings/pci/pci-armada8k.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index ff25a134befa..a177b971a9a0 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -24,6 +24,10 @@ Optional properties:
 - phy-names: names of the PHYs corresponding to the number of lanes.
 	Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
 	2 PHYs.
+- marvell,system-controller: address of system controller needed
+	in order to reset MAC used by link-down handle
+- marvell,mac-reset-bit-mask: MAC reset bit of system controller
+	needed in order to reset MAC used by link-down handle
 
 Example:
 
@@ -45,4 +49,6 @@ Example:
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		num-lanes = <1>;
 		clocks = <&cpm_syscon0 1 13>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		marvell,mac-reset-bit-mask = <CP11X_PCIEx_MAC_RESET_BIT_MASK(1)>;
 	};
-- 
2.25.1


