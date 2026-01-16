Return-Path: <linux-pci+bounces-45021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39703D2D8D5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 08:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B113083C7B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB172C11F3;
	Fri, 16 Jan 2026 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="brxNcF90"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752C3C38;
	Fri, 16 Jan 2026 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549948; cv=none; b=b5UYo2Q3XdCNuG450YmPu08rD59wXmnUsbBJmXEzlrP4pMEba9Z0/xAtTQEpiXz9clT1o+lYIHIGdAc8lhpPKX7WyKb0xXSCfCj00lpQdifH9F2q4k7GmLxMWxgjgNPN15s0OpeMiISYX4WJLhkdX93RO7FvI0QtQPxr2R7zz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549948; c=relaxed/simple;
	bh=2SLkKFQrDOzyQBwhViHlyyk3nzemeDJYp3LZQpYzZ8g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qLLnysOxzYlpqx7bHDxkyNVfA/hqJjzoO/Pl3N/qjBnPAQi34uo7TEF1/f/HLGdO4P2IZI3QaZuJLVmzmvhJrGHOYhT5ptEoahUErG8aQLL+/Ba2OL3T8Jq3KhKM4MnqSBrvAuj+eOGje52528O+gohPhNLPS88XgxbmaHhJx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=brxNcF90; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Lbc6s7BfjdYN6UzX1X6BsPBdAHxZSPui8+3X2WI9GcY=;
	b=brxNcF906Af6UPdkEUUGmdIMZcug3j2sGdZdr3Xcib0/rwTv9S42Ehn2HIOaTJhtCuNFVNxU2
	wgmhIbhzqVuBfo7Ub2zUOG0sO3tyO2Xh9kQ8g42ARpGn/2MhkynCf9xGvvZim5FbNvievTk+eVe
	sT2QMKqdC2igpjt5ln8Q+wI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dssRx4B5dzRhRh;
	Fri, 16 Jan 2026 15:49:01 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FC9E40538;
	Fri, 16 Jan 2026 15:52:22 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Jan 2026 15:52:22 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <alex@shazbot.org>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>
Subject: [PATCH v4 0/4] Miscellaneous fixes for pci subsystem
Date: Fri, 16 Jan 2026 16:17:17 +0800
Message-ID: <20260116081723.1603603-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500012.china.huawei.com (7.202.195.23)

Miscellaneous fixes for pci subsystem

Changes in v4:
- Remove the architecture-specific #ifdef to apply the alignment
  check for all platforms (including x86), as device registers are
  naturally aligned anyway.
- Fix a potential issue in proc_bus_pci_read() to make it consistent
  with proc_bus_pci_write(), as suggested by Ilpo Järvinen.
- Link to v3: https://lore.kernel.org/linux-pci/20260108015944.3520719-1-duziming2@huawei.com/

Changes in v3:
- Check *ppos before assign it to pos.
- Link to v2: https://lore.kernel.org/linux-pci/20251224092721.2034529-1-duziming2@huawei.com/

Changes in v2:
- Correct grammer and indentation.
- Remove unrelated stack traces from the commit message.
- Modify the handling of pos by adding a non-negative check to ensure
  that the input value is valid.
- Use the existing IS_ALIGNED macro and ensure that after modification,
  other cases still retuen -EINVAL as before.
- Link to v1: https://lore.kernel.org/linux-pci/20251216083912.758219-1-duziming2@huawei.com/

Yongqiang Liu (2):
  PCI: Prevent overflow in proc_bus_pci_write()
  PCI/sysfs: Prohibit unaligned access to I/O port
Ziming Du (2):
  PCI/sysfs: Fix null pointer dereference during hotplug
  PCI: Prevent overflow in proc_bus_pci_read()

 drivers/pci/pci-sysfs.c |  7 +++++++
 drivers/pci/proc.c      | 11 +++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.43.0


