Return-Path: <linux-pci+bounces-12388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B79633B3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 23:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BBE1F214A5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366831ABEC8;
	Wed, 28 Aug 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TBiLe0vj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A945C1C
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879737; cv=none; b=JYBgp1SZZujcIJyl5yBhQTPQZ2HgE1niii+bQXuOOZYAkeGF5h0bJzJXpw7y3+cPJzFvTq9Cxzrwqll5QJx4NtyxAOq64BNz3e5/fDeJLw7OpmXTqEyAFR/1g+9j6P/JNiDXr18Qqw0gH4yT/D1MnvPWNHUirt38qI2QQjEpke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879737; c=relaxed/simple;
	bh=rZ0hzRuydgbsTmzNxJW5qDg7GgFGEViAZUQW/xwoQg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAG+63GaeNUncjy5rDjOqYv4PAuz7oIiR8rb4BKYU1+gaEaxafTcuUgB2net0NG6FkbGPc2TC7OXUKEbxDN3r1AL/pPIGRQB1OlDkbne7OITB+848+cE8Pm78/8EEXjvEJmNE+T2650hGS37LwFHkiCac1IbS2qbH09Rr1IWit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TBiLe0vj; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3df07543ed5so27871b6e.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724879735; x=1725484535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wroWp6ZdRx4y4EGEIviQ1d0CtpBbTRnZ8bxPpcNXhAI=;
        b=TBiLe0vjaf36ftvRiYxFcrVq1iqjr+3zy/fT7Q1yy1IzCUD7zT6gYvsEqx/wrTVQvl
         ymSRKKT3tUCTieMWMlrtdw+ErPwKK/cH70D5XUutZU6QHTUFDcWhoKInR3Hz4ykwjKFi
         wCMkK22euHZamSB3MBO0WqGEIG0W3SBMdmUMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879735; x=1725484535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wroWp6ZdRx4y4EGEIviQ1d0CtpBbTRnZ8bxPpcNXhAI=;
        b=WlfdAFoYCUbvUGbJH7K5sxZM8s7tZ6htNXFgdCjfa13nDm1cCAwYh8RW0OWKpGInS/
         /JaOlXRM6Og5tYn/Dxd5dMV3bamHsLDilA/AN4fTY2WKeWVZjk50FAmdcsejmQwgOEug
         lNaDOM8I0lT9G3BPadNAW5k0VbzENI4Hn8P6fimVBUDE6UhIriA6b9gQdjt8WQn1qU1c
         uCCMtJX4achO/Ct3FfR7VkAX53/P50js2eGH8EEJq8r49svZ5gHvpMFtHsWZTuDIJErd
         1oP9Mz8dPafHeM969ratpSwnj7B5qzxds9umah8POQRkQRayFjoUbdIubDJqRqN7MnPq
         jGUg==
X-Forwarded-Encrypted: i=1; AJvYcCW4MR/hC+j+KkxPZol2y0qRmOzzGpTULBjlq9NREp/9sYDawi97qnHa00PUpzAFcjOPpBM+AqzbKmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXuve4ZvxHU0hfsDiGx/a6yOaKHMZj8EncE3nkEQkGdCQi1Lsw
	84DImKZeUpc7qS6jkemovxwH9r+YPlo7ZM4zqxj6f6oS7wmBGwTWLFVSbDbFDzpRD1gyrGyZEl5
	o+VE2LLBrW2fs4UHnGAwODPu6BddMoFgcTtw7
X-Google-Smtp-Source: AGHT+IHpc1TwQ/elzvJfTT8LvKlPqSoX8Jgij02Zkapj6rbYbejYym0vJh0kKtUwFwrIDA0pdyfbKUIckcCIzSc/5qU=
X-Received: by 2002:a05:6870:1586:b0:260:ebf7:d0e7 with SMTP id
 586e51a60fabf-277900cfd7dmr1020924fac.15.1724879734799; Wed, 28 Aug 2024
 14:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org> <ZstCyti3FHZIeFO8@wunner.de>
In-Reply-To: <ZstCyti3FHZIeFO8@wunner.de>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 28 Aug 2024 17:15:24 -0400
Message-ID: <CA+Y6NJE1p-nidmCZzJ7j-mJAmCLmC2q2meUf-5FFSWofWES-qA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	iommu@lists.linux.dev, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 10:49=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> > +{
> > +     struct fwnode_handle *fwnode;
> > +
> > +     /*
> > +      * For USB4, the tunneled PCIe root or downstream ports are marke=
d
> > +      * with the "usb4-host-interface" ACPI property, so we look for
> > +      * that first. This should cover most cases.
> > +      */
> > +     fwnode =3D fwnode_find_reference(dev_fwnode(&pdev->dev),
> > +                                    "usb4-host-interface", 0);
>
> This is all ACPI only, so it should either be #ifdef'ed to CONFIG_ACPI
> or moved to drivers/pci/pci-acpi.c.
>
> Alternatively, it could be moved to arch/x86/pci/ because ACPI can also
> be enabled on arm64 or riscv but the issue seems to only affect x86.

Thanks for the feedback! Adding an #ifdef to CONFIG_ACPI seems more
straightforward, but I do like the idea of not having unnecessary code
run on non-x86 systems.

I'd appreciate some guidance here. How would I move a portion of a
function into a completely different location in the kernel src?
Could you show me an example?
I'm assuming you'd want me to write another function elsewhere.
Shouldn't it be in some existing file in
`include/linux/platform_data/x86`? I don't see `arch/x86/pci/`
included anywhere.
Or would CONFIG_X86 be sufficient? (instead of or in addition to CONFIG_ACP=
I?)

