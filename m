Return-Path: <linux-pci+bounces-21968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F5CA3EE12
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 09:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758C816952D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ADB1F9406;
	Fri, 21 Feb 2025 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjRe+UYF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CF2AEF1;
	Fri, 21 Feb 2025 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125622; cv=none; b=ljYD6Z9rmbQ0d1JNCmGLvpFS7uQxOtos4Z8ZPOm+gYYHgVWsi7I+tDL8V5Y78YP8xhwOPG3KYglSfYMh4ZaK6nmz58K63Ka85cQXLivtZ07Hc7BzHRWTjFEhtmvncbJwTqWT598ElEMG+huHBkmlGnHbGtcWkcacoQH0t0LMTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125622; c=relaxed/simple;
	bh=sstp1KHRVscNEp2wCo68NPITpWUlLbBip5GRGpXG6aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oa1S0yWIgMpEIIyi4DITforF1sdRDsWascsf0+BqzNoanGuH6S90TX7BUqS1EvCnEpDW/CvZExOwBvxOOyxxEAvz//ms5aq3W3MMa3n9juBureinJIpoUUFhMJC4QKYBCWO0uNr+CFfScuU96/b3E0OdNAwA5TDOAXIEpYQdBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjRe+UYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C3EC4CEE6;
	Fri, 21 Feb 2025 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740125622;
	bh=sstp1KHRVscNEp2wCo68NPITpWUlLbBip5GRGpXG6aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cjRe+UYFBSpzEAk8kqexVfZpzvZVW8PnFSA2x3+WqQiRJGUx9YDUvlG2yoWRXe0av
	 YlyWvWT0pQ8As+6lbCjJDpExxB5zvaExCve5g7TvxJuwg24LPPuOFvOaMcPHAE2OEf
	 U0PM2o3/CQ9619EywQtI37TykWEtURJv61tRUEwO4H0tS6hoZ8EbG7FX+Qg2hZA+sb
	 53YYN4+5qUxrUosbmckEcc0nBCRf0WQaihbFpGXllJBOsuFJAfUz8Cu/I5NEZAjP4+
	 CEdmUzNe7suJ2dR/BWa+d2tfDrFSlnenwutzk1L/MOz8tFmOeegWS5ZFr0uovWnnVk
	 TF6v0ZkgtekSg==
X-Mailer: emacs 29.4 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
Date: Fri, 21 Feb 2025 13:43:28 +0530
Message-ID: <yq5aeczrww9j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

....

>
> I am trying to wrap my head around your tsm. here is what I got in my tree:
> https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
>
> Shortly:
>
> drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to 
> control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi, 
> it does not know pci_dev;
>
> drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
>
> drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
> - tsm_subsys in tsm.ko (which does "connect" and "bind" and
> - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
> ccp.ko knows about pci_dev and whatever else comes in the future, and 
> ccp.ko's "connect" implementation calls the IDE library (I am adopting 
> yours now, with some tweaks).
>
> tsm-dev and tsm-tdi embed struct dev each and are added as children to 
> PCI devices: no hide/show attrs, no additional TSM pointer in struct 
> device or pci_dev, looks like:
>
> aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
> device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind 
> tsm_tdi_status  tsm_tdi_status_user  uevent
>
> aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
> device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user 
> tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
>
> aik@sc ~> ls /sys/class/tsm/tsm0/
> device  power  stream0:0000:e1:00.0  subsystem  uevent
>
> aik@sc ~> ls /sys/class/tsm-dev/
> tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
>
> aik@sc ~> ls /sys/class/tsm-tdi/
> tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0 
> tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
>
>
> SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing 
> but pci_dev is only needed for DOE/IDE.
>
> Or is separating struct pci_dev from struct device not worth it and most 
> of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
>

For the Arm CCA DA, I have structured the flow as follows. I am
currently refining my changes to prepare them for posting. I am using
tsm-core in both the host and guest. There is no bind interface at the
sysfs level; instead, it is managed via the KVM ioctl

Host:
step 1.
echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
echo ${DEVICE} > /sys/bus/pci/drivers_probe

step 2.
echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect

step 3.
using VMM to make the new KVM_SET_DEVICE_ATTR ioctl

+		dev_num = vfio_devices[i].dev_hdr.dev_num;
+		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
+		guest_bdf = (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
+
+		struct kvm_vfio_tsm_bind param = {
+			.guest_rid = guest_bdf,
+			.devfd = vfio_devices[i].fd,
+		};
+		struct kvm_device_attr attr = {
+			.group = KVM_DEV_VFIO_DEVICE,
+			.attr = KVM_DEV_VFIO_DEVICE_TDI_BIND,
+			.addr = (__u64)&param,
+		};
+
+		if (ioctl(kvm_vfio_device, KVM_SET_DEVICE_ATTR, &attr)) {
+			pr_err("Failed KVM_SET_DEVICE_ATTR for KVM_DEV_VFIO_DEVICE");
+			return -ENODEV;
+		}
+

Now in the guest we follow the below steps

step 1:
echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind

step 2: Move the device to TDISP LOCK state
echo 1 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
echo 3 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect

step 3: Moves the device to TDISP RUN state
echo 4 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect

step 4: Load the driver again.
echo ${DEVICE} > /sys/bus/pci/drivers_probe



