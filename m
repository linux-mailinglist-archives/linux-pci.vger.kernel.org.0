Return-Path: <linux-pci+bounces-28396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD7AC39A9
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 08:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA6D17156A
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 06:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECCA1D516A;
	Mon, 26 May 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPwjqsWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0151C84BB;
	Mon, 26 May 2025 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239762; cv=none; b=RLoFpotIyHeZ2oXCUG/f98ZdTeTNozlimNHTSFn0z7HHH2mtxCZl1XKoetEqfzvzOnpkwf84lGPnOlh0c+N5ar0uQQUTGMu992APD4ZzVu4aDVOEiyuF9BX9VA7cevr56g1V6RYOW+FGShigIvWVM1so7To0Ha7YoQcwALw400s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239762; c=relaxed/simple;
	bh=/RhfTh7WXrowY7bL9VrQJTIAycnFG7ft7ht4TEKQWSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYVeLVyyVVF/fhJlW8jyVGe08iHdc0eHt64ILcpXEWUzD1OzBr6NL4rUbL/4mvUsRC5arz7Tsl0mcNt8a9txWAnjNBwuLMU486o9dChUxnhoB2/p/IZJ2YEatgd56nBdclpm0CaJbo9gq0q6aitS1uq9ysm6n9Fz7rhWe0WjkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPwjqsWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C98C4CEE7;
	Mon, 26 May 2025 06:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748239761;
	bh=/RhfTh7WXrowY7bL9VrQJTIAycnFG7ft7ht4TEKQWSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CPwjqsWbIZzw3t4ZVlTqgsjNfu+aBfsYTPNX7Bw61BFGo8HYZ3PZ2raY3V0We+6cc
	 SDQyF/8PzDmwHYJnB6L4HvuUTz6v5uDZoNwN9JB7+95BcZDfuXmf55tdk0gXVz+a0k
	 WHk600jyevALylfTWY/tGEnYe4vZsx5C+Hp4k1Jhl/FVRrmniL4hgyUFGoluoLXJ2j
	 uURbWQ+KBqOoxktHftIrNNas/vAsWdVXSHcFM3LJdY4WYiqr2NCTGRwiorkbhylFM0
	 P5379fd8OSF4pYIs86ii1vDOd9MeMgYSqz8FcuY5Z+ZUq6IO41RAEA7aharWdHuUnX
	 s3TzyKznW2fTA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 Q)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	aik@amd.com, jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
In-Reply-To: <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
Date: Mon, 26 May 2025 10:35:10 +0530
Message-ID: <yq5aa570dks9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xu Yilun <yilun.xu@linux.intel.com> writes:

> On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>=20
>> > On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>> >> From: Xu Yilun <yilun.xu@linux.intel.com>
>> >>=20
>> >> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>> >>=20
>> >> pci_tsm_bind/unbind() are supposed to be called by kernel components
>> >> which manages the virtual device. The verb 'bind' means VMM does extra
>> >> configurations to make the assigned device ready to be validated by
>> >> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>> >> include assigning device ownership and MMIO ownership to CoCo VM, and
>> >> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>> >> TDISP message. The detailed operations are specific to platform TSM
>> >> firmware so need to be supported by vendor TSM drivers.
>> >>=20
>> >> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>> >> to TSM firmware about further TDI operations after TDI is bound, e.g.
>> >> get device interface report, certifications & measurements. So this k=
API
>> >> is supposed to be called from KVM vmexit handler.
>> >
>> > To clarify, this commit message is staled. We are proposing existing to
>> > QEMU, then pass to TSM through IOMMUFD VDEVICE.
>> >
>>=20
>> Can you share the POC code/git repo implementing that? I am looking for
>> pci_tsm_bind()/pci_tsm_unbind() example usage.
>
> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
> Stage 2 patchset. I need to rebase this series, adopt suggestions from
> Jason, and make TDX Connect work to verify, so need more time...
>

Since the bind/unbind operations are PCI-specific callbacks, and iommufd
doesn=E2=80=99t seem to have a PCI-specific abstraction layer (unlike vfio,
which uses vfio_pci.c), I=E2=80=99m wondering how iommufd intends to support
PCI-specific TSM binding. Will there be a new interface for this, or is
it expected to hook into something existing?

-aneesh

