Return-Path: <linux-pci+bounces-43414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF2CD11FB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0D75302B672
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7DB2EBB84;
	Fri, 19 Dec 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itZ/5Etn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83422D7A9
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165054; cv=none; b=mXzCcRCwBc3nKD1X1jnBmEuDxslA8fnkKliA8SUUGx2r3R8GR+0u5oaooysWzYWoKbketZakQRXg9vr0cOvgYke/6r8IA71m9flGxMiPVJZ99EAwGxIVinjHmnEYuiX2oXxZgfNPRNlBr09KlS8mn/eFM2D+79TzQsAlXTGOic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165054; c=relaxed/simple;
	bh=g7v7idxZwwl9EGcu0pdn06DUuE6rLau6Cfr+Q033I+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXV9FStjNJeGfFJIxYDXjuYMBmACGS8GcJXV3/nwiNCX3tC7B3dhkuY+g6qGg2Toz0rzWYmqllVt27sHYwgrpCtquDJBYxpj968i7jjAHQm7urp9jMDijgDLoi+1j99gRh2CP5S80UXeGJwDZ5AJAQQ3UPgNYLcIzL2DATm1QME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itZ/5Etn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF39C4AF09
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766165054;
	bh=g7v7idxZwwl9EGcu0pdn06DUuE6rLau6Cfr+Q033I+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=itZ/5EtnEndqPtTjKJnR1RtleUdw2kXcGSLxj0H87Zg/3UJXmHlpslli5y8u1y/La
	 ejZG5+BLxb5/pgqogLP8v7QLXxqQzKi0NT1g/+2+HqFo+0xTZbzBe+oQCatjZ1olnd
	 FSLh8E8QQ9y8Bv7mNyH7jkW2lcQ9NYBTXBiL7UK9uuBXcwqm3+1Je1MQtlhDbwM4Gr
	 T36S4XhTYEimZzBacM6tZv65PYBXkNt8+kWK5B9w6J74pe6DZna/IER1hZSf39340v
	 +Fh9ZAJo70k2t9xZ5iGqMsQsHDAy1Z8+TgAKuY0xjdCYKXZiMqbz4o5alw6nil8xNp
	 eFJOJVEpLbsFA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3ed151e8fc3so1283046fac.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 09:24:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0JRl4A0Q9JMo4xfj91cYapThmAHu9cLpgXH8MLzmok12P8Tz+58/KQl0tQAazojWfTX5qMIxRbwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyfXNKZYug33Z4JjEIbY9d78+dbM5aQHXwztb60o5lHGBSBk/
	ZuMEnXGaerepnpWp79DeR1CVGJKUNSTnwM8E08QtslaO4JfCDEjYK90cZpYU33HqIkYAOcapiCr
	wBHkmLbM6RkVVpQh0qjLeBeUZyWuv5Ts=
X-Google-Smtp-Source: AGHT+IGwlyjxS+61nxvfRvGZ9rI309kSae+Mm1Pms8uRol1tFB8mm6iG65IMAUZY4eUUBrDW2kiD45T2HIC3Zb84K2s=
X-Received: by 2002:a05:6820:1b06:b0:659:9a49:8f1f with SMTP id
 006d021491bc7-65d0ea9d366mr1687515eaf.48.1766165053133; Fri, 19 Dec 2025
 09:24:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5049211.GXAFRqVoOG@rafael.j.wysocki> <10786459.nUPlyArG6x@rafael.j.wysocki>
 <20251219124639.000031c5@huawei.com>
In-Reply-To: <20251219124639.000031c5@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Dec 2025 18:24:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gvBHx2AxmuqLQO55OWw1Z9GafsWnUzRKxzaVUc4Va1rQ@mail.gmail.com>
X-Gm-Features: AQt7F2qMYDZjws0Yn0QZ6Cm0hTKqFUkTw6_fw5L3k2Huc3b2AklP4RFmhLVkhGc
Message-ID: <CAJZ5v0gvBHx2AxmuqLQO55OWw1Z9GafsWnUzRKxzaVUc4Va1rQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] ACPI: bus: Split _OSC error processing out of acpi_run_osc()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 1:46=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Thu, 18 Dec 2025 21:36:57 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Split a function for processing _OSL errors called acpi_osc_error_check=
()
> _OSC?
> > out of acpi_run_osc() to facilitate subsequent changes.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Minor request inline.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > ---
> >  drivers/acpi/bus.c |   56 ++++++++++++++++++++++++++++++++++----------=
---------
> >  1 file changed, 36 insertions(+), 20 deletions(-)
> >
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -236,13 +236,46 @@ static int acpi_eval_osc(acpi_handle han
> >       return 0;
> >  }
> >
> > +static bool acpi_osc_error_check(acpi_handle handle, guid_t *guid, int=
 rev,
> > +                              struct acpi_buffer *cap, u32 *retbuf)
> > +{
> > +     /* Bit 0 in the query DWORD of the return buffer is reserved. */
> > +     u32 errors =3D retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK;
> > +     u32 *capbuf =3D cap->pointer;
> > +
> > +     /*
> > +      * If OSC_QUERY_ENABLE is set in the capabilities buffer, ignore =
bit 4.
>
> Maybe add a tiny bit on why?

OK, I'll expand the comment.

