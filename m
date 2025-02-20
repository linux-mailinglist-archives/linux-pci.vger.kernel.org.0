Return-Path: <linux-pci+bounces-21901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75995A3DC24
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 15:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662801884B5E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31E1C3C07;
	Thu, 20 Feb 2025 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzAojyyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BB1C32FF
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060517; cv=none; b=SowguxohJDSwYZVeJArRUQHwMBtDMIb6T+l7h6Lt9d7Vh/UjQYExTMN0WfJVkYvJYzst8Y2IugZMZIG7WQ1bpLrYtR3k9pHPphTe80jYrmSLPTH7V83t/QTgnqwOFh33jduQeSkVHbnpkfUDtsdmmm1U0x9RAV1qXX8GQFXY8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060517; c=relaxed/simple;
	bh=uMcFCvRyFYAfxSRpb4IHMbXiD751NApuC6Luyf2voJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZBbpMUlu4JzX8FHNon/DCajB4MX7e9g7EVD1eNWZyza74VCqwGCrqZscHEm+p8bhg5q/sH2O0KKI3VUcO1/1iV9pivRXYwbEYFfJQYkxCK+fb33iERonq4fsr2qnKJ6eeZ+jIlhawD2D1swKwhoN6sF7rUnUNQ//EvyugD4zsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzAojyyt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220ea8ed64eso2253285ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740060515; x=1740665315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjmM5gbTC9mvcMhJU+L68piC1eRyu7CQvSJe9PX9cWs=;
        b=AzAojyytbyZYveiTh+82UzKkbso7X33LQvPc3Fv8e7UQjkBdOjQP+TwE8fscLRZqF9
         +Y0NfFUp+4cKJnkxq8VljUjB6NGVmcI/uP4KQicUd6JoGixgG0/N54vJIX3eO919JUur
         nCeynczYZ30WDzJCRa+iIiugcL6BXOyFL3ha4b4aRyZj6zHPmzpmXfD4ZmRd6pzgmnah
         McBzMaoqsdpVOzDNvtps59k0sr+KF5hyVtRV4QhNqdOWn3eJphkdhfhGecbRqnI2DADU
         neauDVGfRSCuVezFNUNyzw6IH+w0Y5P8xqb2Cbv0gOmtHUkB2HwBHB/E2IxNyZL/QjO3
         N5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740060515; x=1740665315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjmM5gbTC9mvcMhJU+L68piC1eRyu7CQvSJe9PX9cWs=;
        b=D3lle5zFSGFdEdV/9PLyCvqVzFkNfSxkLRxJiCq5zDcXTeEW9rFTuz/1YAKfXdLCnV
         T6ZK44FWeNpnIszSfLvV43008yg2JlAL2xaNXRNb5WggAeHMzCsbL9jpbm4QnkTTJPY0
         pEaBHTyChh9P8Xmec5shcjuog5PeYi8RRS9rCA1uaHmIpi8yH4zTEDaYYsari1TAzPMr
         VPdqqmvcueA1XRpaYrzzk5UWUU/UY9pjQ0LhEVtr32ZLPB5He6UevYf96P5gwrnkegAn
         JM3V+Cnc1oTHwk5pdD1pJQCbfOcC7rakRsBrHMsas+YfhTCGEG8ZohqKDbM5Ud0Gkmcp
         CHPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUMsQGhlWI61uzTjFtwzk+NdQo35Tci4StHbyCk4I/v/bt2G/mC57vUcLK65jYpRdyuMs0I67+BAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKrv4dvVG0+y8OtJCpNU5nTPDtAtZogAUwGnl0o4xOpMPH2zN
	1lKMXfk0M6hHZSDLpQzFFxwgLKLZ5NgMA0YkSZKxGhSDJFNczbvrB6omT9bTx4Iz3nujoXWvk3+
	1VaTzeOX9KPqEEz/0Hy1bvKL2RpE=
X-Gm-Gg: ASbGncs/5nxct/pdNBJwYbWKgCMHV4EX3Le3kXsxcFm6lse6soDrDlB8Qvu5Z3+X9Va
	d+oRB8ZQwccTrOtXg+uMrvk+KVeZSjfE+UoSf+0KExe3p+g8j5ASMzaVCxv+z2zFvGImNm+NZ
X-Google-Smtp-Source: AGHT+IGkQAqVX+MDRMILw0YtR9i6iMI9KuYyxccf6C9LXlRgIPcyWd9dbDjU2gBO1tA4wBcbe8Rl1yWltmTLHYcUx4A=
X-Received: by 2002:a17:903:32c7:b0:21f:3e2d:7d43 with SMTP id
 d9443c01a7336-221040b48d5mr130525715ad.13.1740060514034; Thu, 20 Feb 2025
 06:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217151053.420882-1-alexander.deucher@amd.com>
In-Reply-To: <20250217151053.420882-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Feb 2025 09:08:22 -0500
X-Gm-Features: AWEUYZmH7n-J4pdID-Gbt_Ubv5ZtjOVDv1UbvJ66j9xAALjB-6p7CCfjQGwrQc4
Message-ID: <CADnq5_P_oZ808SbHf3Vpga8x+c=WopRpBWUuL2=KpuXwh6cUPg@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: Alex Deucher <alexander.deucher@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, Mario.Limonciello@amd.com, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dropping this patch.  Will work around this in the driver.

Alex

On Mon, Feb 17, 2025 at 10:48=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> There was a quirk added to add a workaround for a Sapphire
> RX 5600 XT Pulse.  However, the quirk only checks the vendor
> ids and not the subsystem ids.  The quirk really should
> have checked the subsystem vendor and device ids as now
> this quirk gets applied to all RX 5600 and it seems to
> cause problems on some Dell laptops.  Add a subsystem vendor
> id check to limit the quirk to Sapphire boards.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT=
 Pulse")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 225a6cd2e9ca3..dec917636974e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pd=
ev, int bar)
>
>         /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 *=
/
>         if (pdev->vendor =3D=3D PCI_VENDOR_ID_ATI && pdev->device =3D=3D =
0x731f &&
> +           pdev->subsystem_vendor =3D=3D 0x1da2 &&
>             bar =3D=3D 0 && cap =3D=3D 0x700)
>                 return 0x3f00;
>
> --
> 2.48.1
>

