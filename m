Return-Path: <linux-pci+bounces-38189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161BBDDDFB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9459C3C539F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13B31B11C;
	Wed, 15 Oct 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APQcqUfy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6A308F2E;
	Wed, 15 Oct 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521958; cv=none; b=Upw080ZXsggUCnZ8/cEthqtuc00T/cjUTX5Sdwff0luu+Jkk33LA3m4YMKjDidyJSYMCOQoaa3xHog9Tx/nlkCx0WSQ5spfsZRAHnV/4HSdC4enQlK4E2sceQhwbWS747gwDbCTk6C3NU/UeiUNEyyFmH1J80N17aiR+Oj4ucVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521958; c=relaxed/simple;
	bh=y0AyUun396Qe57qvtbsaVfGWNx4pdz69sER2tQtFKgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DIP77ERVf/2o7z1AqpKWVwsg6/QQfdu54sJzx3HSPNSSQuHGEM7SQHFImtSKHiJFISEnf7sptwEVhdEEoRWpHN+QT0AUklBkbgadvMCpIpqWshXaWWWJq1RyaotBTBFGNFx308ZrS4Y0fNFEIZmYcWutrVCrTDdRXyLecknbeIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APQcqUfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F88C4CEF8;
	Wed, 15 Oct 2025 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760521957;
	bh=y0AyUun396Qe57qvtbsaVfGWNx4pdz69sER2tQtFKgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=APQcqUfy687JtTczvl7s40SFNg3UbuXiAUWd0XtCvfMecwAYmK91CnkRvLTJ2NKP/
	 /meQxJsltrtVemIgB51odBZY/1vSgqyAsKqXBjP8Kpy89MJ6XSnVWUhtvkXJkOo0hi
	 jJ4aSqlxhf6q2epeg1Otv0MrvY2RAOILyRPRhBb62mE1kvivl21NpCS0kID2/ZycmP
	 u1imzaVTYJqfeWC181BsHM8KTWPEuW8AqGOnZaOa9Nlyp5NeTqkrhOn3HU7aXpXUbX
	 /LrqqsRT4i1xVpVWYoGPiZuTzeTKhc0TvAX/xv7KbeXLr3GGV5OoH54qDOxLB6d/ds
	 OV4etI5OCtEZg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Jeremy Linton <jeremy.linton@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm
 platform device
In-Reply-To: <20251010135922.GC3833649@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com> <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org> <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
Date: Wed, 15 Oct 2025 15:22:28 +0530
Message-ID: <yq5a347kmqzn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Oct 10, 2025 at 07:10:58AM -0500, Jeremy Linton wrote:
>> > Yes, use faux_device if you need/want a struct device to represent
>> > something in the tree and it does NOT have any real platform resources
>> > behind it.  That's explicitly what it was designed for.
>>=20
>> Right, but this code is intended to trigger the kmod/userspace module
>> loader.
>
> Faux devices are not intended to be bound, it says so right on the label:
>
>  * A "simple" faux bus that allows devices to be created and added
>  * automatically to it.  This is to be used whenever you need to create a
>  * device that is not associated with any "real" system resources, and do
>  * not want to have to deal with a bus/driver binding logic.  It is
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>  * intended to be very simple, with only a create and a destroy function
>  * available.
>
> auxiliary_device is quite similar to faux except it is intended to be
> bound to drivers, supports module autoloading and so on.
>
> What you have here is the platform firmware provides the ARM SMC
> (Secure Monitor Call Calling Convention) interface which is a generic
> function call multiplexer between the OS and ARM firmware.
>
> Then we have things like the TSM subsystem that want to load a driver
> to use calls over SMC if the underlying platform firmware supports the
> RSI group of SMC APIs. You'd have a TSM subsystem driver that uses the
> RSI call group over SMC that autobinds when the RSI call group is
> detected when the SMC is first discovered.
>
> So you could use auxiliary_device, you'd consider SMC itself to be the
> shared HW block and all the auxiliary drivers are per-subsystem
> aspects of that shared SMC interface. It is not a terrible fit for
> what it was intended for at least.
>

IIUC, auxiliary_device needs a parent device, and the documentation
explains that it=E2=80=99s intended for cases where a large driver is split=
 into
multiple dependent smaller ones.

If we want to use auxiliary_device for this case, what would serve as
the parent device?

-aneesh

