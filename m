Return-Path: <linux-pci+bounces-3720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0785A20B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92ECBB21C37
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 11:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBB72C1A5;
	Mon, 19 Feb 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="kpLzs6uM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD028E39
	for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342542; cv=none; b=b9VQt/zF9ahM0XT1t94YVy9RQkJj1SWUFkC4Q6JD95hP2qcwc3zti/F+o1opl0lmZwuRKTG/TOoPdtV3xNAILjTm3/xmzO9KFlSBLmfuvDW/Fqrr8yN10iulTERnAzKYbOhyES/d/7gbftMr2LbHCwdxwpC7ESBss2wltxUS3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342542; c=relaxed/simple;
	bh=gbALrddErfrqPTXShtUwM+T8XXo3d7O3TSnDO0Eh7xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYoMYa4+WWgIztpsjqrXH8VmxBVjncD1wxgSiz+zeePH5zMcc7jMME4duUR4tYIOWFGFAnnbCKnb/2J9wphEM3o6KvxDiFOrzXO7QWwqA5fwv9au2PluiBPJYk0keI8mB21LPwpMwKPMCi/Ivg4UbkE+FsAIr5DoQ4AO0cU8oeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=kpLzs6uM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6080f51bf0aso1798967b3.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 03:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1708342540; x=1708947340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wva+EmFcBirATjd5TWYv8SP3tCcrLwwYurAHa3W9HRM=;
        b=kpLzs6uMjhxZJb7icRAk42AsLFuNbaMJZj2ONo6c+7zGVTi/ybf4NgN6xNnimLvqQQ
         aBV0Y44X+3zCTtixlHXd+9YxeN56WlYUUAw8IvzdHvI1LQgF+12qDjiD2LvITC9eXhTS
         nI91wrgtIzbN5kqj3uoxwEt9D49Ku9ZB9m6iByHTZ0FacKfhEvEQeEmYbXw7tmWon9mw
         U83L/2UyNLyx/QlQ9S5MOhbRQolra1XC2nlsM2eneifZPUrsJtxjFu52KQkloNvsEGrw
         EJC1SS3vpL9t++ltg2zy0RH6hyHF0AlYM4qQWhA6lE6WHlG68PXv8+RYofJZe7j2sgVJ
         BkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342540; x=1708947340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wva+EmFcBirATjd5TWYv8SP3tCcrLwwYurAHa3W9HRM=;
        b=OQMy4AAI3Cj0EKney4Kvodnqv6cNa4L4GA+rDPubn0yX7a0j0GiV2BPa6ywFDvqa3j
         5VVdSL97OgvqhzkmvJPf9ChZT+E8UCprwA71CY7U9IfOQzxjRlLy2ZeY2LbC5ryDQ7ms
         V0ZYjHYOMAwKj722zQGDpkDwzEFLBo099asr7RVg2ii1kK3+8p8+gjB9wf8pOZHYKBBn
         f5lNsDN8ItMwrbFUCcnfBP0+fXVqhvBUxtd8KbPjOZLlhsRa47idHaEv42iVowRoHzs6
         clXf9j+3lxB5HrV7ffrRXWOlK6MfgzP1HaIkHpboxsi6PhrIJY5HnzNbE2QOgA9/cnpU
         ezhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIcOpI5gomb0AOeMpXOCSswvZbwyuZEHqjkysacjqBwEp2vDy4+RuQkqW8mQ1QEyMAVjag7fPqLGooiaPon8WJ68C/Dz+4bKT4
X-Gm-Message-State: AOJu0YxiDKRPTGEBBEpuYiEq6I1xRUk2alRLJTM2iOLruQn1QfAqhEg2
	bUN9d0ZsLx5pmKNcJ5p8wDo5D9TYo/Rq/dfIjjH21D5AzTxhZevSHox07rzEZ96UizGylPbPYze
	88tmlaUiC0ifUnwEhrdBJSE3zC1M265qCss3esA==
X-Google-Smtp-Source: AGHT+IGDdacL0TAZ7yJyspFhEqpglS95Pn0FT4r6XPlrF3TFfPKwVmK4ASnL9/+uSFZJkA0VuRZY3QuVlY/ZgDd3jP8=
X-Received: by 2002:a25:b04d:0:b0:dcc:82d9:776b with SMTP id
 e13-20020a25b04d000000b00dcc82d9776bmr6556242ybj.6.1708342540012; Mon, 19 Feb
 2024 03:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207200538.GA912749@bhelgaas>
 <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
 <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com>
 <9654146ac849bb00faf2fe963d3da94ad65003b8.camel@linux.intel.com> <CAD8Lp44tO_pz_HZmPOKUQ-LEQT=c856eH52xWL9nBtAtJwjL1g@mail.gmail.com>
In-Reply-To: <CAD8Lp44tO_pz_HZmPOKUQ-LEQT=c856eH52xWL9nBtAtJwjL1g@mail.gmail.com>
From: Daniel Drake <drake@endlessos.org>
Date: Mon, 19 Feb 2024 12:35:03 +0100
Message-ID: <CAD8Lp46dPtE12ai8srt9Bz3awnkkb1LZz_7FQuF57M=LaUSaCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 9:36=E2=80=AFAM Daniel Drake <drake@endlessos.org> w=
rote:
> On Thu, Feb 8, 2024 at 5:57=E2=80=AFPM David E. Box <david.e.box@linux.in=
tel.com> wrote:
> > This does look like a firmware bug. We've had reports of D3cold support=
 missing
> > when running in non-VMD mode on systems that were designed with VMD for=
 Windows.
> > These issues have been caught and addressed by OEMs during enabling of =
Linux
> > systems. Does D3cold work in VMD mode?
>
> On Windows for the VMD=3Don case, we only tested this on a BIOS with
> StorageD3Enable=3D0. The NVMe device and parent bridge stayed in D0 over
> suspend, but that's exactly what the BIOS asked for, so it doesn't
> really answer your question.

Tested on the original BIOS version with VMD=3Don: Windows leaves the
NVMe device (and parent bridge) in D0 during suspend (i.e. same result
as VMD=3Doff).

On this setup, there are 2 devices with StorageD3Enable flags:

1. \_SB.PC00.PEG0.PEGP._DSD has StorageD3Enable=3D1. This is set
regardless of the VMD setting at the BIOS level. This is the flag that
is causing us the headache in non-VMD mode where Linux then proceeds
to put devices into D3cold.
This PEGP device in the non-VMD configuration corresponds to the NVMe
storage device. PEG0 is the PCI root port at 00:06.0 (the one in
question in this thread), and PEGP is the child with address 0.
However in VMD mode, 00:06.0 is a dummy device (not a bridge) so this
PEGP device isn't going to be used by anything.

2. \_SB.PC00.VMD0._DSD has StorageD3Enable=3D0. This VMD0 device is only
present when VMD is enabled in the BIOS. It is the companion for
00:0e.0 which is the device that the vmd driver binds against. This
could be influencing Windows to leave the NVMe device in D0, but I
doubt it, because it can't explain why Windows would have the D0
behaviour when VMD=3Doff, also this is a really strange place to put the
StorageD3Enable setting because it is not a storage device.

> On Linux with VMD=3Don and StorageD3Enable=3D1, the NVMe storage device
> and the VMD parent bridge are staying in D0 over suspend. I don't know
> why this is, I would have expected at least D3hot.  However, given
> that the NVMe device has no firmware_node under the VMD=3Don setup, I
> believe there is no way it would enter D3cold because there's no
> linkage to an ACPI device, so no available _PS3 or _PR0 or whatever is
> the precise definition of D3cold.

Checked in more detail. In Linux, the NVMe device will only go into
D3hot/D3cold if the ACPI companion device has an explicit
StorageD3Enable=3D1. However, in VMD mode the NVMe storage device has no
ACPI companion. Code flow is nvme_pci_alloc_dev() -> acpi_storage_d3()
 -> return false because no companion.

The VMD PCI bridge at 10000:e0:06.0 that is parent of the SATA & NVME
devices does have a companion \_SB.PC00.VMD0.PEG0
However, the SATA and NVME child devices do not have any ACPI
companion. I examined the logic of vmd_acpi_find_companion() and
determined that it is looking for devices with _ADR 80b8ffff (SATA)
and 8100ffff (NVME) and such devices do not exist in the ACPI tables.

Speculating a little, I guess this is also why Windows leaves the
device in D0 in VMD=3Don mode: it would only put the NVMe device in
D3hot/D3cold if it had a corresponding companion with
StorageD3Enable=3D1 and there isn't one of those. What's still unknown
is why it doesn't put the device in D3 in VMD=3Doff mode because there
is a correctly placed StorageD3Enable=3D1 in that case.

Daniel

