Return-Path: <linux-pci+bounces-22632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97CEA496AB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E863F3B8EBA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1E262D1C;
	Fri, 28 Feb 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR5DonKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126C25DAE7;
	Fri, 28 Feb 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737225; cv=none; b=MAygsiDcZQ/fYoQWrn+zFSyj2fwSdci4m/b0KHG7PRjCmmfu2T+01ceVI3nMwZ/26dnnyHVvAoOdlrG/rPT188xS42jg5iIcCYwEnAm2lsWs2wWtU1XubSkRe/EJ11HOw8rQijXwOdw/gXy438G1beP3cg0kYzbLveWvhrb5sI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737225; c=relaxed/simple;
	bh=2Ub+/dQJerhIjfIvvJPnufU3UVsW2i1UF28us3Ne3mY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHpQclHq8vW9yJlCLjfK5GT5dkibwz5My9K+PwHGP8+vD0iUQ1uy6KX3WZNMYyU5tsyFybXw4zr7fXRMrVSnsyX2GhMJzgUWZNrTLyiXfojT4kWFB5C1r8GPursqX18/IW8SefY6J4trOQ/IdtCLzlrhp3OeLjU0jYnZ3BelXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR5DonKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6675CC4CEE4;
	Fri, 28 Feb 2025 10:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740737224;
	bh=2Ub+/dQJerhIjfIvvJPnufU3UVsW2i1UF28us3Ne3mY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aR5DonKd/jRgrJdqdgrPHbItFB2piYaQPleIQfysSgI0xGabTNRzY9e3DoyAM1XJK
	 l4JVxAMy5mdWPU6urTSV7uwHnlSJcE5vc+cUGPr9IMrPUmxSmiSrJ8Vc2K2bTOjIIN
	 GBGk9d0jBM0BywqQQCKB3ANcwsX1BWaAU+nHa0HwQsu5sta+cvCkrhc9PGMT0Xzx9i
	 m9gK02izCqNd5s99HF1hfFzQP6YZ2/JD2O0uywP1xFfOmyLmnGDlhLdF2uvsCCVgre
	 Ar4w3aFrvn9f4POPkOc2Ey8D/EryNdL2D/nbVDj356cweuL6WxHSZ0n5x5TlQu4G4b
	 eMkPVNqbyy+tg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <67c0c2ad14955_1a7f294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <yq5aeczrww9j.fsf@kernel.org> <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
 <yq5a4j0gc3fp.fsf@kernel.org>
 <67c0c2ad14955_1a7f294d5@dwillia2-xfh.jf.intel.com.notmuch>
Date: Fri, 28 Feb 2025 15:36:58 +0530
Message-ID: <yq5a1pvi8jst.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> writes:

> Aneesh Kumar K.V wrote:
>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>=20
>> > On Fri, Feb 21, 2025 at 01:43:28PM +0530, Aneesh Kumar K.V wrote:
>> >> Alexey Kardashevskiy <aik@amd.com> writes:
>> >>=20
>> >> ....
>> >>=20
>> >> >
>> >> > I am trying to wrap my head around your tsm. here is what I got in =
my tree:
>> >> > https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
>> >> >
>> >> > Shortly:
>> >> >
>> >> > drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind"=
 to=20
>> >> > control and "certs"/"report" to attest) and implements tsm_dev/tsm_=
tdi,=20
>> >> > it does not know pci_dev;
>> >> >
>> >> > drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.k=
o;
>> >> >
>> >> > drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
>> >> > - tsm_subsys in tsm.ko (which does "connect" and "bind" and
>> >> > - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
>> >> > ccp.ko knows about pci_dev and whatever else comes in the future, a=
nd=20
>> >> > ccp.ko's "connect" implementation calls the IDE library (I am adopt=
ing=20
>> >> > yours now, with some tweaks).
>> >> >
>> >> > tsm-dev and tsm-tdi embed struct dev each and are added as children=
 to=20
>> >> > PCI devices: no hide/show attrs, no additional TSM pointer in struc=
t=20
>> >> > device or pci_dev, looks like:
>> >> >
>> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1=
:04.0/
>> >> > device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind=
=20
>> >> > tsm_tdi_status  tsm_tdi_status_user  uevent
>> >> >
>> >> > aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
>> >> > device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user=
=20
>> >> > tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
>> >> >
>> >> > aik@sc ~> ls /sys/class/tsm/tsm0/
>> >> > device  power  stream0:0000:e1:00.0  subsystem  uevent
>> >> >
>> >> > aik@sc ~> ls /sys/class/tsm-dev/
>> >> > tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
>> >> >
>> >> > aik@sc ~> ls /sys/class/tsm-tdi/
>> >> > tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:0=
4.0=20
>> >> > tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
>> >> >
>> >> >
>> >> > SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI th=
ing=20
>> >> > but pci_dev is only needed for DOE/IDE.
>> >> >
>> >> > Or is separating struct pci_dev from struct device not worth it and=
 most=20
>> >> > of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
>> >> >
>> >>=20
>> >> For the Arm CCA DA, I have structured the flow as follows. I am
>> >> currently refining my changes to prepare them for posting. I am using
>> >> tsm-core in both the host and guest. There is no bind interface at the
>> >> sysfs level; instead, it is managed via the KVM ioctl
>> >>=20
>> >> Host:
>> >> step 1.
>> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> >> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
>> >> echo ${DEVICE} > /sys/bus/pci/drivers_probe
>> >>=20
>> >> step 2.
>> >> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
>> >>=20
>> >> step 3.
>> >> using VMM to make the new KVM_SET_DEVICE_ATTR ioctl
>> >>=20
>> >> +		dev_num =3D vfio_devices[i].dev_hdr.dev_num;
>> >> +		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
>> >> +		guest_bdf =3D (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
>> >> +
>> >> +		struct kvm_vfio_tsm_bind param =3D {
>> >> +			.guest_rid =3D guest_bdf,
>> >> +			.devfd =3D vfio_devices[i].fd,
>> >> +		};
>> >> +		struct kvm_device_attr attr =3D {
>> >> +			.group =3D KVM_DEV_VFIO_DEVICE,
>> >> +			.attr =3D KVM_DEV_VFIO_DEVICE_TDI_BIND,
>> >> +			.addr =3D (__u64)&param,
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
>>=20
>> For the current CCA implementation bind is equivalent to VDEV_CREATE
>> which doesn't mark the device LOCKED. Marking the device LOCKED is
>> driven by the guest as shown in the steps below.
>
> I plan to switch focus to the bind flow after we achieve consensus on
> the base TSM framework pieces, but my initial reaction is that
> separating "bind" from "lock" is a finer grained state transition than
> has been discussed previously. There are end use cases that justify
> exposing LOCKED vs RUN in the ABI, but could point to the use case for
> separating the BOUND vs LOCKED states?
>

Can you share the link or reference to the previous discussion? I wasn=E2=
=80=99t
aware of it.

I chose to implement vdev_create and TDISP lock as two separate steps to
better align with the RMM spec[1]. Additionally, there is a possibility
that the guest might need to perform certain operations that either
cannot be executed in the TDISP locked state or would cause the device
to transition to an unlocked state.

In such cases, wouldn=E2=80=99t we need a guest interface to move the device
back to the locked state? I understand that this process might trigger a
device reset, which could even require a full restart of the device
assignment workflow

[1] https://developer.arm.com/-/cdn-downloads/permalink/Architectures/Armv9=
/DEN0137_1.1-alp12.zip

>
>> >> Now in the guest we follow the below steps
>> >>=20
>> >> step 1:
>> >> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> >>=20
>> >> step 2: Move the device to TDISP LOCK state
>> >> echo 1 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
>> >> echo 3 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
>> >
>> > Reuse the 'connect' interface? I think it conceptually brings chaos. Is
>> > it better we create a new interface?
>> >
>>=20
>> I was looking at converting these numbers to strings.
>> "1" -> connect
>> "2" -> lock
>
> I have been modeling Host-side "connect" as IDE establishment on the PF
> while Guest-side "connect" arranges for "bind+lock" on an assigned
> function / TDI. Do we really need to expose "lock" as an explicit state
> vs interpret what "connect" means in the different contexts?
>

One possible use case I was considering is a guest needing to perform
certain operations before the device transitions to the locked state.

>> "3" -> run
>>=20
>> >> step 3: Moves the device to TDISP RUN state
>> >> echo 4 > /sys/bus/pci/devices/0000:00:00.0/tsm/connect
>> >
>> > Could you elaborate what '1'/'3'/'4' stand for?
>> >
>>=20
>> As mentioned above, them move the device to different TDISP state.
>>=20
>> I will reply to this patch with my early RFC chnages for tsm framework.
>> I am not yet ready to share the CCA backend changes. But I assume having
>> the tsm framework changes alone can be useful?
>
> Yes. There are so many moving pieces and multiple vendors that the only
> way to make progress here is to wrestle the common pieces into a form
> that all vendors can agree. Feel free to extend the samples/devsec/
> implementation to demonstrate flows that CCA needs. The idea is that
> sample implementation serves as both a reference implementation and a
> simple smoke test for all the common core pieces.

I haven't looked at samples/devsec yet because it has an x86 PCI
dependency, and it was easier to get the ARM RME backend working.
However, I will try to update devsec to work with ARM RME as well

-aneesh


