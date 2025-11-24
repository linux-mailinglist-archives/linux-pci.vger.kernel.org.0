Return-Path: <linux-pci+bounces-41980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8AC8216E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 19:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EA8E34938F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50953191C3;
	Mon, 24 Nov 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcW16dNa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2C3191B7
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008623; cv=none; b=abSrWtMOEwdbJFLHBUONitgPYr1qqP1Tf6OVpuBr5Wr0SGfHhrRet6hfHDqkZYWMw6jQy555a05Jp4Uytz8YDYpyZy7AlN32xCScDgxMbsp/14bfSS325rINCrmzjdNUtB/MAke7OeCSyUZKqa2mF1EMEQSpfRHg+lEr5wOWjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008623; c=relaxed/simple;
	bh=2FX7rZXKca4g/J0UloZ6GYe00mJx2wV1IHK1gF3C2SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t30AJce5HGaMNkyb3mOuyuJib/BEyCBBa7dudKrcaEMgGxTqqawbAAbA//UJ2E34z18vnZh0UjldqyuifHon6VXAXNnULVfjf4sM9nk/4wbq8tA8jgT+2WMzf0PvlHIm8PrlIEj7iIHCE3/MZHxCybsGwqHXRCTVkgjMv1rxD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcW16dNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693FFC19421
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764008623;
	bh=2FX7rZXKca4g/J0UloZ6GYe00mJx2wV1IHK1gF3C2SY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pcW16dNaGiF6s5vT4XTzPkGay8JLppf19s8pSJ047d+L+LgCwIxWzqt6YMH7lQcM2
	 GIWpqDETt2LsAaYcskOBlzfsLmu/C3Hm9y9x1aWsF4oWaIfFEB3A1qzdfIlN5Psimc
	 S96qMPVKWDujYE+s8zYqlh52jOUE3gaE2oLQnb7O/soEHrcVO5nUm3ohI7NmzoGblr
	 sNcWD3kJM1nxUSp+d/dybSKfbD6qyoRQcD1LL+NaGpCs2PYIs+/M5Nbv4EDHAsg03V
	 XlFDgO1CaErFZccsvMXUsF8HE0U0qK2y56k9mUjb4AhAZHBcmOz5n4SdiejBtkMEhs
	 oVR5hk/OF7EnA==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-450f7f91845so720165b6e.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 10:23:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVBxQ+g7MMVHqt4HjHFx3p6Vr7EP2k3i6zBYSvk/RiXcXEsyzcdFn65FAKqrn5SqdUpic5tEo0ljc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrk2lMXTORLCt4FczxKUs58in/JUxwbuk0AB9SoQKpdvTbuZx
	hE7mCcuVY8H2mT/TMtKpPQZi1b5v945ktAWqs5Pyoec/CnNFCUr2OFxODMw7AXx01Bh7OdFMqey
	llyVTq79+L4dFef4OQKM7hPD3bStF7yo=
X-Google-Smtp-Source: AGHT+IE8USfY1TlzVhoxR68d6+kuU+3Zqd4gD73B+rh8Fu3seOp2TD6CFzvqRKbzETbK58xBjN4YE3uILspEa5NgttU=
X-Received: by 2002:a05:6808:f8e:b0:450:ca65:ef63 with SMTP id
 5614622812f47-45115981923mr3951804b6e.24.1764008622715; Mon, 24 Nov 2025
 10:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <077596ba70202be0e43fdad3bb9b93d356cbe4ec.1763746079.git.lukas@wunner.de>
In-Reply-To: <077596ba70202be0e43fdad3bb9b93d356cbe4ec.1763746079.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Nov 2025 19:23:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iSokgFwYLrXd-ZMYO8PABZwvfZBO-p5gKbETTcURp-oQ@mail.gmail.com>
X-Gm-Features: AWmQ_blp4g0-S_IAjsDssU-F-OFcJ2Imj6eg_vHajqJ-TUa2ZdlupXjD1KnDNJw
Message-ID: <CAJZ5v0iSokgFwYLrXd-ZMYO8PABZwvfZBO-p5gKbETTcURp-oQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PCI: Amend error recovery doc with
 pci_save_state() rules
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Farhan Ali <alifm@linux.ibm.com>, 
	Benjamin Block <bblock@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Linas Vepstas <linasvepstas@gmail.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 6:31=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> After recovering from a PCI error through reset, affected devices are in
> D0_uninitialized state and need to be brought into D0_active state by
> re-initializing their Config Space registers (PCIe r7.0 sec 5.3.1.1).
>
> To facilitate that, the PCI core provides pci_restore_state() and
> pci_save_state() helpers.  Document rules governing their usage.
>
> As Bjorn notes, so far no file in "Documentation/ includes anything about
> the idea of a driver using pci_save_state() to capture the state it wants
> to restore after an error", even though it is a common pattern in drivers=
.
> So that's obviously a gap that should be closed.
>
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/r/20251113161556.GA2284238@bhelgaas/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

It looks good to me, so

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  Documentation/PCI/pci-error-recovery.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI=
/pci-error-recovery.rst
> index 5df481a..43bc4e3 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -326,6 +326,21 @@ be recovered, there is nothing more that can be done=
;  the platform
>  will typically report a "permanent failure" in such a case.  The
>  device will be considered "dead" in this case.
>
> +Drivers typically need to call pci_restore_state() after reset to
> +re-initialize the device's config space registers and thereby
> +bring it from D0\ :sub:`uninitialized` into D0\ :sub:`active` state
> +(PCIe r7.0 sec 5.3.1.1).  The PCI core invokes pci_save_state()
> +on enumeration after initializing config space to ensure that a
> +saved state is available for subsequent error recovery.
> +Drivers which modify config space on probe may need to invoke
> +pci_save_state() afterwards to record those changes for later
> +error recovery.  When going into system suspend, pci_save_state()
> +is called for every PCI device and that state will be restored
> +not only on resume, but also on any subsequent error recovery.
> +In the unlikely event that the saved state recorded on suspend
> +is unsuitable for error recovery, drivers should call
> +pci_save_state() on resume.
> +
>  Drivers for multi-function cards will need to coordinate among
>  themselves as to which driver instance will perform any "one-shot"
>  or global device initialization. For example, the Symbios sym53cxx2
> --
> 2.51.0
>

