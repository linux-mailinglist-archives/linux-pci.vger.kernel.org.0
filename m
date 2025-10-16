Return-Path: <linux-pci+bounces-38292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CDFBE153D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 05:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011CA3B6B9A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 03:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BACE1494DB;
	Thu, 16 Oct 2025 03:08:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771347260F
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584138; cv=none; b=dc9fpqIRYDBgAc/k4JTDjg+wbvbPJgpEleCLLwvBorJrQEdYsUSh481Yxixkp3WDVXYJV5rq8ql+9ly7ghpkPtfMI4VeL7hZ1hg4nXiYjWabnuyckP24JyW2hqG+dg2M85nELeEif7YDGC11QKhWxAasBfrOA55gQzBtVDlzNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584138; c=relaxed/simple;
	bh=a/FCPBgNy258nV6irmGGfP+jCcrjbLE1XvgCYmSeXWM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pL/nFYrzuC0ETNKKYrxR+PmdQl1238Qaa1M/vY6V4l3scfbBcsVuMUNqe5HUR+8HEdKqcsyYVAVAC/aO8AlAsmI4JDiLAe8fLMZ5UAeEN5rpgis++Ak+wJSEV+v76i35Vvn1nxXQprFRIyFCWmuk2vQO3KE/iUSQ8T9WX9Bg6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 2BE6C3F0F9;
	Thu, 16 Oct 2025 05:08:48 +0200 (CEST)
Message-ID: <f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de>
Date: Thu, 16 Oct 2025 12:08:46 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: BAR resizing broken in 6.18 (PPC only?)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

since switching to 6.18rc1, I get

xe 0030:03:00.0: enabling device (0140 -> 0142)
xe 0030:03:00.0: [drm] unbounded parent pci bridge, device won't support 
any PM support.
xe 0030:03:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: 
releasing
xe 0030:03:00.0: BAR 2 [mem 0x6200000000000-0x620000fffffff 64bit pref]: 
releasing
pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff 
64bit pref]: releasing
pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 
64bit pref]: releasing
pci 0030:00:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 
64bit pref]: was not released (still contains assigned resources)
pci 0030:02:01.0: disabling bridge window [io  0x0000-0xffffffffffffffff 
disabled] to [bus 03] (unused)
pci 0030:02:02.0: disabling bridge window [io  0x0000-0xffffffffffffffff 
disabled] to [bus 04] (unused)
pci 0030:02:02.0: disabling bridge window [mem 
0x00000000-0xffffffffffffffff 64bit pref disabled] to [bus 04] (unused)
pci 0030:01:00.0: disabling bridge window [io  0x0000-0xffffffffffffffff 
disabled] to [bus 02-04] (unused)
pci 0030:00:00.0: Assigned bridge window [mem 
0x6200000000000-0x6203fbff0ffff 64bit pref] to [bus 01-04] cannot fit 
0x4000000000 required for 0030:01:00.0 bridging to [bus 02-04]
pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref] to 
[bus 02-04] requires relaxed alignment rules
pci 0030:00:00.0: disabling bridge window [io  0x0000-0xffffffffffffffff 
disabled] to [bus 01-04] (unused)
pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: 
can't assign; no space
pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: 
failed to assign
pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: 
can't assign; no space
pci 0030:01:00.0: bridge window [mem size 0x3fc0000000 64bit pref]: 
failed to assign
pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: can't 
assign; no space
pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: 
failed to assign
pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: can't 
assign; no space
pci 0030:02:01.0: bridge window [mem size 0x400000000 64bit pref]: 
failed to assign
xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; 
no space
xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: assigned
xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: 
releasing
xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; 
no space
xe 0030:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: assigned
pci 0030:00:00.0: PCI bridge to [bus 01-04]
pci 0030:00:00.0:   bridge window [mem 0x620c000000000-0x620c07fefffff]
pci 0030:00:00.0:   bridge window [mem 0x6200000000000-0x6203fbff0ffff 
64bit pref]
pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 
64bit pref]: can't claim; address conflict with 0030:01:00.0 [mem 
0x6200020000000-0x62000207fffff 64bit pref]
pci 0030:01:00.0: PCI bridge to [bus 02-04]
pci 0030:01:00.0:   bridge window [mem 0x620c000000000-0x620c07fefffff]
pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff 
64bit pref]: can't claim; no compatible bridge window
pci 0030:02:01.0: PCI bridge to [bus 03]
pci 0030:02:01.0:   bridge window [mem 0x620c000000000-0x620c0013fffff]
xe 0030:03:00.0: [drm] Failed to resize BAR2 to 16384M (-ENOSPC). 
Consider enabling 'Resizable BAR' support in your BIOS
xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: can't assign; 
no space
xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: failed to assign
xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: can't assign; 
no space
xe 0030:03:00.0: BAR 2 [mem size 0x10000000 64bit pref]: failed to assign
xe 0030:03:00.0: [drm] Found battlemage (device ID e20b) discrete 
display version 14.01 stepping B0
xe 0030:03:00.0: [drm] *ERROR* pci resource is not valid

There's also a bug report[1] on the freedesktop GitLab, but this may be 
a more generic problem.

I'm unsure what other "assigned resources" would be below the root that 
are not covered by the bridge window of equal size on the upstream port 
of the GPU -- also it would be really cool if it reverted to the old 
state on failure instead of creating an invalid configuration.

Also, why do we change the BAR assignment while mem decoding is active?

    Simon

[1] https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6356

