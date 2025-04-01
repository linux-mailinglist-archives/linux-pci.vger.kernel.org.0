Return-Path: <linux-pci+bounces-25030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5CA772C3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 04:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19291889547
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 02:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012F1519B9;
	Tue,  1 Apr 2025 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbsv8x65"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119084039;
	Tue,  1 Apr 2025 02:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743474925; cv=none; b=habOyLO/2YDPzaddZ34kkdGZuGnsgBfQIWroOFZK0ayxgWQRwUxd/Zasu1iI2Aw3W/bavrlWbdCV7nut7EOjtU3cBm5yeJDFRTnbcf+PxIpcdnPQ0C9Se7tPQRkmRfp/ALXmXHT2Ai3wOr9y4PvYwAMtkryQxh1m80MOGrIJDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743474925; c=relaxed/simple;
	bh=X60EGHRjpwhW6iX81c4eH+9bV6Wo0yl3+QtP2wMa+PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saY6zORl49ca76INw3ujDynLls59pQmGR2RaGiT3YfyYZaqKmWlYoJbj6xrCY431k5PqHwtjCElGje4Yv6PK3n2lpVZWefgvRX/pwGH4JKtqjgT0//zaRMhdHkSr0S7N6Jg+2ZySpM1ANA6g8UU8R1P57OoTJfSYUCkPGtgSVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbsv8x65; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227c7e57da2so75410575ad.0;
        Mon, 31 Mar 2025 19:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743474922; x=1744079722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1beZhyS7yh43TbZSwap790c+P+krd101wvI4yII/6k=;
        b=nbsv8x65l0OuhnJnq0Zk8/os2rfx1j7xEFX/69ELAMa8yBXJFZdhN0OhE1cv9k0S6o
         HJaGdknCBZ2ZIQ57WjARyrjxp6vW1IjExK9khc6StMSa8xMtchtWupInbEY+Ix+wrRZP
         ywi8HawCEWHDr1PH2J+Kb7R/uU7itUFQNA1P2vC14ReFojCKLQgrNACN7vu/bN0cRrqm
         3g3kcZpOhHRi/rl+7H8n86ia/k7mQCFlkgQhmU/cjbHt/7Cd9z8ILx3xeDye3SVp2i21
         uEHXbGwn3N+HQM/Nxg8HQKzY0s6NQO/5uAfjoxzXrybeo8GeIgHGszZWmlyZQlXZ6Rq4
         Xk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743474922; x=1744079722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1beZhyS7yh43TbZSwap790c+P+krd101wvI4yII/6k=;
        b=t5A/Oxdg0JdLs2BZ/8e8NMCudgB25k67rklrmkC9le4CBh1/fEqZ1nw2f7MljWvV35
         sF9H80rSw68/83vElREQJ13M9iXvmMWzB0m5roU+x0EawKObxviwAMWFtwofB5eXXKa/
         CpehaD9WmXGWgQTLduxoin/72KuyiU8aWZVilVHzVb+ZPYYugxKMivBusMDPZ/p6upMb
         nIC8wn9ejIdo/v8OqJ20KHdQ3ZUsZbYFW1nRgBVacBUpYmu/+phYB6IDEbwsnekqY6hP
         vTjkNt8F0Avo3rZarBWCPUIdm+0l7Xsej1+PeQXReRz4xWkqbFl0mYN1laAlC1Sfgisb
         VcDw==
X-Forwarded-Encrypted: i=1; AJvYcCVJiXzI4cA5aNUH0mp5HVTuHoTgyH2s3Or2i1asphEFWjyGqCH7D5nOJzgz1ozxIw9k5rLMc8aOuHAa@vger.kernel.org, AJvYcCWqVmi9gBltEalNhxFIFwWr07PAIH6qiaipkHcqlEM0AJd3PSyVh2kPipdfwq+xXxn+LM+9hqsKD2DSmuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3oknSw3ZhVNgdqAhOIfHHcsUmzMILLFwaRTdLmqKPL1xZhmT
	mipV0KMNBrHCrJZWxPI/RQm3mgU41H5JvqLsmmptdvwwhLdEre3E
X-Gm-Gg: ASbGncsgs4D5JUTKenEU30LQ4k6zf8UCnOAAXWeRTDJJ+92qXU5rync0YL6rAUplphg
	DslhnHx/HSZ/c3I/CiQb7i5B9HHLyTYAzPmPecRlA/o90B7AApM+du2xValce/Ns2iCBos9LL6e
	nRhTSg4elz3BVjqOtx57cAKPHXvf7oNhHr55OsE8OcbvhKOSsZCkiZeSZQr1xEz6vvLz90QfWAb
	4hkOoknWfzmbApsHtzPTLSO0SthexFWF5GbfP8qjgYHNGosYSW8b8/CkXonDwJk0PiNZHZPt0gN
	h+Ywv8uebteR/UpTmAcei7ZehHAf8v5Mcn/ace39ZppBe4Q282ujq+cWqQ==
X-Google-Smtp-Source: AGHT+IHjvaX7kh/ussl2CjXhDIto/0CSkERfKMyrkQCIXzkID+s5XCT6mm6raopJTBz6Zlsm/6uEdQ==
X-Received: by 2002:a05:6a20:2d07:b0:1f5:8f65:a6e6 with SMTP id adf61e73a8af0-2009f7621d1mr20131166637.27.1743474921977;
        Mon, 31 Mar 2025 19:35:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93ba0e532sm7096880a12.64.2025.03.31.19.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 19:35:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 31 Mar 2025 19:35:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
Message-ID: <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>

Hi,

On Mon, Dec 16, 2024 at 07:56:31PM +0200, Ilpo Järvinen wrote:
> Resetting resource is problematic as it prevent attempting to allocate
> the resource later, unless something in between restores the resource.
> Similarly, if fail_head does not contain all resources that were reset,
> those resource cannot be restored later.
> 
> The entire reset/restore cycle adds complexity and leaving resources
> into reseted state causes issues to other code such as for checks done
> in pci_enable_resources(). Take a small step towards not resetting
> resources by delaying reset until the end of resource assignment and
> build failure list (fail_head) in sync with the reset to avoid leaving
> behind resources that cannot be restored (for the case where the caller
> provides fail_head in the first place to allow restore somewhere in the
> callchain, as is not all callers pass non-NULL fail_head).
> 
> The Expansion ROM check is temporarily left in place while building the
> failure list until the upcoming change which reworks optional resource
> handling.
> 
> Ideally, whole resource reset could be removed but doing that in a big
> step would make the impact non-tractable due to complexity of all
> related code.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

With this patch in the mainline kernel, all mips:boston qemu emulations
fail when running a 64-bit little endian configuration (64r6el_defconfig).

The problem is that the PCI based IDE/ATA controller is not initialized.
There are a number of pci error messages.

pci_bus 0002:01: extended config space not accessible
pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
pci 0002:00:00.0: PCI bridge to [bus 01-ff]
pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assigned
pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: can't assign; no space
pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: failed to assign
pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no space
pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
pci 0002:00:00.0: bridge window [mem size 0x00100000]: can't assign; bogus alignment
pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff 64bit pref]: assigned
pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no space
pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no space
pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: can't assign; no space
pci 0002:01:00.0: BAR 5 [mem size 0x00001000]: failed to assign
pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
pci 0002:00:00.0: PCI bridge to [bus 01]
pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff 64bit pref]
pci_bus 0002:00: Some PCI device resources are unassigned, try booting with pci=realloc
pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
pci_bus 0002:01: resource 2 [mem 0x16000000-0x160fffff 64bit pref]
...
pci 0002:00:00.0: enabling device (0000 -> 0002)
ahci 0002:01:00.0: probe with driver ahci failed with error -12

Bisect points to this patch. Reverting it together with "PCI: Rework
optional resource handling" fixes the problem. For comparison, after
reverting the offending patches, the log messages are as follows.

pci_bus 0002:00: root bus resource [bus 00-ff]
pci_bus 0002:00: root bus resource [mem 0x16000000-0x160fffff]
pci 0002:00:00.0: [10ee:7021] type 01 class 0x060400 PCIe Root Complex Integrated Endpoint
pci 0002:00:00.0: PCI bridge to [bus 00]
pci 0002:00:00.0:   bridge window [io  0x0000-0x0fff]
pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0002:00:00.0: enabling Extended Tags
pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci_bus 0002:01: extended config space not accessible
pci 0002:01:00.0: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
pci 0002:01:00.0: BAR 4 [io  0x0000-0x001f]
pci 0002:01:00.0: BAR 5 [mem 0x00000000-0x00000fff]
pci 0002:00:00.0: PCI bridge to [bus 01-ff]
pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
pci 0002:00:00.0: bridge window [mem 0x16000000-0x160fffff]: assigned
pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: can't assign; no space
pci 0002:00:00.0: bridge window [mem size 0x00100000 64bit pref]: failed to assign
pci 0002:00:00.0: bridge window [io  size 0x1000]: can't assign; no space
pci 0002:00:00.0: bridge window [io  size 0x1000]: failed to assign
pci 0002:01:00.0: BAR 5 [mem 0x16000000-0x16000fff]: assigned
pci 0002:01:00.0: BAR 4 [io  size 0x0020]: can't assign; no space
pci 0002:01:00.0: BAR 4 [io  size 0x0020]: failed to assign
pci 0002:00:00.0: PCI bridge to [bus 01]
pci 0002:00:00.0:   bridge window [mem 0x16000000-0x160fffff]
pci_bus 0002:00: Some PCI device resources are unassigned, try booting with pci=realloc
pci_bus 0002:00: resource 4 [mem 0x16000000-0x160fffff]
pci_bus 0002:01: resource 1 [mem 0x16000000-0x160fffff]
...
pci 0002:00:00.0: enabling device (0000 -> 0002)
ahci 0002:01:00.0: enabling device (0000 -> 0002)
ahci 0002:01:00.0: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
ahci 0002:01:00.0: 6/6 ports implemented (port mask 0x3f)
ahci 0002:01:00.0: flags: 64bit ncq only

Bisect log is attached for reference.

Guenter
---
# bad: [609706855d90bcab6080ba2cd030b9af322a1f0c] Merge tag 'trace-latency-v6.15-3' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
# good: [acb4f33713b9f6cadb6143f211714c343465411c] Merge tag 'm68knommu-for-v6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
git bisect start 'HEAD' 'acb4f33713b9'
# good: [cf05922d63e2ae6a9b1b52ff5236a44c3b29f78c] Merge tag 'drm-intel-gt-next-2025-03-12' of https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
git bisect good cf05922d63e2ae6a9b1b52ff5236a44c3b29f78c
# bad: [93d52288679e29aaa44a6f12d5a02e8a90e742c5] Merge tag 'backlight-next-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
git bisect bad 93d52288679e29aaa44a6f12d5a02e8a90e742c5
# bad: [e5e0e6bebef3a21081fd1057c40468d4cff1a60d] Merge tag 'v6.15-p1' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad e5e0e6bebef3a21081fd1057c40468d4cff1a60d
# bad: [dea140198b846f7432d78566b7b0b83979c72c2b] Merge branch 'pci/misc'
git bisect bad dea140198b846f7432d78566b7b0b83979c72c2b
# bad: [a113afb84ae63ec4c893bc3204945ef6f3bb89f7] Merge branch 'pci/endpoint'
git bisect bad a113afb84ae63ec4c893bc3204945ef6f3bb89f7
# good: [a7a8e7996c1c114b50df5599229b1e7be38be3db] Merge branch 'pci/reset'
git bisect good a7a8e7996c1c114b50df5599229b1e7be38be3db
# bad: [7d4bcc0f2631e4ee10b5bcfff24a423d1c3c02a3] PCI: Move resource reassignment func declarations into pci/pci.h
git bisect bad 7d4bcc0f2631e4ee10b5bcfff24a423d1c3c02a3
# good: [acba174d2e754346c07578ad2220258706a203e2] PCI: Use while loop and break instead of gotos
git bisect good acba174d2e754346c07578ad2220258706a203e2
# good: [8884b5637b794ae541e8d6fb72102b1d8dba2b8d] PCI: Add debug print when releasing resources before retry
git bisect good 8884b5637b794ae541e8d6fb72102b1d8dba2b8d
# bad: [5af473941b56189423a7d16c05efabaf77299847] PCI: Increase Resizable BAR support from 512 GB to 128 TB
git bisect bad 5af473941b56189423a7d16c05efabaf77299847
# bad: [96336ec702643aec2addb3b1cdb81d687fe362f0] PCI: Perform reset_resource() and build fail list in sync
git bisect bad 96336ec702643aec2addb3b1cdb81d687fe362f0
# good: [e89df6d2beae847e931d84a190b192dfac41eba7] PCI: Use res->parent to check if resource is assigned
git bisect good e89df6d2beae847e931d84a190b192dfac41eba7
# first bad commit: [96336ec702643aec2addb3b1cdb81d687fe362f0] PCI: Perform reset_resource() and build fail list in sync

