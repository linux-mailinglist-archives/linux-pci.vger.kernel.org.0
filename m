Return-Path: <linux-pci+bounces-18041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8499EB87C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3B21887FB8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9586329;
	Tue, 10 Dec 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ognOlJet"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8123ED5F;
	Tue, 10 Dec 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852755; cv=none; b=kZ81Pd8rrtjekbbJqm2txKvZY1AnO2WhZb/SiKNf0B7oRL4Ojh/f33Ba53vmI1IX4f/67KVKo82L3YinBa38laKPQaLfhOpxbnjFzZVLiv642ThnCm6Qrm59jWD+61mUbMwsIU1lTAqH3fjSg57PaTs1c1nC0mjDz1rDvoiPLW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852755; c=relaxed/simple;
	bh=K9ZrrKRWQQIVbr41pbEtdsc8zyftS5P/tSVoHmQ3x80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7EgAnAfYQz2a56lkou4TEpRDyOyVlwSx0WYJ5ci/iWLoyl8tM+lhEmNWI0Pli+Ka3iGITfHVOxTy69Z9f5MRjDp4X6yhkzVuRw9BMkFmfDL23D6GR5pWbs8YLIJ+sysmLBhqcDdB19KQBJybRw+1xJNoRBLIc0u85FRFH7J0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ognOlJet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0E4C4CEE1;
	Tue, 10 Dec 2024 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733852754;
	bh=K9ZrrKRWQQIVbr41pbEtdsc8zyftS5P/tSVoHmQ3x80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ognOlJetmLcdW6ulR/hod0BdErAwMo4jMErwozSH4sU7YpC9UDbyNVFErFih0jZdB
	 ZRLep/YTBAbBExrZ8nfkJz1SusX7jpNRXwlES1RQnutsYNB22esZkLozJKbIMxtc1S
	 VLltXSOJWcT6JVDT4BghH46HFOM+7uL4b3VRpxCRrBPmkgqXPGpETvFihPcfudpsRC
	 343phtdFVIC50QW1pyodf5AxD/J6Gv1Pt1AdzkDwsub9BuLccJu0djJe3TaTvXKLfU
	 YfYRYc1XYdZ0S99hv0Q0tnwN8mmpZLRq9njw+k6YUa/MLns82AE2490ZDVm52gw0Lw
	 kcfMEEdBbuEsw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f2ba68b40aso942047eaf.1;
        Tue, 10 Dec 2024 09:45:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7dAfEV2/jjP/g4EzV61TLoWnmgwKa7rnupVDOQTuw7UQF9dklzQgRWC6+iNHdTh78TE1pEPcimj2EijYm@vger.kernel.org, AJvYcCWsyeiHVSXmhN9i1Fej8bzENp6zxmXzfwIrW3xZZUb/715L4YYNoi4SXcvtlGR9zbqV91FHwUiPykOt@vger.kernel.org, AJvYcCXtvt6qDrnhGXMA626LFcmH8KHd8w0+vB1JUyDiPbQj9iz7xJfFblWzlJ7Ef6yVOrgsKw2CHfCiN/zo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpnn+eR1mrd8wnCePMJitxFniSvGs3G1dwNdRzfc9G9raFq3ts
	gLtAlI3rnAA2VHGwmssHFKS1dtlRCAiYkA+Y2Pa8rXNRrAztH2ENtgG2td3FEfByJleAS8j8nSl
	JW+jIyRV3zpRuyQDGptfUOg6wzrs=
X-Google-Smtp-Source: AGHT+IFyxz3jwxWIkraPx/cZ2fyAWUZZMaIjXnLEJxqqneT1f6/XDyBa3sK2NBPcDXcB4NesMWxLvSqdt6SOkoJaNnQ=
X-Received: by 2002:a05:6820:199b:b0:5eb:d1ac:21e5 with SMTP id
 006d021491bc7-5f286b47c8fmr12663379eaf.0.1733852753950; Tue, 10 Dec 2024
 09:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114030424.45074-1-zhoushengqing@ttyinfo.com>
In-Reply-To: <20241114030424.45074-1-zhoushengqing@ttyinfo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 18:45:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iWiY5B0J988uFD2GK7v8ixTnaYnr8hpCRZ2oJ40HK7hg@mail.gmail.com>
Message-ID: <CAJZ5v0iWiY5B0J988uFD2GK7v8ixTnaYnr8hpCRZ2oJ40HK7hg@mail.gmail.com>
Subject: Re: [PATCHv2] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev id
 doesn't match with spec.
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The period at the end of the subject doesn't match the common practice.

On Thu, Nov 14, 2024 at 4:05=E2=80=AFAM Zhou Shengqing
<zhoushengqing@ttyinfo.com> wrote:
>
> Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> for PCI. Preserve PCI Boot Configuration Initial Revision ID is 2. But
> the code is 1.
>
> v2:add Fixes tag.
>
> Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to p=
ci_register_host_bridge()")
> Origin fixes: a78cf9657ba5 ("PCI/ACPI: Evaluate PCI Boot Configuration _D=
SM")

What does this mean?

>
> Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..7a4cad0c1f00 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -132,7 +132,7 @@ bool pci_acpi_preserve_config(struct pci_host_bridge =
*host_bridge)
>                  */
>                 obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge-=
>dev),
>                                               &pci_acpi_dsm_guid,
> -                                             1, DSM_PCI_PRESERVE_BOOT_CO=
NFIG,
> +                                             2, DSM_PCI_PRESERVE_BOOT_CO=
NFIG,
>                                               NULL, ACPI_TYPE_INTEGER);
>                 if (obj && obj->integer.value =3D=3D 0)
>                         return true;
> --

This looks like a genuine fix, but I think it is PCI material.

