Return-Path: <linux-pci+bounces-22607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38564A48DF0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 02:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386B1164691
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7844022301;
	Fri, 28 Feb 2025 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMUzBTtl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8717C33F9
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706088; cv=none; b=lR0/nHDFIQsKiIqJIwXEUFsHKwcqZUiugqwmwjRNrzHr7068wHskXyIgfQferl0FICRZf/M3Q1jS1o6QiqNF7qtLZJ2fKYQvHPK5MpEB/zcod6exp4oD4b8N3AJ9nrNtoqDmxdShmNg+5fsHMbYzqmnsbm7fybHw7VFpN3OaYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706088; c=relaxed/simple;
	bh=vCl+dtgAfJBQl5JIKaTvHYjl3fvAOLPHmi5FXyCX0eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH1i+XOT+mfG/jsDu0QZsyBXNOMfm/w12V75mqHZ67qifoYIDUHJRUSe1H1ZkcW3+CZgrnWDOoQod/gT818jGn+dwa8E6gBIN0eRP6TPQ+IOCYrPcf2K3a0Tomhwo55gtDAR+SWHi0VB6cOT6IfB8YbhZoY+mdmYWwkO2FL4iSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMUzBTtl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740706086; x=1772242086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vCl+dtgAfJBQl5JIKaTvHYjl3fvAOLPHmi5FXyCX0eo=;
  b=EMUzBTtlakx//kbpgEUNSrOq89c1DCBB9RG+NIBl8zx3V8AD9rabuc5r
   tUmcGIYqXMLo8VxIdemwQrQ7dZ7wqDuAeXTiAgw49/yVIa/mF9mYK2ku/
   3XvjhKPzvNwdNOnVrRm50sT28R0JaEHPqpAVTqMG033mL90iD0TSLjpZ0
   A+/1/RlabEzlPmU83u5XjMnFZOnIaGELUNC8FEweV6J8c+YbFqLzdUpP0
   p8XpmgQ7gUXKDP3WzCPe/okLUIaJpXhkO2gNwQzg42N48NVByw1gFZpWQ
   +lipHjLWJdlYDn6PM3TMmHn86UrZewuKtjhqhGKQc3QqsehpOOWCCjxrk
   g==;
X-CSE-ConnectionGUID: 3YafSc3ZSIer/QEv44RiFQ==
X-CSE-MsgGUID: 2hEzPT4zSAacr1In1F03vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41750554"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41750554"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 17:28:05 -0800
X-CSE-ConnectionGUID: 46Q48IfhR/CC87Pbg+6t3A==
X-CSE-MsgGUID: Zpv11XQ7TCmMuCiP6DRpmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="116963004"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 27 Feb 2025 17:28:03 -0800
Date: Fri, 28 Feb 2025 09:26:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <Z8EQsFiVAxtWfulx@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <yq5aeczrww9j.fsf@kernel.org>
 <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
 <yq5a4j0gc3fp.fsf@kernel.org>
 <Z8AHtcYgz2JukdfM@yilunxu-OptiPlex-7050>
 <yq5aa5a78p8d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aa5a78p8d.fsf@kernel.org>

On Thu, Feb 27, 2025 at 07:27:22PM +0530, Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
> > On Wed, Feb 26, 2025 at 05:40:02PM +0530, Aneesh Kumar K.V wrote:
> >> Xu Yilun <yilun.xu@linux.intel.com> writes:
> >> 
> >> > On Fri, Feb 21, 2025 at 01:43:28PM +0530, Aneesh Kumar K.V wrote:
> >> >> Alexey Kardashevskiy <aik@amd.com> writes:
> >> >> 
> >> >> ....
> >> >> 
> >> >> >
> >> >> > I am trying to wrap my head around your tsm. here is what I got in my tree:
> >> >> > https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
> >> >> >
> >> >> > Shortly:
> >> >> >
> >> >> > drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to 
> >> >> > control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi, 
> >> >> > it does not know pci_dev;
> >> >> >
> >> >> > drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
> >> >> >
> >> >> > drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
> >> >> > - tsm_subsys in tsm.ko (which does "connect" and "bind" and
> >> >> > - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
> >> >> > ccp.ko knows about pci_dev and whatever else comes in the future, and 
> >> >> > ccp.ko's "connect" implementation calls the IDE library (I am adopting 
> >> >> > yours now, with some tweaks).
> >> >> >
> >> >> > tsm-dev and tsm-tdi embed struct dev each and are added as children to 
> >> >> > PCI devices: no hide/show attrs, no additional TSM pointer in struct 
> >> >> > device or pci_dev, looks like:
> >> >> >
> >> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
> >> >> > device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind 
> >> >> > tsm_tdi_status  tsm_tdi_status_user  uevent
> >> >> >
> >> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
> >> >> > device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user 
> >> >> > tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
> >> >> >
> >> >> > aik@sc ~> ls /sys/class/tsm/tsm0/
> >> >> > device  power  stream0:0000:e1:00.0  subsystem  uevent
> >> >> >
> >> >> > aik@sc ~> ls /sys/class/tsm-dev/
> >> >> > tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
> >> >> >
> >> >> > aik@sc ~> ls /sys/class/tsm-tdi/
> >> >> > tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0 
> >> >> > tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
> >> >> >
> >> >> >
> >> >> > SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing 
> >> >> > but pci_dev is only needed for DOE/IDE.
> >> >> >
> >> >> > Or is separating struct pci_dev from struct device not worth it and most 
> >> >> > of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
> >> >> >
> >> >> 
> >> >> For the Arm CCA DA, I have structured the flow as follows. I am
> >> >> currently refining my changes to prepare them for posting. I am using
> >> >> tsm-core in both the host and guest. There is no bind interface at the
> >> >> sysfs level; instead, it is managed via the KVM ioctl
> >> >> 
> >> >> Host:
> >> >> step 1.
> >> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> >> >> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
> >> >> echo ${DEVICE} > /sys/bus/pci/drivers_probe
> >> >> 
> >> >> step 2.
> >> >> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
> >> >> 
> >> >> step 3.
> >> >> using VMM to make the new KVM_SET_DEVICE_ATTR ioctl
> >> >> 
> >> >> +		dev_num = vfio_devices[i].dev_hdr.dev_num;
> >> >> +		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
> >> >> +		guest_bdf = (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
> >> >> +
> >> >> +		struct kvm_vfio_tsm_bind param = {
> >> >> +			.guest_rid = guest_bdf,
> >> >> +			.devfd = vfio_devices[i].fd,
> >> >> +		};
> >> >> +		struct kvm_device_attr attr = {
> >> >> +			.group = KVM_DEV_VFIO_DEVICE,
> >> >> +			.attr = KVM_DEV_VFIO_DEVICE_TDI_BIND,
> >> >> +			.addr = (__u64)&param,
> >> >> +		};
> >> >> +
> >> >> +		if (ioctl(kvm_vfio_device, KVM_SET_DEVICE_ATTR, &attr)) {
> >> >> +			pr_err("Failed KVM_SET_DEVICE_ATTR for KVM_DEV_VFIO_DEVICE");
> >> >> +			return -ENODEV;
> >> >> +		}
> >> >> +
> >> >
> >> > I think bind (which brings device to a LOCKED state, no MMIO, no DMA)
> >> > cannot be a driver agnostic behavior. So I think it should be a VFIO
> >> > ioctl.
> >> >
> >> 
> >> For the current CCA implementation bind is equivalent to VDEV_CREATE
> >> which doesn't mark the device LOCKED. Marking the device LOCKED is
> >> driven by the guest as shown in the steps below.
> >
> > Could you elaborate why vdev create & LOCK can't be done at the same
> > time, when guest requests "lock"? Intel TDX also requires firmware calls
> > like tdi_create(alloc metadata) & tdi_bind(do LOCK), but I don't see
> > there is need to break them out in different phases.
> >
> 
> Yes, that is possible and might be what I will end up doing. Right now
> I have kept the interface flexible enough as I am writing these changes.

Good to know that, thanks.

> Device can possibly be presented in locked state to the guest.

This is also what I did before. But finally I dropped (or pending) this
"early binding" support. There are several reset operations during VM
setup and booting, especially the ones in bios. They breaks LOCK state
and I have to make VFIO suppress the reset, or reset & recover, but that
seems not worth the effort.

May wanna know how you see this problem.

Thanks,
Yilun

