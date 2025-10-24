Return-Path: <linux-pci+bounces-39250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F5CC05397
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F248D3B98F8
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA003064A3;
	Fri, 24 Oct 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePRmMW7/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A6305E09
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295740; cv=none; b=iPIQYgfxBMx/6wBtg33lsklKf0u1eViMwq9bkVSj6SEaMkptYYIfg/vlvtitG2RLOwtRHN+7wZspq84XC2wLwi7pRUMyQqyYuBbDzlZDZK5qejl5Rk/XmxanySgEqufL5vhKpTMKXnfWs38X3iNLjD7kUEmHYmVq0Qt9xW/Ec8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295740; c=relaxed/simple;
	bh=ztHIOhEiiaqBoopvTIXqOUqJUfk2HMRNxwUoONlyffU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k53Co5VsY/niypBdPD14kG/yHVipYSM8p6IsDbvJ5s9EehIlzC/ittOzlHOCkKocpR0G0fKnaoT7uR8kDg/myL5/6f5xmK2yBVNhyZs+i3L0rqzghE6i9R9C6NKL36+vE41dRy3PLMLwykt/c8sKXJvcoob562N7dmR6VI+TJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePRmMW7/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378d65d8184so24287701fa.0
        for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761295736; x=1761900536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4kJQLU7HkQQtlqv3b3bm8HqvzrF9H7Chbd+Noruans=;
        b=ePRmMW7/EJ3T5kaynQgUdTh/i2uC22RIqoPAFXDGZlwofd4XUy0p/6v3MQ+o0SInzI
         Cvp8KK6C48u5s8Dx1WERvhtxR9heJtx+YOXPK34AyRjNq/kEUbeoWX41PDrWIHI3yuGZ
         YANelvWiJcZ2qlIVlnuX41GmQ1yPGoOq8eFO3+FGK9uqfS235r7mg3uwtpsDRuATos+7
         04dNIw3OiMj/xeD4uL5cWCxyPbraVB6g3pLXyARo7AzDEPuDCOXWeCOy5USm+0sJXBgN
         r2+Rdpz9/cDwBogHV+a/Lul+j2Vd+KtNuaw/ZzZrcQZu90OHsUuM3DESbtMsc092sAzY
         dqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295736; x=1761900536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4kJQLU7HkQQtlqv3b3bm8HqvzrF9H7Chbd+Noruans=;
        b=Ua6dDOHonDkT9fU/4SMvReEHY2VJGPd3u8mY0YyGz7QnarQd7C4COESTINQY3Zx+Su
         2u/IjjDy+tukaXmV+ggnnps9S9HN7mP9IG4A2IrELH20rCwhEAXTEe2YtNe8fz9V89Cf
         vXWbjHu7C5mE/FsgSuzen632BftWQ2jiWvyScjONWrVCemCAgQ/jMADnebJHjrY1k+YV
         HHXaD1TV3BevQir1IFvXuCFt8qxdv2JXkWnLerxlbaGkNjjyYPUi2b+9xCkkrEWnRkzK
         4XlM70zBXvgczRt65y7GzRw1Sps0dawAyqlTeb17UMpwhb9uvo2jK3DkKbrBwwe2GLee
         qYmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZElAbz5bzQC5WKsuy+sqn3CDdEWbQdX6hZguh820vwBuYk/zU8wDjsOv240iS4lZGgl/zLHOKTOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbpsHzFrqac0WJORzwxciovskBuxxM+ICLaL526JjSCfHWmnCK
	GsvvVZG3eVQHIDMAEfUVLQh6u1mAd647nIyjVk6W9ZapKce7IGo2dKSf
X-Gm-Gg: ASbGncuzQ9nZXJtmeCEs4+2YWMJYF8yFaC9tuupxI//+A/snrT/Ap5SHWBwgPMy+hu9
	AoXdV4ARLGmEp0k78rXYomgVRqa3+B81I9e+FxEIsDWQWTsxuzN+91lXpRFitSj9ZM1SJf8ktoo
	2Lme0eigZn+kHUlPLj+VWobPmj9jaXOTnzAPfyysHDeXm8M98cBTVV2YlcDHliGXJwjHe7LUukL
	B8OoIA4sb4WKLjoEMKodkMTuB3hdKlAZIw59yP6c8knU1fmXUsOfKP3Fd23SB2Sj/yOFtitKox+
	SIO2+JbS6h6SjKryqWlevchgiyPlTDPunLJOntzCIJOv07JHw/R3Al+ndhgtGXYhJPiU6cJpg2I
	LPd4jMO/PXQv08Yml5aeEXaD6LJxeNb8frAJoLjoTi2fs5QKX8t/6UmNPdV32hbUzia+ktGqoHb
	tkW13RGI1ZoWujgnUJFnImCxUsxGAL9DnC4chCFg==
X-Google-Smtp-Source: AGHT+IESgU7Y4+mcfFfkHpukwGwbt1gtrw7F8TBkSlObe6I2/8SHRwyJCnz9Y0OqCyB02ZUjj1l7Gw==
X-Received: by 2002:a05:651c:1545:b0:378:d65a:9ceb with SMTP id 38308e7fff4ca-378d65aaa18mr14578941fa.24.1761295736186;
        Fri, 24 Oct 2025 01:48:56 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378e8b6d2dcsm769061fa.23.2025.10.24.01.48.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Oct 2025 01:48:55 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:48:51 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux@roeck-us.net, mario.limonciello@amd.com,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251024104851.4d3030b0.michal.pecio@gmail.com>
In-Reply-To: <20251023190901.GA840389@yaz-khff2.amd.com>
References: <20251022011610.60d0ba6e.michal.pecio@gmail.com>
	<20251022133901.GB7243@yaz-khff2.amd.com>
	<20251022173831.671843f4.michal.pecio@gmail.com>
	<20251022160904.GA174761@yaz-khff2.amd.com>
	<20251022181856.0e3cfc92.michal.pecio@gmail.com>
	<20251023135935.GA619807@yaz-khff2.amd.com>
	<20251023170107.0cc70bad.michal.pecio@gmail.com>
	<20251023160906.GA730672@yaz-khff2.amd.com>
	<20251023202503.72987338.michal.pecio@gmail.com>
	<20251023190429.GB796848@yaz-khff2.amd.com>
	<20251023190901.GA840389@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 15:09:01 -0400, Yazen Ghannam wrote:
> On Thu, Oct 23, 2025 at 03:04:29PM -0400, Yazen Ghannam wrote:
> > On Thu, Oct 23, 2025 at 08:25:03PM +0200, Michal Pecio wrote:  
> > > On Thu, 23 Oct 2025 12:09:06 -0400, Yazen Ghannam wrote:  
> > > > The kernel seems to think there are 6 CPUs on your system:
> > > > 
> > > > [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs  
> > > 
> > > I wonder if this code doesn't break systems which actually support
> > > hotplug, when some sockets aren't populated at boot?  
> > 
> > I don't know about other vendors, but we don't do physical CPU
> > hotplug. CPU hotplug, in this case, is there are physical CPUs
> > already in the system, but they are not enabled for whatever policy
> > decision. They could be disabled in BIOS, and so the MADT entries
> > will reflect that. Or they can be disabled by kernel parameters.

Thanks for the explanation. Looks like your patch is correct then
and we need to fix the topology somehow.

> Sorry for the rapid emails. Here's another interesting commit:
> f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")

I have this commit on 6.12 but it doesn't help.

As I understand, APIC ID is a bitfield of the form:

[package ID] ... [core ID] [thread ID]

In my case, per debugfs:

domain: Thread     shift: 0 dom_size:     1 max_threads:     1
domain: Core       shift: 2 dom_size:     4 max_threads:     4
domain: Module     shift: 2 dom_size:     1 max_threads:     4
domain: Tile       shift: 2 dom_size:     1 max_threads:     4
domain: Die        shift: 2 dom_size:     1 max_threads:     4
domain: DieGrp     shift: 2 dom_size:     1 max_threads:     4
domain: Package    shift: 2 dom_size:     1 max_threads:     4

So my phantom APICs simply look like another package with weird
non-sequential ID. (Probably not an ACPI spec violation yet?)

f0551af02130 only rejects disabled APICs in the same packages as
enabled ones. An earlier proposal in that thread was to reject all
disabled APICs on bare metal unless explicitly "online capable":

https://lore.kernel.org/all/87sf15ugsz.ffs@tglx/

This clearly goes against fed8d8773b8e and it seems to go against
what you wrote about AMD BIOSes potentially marking CPUs as disabled
in MADT and presumably allowing OS to wake them up with ACPI?

You asked elsewhere what happens if I online CPU5/6. I don't have
directories for them in /sys/, so not sure if I need any extra steps
to make them appear, or the kernel considers those CPUs bogus for
some reason and amd_nb could do the same?

Bitmaps from /sys/:
/sys/devices/system/cpu/enabled:0-3
/sys/devices/system/cpu/kernel_max:5
/sys/devices/system/cpu/offline:4-5
/sys/devices/system/cpu/online:0-3
/sys/devices/system/cpu/possible:0-5
/sys/devices/system/cpu/present:0-3

I tried 6.18-rc2 and it's same thing, except EDAC and GART don't work.
On both kernels, possible_cpus=4 fixes it:

[    0.072066] CPU topo: Limiting to 4 possible CPUs
[    0.072074] CPU topo: CPU limit of 4 reached. Ignoring further CPUs
[    0.072082] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.072084] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.072086] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.072089] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.072090] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.072097] CPU topo: Max. logical packages:   1
[    0.072097] CPU topo: Max. logical dies:       1
[    0.072098] CPU topo: Max. dies per package:   1
[    0.072103] CPU topo: Max. threads per core:   1
[    0.072105] CPU topo: Num. cores per package:     4
[    0.072105] CPU topo: Num. threads per package:   4
[    0.072106] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
[    0.072107] CPU topo: Rejected CPUs 2

