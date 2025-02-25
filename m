Return-Path: <linux-pci+bounces-22290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9412A43607
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 08:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9413B727B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3672566F1;
	Tue, 25 Feb 2025 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7jgw7T8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791124EF96
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740467981; cv=none; b=J1BjFB4K4J7FxzzFKZMe4XgrWXkWx4wiTPGuqJmCNKUwvffv9QhbTPJbopiXGLczzl29ZJL/gf28iZYn9vUt5w8ZHIRshqVSBTN8dGbWpH3sZ6nwfgYjkcaUcPDgtFk6iA+86lPqklkwVRiE4vorAEcuS1543n12EiyCa85ABsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740467981; c=relaxed/simple;
	bh=dS+PWUcfJ3XaqI1dCSZhmyUY1Ks/Z7nsCJpe9zNAhDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFR2dsIpebhbWVpSuCFkXl1TFckf5eS7R4hQXMz0OUd2h+7iN1l0TpKS5d6fatI9EfCMMZabiqryOEmT2IE9DqLIWPPoYkhTLy5iICU3xbLaLPOCnHTPnkAh9n407w0Woobp/z3v38q9Cjy9ZtfCVboRRhOeQ/Ko4Mht4CgOXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7jgw7T8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740467980; x=1772003980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dS+PWUcfJ3XaqI1dCSZhmyUY1Ks/Z7nsCJpe9zNAhDo=;
  b=D7jgw7T8K5pcvNzz/6aQ7T4dUH+sQ8P7usfo3ZHWqAOZDe3KY0KEOOGw
   Xk3wIgspg+qfp0x52wG1YHatfn2fbnEsdwRoX4qt32A6CaFbV+PbTItd4
   UHoBH5nD0Q4BX6MUCEg9jvM9ndZtQWbR74kb3XdZnYzfqGEMLe8oqKila
   DrQX1i0kS3OrFNpW0qVQ6VtmWjt6tfznbUJNDNaxdjNzwIlMgjalzZtUK
   shQwli2x6mkTlu56wpicH2iiaTbfFPf8A8gq4huWt/HnFwiQyU5os1YGi
   UXaOgTUIxH1dA5y1beuShx/CnLMzYPsC6OPcbCNoztpycB7sSZgsK8muq
   g==;
X-CSE-ConnectionGUID: qwssI+MsQB2fu4XFjZyJNQ==
X-CSE-MsgGUID: 9zRygzZ0QYWosTD8q57Zyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40445932"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="40445932"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:19:34 -0800
X-CSE-ConnectionGUID: L/xnZHyYSQeqTYrocEb5Hw==
X-CSE-MsgGUID: XKMIU+zPQhOPc1CzX6RDzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116932055"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 24 Feb 2025 23:19:32 -0800
Date: Tue, 25 Feb 2025 15:17:45 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <yq5aeczrww9j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aeczrww9j.fsf@kernel.org>

On Fri, Feb 21, 2025 at 01:43:28PM +0530, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
> ....
> 
> >
> > I am trying to wrap my head around your tsm. here is what I got in my tree:
> > https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
> >
> > Shortly:
> >
> > drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to 
> > control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi, 
> > it does not know pci_dev;
> >
> > drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
> >
> > drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
> > - tsm_subsys in tsm.ko (which does "connect" and "bind" and
> > - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
> > ccp.ko knows about pci_dev and whatever else comes in the future, and 
> > ccp.ko's "connect" implementation calls the IDE library (I am adopting 
> > yours now, with some tweaks).
> >
> > tsm-dev and tsm-tdi embed struct dev each and are added as children to 
> > PCI devices: no hide/show attrs, no additional TSM pointer in struct 
> > device or pci_dev, looks like:
> >
> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
> > device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind 
> > tsm_tdi_status  tsm_tdi_status_user  uevent
> >
> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
> > device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user 
> > tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
> >
> > aik@sc ~> ls /sys/class/tsm/tsm0/
> > device  power  stream0:0000:e1:00.0  subsystem  uevent
> >
> > aik@sc ~> ls /sys/class/tsm-dev/
> > tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
> >
> > aik@sc ~> ls /sys/class/tsm-tdi/
> > tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0 
> > tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
> >
> >
> > SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing 
> > but pci_dev is only needed for DOE/IDE.
> >
> > Or is separating struct pci_dev from struct device not worth it and most 
> > of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
> >
> 
> For the Arm CCA DA, I have structured the flow as follows. I am
> currently refining my changes to prepare them for posting. I am using
> tsm-core in both the host and guest. There is no bind interface at the
> sysfs level; instead, it is managed via the KVM ioctl
> 
> Host:
> step 1.
> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
> echo ${DEVICE} > /sys/bus/pci/drivers_probe
> 
> step 2.
> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
> 
> step 3.
> using VMM to make the new KVM_SET_DEVICE_ATTR ioctl
> 
> +		dev_num = vfio_devices[i].dev_hdr.dev_num;
> +		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
> +		guest_bdf = (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
> +
> +		struct kvm_vfio_tsm_bind param = {
> +			.guest_rid = guest_bdf,
> +			.devfd = vfio_devices[i].fd,
> +		};
> +		struct kvm_device_attr attr = {
> +			.group = KVM_DEV_VFIO_DEVICE,
> +			.attr = KVM_DEV_VFIO_DEVICE_TDI_BIND,
> +			.addr = (__u64)&param,
> +		};
> +
> +		if (ioctl(kvm_vfio_device, KVM_SET_DEVICE_ATTR, &attr)) {
> +			pr_err("Failed KVM_SET_DEVICE_ATTR for KVM_DEV_VFIO_DEVICE");
> +			return -ENODEV;
> +		}
> +

I think bind (which brings device to a LOCKED state, no MMIO, no DMA)
cannot be a driver agnostic behavior. So I think it should be a VFIO
ioctl.

> 
> Now in the guest we follow the below steps
> 
> step 1:
> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> 
> step 2: Move the device to TDISP LOCK state
> echo 1 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
> echo 3 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect

Reuse the 'connect' interface? I think it conceptually brings chaos. Is
it better we create a new interface?

> 
> step 3: Moves the device to TDISP RUN state
> echo 4 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect

Could you elaborate what '1'/'3'/'4' stand for?

Thanks,
Yilun

> 
> step 4: Load the driver again.
> echo ${DEVICE} > /sys/bus/pci/drivers_probe
> 
> 

