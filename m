Return-Path: <linux-pci+bounces-2367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC23832CB9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97799281529
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70754BC1;
	Fri, 19 Jan 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rzefv25D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CA52F61
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680213; cv=none; b=dYyH0u7ehxIZ/YzXenD7qQmZrNhP6NiJheNsd+S0W/Sj2lAQ55QBMlwmai1vahrtIrNXFsSm//d0Y6JD5DlIGudjmDjc320Di2AIT1k+yULcUGSPbbNAGj6+clmtLHsd40+IcNmm8mFtcNvAd70A5QsC6xPOaTNSNrku0edd478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680213; c=relaxed/simple;
	bh=bcLvwWccNAWsUiEj7IX0uRHJeNmfTZEkM9hsx1PnbHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7+lX/MV2QIVy3Ik014jxNrGWug8t7PE+yp+OSmy4Z6OVvXtpr+68xaGlk3ntUp0W9hOVgW9m/i8vKBb7bkLfC26MmR/ikp44HdxPDpr+Zen7icgB+EbXzGqncmM+UILR7MvOoLGZXpND7sM/AGu7W06tw8m1Nka1APbZwgyiR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rzefv25D; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b7480a80ceso1213200e0c.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 08:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705680211; x=1706285011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC2wn1ghIRgJ17BldXRyobqgCTNz3OsOecAZdsiLq84=;
        b=Rzefv25DSSBOFwICV9pImVfp1vGwQli3ewR/gkcYOSDj2aOYOOeYil9Zrd9zam8IS0
         Bst9nsXENoBtTqmdy6mRFFDkD4VPpuX9eO8X0N0MPcC0k+8akyZF/hOKROycQ3UZPo91
         MleZmAOnjP3NNmr+rRFP+lPcNQHWMDtEp7nhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680211; x=1706285011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC2wn1ghIRgJ17BldXRyobqgCTNz3OsOecAZdsiLq84=;
        b=jYEnaptBZc3DplITsxMWjaxcI4eWF+2hQuSld10n+UZjE4FVfmzATYBCgt6UisMXZA
         ukKfkHQItDchSz+HSNOoF0HXFwa/m6cwpey/ZBGyq3FodH1ALo/jiFBdXwuS7ewOM1zF
         o4O9l1rTPFuDmRAKEJviGk17maTR2jQycUcGKA+elEQEwL1X8Ks+4pAAYvf3xtJKcnGJ
         PgNKB5B4ecf6ZmRByWFAZUQG5afSA7dr7XmTnDfBotv57VmXPPjWDNwSH/DzdIYmm/o0
         f51WHMj7M0dFjsya9iGe/oxQdLE58l/Sl7b8g9ESIw0Lh0V8Suu05b01ATDVTMUBfxOL
         L8YA==
X-Gm-Message-State: AOJu0YxH1PIiiKD+y1GDAC+Wv5QEa2YqQoeJRPftRICiQv1j+McFwxXo
	FKPOTjK9C/T7QpZxANLYyIpeeGk8nQ9MPB0MEJ6PGzUNztgi2gS0uK0bE1l0h5DynnOG1wVD/ea
	XvEhSRPYuGHrK2PdmMO9B7qCFAbllgaUtRb8U
X-Google-Smtp-Source: AGHT+IGhC1DkuAVOHUbGsqhAv7kRl/8FPFEepErLnioMEXwPe0+Fk3F00JapWbWMLrHATAzVnIMljAIDoOit0HtstHQ=
X-Received: by 2002:a05:6122:2224:b0:4bb:3b8:afbd with SMTP id
 bb36-20020a056122222400b004bb03b8afbdmr194770vkb.0.1705680211307; Fri, 19 Jan
 2024 08:03:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
 <20231228132517.GA12586@wunner.de> <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com> <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com> <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com> <20240119102258.GE2543524@black.fi.intel.com>
In-Reply-To: <20240119102258.GE2543524@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Fri, 19 Jan 2024 11:03:18 -0500
Message-ID: <CA+Y6NJHhTaroqJKEvOebRvbTdgkxW8tqFvq5MrOVE9swmwmtOw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Lukas Wunner <lukas@wunner.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 1:01=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Well that's pretty much all Intel Titan Ridge and Maple Ridge based
> systems. Some early ones did not use IOMMU but all the rest do.
...
> Before Intel Ice Lake it was all discrete and it is still discrete with
> the Barlow Ridge controller who will have exact same ExternalFacing port
> as the previous models.

Next week I'll try those devices in our inventory to see if I can find
another one with this bug. I'll get back to you on that!

On Fri, Jan 19, 2024 at 2:58=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Now if I understand the reason behind this patch is actually not about
> "removability" that much than about identifying a trusted vs. untrusted
> device and attaching a driver to those. I was under impression that
> there is already a solution to this in ChromeOS kernel. It has an
> allowlist of drivers that are allowed to attach these devices and that
> includes the PCIe port drivers, xhci_hcd and the thunderbolt driver,
> possibly something else too. Is this not working for your case?

This device shouldn=E2=80=99t be treated as a removable thunderbolt device
that is enabled by policy because it is an internal device that should
be trusted in the first place.
Even so, while learning about this problem I tried modifying the
ChromeOS policy but it ended up not fixing the issue because it seems
like there is an expectation for it to see an existing =E2=80=9Cfixed=E2=80=
=9D
thunderbolt port before it loads anything else. But the fixed
thunderbolt port is prevented from enumerating during bootup, before
the policy has a chance to work.

On Fri, Jan 19, 2024 at 5:23=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> The below "might" work:
>
> 1. A device that is directly behind a PCIe root or downstream port that
>    has ->external_facing =3D=3D 1.
>
> 2. It is a PCIe endpoint.
>
> 3. It is a sibling to or has any of the below PCI IDs (see
>    drivers/thunderbolt/nhi.h for the definitions):

External pci devices seem to have the same kinds of chips in them. So
this wouldn=E2=80=99t distinguish the =E2=80=9Cfixed but discrete=E2=80=9D =
embedded pci
devices from the =E2=80=9Cremovable=E2=80=9D pcie through usb devices. My m=
onitor with
thunderbolt capabilities has the JHL7540 chip in it. From the kernel's
perspective, I have only found that the subsystem id is what
distinguishes these devices.

That is, unless I am missing something in your proposal that would
distinguish a fixed JHL6540 chip from an external JHL6540 chip. Please
correct me on any assumptions I get wrong!

