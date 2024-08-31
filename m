Return-Path: <linux-pci+bounces-12544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE94966F44
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 06:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5767B1C21CD2
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 04:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436E136358;
	Sat, 31 Aug 2024 04:17:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5F22086
	for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2024 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077864; cv=none; b=KjBD6NnYslpTrEZiZOHoIJxGcFafHq0wYJEN03fBTIQYgnM1Cs7XLEGyQwOjwH6bf8nSouklze8hT8CIC9O327SRuZkAFlF0dW32wiwC1y6YE0SxsNGWZaXL7HIQlduJSlmEiofKSlpCvFu9tgQM6gunBWvaSx4C0Eo6xA12pqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077864; c=relaxed/simple;
	bh=b7uH07utdHrwM1ZOx1yquIktJbmv9P89DRy+i9zwsSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JMuiFbgEUqZx2GcATmxoExDKVdYT4p6GW8B4t4U8xfPuP1Cvv7HZwqFk7RTCOGIj6c7N9xzahW6WMlhGEzVVbMkHHDPfPJrRY1YilgJvj9sLY5HO5QH4zzoHcRYh5dZLzsK51uWqcnz/RGiVqEhvhUz63M9DXzARnBT8gsBiPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwhSZ4Yh9z20n3Z;
	Sat, 31 Aug 2024 12:12:46 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 01E8A180043;
	Sat, 31 Aug 2024 12:17:39 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 12:17:37 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>, <Jonathan.Cameron@Huawei.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v3 0/6] Simplify code with _scoped() helper functions
Date: Sat, 31 Aug 2024 12:04:07 +0800
Message-ID: <20240831040413.126417-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Use _scoped() functions to iterate through the child node, and we don't
need to call of_node_put() manually. This can simplify the code a bit.

v2:
- Use dev_err_probe() to simplify code.
- Fix spelling error in commit message.

v3:
- Fix a spelling error.
- wrap the line when it is too long.

Zhang Zekun (6):
  PCI: kirin: Use helper function
    for_each_available_child_of_node_scoped()
  PCI: kirin: Tidy up _probe() related function with dev_err_probe()
  PCI: mediatek: Use helper function
    for_each_available_child_of_node_scoped()
  PCI: mt7621: Use helper function
    for_each_available_child_of_node_scoped()
  PCI: apple: Use helper function for_each_child_of_node_scoped()
  PCI: tegra: Use helper function for_each_child_of_node_scoped()

 drivers/pci/controller/dwc/pcie-kirin.c | 50 ++++++----------
 drivers/pci/controller/pci-tegra.c      | 80 +++++++++----------------
 drivers/pci/controller/pcie-apple.c     |  4 +-
 drivers/pci/controller/pcie-mediatek.c  | 15 ++---
 drivers/pci/controller/pcie-mt7621.c    | 15 ++---
 5 files changed, 58 insertions(+), 106 deletions(-)

-- 
2.17.1


