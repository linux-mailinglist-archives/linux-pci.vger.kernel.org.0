Return-Path: <linux-pci+bounces-43602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C39ECD9E91
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB166300EA1B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B432E2DEF;
	Tue, 23 Dec 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcOvFjqg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EDE2DA77E
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506448; cv=none; b=T2cs/5h7Fk+XK65qJiEcljI5AWjgmRQPZmUVpc+WytblYG/QdJpmbZ++n3MGUdrXh64q7eertIeMnK8iinK4Fb8h8KJFwSZVJ9jcRj7zX7J6/XVDFIkWxs0fOdfro5uM6wYO62ghLVA4UF5EV082qy4g7bgn2tH8a1D1XUCxHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506448; c=relaxed/simple;
	bh=jOJvb/c/LP7iQlRmzr6t7IKIeRPUA7elH42S1yBiDo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQrN5wcHE/JbwVSwanWBKRW+4/qDt//UxAhbbevmYRIr2lWYVMgonXW10laTjhBXpmTeG7wDcoNFQTBoSJe/Wjer5bZMANrxmm4TcYhOs9mA4ue1Kz77sU5HZmCCsO2fhC+wDJasmm4Xsh4OeMzCrk6cL6ULAeakQNqPOslTn8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcOvFjqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760B9C19424
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766506447;
	bh=jOJvb/c/LP7iQlRmzr6t7IKIeRPUA7elH42S1yBiDo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NcOvFjqgv1CpJyNJ1V64dD8Fsmfp4tUxf+eMEl4wtWOgqkwyBaevpen1qBU6xJMQH
	 9V8wtwxKUicm392HoRXuyDSrPbT15qekhBX9tAjgWrIaftZEi5NdY1owlSgwhxitXQ
	 FxyFXntQsUUdjccD+iSO5THsunM88vMsxY0rpB5wZEEEstamlgdyov6+RpuIex31l2
	 zqMdrLq0z9ztTsyj3WVntoBcjZRmbTEHXedNe/TxNWgaBYiHIUfw9tS7Laoee44zak
	 VQbgmyYmXq964bDKxTJnmfTztQhbwdQRYYIcu5NLk7qDwDI+8gYz4Xk/6inS102/P4
	 hIMXIDf12TbGg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7caf5314847so3224800a34.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 08:14:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTuRJA5hYM19IRNXjngjBUF8FuOMB5xCBcJk5rDB3NcgNdX16NH0znxpfy0BzTixaAAVEQf/L4sdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WyEIR0U8BrZJEEDllV79BjNp8wCCyzAD6W9hAJ6FGdXptMJ0
	lLH9MyTPZis+yN4jm0h59xI1tvMSb3heF9Lkno6bT32BQAgTWpLF2IjhvdoIOAVAbBCkfLs9hZz
	YAxtHdv4esSeFTZTUgarjnPGW2uF2pT8=
X-Google-Smtp-Source: AGHT+IHDGB/lVrrd1mvqVkTN59z5wrMUPq02VPbT4JwrllBJx7qu6NmHgKJCRAYr6eN2oh1Ouv3cfAfystYI+sj+FNU=
X-Received: by 2002:a05:6830:2e07:b0:7c7:5f09:879c with SMTP id
 46e09a7af769-7cc66ace8b3mr8401173a34.26.1766506446544; Tue, 23 Dec 2025
 08:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2413407.ElGaqSPkdT@rafael.j.wysocki> <3042649.e9J7NaK4W3@rafael.j.wysocki>
 <20251223111207.0000595d@huawei.com>
In-Reply-To: <20251223111207.0000595d@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Dec 2025 17:13:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h5gQtPBw-KBrdrSqwmx1qdcv0r3bmXe8h9YqoEd=L5YA@mail.gmail.com>
X-Gm-Features: AQt7F2rxYUihUeZ3XGUW4pn3mX7gwcTV52YD2g9BE48cgwbSauHwpeMYd6Xd4hE
Message-ID: <CAJZ5v0h5gQtPBw-KBrdrSqwmx1qdcv0r3bmXe8h9YqoEd=L5YA@mail.gmail.com>
Subject: Re: [PATCH v2.1 1/8] ACPI: bus: Fix handling of _OSC errors in acpi_run_osc()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 12:12=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 22 Dec 2025 20:05:44 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The handling of _OSC errors in acpi_run_osc() is inconsistent and
> > arguably not compliant with the _OSC definition (cf. Section 6.2.12 of
> > ACPI 6.6 [1]).
> >
> > Namely, if OSC_QUERY_ENABLE is not set in the capabilities buffer and
> > any of the error bits are set in the _OSC return buffer, acpi_run_osc()
> > returns an error code and the _OSC return buffer is discarded.  However=
,
> > in that case, depending on what error bits are set, the return buffer
> > may contain acknowledged bits for features that need to be controlled b=
y
> > the kernel going forward.
> >
> > If the OSC_INVALID_UUID_ERROR bit is set, the request could not be
> > processed at all and so in that particular case discarding the _OSC
> > return buffer and returning an error is the right thing to do regardles=
s
> > of whether or not OSC_QUERY_ENABLE is set in the capabilities buffer.
> >
> > If OSC_QUERY_ENABLE is set in the capabilities buffer and the
> > OSC_REQUEST_ERROR or OSC_INVALID_REVISION_ERROR bits are set in the
> > return buffer, acpi_run_osc() may return an error and discard the _OSC
> > return buffer because in that case the platform configuration does not
> > change.  However, if any of them is set in the return buffer when
> > OSC_QUERY_ENABLE is not set in the capabilities buffer, the feature
> > mask in the _OSC return buffer still representes a set of acknowleded
>
> typo: represents

Thanks, fixed while applying.

> > features as per the _OSC definition:
> >
> >  The platform acknowledges the Capabilities Buffer by returning a
> >  buffer of DWORDs of the same length. Set bits indicate acknowledgment
> >  that OSPM may take control of the capability and cleared bits indicate
> >  that the platform either does not support the capability or that OSPM
> >  may not assume control.
> >
> > which is not conditional on the error bits being clear, so in that case=
,
> > discarding the _OSC return buffer is questionable.  There is also no
> > reason to return an error and discard the _OSC return buffer if the
> > OSC_CAPABILITIES_MASK_ERROR bit is set in it, but printing diagnostic
> > messages is appropriate when that happens with OSC_QUERY_ENABLE clear
> > in the capabilities buffer.
> >
> > Adress this issue by making acpi_run_osc() follow the rules outlined
> > above.
> >
> > Moreover, make acpi_run_osc() only take the defined _OSC error bits int=
o
> > account when checking _OSC errors.
> >
> > Link: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#osc-=
operating-system-capabilities [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thank you!

And thanks for all of the reviews!

