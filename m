Return-Path: <linux-pci+bounces-44241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F8ED00901
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 02:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 926433038019
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 01:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FD61F4615;
	Thu,  8 Jan 2026 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NqaafbQt"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332AE22A1E1;
	Thu,  8 Jan 2026 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836081; cv=none; b=l8j9T6nM5WOpZN+dPpB2tK2vvJy4IoGmioNz+D5IS617wrkuLQBvZ6C1Ja48V9VUK7ke8tDdSqRaSg8Z5EMArc9Y0iwU8hKZoUxzVwtxFei8xUfr6cYLtQR16py+c9M4Ih/dSyxIQYYzlN/phf7V+YzpBHO7GkwGlv6DJvvhKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836081; c=relaxed/simple;
	bh=PwVs6V+EeBOZG7xHiaG1qVpHr5maYKBc1KSrivggCGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pw+D1VGzh6M0FIUtX2jATw1f7lCFnU4kATJAwyRE5Kqbqg0NGN/ZQ6bEpT4bpE+4p17pn+7PluSFYkjr7TA3yW23zAFNPPPxDeaNZaq9jPSRZf+CdpETYOLpizcBK/wdhR250dj4Y8uReXn4vDCjnYbELuEm8em0jAFooQI9mEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NqaafbQt; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x795RryeLenZCrBNny0LYWzCuqG9woSgFCq97oSuQ6s=;
	b=NqaafbQt6arLl4brcO0085No7DyhKgQK4EsZ1BSFikeyJOF4YXfyvUckL8OYsulPRS8Tro2v/
	0PiySAIkZIWZuZZY+VKBRtfGCD1jiNxXDYItW3IReyZGORgfK2QgdwDbmGY2vFMpqFo8QlhWCe7
	0Ks7HHe9N37XBeGT+i4MC4Q=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dmnRh6gFSzmVVv;
	Thu,  8 Jan 2026 09:31:12 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C63C40539;
	Thu,  8 Jan 2026 09:34:29 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 09:34:28 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v3 0/3] Miscellaneous fixes for pci subsystem
Date: Thu, 8 Jan 2026 09:59:41 +0800
Message-ID: <20260108015944.3520719-1-duziming2@huawei.com>
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

Miscellaneous fixes for pci subsystem

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
  PCI/sysfs: Prohibit unaligned access to I/O port on non-x86
  PCI: Prevent overflow in proc_bus_pci_write()

Ziming Du (1):
  PCI/sysfs: Fix null pointer dereference during hotplug

 drivers/pci/pci-sysfs.c | 11 +++++++++++
 drivers/pci/proc.c      |  6 +++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.43.0


