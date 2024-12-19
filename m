Return-Path: <linux-pci+bounces-18771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDFA9F7A4B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 12:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E34169F41
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF90A22371C;
	Thu, 19 Dec 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Cpkxhch3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C38222D68;
	Thu, 19 Dec 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607442; cv=none; b=mq+XGjBdl7uf2oV/mVxXN1q0WC20x7559e0kIY8Md1NrhxW21DWkOvWpQKF0PvJl2W8hj5KroOlijXS0lUBQ4PCp6QBb6n4naeBtHvCDhaPgP9Oh/CgFndSr/fSh5am4/tDirOnWJvgGz1z7grtVf1udTnlvqL2515XpzZUnn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607442; c=relaxed/simple;
	bh=Z+B0TtMOCcpkWVdy/3AxHhcMeb4iaFN+XQCTuzmOQ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHxNMG8EqgiOiwqWcyNhHx16eugo3F6XCUder/kCB8eAtByBcu9JPxiIHlvyUnC2fMX6zEJJFCOC/qWNhUU4twHCpLcH2YN9V0gTjlY/IsUjThUffEX3m0KH+IOfuNt5OFLGaOhqENUeIKFleVzbqd12Yr6Cawu+Vcp9aAdWKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Cpkxhch3 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C60A40E02C4;
	Thu, 19 Dec 2024 11:23:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ag5DNof_6v-2; Thu, 19 Dec 2024 11:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734607426; bh=Ky91ij7q8YzbxjbNPNlCNvqYo+3HDYeDJCMEoaVeO1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cpkxhch3GqGKQ+2KfkW0RPRWUFl0Rdl3na4M7Tdgfx1Y9J80b6Vo4WaJMwW0b/rwr
	 L6He2ba8gs9r7uMnMXK7eagdoZ5h8WJH7D/sHnP9NOMHdBm1CNjt8Jlea6VqLOTZSr
	 mV94pe2qfUnni3ZOhPFhQLmrD2VD7zrMtGO0L3iXq1ABC9xKKqRj6Sr6frUY40vNwY
	 RsBOb/gZQzA3p/IZUOw5693Vj+Rgn0DfpRbt50EPGWFkC9JtGHjfHB4TQeU+3hdxDz
	 vVzLw61uTuHl0Uqo+DeXzRN5Xv4jjYwyhZsOuZJsXxl4FWO1oNtzGVnnG6lePw3aRi
	 UdpU9BvydXPklU7ebcGSR/Q7vdiD5kyX5TubkVgBSOPzL1O09l9zQw3YAUDnQGAvPB
	 zkH6M0toUisCz5kg5FDw2wCKtSMKQ/8Hn2jAwRhx+2BylXxgEj+gvHSNVxiRNOSmc3
	 H/c3rVPPRrMe4Qiq7VcktiKnh4vSOxfGrEFKlFyzgAeTcvkarcbPgCNU0TXvnolBQ4
	 dBnEamcin6+Y/pGfDtslgxpl+2dLArcUqGrSA7zRYxmtktgwjqVNyzANxwy4Hi4BcT
	 J0AUogNog14S9iylFgGV0Wh7E/CQTkLRf7rj7fRkqnbDGgR3O+L3Wk7gQdf69iE5Rw
	 c3aVUkidDIl72ZUASZSosbJ8=
Received: from nazgul.tnic (93-39-225-244.ip77.fastwebnet.it [93.39.225.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 71EDE40E02C1;
	Thu, 19 Dec 2024 11:23:39 +0000 (UTC)
Date: Thu, 19 Dec 2024 12:23:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

+ Yazen.

On Mon, Dec 16, 2024 at 02:15:26PM +0100, Rostyslav Khudolii wrote:
> Hi all,
>=20
> I am currently working on a custom AMD Ryzen=E2=84=A2 Embedded R2000 (A=
MD
> Family 17h) device and have discovered that PCI IO Extended
> Configuration Space (ECS) access is no longer possible.

Perhaps that particular type of system of yours needs some special handli=
ng.

Things to try:

* use the latest upstream kernel

* add some debug printks to the paths you mention to see where they fail

Looking at the relevant chapter in the PPR - 2.1.7 or 2.1.8 - that
should still work.

Leaving in the rest for reference.

> Consider the following functions: amd_bus_cpu_online() and
> pci_enable_pci_io_ecs(). These functions are part of the
> amd_postcore_init() initcall and are responsible for enabling PCI IO
> ECS. Both functions modify the CoreMasterAccessCtrl (EnableCf8ExtCfg)
> value via the PCI device function or the MSR register directly (see
> the "BIOS and Kernel Developer=E2=80=99s Guide (BKDG) for AMD Family 15=
h",
> Section 2.7). However, neither the MSR register nor the PCI function
> at the specified address (D18F3x8C) exists for AMD Family 17h. The
> CoreMasterAccessCtrl register still exists but is now located at a
> different address (see the "Processor Programming Reference (PPR) for
> AMD Family 17h", Section 2.1.8).
>=20
> I would be happy to submit a patch to fix this issue. However, since
> the most recent change affecting this functionality appears to be 14
> years old, I would like to confirm whether this is still relevant or
> if the kernel should always be built with CONFIG_PCI_MMCONFIG when ECS
> access is required.
>=20
> Linux Kernel info:
>=20
> root@qt5222:~# uname -a
> Linux qt5222 6.6.49-2447-qtec-standard--gef032148967a #1 SMP Fri Nov
> 22 09:25:55 UTC 2024 x86_64 GNU/Linux
>=20
> Best regards,
> Ros

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

