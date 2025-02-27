Return-Path: <linux-pci+bounces-22526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E2A475FE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 07:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494623A483C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 06:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A50721B9E6;
	Thu, 27 Feb 2025 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXJ1IIlP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF2BE65
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638250; cv=none; b=jtNQGmEp34t2P/iTkdmCZPld2Utyt8Rtp5Qn022KzcKWxEp2oPKadFHylvhjd13tOEFr7HsOPZop1JPHQWD6zMhGQfOBqHzwlqr19mqB2+25POpCXKz6rjLMFIq06yinsTwH8Frcsr9yMjWbc2SjyrNf1L6FGotf7YcqsW/h4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638250; c=relaxed/simple;
	bh=6ehUHRs0ik5Iv0w8P3wUfENOuZ9HjBUtmswnvaYMVwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6sVHff6FDotrkPppI/QHDpfTDsnGs/kFmPRgxIGVAvBWUSmGb3+hwwsEvJgCwmKa/DopL9wM8b+GUv/F4TnMrBcVWDRJFZFEaiVPITSOs/+ZHW9Ymzg/TNK+xIa1XBZvzjw8kRPYRZU+RfZtu4ieaePPlZ+BjwuJcyuLXzNidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXJ1IIlP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740638248; x=1772174248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ehUHRs0ik5Iv0w8P3wUfENOuZ9HjBUtmswnvaYMVwA=;
  b=TXJ1IIlPRkvdQ2H6zThTg+RG2/t6NLImK6rROI/b6hV9Mn4jgYJxDZvZ
   CYu5gIgRiQsqUyinfBLyETW8NM6ChMuwxkM3+NyO0DReRXaRrfK6Wl4id
   oGcyxZzeF6FkWKl++5TJr2xRFHh8tZDQ2Mx1DrX3OCy3Nb8Ft6UPM21B9
   1RDgKdK8+SJnpb9pXTi7TEOYUE7JOAoRN7BSBcAiBWbOpTSFNfRDCTGNr
   S/s+92enQ2R4bhSJRyeVPoEcjUklntR7wXq8jUIs+2yKCGxOqycqBoAVJ
   76zHOJye6mITWocLN3SyfhrVkiGso22uYbvokoGrvfZuk0WKXD7Wvo7Uk
   w==;
X-CSE-ConnectionGUID: nKGDNwrmRe6uQNz9vlNvoQ==
X-CSE-MsgGUID: A2EXDVNBReiOR40M0iXrPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41396536"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41396536"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:37:27 -0800
X-CSE-ConnectionGUID: FOgA5Nd1Q6i+lCRcp/L18Q==
X-CSE-MsgGUID: EKTE0JcoQ4ufOu3nyzIu0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117575409"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 26 Feb 2025 22:37:26 -0800
Date: Thu, 27 Feb 2025 14:35:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <Z8AHtcYgz2JukdfM@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <yq5aeczrww9j.fsf@kernel.org>
 <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
 <yq5a4j0gc3fp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a4j0gc3fp.fsf@kernel.org>

On Wed, Feb 26, 2025 at 05:40:02PM +0530, Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
> > On Fri, Feb 21, 2025 at 01:43:28PM +0530, Aneesh Kumar K.V wrote:
> >> Alexey Kardashevskiy <aik@amd.com> writes:
> >> 
> >> ....
> >> 
> >> >
> >> > I am trying to wrap my head around your tsm. here is what I got in my tree:
> >> > https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
> >> >
> >> > Shortly:
> >> >
> >> > drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to 
> >> > control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi, 
> >> > it does not know pci_dev;
> >> >
> >> > drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
> >> >
> >> > drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
> >> > - tsm_subsys in tsm.ko (which does "connect" and "bind" and
> >> > - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
> >> > ccp.ko knows about pci_dev and whatever else comes in the future, and 
> >> > ccp.ko's "connect" implementation calls the IDE library (I am adopting 
> >> > yours now, with some tweaks).
> >> >
> >> > tsm-dev and tsm-tdi embed struct dev each and are added as children to 
> >> > PCI devices: no hide/show attrs, no additional TSM pointer in struct 
> >> > device or pci_dev, looks like:
> >> >
> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
> >> > device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind 
> >> > tsm_tdi_status  tsm_tdi_status_user  uevent
> >> >
> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
> >> > device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user 
> >> > tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
> >> >
> >> > aik@sc ~> ls /sys/class/tsm/tsm0/
> >> > device  power  stream0:0000:e1:00.0  subsystem  uevent
> >> >
> >> > aik@sc ~> ls /sys/class/tsm-dev/
> >> > tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
> >> >
> >> > aik@sc ~> ls /sys/class/tsm-tdi/
> >> > tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0 
> >> > tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
> >> >
> >> >
> >> > SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing 
> >> > but pci_dev is only needed for DOE/IDE.
> >> >
> >> > Or is separating struct pci_dev from struct device not worth it and most 
> >> > of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
> >> >
> >> 
> >> For the Arm CCA DA, I have structured the flow as follows. I am
> >> currently refining my changes to prepare them for posting. I am using
> >> tsm-core in both the host and guest. There is no bind interface at the
> >> sysfs level; instead, it is managed via the KVM ioctl
> >> 
> >> Host:
> >> step 1.
> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> >> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
> >> echo ${DEVICE} > /sys/bus/pci/drivers_probe
> >> 
> >> step 2.
> >> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
> >> 
> >> step 3.
> >> using VMM to make the new KVM_SET_DEVICE_ATTR ioctl
> >> 
> >> +		dev_num = vfio_devices[i].dev_hdr.dev_num;
> >> +		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
> >> +		guest_bdf = (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
> >> +
> >> +		struct kvm_vfio_tsm_bind param = {
> >> +			.guest_rid = guest_bdf,
> >> +			.devfd = vfio_devices[i].fd,
> >> +		};
> >> +		struct kvm_device_attr attr = {
> >> +			.group = KVM_DEV_VFIO_DEVICE,
> >> +			.attr = KVM_DEV_VFIO_DEVICE_TDI_BIND,
> >> +			.addr = (__u64)&param,
> >> +		};
> >> +
> >> +		if (ioctl(kvm_vfio_device, KVM_SET_DEVICE_ATTR, &attr)) {
> >> +			pr_err("Failed KVM_SET_DEVICE_ATTR for KVM_DEV_VFIO_DEVICE");
> >> +			return -ENODEV;
> >> +		}
> >> +
> >
> > I think bind (which brings device to a LOCKED state, no MMIO, no DMA)
> > cannot be a driver agnostic behavior. So I think it should be a VFIO
> > ioctl.
> >
> 
> For the current CCA implementation bind is equivalent to VDEV_CREATE
> which doesn't mark the device LOCKED. Marking the device LOCKED is
> driven by the guest as shown in the steps below.

Could you elaborate why vdev create & LOCK can't be done at the same
time, when guest requests "lock"? Intel TDX also requires firmware calls
like tdi_create(alloc metadata) & tdi_bind(do LOCK), but I don't see
there is need to break them out in different phases.

> 
> 
> >> 
> >> Now in the guest we follow the below steps
> >> 
> >> step 1:
> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> >> 
> >> step 2: Move the device to TDISP LOCK state
> >> echo 1 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
> >> echo 3 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
> >
> > Reuse the 'connect' interface? I think it conceptually brings chaos. Is
> > it better we create a new interface?
> >
> 
> I was looking at converting these numbers to strings.
> "1" -> connect

What does "connect" do in guest?

Thanks,
Yilun

> "2" -> lock
> "3" -> run
> 
> 
> >
> >> 
> >> step 3: Moves the device to TDISP RUN state
> >> echo 4 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
> >
> > Could you elaborate what '1'/'3'/'4' stand for?
> >
> 
> As mentioned above, them move the device to different TDISP state.
> 
> I will reply to this patch with my early RFC chnages for tsm framework.
> I am not yet ready to share the CCA backend changes. But I assume having
> the tsm framework changes alone can be useful?
> 
> -aneesh

