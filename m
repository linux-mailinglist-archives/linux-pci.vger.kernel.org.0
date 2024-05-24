Return-Path: <linux-pci+bounces-7812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31528CE487
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEB4282228
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883558624C;
	Fri, 24 May 2024 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bIm8lu9c"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415F85C7A;
	Fri, 24 May 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548271; cv=none; b=d6/6L4c5C5ReeCBhcxzLyahRdHsCSoryoDmNX0FyVrZRM7lqrUNyygmZFl5TNTHikQOzPtxsuI++s4Q9UKLDjK8zF3a0zy3nADhYz+26SYThkIRVLbXur9fcOeOlLchODcEMSm0eR7mxCK7O1Ba4G2Rwj4skLHXITISnhAdZHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548271; c=relaxed/simple;
	bh=DhRgvtrP0c3jw3+XoN0gC/RIwZJM7A0fl6LplMmhz/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X5d0FydpIL/RQww84CZcmpjaDjfy80VkTcjRaLrMPQETuNw5wRZmbEOOrKYDd9MevKgi7QQRQv3Mt4vCSz4QZHDbfH2q68hQwDtnH8cOyihK2O2YhMWQKPs+iH60isLmmnu7A6xtOclG3EyDEL0gzBmxBVqKquFuH6r6+vJCfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bIm8lu9c; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44OAvKAs028538;
	Fri, 24 May 2024 05:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716548240;
	bh=gxcOAXEsT0+7t2D4xiq39hB4HHwZ3vun1qDGSyIbQrk=;
	h=From:To:CC:Subject:Date;
	b=bIm8lu9cOJ8SJ8qhzIXH9CzTy3sCaJ0KfhwxM2KsgiF1o6YaTea0/27SvIcs6tuF3
	 azCC7Nf+mhY92h5pwB+LdQBHA29YFvkBhpulAK8abX/IrW4JRIWXXEFFj9TWU7DgW2
	 ls6SWbgHKRMtYlz2qDU5iAUqvEAw0okJDISexqZk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44OAvK6e036870
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 05:57:20 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 05:57:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 05:57:20 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44OAvFvD049802;
	Fri, 24 May 2024 05:57:16 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <manivannan.sadhasivam@linaro.org>,
        <kishon@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <cassel@kernel.org>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Fixes for PCI Keystone driver
Date: Fri, 24 May 2024 16:27:12 +0530
Message-ID: <20240524105714.191642-1-s-vadapalli@ti.com>
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

This series adds fixes for the PCI Keystone driver.
The v1 of this series was posted on the 24th of March 2021:
https://lore.kernel.org/r/20210324121901.1856-1-kishon@ti.com/
There are no changes since v1 except for rebasing the series on the
latest linux-next.

There were no open comments on the v1 series so it appears to me that
the series got missed when merging patches to the PCI tree. I am
reposting the series after rebasing it on linux-next tagged next-20240523.

I don't have the device corresponding to the older "ti,keystone-pcie"
compatible so I wasn't able to test this series (specifically patch 2
of this series). I have only compile-tested this series and logically
verified it for correctness to the best of my knowledge.

Regards,
Siddharth.

Kishon Vijay Abraham I (2):
  PCI: keystone: Set mode as RootComplex for "ti,keystone-pcie"
    compatible
  PCI: keystone: Add link up check in ks_child_pcie_ops.map_bus()

 drivers/pci/controller/dwc/pci-keystone.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.40.1


