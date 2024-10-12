Return-Path: <linux-pci+bounces-14405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE8199B581
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 16:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96669B225B4
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6639339ACC;
	Sat, 12 Oct 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4860NO7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360858F66;
	Sat, 12 Oct 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728743484; cv=none; b=TosqJcGqIyxIDTQSAbRvPkkSBkbdIqfwd1IZhwFJZmA234kTKrZJ2F/ZN1RVj8uXO/Go/f/vIFZVrX3e/bLPyI7HUfDpD4ZYVz7lXywZ1Qo6EHCNoZ30QZk3OXc4dn24RJt1c+VB1/6tOwRtEQohye4NwWXvJy2c+5B5zly315U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728743484; c=relaxed/simple;
	bh=OEZ6In6GkYgQcrycvWPs1B+R/1sB9svySFgGOdmlr/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LOfh7PpdKj0go+cQeypSMUZeZ+kCaHFvawR2+e0irXp/HirbFZI1XtNYO9rhG6OOPZKZ5sRP3GvyQpjZ4jeOXxWATndLlpyHCCdbXYXuBx3ICtdgXdPPX7QjEEkT8pMgiXj18A9z5nprKajgpkaBtc300Pf6P1kKr5QsyicJ27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4860NO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD1BC4CEC6;
	Sat, 12 Oct 2024 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728743483;
	bh=OEZ6In6GkYgQcrycvWPs1B+R/1sB9svySFgGOdmlr/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c4860NO71RMJTwQmRNYsGKUTHMpfZle16JeC3H+OEKKWHeJ1C4PcIaKr1iS/4DsMY
	 jyf5iwPeiGzIRMHAsUR3swQR1z8Hj46t+gKR4Ak3OHrQXXuVawLovPXdMrag0s02nO
	 FUTTyq2zDXO6Nx0sCHYYjQPUlT3U261MTOU4cNWeQqDq0VCGMp6KtIIupN8NGKOEtK
	 6Df9wW0ILoW/2QiHyy5EuC4+yTZzCvAtKl/9XvB6RdLAUxswKyrV0vkHu08gi7r/i0
	 kQ5QeRWNkr5zpDvukywruULcxOTB58xHjh8QQDkhXgt/qR+ZRbOIfPlb3V9TxHxrwu
	 xdFIKskYzVecw==
Date: Sat, 12 Oct 2024 09:31:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2] PCI: take the rescan lock when adding devices during
 host probe
Message-ID: <20241012143119.GA604156@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeUW3jsOPTxxu38+w_ps2FQFYR-PmgGY=V+vjnqNs0RYw@mail.gmail.com>

On Thu, Oct 10, 2024 at 11:17:47AM +0200, Bartosz Golaszewski wrote:
> On Thu, Oct 3, 2024 at 10:43 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Since adding the PCI power control code, we may end up with a race
> > between the pwrctl platform device rescanning the bus and the host
> > controller probe function. The latter needs to take the rescan lock when
> > adding devices or we may end up in an undefined state having two
> > incompletely added devices and hit the following crash when trying to
> > remove the device over sysfs:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > Internal error: Oops: 0000000096000004 [#1] SMP
> > Call trace:
> >   __pi_strlen+0x14/0x150
> >   kernfs_find_ns+0x80/0x13c
> >   kernfs_remove_by_name_ns+0x54/0xf0
> >   sysfs_remove_bin_file+0x24/0x34
> >   pci_remove_resource_files+0x3c/0x84
> >   pci_remove_sysfs_dev_files+0x28/0x38
> >   pci_stop_bus_device+0x8c/0xd8
> >   pci_stop_bus_device+0x40/0xd8
> >   pci_stop_and_remove_bus_device_locked+0x28/0x48
> >   remove_store+0x70/0xb0
> >   dev_attr_store+0x20/0x38
> >   sysfs_kf_write+0x58/0x78
> >   kernfs_fop_write_iter+0xe8/0x184
> >   vfs_write+0x2dc/0x308
> >   ksys_write+0x7c/0xec
> >
> > Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> > Tested-by: Konrad Dybcio <konradybcio@kernel.org>
> > Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> 
> It's been a week, so gentle ping - can this be picked up into v6.12?

I hoped we could fix the similar latent issues in other drivers, but
yes, we can get this in v6.12.  Thanks for the hint that it should go
there.  I'll pick it up when I return from vacation on Wednesday.

Bjorn

