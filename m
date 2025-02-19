Return-Path: <linux-pci+bounces-21787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC559A3AFCF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 03:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33223AAD07
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 02:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD337FBD6;
	Wed, 19 Feb 2025 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZQ1VcQg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D728628D
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933460; cv=none; b=crQknHyVy5CApA/jLpM190eHsDsN9YXo9Q/SsLoNJV5KalA95SwY6BAawKFGArKI0Cec5frE5zkmCX3U/MDtJoNGn2kiM81vV1qqFJSDMzsJZV2RHjiLQ7Tfo66Nlm0h2iSqI59I9yRT201pfPQJZjRMWA/dtcHP/uewTaDXCC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933460; c=relaxed/simple;
	bh=mPMA4I5qgy88RPiPBbz7jI0nZ2bBqK7e7bM0pUd2XPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRg7To4V1WRupSaKNmYJD/D7zyEGy+u8pk/0eZOWYuEa2EM3JgwNtPavenp119+ftIzfs5pVKP2YXftaf46gGQjh5W83fMXfXOWjFpF85QT/hsNHjJhCwzJk7lPUmV2AvHf7VP7l7MyDvhdnXrKiNn9U/82as74LHmdvLnU89Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZQ1VcQg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb90f68f8cso575844266b.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 18:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739933456; x=1740538256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPMA4I5qgy88RPiPBbz7jI0nZ2bBqK7e7bM0pUd2XPo=;
        b=DZQ1VcQgxuudARtAVr0OAkFJFNLmc8AgKSaRjr67iXeDO/8/IsyDuRiaN8x04cQFmz
         WzWkN7LxCBRA3TM+o4aFRHuctmfH2VdIG7xmrC6SCGtdil/CmcbNJIA2fQtTtrXFGbXe
         GDeRoQPkuDKdqtrWeMdbQFGxmGNnJUoqGuxaR1sfWLfS/wd2Oetp3jB+Sp5B/z5Fq+/n
         5XHktXWGHhcIvpmG6We/nb4jQidkdsrFUo8OLmidgmJOv9pxpGuXeXS5mnB8rXxD057X
         8NOJ9sZT6yS7DyyiADCpV8yI/T69UpUTulwAAvLz3wHzC9Jqh93CSDlUdwlirOFBt5NN
         pU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739933456; x=1740538256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPMA4I5qgy88RPiPBbz7jI0nZ2bBqK7e7bM0pUd2XPo=;
        b=sCPwp8asfBHX45Qx572VWw51PKvolgVgDxu7Fe/LblIaISAFSe6kcIwxTzIdUzOJNx
         tzAwtxd0RpnGDjE2DAhFwtS/ARIsxAwie+Cd9or4yzxYyag0f715sAKdZlXZ9fT+LKpE
         LrWr+PzixxCASpAYc8heNBcaR3QaBB14EF78L0jz36inU6/pVA5wnrwwegm/9rsrdn5s
         uv3Yrj1q8jQxMmELWrtHwQzn8+GMVkgmVZSUe37BFjuqG69ruateJof+u4D8pwhE2hoh
         Ty4CcC8vU6lSCOeHu5qORWkQi8uyn+8EIUtj1pfJwqsE4HwFMh7bpPsySfq4XF0GyZkz
         AWEg==
X-Forwarded-Encrypted: i=1; AJvYcCXnPAM/ePfYUSdOCO6F8I8AX5yWeWjqtNtRUZYTAn4YWJpgFqQE0WT58Zaycjfm8inGOm8mx4rKYts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5pt3EQ+d+p17JypxQ6OWmWupwgx+JXQRqlil4cRJOm1RK/hd
	NSIBH1CeV6MgdAHrYjNWGmFZ8+Kx80yJ4yie0E6nCM1MrCPIBXVHqI4tbGxx/3dBUna+rconoUD
	rd0UnRSynARxfrM5px2D6usUcnahkdiOgHvzj
X-Gm-Gg: ASbGncu54qJv67zFUX1J1D8rkiGRY4hjdmHLpfk2Nbr2Myr5oL9awxEmxZYenwyhDbA
	Nb5tLnW66ayK1dJmbEz0M4X/RrA+hz2eEPaJtks1fnK94ggg7WSczmafxtfIxAK7tKeePWQLRuZ
	L5ephLtYqLscktFr5fsIzwhBh1grY=
X-Google-Smtp-Source: AGHT+IE6FgJf2M3r/vmGQR/7L7DYWfJ7qxmJZjUNExalS4SECAw3vd8c33scbmKWJW+SVSdqel60Gxyhy9J2GkFdNe8=
X-Received: by 2002:a17:906:c154:b0:ab7:fc9a:28e2 with SMTP id
 a640c23a62f3a-abb70df002amr1769807966b.47.1739933456483; Tue, 18 Feb 2025
 18:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com> <20250214023543.992372-8-pandoh@google.com>
 <38451a01-4e95-44ff-922b-8fda725eb25b@oracle.com>
In-Reply-To: <38451a01-4e95-44ff-922b-8fda725eb25b@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 18 Feb 2025 18:50:45 -0800
X-Gm-Features: AWEUYZkEPaiQrMP3dhSekZ86KNmWtYUpdqa62HFgKYEaaQlipVh4DbaLSR8XIgg
Message-ID: <CAMC_AXWYmRCQ8EWsdC-yPYsujHLZuXc7f0J_4bUuwaZgkFpP8g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] PCI/AER: Add AER sysfs attributes for log ratelimits
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 5:31=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> I don't think it's neccessary to keep ratelimits in a separate directory
> when we decided to we keep the rest of AER attributes at the dev level.

My motivation for this is that there may be more AER sysfs attributes we wa=
nt to
expose. An example being OCP Fault Management roadmap which aims to have
userspace manage/enforce AER settings (set/get PCIE AER regs) for datacente=
r
repairability.

Given the permanence of sysfs entries, I think that it is reasonable
to create a new
directory to make AER sysfs attributes more extensible.

> > +These attributes show up under all the devices that are AER capable.
> > +Provides configurable ratelimits of logs/irq per error type. Writing a
>
> This sentence seems to refer to _one_ attribute and mentions IRQ
> ratelimiting, which is not a part of the series.
>
> How about rephrasing this section to say that the attributes allow
> configuration of the rate at which AER errors are reported, with each of
> them dedicated to one error type (correctable or uncorrectable)?
> Something along these lines.

Good catch. IRQ verbiage slipped in from v1. How's this:

These attributes show up under all the devices that are AER capable.
They allow configuration of the rate at which AER errors are reported,
with each of them dedicated to one error type (correctable or uncorrectable=
).

I kept the first sentence as that is common under the other AER sysfs
attributes.

> The convention is that sysfs files should provide one value per file. It
> won't be just people interacting with this interface, but scripts as
> well. Parsing such a string is a hassle. As we can only change the burst
> of the ratelimit, I'd simply emit pdev->aer_report->ratelimit.burst.

Ack. Will update in v3 and add explicit mention of ratelimit interval
in sysfs-bus-pci-devices-aer_stats so context is still there.

Thanks,
Jon

