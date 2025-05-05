Return-Path: <linux-pci+bounces-27179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE767AA99E3
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FB7188DB1A
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AB5264FB1;
	Mon,  5 May 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUyyrIli"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B701D63C7;
	Mon,  5 May 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464386; cv=none; b=UcS39uEW5Nas9yqlm/42BN4u5aM4Q1N2jDKByvhmugnQpq7bfTCPw+qnmlIcZ8vMNs46RMxT41IHjJSyy/1V74wkBEN5VhkKh35o5ALRs2ntUI20I3ZitX3ftam3oJVmrXVHj3l10m4GbTjVwVMOp+pS53lcQBhf9wKZEldX9Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464386; c=relaxed/simple;
	bh=lxjsFL+wMV496UmAwohSTtTLjrO4J7BZiWm7K8VT3/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRKFcM8IYUXGZz3Tjrpm+mG4JFBazoNEOYY5kaNqFSQ4KEj5jhWUVSDkOhQFZJIOWkSXN2n4PztP84bDAVulX3kAhuDt3buy9SVVnphgQM7OGMNZcd56UTj0wGorrXTf+Mpote1hV8C9SQDbpTq5LL6hMwOlGYiMzIydOLa84IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUyyrIli; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54e816aeca6so5926412e87.2;
        Mon, 05 May 2025 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746464383; x=1747069183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxjsFL+wMV496UmAwohSTtTLjrO4J7BZiWm7K8VT3/I=;
        b=IUyyrIli1jkPpPGGAKqRY9BlK3NcZZNWIkFoKefKS2D+HE5uMMoYNkAn+Ko8uUqihL
         Rkqf8n1Df26p8/oLMIBWKBBapC+bUp7PxelRdtEzkxotzVpa5RWh5ypHeZxt2dLdkr23
         PvpF4/NUGN/4jvEKJknb5olsQzBPXFjbBLTD998SbIc6pB6nmpclXNjcn73+sU/eA24C
         pX0xV15uF8JaMU/oCsV5eYDB6wY3r7qPm0REHMHVZAZahPzLe6Nl17WSpPmxbiJJISAl
         xMPOo6qmzlnb6mjPyymNwMiwzG73GUyIPQAy+FyJQIkIxIZ67WCref+f3fVprdbTzv/L
         dQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746464383; x=1747069183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxjsFL+wMV496UmAwohSTtTLjrO4J7BZiWm7K8VT3/I=;
        b=uykHa0OLra/Vx/NykMKrn4lwAlSVbjkmeHHapJGeH1zFmQSOHqZlwyxvtrUVZi3tt4
         fyofqf2Yj3PKVdBuZZrCJLQL0a90fdQJ2OIPnGab5IYOnXjcqYH6Sjoh6pYek2IEklZu
         TpYPGUatjFrSy8iuUnOdo6ZfIIY1OVpwYrLGqAKuMS9dJ1M2imNe24HlxCR9Xno4vD7n
         9992kR3MQwB90j6r5lMHzSet2NwskMmQOrLRIaA+1oi/pR3milgG4tFmnQBoGK+Dui2R
         4QSoxAEsxgaup0idvbtV9gNDiU90GBq6WYKRU4pEJPSTkKlZniCLxPm0tX8ctrfr4xWi
         R6SA==
X-Forwarded-Encrypted: i=1; AJvYcCUTSGe/dxYTBhIEqkIzgJ74KWkl1tygD2mLsi4CGCA5SOfNAUUPfn9zzfVqp5XQNDMskVGhxMxLUdzhdwY=@vger.kernel.org, AJvYcCUtbVX7tY7krnNnKTcqMtm2F2tpmTiClVhJZ9aZOox7icEERmBNgBGmty4RV903WSAiNVwivIdLGA8=@vger.kernel.org, AJvYcCVLIGYOV0wGtNJHEjqjoyueDdyWMcI+GOXvyN4NghHUAIBbd86Xb+BO6lDxurJgmnnqqHbfFFd/TRIBnh4=@vger.kernel.org, AJvYcCXJZnerSFJigcD5SHCYY2j6ZZ6sC9ax/uR5sEqG4j41pxt0CGJi+p50T5b/jJOOeUlmnP0Gvy1YMZoN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vEzjSafu7c6pnNJxQF4bTvSCEtDbUYNKXWk060equ36F3eAw
	P2UeBqCwUhPHy8gZmCuq6v6gn9RLp+e16AWluBAtnBnLSbFaMVh+earyBg8yGMLZgRxlWxSwcd1
	EP6HBb39GiMI1xw8YUbQErcQMKJA=
X-Gm-Gg: ASbGnctdpwUbUF9BjO61W/3ibzN8UH0Oxfytg4OrVfIVvF06kR87G3kQ6aGqIKgGE+v
	36Wkbe+rZch4QfgfHZdYSO5Abz/uH7/eSZL6ZFtVRzHH0tquc2UapKPy0a4I2UP/31ronLnFeWn
	0OY+3w9KoRVzIoEUDQY3/U6ZGDgj/uo51VCQu1QU3ISNmZP/T4NeHm0nhW
X-Google-Smtp-Source: AGHT+IGWfM2phNYFBxfw+WiwtJ4VT74sTH1JYbp4A09ZPJ0thrp7SCQ3SyvfiPXjmaCWTlGYcUcb0PFFmeyTHU635bw=
X-Received: by 2002:a05:6512:b0b:b0:545:16a5:10f5 with SMTP id
 2adb3069b0e04-54eb243945amr2462931e87.30.1746464382420; Mon, 05 May 2025
 09:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
 <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com> <idddypjxxtiie3tllfk47krcydlno4lnhbkik4wakekcyu7c2d@iurtu6bjzeey>
 <CALHNRZ88VaS6zmmnkQg_WrBVPjMT4e2uPUPEQUj8ARL1TieZPg@mail.gmail.com> <gxbuvopbhum3v622gf4olzfspgihxt3dm4z3rsj4gquaabt2c4@peemxrxshjuu>
In-Reply-To: <gxbuvopbhum3v622gf4olzfspgihxt3dm4z3rsj4gquaabt2c4@peemxrxshjuu>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 5 May 2025 11:59:27 -0500
X-Gm-Features: ATxdqUHlF-KwEnhKKwshWxs2CcgMthGV7BB1qKE9YC7P7Z8WKl37pcpWArjpasQ
Message-ID: <CALHNRZ9DHApwS_W22aD0uOFJKBk8WkucFo04_vjLRpnRjP4WCg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI: tegra: Drop unused remove callback
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:48=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, May 05, 2025 at 11:43:26AM -0500, Aaron Kling wrote:
> > On Mon, May 5, 2025 at 11:32=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, May 05, 2025 at 09:59:01AM -0500, Aaron Kling via B4 Relay wr=
ote:
> > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > >
> > > > Debugfs cleanup is moved to a new shutdown callback to ensure the
> > > > debugfs nodes are properly cleaned up on shutdown and reboot.
> > > >
> > >
> > > Both are separate changes. You should remove the .remove() callback i=
n the
> > > previous patch itself and add .shutdown() callback in this patch.
> > >
> > > And the shutdown callback should quiesce the device by putting it in =
L2/L3 state
> > > and turn off the supplies. It is not intended to perform resource cle=
anup.
> >
> > Then where would resource cleanup go?
> >
>
> .remove(), but it is not useful here since the driver is not getting remo=
ved.

I may be misunderstanding how stuff works, but don't those resources
still need cleaned up on shutdown/reboot even if the driver can't be
unloaded? I recall seeing shutdown errors in the past when higher
level debugfs nodes tried to clean themselves up, but bad drivers had
left their nodes behind.

In any case, do you want me to just not add .shutdown() at all, or try
to set the proper power state? Prior to the half-baked attempt to make
this driver a loadable module several years ago, there was no such
cleanup.

Sincerely,
Aaron Kling

