Return-Path: <linux-pci+bounces-44209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C222FCFF3ED
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 18:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9850304C654
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE73E3A0B34;
	Wed,  7 Jan 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A0+1t1Yp"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF1318EEE
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808603; cv=none; b=LWvfSxcFMVCYd16QQGNe+6PEZ4h2nenoPig7ZgRrYo28VVNuRnPN8rTIdOWFBpqQKcJJgHp0i0vht6bMTKarwlsm6JlR5FXvlKqdkkPBX23EJLj6PSOH7nPrLukYzTOUYJccO9fxQ8Zl5P1QQjiojBBnJTLZttUcXlL1mpJT0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808603; c=relaxed/simple;
	bh=grQKkkjeIqJzVfZeFoHxt4ek2uikRtwTsKBFQjSx96s=;
	h=To:From:Subject:Message-Id:Cc:Mime-Version:Date:Content-Type; b=PF2GnnLuMJ7uEsUL5SzmOjdee6InGlTd4MsRpueXlicwKu7Br076Dw0O7bRn5cB4/HpRxKJo+5cg7/0fvVRl42dwre17myOi4hmaIKvfuTlc5a4v7qfha1BsCK+sTi0jr7eNdHxVrcrJcas9c+3HLHRToIrGS6abR3sDrcCg55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A0+1t1Yp; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767808594; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xxnG3ewvxg8QmVht7L1kl3s0mWive5Z7wHYfXzACf3U=;
 b=A0+1t1YpD71P2/GZsey6CX0JdGGkwZV/1Wok6aFz8G741OOdwgMcyoqtA5uVvGX98JYLjw
 QIZX8Mgn/Xfpsmsj6dLCGAeX3F2EIfawEW9hqXmyJvk9u8q1q3pArfHf6vmLqHJzXp2Aei
 MuJaTrpNB6zb96s+xw4bRlMk4+iIEeN1+M80c7N7rlYv/6nUfe5j5sCjIkWTrD0K8vLsic
 MoOVdwOtI9Kx8NDU48shDJCcNBA5TR6u2cvPwuX4cObDTDtR5vtNZz5ZCF3+Gy8Nun9PoJ
 MNeaZ2BZ3iHEfwK95ZYuA3vgIcLdmzGl75XAOUX/kvRCeiM+ZMJcK94xUz6k1A==
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: <dakr@kernel.org>, <alexander.h.duyck@linux.intel.com>, 
	<alexanderduyck@fb.com>, <bhelgaas@google.com>, <bvanassche@acm.org>, 
	<dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>, 
	<helgaas@kernel.org>, <rafael@kernel.org>, <tj@kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [PATCH 0/3] Add NUMA-node-aware synchronous probing to driver core
Message-Id: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2695e9e50+85a4d9+vger.kernel.org+guojinhui.liam@bytedance.com>
Cc: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.17.1
Date: Thu,  8 Jan 2026 01:55:45 +0800
Content-Type: text/plain; charset=UTF-8

Hi all,

** Overview **

This patchset introduces NUMA-node-aware synchronous probing.

Drivers can initialize and allocate memory on the device=E2=80=99s local
node without scattering kmalloc_node() calls throughout the code.
NUMA-aware probing was added to PCI drivers in 2005 and has
benefited them ever since.

The asynchronous probe path already supports NUMA-node-aware
probing via async_schedule_dev() in the driver core. Since NUMA
affinity is orthogonal to sync/async probing, this patchset adds
NUMA-node-aware support to the synchronous probe path.

** Background **

The idea arose from a discussion with Bjorn and Danilo about a
PCI-probe issue [1]:

when PCI devices on the same NUMA node are probed asynchronously,
pci_call_probe() calls work_on_cpu(), pins every probe worker to
the same CPU inside that node, and forces the probes to run serially.

Testing three NVMe devices on the same NUMA node of an AMD EPYC 9A64
2.4 GHz processor (all on CPU 0):

  nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, probe cost: 53372612 ns
  nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:2, probe cost: 49532941 ns
  nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:3, probe cost: 47315175 ns

Since the driver core already provides NUMA-node-aware asynchronous
probing, we can extend the same capability to the synchronous probe
path. This solves the issue and lets other drivers benefit from
NUMA-local initialization as well.

[1] https://lore.kernel.org/all/20251227113326.964-1-guojinhui.liam@bytedan=
ce.com/

** Changes **

The series makes three main changes:

1. Adds helper __device_attach_driver_scan() to eliminate duplication
   between __device_attach() and __device_attach_async_helper().
2. Introduces a NUMA-node-aware execution mechanism and uses it to
   enable NUMA-local synchronous probing in __device_attach(),
   device_driver_attach(), and __driver_attach().
3. Removes the now-redundant NUMA code from the PCI driver.

** Test **

I added debug prints to nvme, mlx5, usbhid, and intel_rapl_msr and
ran tests on an AMD EPYC 9A64 system:

1. Without the patchset
   - PCI drivers (nvme, mlx5) probe sequentially on CPU 0
   - USB and platform drivers pick random CPUs in the udev worker

   nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, cost: 54013202 ns
   nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:2, cost: 53968911 ns
   nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:4, cost: 48077276 ns
  =20
   mlx5_core 0000:41:00.0: CPU: 0, COMM: kworker/0:2 cost: 506256717 ns
   mlx5_core 0000:41:00.1: CPU: 0, COMM: kworker/0:2 cost: 514289394 ns
  =20
   usb 1-2.4: CPU: 163, COMM: (udev-worker), cost 854131 ns
   usb 1-2.6: CPU: 163, COMM: (udev-worker), cost 967993 ns
  =20
   intel_rapl_msr intel_rapl_msr.0: CPU: 61, COMM: (udev-worker), cost: 371=
7567 ns

2. With the patchset
   - PCI probes are spread across CPUs inside the device=E2=80=99s NUMA nod=
e
   - Asynchronous nvme probes are ~35 % faster; synchronous mlx5 times
     are unchanged
   - USB probe times are virtually identical
   - Platform driver (no NUMA node) falls back to the original path

   nvme 0000:01:00.0: CPU: 130, COMM: kworker/u1025:0, cost: 35074561 ns
   nvme 0000:02:00.0: CPU:   1, COMM: kworker/u1025:6, cost: 34612117 ns
   nvme 0000:03:00.0: CPU:   2, COMM: kworker/u1025:5, cost: 34802918 ns

   mlx5_core 0000:41:00.0: CPU: 128, COMM: kworker/u1025:0, cost: 506214576=
 ns
   mlx5_core 0000:41:00.1: CPU: 128, COMM: kworker/u1025:0, cost: 514273565=
 ns

   usb 1-2.4: CPU: 51, COMM: kworker/u1031:2, cost: 933581 ns
   usb 1-2.6: CPU: 51, COMM: kworker/u1031:2, cost: 957237 ns

   intel_rapl_msr intel_rapl_msr.0: CPU: 225, COMM: (udev-worker), cost: 47=
15967 ns

3. With the patchset, unbind/bind cycles also spread PCI probes across
   CPUs within the device=E2=80=99s NUMA node:

   nvme 0000:02:00.0: CPU: 1, COMM: kworker/u1025:4, cost: 37070897 ns

** Final **

Comments and suggestions are welcome.

Best Regards,
Jinhui

---
Jinhui Guo (3):
  driver core: Introduce helper function __device_attach_driver_scan()
  driver core: Add NUMA-node awareness to the synchronous probe path
  PCI: Clean up NUMA-node awareness in pci_bus_type probe

 drivers/base/dd.c        | 173 +++++++++++++++++++++++++++++++--------
 drivers/pci/pci-driver.c |  83 ++-----------------
 include/linux/pci.h      |   1 -
 3 files changed, 148 insertions(+), 109 deletions(-)

--=20
2.20.1

