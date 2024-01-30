Return-Path: <linux-pci+bounces-2829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04FE842CC1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C121F25ECB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01F7B3CD;
	Tue, 30 Jan 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGQK5tqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3C7B3C2
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642939; cv=none; b=kxYiiMlf03S0ddog6Q+Y5nHcBRlDaupLguN76O2CU/HsEL+kfgkaoXfsX2IXL5MStGkni27cviOJGAL1lI/GgonlPy6COcMhfQKrVrKNaMo4g8ttMWwYyL9C7j4zQlrb4yMLusPTSVE34me83OZItRbFzPfV8j5xlXBrc1eSwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642939; c=relaxed/simple;
	bh=ONnvffc1UahhL4JXExlFCCFho+8JvoDfBOBbjV0BCgE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C7Nwo1cSC6MfvcobtvFQfYr1fKL96672DZbsegCmrFUtHVyV+VMFY3rTIig2jknXM9ktI5PGQQT+NBIvz0nRzD1yPFIxU4WDmr8fM6q+mQMi9P3h4V5EJfEk1J5gInIWMlmOVxYnuUu0eImndPf/oWimIHXfvYEhNPwVCCy3sW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGQK5tqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760AAC433F1;
	Tue, 30 Jan 2024 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706642938;
	bh=ONnvffc1UahhL4JXExlFCCFho+8JvoDfBOBbjV0BCgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tGQK5tqVI4lQg0gvJXxkKJQy+dZyYLWpAJGmy2RPRcqirFFGle4Z4ikSM9+XnwcRv
	 qiUO6fRzF+GOcIq/5tT87WoommYnp4rpoBgx/AL6d20LikIXouPMEQvWrPH3izkydt
	 BdBWEadmvjTGWDT2WYht8HClVDVn2Ck4/JHzksETbfxMzPsh7AaNDTmiC9H6a52wU5
	 UckaxKZbMGvD2CUO8IUsQ7zH4zDQEK45FZw/0SOX8+98tvVPyVkNydO/r7dBqHn+5H
	 kG9QiEnNiwI3+TfCZG7UnJ9JTvDFQZIGinzwTpMvDSvJQscFw9F7i4r5lxvLfYlbbB
	 3nXNd+SXut34w==
Date: Tue, 30 Jan 2024 13:28:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: aravind <aravindk20@gmail.com>
Cc: linux-pci@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: memory access to mmaped pci sysfs file, does not fail when the
 pci device is removed.
Message-ID: <20240130192856.GA527632@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAgyjC9ttHQxodPsVcrNKx2_2T9FTy_E6wZf_u3QbqGGs82P_w@mail.gmail.com>

[+cc Daniel (author of 74b30195395c), Greg]

On Tue, Jan 30, 2024 at 08:50:10AM +0530, aravind wrote:
> Hi,
>  I am facing an issue in v5.15 kernel due to " [PATCH v7 12/17] PCI:
> Revoke mappings like devmem "related changes.
>  Whenever a PCI device (4f:00.0)is removed while being accessed from
> user space (mmaped (sys/bus/pci/device/....4f:00.0/resource0)), no sig
> bus error is raised. in earlier kernel v5.2, a sig bus error used to
> get generated for this scenario.
> In v5.15 5 kernel , value 0xffffffff is returned when the device is
> plugged out or it is reset.
> if the device is removed through "echo 1 >
> /sys/bus/pci/devices/..4f:00.0/remove") command. user space code is
> still able to access device memory no fault is generated in this case.
> not sure if this is expected behavior. as the file which is mapped is
> removed .(/sys/bus/pci/.../resource0)
> 
> After making the below change in v5.15 , I am able to get fault for
> above scenarios. (device removal or unplug/reset.)
> Please let me know if this is a new feature introduced to handle
> mmaped memory access holes ? and allow to work inspite of sysfs files
> removal.
> 
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index d019d6ac6ad0..5f9b59ba8320 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -251,7 +251,7 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
>         .read           = sysfs_kf_bin_read,
>         .write          = sysfs_kf_bin_write,
>         .mmap           = sysfs_kf_bin_mmap,
> -       .open           = sysfs_kf_bin_open,
> +//     .open           = sysfs_kf_bin_open,
>  };

If the change above makes the difference, I guess the change might be
related to https://git.kernel.org/linus/74b30195395c ("sysfs: Support
zapping of binary attr mmaps"), which appeared in v5.12.

I agree that SIGBUS when accessing MMIO space of a device that has
been removed sounds like a better experience than reading 0xffffffff.

I don't know enough about the VM side of this to know just how
74b30195395c makes this difference.  Maybe Daniel will chime in.

Bjorn

