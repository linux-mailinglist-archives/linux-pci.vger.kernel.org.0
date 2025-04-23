Return-Path: <linux-pci+bounces-26515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9945EA98592
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508613AC7E1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C892A1DF991;
	Wed, 23 Apr 2025 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVne6kNu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3D2701DF;
	Wed, 23 Apr 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400743; cv=none; b=DFFdGYkDTPQFN1cq5wiLK9A64J5H0zRuObA043vYUOEF6QJAIUl+GTz9lB0B3My/5KzctWHwDm+L+j7UmN28nCZFJgMJm0SmVf78cJ7iBZF/eF7WRQ6gZogTyaRN+nQ8Wl45BGFI7SUvMhwIh7SjYYtl40PXAxj/PQt1U1ixv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400743; c=relaxed/simple;
	bh=aYLu6xNAjH0O0LUykFOSGkDTTVlyAPDb1573K5hiCZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrimyuVloz5DMpTsH6qjD9+GqoAHWDFoN63ApiUmZMbSW9rL6uQcQq1q2spvJa5lFS28cWivHIxybF0vVrSGmnnzOi0oaLv9SQsXK2RD7lzPmN/tlvYmIhVQhco0z9SNHABRDlDXDxAYK08L9Tm7QYvLLjdez7wxdaE+n8oGTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVne6kNu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af5139ad9a2so3931717a12.1;
        Wed, 23 Apr 2025 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745400740; x=1746005540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpvYx4I4dXv7Dap9phUEXTzOU2IX4DONLJbyNUltq+w=;
        b=YVne6kNu50BaxhbBRx02NPmDTe8uQC6NG9yMpEjS0pQqkt4XGJfKa04krPWI3PwLKJ
         GDOT+ii76zB+PxgsM9w/2XdgTeM0RbuqUobSJUgfLBChpnMqzdz/EOC6NYsYHZDGCdwb
         3vB8D1TtwbpLdCcWmlMq2dKfAvxl+R3qcpb8lAbUUDT7G9rLnLqNxckPIejzSjNddDTN
         DBA8ZUGSETJsB//tCteLsNSia3fWuSnfe/U1UIpfMmnE68j4ac2iZ3o9zYCknoldVGwK
         UwIsfjUiayiC5AvW0O+bhHnCJI1SsrDBBFkFwMXbV8cill8zZb1wOPTVcxgctaD4/L5V
         LMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745400740; x=1746005540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpvYx4I4dXv7Dap9phUEXTzOU2IX4DONLJbyNUltq+w=;
        b=NRFmRRCsAbFU8vzlDShIijtC8ifQtpqqMEgS6oEJJlBIIZ4yX8qrqQ1IGReTlhkksV
         lHMpCplUFbnR5rrFzHtXD3amIpoy6Cygjvk3U1MI+M6FkkG0DchCAKMxMjWjVIoXyHMi
         hS6o+oBNdAW8yFXEfYuueNYJgooA8Vcw/I51DkvJ2kZAHQCa+JBFi/MuonbCO/z8rLU/
         qT3aw45Q0ZM2ljpLdnt2mUdsyMNO04oM/9HTeuVCwb9RoH0enjxuHCFSvu3kKChvL4OG
         /54rfPZbxLUbGFY5Jhim/lTxO3oy3X/Cc86pv7OAzPiucbhbl2m4Zdms7jvVVs7OM9lm
         p6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR//TeRDAi0VzaXl57dmx3cY8W/x2wY4YX9lDloDhIyx4pvgLbb3R/r++1pQgNe1qxXRiG8deT4NP+@vger.kernel.org, AJvYcCVphZrIVW9EnMVdtugWIKfeLELAP3lhaN8bVD+yHhfwiZz2PaV+cpFYwjGjar0/VIqv3FJbJyFma4sY@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDgOqRM+YQp2jzIl1VLkrsFSC3DfZjoHYL51YqZoJqVdQrGJU
	SY2D9BkquCUsTIlgsIXluS12MeZK82ucHLhb91yLL4LJSM/hWuvkxR1/pHRVfdzmuckNAf0G/sV
	7v9toiY80Ln5AY+JG9TbAHRjHUbA=
X-Gm-Gg: ASbGncsTUVHuQbRUtXyW9+XP/fWb9EPi0I11uPZT0gJB8KZR1EN/Fzt+LQne+2qchBM
	JcrkkpL1sNm1r/+Kz0YqpuEJ1o9WIfGHTyFFB/GU6QFQ0Ndv//To9cYJkhdwSUe5IOSCmy5/iWN
	9oaAk6i00wNMpdad3CwmZV8A==
X-Google-Smtp-Source: AGHT+IGE8sObaNyKSiPkO/qpSiUeuKAoTJJOunfvuIWb7LoyW0/brJrvAJTkDYKHXnj40W7gIv+eM7F0rIEcowv9baM=
X-Received: by 2002:a17:90b:274a:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-3087bb525cemr28936199a91.9.1745400740319; Wed, 23 Apr 2025
 02:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <62de9027-e4cd-4192-90e8-64f4c4a8fe4b@gmail.com>
 <aAc26NTVcXy1BCxU@wunner.de> <CAJZ5v0iWTd_ndpAr=q8QJC2MWSheq0UXVR6a1oyGSH063yzpFw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iWTd_ndpAr=q8QJC2MWSheq0UXVR6a1oyGSH063yzpFw@mail.gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Wed, 23 Apr 2025 11:32:08 +0200
X-Gm-Features: ATxdqUHnoN02QKdGtRupZAwXQafde4nJbce3gtu3QSEXhRoH_QXALjZij0_4wQ4
Message-ID: <CAFSsGVudMV+=0M7m_LC0xuJF=spTwk-691_W=wmnuuNFxCK1AA@mail.gmail.com>
Subject: Re: Potential issue with pci_prepare_to_sleep if there's no platform
 support for D3cold transition
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 1:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Apr 22, 2025 at 8:28=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wr=
ote:
> >
> > [cc +=3D Rafael, linux-acpi]
> >
> > On Mon, Apr 21, 2025 at 10:05:59PM +0200, Heiner Kallweit wrote:
> > > If there's no platform support for transition to D3cold, then
> > > pci_set_power_state(dev, D3cold) still returns 0, even though
> > > power state is transitioned to D3hot only. We called
> > > pci_enable_wake(dev, D3cold, wakeup) before, therefore PME for
> > > D3hot may not be enabled. Is this a bug?
>
> On platforms using ACPI, no it isn't.
>
> Internally, pci_enable_wake() evaluates _DSW and it doesn't
> distinguish between D3hot and D3cold as per the spec.
>
> > > Background:
> > > In __pci_set_power_state we have the following:
> > >
> > > error =3D pci_set_low_power_state(dev, PCI_D3hot, locked);
> > > if (pci_platform_power_transition(dev, PCI_D3cold))
> > >       return error;
> > >
> > > The acpi_pci_set_power_state() stub returns -ENODEV.
> > > Therefore, if error=3D0,  __pci_set_power_state() will
> > > return 0 if pci_platform_power_transition() fails.
> >
> > pci_prepare_to_sleep() calls pci_target_state() right at the top.
> >
> > If wakeup is supported and enabled, pci_target_state() is supposed
> > to find the deepest power state supporting wakeup.  If D3cold doesn't
> > support wakeup, D3hot or a shallower state is returned.
> >
> > Hence I don't quite understand how the scenario you're describing
> > could occur in practice.  Are you seeing actual issues and have tracked
> > them down to incorrect handling in pci_prepare_to_sleep()?

On non-ACPI systems pci_target_state() just looks at the device
capabilities. The described scenario can happen if device supports
wake from D3cold, but platform has no means to switch a device to
D3cold. I'm thinking of e.g. RTL8125 on ARM. Typically I don't expect
an issue because boot-up default on these devices is to have PME wake
from all states enabled. So it's more of a theoretical exercise at the
moment.

