Return-Path: <linux-pci+bounces-22425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1CCA45E93
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F24219C356A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F79E21E0BC;
	Wed, 26 Feb 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxRr9NL0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3771A21D3F0;
	Wed, 26 Feb 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571809; cv=none; b=r6P6EV3AFpRif6klmTaErODz3MaL9Azqa1VivaltG8bNWgYIB5bdkUj8SqBw7kV9jBk7tPzU6IP1d67LnEQXyYAi3i6c4WZrMFAhNqLvHJD5/R5XrLP8k6JMcc7zQ8kLpSlxsj9HLeHgiqtYH1NYdXO7a7sUO9GoWP/rlpQqLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571809; c=relaxed/simple;
	bh=U6hF+A/kdy1VR2aMr3cuOaLbVWSIJ/JXB33mTnAsWuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IoOh0JsjUq0PQhmgR1bnTD5Su8kELvX6DlO2pMu6B3UpbE5+fSetpFrOR8ouSM7RcUjpftlNY7q6e4NZ74WYvVf/lC/5Ld49DYA7nSgcNgKn6a99qW0vCpDUQZKiD6mEQriBrJoLNaoMLf6qzFOK6if8sNObQcz6GaPeqql5LRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxRr9NL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D43C4CED6;
	Wed, 26 Feb 2025 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740571808;
	bh=U6hF+A/kdy1VR2aMr3cuOaLbVWSIJ/JXB33mTnAsWuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LxRr9NL0DT8MOqx4Y0m9M8/Z2VsqU2j2/ozVNNZCKvR825NOGydbbVwwl66oi/Cpg
	 7MqG7YWTqh70OK8g85SfJ/ju1gX89g0MzlLU7gWe9yXuZBuUcyp8r2YM3wvOZRr3vb
	 ln8Znr4ViD1ClRDTMC4cTmirbkQ23Lf28epV0BFx1PFpksG+wtO0xFXM3p65NZlikI
	 qzLFdU507rIhfB6Et3IxwhyyhwT7Y+fFCWT+CfBiSgD83RZv5JomSP+O+IKrdcSRp2
	 FGB55MkO7ZcgBbncJQqOaE1KOrW24qihgkIAWXwpuFv8UtBqbkLdHgiB4bQ/2TUwn6
	 46v2tL/V+Wrtw==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <yq5aeczrww9j.fsf@kernel.org> <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
Date: Wed, 26 Feb 2025 17:40:02 +0530
Message-ID: <yq5a4j0gc3fp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Yilun <yilun.xu@linux.intel.com> writes:

> On Fri, Feb 21, 2025 at 01:43:28PM +0530, Aneesh Kumar K.V wrote:
>> Alexey Kardashevskiy <aik@amd.com> writes:
>> 
>> ....
>> 
>> >
>> > I am trying to wrap my head around your tsm. here is what I got in my tree:
>> > https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
>> >
>> > Shortly:
>> >
>> > drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to 
>> > control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi, 
>> > it does not know pci_dev;
>> >
>> > drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
>> >
>> > drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
>> > - tsm_subsys in tsm.ko (which does "connect" and "bind" and
>> > - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
>> > ccp.ko knows about pci_dev and whatever else comes in the future, and 
>> > ccp.ko's "connect" implementation calls the IDE library (I am adopting 
>> > yours now, with some tweaks).
>> >
>> > tsm-dev and tsm-tdi embed struct dev each and are added as children to 
>> > PCI devices: no hide/show attrs, no additional TSM pointer in struct 
>> > device or pci_dev, looks like:
>> >
>> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
>> > device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind 
>> > tsm_tdi_status  tsm_tdi_status_user  uevent
>> >
>> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
>> > device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user 
>> > tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
>> >
>> > aik@sc ~> ls /sys/class/tsm/tsm0/
>> > device  power  stream0:0000:e1:00.0  subsystem  uevent
>> >
>> > aik@sc ~> ls /sys/class/tsm-dev/
>> > tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
>> >
>> > aik@sc ~> ls /sys/class/tsm-tdi/
>> > tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0 
>> > tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
>> >
>> >
>> > SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing 
>> > but pci_dev is only needed for DOE/IDE.
>> >
>> > Or is separating struct pci_dev from struct device not worth it and most 
>> > of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
>> >
>> 
>> For the Arm CCA DA, I have structured the flow as follows. I am
>> currently refining my changes to prepare them for posting. I am using
>> tsm-core in both the host and guest. There is no bind interface at the
>> sysfs level; instead, it is managed via the KVM ioctl
>> 
>> Host:
>> step 1.
>> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
>> echo ${DEVICE} > /sys/bus/pci/drivers_probe
>> 
>> step 2.
>> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
>> 
>> step 3.
>> using VMM to make the new KVM_SET_DEVICE_ATTR ioctl
>> 
>> +		dev_num = vfio_devices[i].dev_hdr.dev_num;
>> +		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
>> +		guest_bdf = (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
>> +
>> +		struct kvm_vfio_tsm_bind param = {
>> +			.guest_rid = guest_bdf,
>> +			.devfd = vfio_devices[i].fd,
>> +		};
>> +		struct kvm_device_attr attr = {
>> +			.group = KVM_DEV_VFIO_DEVICE,
>> +			.attr = KVM_DEV_VFIO_DEVICE_TDI_BIND,
>> +			.addr = (__u64)&param,
>> +		};
>> +
>> +		if (ioctl(kvm_vfio_device, KVM_SET_DEVICE_ATTR, &attr)) {
>> +			pr_err("Failed KVM_SET_DEVICE_ATTR for KVM_DEV_VFIO_DEVICE");
>> +			return -ENODEV;
>> +		}
>> +
>
> I think bind (which brings device to a LOCKED state, no MMIO, no DMA)
> cannot be a driver agnostic behavior. So I think it should be a VFIO
> ioctl.
>

For the current CCA implementation bind is equivalent to VDEV_CREATE
which doesn't mark the device LOCKED. Marking the device LOCKED is
driven by the guest as shown in the steps below.


>> 
>> Now in the guest we follow the below steps
>> 
>> step 1:
>> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> 
>> step 2: Move the device to TDISP LOCK state
>> echo 1 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
>> echo 3 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
>
> Reuse the 'connect' interface? I think it conceptually brings chaos. Is
> it better we create a new interface?
>

I was looking at converting these numbers to strings.
"1" -> connect
"2" -> lock
"3" -> run


>
>> 
>> step 3: Moves the device to TDISP RUN state
>> echo 4 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
>
> Could you elaborate what '1'/'3'/'4' stand for?
>

As mentioned above, them move the device to different TDISP state.

I will reply to this patch with my early RFC chnages for tsm framework.
I am not yet ready to share the CCA backend changes. But I assume having
the tsm framework changes alone can be useful?

-aneesh

