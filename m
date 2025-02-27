Return-Path: <linux-pci+bounces-22567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3975DA48037
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 15:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4543ADEF6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF61E5210;
	Thu, 27 Feb 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id8+Gld8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27729270047;
	Thu, 27 Feb 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664650; cv=none; b=tprnNVC3R3gu0EJX9Fqwd6eECi7i+JC/7RMIRxeTvaKeVaS4RgayHi90POuPA5uiUQ5ScYGtJSGBQo/UKpMNflWEswt7mizW4MATWlmAaQXERyyETypTGdWnGapFbVpgyvfPIvj9EZTGcIP1MsS4L6cSS8fezw8Kcx8haJWXXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664650; c=relaxed/simple;
	bh=nVOQTG+1AjyPHbVpv+mJt48NO8vRQ6pRUwN9R5/RxAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NmW3bB5ZS9F7Xdk/NeMAWGjlYzKNOeahsgj6EiZPMYZg9A09zj4gF3CVllPcEtW04Z6ux1Djwmm6yTEFhySezwS6Pq3flxQ3r7voybUuEXrpXCLQbov0q24OCcU4UcKZD/5j0xMU8kYBXXKCto36b9YHTlVi++nd4aVmbAWUPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id8+Gld8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83EFC4CEDD;
	Thu, 27 Feb 2025 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740664649;
	bh=nVOQTG+1AjyPHbVpv+mJt48NO8vRQ6pRUwN9R5/RxAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Id8+Gld8p0AgGJ304FQvSuKf1AHG4L03TVgI03uIaMSKXlEVlZIfl22eTibsPVIhn
	 z5PkmUiKs4Nt3mHhrb9fEOn2UOXQ6LH+rzy/FPNBdDgDuEpl49AI32MqWKZQ/fxT2D
	 JUQFQJj4yajzP3hM+HfrLZSubMBxYGuzCeH1+nxaeaAvycwFJ04WporrZIf0Sl8SdC
	 8+155v+VfqiztVoQicl2NpPcxuWT6uT0LH/Rzvo0y0sQzPnVsByf+7XMTYciZf0a2n
	 mM7Roz+NIamyrNVhJQF/4+2SonZdBsAvrh0eP8fOU2YYmHe7c8h525RTNSDY/pgCwC
	 vy4RAJ8swAH+g==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <Z8AHtcYgz2JukdfM@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <yq5aeczrww9j.fsf@kernel.org> <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
 <yq5a4j0gc3fp.fsf@kernel.org> <Z8AHtcYgz2JukdfM@yilunxu-OptiPlex-7050>
Date: Thu, 27 Feb 2025 19:27:22 +0530
Message-ID: <yq5aa5a78p8d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Yilun <yilun.xu@linux.intel.com> writes:

> On Wed, Feb 26, 2025 at 05:40:02PM +0530, Aneesh Kumar K.V wrote:
>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>> 
>> > On Fri, Feb 21, 2025 at 01:43:28PM +0530, Aneesh Kumar K.V wrote:
>> >> Alexey Kardashevskiy <aik@amd.com> writes:
>> >> 
>> >> ....
>> >> 
>> >> >
>> >> > I am trying to wrap my head around your tsm. here is what I got in my tree:
>> >> > https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
>> >> >
>> >> > Shortly:
>> >> >
>> >> > drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to 
>> >> > control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi, 
>> >> > it does not know pci_dev;
>> >> >
>> >> > drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
>> >> >
>> >> > drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
>> >> > - tsm_subsys in tsm.ko (which does "connect" and "bind" and
>> >> > - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
>> >> > ccp.ko knows about pci_dev and whatever else comes in the future, and 
>> >> > ccp.ko's "connect" implementation calls the IDE library (I am adopting 
>> >> > yours now, with some tweaks).
>> >> >
>> >> > tsm-dev and tsm-tdi embed struct dev each and are added as children to 
>> >> > PCI devices: no hide/show attrs, no additional TSM pointer in struct 
>> >> > device or pci_dev, looks like:
>> >> >
>> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
>> >> > device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind 
>> >> > tsm_tdi_status  tsm_tdi_status_user  uevent
>> >> >
>> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
>> >> > device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user 
>> >> > tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
>> >> >
>> >> > aik@sc ~> ls /sys/class/tsm/tsm0/
>> >> > device  power  stream0:0000:e1:00.0  subsystem  uevent
>> >> >
>> >> > aik@sc ~> ls /sys/class/tsm-dev/
>> >> > tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
>> >> >
>> >> > aik@sc ~> ls /sys/class/tsm-tdi/
>> >> > tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0 
>> >> > tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
>> >> >
>> >> >
>> >> > SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing 
>> >> > but pci_dev is only needed for DOE/IDE.
>> >> >
>> >> > Or is separating struct pci_dev from struct device not worth it and most 
>> >> > of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
>> >> >
>> >> 
>> >> For the Arm CCA DA, I have structured the flow as follows. I am
>> >> currently refining my changes to prepare them for posting. I am using
>> >> tsm-core in both the host and guest. There is no bind interface at the
>> >> sysfs level; instead, it is managed via the KVM ioctl
>> >> 
>> >> Host:
>> >> step 1.
>> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> >> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
>> >> echo ${DEVICE} > /sys/bus/pci/drivers_probe
>> >> 
>> >> step 2.
>> >> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
>> >> 
>> >> step 3.
>> >> using VMM to make the new KVM_SET_DEVICE_ATTR ioctl
>> >> 
>> >> +		dev_num = vfio_devices[i].dev_hdr.dev_num;
>> >> +		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
>> >> +		guest_bdf = (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
>> >> +
>> >> +		struct kvm_vfio_tsm_bind param = {
>> >> +			.guest_rid = guest_bdf,
>> >> +			.devfd = vfio_devices[i].fd,
>> >> +		};
>> >> +		struct kvm_device_attr attr = {
>> >> +			.group = KVM_DEV_VFIO_DEVICE,
>> >> +			.attr = KVM_DEV_VFIO_DEVICE_TDI_BIND,
>> >> +			.addr = (__u64)&param,
>> >> +		};
>> >> +
>> >> +		if (ioctl(kvm_vfio_device, KVM_SET_DEVICE_ATTR, &attr)) {
>> >> +			pr_err("Failed KVM_SET_DEVICE_ATTR for KVM_DEV_VFIO_DEVICE");
>> >> +			return -ENODEV;
>> >> +		}
>> >> +
>> >
>> > I think bind (which brings device to a LOCKED state, no MMIO, no DMA)
>> > cannot be a driver agnostic behavior. So I think it should be a VFIO
>> > ioctl.
>> >
>> 
>> For the current CCA implementation bind is equivalent to VDEV_CREATE
>> which doesn't mark the device LOCKED. Marking the device LOCKED is
>> driven by the guest as shown in the steps below.
>
> Could you elaborate why vdev create & LOCK can't be done at the same
> time, when guest requests "lock"? Intel TDX also requires firmware calls
> like tdi_create(alloc metadata) & tdi_bind(do LOCK), but I don't see
> there is need to break them out in different phases.
>

Yes, that is possible and might be what I will end up doing. Right now
I have kept the interface flexible enough as I am writing these changes.
Device can possibly be presented in locked state to the guest.

>
>> 
>> 
>> >> 
>> >> Now in the guest we follow the below steps
>> >> 
>> >> step 1:
>> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> >> 
>> >> step 2: Move the device to TDISP LOCK state
>> >> echo 1 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
>> >> echo 3 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
>> >
>> > Reuse the 'connect' interface? I think it conceptually brings chaos. Is
>> > it better we create a new interface?
>> >
>> 
>> I was looking at converting these numbers to strings.
>> "1" -> connect
>
> What does "connect" do in guest?
>

Nothing much for now. I added that to keep it consistent with host
workflow. That is device transition from PCI_TSM_INIT -> PCI_TSM_CONNECT
-> PCI_TSM_BOUND -> PCI_TSM_LOCK -> PCI_TSM_RUN.

Relevant part of the TSM backend in guest

static int cca_tsm_connect(struct pci_dev *pdev, int new_state)
{
	unsigned long ret;
	int connect_state;
	struct pci_tsm *pci_tsm = pdev->tsm;

	connect_state = pci_tsm->state;
	switch (new_state) {
	case PCI_TSM_CONNECT:
		pci_tsm->state = PCI_TSM_CONNECT;
		break;
	case PCI_TSM_LOCKED:
		if (connect_state != PCI_TSM_CONNECT)
			return -EINVAL;

		ret = rsi_device_lock(pdev);
		if (ret) {
			pci_err(pdev, "failed to lock the device (%lu)\n", ret);
			return -EIO;
		}
		pci_tsm->state = PCI_TSM_LOCKED;
		break;


-aneesh

