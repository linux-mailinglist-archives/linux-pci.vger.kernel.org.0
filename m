Return-Path: <linux-pci+bounces-37752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BEFBC7A6E
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 09:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B11BF4E51E3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8999F24E01D;
	Thu,  9 Oct 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxabBT8/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD81D5147;
	Thu,  9 Oct 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994243; cv=none; b=uoE/U5fCKjukOMIl6jcFAJ44K79vXd5CwLGcA4HR4JHPlPI/wgbOjdf2Dz78JEyvtxSBqbSBCmNK37zJ6N8DiTwGq2SO3WkIUuXq84L/3kghBMex/MH0oOKf6kxRvxmjxg4sy/S7/bvpKAbaRvjCz0bcFUAM0K1dWo/O9fXPDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994243; c=relaxed/simple;
	bh=qpw+6J2ytukjMwUmxCZyRh0+7i8HVvt1dA1nhFhJDmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BNC/oceX+tU1YGuoKylkuACpQ/f/PVh+ztmpYCG+vj0CNV+yTP3JbRlrKeeewH8y/OKpKH9uPRGD6KQpTFtByPKLOVzio4fmUFaPGrsyr6X2zXJIXSPJKA+ugPJTY8OaxyX+ibM9lwxQUfFzWp4PBjdoLVyuaR596FNKQuGT+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxabBT8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071D0C4CEE7;
	Thu,  9 Oct 2025 07:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759994242;
	bh=qpw+6J2ytukjMwUmxCZyRh0+7i8HVvt1dA1nhFhJDmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qxabBT8/OBr9oWRsRZC1T4SCz/d/UL9LHnDRBeT7LDEoOnY+JcC5Ohyn1VkvPB+TZ
	 vSgOdO85UFh3UoszH9719MuF7wO7/Pskv+1/Ng2ROmVD4wyEZzJByKOKYSzPrDgHdb
	 5c/DfzhDI9lL4N11239fttCX6M3z66/aZ84n4HgVDBIMwkGweyFNzW6dDYhckhE3iL
	 Go5yre6HVBnDlrQJkT85vwQF03rQgOymEEf4UpDKpf7d52/HfC85wUVCSEC0Zu4fR1
	 UZ9BqOKHsYBT2Q2vrMJV5xHTRfiQz8gFYwXjbM/wUvO97hAfsYzJERUJ5aJLr6sCNj
	 1zcsL+43/ZMFw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: dan.j.williams@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, gregkh@linuxfounation.org
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm
 platform device
In-Reply-To: <688d61b1c4c8c_55f09100f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com> <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org> <20250730113827.000032b8@huawei.com>
 <20250731121133.GP26511@ziepe.ca>
 <688d61b1c4c8c_55f09100f4@dwillia2-xfh.jf.intel.com.notmuch>
Date: Thu, 09 Oct 2025 12:47:14 +0530
Message-ID: <yq5aikgoa6it.fsf@kernel.org>
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
>> On Wed, Jul 30, 2025 at 11:38:27AM +0100, Jonathan Cameron wrote:
>> > On Wed, 30 Jul 2025 14:12:26 +0530
>> > "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
>> >=20
>> > > Jason Gunthorpe <jgg@ziepe.ca> writes:
>> > >=20
>> > > > On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
>> > > >=20=20
>> > > >> > +static struct platform_device cca_host_dev =3D {=20=20
>> > > >> Hmm. Greg is getting increasingly (and correctly in my view) grum=
py with
>> > > >> platform devices being registered with no underlying resources et=
c as glue
>> > > >> layers.  Maybe some of that will come later.=20=20
>> > > >
>> > > > Is faux_device a better choice? I admit to not knowing entirely wh=
at
>> > > > it is for..
>> >=20
>> > I'll go with a cautious yes to faux_device. This case of a glue device
>> > with no resources and no reason to be on a particular bus was definite=
ly
>> > the intent but I'm not 100% sure without trying it that we don't run
>> > into any problems.
>> >=20
>> > Not that many examples yet, but cpuidle-psci.c looks like a vaguely si=
milar
>> > case to this one.=20=20
>> >=20
>> > All it really does is move the location of the device and
>> > smash together the device registration with probe/remove.
>> > That means the device disappears if probe() fails, which is cleaner
>> > in many ways than leaving a pointless stub behind.
>> >=20
>> > Maybe it isn't appropriate it if is actually useful to rmmod/modprobe =
the
>> > driver.=20
>>=20
>> Yeah, exactly. Can a TSM driver even be modular? If it has to be built
>> in then there is no reason to do this:
>
> For example, CRYPTO_DEV_CCP_DD, the AMD PCI device driver that will call
> tsm_register(), is already modular.
>
>> > > The goal is to have tsm class device to be parented by the platform
>> > > device.
>>=20
>> IMHO the only real point of that is to trigger module autoloading.
>
> Right. For TDX, and I expect CCA as well, the arch code that knows that
> PCI/TSM functionality is available and can register a device, may be
> running too early to attach a driver to that device.
>
> I.e. I would like to just use faux_device, but without the ability to do
> EPROBE_DEFER, for example to await the plaform IOMMU driver. It needs to
> move to its own bus so the attach event can be handled at a better time.
>

One of the issues I=E2=80=99ve run into after switching to the faux_device =
model
is determining how to automatically load the guest and host TSM drivers
based on the availability of the device assignment feature.

The platform device previously provided a clean abstraction for this
behavior, which made autoloading straightforward

>
>> Otherwise the tsm core should accept NULL as the parent pointer during
>> registration, it probably already does..
>
> Yes, NULL @parent "just works" with tsm_register().
>
> However, I expect all tsm_register() callers to be from modular drivers.

-aneesh

