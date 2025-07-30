Return-Path: <linux-pci+bounces-33157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9BAB15AD1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 10:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C38116AA27
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0226B230981;
	Wed, 30 Jul 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go8lp2CB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7F481A3;
	Wed, 30 Jul 2025 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864954; cv=none; b=ao9hsAV+jo0qO+NK4IE3kB8V/o+dr62eMx3nnWcm73hRsTsthuRE+elE/5KBiqDRpFMuG3kizVOwunNpbQclAGIgQ/y5CW4zK7AqW5g8b7kmtarHTh2qIwClooPuTZMUF4B/u4Hd+ToHCyPRyqI0DKomXkGGMgKmwWkgpj+MfmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864954; c=relaxed/simple;
	bh=9jwGQtcgoGblfYqhXaAV67vOauoqIhza/+dVv/5EcsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XKhRyifYjJUFRTMgZ7YxjkwQN0K6GJ8kMgOdr4K6jDHAWf57h5Om0RAchhmI4L38Nof4v0/Nd0LqNASnkKzBPInfQl1hQm3Ki7XluZdJzDD1j3QgrmCstYm5bGOlhxHETtOw41ryzA0um1KEEKaFUFdzzLj8gY/KcJWshFBdlsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go8lp2CB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D109FC4CEE7;
	Wed, 30 Jul 2025 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753864954;
	bh=9jwGQtcgoGblfYqhXaAV67vOauoqIhza/+dVv/5EcsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Go8lp2CB+T4l9aWV40JjIjQz9FZO4AywDWuWNCU9YvLYUMCIrudTSDfUtpXxKdjM7
	 5hgXa8GNJVppkhYV0Ixfxvw5FkHx8HfzQ9WdE8a8ADFQPdA0cEF5Yo5wAwyAXjub3t
	 Awtm059fx20HyRQ6CIsralMYLVrmwBrNe4pcVGfgtieQS6wTaIcwuk1BcEX4EHX9ML
	 26i1IGSdOd9CsoofII7f+W+9Ic7Di/gU6VnwZZOXLZBpGUYC9GO1yRQqXMKkNDU7vM
	 uUrZJ1Mde6gytUo4MUD+lV5Vr+7xPSg0lbwTjUEFng6h3nssvndNAKV40CT0TAPXug
	 7/HOZgOVF4g/g==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm
 platform device
In-Reply-To: <20250729231948.GJ26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com> <20250729231948.GJ26511@ziepe.ca>
Date: Wed, 30 Jul 2025 14:12:26 +0530
Message-ID: <yq5aqzxy9ij1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
>
>> > +static struct platform_device cca_host_dev = {
>> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
>> platform devices being registered with no underlying resources etc as glue
>> layers.  Maybe some of that will come later.
>
> Is faux_device a better choice? I admit to not knowing entirely what
> it is for..
>
> But alternatively, why do we need a dummy "hw" struct device at all?
> Typically a subsystem like TSM should be structured to create its own
> struct devices..
>
> I would expect this to just call 'register tsm' ?
>

The goal is to have tsm class device to be parented by the platform
device.

# ls -al
total 0
drwxr-xr-x    2 root     root             0 Jan 13 06:07 .
drwxr-xr-x   23 root     root             0 Jan  1 00:00 ..
lrwxrwxrwx    1 root     root             0 Jan 13 06:07 tsm0 -> ../../devices/platform/arm-rmi-dev/tsm/tsm0
# pwd
/sys/class/tsm

-aneesh

