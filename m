Return-Path: <linux-pci+bounces-22630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B3A495CE
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA32516AD2A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED52580CE;
	Fri, 28 Feb 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5BVHmjY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACB25744D;
	Fri, 28 Feb 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736138; cv=none; b=NtzeNr8H7qOXzegkJVALTHsTvs7SiH5WGrNkjlgBDQyponXUuO9Leqw+aA76+Cva5ZmQJdY91fxEb3cSYkXejANADlG/kw5BsZoxYd5+5Ys4S1Iet1X6fAkKKeTPSCZhdNr7dfohNxhdYNYaJyLln8Rx859e/eWfHJRYCdQxLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736138; c=relaxed/simple;
	bh=GpLEJTEeRlt9jJz1/IO39HWv8+hV4PlRV+AmeNj+5CE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZYqXnJ8YL/vfdW8ryhUluWelONdVUsq9WSVXuGTCGwdrrWcOGuY1REIE8HFnRvSPFra3XruV6eJd7Y7UBp80e3Hy+dXS/4dptri9nv/JfD8QwvrG6LL6QMJW8BcNjaEhsGEnydHMzPKr3HXJ9jRZj0Vmx/mB4oj7KE7f3cQ1SV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5BVHmjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2F9C4CED6;
	Fri, 28 Feb 2025 09:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740736137;
	bh=GpLEJTEeRlt9jJz1/IO39HWv8+hV4PlRV+AmeNj+5CE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=K5BVHmjY/pAKlqhTLI87VLB8Mzql+KtrYAoObw1ZwiQoDbBbfvPQWNWqnEr4qTVma
	 yjAXlTImqk9bx2gnP9vC6dL4BGJTpnuIZ1UjNxLvfCnhPXlbMJNVJr5eCpBLFbsZZ9
	 X5TJnE8d3mx5raSrKV8ysc4LFo2GHBXP02ANK+m9atzos8f+oaNcKEbbZ0hzMmbNO9
	 geEXR6zDC8pDQl12LrQB4lvdvmVXrHTC1Y+tEKhRs3XGOH95hSMjWywqeUhJj6JP0A
	 ALfP+65ubvbdV7BrYD4KsMTmnGXpSdFLTuYnZMFUlAzNqo1wPy1cPMLmoKiDYU49PL
	 fGABkXv4TB3Lg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <Z8EQsFiVAxtWfulx@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <yq5aeczrww9j.fsf@kernel.org> <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
 <yq5a4j0gc3fp.fsf@kernel.org> <Z8AHtcYgz2JukdfM@yilunxu-OptiPlex-7050>
 <yq5aa5a78p8d.fsf@kernel.org> <Z8EQsFiVAxtWfulx@yilunxu-OptiPlex-7050>
Date: Fri, 28 Feb 2025 15:18:51 +0530
Message-ID: <yq5a4j0e8kn0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Yilun <yilun.xu@linux.intel.com> writes:

> On Thu, Feb 27, 2025 at 07:27:22PM +0530, Aneesh Kumar K.V wrote:
>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>
>> > On Wed, Feb 26, 2025 at 05:40:02PM +0530, Aneesh Kumar K.V wrote:
>> >> Xu Yilun <yilun.xu@linux.intel.com> writes:
>> >>
>> >> > On Fri, Feb 21, 2025 at 01:43:28PM +0530, Aneesh Kumar K.V wrote:
>> >> >> Alexey Kardashevskiy <aik@amd.com> writes:
>> >> >>
>> >> >> ....
>> >> >>
>> >> >> >
>> >> >> > I am trying to wrap my head around your tsm. here is what I got in my tree:
>> >> >> > https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
>> >> >> >
>> >> >> > Shortly:
>> >> >> >
>> >> >> > drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to
>> >> >> > control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi,
>> >> >> > it does not know pci_dev;
>> >> >> >
>> >> >> > drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
>> >> >> >
>> >> >> > drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
>> >> >> > - tsm_subsys in tsm.ko (which does "connect" and "bind" and
>> >> >> > - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
>> >> >> > ccp.ko knows about pci_dev and whatever else comes in the future, and
>> >> >> > ccp.ko's "connect" implementation calls the IDE library (I am adopting
>> >> >> > yours now, with some tweaks).
>> >> >> >
>> >> >> > tsm-dev and tsm-tdi embed struct dev each and are added as children to
>> >> >> > PCI devices: no hide/show attrs, no additional TSM pointer in struct
>> >> >> > device or pci_dev, looks like:
>> >> >> >
>> >> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
>> >> >> > device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind
>> >> >> > tsm_tdi_status  tsm_tdi_status_user  uevent
>> >> >> >
>> >> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
>> >> >> > device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user
>> >> >> > tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
>> >> >> >
>> >> >> > aik@sc ~> ls /sys/class/tsm/tsm0/
>> >> >> > device  power  stream0:0000:e1:00.0  subsystem  uevent
>> >> >> >
>> >> >> > aik@sc ~> ls /sys/class/tsm-dev/
>> >> >> > tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
>> >> >> >
>> >> >> > aik@sc ~> ls /sys/class/tsm-tdi/
>> >> >> > tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0
>> >> >> > tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
>> >> >> >
>> >> >> >
>> >> >> > SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing
>> >> >> > but pci_dev is only needed for DOE/IDE.
>> >> >> >
>> >> >> > Or is separating struct pci_dev from struct device not worth it and most
>> >> >> > of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
>> >> >> >
>> >> >>
>> >> >> For the Arm CCA DA, I have structured the flow as follows. I am
>> >> >> currently refining my changes to prepare them for posting. I am using
>> >> >> tsm-core in both the host and guest. There is no bind interface at the
>> >> >> sysfs level; instead, it is managed via the KVM ioctl
>> >> >>
>> >> >> Host:
>> >> >> step 1.
>> >> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> >> >> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
>> >> >> echo ${DEVICE} > /sys/bus/pci/drivers_probe
>> >> >>
>> >> >> step 2.
>> >> >> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
>> >> >>
>> >> >> step 3.
>> >> >> using VMM to make the new KVM_SET_DEVICE_ATTR ioctl
>> >> >>
>> >> >> +		dev_num = vfio_devices[i].dev_hdr.dev_num;
>> >> >> +		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
>> >> >> +		guest_bdf = (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
>> >> >> +
>> >> >> +		struct kvm_vfio_tsm_bind param = {
>> >> >> +			.guest_rid = guest_bdf,
>> >> >> +			.devfd = vfio_devices[i].fd,
>> >> >> +		};
>> >> >> +		struct kvm_device_attr attr = {
>> >> >> +			.group = KVM_DEV_VFIO_DEVICE,
>> >> >> +			.attr = KVM_DEV_VFIO_DEVICE_TDI_BIND,
>> >> >> +			.addr = (__u64)&param,
>> >> >> +		};
>> >> >> +
>> >> >> +		if (ioctl(kvm_vfio_device, KVM_SET_DEVICE_ATTR, &attr)) {
>> >> >> +			pr_err("Failed KVM_SET_DEVICE_ATTR for KVM_DEV_VFIO_DEVICE");
>> >> >> +			return -ENODEV;
>> >> >> +		}
>> >> >> +
>> >> >
>> >> > I think bind (which brings device to a LOCKED state, no MMIO, no DMA)
>> >> > cannot be a driver agnostic behavior. So I think it should be a VFIO
>> >> > ioctl.
>> >> >
>> >>
>> >> For the current CCA implementation bind is equivalent to VDEV_CREATE
>> >> which doesn't mark the device LOCKED. Marking the device LOCKED is
>> >> driven by the guest as shown in the steps below.
>> >
>> > Could you elaborate why vdev create & LOCK can't be done at the same
>> > time, when guest requests "lock"? Intel TDX also requires firmware calls
>> > like tdi_create(alloc metadata) & tdi_bind(do LOCK), but I don't see
>> > there is need to break them out in different phases.
>> >
>>
>> Yes, that is possible and might be what I will end up doing. Right now
>> I have kept the interface flexible enough as I am writing these changes.
>
> Good to know that, thanks.
>
>> Device can possibly be presented in locked state to the guest.
>
> This is also what I did before. But finally I dropped (or pending) this
> "early binding" support. There are several reset operations during VM
> setup and booting, especially the ones in bios. They breaks LOCK state
> and I have to make VFIO suppress the reset, or reset & recover, but that
> seems not worth the effort.
>
> May wanna know how you see this problem.

Currently, my approach involves a split vdev_create and a TDISP lock, which is
why I haven't encountered the issue mentioned above. The current changes
implement vdev_create via the VMM, while the guest makes an RSI call to
switch the device to the locked state.

I chose to separate vdev_create and TDISP lock into two distinct steps
to simplify the process and better align it with the RMM spec [1].

I noticed that SEV-TIO performs a KVM_EXIT_VMGEXIT, which carries out a
similar operation unless it has already been handled during VM startup.
From your reply above, I understand there was a proposal to combine
VDEV_CREATE and TDISP_LOCK. However, you also mentioned that if we
present the device in a locked state to a VM early in the boot process,
we might unintentionally break the TDISP lock state.

I will look up the previous discussions to better understand the
rationale behind combining vdev_create and lock.

[1] https://developer.arm.com/-/cdn-downloads/permalink/Architectures/Armv9/DEN0137_1.1-alp12.zip

-aneesh

