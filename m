Return-Path: <linux-pci+bounces-43651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8319BCDBBC6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 10:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2BFA303FE46
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA232F75F;
	Wed, 24 Dec 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ubB5/iho"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E8311597;
	Wed, 24 Dec 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566909; cv=none; b=NFloNzWlPAEJQixnqfdnyQgoxNacmiLd65qxlsOgrmXof4gl61eOwk/7juBRUEXgMYwSbXq2kxo26HgaAz5kvC3jZw8Vu39dyp+DL4xZU9XKKFEqjZ0eUlACK3nfjOdalT1WciH1mW4PK1YzG3ppVcXU7ajZBvjatJga+0IAO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566909; c=relaxed/simple;
	bh=vClo30wxSosW0JAgzeL1m6iTsUiR47+QoeojeIONJw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LfkLt1gthdbeDP/0etxBjS63RGVU4JMbrj0r0sp5djJNTB2w5e7fKOp+bpKefX3y+TkM3Ud6OKJnNZxFwkpzUw9TVE8uOqqNm9zAdDxF23wph11ji6T5ZcPdKgkxuJKT4i6xqE5Z7ag2rykxz2kom600bsmJXzk6P+2GisNk5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ubB5/iho; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SQShtaFCTxayYbmKYduvbEjtqODrdx5JPrXXq2zVfuE=;
	b=ubB5/ihowKoXc0dy8rzWsdbmNqiYSzyBrtvy4sVqo5t5zh2rapRq1HIx34zpll5aeaAVn/fbD
	GdYoFiHGjQGWB7lXmBRF32X5NsY7bBoq6Q+ILJKeqrVcgq1ciT4awKDWKdBfwW9JtTcCIjVyQiI
	8rgWTi1JOHf2ohshIxeNN9I=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dbm4p3Q0Tz1cyQ8;
	Wed, 24 Dec 2025 16:58:34 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id DD9E840565;
	Wed, 24 Dec 2025 17:01:40 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Dec 2025 17:01:40 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <jbarnes@virtuousgeek.org>, <chrisw@redhat.com>,
	<alex.williamson@redhat.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v2 0/3] Miscellaneous fixes for pci subsystem
Date: Wed, 24 Dec 2025 17:27:16 +0800
Message-ID: <20251224092721.2034529-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500012.china.huawei.com (7.202.195.23)

Miscellaneous fixes for pci subsystem


Ilpo Järvinen warned me of potential issues in my previous patch,
so I have made the necessary adjustments. 

Changes in v2:
- Correct grammer and indentation.
- Remove unrelated stack traces from the commit message.
- Modify the handling of pos by adding a non-negative check to ensure
  that the input value is valid.
- Use the existing IS_ALIGNED macro and ensure that after modification,
  other cases still retuen -EINVAL as before.
- Link to v1: https://lore.kernel.org/linux-pci/20251216083912.758219-1-duziming2@huawei.com/
								Thanx, Du

Yongqiang Liu (2):
  PCI/sysfs: Prohibit unaligned access to I/O port on non-x86
  PCI: Prevent overflow in proc_bus_pci_write()

Ziming Du (1):
  PCI/sysfs: Fix null pointer dereference during hotplug

 drivers/pci/pci-sysfs.c | 10 ++++++++++
 drivers/pci/proc.c      |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.43.0


