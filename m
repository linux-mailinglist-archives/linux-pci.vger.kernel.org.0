Return-Path: <linux-pci+bounces-43101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012ECC18B0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 09:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF99303C297
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 08:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DA4349B0B;
	Tue, 16 Dec 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ONWDosZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4BA347FD8;
	Tue, 16 Dec 2025 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872803; cv=none; b=gLeCuQQEuLeDyj9x4Ptk9AOQxunVFiVNdRT8fbiV8bjixPYzmtHmbDOyjHkP5VC6edKei4gslqthoDbXcyK0IbBhkU+FbQVIOg9Mxh3EC9hyZAQx8wpVnjROJyS/9Psp2GSRHEJeLDU2y9pOtLY/X/0Udm5ZiVsqqi2qoKrC9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872803; c=relaxed/simple;
	bh=L2S7GYPOBXAwZK10RkOfIOWQatRbHK+uLLcenk5wXf0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pu8hYR1QANJ/bRGUID5bKKFFHV+8vg+b22urnPDwfO55YW2urYDmdzdg5vhZswm+8Zln0GDe2W4icNEJp7a3FLOn6toKp9SzjXbxEBri2N0HQwwyPicSd/nDusCxjSjXzI6BVQN3Hc4YY0JEWavHABf43qhHvQZeQwlCpmOOpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ONWDosZF; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zbOTsv/beHp87ZtyD3t7LTaXEOz0aIK8UQwLv/fihAs=;
	b=ONWDosZFY+ul52h7W8xbc78s+nxbxQnuMEIkDO9hRjS9W4fPfJeFAzSTkR/MkggBI6gbpfE58
	0iue/GZWc0PpJeP/EtT2Icv0yrK4FsMtPgnXyI671D2Vw1stQNpkvD3mgGbUwljMbwwkX0w0ib0
	3viQsuwUPPIu2J54m3sFz1Q=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dVqPw27Fkz1prKB;
	Tue, 16 Dec 2025 16:11:16 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 95106140132;
	Tue, 16 Dec 2025 16:13:17 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Dec 2025 16:13:17 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chrisw@redhat.com>, <jbarnes@virtuousgeek.org>,
	<alex.williamson@redhat.com>, <liuyongqiang13@huawei.com>,
	<duziming2@huawei.com>
Subject: [PATCH 0/3] Miscellaneous fixes for pci subsystem
Date: Tue, 16 Dec 2025 16:39:09 +0800
Message-ID: <20251216083912.758219-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500012.china.huawei.com (7.202.195.23)

Hello!

This series contains miscellaneous fixes for pci subsystem:

Yongqiang Liu (2):
  PCI/sysfs: Prohibit unaligned access to I/O port on non-x86
  PCI: Prevent overflow in proc_bus_pci_write()

Ziming Du (1):
  PCI/sysfs: fix null pointer dereference during PCI hotplug

							Thanx, Du

 drivers/pci/pci-sysfs.c | 14 ++++++++++++++
 drivers/pci/proc.c      |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.43.0


