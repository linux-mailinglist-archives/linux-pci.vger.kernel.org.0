Return-Path: <linux-pci+bounces-3230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A87184DB8F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 09:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42076287C44
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6FF6A35B;
	Thu,  8 Feb 2024 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ZIdG1OOD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F3692E6
	for <linux-pci@vger.kernel.org>; Thu,  8 Feb 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381495; cv=none; b=rHpPgndgVfBhvlpATdGMU9t/Tb697MUxg+94o8nb3GaXQA1eOCgnr0eJG6OINs7GbKb/ip8hhWD1pu+BAiV6Al9Xwf8erMIswJQzJPtRL7rkwCbTLkkCkmVbaIW0eX/LDaShoPcJ1Eg4mOhLrpKEHTrgqxPNqx06VRJlzOHvlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381495; c=relaxed/simple;
	bh=lF1qmuDwtNui8X0ZFYNVt/ucazJB6+zf68wnH6w0jUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyQzJnjO4q3PkWGJ6pxWiCl0Nsqe79vN6CCvBG3OEUCDI2cneIzBJnujBNlH4CIR8WXZWfx2E0e2YqedXYr87LlUzouaiBOUNkeiLhKtnzbHI19OmfLneY09onOG/iJoUab7L+wsw0UQR2DjrLJI+DatM2Z92cX+e+Vage8bYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ZIdG1OOD; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc26698a5bfso633802276.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Feb 2024 00:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707381493; x=1707986293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJjgK/86oIYgDKE/vpWS6pEJ65u/gCjBzOy2n9k26uo=;
        b=ZIdG1OODqGuJaJXs8H41EmQ0bNAavyQGcaIO+8Qw0ubArxDacqPV2K9ahfrmZM35m4
         O/tRdNIj/GHDwrRkzGrbi24C5qIau/sIxruXhf/mXZbsAOJKBlW7n0F1qr3/cE8L/wfn
         cg+WN0PKcmG3qXzOXr+q6ok6ax6azW04qVBG8pINMcELfSA3Z+z0cADJ/htA87f9cB38
         ZsQFFKmwk91yyATi4Py53ZWsBcrlE4YyRFPnA6zluRsAYXnHfwE9Q2mxRj2BKUCu1KuR
         s0m40emk0w8GW3tuEH+zTmDEpYupavmdN1hf2rgfQI78vMH4gZFeaRlcpcv6JDERp9uS
         ze6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707381493; x=1707986293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJjgK/86oIYgDKE/vpWS6pEJ65u/gCjBzOy2n9k26uo=;
        b=Idw403r3mOHUSOjysIgjCIBkuRWFHqgU8Ez8NGYeg5NVqpdVdEEnL07XHkO/DY/jCU
         RnJVC3gFCzwfXaDONBPOS83iKj1KVcgQ8ajqw2+6xnt7Vy6q2KY6bETX1cibsfp/eHI+
         CrKRoLcjj4Niy4KSml6FOHy8WvjQNaBuGK254NqrWfaBtFJXo6WzX027HlwQ3N7Lt3XF
         plXtB9u4SPbLf/E9nvrThkI3fvFRnp03WuoseFFAYvWPt8Syg71QPWmCp1cmUo31WYR+
         LYIQaJI8Lrh4X2l1YT+cK5+Z6uuc0ZDGkVel/fMto6blWm0E8hCKkhOzdVL7WDNTgBBd
         /S4A==
X-Forwarded-Encrypted: i=1; AJvYcCUGRr9JJH1Frnr5FGdM5aLOsAzzVh74zcum/4lcc9r0KyhGmfjnTrnHzrjA/tcbyZ0DT8LJjDQMA/t732dhSeI2VIYfF6aXQqR8
X-Gm-Message-State: AOJu0YxSAx2NVyRdO3jaXYDiA9PSH7B2EKF1HhEjaUfhJnPPLEMSaazT
	w874yBEceXw1/lf5867qxm22TnPgz8P7x6lnTgI3Dx6DMMuAgIpOXiApDrg6rQVj/dwu5hVtRqM
	+vjhgcgdp2x4eUNJvoeAsGWaclVS6WoK9Xq8Alw==
X-Google-Smtp-Source: AGHT+IGMvfAD5Dwy5xHDpbIKVVXYXtthlZowYoNKU2j4hr05mPhNntdO2N44+cfCiLv/dgkt+wBOwO1Wtk1t6IMtHLg=
X-Received: by 2002:a25:8002:0:b0:dbc:b927:c5f9 with SMTP id
 m2-20020a258002000000b00dbcb927c5f9mr7087610ybk.6.1707381492892; Thu, 08 Feb
 2024 00:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207200538.GA912749@bhelgaas>
In-Reply-To: <20240207200538.GA912749@bhelgaas>
From: Daniel Drake <drake@endlessos.org>
Date: Thu, 8 Feb 2024 09:37:36 +0100
Message-ID: <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, rafael@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:05=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
> Can you run "sudo lspci -vvxxxx -s00:06.0" before putting the Root
> Port in D3hot, and then again after putting it back in D0 (when NVMe
> is inaccessible), and attach both outputs to the bugzilla?

Done: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742#c21

> Given that D3cold is just "main power off," and obviously the Root
> Port *can* transition from D3cold to D0 (at initial platform power-up
> if nothing else), this seems kind of strange and makes me think we may
> not completely understand the root cause, e.g., maybe some config
> didn't get restored.
>
> But the fact that Windows doesn't use D3cold in this case suggests
> that either (1) Windows has a similar quirk to work around this, or
> (2) Windows decides whether to use D3cold differently than Linux does.
>
> I have no data, but (1) seems sort of unlikely.  In case it turns out
> to be (2) and we figure out how to fix it that way someday, can you
> add the output of "sudo lspci -vvxxxx" of the system to the bugzilla?

https://bugzilla.kernel.org/show_bug.cgi?id=3D215742#c27

Some other interesting observations from Windows, observed via socwatch & V=
Tune:

On affected BIOS versions:
CPU does not go into the lowest power state PC10 during suspend - it
only reaches PC8.
SLP_S0# signal is not asserted (which follows from it not reaching PC10).
NVMe device in D0 and the HDD LED briefly blinks every 1-2 seconds
(can't recall if it a regular or irregular blink)

On latest BIOS version:
PC10 reached and SLP_S0# asserted during suspend, but only for about
25% of the suspend time
NVMe device in D0 and the HDD LED briefly blinks every 1-2 seconds
(can't recall if it a regular or irregular blink)

The LED blinking leaves me wondering if there is something "using" the
disk during suspend in Windows, so that's why it doesn't try to power
it down even on the original version with StorageD3Enable=3D1. This HDD
LED blinking during suspend does not happen on Linux, not even when
NVMe device is left in D0 over suspend with the regular nvme_suspend()
path putting the NVMe device into lower power mode at the NVMe
protocol level.

> What would be the downside of skipping the DMI table and calling
> pci_d3cold_disable() always?  If this truly is a Root Port defect, it
> should affect all platforms with this device, and what's the benefit
> of relying on BIOS to use StorageD3Enable to avoid the defect?

I had more assumed that it was a platform-specific DSDT bug, in that
PEG0.PXP._OFF is doing something that PEG0.PXP._ON is unable to
recover from, and that other platforms might handle the suspend/resume
of this root port more correctly. Not sure if it is reasonable to
assume that all other platforms on the same chipset have the same bug
(if that's what this is).

Daniel

