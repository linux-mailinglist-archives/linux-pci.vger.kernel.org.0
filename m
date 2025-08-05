Return-Path: <linux-pci+bounces-33416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69951B1AD75
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 07:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EC6189ED47
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 05:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE717A2FA;
	Tue,  5 Aug 2025 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJEXGLeL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121862AD0B;
	Tue,  5 Aug 2025 05:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754370432; cv=none; b=mItvsmO8NqkQL15IgS7DdSwoCDqKY3tMCtuVQbssrpum1jJ/BzlvM8IgyGYvBPaS0n2GYNqxko6UlKwf0Vpi8wFxzo7fTEFo9zv/a2uaIPK6gCCHFo908b01Xvs+OR2hzQ2UVAbMQEYUjKay1VoFyNwNmxBcXvf3bqUrxUBExtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754370432; c=relaxed/simple;
	bh=9JDTR9BxKqic2TGY9UgdkLZTSDBnR2ZFG+hzdLOr00Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PE0bykPMTdEBTu4zrz8hCau6D5P3qkxZOqq40zbT10jqEkAfxjVyASyf+Nx0YSKopuNVMBEPAtxOCRkGwtvmd7h55bb7BlkL8mqE9RGF6S5/UDDZ02LmPvGgaTNlP9Yy/7V1Qwk/w0FQklCBjj+6gagiAD7Zim5DOu49yfpRquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJEXGLeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFD2C4CEF4;
	Tue,  5 Aug 2025 05:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754370429;
	bh=9JDTR9BxKqic2TGY9UgdkLZTSDBnR2ZFG+hzdLOr00Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JJEXGLeLW4Ji6YpUI7Jk/7agACw+LI+u0FLJJIcUDRT/i5p7fJekRNHQ+A2kEZ6UZ
	 1BI+WOGTUierOiSsVUwXvlaM+YXoOT2+3G+z9SgT54IEjeYh+PnCINwiY/IvaPndqi
	 cX50dRGTKuHXprBPKb5jchNRFNIgmkg7rszvJS+QAo9ZQ4pzHxiZH7sJQTmdGe1DoB
	 dn+xeuwdAcgwPKACAsskGRNUT2JlPL5SwxBd8T/AflA/K6XABhM+cRkZc/j0EyELe9
	 ONm7FKmR2lisWfUzlcjAgxKeIwtCTHRuFMWx5fUaUH/HRTK1FtxDWRPrmpVciquHf3
	 YJdip/0O9CTmA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: dan.j.williams@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
	dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
In-Reply-To: <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
Date: Tue, 05 Aug 2025 10:37:01 +0530
Message-ID: <yq5acy9a8ih6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<dan.j.williams@intel.com> writes:

> Jason Gunthorpe wrote:
>> On Thu, Jul 31, 2025 at 07:07:17PM -0700, dan.j.williams@intel.com wrote:
>> > Aneesh Kumar K.V (Arm) wrote:
>> > > Host:
>> > > step 1.
>> > > echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> > > echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
>> > > echo ${DEVICE} > /sys/bus/pci/drivers_probe
>> > >=20
>> > > step 2.
>> > > echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
>> >=20
>> > Just for my own understanding... presumably there is no ordering
>> > constraint for ARM CCA between step1 and step2, right? I.e. The connect
>> > state is independent of the bind state.
>> >=20
>> > In the v4 PCI/TSM scheme the connect command is now:
>> >=20
>> > echo $tsm_dev > /sys/bus/pci/devices/$DEVICE/tsm/connect
>>=20
>> What does this do on the host? It seems to somehow prep it for VM
>> assignment? Seems pretty strange this is here in sysfs and not part of
>> creating the vPCI function in the VM through VFIO and iommufd?
>
> vPCI is out of the picture at this phase.
>
> On the host this establishes an SPDM session and sets up link encryption
> (IDE) with the physical device. Leave VMs out of the picture, this
> capability in isolation is a useful property. It addresses the similar
> threat model that Intel Total Memory Encryption (TME) or AMD Secure
> Memory Encryption (SME) go after, i.e. interposer on a physical link
> capturing data in flight.=20
>
> With that established then one can go futher to do the full TDISP dance.
>
>> Frankly, I'm nervous about making any uAPI whatsoever for the
>> hypervisor side at this point. I don't think we have enough of the
>> solution even in draft format. I'd really like your first merged TSM
>> series to only have uAPI for the guest side where things are hopefully
>> closer to complete.
>
> Aligned. I am not comfortable merging any of this until we have that end
> to end reliably stable for a kernel cycle or 2. The proposal is soak all
> the vendor solutions together in tsm.git#staging.
>
> Now, if the guest side graduates out of that staging before the host
> side, I am ok with that.
>
>> > > step 1:
>> > > echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>> > >=20
>> > > step 2: Move the device to TDISP LOCK state
>> > > echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/lock
>> >=20
>> > Ok, so my stance has recently picked up some nuance here. As Jason
>> > mentions here:
>> >=20
>> > http://lore.kernel.org/20250410235008.GC63245@ziepe.ca
>> >=20
>> > "However it works, it should be done before the driver is probed and
>> > remain stable for the duration of the driver attachment. From the
>> > iommu side the correct iommu domain, on the correct IOMMU instance to
>> > handle the expected traffic should be setup as the DMA API's iommu
>> > domain."
>>=20
>> I think it is not just the dma api, but also the MMIO registers may
>> move location (form shared to protected IPA space for
>> example). Meaning any attached driver is completely wrecked.
>
> True.
>
>> > I agree with that up until the point where the implication is userspace
>> > control of the UNLOCKED->LOCKED transition. That transition requires
>> > enabling bus-mastering (BME),=20
>>=20
>> Why? That's sad. BME should be controlled by the VM driver not the
>> TSM, and it should be set only when a VM driver is probed to the RUN
>> state device?
>
> To me it is an unfortunate PCI specification wrinkle that writing to the
> command register drops the device from RUN to ERROR. So you can LOCK
> without setting BME, but then no DMA.
>

This is only w.r.t clearing BME isn't ?

According to section 11.2.6 DSM Tracking and Handling of Locked TDI Configu=
rations

Clearing any of the following bits causes the TDI hosted
by the Function to transition to ERROR:

=E2=80=A2 Memory Space Enable
=E2=80=A2 Bus Master Enable


Which implies the flow described in the cover-letter where driver enable th=
e BME works?
However clearing BME may be problematic? I did have a FIXME!!/comment in [1]

vfio_pci_core_close_device():

#if 0
	/*
	 * destroy vdevice which involves tsm unbind before we disable pci disable
	 * A MSE/BME clear will transition the device to error state.
	 */
	if (core_vdev->iommufd_device)
		iommufd_device_tombstone_vdevice(core_vdev->iommufd_device);
#endif

	vfio_pci_core_disable(vdev);


Currently, we destroy (TSM unbind) the vdevice after calling
vfio_pci_core_disable(), which means BME is cleared before unbinding,
and the TDI transitions to the ERROR state.

[1] https://lore.kernel.org/all/20250728135216.48084-9-aneesh.kumar@kernel.=
org/

-aneesh

