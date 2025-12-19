Return-Path: <linux-pci+bounces-43442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02766CD1CCF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 21:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 657823084A9D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEBD2E88B0;
	Fri, 19 Dec 2025 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2fRtwHw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C212E6CD5
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176737; cv=none; b=WY4EUZVkx6M971kFb5e97feone+QELBpsBPlzVFZ+VMM7EpFJ1Hmh2rQd66KW31Uh0KalZEN39UHX5m6x4YWVyH/brhzsYs3i3aOLgMjFyX4acpVjX473QY82D281LVL+Ev44Plp9pCZNcqa7Ww3wuuw8BU1GGvl2ZvHAVt9KTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176737; c=relaxed/simple;
	bh=7MQxHdBah0ML4bAcIMYzoH8Q6NX7+IStQQKHoOCifDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDIRnJy3Sr5z3aMnCpDCwLO8EQ6y0nxl6p16LjXA2wISDSU+39XIBCu4J+WMuG3cYH0MY8KRhXZmwbL9NfS2a/7HZeGdbIy84pFBmV0Xip6P3c7hdM198V7IDBQvGjdRY/Ml2o5djtyx7QWRbvNc3+12OKtH4rvkH03zdbangWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2fRtwHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11D6C19424
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 20:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766176736;
	bh=7MQxHdBah0ML4bAcIMYzoH8Q6NX7+IStQQKHoOCifDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W2fRtwHwM1WopYhRi1cWQhhb425235yq60PRrWZpddod1723eN2/WGLlaE45L6nMO
	 aNXsf5+E14033+QRGN/j/aoQ1DteUuj8UQKhIaSyfyNRbtd9EjpfjEUDYFvrFWjMk6
	 ZTqodp0391+qUy4bhDXRVxEogkkeBevLMgOenyaw+IlOqTIrbRaUOq4sXmt43jox2q
	 irTqj7lPyf0zCt9y2la2vUBCwvy/uPZlWvMTyL87LNiKNVqCLQ5WhPuMNphairfFku
	 Tv3fjTyyxktzXex0JTPxMVJl6rITFszKe3/3Jrm5Kmm19KLHhySfgq8nQDTBdUxf3M
	 ZSbFfRMWzLo0w==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3fa139e5d90so802378fac.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 12:38:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmQI39K/8ODI0QdLBlOmCr6q3yJ0qcO9+amknsls6yIb1f/HsCJBnpNVtP0BG5rG28g7cLA/+Gz5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzTZy/+fSrcDgxkR8+H3bUXZjgEMfTMCYymoyKQnSJhENgWb4
	U/TgenJGcxUYv2jiNlLCBZ5UoL1hlHzVyYNRj9ndlH05itpHrQfLIFWk6xEHHoYPzTs5B+VImGv
	Vj1vY/YHy15Ui3A3D74dh9tVFk2ug8UM=
X-Google-Smtp-Source: AGHT+IE+3/YBFazCnYLF+aNwuAsPkLBq0YGZbDpjOWVFTlJyhpo9yqws1BKd8A+1CRWyLY80BDKnlccQ7zJLT257Ua4=
X-Received: by 2002:a05:6820:162a:b0:659:9a49:8e0d with SMTP id
 006d021491bc7-65d0ec0cb4fmr1897747eaf.79.1766176735905; Fri, 19 Dec 2025
 12:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5049211.GXAFRqVoOG@rafael.j.wysocki> <2261695.irdbgypaU6@rafael.j.wysocki>
 <20251219122620.00002049@huawei.com>
In-Reply-To: <20251219122620.00002049@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Dec 2025 21:38:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hnyBCv-=nq5XbimupJ5T9DS9f4eCgDEC2SiH1gw3zH-A@mail.gmail.com>
X-Gm-Features: AQt7F2p7o2-hlUURGmmE4LXj9kh2YbRtJ-oXKyzs-Q0R1I2eezY9FRGUtF3HqI0
Message-ID: <CAJZ5v0hnyBCv-=nq5XbimupJ5T9DS9f4eCgDEC2SiH1gw3zH-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] ACPI: bus: Fix handling of _OSC errors in acpi_run_osc()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 1:26=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Thu, 18 Dec 2025 21:34:26 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The handling of _OSC errors in acpi_run_osc() is inconsistent.
>
> I wonder if this would be easier to follow with a brief statement
> of why we threat OSC_CAPABILITIES_MASK_ERROR as an error in the first
> place for non query cases?  It took me a brief think and spec read
> to figure that out, but maybe more coffee needed.

Well, this is a good question and it is not obvious IMV.

The current code treats it as an error, but arguably it is not really an er=
ror.

If it is a query, it doesn't even make sense to print a debug message
for it, but if it is not a query, the feature mask in the _OSC return
buffer still represents the feature that the OS is expected to
control.  So print the debug messages, but do not fail in that case.

I'll update the patch.

