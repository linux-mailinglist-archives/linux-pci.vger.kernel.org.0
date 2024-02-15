Return-Path: <linux-pci+bounces-3489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03311856207
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 12:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E001F25AA3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 11:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9118412BE8E;
	Thu, 15 Feb 2024 11:47:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA312AAE4;
	Thu, 15 Feb 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997635; cv=none; b=QOO4OLphWr4rg3AQhSyqK21n32Naf8RMkFl3eXgF9cZENwXiyUwSn93EbNgF6GL51JG8h38SvuaeX6xucgIgYmvXo5SObVXh6N9gHS8Fn8TAXgh5bdti88XTiIf97urG1M1tdtPG1Ml+1enGV1ZxJEGoRids7p5HUTMwbaUNJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997635; c=relaxed/simple;
	bh=pVKMskrg2EOHurv3uw2zMsfBkmaswPPUHPPelj0IY3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XlaCTy6KroZrIrZ9NfX2U4uP9zQc5LWvNDihhXyjEh4LDQZtE0DkfS5Us0v+YyoxS8D4aHaIJ4qvjZ3OBhwCvP4eBNw3bvQN6DBfTIo+tWCz/5QCDhrBaBYK85+/12XiJP696KDDJRBE2PArvR2uCPbMzxeOnZfHiGcWiAmRA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCqZ03XTz6J9hM;
	Thu, 15 Feb 2024 19:43:06 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F0091400CD;
	Thu, 15 Feb 2024 19:47:08 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:47:08 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <mchehab@kernel.org>
CC: <qingshun.wang@linux.intel.com>, <jonathan.cameron@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [RFC PATCH 0/2] rasdaemon: Add handling of new fields in aer_event for advisory non-fatal and other errors
Date: Thu, 15 Feb 2024 19:46:57 +0800
Message-ID: <20240215114659.1513-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add handling of following new fields in trace aer_event
for advisory non-fatal and other errors.

  - cor_status          (Correctable Error Status)
  - cor_mask            (Correctable Error Mask)
  - uncor_status        (Uncorrectable Error Status)
  - uncor_severity      (Uncorrectable Error Severity)
  - uncor_mask          (Uncorrectable Error Mask)
  - aer_cap_ctrl        (AER Capabilities and Control)
  - link_status         (Link Status)
  - device_status       (Device Status)
  - device_control_2    (Device Control 2)

https://lore.kernel.org/lkml/20240125062802.50819-5-qingshun.wang@linux.intel.com/

Shiju Jose (2):
  rasdaemon: Add handling of new fields in aer_event for advisory
    non-fatal and other errors
  rasdaemon: ras-mc-ctl: Add support for new fields in aer_event for 
    advisory non-fatal and other errors

 ras-aer-handler.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-record.c       | 20 ++++++++++++++++
 ras-record.h       | 10 ++++++++
 ras-report.c       | 24 +++++++++++++++++--
 util/ras-mc-ctl.in | 19 +++++++++++----
 5 files changed, 127 insertions(+), 6 deletions(-)

-- 
2.34.1


