Return-Path: <linux-pci+bounces-12278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCC2960A08
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 14:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F72B228F6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F31B581C;
	Tue, 27 Aug 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YzppQndm"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA141B5317;
	Tue, 27 Aug 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761502; cv=none; b=YTc+6+7SC0AO01sfj26hCDf/dpdHLwMrbVa3N81PNUSNWRWscURTMkV+GjOm2IyDogaUkuhemoLe84IXJLBhbM+9Wnjn0b49NFbHcVNmZnTGxy43mrBhQ3SXRVAWyGeeQRcUgDRLM9Za0Dt/CEmqKohMb9r0al3+3jyG5NVSCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761502; c=relaxed/simple;
	bh=VifBbbT4jI4kSbghfg/bBdn4n9115mt2U/GVNdWHj9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gqR/Lu90O0LmzY3kgFMw22fy/tzc8wA8iYnEkyYJm03DjTryNMojo3agqXmzCVdxFwxQv0GKIYQoTauHXjfgbn7Pzw/B+fURHLwnvMrTNrBYR2pzGw5VEPL0KG4nzd88fxAYij0YBuERy3ARK5CfR+6vELqwIVn4c/DCz+1GuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YzppQndm; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RCOTQ5048711;
	Tue, 27 Aug 2024 07:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724761469;
	bh=5vLxHSPPDpTvxCRX8hzBTvQzKMqlBgRluuKOgPM3Ifk=;
	h=From:To:CC:Subject:Date;
	b=YzppQndmQJftQtBWp/iyoAdwL7nnlMTDk7ddQyxFkztXQmqIEBgf3Sd4PVlhD1P4I
	 gZ7Y0w8AKaddAqPfLPm52wJccU/J3sMEV/tf6M6hJHLRQ5Rl/XNyEmPZ8l408k9Izj
	 io1TIO8QVyrbc6pG6zetpYHOQyPtAQ7e2MOHF5Tg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RCOTV5051138
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 07:24:29 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 07:24:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 07:24:29 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RCONYC011388;
	Tue, 27 Aug 2024 07:24:24 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <j-keerthy@ti.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <u-kumar1@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/2] Fixes for the PCI dra7xx driver
Date: Tue, 27 Aug 2024 17:54:20 +0530
Message-ID: <20240827122422.985547-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

This series is based on commit
3e9bff3bbe13 Merge tag 'vfs-6.11-rc6.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
of Mainline Linux.

The first patch fixes conversion to "devm_request_threaded_irq()" where
the IRQF_ONESHOT flag should have been added since the handler is NULL.

The second patch fixes the error handling when IRQ request fails in the
probe function. The existing error handling doesn't cleanup the changes
performed prior to the IRQ request invocation.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  PCI: dra7xx: Fix threaded IRQ request for "dra7xx-pcie-main" IRQ
  PCI: dra7xx: Fix error handling when IRQ request fails in probe

 drivers/pci/controller/dwc/pci-dra7xx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.40.1


