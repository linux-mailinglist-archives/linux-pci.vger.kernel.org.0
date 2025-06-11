Return-Path: <linux-pci+bounces-29453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40412AD5846
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF25E7A77CE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34E429B211;
	Wed, 11 Jun 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="bvYge6UQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113B28C2A2
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651293; cv=none; b=omw+hrx0vAQvjS61ntwSpNeSdh7lLYjpqCiNInOr+dYNIzkt9QQKt/87p2FAKb/6cOiZ6Y5u7eGP6ZV9dDSeTTN0f9qI1uLQOYBIYJE8pcthUvlMnGpwdYEtcLb55j6+m2eFI0Za05hYTt87qvEfo0Xnbh2a26HLgFfKtNwCfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651293; c=relaxed/simple;
	bh=qklXMM4Zm/m53GZlgeQXTzRagvzgFF7qFVgg4k+VQEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjABrcz1Ph0Dok575DL+53MdF6tVNK4WsaiXh2eMZq+3oZLDcWK1g7g/2WGjQWfl/JaZ5BFI3uI+1cyiDhpdVt0sfgJ7GxD+R+oyCDAUajv7nB0W97qHa5TMy95T4PbQRUUIWRxzSstMtE52iV/g1Gy+CK3GFf2mGWofaSE/n9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=bvYge6UQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4ebbfb18fso63938f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1749651290; x=1750256090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NtPSxN3f/hSKLGrEdTW5DuLPmWgVBhZIqrCaEy4i/uw=;
        b=bvYge6UQH8zncXx5mLl7xC1vp0dA9bfNFVbbRqYoMrjXbq1jn9ZnppN/UVBM8ZQ13V
         gEDonmkvHFIg4FBI/Rkbj+/+5jOUpKXbLMWP6RlMvvZkfSAz+kF6uvty3HmD4fTKTLgB
         iMeL8nvaCQTnB7yz76qZvNmN6Ytgq6ZBU7d3gI09E2kXNqUiwVEzoj6RfbazMDWlw9Xx
         DGIvM1wWTLQRx2WQB0UHM6S7e5IN8xgXG01JNyUzu7TNqJcHHbCxIwgG7cZdA35x0mmq
         Y9o64/j3wxVm+/VQyOpDwUZxcYz+9B61rxE5PeDHPKcywqLxjPQDgccj2HbHGioUDyCJ
         Wjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651290; x=1750256090;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtPSxN3f/hSKLGrEdTW5DuLPmWgVBhZIqrCaEy4i/uw=;
        b=TMBiRxYjCJaZG/+Qv1CEN/AIBMW8BLJai/x8/lBinpFe3Tg71O6r6muQiSDSuReE7R
         vSVFqJwEEFzSaibxd23uCkd6S+pQ7p4hvBVbxd0UbciJAdS2ho64/NrT3XGdKw91eoX7
         ZpISIDiHse5WQa8IJZIZ7CtlMDyWhtoeOc7OTxIArhfj14FgGlH7CR8GJFPZPMXCEbeJ
         FC8nqqda/1vgOL8j/9Dm4Uv2HJ85y+ekf0O6Pdj786g6e7KLyp0GAtqAgeyL7FljvZnv
         9NRBBGK7wlpkL7RV0lgD2uXFFbqbQDf3BKZ7A124wbs1QqNkq47vCYBUszqZeJ/MZtML
         9O3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWINXDqyCGbJYqoTRevPUSeCUooEpr6idOghc8fdnwvUjyrcZBGR/d2GNhHi0/4dSyxzVQI2mJ/hVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgg57WT5hfBe+mgcX2s4FWgt4BkoiSTLrpMMp56eApeYl02HyA
	Pf2trFCgUoCpO9R3y8z5NVAwFII6SNEOt5kYzTuMbTRoTjKUxK6qYcx5Upfz+HpSngQ=
X-Gm-Gg: ASbGncsAxargOQlh6uOARNYkVm6NM4N2ZBjhXOniFxMPqzDGASzZewJEBMQaH+Se0Zj
	fwfMOWU2x7r3WTvuPxEfCUW64A/EVCCv6pMWcrZcYiZa89N0xgHZf4x6uBxC2RhQGENgoskjz7z
	gCL9TnmmIxHojuAvUQDZ1f/KdnyJ4Zxl4TpD3H/QtH5w3AqV1hrmG4nHs+M2rQ595AqshsHlK4X
	sxUESRpoza7Af7eBGkspvCBKvluZE8/K+/QWS5+WupFoI6ie42rl2yEsw4PHK7L9h4KlflpDUOZ
	EYlhOrVaLJ8tFuEJQzRmjf6pyKjlXzwl84SriSdEjKTdWUc5wvSBVUVjLzcSEd1Nkse5/9CFft6
	+/C8sPQK2wN4xfoiCpIUmU/njLZ3t6xO60P0jBx8qNI9+Y9xErw==
X-Google-Smtp-Source: AGHT+IF5QjGtnTK3+avwKtK8lcdvBbTrsoW9iXv34rilJUfVk5XsaRgbij1H/xCqNfyhBwowL/oWNw==
X-Received: by 2002:a05:6000:2082:b0:3a4:da29:d13f with SMTP id ffacd0b85a97d-3a5586b89d0mr1076827f8f.3.1749651290044;
        Wed, 11 Jun 2025 07:14:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:7f7c:5244:66f5:568b? ([2a01:e0a:b41:c160:7f7c:5244:66f5:568b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de53sm15349693f8f.8.2025.06.11.07.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 07:14:49 -0700 (PDT)
Message-ID: <3d09359f-6e38-4e48-9d4e-6bc203c49e61@6wind.com>
Date: Wed, 11 Jun 2025 16:14:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
To: Bjorn Helgaas <helgaas@kernel.org>, Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 rafael.j.wysocki@intel.com, huang.ying.caritas@gmail.com,
 stern@rowland.harvard.edu, linux-pci@vger.kernel.org,
 Olivier MATZ <olivier.matz@6wind.com>, "dev@dpdk.org" <dev@dpdk.org>
References: <20250505230632.GA1007257@bhelgaas>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250505230632.GA1007257@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 06/05/2025 à 01:06, Bjorn Helgaas a écrit :
> On Wed, Apr 23, 2025 at 11:31:32PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> AMD BIOS team has root caused an issue that NVME storage failed to come
>> back from suspend to a lack of a call to _REG when NVME device was probed.
>>
>> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
>> added support for calling _REG when transitioning D-states, but this only
>> works if the device actually "transitions" D-states.
>>
>> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
>> devices") added support for runtime PM on PCI devices, but never actually
>> 'explicitly' sets the device to D0.
>>
>> To make sure that devices are in D0 and that platform methods such as
>> _REG are called, explicitly set all devices into D0 during initialization.
>>
>> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Applied to pci/pm for v6.16, thanks!
> 

I've a regression after this commit.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d4c10f763d7

I've started a QEMU with "-cpu host" on an AMD (AMD Ryzen 5 3600 6-Core
Processor) machine + virtio-net interfaces. When I try to start a testpmd (a
DPDK app), it cannot find the virtio port. The ioctl VFIO_GROUP_GET_DEVICE_FD fails.

To reproduce the issue:
qemu-system-x86_64 --enable-kvm -m 5G -cpu host \
	-smp sockets=1,cores=2,threads=2 \
	-snapshot -vga none -display none -nographic \
	-drive if=none,file=/opt/vm/ubuntu-24.04-with-linux-net.qcow2,id=hda \
	-device virtio-blk,drive=hda \
	-device virtio-net,netdev=eth0,addr=03 -netdev user,id=eth0 \
	-device virtio-net,netdev=eth1,addr=04 -netdev socket,id=eth1,mcast=230.0.0.1:1234

git clone git://dpdk.org/dpdk
cd dpdk/
meson build-static --werror --default-library=static --debug
ninja -C build-static
echo 3 > /proc/sys/vm/drop_caches
echo 256 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
modprobe vfio-pci
lspci
python3 ./usertools/dpdk-devbind.py --noiommu-mode -b vfio-pci 0000:00:04.0
./build-static/app/dpdk-testpmd -l 1,2 --socket-mem 512,0 -a 0000:00:04.0 -- -i

Here is the output:
EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: VFIO support initialized
EAL: Using IOMMU type 8 (No-IOMMU)
EAL: Getting a vfio_dev_fd for 0000:00:04.0 failed
PCI_BUS: Cannot get offset of region 0.
PCI_BUS: fail to disable req notifier.
PCI_BUS: fail to disable req notifier.
VIRTIO_INIT: eth_virtio_pci_init(): Failed to init PCI device
PCI_BUS: Requested device 0000:00:04.0 cannot be used
EAL: Bus (pci) probe failed.
testpmd: No probed ethernet devices
Interactive-mode selected
testpmd: create a new mbuf pool <mb_pool_0>: n=155456, size=2176, socket=0
testpmd: preferred mempool ops selected: ring_mp_mc
Done
testpmd>

=> the problem starts at the line "Getting a vfio_dev_fd for 0000:00:04.0 failed"
https://git.dpdk.org/dpdk/tree/lib/eal/linux/eal_vfio.c#n966

FWIW, here is the output when it starts correctly:
EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: VFIO support initialized
EAL: Using IOMMU type 8 (No-IOMMU)
Interactive-mode selected
Warning: NUMA should be configured manually by using --port-numa-config and
--ring-numa-config parameters along with --numa.
testpmd: create a new mbuf pool <mb_pool_0>: n=155456, size=2176, socket=0
testpmd: preferred mempool ops selected: ring_mp_mc

Warning! port-topology=paired and odd forward ports number, the last port will
pair with itself.

Configuring Port 0 (socket 0)
EAL: Error disabling MSI-X interrupts for fd 277
Port 0: DE:ED:01:E0:1B:75
Checking link statuses...
Done
testpmd>

Any help would be appreciated.

Regards,
Nicolas

