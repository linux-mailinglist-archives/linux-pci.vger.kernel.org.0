Return-Path: <linux-pci+bounces-38299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1508CBE1CCB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 08:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CE9188C279
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 06:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66601FECB0;
	Thu, 16 Oct 2025 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7y6jGCi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185B1AF0BB
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597238; cv=none; b=sX24cEJjYVMrPYZRo5hw0OCVQvSX2gzzLC8UTZyVvnaz06ArlpUR35kGkVehweB6tPf0dq8thIcmqe+YwwAPhJ3z+7e9rSg6j5BvGZJoAKnG851T5/9nf2dH4fp/aB9JzHta97oIwb/47qznGzaJs338sb7+8XAoXNtdTj4Lgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597238; c=relaxed/simple;
	bh=izt9ZkFRB355gQZtjFJag0Q84QEoofTBJy9ofvbfAUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ0/rhFvv6Fy0itfbGoP07Hq4VRFEWq3L/aUzbMoNt6sD9ckzI/C5sZ8lXhYNLZ2XSZy3g94kDthws0sIqK07S9hDRlVqERzbvNtAq/vN9VRdem0NBV4tnji//vIitugNhtqhMExuYliLRfUMef5P6hFxER2X4EdWjwR833vXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7y6jGCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19869C4CEF1;
	Thu, 16 Oct 2025 06:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760597238;
	bh=izt9ZkFRB355gQZtjFJag0Q84QEoofTBJy9ofvbfAUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7y6jGCiJXRMvK9si/w0a5xxGSGQqn7X37hueTdWpz8b2rpfumL7nTwbWhz9AMNP2
	 hCV1L+EPDBtckSaF6/Jb4iYGQX0bHX52UyUug0mgqxlv0JXiuptuVVqLuWVy8VeTe/
	 ONZjaZJ4z+t4Fu21erjmIuXzd7YcWRiElidQCunpzjGLYsITU8kRvNXTtPGmcgeuu9
	 52fil7LFj+g/7welq6jae945YZqmsaANmeTzwxrywcVe0jp1LyNzQBA0e7/JiTNa0T
	 Ck6PEcYrjpUrU95xnOWDW7ppEClrne6RzBGYaqo8f3og11G0uPb9X9qk5yprsmaete
	 srBMDFUT1mELg==
Date: Thu, 16 Oct 2025 12:17:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: BAR resizing broken in 6.18 (PPC only?)
Message-ID: <yn2ladybszyrxfridi3z3rx4ogfh6c42bcxq5qld64gul2xltt@6hir2oknxfmg>
References: <f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de>

+ Ilpo

On Thu, Oct 16, 2025 at 12:08:46PM +0900, Simon Richter wrote:
> Hi,
> 
> since switching to 6.18rc1, I get
> 
> xe 0030:03:00.0: enabling device (0140 -> 0142)
> xe 0030:03:00.0: [drm] unbounded parent pci bridge, device won't support any
> PM support.
> xe 0030:03:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
> xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]:
> releasing
> xe 0030:03:00.0: BAR 2 [mem 0x6200000000000-0x620000fffffff 64bit pref]:
> releasing
> pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff 64bit
> pref]: releasing
> pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit
> pref]: releasing
> pci 0030:00:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit
> pref]: was not released (still contains assigned resources)
> pci 0030:02:01.0: disabling bridge window [io  0x0000-0xffffffffffffffff
> disabled] to [bus 03] (unused)
> pci 0030:02:02.0: disabling bridge window [io  0x0000-0xffffffffffffffff
> disabled] to [bus 04] (unused)
> pci 0030:02:02.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff
> 64bit pref disabled] to [bus 04] (unused)
> pci 0030:01:00.0: disabling bridge window [io  0x0000-0xffffffffffffffff
> disabled] to [bus 02-04] (unused)
> pci 0030:00:00.0: Assigned bridge window [mem
> 0x6200000000000-0x6203fbff0ffff 64bit pref] to [bus 01-04] cannot fit
> 0x4000000000 required for 0030:01:00.0 bridging to [bus 02-04]
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref] to [bus
> 02-04] requires relaxed alignment rules
> pci 0030:00:00.0: disabling bridge window [io  0x0000-0xffffffffffffffff
> disabled] to [bus 01-04] (unused)
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: can't
> assign; no space
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: failed
> to assign
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: can't
> assign; no space
> pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: failed
> to assign
> pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: can't
> assign; no space
> pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to
> assign
> pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: can't
> assign; no space
> pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to
> assign
> xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no
> space
> xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
> xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: assigned
> xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]:
> releasing
> xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no
> space
> xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
> xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: assigned
> pci 0030:00:00.0: PCI bridge to [bus 01-04]
> pci 0030:00:00.0:   bridge window [mem 0x620c000000000-0x620c07fefffff]
> pci 0030:00:00.0:   bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit
> pref]
> pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit
> pref]: can't claim; address conflict with 0030:01:00.0 [mem
> 0x6200020000000-0x62000207fffff 64bit pref]
> pci 0030:01:00.0: PCI bridge to [bus 02-04]
> pci 0030:01:00.0:   bridge window [mem 0x620c000000000-0x620c07fefffff]
> pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff 64bit
> pref]: can't claim; no compatible bridge window
> pci 0030:02:01.0: PCI bridge to [bus 03]
> pci 0030:02:01.0:   bridge window [mem 0x620c000000000-0x620c0013fffff]
> xe 0030:03:00.0: [drm] Failed to resize BAR2 to 16384M (-ENOSPC). Consider
> enabling 'Resizable BAR' support in your BIOS
> xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: can't assign; no
> space
> xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: failed to assign
> xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: can't assign; no
> space
> xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: failed to assign
> xe 0030:03:00.0: [drm] Found battlemage (device ID e20b) discrete display
> version 14.01 stepping B0
> xe 0030:03:00.0: [drm] *ERROR* pci resource is not valid
> 
> There's also a bug report[1] on the freedesktop GitLab, but this may be a
> more generic problem.
> 
> I'm unsure what other "assigned resources" would be below the root that are
> not covered by the bridge window of equal size on the upstream port of the
> GPU -- also it would be really cool if it reverted to the old state on
> failure instead of creating an invalid configuration.
> 
> Also, why do we change the BAR assignment while mem decoding is active?
> 

This could be due to the recently merged patch that changes the way we read
bridge resources. We saw a similar bug report with Qcom platforms as well [1].a43ac325c7cb

Could you please try reverting the below mentioned commit and see if that fixes
the issue?

a43ac325c7cb ("PCI: Set up bridge resources earlier")

- Mani

[1] https://lore.kernel.org/lkml/017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool

-- 
மணிவண்ணன் சதாசிவம்

