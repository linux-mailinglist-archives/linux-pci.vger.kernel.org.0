Return-Path: <linux-pci+bounces-44723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B7DD1DB65
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AED3301D654
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FEA3328F0;
	Wed, 14 Jan 2026 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XHw7tdL1"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830A3612E2;
	Wed, 14 Jan 2026 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384188; cv=none; b=BYnFD66l7G72M8+RYfoKlL/pQR6yAiVphsh4Njb5G0o29BGRVJuRZJpz/0Z5Hpw2YGXHdxfNqYxHRLDl5GeL10uPXLAXWH4LbZsx+6WajWv9xOIJl+BlHttunen9DfMfyVvsVNAN+drUWIWl0LT/fW9j4UyS3mRRhbBApZa39Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384188; c=relaxed/simple;
	bh=aIKelqJkezQTifbDuUvtu/Ap6GHH5Pl9f40JH/Okyv8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L1WaMdgLOnGRndvfamsRxoEAOfrP3EYpjFROIVCoYtXepThD7OM4PdrNwkSPyib9g0T35WTxa53CzeRaHPojBgdIr4ACgsWM6rkhx3hPcWWtNFkZuqaNdCdU9wkFXdXuZJpacTsIxADUalqJ5wLLJxSMMPgDzhrZ2oAN5thUbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XHw7tdL1; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aIKelqJkezQTifbDuUvtu/Ap6GHH5Pl9f40JH/Okyv8=;
	b=XHw7tdL1vkCi89Fk8grch1nDqMbZP/kOikPRUNLhY3hpZBXdWXQ4j+/CMUSRCeUGGLz+6f+IR
	xjI+1QHOnWzpp61nkGcphvvGvW/CegPi/CZE7cnNzh7+nihSBnaOlpbioWi2R6rL1UR+r0dX3GW
	YuLkecx8lqV2PNyy1nJfdYs=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4drh8J2cFhzmVCy;
	Wed, 14 Jan 2026 17:46:24 +0800 (CST)
Received: from dggpemf100002.china.huawei.com (unknown [7.185.36.19])
	by mail.maildlp.com (Postfix) with ESMTPS id 95D0840562;
	Wed, 14 Jan 2026 17:49:44 +0800 (CST)
Received: from dggpemf100007.china.huawei.com (7.185.36.214) by
 dggpemf100002.china.huawei.com (7.185.36.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 Jan 2026 17:49:44 +0800
Received: from dggpemf100007.china.huawei.com ([7.185.36.214]) by
 dggpemf100007.china.huawei.com ([7.185.36.214]) with mapi id 15.02.1544.011;
 Wed, 14 Jan 2026 17:49:44 +0800
From: Kangfenglong <kangfenglong@huawei.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shenyang
 (M)" <shenyang39@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"shenjian (K)" <shenjian15@huawei.com>, "Wangyu (Eric)"
	<seven.wangyu@huawei.com>
Subject: [BUG] PCI/DPC: NULL pointer dereference in pci_bus_read_config_dword
 during DPC recovery racing with hotplug
Thread-Topic: [BUG] PCI/DPC: NULL pointer dereference in
 pci_bus_read_config_dword during DPC recovery racing with hotplug
Thread-Index: AdyFOv+AaZVnS8lRRV6uf8BQq0jYUw==
Date: Wed, 14 Jan 2026 09:49:44 +0000
Message-ID: <fe8a89b501e44737821fe8b0ab4492e9@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Linux PCI maintainers,

I'm reporting a critical use-after-free bug in the PCIe DPC recovery
mechanism that occurs when DPC recovery races with hotplug removal.
This results in a NULL pointer dereference in pci_bus_read_config_dword
and system panic.

## 1. Bug Summary

Title: Use-after-free race between DPC recovery and hotplug removal
Root Cause: DPC recovery accesses pci_dev after hotplug freed it
Severity: High (kernel panic, system crash)
Kernel Version: 5.10.0
Architecture: ARM64 (aarch64)

## 2. Timeline Analysis

### 2.1 DPC Event (T=3D1411s)
[ 1411.421320][ T2808] pcieport 0000:5f:00.0: DPC: containment event
[ 1411.463810][ T2808] pcieport 0000:5f:00.0: PCIe Bus Error: severity=3DUn=
corrected

DPC recovery starts on port 0000:5f:00.0 (thread T2808)

### 2.2 Hotplug Link Down (T=3D1415s)
[ 1415.621146][ T2807] pcieport 0000:5f:00.0: pciehp: Slot(3): Link Down

Hotplug detects link down on same slot (thread T2807).
RACE BEGINS: DPC and hotplug run concurrently.

### 2.3 Device Recovery Fails (T=3D1415s-1479s)
[ 1415.650432][ T8030] mlx5_core 0000:60:00.1: mlx5_error_sw_reset: start
[ 1479.604410][ T8030] mlx5_health_try_recover: health recovery flow aborte=
d

mlx5 driver recovery fails.

### 2.4 Hotplug Removal Starts (T=3D1479s)
[ 1479.962953][ T2808] pci 0000:60:00.1: AER: can't recover
[ 1479.962961][ T2807] pci 0000:60:00.1: Removing from iommu group 67

Hotplug begins removing device 0000:60:00.1.

### 2.5 DPC Recovery Continues (T=3D1481s)
[ 1481.412327][ T2808] pci 0000:60:00.0: not ready 1023ms after DPC

DPC recovery still active for sibling device 0000:60:00.0.

### 2.6 Hotplug Re-enumeration (T=3D1481s)
[ 1481.892474][ T2807] pciehp: Slot(3): Card present
[ 1481.899188][ T2807] pciehp: Slot(3): Link Up

Hotplug re-detects and re-enumerates device.

### 2.7 The Crash (T=3D1484s)
[ 1484.742859][ T2808] Unable to handle kernel NULL pointer dereference
[ 1485.009989][ T2808] pc : pci_bus_read_config_dword+0x1b0/0x350

## 3. Call Trace
[ 1484.742859][ T2808] Unable to handle kernel NULL pointer dereference
[ 1484.814910][ T2808] Internal error: Oops: 0000000096000004 [#1] SMP
[ 1485.009989][ T2808] pc : pci_bus_read_config_dword+0x1b0/0x350
[ 1485.015808][ T2808] lr : pci_read_config_dword+0x4c/0xa0
[ 1485.120656][ T2808]=A0 pci_bus_read_config_dword+0x1b0/0x350
[ 1485.126130][ T2808]=A0 pci_read_config_dword+0x4c/0xa0
[ 1485.131084][ T2808]=A0 pci_dev_wait+0xf0/0x230
[ 1485.135341][ T2808]=A0 pci_bridge_wait_for_secondary_bus+0x204/0x4f0
[ 1485.141509][ T2808]=A0 dpc_reset_link+0x12c/0x534
[ 1485.146027][ T2808]=A0 pcie_do_recovery+0x26c/0x6e0
[ 1485.150718][ T2808]=A0 dpc_handler+0x90/0x170
[ 1485.154890][ T2808]=A0 irq_thread_fn+0x50/0x180
[ 1485.159234][ T2808]=A0 irq_thread+0x144/0x210
[ 1485.163407][ T2808]=A0 kthread+0x190/0x210
[ 1485.167318][ T2808]=A0 ret_from_fork+0x10/0x18

## 4. Root Cause
I speculate that an use-after-free race condition cause this issue:

Thread T2808 (DPC):
dpc_handler() -> pcie_do_recovery() -> dpc_reset_link() ->
pci_bridge_wait_for_secondary_bus() -> pci_dev_wait() ->
pci_read_config_dword()

Thread T2807 (hotplug):
Detects link down -> removes device -> frees pci_dev ->
re-enumerates device -> creates new pci_dev

The DPC recovery assumes device stability, but hotplug can free and
recreate pci_dev concurrently.

## 5. System Information

Hardware: HiSilicon ARM64 server
CPU: ARM64, core 11 affected
NIC: Mellanox ConnectX-6 (0000:60:00.0/1)
Upstream Port: 0000:5f:00.0

Kernel: 5.10.0
Modules: mlx5_core,
Config: CONFIG_HOTPLUG_PCI_PCIE=3Dy, CONFIG_PCIE_DPC=3Dy

## 6. Questions

1. Existing synchronization between DPC and hotplug?
2. Should DPC use pci_dev_get()/pci_dev_put()?
3. Similar fixes in newer kernels?
4. Preferred approach?

Thank you.

Best regards


