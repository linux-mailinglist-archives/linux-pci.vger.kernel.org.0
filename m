Return-Path: <linux-pci+bounces-22314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1AAA43B8A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E847AC0C1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A010C2641C7;
	Tue, 25 Feb 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="IbUp1twy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ECM6yOco"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9E8F4A;
	Tue, 25 Feb 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479267; cv=none; b=WRYNAJ75Z5dNiRFhCqagC4w4wqD5xt/Ru1T903YzZTCLZSnuJNrAwa5OGWrRL5voQ9I2BaNWY3Bqwugklz9KObUvFwgM+lEzc8gILa8ugRznxXQuyayNu9igzN7cT+KauvY5UgKV+SM+MlV3jjoU9MfKMS3AZseMyoXpKv8L35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479267; c=relaxed/simple;
	bh=mVKpdeeiYw226WHLq44Om65ce+IGZK0AgVZF+3H5Gug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huX5cE67J3APZ4v1h4WmasxARA1ac4A6qAGbzTy7O6kd9LK340FA5hTJUc2UFuBu/Cp/L7phPuvilcZYPpdwaCUjuNIXtt8bNAsBvNnFSZpzpERDa7c6awSSOnABy35agCWf4LpE0sJ5IcbcHkjIZqQqlTbEWPdaAGYeA0pV0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=IbUp1twy; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ECM6yOco reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740479265; x=1772015265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JKIIrvyYA+gZm83nHFuNxA39LsjVxEX31VPSiey1bdc=;
  b=IbUp1twyH0KVhgVogTmlRitHfH4yu+TelgroSNSUCO2lia6XIravFx+q
   4qLY9AsAuinRtwLWpm84+FeBmzP3r/2cpb+MZ48OO0GroYvrGJ3LaRwOy
   Ueh00x2i5ab4LmfKOj+8ZWEt3/0MhOo/aaCTIZ1KBqdDFRXuf0I3Bf/uO
   JhlRLVwawJikabZZcKlL5Jd8kie4Hl2n80SMb0mycrl2Cz/a5l7HpQTsS
   /0gGG7oBP/7tXRBNsvUPu2SV763et2gyM8Xj1Ufz+2Y46aw+TlofLAKeC
   nmOGu24xsnkuIqasgpmTMdRNn3lJhNBQQOn5e50+LVJe39Inh93oNxKUL
   g==;
X-CSE-ConnectionGUID: AZdDBfoURgeNHgJKSZLLGw==
X-CSE-MsgGUID: Za8JJxYISpCkzurMnjrrLQ==
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="42067825"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Feb 2025 11:27:42 +0100
X-CheckPoint: {67BD9B1E-B-6E0A4539-DBC44C3A}
X-MAIL-CPID: 187A32B327A701531B4B47B9AD6D0F89_1
X-Control-Analysis: str=0001.0A00211A.67BD9B1D.0054,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 300FF168561;
	Tue, 25 Feb 2025 11:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740479257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JKIIrvyYA+gZm83nHFuNxA39LsjVxEX31VPSiey1bdc=;
	b=ECM6yOcoQiugNIAhZWqDx1+0pPmHt8AANO568tWe2SIhwTRieaBOrjBjV7ABLZWCJQ++i6
	v0OFfCtOas6+4iAhTaUb9tvU4ejks9tClTbMoOqw26TDG1wm3LqrKY7BlWd4TY2mho27NO
	5ieBUKQh8Mn1ekyr7i42t/kINZz6oJFWv0EBgzsXZTjLNbadpG8aP+hKY8OcuzNMsPAjQM
	0OdsvPIiytlqWP0jV81qvr/EMFGuwcYyHLbEokoYUEE+yQUuiEyS0h1L13a0xIKxATsvWu
	zFFt9qHklfbSM738aE6kc6DK2ApvVOJ41HQGlSxTIbQgj672iF1SvqqFzoNn6A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: [PATCH 0/3] imx8qxp: PCIe fixes
Date: Tue, 25 Feb 2025 11:27:20 +0100
Message-ID: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

my series at [1] introduced some dtbs_check warnings for imx8qm based platforms,
highlighted by Frank [2]. This series fixes the problem by updating the schema
for allowing an optional DMA interrupt and adding the DMA interrupt for imx8qm.
Also a non-upstream property is removed as well.

Best regards,
Alexander

[1] https://lore.kernel.org/all/20250107140110.982215-1-alexander.stein@ew.tq-group.com/
[2] https://lore.kernel.org/all/Z7yxDRO+ICPCu0I2@lizhi-Precision-Tower-5810/

Alexander Stein (3):
  dt-bindings: PCI: fsl,imx6q-pcie: Add optional DMA interrupt
  arm64: dts: imx8qm-ss-hsio: Wire up DMA IRQ for PCIe
  arm64: dts: mba8xx: Remove invalid propert

 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 4 ++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi         | 5 +++--
 arch/arm64/boot/dts/freescale/mba8xx.dtsi                 | 1 -
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.43.0


