Return-Path: <linux-pci+bounces-12325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F509621C8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 09:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F841C216A2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 07:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC9F1598E9;
	Wed, 28 Aug 2024 07:51:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D51487FE
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831510; cv=none; b=k/5TngvqQhh6LF2HthULcUc8wuaSPFw1ZnFYGD9MNUHg2sod+uM0hrwZ1grRVqPEIKGGlMLB4rHMYN1J3JNZeKF+B3zITDK5NUtR5LpbrAeya1GWT758CDYOiGhInar3jmDl96v5dqnsfseOkafUodXxvvK19Eb9AjXR3yfYRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831510; c=relaxed/simple;
	bh=6X8oB9i6UWhWvQ8YihWk3s4RS/Y3ogIY7fJIUSK1ibA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AijKb0Oo/D+rWQ8Gu1DAMZDOgF264NIOVu8omoBUS2dgJiaIlEwuYfErKh+bN/UGMR8dqfBz+epadTivT+sl4uXqVaQyEAE6A//xVom4U65ai84wJBYKwokMAc6qlTxeJkO3oJ82GtjIU7G0P3a5uCwEJsfFUilTAJeGYqvKsBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WtxM347gMzQqyn;
	Wed, 28 Aug 2024 15:46:55 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AF7A140202;
	Wed, 28 Aug 2024 15:51:45 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 15:51:43 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 0/5] Simplify code with _scoped() helper functions
Date: Wed, 28 Aug 2024 15:38:20 +0800
Message-ID: <20240828073825.43072-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Use _scoped() functions to iterate through the child node, and we don't
need to call of_node_put() manually. This can simplify the code a bit.

Zhang Zekun (5):
  PCI: kirin: Use helper function
    for_each_available_child_of_node_scoped()
  PCI: mediatek: Use helper function
    for_each_available_child_of_node_scoped()
  PCI: mt7621: Use helper function
    for_each_available_child_of_node_scoped()
  PCI: apple: Use helper function for_each_child_of_node_scoped()
  PCI: tegra: Use helper function for_each_child_of_node_scoped()

 drivers/pci/controller/dwc/pcie-kirin.c | 10 ++----
 drivers/pci/controller/pci-tegra.c      | 41 +++++++++----------------
 drivers/pci/controller/pcie-apple.c     |  4 +--
 drivers/pci/controller/pcie-mediatek.c  | 11 +++----
 drivers/pci/controller/pcie-mt7621.c    |  9 ++----
 5 files changed, 25 insertions(+), 50 deletions(-)

-- 
2.17.1


