Return-Path: <linux-pci+bounces-5313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7B88FA4E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73561F29410
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744C857895;
	Thu, 28 Mar 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B6PoaNGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45750A97;
	Thu, 28 Mar 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615873; cv=none; b=JMnnzVE3nARL/x5r279wMXk0TlFY6BfNgcN0hJsbWk+mQm+WGOIOh+4dTDCn3pXJUC6l+w5J14+dO/xaSmIC9r6hXC4y9IB5sBKiEiuGP783fZz3Ki6P2c+tyUNVjdaKBMNjgBJkA16S1mdJfwxrWJKWHcEoPw7xX8l6hxxdTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615873; c=relaxed/simple;
	bh=QcfFIfnoXJ39ZOQl9Kq+tID15GTEFiWOpgi2L8iB1Og=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i64ogSxQ5uxFfKaOMhg02aFRk1tZiTVDUgcpbJ+CoUTWfWaYF6uJt4W4130tp+1CDYV1ubDZLGPzVsunVbsyx5GH91X1dENllrQEiraHm5+tfu0tOU5picYvkABozO8oMVjbERLWlXNsfogHOF06MegVQCnVYOnGYuH2D0On8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B6PoaNGY; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42S8olmd090450;
	Thu, 28 Mar 2024 03:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711615847;
	bh=Cacsn4bkQffC1LUgUwIOS+voeU8rwMJR+qK/aUFmy3g=;
	h=From:To:CC:Subject:Date;
	b=B6PoaNGYgdqP6IytfDdlSaF6P+8/ooSlT9W7JMOOhdO/ih+j7r2Xpqr5VZd9lqCAU
	 iMDbGmaS5WONMdK21tRtgL8IvT8MuxsEi6jhRIaVX9tSi4cjIl3TutKpuOXYJTdpPn
	 l2A7OqmpiQErdvt7QGZfNhE2QC42NFaWzQYc19/M=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42S8olDb031604
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 03:50:47 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 03:50:46 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 03:50:46 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42S8ofoQ006765;
	Thu, 28 Mar 2024 03:50:42 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <manivannan.sadhasivam@linaro.org>,
        <fancer.lancer@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <cassel@kernel.org>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v7 0/2] PCI: keystone: Fix pci_ops for AM654x SoC
Date: Thu, 28 Mar 2024 14:20:39 +0530
Message-ID: <20240328085041.2916899-1-s-vadapalli@ti.com>
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

This series is based on linux-next tagged next-20240328.

v6:
https://lore.kernel.org/r/20240326144258.2404433-1-s-vadapalli@ti.com/
Changes since v6:
- The v6 patch has been split into two patches based on Bjorn's
  suggestion at:
  https://lore.kernel.org/r/20240326232403.GA1502764@bhelgaas/

Regards,
Siddharth.

Siddharth Vadapalli (2):
  PCI: keystone: Relocate ks_pcie_set/clear_dbi_mode()
  PCI: keystone: Fix pci_ops for AM654x SoC

 drivers/pci/controller/dwc/pci-keystone.c | 136 ++++++++++------------
 1 file changed, 60 insertions(+), 76 deletions(-)

-- 
2.40.1


