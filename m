Return-Path: <linux-pci+bounces-41016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 83324C54417
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 20:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0005334B82E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA0248F7C;
	Wed, 12 Nov 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6QvYVF9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131AB663
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976683; cv=none; b=X0c5FPa4IbQgMH2NJ6j2k2JQ2znY2TFr1E71D9u6yMLt88PQO8rhy8Y4dkfNqeCsum+Qk1qeYvw8L/QbK0lscktUYKUwN4vJlpD1TuvmI8kV+0UVt6Lb+f7qtchhpObrxdu/h1CxTdM9yfuS6aVu6PYiHb6UFNFKMxHqNj0BP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976683; c=relaxed/simple;
	bh=/IKNkoEr6yRtPzjjEbHpE2rnc1KUK+AE/yrK+Lm+0kM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WFdArksGRuZ7Q2e6H7dnePu3B3jU9rLh1QQ6JLlMEv4PTzwNkvUdRr1/GiFCNZOB6mIjGsJYvgXfySJ7Ee2zF/KulKNOXGg9Lt7Rmz4/oJLfuBoh2C3medhfz+aDsXy8MVnwJiyYgNS/TMjyl4Tf4S72guf1TkDIIwK3eDVRxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6QvYVF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268CEC16AAE;
	Wed, 12 Nov 2025 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762976683;
	bh=/IKNkoEr6yRtPzjjEbHpE2rnc1KUK+AE/yrK+Lm+0kM=;
	h=Date:From:To:Cc:Subject:From;
	b=u6QvYVF9gCv7uvKgAQ3NplU9BP75uDBmzrsqPfAsqXvyWnwYGyIQTKSj/xkcgGeTG
	 AFP1Phza83mRMI04mhDqLsV0IeFwewkMdD6VrGWMhyc66uz2h/5joghx3s2zeLqMLQ
	 8gvHe149YSwzNqtMUvQuZVE8Ir0xTB7M4Sam31EcgaBLzUqoeRtKPLJFCIeNqm2S+5
	 P4U77WeFreSzmiNmKIvIdlMjVTGH/W1hKXpmc8Kh1e/eDwL2LITGEUHPvN2QlGdflc
	 uJSM9WmMupvGQUJFspLKIIhLznB9YTX27fMWxXSkbIzsjWFVGVEFty0/ABT8+Sw0aD
	 ZaqUNY8PTW1Zw==
Date: Wed, 12 Nov 2025 13:44:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: [bugzilla-daemon@kernel.org: [Bug 220775] snd_ctxfi fails init since
 6.18-rc1]
Message-ID: <20251112194441.GA2238830@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[+cc Ilpo, reporter in bcc]

https://bugzilla.kernel.org/show_bug.cgi?id=220775

> Hi, since 6.18-rc1 ctxfi doesn't work anymore. On module load I get:
> [   18.558124] snd_ctxfi 0000:11:00.0: chip 20K2 model SB0880 (1102:0043) is found
> [   18.558239] snd_ctxfi 0000:11:00.0: Something wrong!!!
> [   18.558243] snd_ctxfi 0000:11:00.0: probe with driver snd_ctxfi failed with error -2
> 
> I first noticed with -rc5, but can reproduce in -rc1. Tried to
> bisect, but I get into issues where the system wouldn't even boot.

#regzbot title: snd_ctxfi fails init; failed to assign BAR
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=220775
#regzbot introduced: 3a8660878839

3a8660878839 ("Linux 6.18-rc1")

Dmesg of working v6.17.7 and broken v6.18-rc5 attached to the
bugzilla.  PCI-related excerpts from:

  $ diff -U 10000  dmesg_6.17.7 dmesg_6.18-rc5-mod | grep 0000:

--- dmesg_6.17.7        2025-11-12 13:28:34.908809832 -0600
+++ dmesg_6.18-rc5-mod  2025-11-12 13:28:28.184783933 -0600

 PCI host bridge to bus 0000:00
 pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
 pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
 pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
 pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
 pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
 pci_bus 0000:00: root bus resource [mem 0xa0000000-0xdfffffff window]
 pci_bus 0000:00: root bus resource [mem 0x1060000000-0xffffffffff window]
 pci_bus 0000:00: root bus resource [bus 00-ff]
 pci 0000:00:00.0: [1022:14d8] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:00.2: [1022:14d9] type 00 class 0x080600 conventional PCI endpoint
 pci 0000:00:01.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:01.1: [1022:14db] type 01 class 0x060400 PCIe Root Port
 pci 0000:00:01.1: PCI bridge to [bus 01-03]
 pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
 pci 0000:00:01.1:   bridge window [mem 0xde700000-0xde8fffff]
 pci 0000:00:01.1:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
 pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
 pci 0000:00:01.2: [1022:14db] type 01 class 0x060400 PCIe Root Port
 pci 0000:00:01.2: PCI bridge to [bus 04]
 pci 0000:00:01.2:   bridge window [mem 0xdea00000-0xdeafffff]
 pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
 pci 0000:00:02.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:02.1: [1022:14db] type 01 class 0x060400 PCIe Root Port
 pci 0000:00:02.1: PCI bridge to [bus 05-16]
 pci 0000:00:02.1:   bridge window [io  0xd000-0xefff]
 pci 0000:00:02.1:   bridge window [mem 0xd8000000-0xde1fffff]
 pci 0000:00:02.1: enabling Extended Tags
 pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
 pci 0000:00:02.2: [1022:14db] type 01 class 0x060400 PCIe Root Port
 pci 0000:00:02.2: PCI bridge to [bus 17-7a]
 pci 0000:00:02.2:   bridge window [io  0x7000-0xcfff]
 pci 0000:00:02.2:   bridge window [mem 0xa4000000-0xd47fffff]
 pci 0000:00:02.2:   bridge window [mem 0xb800000000-0xf7ffffffff 64bit pref]
 pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
 pci 0000:00:03.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:04.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:08.0: [1022:14da] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:08.1: [1022:14dd] type 01 class 0x060400 PCIe Root Port
 pci 0000:00:08.1: PCI bridge to [bus 7b]
 pci 0000:00:08.1:   bridge window [mem 0xde300000-0xde6fffff]
 pci 0000:00:08.1: enabling Extended Tags
 pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
 pci 0000:00:08.3: [1022:14dd] type 01 class 0x060400 PCIe Root Port
 pci 0000:00:08.3: PCI bridge to [bus 7c]
 pci 0000:00:08.3:   bridge window [mem 0xde900000-0xde9fffff]
 pci 0000:00:08.3: enabling Extended Tags
 pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
 pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
 pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
 pci 0000:00:18.0: [1022:14e0] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:18.1: [1022:14e1] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:18.2: [1022:14e2] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:18.3: [1022:14e3] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:18.4: [1022:14e4] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:18.5: [1022:14e5] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:18.6: [1022:14e6] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:00:18.7: [1022:14e7] type 00 class 0x060000 conventional PCI endpoint
 pci 0000:01:00.0: [1002:1478] type 01 class 0x060400 PCIe Switch Upstream Port
 pci 0000:01:00.0: BAR 0 [mem 0xde800000-0xde803fff]
 pci 0000:01:00.0: PCI bridge to [bus 02-03]
 pci 0000:01:00.0:   bridge window [io  0xf000-0xffff]
 pci 0000:01:00.0:   bridge window [mem 0xde700000-0xde7fffff]
 pci 0000:01:00.0:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
 pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:00:01.1: PCI bridge to [bus 01-03]
 pci 0000:02:00.0: [1002:1479] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:02:00.0: PCI bridge to [bus 03]
 pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
 pci 0000:02:00.0:   bridge window [mem 0xde700000-0xde7fffff]
 pci 0000:02:00.0:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
 pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:01:00.0: PCI bridge to [bus 02-03]
 pci 0000:03:00.0: [1002:7550] type 00 class 0x030000 PCIe Legacy Endpoint
 pci 0000:03:00.0: BAR 0 [mem 0xf800000000-0xfbffffffff 64bit pref]
 pci 0000:03:00.0: BAR 2 [mem 0xfc00000000-0xfc0fffffff 64bit pref]
 pci 0000:03:00.0: BAR 4 [io  0xf000-0xf0ff]
 pci 0000:03:00.0: BAR 5 [mem 0xde700000-0xde77ffff]
 pci 0000:03:00.0: ROM [mem 0xde780000-0xde79ffff pref]
 pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
 pci 0000:03:00.1: [1002:ab40] type 00 class 0x040300 PCIe Legacy Endpoint
 pci 0000:03:00.1: BAR 0 [mem 0xde7a0000-0xde7a3fff]
 pci 0000:03:00.1: PME# supported from D1 D2 D3hot D3cold
 pci 0000:02:00.0: PCI bridge to [bus 03]
 pci 0000:04:00.0: [144d:a80c] type 00 class 0x010802 PCIe Endpoint
 pci 0000:04:00.0: BAR 0 [mem 0xdea00000-0xdea03fff 64bit]
 pci 0000:00:01.2: PCI bridge to [bus 04]
 pci 0000:05:00.0: [1022:43f4] type 01 class 0x060400 PCIe Switch Upstream Port
 pci 0000:05:00.0: PCI bridge to [bus 06-16]
 pci 0000:05:00.0:   bridge window [io  0xd000-0xefff]
 pci 0000:05:00.0:   bridge window [mem 0xd8000000-0xde1fffff]
 pci 0000:05:00.0: enabling Extended Tags
 pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:00:02.1: PCI bridge to [bus 05-16]
 pci 0000:06:00.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:06:00.0: PCI bridge to [bus 07]
 pci 0000:06:00.0:   bridge window [mem 0xde100000-0xde1fffff]
 pci 0000:06:00.0: enabling Extended Tags
 pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:04.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:06:04.0: PCI bridge to [bus 08]
 pci 0000:06:04.0: enabling Extended Tags
 pci 0000:06:04.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:05.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:06:05.0: PCI bridge to [bus 09]
 pci 0000:06:05.0: enabling Extended Tags
 pci 0000:06:05.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:06.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:06:06.0: PCI bridge to [bus 0a]
 pci 0000:06:06.0:   bridge window [io  0xe000-0xefff]
 pci 0000:06:06.0:   bridge window [mem 0xde000000-0xde0fffff]
 pci 0000:06:06.0: enabling Extended Tags
 pci 0000:06:06.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:07.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:06:07.0: PCI bridge to [bus 0b]
 pci 0000:06:07.0:   bridge window [mem 0xdda00000-0xddcfffff]
 pci 0000:06:07.0: enabling Extended Tags
 pci 0000:06:07.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:08.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:06:08.0: PCI bridge to [bus 0c-14]
 pci 0000:06:08.0:   bridge window [io  0xd000-0xdfff]
 pci 0000:06:08.0:   bridge window [mem 0xd8000000-0xdd7fffff]
 pci 0000:06:08.0: enabling Extended Tags
 pci 0000:06:08.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:0c.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:06:0c.0: PCI bridge to [bus 15]
 pci 0000:06:0c.0:   bridge window [mem 0xddf00000-0xddffffff]
 pci 0000:06:0c.0: enabling Extended Tags
 pci 0000:06:0c.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:0d.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:06:0d.0: PCI bridge to [bus 16]
 pci 0000:06:0d.0:   bridge window [mem 0xdde00000-0xddefffff]
 pci 0000:06:0d.0: enabling Extended Tags
 pci 0000:06:0d.0: PME# supported from D0 D3hot D3cold
 pci 0000:05:00.0: PCI bridge to [bus 06-16]
 pci 0000:07:00.0: [144d:a80c] type 00 class 0x010802 PCIe Endpoint
 pci 0000:07:00.0: BAR 0 [mem 0xde100000-0xde103fff 64bit]
 pci 0000:07:00.0: enabling Extended Tags
 pci 0000:06:00.0: PCI bridge to [bus 07]
 pci 0000:06:04.0: PCI bridge to [bus 08]
 pci 0000:06:05.0: PCI bridge to [bus 09]
 pci 0000:0a:00.0: [10ec:8126] type 00 class 0x020000 PCIe Endpoint
 pci 0000:0a:00.0: BAR 0 [io  0xe000-0xe0ff]
 pci 0000:0a:00.0: BAR 2 [mem 0xde000000-0xde00ffff 64bit]
 pci 0000:0a:00.0: BAR 4 [mem 0xde010000-0xde013fff 64bit]
 pci 0000:0a:00.0: supports D1 D2
 pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
 pci 0000:06:06.0: PCI bridge to [bus 0a]
 pci 0000:0b:00.0: [14c3:0717] type 00 class 0x028000 PCIe Endpoint
 pci 0000:0b:00.0: BAR 0 [mem 0xdda00000-0xddbfffff 64bit]
 pci 0000:0b:00.0: BAR 2 [mem 0xddc00000-0xddc07fff 64bit]
 pci 0000:0b:00.0: enabling Extended Tags
 pci 0000:0b:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:07.0: PCI bridge to [bus 0b]
 pci 0000:0c:00.0: [1022:43f4] type 01 class 0x060400 PCIe Switch Upstream Port
 pci 0000:0c:00.0: PCI bridge to [bus 0d-14]
 pci 0000:0c:00.0:   bridge window [io  0xd000-0xdfff]
 pci 0000:0c:00.0:   bridge window [mem 0xd8000000-0xdd7fffff]
 pci 0000:0c:00.0: enabling Extended Tags
 pci 0000:0c:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:08.0: PCI bridge to [bus 0c-14]
 pci 0000:0d:00.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:0d:00.0: PCI bridge to [bus 0e]
 pci 0000:0d:00.0: enabling Extended Tags
 pci 0000:0d:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:0d:04.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:0d:04.0: PCI bridge to [bus 0f]
 pci 0000:0d:04.0:   bridge window [mem 0xdc800000-0xdd1fffff]
 pci 0000:0d:04.0: enabling Extended Tags
 pci 0000:0d:04.0: PME# supported from D0 D3hot D3cold
 pci 0000:0d:06.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:0d:06.0: PCI bridge to [bus 10]
 pci 0000:0d:06.0:   bridge window [io  0xd000-0xdfff]
 pci 0000:0d:06.0:   bridge window [mem 0xdd700000-0xdd7fffff]
 pci 0000:0d:06.0: enabling Extended Tags
 pci 0000:0d:06.0: PME# supported from D0 D3hot D3cold
 pci 0000:0d:07.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:0d:07.0: PCI bridge to [bus 11]
 pci 0000:0d:07.0:   bridge window [mem 0xd8000000-0xdc2fffff]
 pci 0000:0d:07.0: enabling Extended Tags
 pci 0000:0d:07.0: PME# supported from D0 D3hot D3cold
 pci 0000:0d:08.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:0d:08.0: PCI bridge to [bus 12]
 pci 0000:0d:08.0:   bridge window [mem 0xdd600000-0xdd6fffff]
 pci 0000:0d:08.0: enabling Extended Tags
 pci 0000:0d:08.0: PME# supported from D0 D3hot D3cold
 pci 0000:0d:0c.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:0d:0c.0: PCI bridge to [bus 13]
 pci 0000:0d:0c.0:   bridge window [mem 0xdd500000-0xdd5fffff]
 pci 0000:0d:0c.0: enabling Extended Tags
 pci 0000:0d:0c.0: PME# supported from D0 D3hot D3cold
 pci 0000:0d:0d.0: [1022:43f5] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:0d:0d.0: PCI bridge to [bus 14]
 pci 0000:0d:0d.0:   bridge window [mem 0xdd300000-0xdd4fffff]
 pci 0000:0d:0d.0: enabling Extended Tags
 pci 0000:0d:0d.0: PME# supported from D0 D3hot D3cold
 pci 0000:0c:00.0: PCI bridge to [bus 0d-14]
 pci 0000:0d:00.0: PCI bridge to [bus 0e]
 pci 0000:0f:00.0: [15b3:1003] type 00 class 0x020000 PCIe Endpoint
 pci 0000:0f:00.0: BAR 0 [mem 0xdd100000-0xdd1fffff 64bit]
 pci 0000:0f:00.0: BAR 2 [mem 0xdc800000-0xdcffffff 64bit pref]
 pci 0000:0f:00.0: ROM [mem 0xdd000000-0xdd0fffff pref]
 pci 0000:0f:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:0d:04.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
 pci 0000:0d:04.0: PCI bridge to [bus 0f]
 pci 0000:10:00.0: [1b21:0612] type 00 class 0x010601 PCIe Legacy Endpoint
 pci 0000:10:00.0: BAR 0 [io  0xd050-0xd057]
 pci 0000:10:00.0: BAR 1 [io  0xd040-0xd043]
 pci 0000:10:00.0: BAR 2 [io  0xd030-0xd037]
 pci 0000:10:00.0: BAR 3 [io  0xd020-0xd023]
 pci 0000:10:00.0: BAR 4 [io  0xd000-0xd01f]
 pci 0000:10:00.0: BAR 5 [mem 0xdd700000-0xdd7001ff]
 pci 0000:0d:06.0: PCI bridge to [bus 10]
 pci 0000:11:00.0: [1102:000b] type 00 class 0x040300 PCIe Endpoint
 pci 0000:11:00.0: BAR 0 [mem 0xdc200000-0xdc20ffff 64bit]
 pci 0000:11:00.0: BAR 2 [mem 0xdc000000-0xdc1fffff 64bit]
 pci 0000:11:00.0: BAR 4 [mem 0xd8000000-0xdbffffff 64bit]
 pci 0000:0d:07.0: PCI bridge to [bus 11]
 pci 0000:12:00.0: [144d:a80a] type 00 class 0x010802 PCIe Endpoint
 pci 0000:12:00.0: BAR 0 [mem 0xdd600000-0xdd603fff 64bit]
 pci 0000:12:00.0: enabling Extended Tags
 pci 0000:0d:08.0: PCI bridge to [bus 12]
 pci 0000:13:00.0: [1022:43fd] type 00 class 0x0c0330 PCIe Legacy Endpoint
 pci 0000:13:00.0: BAR 0 [mem 0xdd500000-0xdd507fff 64bit]
 pci 0000:13:00.0: enabling Extended Tags
 pci 0000:13:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:0d:0c.0: PCI bridge to [bus 13]
 pci 0000:14:00.0: [1022:43f6] type 00 class 0x010601 PCIe Legacy Endpoint
 pci 0000:14:00.0: BAR 5 [mem 0xdd380000-0xdd3803ff]
 pci 0000:14:00.0: ROM [mem 0xdd300000-0xdd37ffff pref]
 pci 0000:14:00.0: enabling Extended Tags
 pci 0000:14:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:0d:0d.0: PCI bridge to [bus 14]
 pci 0000:15:00.0: [1022:43fd] type 00 class 0x0c0330 PCIe Legacy Endpoint
 pci 0000:15:00.0: BAR 0 [mem 0xddf00000-0xddf07fff 64bit]
 pci 0000:15:00.0: enabling Extended Tags
 pci 0000:15:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:0c.0: PCI bridge to [bus 15]
 pci 0000:16:00.0: [1022:43f6] type 00 class 0x010601 PCIe Legacy Endpoint
 pci 0000:16:00.0: BAR 5 [mem 0xdde80000-0xdde803ff]
 pci 0000:16:00.0: ROM [mem 0xdde00000-0xdde7ffff pref]
 pci 0000:16:00.0: enabling Extended Tags
 pci 0000:16:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:06:0d.0: PCI bridge to [bus 16]
 pci 0000:17:00.0: [1b21:2421] type 01 class 0x060400 PCIe Switch Upstream Port
 pci 0000:17:00.0: PCI bridge to [bus 18-7a]
 pci 0000:17:00.0:   bridge window [io  0x7000-0xcfff]
 pci 0000:17:00.0:   bridge window [mem 0xa4000000-0xd47fffff]
 pci 0000:17:00.0:   bridge window [mem 0xb800000000-0xf7ffffffff 64bit pref]
 pci 0000:17:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:00:02.2: PCI bridge to [bus 17-7a]
 pci 0000:18:00.0: [1b21:2423] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:18:00.0: PCI bridge to [bus 19-48]
 pci 0000:18:00.0:   bridge window [io  0xa000-0xcfff]
 pci 0000:18:00.0:   bridge window [mem 0xbc000000-0xd3ffffff]
 pci 0000:18:00.0:   bridge window [mem 0xd800000000-0xf7ffffffff 64bit pref]
 pci 0000:18:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:18:01.0: [1b21:2423] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:18:01.0: PCI bridge to [bus 49-78]
 pci 0000:18:01.0:   bridge window [io  0x7000-0x9fff]
 pci 0000:18:01.0:   bridge window [mem 0xa4000000-0xbbffffff]
 pci 0000:18:01.0:   bridge window [mem 0xb800000000-0xd7ffffffff 64bit pref]
 pci 0000:18:01.0: PME# supported from D0 D3hot D3cold
 pci 0000:18:02.0: [1b21:2423] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:18:02.0: PCI bridge to [bus 79]
 pci 0000:18:02.0:   bridge window [mem 0xd4400000-0xd47fffff]
 pci 0000:18:02.0: PME# supported from D0 D3hot D3cold
 pci 0000:18:03.0: [1b21:2423] type 01 class 0x060400 PCIe Switch Downstream Port
 pci 0000:18:03.0: PCI bridge to [bus 7a]
 pci 0000:18:03.0:   bridge window [mem 0xd4000000-0xd43fffff]
 pci 0000:18:03.0: PME# supported from D0 D3hot D3cold
 pci 0000:17:00.0: PCI bridge to [bus 18-7a]
 pci 0000:18:00.0: PCI bridge to [bus 19-48]
 pci 0000:18:01.0: PCI bridge to [bus 49-78]
 pci 0000:79:00.0: [1b21:2426] type 00 class 0x0c0330 PCIe Legacy Endpoint
 pci 0000:79:00.0: BAR 0 [mem 0xd4400000-0xd4407fff 64bit]
 pci 0000:79:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:18:02.0: PCI bridge to [bus 79]
 pci 0000:7a:00.0: [1b21:2425] type 00 class 0x0c0340 PCIe Legacy Endpoint
 pci 0000:7a:00.0: BAR 0 [mem 0xd4000000-0xd403ffff 64bit]
 pci 0000:7a:00.0: BAR 2 [mem 0xd4040000-0xd404ffff 64bit]
 pci 0000:7a:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:18:03.0: PCI bridge to [bus 7a]
 pci 0000:7b:00.0: [1022:14de] type 00 class 0x130000 PCIe Legacy Endpoint
 pci 0000:7b:00.0: enabling Extended Tags
 pci 0000:7b:00.2: [1022:1649] type 00 class 0x108000 PCIe Endpoint
 pci 0000:7b:00.2: BAR 2 [mem 0xde500000-0xde5fffff]
 pci 0000:7b:00.2: BAR 5 [mem 0xde608000-0xde609fff]
 pci 0000:7b:00.2: enabling Extended Tags
 pci 0000:7b:00.3: [1022:15b6] type 00 class 0x0c0330 PCIe Endpoint
 pci 0000:7b:00.3: BAR 0 [mem 0xde400000-0xde4fffff 64bit]
 pci 0000:7b:00.3: enabling Extended Tags
 pci 0000:7b:00.3: PME# supported from D0 D3hot D3cold
 pci 0000:7b:00.4: [1022:15b7] type 00 class 0x0c0330 PCIe Endpoint
 pci 0000:7b:00.4: BAR 0 [mem 0xde300000-0xde3fffff 64bit]
 pci 0000:7b:00.4: enabling Extended Tags
 pci 0000:7b:00.4: PME# supported from D0 D3hot D3cold
 pci 0000:7b:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoint
 pci 0000:7b:00.6: BAR 0 [mem 0xde600000-0xde607fff]
 pci 0000:7b:00.6: enabling Extended Tags
 pci 0000:7b:00.6: PME# supported from D0 D3hot D3cold
 pci 0000:00:08.1: PCI bridge to [bus 7b]
 pci 0000:7c:00.0: [1022:15b8] type 00 class 0x0c0330 PCIe Endpoint
 pci 0000:7c:00.0: BAR 0 [mem 0xde900000-0xde9fffff 64bit]
 pci 0000:7c:00.0: enabling Extended Tags
 pci 0000:7c:00.0: PME# supported from D0 D3hot D3cold
 pci 0000:00:08.3: PCI bridge to [bus 7c]
 pci_bus 0000:00: on NUMA node 0
 pci 0000:00:02.1: bridge window [mem 0xd8000000-0xde1fffff]: can't claim; address conflict with AMDIF031:00 [mem 0xdd400000-0xdd400fff]
 pci 0000:05:00.0: bridge window [mem 0xd8000000-0xde1fffff]: can't claim; no compatible bridge window
 pci 0000:06:00.0: bridge window [mem 0xde100000-0xde1fffff]: can't claim; no compatible bridge window
 pci 0000:06:06.0: bridge window [mem 0xde000000-0xde0fffff]: can't claim; no compatible bridge window
 pci 0000:06:07.0: bridge window [mem 0xdda00000-0xddcfffff]: can't claim; no compatible bridge window
 pci 0000:06:08.0: bridge window [mem 0xd8000000-0xdd7fffff]: can't claim; no compatible bridge window
 pci 0000:0c:00.0: bridge window [mem 0xd8000000-0xdd7fffff]: can't claim; no compatible bridge window
 pci 0000:0d:04.0: bridge window [mem 0xdc800000-0xdd1fffff]: can't claim; no compatible bridge window
 pci 0000:0d:06.0: bridge window [mem 0xdd700000-0xdd7fffff]: can't claim; no compatible bridge window
 pci 0000:0d:07.0: bridge window [mem 0xd8000000-0xdc2fffff]: can't claim; no compatible bridge window
 pci 0000:0d:08.0: bridge window [mem 0xdd600000-0xdd6fffff]: can't claim; no compatible bridge window
 pci 0000:0d:0c.0: bridge window [mem 0xdd500000-0xdd5fffff]: can't claim; no compatible bridge window
 pci 0000:0d:0d.0: bridge window [mem 0xdd300000-0xdd4fffff]: can't claim; no compatible bridge window
 pci 0000:06:0c.0: bridge window [mem 0xddf00000-0xddffffff]: can't claim; no compatible bridge window
 pci 0000:06:0d.0: bridge window [mem 0xdde00000-0xddefffff]: can't claim; no compatible bridge window
 pci 0000:07:00.0: BAR 0 [mem 0xde100000-0xde103fff 64bit]: can't claim; no compatible bridge window
 pci 0000:0a:00.0: BAR 2 [mem 0xde000000-0xde00ffff 64bit]: can't claim; no compatible bridge window
 pci 0000:0a:00.0: BAR 4 [mem 0xde010000-0xde013fff 64bit]: can't claim; no compatible bridge window
 pci 0000:12:00.0: BAR 0 [mem 0xdd600000-0xdd603fff 64bit]: can't claim; no compatible bridge window
 pci 0000:13:00.0: BAR 0 [mem 0xdd500000-0xdd507fff 64bit]: can't claim; no compatible bridge window
 pci 0000:15:00.0: BAR 0 [mem 0xddf00000-0xddf07fff 64bit]: can't claim; no compatible bridge window
 pci 0000:0b:00.0: BAR 0 [mem 0xdda00000-0xddbfffff 64bit]: can't claim; no compatible bridge window
 pci 0000:0b:00.0: BAR 2 [mem 0xddc00000-0xddc07fff 64bit]: can't claim; no compatible bridge window
 pci 0000:0f:00.0: BAR 0 [mem 0xdd100000-0xdd1fffff 64bit]: can't claim; no compatible bridge window
 pci 0000:0f:00.0: BAR 2 [mem 0xdc800000-0xdcffffff 64bit pref]: can't claim; no compatible bridge window
 pci 0000:10:00.0: BAR 5 [mem 0xdd700000-0xdd7001ff]: can't claim; no compatible bridge window
 pci 0000:11:00.0: BAR 0 [mem 0xdc200000-0xdc20ffff 64bit]: can't claim; no compatible bridge window
 pci 0000:11:00.0: BAR 2 [mem 0xdc000000-0xdc1fffff 64bit]: can't claim; no compatible bridge window
 pci 0000:11:00.0: BAR 4 [mem 0xd8000000-0xdbffffff 64bit]: can't claim; no compatible bridge window
 pci 0000:14:00.0: BAR 5 [mem 0xdd380000-0xdd3803ff]: can't claim; no compatible bridge window
 pci 0000:16:00.0: BAR 5 [mem 0xdde80000-0xdde803ff]: can't claim; no compatible bridge window
 pci 0000:03:00.0: vgaarb: setting as boot VGA device
 pci 0000:03:00.0: vgaarb: bridge control possible
 pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:0f:00.0: ROM [mem 0xdd000000-0xdd0fffff pref]: can't claim; no compatible bridge window
 pci 0000:14:00.0: ROM [mem 0xdd300000-0xdd37ffff pref]: can't claim; no compatible bridge window
 pci 0000:16:00.0: ROM [mem 0xdde00000-0xdde7ffff pref]: can't claim; no compatible bridge window
+pci 0000:06:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 07] requires relaxed alignment rules
+pci 0000:06:06.0: bridge window [mem 0x00100000-0x001fffff] to [bus 0a] requires relaxed alignment rules
+pci 0000:06:07.0: bridge window [mem 0x00100000-0x003fffff] to [bus 0b] requires relaxed alignment rules
+pci 0000:0d:04.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref] to [bus 0f] requires relaxed alignment rules
+pci 0000:0d:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 0f] requires relaxed alignment rules
+pci 0000:0d:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 0f] requires relaxed alignment rules
 pci 0000:0d:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 0f] add_size 100000 add_align 100000
-pci 0000:00:02.1: bridge window [mem 0xd4800000-0xdbffffff]: assigned
+pci 0000:0d:06.0: bridge window [mem 0x00100000-0x001fffff] to [bus 10] requires relaxed alignment rules
+pci 0000:0d:07.0: bridge window [mem 0x02000000-0x062fffff] to [bus 11] requires relaxed alignment rules
+pci 0000:0d:08.0: bridge window [mem 0x00100000-0x001fffff] to [bus 12] requires relaxed alignment rules
+pci 0000:0d:0c.0: bridge window [mem 0x00100000-0x001fffff] to [bus 13] requires relaxed alignment rules
+pci 0000:0d:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 14] requires relaxed alignment rules
+pci 0000:0d:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 14] requires relaxed alignment rules
+pci 0000:0c:00.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref] to [bus 0d-14] requires relaxed alignment rules
+pci 0000:0c:00.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0d-14] requires relaxed alignment rules
+pci 0000:0c:00.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0d-14] requires relaxed alignment rules
+pci 0000:0c:00.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0d-14] add_size 100000 add_align 1000000
+pci 0000:06:08.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref] to [bus 0c-14] requires relaxed alignment rules
+pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] requires relaxed alignment rules
+pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] requires relaxed alignment rules
+pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] add_size 100000 add_align 1000000
+pci 0000:06:0c.0: bridge window [mem 0x00100000-0x001fffff] to [bus 15] requires relaxed alignment rules
+pci 0000:06:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 16] requires relaxed alignment rules
+pci 0000:06:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 16] requires relaxed alignment rules
+pci 0000:00:02.1: bridge window [mem 0xd4800000-0xd97fffff]: assigned
 pci 0000:00:02.1: bridge window [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
 pci 0000:02:00.0: PCI bridge to [bus 03]
 pci 0000:02:00.0:   bridge window [io  0xf000-0xffff]
 pci 0000:02:00.0:   bridge window [mem 0xde700000-0xde7fffff]
 pci 0000:02:00.0:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
 pci 0000:01:00.0: PCI bridge to [bus 02-03]
 pci 0000:01:00.0:   bridge window [io  0xf000-0xffff]
 pci 0000:01:00.0:   bridge window [mem 0xde700000-0xde7fffff]
 pci 0000:01:00.0:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
 pci 0000:00:01.1: PCI bridge to [bus 01-03]
 pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
 pci 0000:00:01.1:   bridge window [mem 0xde700000-0xde8fffff]
 pci 0000:00:01.1:   bridge window [mem 0xf800000000-0xfc0fffffff 64bit pref]
 pci 0000:00:01.2: PCI bridge to [bus 04]
 pci 0000:00:01.2:   bridge window [mem 0xdea00000-0xdeafffff]
-pci 0000:05:00.0: bridge window [mem 0xd4800000-0xdbffffff]: assigned
+pci 0000:05:00.0: bridge window [mem 0xd4800000-0xd97fffff]: assigned
 pci 0000:05:00.0: bridge window [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
-pci 0000:06:08.0: bridge window [mem 0xd5000000-0xdbffffff]: assigned
+pci 0000:06:08.0: bridge window [mem size 0x04900000]: can't assign; no space
+pci 0000:06:08.0: bridge window [mem size 0x04900000]: failed to assign
 pci 0000:06:08.0: bridge window [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
 pci 0000:06:00.0: bridge window [mem 0xd4800000-0xd48fffff]: assigned
 pci 0000:06:06.0: bridge window [mem 0xd4900000-0xd49fffff]: assigned
 pci 0000:06:07.0: bridge window [mem 0xd4a00000-0xd4cfffff]: assigned
 pci 0000:06:0c.0: bridge window [mem 0xd4d00000-0xd4dfffff]: assigned
 pci 0000:06:0d.0: bridge window [mem 0xd4e00000-0xd4efffff]: assigned
+pci 0000:06:00.0: bridge window [mem 0xd4800000-0xd48fffff]: releasing
+pci 0000:06:06.0: bridge window [mem 0xd4900000-0xd49fffff]: releasing
+pci 0000:06:07.0: bridge window [mem 0xd4a00000-0xd4cfffff]: releasing
+pci 0000:06:0c.0: bridge window [mem 0xd4d00000-0xd4dfffff]: releasing
+pci 0000:06:0d.0: bridge window [mem 0xd4e00000-0xd4efffff]: releasing
+pci 0000:06:08.0: bridge window [mem 0xd5000000-0xd97fffff]: assigned
+pci 0000:06:00.0: bridge window [mem 0xd4800000-0xd48fffff]: assigned
+pci 0000:06:06.0: bridge window [mem 0xd4900000-0xd49fffff]: assigned
+pci 0000:06:07.0: bridge window [mem 0xd4a00000-0xd4cfffff]: assigned
+pci 0000:06:0c.0: bridge window [mem 0xd4d00000-0xd4dfffff]: assigned
+pci 0000:06:0d.0: bridge window [mem 0xd4e00000-0xd4efffff]: assigned
+pci 0000:06:08.0: bridge window [mem 0xd5000000-0xd97fffff]: failed to expand by 0x100000
+pci 0000:06:08.0: bridge window [mem 0xd5000000-0xd97fffff]: failed to add optional 100000
 pci 0000:07:00.0: BAR 0 [mem 0xd4800000-0xd4803fff 64bit]: assigned
 pci 0000:06:00.0: PCI bridge to [bus 07]
 pci 0000:06:00.0:   bridge window [mem 0xd4800000-0xd48fffff]
 pci 0000:06:04.0: PCI bridge to [bus 08]
 pci 0000:06:05.0: PCI bridge to [bus 09]
 pci 0000:0a:00.0: BAR 2 [mem 0xd4900000-0xd490ffff 64bit]: assigned
 pci 0000:0a:00.0: BAR 4 [mem 0xd4910000-0xd4913fff 64bit]: assigned
 pci 0000:06:06.0: PCI bridge to [bus 0a]
 pci 0000:06:06.0:   bridge window [io  0xe000-0xefff]
 pci 0000:06:06.0:   bridge window [mem 0xd4900000-0xd49fffff]
 pci 0000:0b:00.0: BAR 0 [mem 0xd4a00000-0xd4bfffff 64bit]: assigned
 pci 0000:0b:00.0: BAR 2 [mem 0xd4c00000-0xd4c07fff 64bit]: assigned
 pci 0000:06:07.0: PCI bridge to [bus 0b]
 pci 0000:06:07.0:   bridge window [mem 0xd4a00000-0xd4cfffff]
-pci 0000:0c:00.0: bridge window [mem 0xd5000000-0xdbffffff]: assigned
+pci 0000:0c:00.0: bridge window [mem 0xd5000000-0xd97fffff]: assigned
 pci 0000:0c:00.0: bridge window [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
-pci 0000:0d:07.0: bridge window [mem 0xd6000000-0xdbffffff]: assigned
+pci 0000:0d:07.0: bridge window [mem size 0x04300000]: can't assign; no space
+pci 0000:0d:07.0: bridge window [mem size 0x04300000]: failed to assign
 pci 0000:0d:04.0: bridge window [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
-pci 0000:0d:04.0: bridge window [mem 0xd5000000-0xd51fffff]: assigned
-pci 0000:0d:06.0: bridge window [mem 0xd5200000-0xd52fffff]: assigned
-pci 0000:0d:08.0: bridge window [mem 0xd5300000-0xd53fffff]: assigned
-pci 0000:0d:0c.0: bridge window [mem 0xd5400000-0xd54fffff]: assigned
-pci 0000:0d:0d.0: bridge window [mem 0xd5500000-0xd55fffff]: assigned
+pci 0000:0d:04.0: bridge window [mem 0xd5000000-0xd50fffff]: assigned
+pci 0000:0d:06.0: bridge window [mem 0xd5100000-0xd51fffff]: assigned
+pci 0000:0d:08.0: bridge window [mem 0xd5200000-0xd52fffff]: assigned
+pci 0000:0d:0c.0: bridge window [mem 0xd5300000-0xd53fffff]: assigned
+pci 0000:0d:0d.0: bridge window [mem 0xd5400000-0xd54fffff]: assigned
+pci 0000:0d:04.0: bridge window [mem 0xd5000000-0xd50fffff]: releasing
+pci 0000:0d:06.0: bridge window [mem 0xd5100000-0xd51fffff]: releasing
+pci 0000:0d:08.0: bridge window [mem 0xd5200000-0xd52fffff]: releasing
+pci 0000:0d:0c.0: bridge window [mem 0xd5300000-0xd53fffff]: releasing
+pci 0000:0d:0d.0: bridge window [mem 0xd5400000-0xd54fffff]: releasing
+pci 0000:0d:07.0: bridge window [mem size 0x04300000]: can't assign; no space
+pci 0000:0d:07.0: bridge window [mem size 0x04300000]: failed to assign
+pci 0000:0d:04.0: bridge window [mem 0xd5000000-0xd50fffff]: assigned
+pci 0000:0d:06.0: bridge window [mem 0xd5100000-0xd51fffff]: assigned
+pci 0000:0d:08.0: bridge window [mem 0xd5200000-0xd52fffff]: assigned
+pci 0000:0d:0c.0: bridge window [mem 0xd5300000-0xd53fffff]: assigned
+pci 0000:0d:0d.0: bridge window [mem 0xd5400000-0xd54fffff]: assigned
 pci 0000:0d:00.0: PCI bridge to [bus 0e]
 pci 0000:0f:00.0: BAR 2 [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
 pci 0000:0f:00.0: BAR 0 [mem 0xd5000000-0xd50fffff 64bit]: assigned
-pci 0000:0f:00.0: ROM [mem 0xd5100000-0xd51fffff pref]: assigned
+pci 0000:0f:00.0: ROM [mem size 0x00100000 pref]: can't assign; no space
+pci 0000:0f:00.0: ROM [mem size 0x00100000 pref]: failed to assign
+pci 0000:0f:00.0: BAR 2 [mem 0x1060000000-0x10607fffff 64bit pref]: releasing
+pci 0000:0f:00.0: BAR 0 [mem 0xd5000000-0xd50fffff 64bit]: releasing
+pci 0000:0f:00.0: BAR 2 [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
+pci 0000:0f:00.0: BAR 0 [mem 0xd5000000-0xd50fffff 64bit]: assigned
+pci 0000:0f:00.0: ROM [mem size 0x00100000 pref]: can't assign; no space
+pci 0000:0f:00.0: ROM [mem size 0x00100000 pref]: failed to assign
 pci 0000:0d:04.0: PCI bridge to [bus 0f]
-pci 0000:0d:04.0:   bridge window [mem 0xd5000000-0xd51fffff]
+pci 0000:0d:04.0:   bridge window [mem 0xd5000000-0xd50fffff]
 pci 0000:0d:04.0:   bridge window [mem 0x1060000000-0x10607fffff 64bit pref]
-pci 0000:10:00.0: BAR 5 [mem 0xd5200000-0xd52001ff]: assigned
+pci 0000:10:00.0: BAR 5 [mem 0xd5100000-0xd51001ff]: assigned
 pci 0000:0d:06.0: PCI bridge to [bus 10]
 pci 0000:0d:06.0:   bridge window [io  0xd000-0xdfff]
-pci 0000:0d:06.0:   bridge window [mem 0xd5200000-0xd52fffff]
-pci 0000:11:00.0: BAR 4 [mem 0xd8000000-0xdbffffff 64bit]: assigned
-pci 0000:11:00.0: BAR 2 [mem 0xd6000000-0xd61fffff 64bit]: assigned
-pci 0000:11:00.0: BAR 0 [mem 0xd6200000-0xd620ffff 64bit]: assigned
+pci 0000:0d:06.0:   bridge window [mem 0xd5100000-0xd51fffff]
+pci 0000:11:00.0: BAR 4 [mem size 0x04000000 64bit]: can't assign; no space
+pci 0000:11:00.0: BAR 4 [mem 0xd8000000-0xdbffffff 64bit]: failed to assign
+pci 0000:11:00.0: BAR 2 [mem size 0x00200000 64bit]: can't assign; no space
+pci 0000:11:00.0: BAR 2 [mem 0xdc000000-0xdc1fffff 64bit]: failed to assign
+pci 0000:11:00.0: BAR 0 [mem size 0x00010000 64bit]: can't assign; no space
+pci 0000:11:00.0: BAR 0 [mem 0xdc200000-0xdc20ffff 64bit]: failed to assign
+pci 0000:11:00.0: BAR 4 [mem size 0x04000000 64bit]: can't assign; no space
+pci 0000:11:00.0: BAR 4 [mem 0xd8000000-0xdbffffff 64bit]: failed to assign
+pci 0000:11:00.0: BAR 2 [mem size 0x00200000 64bit]: can't assign; no space
+pci 0000:11:00.0: BAR 2 [mem 0xdc000000-0xdc1fffff 64bit]: failed to assign
+pci 0000:11:00.0: BAR 0 [mem size 0x00010000 64bit]: can't assign; no space
+pci 0000:11:00.0: BAR 0 [mem 0xdc200000-0xdc20ffff 64bit]: failed to assign
 pci 0000:0d:07.0: PCI bridge to [bus 11]
-pci 0000:0d:07.0:   bridge window [mem 0xd6000000-0xdbffffff]
-pci 0000:12:00.0: BAR 0 [mem 0xd5300000-0xd5303fff 64bit]: assigned
+pci 0000:12:00.0: BAR 0 [mem 0xd5200000-0xd5203fff 64bit]: assigned
 pci 0000:0d:08.0: PCI bridge to [bus 12]
-pci 0000:0d:08.0:   bridge window [mem 0xd5300000-0xd53fffff]
-pci 0000:13:00.0: BAR 0 [mem 0xd5400000-0xd5407fff 64bit]: assigned
+pci 0000:0d:08.0:   bridge window [mem 0xd5200000-0xd52fffff]
+pci 0000:13:00.0: BAR 0 [mem 0xd5300000-0xd5307fff 64bit]: assigned
 pci 0000:0d:0c.0: PCI bridge to [bus 13]
-pci 0000:0d:0c.0:   bridge window [mem 0xd5400000-0xd54fffff]
-pci 0000:14:00.0: ROM [mem 0xd5500000-0xd557ffff pref]: assigned
-pci 0000:14:00.0: BAR 5 [mem 0xd5580000-0xd55803ff]: assigned
+pci 0000:0d:0c.0:   bridge window [mem 0xd5300000-0xd53fffff]
+pci 0000:14:00.0: ROM [mem 0xd5400000-0xd547ffff pref]: assigned
+pci 0000:14:00.0: BAR 5 [mem 0xd5480000-0xd54803ff]: assigned
 pci 0000:0d:0d.0: PCI bridge to [bus 14]
-pci 0000:0d:0d.0:   bridge window [mem 0xd5500000-0xd55fffff]
+pci 0000:0d:0d.0:   bridge window [mem 0xd5400000-0xd54fffff]
 pci 0000:0c:00.0: PCI bridge to [bus 0d-14]
 pci 0000:0c:00.0:   bridge window [io  0xd000-0xdfff]
-pci 0000:0c:00.0:   bridge window [mem 0xd5000000-0xdbffffff]
+pci 0000:0c:00.0:   bridge window [mem 0xd5000000-0xd97fffff]
 pci 0000:0c:00.0:   bridge window [mem 0x1060000000-0x10607fffff 64bit pref]
 pci 0000:06:08.0: PCI bridge to [bus 0c-14]
 pci 0000:06:08.0:   bridge window [io  0xd000-0xdfff]
-pci 0000:06:08.0:   bridge window [mem 0xd5000000-0xdbffffff]
+pci 0000:06:08.0:   bridge window [mem 0xd5000000-0xd97fffff]
 pci 0000:06:08.0:   bridge window [mem 0x1060000000-0x10607fffff 64bit pref]
 pci 0000:15:00.0: BAR 0 [mem 0xd4d00000-0xd4d07fff 64bit]: assigned
 pci 0000:06:0c.0: PCI bridge to [bus 15]
 pci 0000:06:0c.0:   bridge window [mem 0xd4d00000-0xd4dfffff]
 pci 0000:16:00.0: ROM [mem 0xd4e00000-0xd4e7ffff pref]: assigned
 pci 0000:16:00.0: BAR 5 [mem 0xd4e80000-0xd4e803ff]: assigned
 pci 0000:06:0d.0: PCI bridge to [bus 16]
 pci 0000:06:0d.0:   bridge window [mem 0xd4e00000-0xd4efffff]
 pci 0000:05:00.0: PCI bridge to [bus 06-16]
 pci 0000:05:00.0:   bridge window [io  0xd000-0xefff]
-pci 0000:05:00.0:   bridge window [mem 0xd4800000-0xdbffffff]
+pci 0000:05:00.0:   bridge window [mem 0xd4800000-0xd97fffff]
 pci 0000:05:00.0:   bridge window [mem 0x1060000000-0x10607fffff 64bit pref]
 pci 0000:00:02.1: PCI bridge to [bus 05-16]
 pci 0000:00:02.1:   bridge window [io  0xd000-0xefff]
-pci 0000:00:02.1:   bridge window [mem 0xd4800000-0xdbffffff]
+pci 0000:00:02.1:   bridge window [mem 0xd4800000-0xd97fffff]
 pci 0000:00:02.1:   bridge window [mem 0x1060000000-0x10607fffff 64bit pref]
 pci 0000:18:00.0: PCI bridge to [bus 19-48]
 pci 0000:18:00.0:   bridge window [io  0xa000-0xcfff]
 pci 0000:18:00.0:   bridge window [mem 0xbc000000-0xd3ffffff]
 pci 0000:18:00.0:   bridge window [mem 0xd800000000-0xf7ffffffff 64bit pref]
 pci 0000:18:01.0: PCI bridge to [bus 49-78]
 pci 0000:18:01.0:   bridge window [io  0x7000-0x9fff]
 pci 0000:18:01.0:   bridge window [mem 0xa4000000-0xbbffffff]
 pci 0000:18:01.0:   bridge window [mem 0xb800000000-0xd7ffffffff 64bit pref]
 pci 0000:18:02.0: PCI bridge to [bus 79]
 pci 0000:18:02.0:   bridge window [mem 0xd4400000-0xd47fffff]
 pci 0000:18:03.0: PCI bridge to [bus 7a]
 pci 0000:18:03.0:   bridge window [mem 0xd4000000-0xd43fffff]
 pci 0000:17:00.0: PCI bridge to [bus 18-7a]
 pci 0000:17:00.0:   bridge window [io  0x7000-0xcfff]
 pci 0000:17:00.0:   bridge window [mem 0xa4000000-0xd47fffff]
 pci 0000:17:00.0:   bridge window [mem 0xb800000000-0xf7ffffffff 64bit pref]
 pci 0000:00:02.2: PCI bridge to [bus 17-7a]
 pci 0000:00:02.2:   bridge window [io  0x7000-0xcfff]
 pci 0000:00:02.2:   bridge window [mem 0xa4000000-0xd47fffff]
 pci 0000:00:02.2:   bridge window [mem 0xb800000000-0xf7ffffffff 64bit pref]
 pci 0000:00:08.1: PCI bridge to [bus 7b]
 pci 0000:00:08.1:   bridge window [mem 0xde300000-0xde6fffff]
 pci 0000:00:08.3: PCI bridge to [bus 7c]
 pci 0000:00:08.3:   bridge window [mem 0xde900000-0xde9fffff]
+pci_bus 0000:00: Some PCI device resources are unassigned, try booting with pci=realloc
 pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
 pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
 pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
 pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
 pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
 pci_bus 0000:00: resource 9 [mem 0xa0000000-0xdfffffff window]
 pci_bus 0000:00: resource 10 [mem 0x1060000000-0xffffffffff window]
 pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
 pci_bus 0000:01: resource 1 [mem 0xde700000-0xde8fffff]
 pci_bus 0000:01: resource 2 [mem 0xf800000000-0xfc0fffffff 64bit pref]
 pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
 pci_bus 0000:02: resource 1 [mem 0xde700000-0xde7fffff]
 pci_bus 0000:02: resource 2 [mem 0xf800000000-0xfc0fffffff 64bit pref]
 pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
 pci_bus 0000:03: resource 1 [mem 0xde700000-0xde7fffff]
 pci_bus 0000:03: resource 2 [mem 0xf800000000-0xfc0fffffff 64bit pref]
 pci_bus 0000:04: resource 1 [mem 0xdea00000-0xdeafffff]
 pci_bus 0000:05: resource 0 [io  0xd000-0xefff]
-pci_bus 0000:05: resource 1 [mem 0xd4800000-0xdbffffff]
+pci_bus 0000:05: resource 1 [mem 0xd4800000-0xd97fffff]
 pci_bus 0000:05: resource 2 [mem 0x1060000000-0x10607fffff 64bit pref]
 pci_bus 0000:06: resource 0 [io  0xd000-0xefff]
-pci_bus 0000:06: resource 1 [mem 0xd4800000-0xdbffffff]
+pci_bus 0000:06: resource 1 [mem 0xd4800000-0xd97fffff]
 pci_bus 0000:06: resource 2 [mem 0x1060000000-0x10607fffff 64bit pref]
 pci_bus 0000:07: resource 1 [mem 0xd4800000-0xd48fffff]
 pci_bus 0000:0a: resource 0 [io  0xe000-0xefff]
 pci_bus 0000:0a: resource 1 [mem 0xd4900000-0xd49fffff]
 pci_bus 0000:0b: resource 1 [mem 0xd4a00000-0xd4cfffff]
 pci_bus 0000:0c: resource 0 [io  0xd000-0xdfff]
-pci_bus 0000:0c: resource 1 [mem 0xd5000000-0xdbffffff]
+pci_bus 0000:0c: resource 1 [mem 0xd5000000-0xd97fffff]
 pci_bus 0000:0c: resource 2 [mem 0x1060000000-0x10607fffff 64bit pref]
 pci_bus 0000:0d: resource 0 [io  0xd000-0xdfff]
-pci_bus 0000:0d: resource 1 [mem 0xd5000000-0xdbffffff]
+pci_bus 0000:0d: resource 1 [mem 0xd5000000-0xd97fffff]
 pci_bus 0000:0d: resource 2 [mem 0x1060000000-0x10607fffff 64bit pref]
-pci_bus 0000:0f: resource 1 [mem 0xd5000000-0xd51fffff]
+pci_bus 0000:0f: resource 1 [mem 0xd5000000-0xd50fffff]
 pci_bus 0000:0f: resource 2 [mem 0x1060000000-0x10607fffff 64bit pref]
 pci_bus 0000:10: resource 0 [io  0xd000-0xdfff]
-pci_bus 0000:10: resource 1 [mem 0xd5200000-0xd52fffff]
-pci_bus 0000:11: resource 1 [mem 0xd6000000-0xdbffffff]
-pci_bus 0000:12: resource 1 [mem 0xd5300000-0xd53fffff]
-pci_bus 0000:13: resource 1 [mem 0xd5400000-0xd54fffff]
-pci_bus 0000:14: resource 1 [mem 0xd5500000-0xd55fffff]
+pci_bus 0000:10: resource 1 [mem 0xd5100000-0xd51fffff]
+pci_bus 0000:11: resource 1 [mem size 0x04300000]
+pci_bus 0000:12: resource 1 [mem 0xd5200000-0xd52fffff]
+pci_bus 0000:13: resource 1 [mem 0xd5300000-0xd53fffff]
+pci_bus 0000:14: resource 1 [mem 0xd5400000-0xd54fffff]
 pci_bus 0000:15: resource 1 [mem 0xd4d00000-0xd4dfffff]
 pci_bus 0000:16: resource 1 [mem 0xd4e00000-0xd4efffff]
 pci_bus 0000:17: resource 0 [io  0x7000-0xcfff]
 pci_bus 0000:17: resource 1 [mem 0xa4000000-0xd47fffff]
 pci_bus 0000:17: resource 2 [mem 0xb800000000-0xf7ffffffff 64bit pref]
 pci_bus 0000:18: resource 0 [io  0x7000-0xcfff]
 pci_bus 0000:18: resource 1 [mem 0xa4000000-0xd47fffff]
 pci_bus 0000:18: resource 2 [mem 0xb800000000-0xf7ffffffff 64bit pref]
 pci_bus 0000:19: resource 0 [io  0xa000-0xcfff]
 pci_bus 0000:19: resource 1 [mem 0xbc000000-0xd3ffffff]
 pci_bus 0000:19: resource 2 [mem 0xd800000000-0xf7ffffffff 64bit pref]
 pci_bus 0000:49: resource 0 [io  0x7000-0x9fff]
 pci_bus 0000:49: resource 1 [mem 0xa4000000-0xbbffffff]
 pci_bus 0000:49: resource 2 [mem 0xb800000000-0xd7ffffffff 64bit pref]
 pci_bus 0000:79: resource 1 [mem 0xd4400000-0xd47fffff]
 pci_bus 0000:7a: resource 1 [mem 0xd4000000-0xd43fffff]
 pci_bus 0000:7b: resource 1 [mem 0xde300000-0xde6fffff]
 pci_bus 0000:7c: resource 1 [mem 0xde900000-0xde9fffff]
 pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
 pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
 pci 0000:00:01.0: Adding to iommu group 0
 pci 0000:00:01.1: Adding to iommu group 1
 pci 0000:00:01.2: Adding to iommu group 2
 pci 0000:00:02.0: Adding to iommu group 3
 pci 0000:00:02.1: Adding to iommu group 4
 pci 0000:00:02.2: Adding to iommu group 5
 pci 0000:00:03.0: Adding to iommu group 6
 pci 0000:00:04.0: Adding to iommu group 7
 pci 0000:00:08.0: Adding to iommu group 8
 pci 0000:00:08.1: Adding to iommu group 9
 pci 0000:00:08.3: Adding to iommu group 10
 pci 0000:00:14.0: Adding to iommu group 11
 pci 0000:00:14.3: Adding to iommu group 11
 pci 0000:00:18.0: Adding to iommu group 12
 pci 0000:00:18.1: Adding to iommu group 12
 pci 0000:00:18.2: Adding to iommu group 12
 pci 0000:00:18.3: Adding to iommu group 12
 pci 0000:00:18.4: Adding to iommu group 12
 pci 0000:00:18.5: Adding to iommu group 12
 pci 0000:00:18.6: Adding to iommu group 12
 pci 0000:00:18.7: Adding to iommu group 12
 pci 0000:01:00.0: Adding to iommu group 13
 pci 0000:02:00.0: Adding to iommu group 14
 pci 0000:03:00.0: Adding to iommu group 15
 pci 0000:03:00.1: Adding to iommu group 16
 pci 0000:04:00.0: Adding to iommu group 17
 pci 0000:05:00.0: Adding to iommu group 18
 pci 0000:06:00.0: Adding to iommu group 19
 pci 0000:06:04.0: Adding to iommu group 20
 pci 0000:06:05.0: Adding to iommu group 21
 pci 0000:06:06.0: Adding to iommu group 22
 pci 0000:06:07.0: Adding to iommu group 23
 pci 0000:06:08.0: Adding to iommu group 24
 pci 0000:06:0c.0: Adding to iommu group 25
 pci 0000:06:0d.0: Adding to iommu group 26
 pci 0000:07:00.0: Adding to iommu group 19
 pci 0000:0a:00.0: Adding to iommu group 22
 pci 0000:0b:00.0: Adding to iommu group 23
 pci 0000:0c:00.0: Adding to iommu group 24
 pci 0000:0d:00.0: Adding to iommu group 24
 pci 0000:0d:04.0: Adding to iommu group 24
 pci 0000:0d:06.0: Adding to iommu group 24
 pci 0000:0d:07.0: Adding to iommu group 24
 pci 0000:0d:08.0: Adding to iommu group 24
 pci 0000:0d:0c.0: Adding to iommu group 24
 pci 0000:0d:0d.0: Adding to iommu group 24
 pci 0000:0f:00.0: Adding to iommu group 24
 pci 0000:10:00.0: Adding to iommu group 24
 pci 0000:11:00.0: Adding to iommu group 24
 pci 0000:12:00.0: Adding to iommu group 24
 pci 0000:13:00.0: Adding to iommu group 24
 pci 0000:14:00.0: Adding to iommu group 24
 pci 0000:15:00.0: Adding to iommu group 25
 pci 0000:16:00.0: Adding to iommu group 26
 pci 0000:17:00.0: Adding to iommu group 27
 pci 0000:18:00.0: Adding to iommu group 28
 pci 0000:18:01.0: Adding to iommu group 29
 pci 0000:18:02.0: Adding to iommu group 30
 pci 0000:18:03.0: Adding to iommu group 31
 pci 0000:79:00.0: Adding to iommu group 30
 pci 0000:7a:00.0: Adding to iommu group 31
 pci 0000:7b:00.0: Adding to iommu group 32
 pci 0000:7b:00.2: Adding to iommu group 33
 pci 0000:7b:00.3: Adding to iommu group 34
 pci 0000:7b:00.4: Adding to iommu group 35
 pci 0000:7b:00.6: Adding to iommu group 36
 pci 0000:7c:00.0: Adding to iommu group 37
 thunderbolt 0000:7a:00.0: enabling device (0000 -> 0002)
 pcieport 0000:00:01.1: PME: Signaling with IRQ 45
 pcieport 0000:00:01.1: AER: enabled with IRQ 45
 pcieport 0000:00:01.2: PME: Signaling with IRQ 46
 pcieport 0000:00:01.2: AER: enabled with IRQ 46
 pcieport 0000:00:02.1: PME: Signaling with IRQ 47
 pcieport 0000:00:02.1: AER: enabled with IRQ 47
 pcieport 0000:00:02.2: PME: Signaling with IRQ 48
 pcieport 0000:00:02.2: AER: enabled with IRQ 48
 pcieport 0000:00:08.1: PME: Signaling with IRQ 49
 pcieport 0000:00:08.3: PME: Signaling with IRQ 50
 nvme 0000:04:00.0: platform quirk: setting simple suspend
 nvme 0000:07:00.0: platform quirk: setting simple suspend
 ahci 0000:10:00.0: enabling device (0000 -> 0003)
-nvme nvme0: pci function 0000:04:00.0
 nvme nvme1: pci function 0000:07:00.0
+nvme nvme0: pci function 0000:04:00.0
 nvme nvme2: pci function 0000:12:00.0
 ahci 0000:10:00.0: SSS flag set, parallel bus scan disabled
 ahci 0000:10:00.0: AHCI vers 0001.0200, 32 command slots, 6 Gbps, SATA mode
 ahci 0000:10:00.0: 2/2 ports implemented (port mask 0x3)
 ahci 0000:10:00.0: flags: 64bit ncq sntf stag led clo pmp pio slum part ccc 
 ahci 0000:14:00.0: enabling device (0000 -> 0002)
 ahci 0000:14:00.0: SSS flag set, parallel bus scan disabled
 ahci 0000:14:00.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
 ahci 0000:14:00.0: 4/6 ports implemented (port mask 0xf)
 ahci 0000:14:00.0: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
 ahci 0000:16:00.0: enabling device (0000 -> 0002)
 ahci 0000:16:00.0: SSS flag set, parallel bus scan disabled
 ahci 0000:16:00.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
 ahci 0000:16:00.0: 4/6 ports implemented (port mask 0xf)
 ahci 0000:16:00.0: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
 mlx4_core: Initializing 0000:0f:00.0
 mlx4_core 0000:0f:00.0: enabling device (0000 -> 0002)
 mlx4_core 0000:0f:00.0: DMFS high rate steer mode is: disabled performance optimized steering
 mlx4_core 0000:0f:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:0d:04.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
 mlx4_en 0000:0f:00.0: Activating port:1
 mlx4_en: 0000:0f:00.0: Port 1: Using 32 TX rings
 mlx4_en: 0000:0f:00.0: Port 1: Using 16 RX rings
 mlx4_en: 0000:0f:00.0: Port 1: Initializing port
 mlx4_en 0000:0f:00.0: registered PHC clock
 r8169 0000:0a:00.0 eth1: RTL8126A, 9c:6b:00:96:ce:15, XID 64a, IRQ 169
 r8169 0000:0a:00.0 eth1: jumbo features [frames: 16362 bytes, tx checksumming: ko]
 xhci_hcd 0000:13:00.0: xHCI Host Controller
 xhci_hcd 0000:13:00.0: new USB bus registered, assigned bus number 1
 xhci_hcd 0000:13:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000000000010
 xhci_hcd 0000:13:00.0: xHCI Host Controller
 xhci_hcd 0000:13:00.0: new USB bus registered, assigned bus number 2
 xhci_hcd 0000:13:00.0: Host supports USB 3.1 Enhanced SuperSpeed
 usb usb1: SerialNumber: 0000:13:00.0
 usb usb2: SerialNumber: 0000:13:00.0
 xhci_hcd 0000:15:00.0: xHCI Host Controller
 xhci_hcd 0000:15:00.0: new USB bus registered, assigned bus number 3
 xhci_hcd 0000:15:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000000000010
 xhci_hcd 0000:15:00.0: xHCI Host Controller
 xhci_hcd 0000:15:00.0: new USB bus registered, assigned bus number 4
 xhci_hcd 0000:15:00.0: Host supports USB 3.2 Enhanced SuperSpeed
 usb usb3: SerialNumber: 0000:15:00.0
 usb usb4: SerialNumber: 0000:15:00.0
 xhci_hcd 0000:79:00.0: xHCI Host Controller
 xhci_hcd 0000:79:00.0: new USB bus registered, assigned bus number 5
 xhci_hcd 0000:79:00.0: hcc params 0x0200ef81 hci version 0x120 quirks 0x0000000200000010
 xhci_hcd 0000:79:00.0: xHCI Host Controller
 xhci_hcd 0000:79:00.0: new USB bus registered, assigned bus number 6
 xhci_hcd 0000:79:00.0: Host supports USB 3.2 Enhanced SuperSpeed
 usb usb5: SerialNumber: 0000:79:00.0
 usb usb6: SerialNumber: 0000:79:00.0
 xhci_hcd 0000:7b:00.3: xHCI Host Controller
 xhci_hcd 0000:7b:00.3: new USB bus registered, assigned bus number 7
 xhci_hcd 0000:7b:00.3: hcc params 0x0120ffc5 hci version 0x120 quirks 0x0000000200000010
 xhci_hcd 0000:7b:00.3: xHCI Host Controller
 xhci_hcd 0000:7b:00.3: new USB bus registered, assigned bus number 8
 xhci_hcd 0000:7b:00.3: Host supports USB 3.1 Enhanced SuperSpeed
 usb usb7: SerialNumber: 0000:7b:00.3
 usb usb8: SerialNumber: 0000:7b:00.3
 xhci_hcd 0000:7b:00.4: xHCI Host Controller
 xhci_hcd 0000:7b:00.4: new USB bus registered, assigned bus number 9
 xhci_hcd 0000:7b:00.4: hcc params 0x0120ffc5 hci version 0x120 quirks 0x0000000200000010
 xhci_hcd 0000:7b:00.4: xHCI Host Controller
 xhci_hcd 0000:7b:00.4: new USB bus registered, assigned bus number 10
 xhci_hcd 0000:7b:00.4: Host supports USB 3.1 Enhanced SuperSpeed
 usb usb9: SerialNumber: 0000:7b:00.4
 usb usb10: SerialNumber: 0000:7b:00.4
 xhci_hcd 0000:7c:00.0: xHCI Host Controller
 xhci_hcd 0000:7c:00.0: new USB bus registered, assigned bus number 11
 xhci_hcd 0000:7c:00.0: USB3 root hub has no ports
 xhci_hcd 0000:7c:00.0: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
-xhci_hcd 0000:7c:00.0: xHCI Host Controller
-xhci_hcd 0000:7c:00.0: new USB bus registered, assigned bus number 12
-xhci_hcd 0000:7c:00.0: Host supports USB 3.0 SuperSpeed
 usb usb11: SerialNumber: 0000:7c:00.0
-usb usb12: SerialNumber: 0000:7c:00.0
 ccp 0000:7b:00.2: enabling device (0000 -> 0002)
 ccp 0000:7b:00.2: tee enabled
 ccp 0000:7b:00.2: psp enabled
 amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
 amdgpu 0000:03:00.0: amdgpu: initializing kernel modesetting (IP DISCOVERY 0x1002:0x7550 0x1EAE:0x8811 0xC0).
 amdgpu 0000:03:00.0: amdgpu: register mmio base: 0xDE700000
 amdgpu 0000:03:00.0: amdgpu: register mmio size: 524288
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <soc24_common>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v12_0>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <ih_v7_0>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dm>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v12_0>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v7_0>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v5_0_0>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v5_0_0>
-amdgpu 0000:03:00.0: amdgpu: detected ip block number 10 <mes_v12_0>
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 0 <common_v1_0_0> (soc24_common)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 1 <gmc_v12_0_0> (gmc_v12_0)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 2 <ih_v7_0_0> (ih_v7_0)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 3 <psp_v14_0_0> (psp)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 4 <smu_v14_0_0> (smu)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 5 <dce_v1_0_0> (dm)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 6 <gfx_v12_0_0> (gfx_v12_0)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 7 <sdma_v7_0_0> (sdma_v7_0)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 8 <vcn_v5_0_0> (vcn_v5_0_0)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 9 <jpeg_v5_0_0> (jpeg_v5_0_0)
+amdgpu 0000:03:00.0: amdgpu: detected ip block number 10 <mes_v12_0_0> (mes_v12_0)
 amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
 amdgpu 0000:03:00.0: vgaarb: deactivate vga console
 amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
 amdgpu 0000:03:00.0: amdgpu: MEM ECC is not presented.
 amdgpu 0000:03:00.0: amdgpu: SRAM ECC is not presented.
 amdgpu 0000:03:00.0: amdgpu: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
 amdgpu 0000:03:00.0: amdgpu: VRAM: 16304M 0x0000008000000000 - 0x00000083FAFFFFFF (16304M used)
 amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
 amdgpu 0000:03:00.0: amdgpu: amdgpu: 16304M of VRAM memory ready
-amdgpu 0000:03:00.0: amdgpu: amdgpu: 31936M of GTT memory ready.
+amdgpu 0000:03:00.0: amdgpu: amdgpu: 31937M of GTT memory ready.
 amdgpu 0000:03:00.0: amdgpu: PCIE GART of 512M enabled (table at 0x00000083DAB00000).
 amdgpu 0000:03:00.0: amdgpu: [drm] Loading DMUB firmware via PSP: version=0x0A000400
-amdgpu 0000:03:00.0: amdgpu: Found VCN firmware Version ENC: 1.9 DEC: 9 VEP: 0 Revision: 38
+amdgpu 0000:03:00.0: amdgpu: [VCN instance 0] Found VCN firmware Version ENC: 1.9 DEC: 9 VEP: 0 Revision: 38
 input: ASRock LED Controller as /devices/pci0000:00/0000:00:08.3/0000:7c:00.0/usb11/11-1/11-1:1.0/0003:26CE:01A2.0001/input/input3
+hid-generic 0003:26CE:01A2.0001: input,hidraw0: USB HID v1.10 Device [ASRock LED Controller] on usb-0000:7c:00.0-1/input0
-hid-generic 0003:26CE:01A2.0001: input,hidraw0: USB HID v1.10 Device [ASRock LED Controller] on usb-0000:7c:00.0-1/input0
 amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
 amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional securedisplay ta ucode is not available
 amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x0000002e, smu fw if version = 0x00000032, smu fw program = 0, smu fw version = 0x00684a00 (104.74.0)
 amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
 amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
-amdgpu 0000:03:00.0: amdgpu: [drm] Display Core v3.2.340 initialized on DCN 4.0.1
+amdgpu 0000:03:00.0: amdgpu: [drm] Display Core v3.2.351 initialized on DCN 4.0.1
 amdgpu 0000:03:00.0: amdgpu: [drm] DP-HDMI FRL PCON supported
 amdgpu 0000:03:00.0: amdgpu: [drm] DMUB hardware initialized: version=0x0A000400
-amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
-amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
+amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
+amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
 input: SAVITECH Bravo-X USB Audio as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:0c.0/0000:15:00.0/usb3/3-4/3-4:1.0/0003:262A:9023.0002/input/input4
 hid-generic 0003:262A:9023.0002: input,hidraw1: USB HID v1.00 Device [SAVITECH Bravo-X USB Audio] on usb-0000:15:00.0-4/input0
 amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
 amdgpu 0000:03:00.0: amdgpu: [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
 amdgpu 0000:03:00.0: amdgpu: program CP_MES_CNTL : 0x4000000
 amdgpu 0000:03:00.0: amdgpu: program CP_MES_CNTL : 0xc000000
 amdgpu 0000:03:00.0: amdgpu: MES FW version must be >= 0x82 to enable LR compute workaround.
 amdgpu 0000:03:00.0: amdgpu: SE 4, SH per SE 2, CU per SH 8, active_cu_number 64
 amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 6 on hub 0
 amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 7 on hub 0
 amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 8 on hub 0
 amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 9 on hub 0
 amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
 amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
 amdgpu 0000:03:00.0: amdgpu: Using BACO for runtime pm
 amdgpu 0000:03:00.0: [drm] Registered 4 planes with drm panic
 [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 0
 amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer device
 hid-generic 0003:0ECB:2088.0003: hiddev0,hidraw2: USB HID v1.10 Device [Harman International Inc JBL Quantum 910 Wireless] on usb-0000:13:00.0-12/input5
 input: Logitech USB Receiver as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:0c.0/0000:15:00.0/usb3/3-5/3-5:1.0/0003:046D:C52B.0004/input/input5
 hid-generic 0003:046D:C52B.0004: input,hidraw3: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:15:00.0-5/input0
 input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:0c.0/0000:15:00.0/usb3/3-5/3-5:1.1/0003:046D:C52B.0005/input/input6
 input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:0c.0/0000:15:00.0/usb3/3-5/3-5:1.1/0003:046D:C52B.0005/input/input7
 input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:0c.0/0000:15:00.0/usb3/3-5/3-5:1.1/0003:046D:C52B.0005/input/input8
 hid-generic 0003:046D:C52B.0005: input,hiddev1,hidraw4: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:15:00.0-5/input1
 hid-generic 0003:046D:C52B.0006: hiddev2,hidraw5: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:15:00.0-5/input2
 input: Corsair Corsair Gaming K70 LUX Keyboard  as /devices/pci0000:00/0000:00:08.1/0000:7b:00.4/usb9/9-1/9-1:1.0/0003:1B1C:1B36.0009/input/input10
 hid-generic 0003:1B1C:1B36.0009: input,hidraw6: USB HID v1.11 Keyboard [Corsair Corsair Gaming K70 LUX Keyboard ] on usb-0000:7b:00.4-1/input0
 input: Corsair Corsair Gaming K70 LUX Keyboard  Keyboard as /devices/pci0000:00/0000:00:08.1/0000:7b:00.4/usb9/9-1/9-1:1.1/0003:1B1C:1B36.000A/input/input11
 input: Corsair Corsair Gaming K70 LUX Keyboard  as /devices/pci0000:00/0000:00:08.1/0000:7b:00.4/usb9/9-1/9-1:1.1/0003:1B1C:1B36.000A/input/input12
 input: Corsair Corsair Gaming K70 LUX Keyboard  as /devices/pci0000:00/0000:00:08.1/0000:7b:00.4/usb9/9-1/9-1:1.1/0003:1B1C:1B36.000A/input/input13
 hid-generic 0003:1B1C:1B36.000A: input,hiddev3,hidraw7: USB HID v1.11 Keyboard [Corsair Corsair Gaming K70 LUX Keyboard ] on usb-0000:7b:00.4-1/input1
 hid-generic 0003:26CE:0A08.000B: hiddev4,hidraw8: USB HID v1.11 Device [Generic USB Audio] on usb-0000:15:00.0-8/input6
 input: ROCCAT ROCCAT Kone as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:08.0/0000:0c:00.0/0000:0d:0c.0/0000:13:00.0/usb1/1-2/1-2.3/1-2.3:1.0/0003:1E7D:2CED.0007/input/input14
+kone 0003:1E7D:2CED.0007: input,hidraw9: USB HID v1.00 Mouse [ROCCAT ROCCAT Kone] on usb-0000:13:00.0-2.3/input0
-snd_hda_intel 0000:03:00.1: enabling device (0000 -> 0002)
-snd_hda_intel 0000:03:00.1: Force to non-snoop mode
-snd_hda_intel 0000:7b:00.6: enabling device (0000 -> 0002)
+snd_hda_intel 0000:03:00.1: enabling device (0000 -> 0002)
+snd_hda_intel 0000:03:00.1: Force to non-snoop mode
+snd_hda_intel 0000:7b:00.6: enabling device (0000 -> 0002)
 snd_hda_intel 0000:7b:00.6: no codecs found!
 snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
-input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input16
+input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card2/input16
-kone 0003:1E7D:2CED.0007: input,hidraw3: USB HID v1.00 Mouse [ROCCAT ROCCAT Kone] on usb-0000:13:00.0-2.3/input0
-input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input17
-input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input18
-input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0/input19
+input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card2/input17
-logitech-djreceiver 0003:046D:C52B.0006: hiddev1,hidraw4: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:15:00.0-5/input2
+input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card2/input18
 input: ROCCAT ROCCAT Kone as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:08.0/0000:0c:00.0/0000:0d:0c.0/0000:13:00.0/usb1/1-2/1-2.3/1-2.3:1.1/0003:1E7D:2CED.0008/input/input20
+input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card2/input19
+kone 0003:1E7D:2CED.0008: input,hidraw3: USB HID v1.11 Keyboard [ROCCAT ROCCAT Kone] on usb-0000:13:00.0-2.3/input1
+logitech-djreceiver 0003:046D:C52B.0006: hiddev2,hidraw5: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:15:00.0-5/input2
 input: Logitech Wireless Device PID:406f Keyboard as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:0c.0/0000:15:00.0/usb3/3-5/3-5:1.2/0003:046D:C52B.0006/0003:046D:406F.000C/input/input21
-kone 0003:1E7D:2CED.0008: input,hidraw5: USB HID v1.11 Keyboard [ROCCAT ROCCAT Kone] on usb-0000:13:00.0-2.3/input1
 input: Logitech Wireless Device PID:406f Mouse as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:0c.0/0000:15:00.0/usb3/3-5/3-5:1.2/0003:046D:C52B.0006/0003:046D:406F.000C/input/input22
-hid-generic 0003:046D:406F.000C: input,hidraw9: USB HID v1.11 Keyboard [Logitech Wireless Device PID:406f] on usb-0000:15:00.0-5/input2:1
+hid-generic 0003:046D:406F.000C: input,hidraw4: USB HID v1.11 Keyboard [Logitech Wireless Device PID:406f] on usb-0000:15:00.0-5/input2:1
 snd_ctxfi 0000:11:00.0: chip 20K2 model SB0880 (1102:0043) is found
-snd_ctxfi 0000:11:00.0: enabling device (0000 -> 0002)
+snd_ctxfi 0000:11:00.0: can't ioremap BAR 2: [??? 0x00000000 flags 0x0]
+snd_ctxfi 0000:11:00.0: Something wrong!!!
+snd_ctxfi 0000:11:00.0: probe with driver snd_ctxfi failed with error -2
 r8169 0000:0a:00.0 enp10s0: renamed from eth1
 mt7925e 0000:0b:00.0: enabling device (0000 -> 0002)
 mt7925e 0000:0b:00.0: ASIC revision: 79250000
 mt7925e 0000:0b:00.0: HW/SW Version: 0x8a108a10, Build Time: 20250825215832a
 input: Logitech MX Ergo as /devices/pci0000:00/0000:00:02.1/0000:05:00.0/0000:06:0c.0/0000:15:00.0/usb3/3-5/3-5:1.2/0003:046D:C52B.0006/0003:046D:406F.000C/input/input26
+logitech-hidpp-device 0003:046D:406F.000C: input,hidraw4: USB HID v1.11 Keyboard [Logitech MX Ergo] on usb-0000:15:00.0-5/input2:1
-logitech-hidpp-device 0003:046D:406F.000C: input,hidraw9: USB HID v1.11 Keyboard [Logitech MX Ergo] on usb-0000:15:00.0-5/input2:1
-snd_ctxfi 0000:11:00.0: Use xfi-native timer
 mt7925e 0000:0b:00.0: WM Firmware Version: ____000000, Build Time: 20250825215925
 r8169 0000:0a:00.0 enp10s0: Link is Down
 mt7925e 0000:0b:00.0 wlp11s0: renamed from wlan0
-r8169 0000:0a:00.0: invalid VPD tag 0x00 (size 0) at offset 0; assume missing optional EEPROM

