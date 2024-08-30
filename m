Return-Path: <linux-pci+bounces-12475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B5D96562E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 06:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6911C21863
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 04:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E88146D69;
	Fri, 30 Aug 2024 04:11:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8BC22615
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724991108; cv=none; b=LPshgAppmug4zjZCH0AYfgP+oQRhWsr5fD1KJ425xdvRsT4We++LcEfnEt6KhQxYNn2yTrgL2C6ShONTkbhXxwyrP4qEmE/lrncvKpqb7bb28VREK4OWaYf6QMTzXMvMbmLd9d05rqXlJ1VixHR08Y990o3GusbTseF0otbhQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724991108; c=relaxed/simple;
	bh=LA9Y1vuslF1RSc3om/ABvEcWTJj3L/IigstHVsoMV1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i0tO0nnGqQvXfZtOSCPjWv9SG+kTTAl7jxaBp+1Brn1/afzdd7eVyT8wvpwGYUtSZoHaKpI9X2JRRUsDJ2JX4ehHemtoaAOyvAL9PZtLl9DfzMLtog49EbrxvZ0rpe2MbWsN/12WNHZw3VZ77AwMnqsllupJpnzpwN7JVT7GwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ww4Sr271fz18Mx7;
	Fri, 30 Aug 2024 12:10:52 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B7A16140202;
	Fri, 30 Aug 2024 12:11:42 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 12:11:41 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>, <Jonathan.Cameron@Huawei.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v2 0/6] Simplify code with _scoped() helper functions
Date: Fri, 30 Aug 2024 11:58:13 +0800
Message-ID: <20240830035819.13718-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Use _scoped() functions to iterate through the child node, and we don't
need to call of_node_put() manually. This can simplify the code a bit.

v2:
- Use dev_err_probe() to simplify code.
- Fix spelling error in commit message.

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

 drivers/pci/controller/dwc/pcie-kirin.c | 46 +++++----------
 drivers/pci/controller/pci-tegra.c      | 74 ++++++++-----------------
 drivers/pci/controller/pcie-apple.c     |  4 +-
 drivers/pci/controller/pcie-mediatek.c  | 15 ++---
 drivers/pci/controller/pcie-mt7621.c    | 15 ++---
 5 files changed, 49 insertions(+), 105 deletions(-)

-- 
2.17.1


