Return-Path: <linux-pci+bounces-8971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 117C090E8AD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0DE1F22457
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F6132102;
	Wed, 19 Jun 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3uSaA84"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C11304AD;
	Wed, 19 Jun 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794372; cv=none; b=ivElyXwrjuPLCingVIPlw7k5Ot61WMbw+bc/WCx+XSW1jw/IG80sszGoVt3np69oZJd8+1vT1oIx9MBFbJ2XrHyUhfD7szgbdgk2CRWNkanmhZULxoruVaCOiDOQpqTwv/fPm4x9BJiKY5/+nRsLsQKMPeHXs64hhnvDb8LA4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794372; c=relaxed/simple;
	bh=x6rRWvFLspQevsB2WpDwXMeeTixJq93OzwM4BU6/jhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iye1lPntt+VzWKk9p8rvPu2V5b/q4YQdgi8saMK0B/YGBXZB+lrgA6t+nDWlUXoveGF3LmqqRCTseNdyQyC5SfryK8F/c5Zu4ZdFA9GpaRM/t2d5sfXs6EvLKnwaszScUW04S5bjW5akA7YsegmfC+/wqX85rb9egWmW7NJ3T0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3uSaA84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF89C4AF53;
	Wed, 19 Jun 2024 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718794372;
	bh=x6rRWvFLspQevsB2WpDwXMeeTixJq93OzwM4BU6/jhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u3uSaA84l5gVLsWmwxrOtJWM7MF0Vu51G0CMA1IUhuxDqK7DR2yRzGOKrg5XZfJyp
	 gc1uZ0BFFh/wA26oymxl7R1SluIcT5SJ5t1Ag6XbCE5Xkm7ygActqF/NpHFUki9mlL
	 JbLwuS31tzqYMGiroNPmsUu+jF8Vggo/jU2YswgPzfH0OUyJKD3lw6P18dgkFZl/0Y
	 n5dvVHipC+NvVTsEaLa4yR6Z2kvQMtMEiStK1cuhhGDOlvFIk45u6nd3IWZNz0xwwZ
	 4TMCjh7s4W1TjzGlDdladzFqHv7/kFYAVMXWKntAeSqEk/WhLSN/siYOf+znixzC+C
	 tKhqZbYVCrBQQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-254939503baso511628fac.0;
        Wed, 19 Jun 2024 03:52:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+xyWfe5iJvRVgVyFqt4isgis/bx1GqvNReaBUFx3d2Bs/V5BKLMT0A/SQ4FC8CLEumQMio/zZ90pKkS1AOzWmnYTV9JEh8A5LOkvL1nHDzSgaiDGxtikfn8JvqiQ23io0MbJ9xYXx
X-Gm-Message-State: AOJu0Yw5cC9ycK6vWlObCi9vyBw8HGojJgkOg5ifLzsyWlW2Fzkc2nl/
	Vj9xnKJ9geX5rYLpu1QJ5DL79oawH5VCXXb+d/rzXM0gdStl9oc6EhPkeH/YHvcCb9loNsdaUFa
	pKEpiZdkS8iBSDrn/g/m2Y5vwAKg=
X-Google-Smtp-Source: AGHT+IHkfbPpplMOo0+AZF3Oi/SLUmBNejk3LQsh8tt80LEVbwbJ0RTdOmOkrR69Re/mAWO5+pPtyJBD56qHP10v7uQ=
X-Received: by 2002:a05:6820:2210:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5c1ad8a198cmr2995209eaf.0.1718794371598; Wed, 19 Jun 2024
 03:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618204946.1271042-1-helgaas@kernel.org>
In-Reply-To: <20240618204946.1271042-1-helgaas@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Jun 2024 12:52:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hZHnMbTLs3KK3ORQey=-u8SEm5H4X-eDSVzdk8s9Rn5A@mail.gmail.com>
Message-ID: <CAJZ5v0hZHnMbTLs3KK3ORQey=-u8SEm5H4X-eDSVzdk8s9Rn5A@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] PCI: Disable AER & DPC on suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Thomas Crider <gloriouseggroll@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-nvme@lists.infradead.org, 
	regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 10:49=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> This is an old series from Kai-Heng that I didn't handle soon enough.  Th=
e
> intent is to fix several suspend/resume issues:
>
>   - Spurious wakeup from s2idle
>     (https://bugzilla.kernel.org/show_bug.cgi?id=3D216295)
>
>   - Steam Deck doesn't resume after suspend
>     (https://bugzilla.kernel.org/show_bug.cgi?id=3D218090)
>
>   - Unexpected ACS error and DPC event when resuming after suspend
>     (https://bugzilla.kernel.org/show_bug.cgi?id=3D209149)
>
> It seems that a glitch when the link is powered down during suspend cause=
s
> errors to be logged by AER.  When AER is enabled, this causes an AER
> interrupt, and if that IRQ is shared with PME, it may cause a spurious
> wakeup.
>
> Also, errors logged during link power-down and power-up seem to cause
> unwanted error reporting during resume.
>
> This series disables AER interrupts, DPC triggering, and DPC interrupts
> during suspend.  On resume, it clears AER and DPC error status before
> re-enabling their interrupts.
>
> I added a couple cosmetic changes for the v9, but this is essentially all
> Kai-Heng's work.  I'm just posting it as a v9 because I failed to act on
> this earlier.
>
> Bjorn
>
> v9:
>  - Drop pci_ancestor_pr3_present() and pm_suspend_via_firmware; do it
>    unconditionally
>  - Clear DPC status before re-enabling DPC interrupt
>
> v8: https://lore.kernel.org/r/20240416043225.1462548-1-kai.heng.feng@cano=
nical.com
>  - Wording.
>  - Add more bug reports.
>
> v7:
>  - Wording.
>  - Disable AER completely (again) if power will be turned off
>  - Disable DPC completely (again) if power will be turned off
>
> v6: https://lore.kernel.org/r/20230512000014.118942-1-kai.heng.feng@canon=
ical.com
>
> v5: https://lore.kernel.org/r/20230511133610.99759-1-kai.heng.feng@canoni=
cal.com
>  - Wording.
>
> v4: https://lore.kernel.org/r/20230424055249.460381-1-kai.heng.feng@canon=
ical.com
> v3: https://lore.kernel.org/r/20230420125941.333675-1-kai.heng.feng@canon=
ical.com
>  - Correct subject.
>
> v2: https://lore.kernel.org/r/20230420015830.309845-1-kai.heng.feng@canon=
ical.com
>  - Only disable AER IRQ.
>  - No more AER check on PME IRQ#.
>  - Use AER helper.
>  - Only disable DPC IRQ.
>  - No more DPC check on PME IRQ#.
>
> v1: https://lore.kernel.org/r/20220727013255.269815-1-kai.heng.feng@canon=
ical.com
>
> Kai-Heng Feng (2):
>   PCI/AER: Disable AER service on suspend
>   PCI/DPC: Disable DPC service on suspend
>
>  drivers/pci/pcie/aer.c | 18 +++++++++++++
>  drivers/pci/pcie/dpc.c | 60 +++++++++++++++++++++++++++++++++---------
>  2 files changed, 66 insertions(+), 12 deletions(-)
>
> --

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to both patches in the series.

Thanks!

