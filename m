Return-Path: <linux-pci+bounces-4268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68086D0DE
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325791F22262
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339EE757E0;
	Thu, 29 Feb 2024 17:38:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BE71EC5;
	Thu, 29 Feb 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228295; cv=none; b=GUYhU+kx6rAO9G1K+ClXGTrDQwHz8wq13P3pd2YfWqUb40eljxKoZxH9+Bzd7NoCXAY3vXC4dwxEt8m7bGXMYDLO9avVdxEh6oG3BpI9vBNi8bdoF65a69DrD2eDzhE9s0nJKz/gz8K2640S6aQz/5Nk3y8L2BHlcGZ7pMmchyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228295; c=relaxed/simple;
	bh=RPLYWTcaQbJLg3/Mn7gCZvlZCikgCSBWo0sfH7/OGMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKr7+5WT7cpdNvyPhlLz9QVBByNjEywuHguDJ556QBB78f+hse7NyI9cS+o7MXp/VEzVC8CfCFAa+qcyxb0mE0o6k2WI9oQUMBtkf2x33/eqjGV++wxW8WFuMteald+1CHOgELvKPj3wqZzRX2lAinNDl9+eQTNbZXiaXEB8anA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a0918d6d83so31650eaf.0;
        Thu, 29 Feb 2024 09:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228293; x=1709833093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPLYWTcaQbJLg3/Mn7gCZvlZCikgCSBWo0sfH7/OGMA=;
        b=XDlmyTDKkZyYQMYthiTwLkitYhqwY1vX23X/69ru99QDbuVQTj/6Jq62lhT8xDJBMH
         timljTEgn/s99J9xHAQLQ2yRJYpynrGk+pLw49JLLTLjFu79yGL1RvnYL0Whfr3MAKvp
         cUfJL6raIJ74HDpjFn5ooWEm+8Cvoewsl38UHPAcvy48XB6E5q3XalMQTCWoyyj0TUxk
         9mA+26D4hXBc9PsI9qz0NG12LzZrgWzZttTDh60RdR0qclR41agpqcSI+B7EG5E7Y9Em
         DHjZbnSvjEDH3i2/fxKeXAANfU3QUb8GqjbepUTZ59j4mvqh8cooh7eBXNHk3WBqL29K
         U/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVe3IfuhNQIHYnB0gniaJmDefORBReTiznQUygAIY52B8g4ACRebptlVHiGMSZQVoP2efNCVzFsKvA4RMZQIA+itnD2KFzKpryJ6V65H4HsQFwJ0y/uuwrrsPY/0PwqY/Schzhu0OWx3H+ZHYfGrH2N4sRWzNm5uBRib3O9gElOxIabAw==
X-Gm-Message-State: AOJu0YzOE7EYFtRSjfTaBfT4ryu33Fnx9sPrwl6ipd6WAYnPhxfJxxJK
	EwJFMqybQO9eduqonJDW5IlxTunyWxNVcsWIXDB5vv3d16A4U0RuGWrxm7Y4Czqy7W+hq37LXEZ
	caJ/UTIi+xXTj402SwQHkSGqHNqyE42D+
X-Google-Smtp-Source: AGHT+IFfeSSKxdwwNHdcoNT6xng8dvSLbg3Q+8NYSMk43wKsex6j1IG5wW0csQkTApAFIFjMdQWlZ35cRKw0/Uq51VM=
X-Received: by 2002:a4a:b902:0:b0:5a0:c62a:72b3 with SMTP id
 x2-20020a4ab902000000b005a0c62a72b3mr2770335ooo.0.1709228292739; Thu, 29 Feb
 2024 09:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228075316.7404-2-drake@endlessos.org> <20240228222601.GA310596@bhelgaas>
In-Reply-To: <20240228222601.GA310596@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 18:38:01 +0100
Message-ID: <CAJZ5v0jhEE9X50TGaXpwFA89wfQb8HYK9qNRnhhuYjU6oM84eg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from
 suspend to idle by default"
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Daniel Drake <drake@endlessos.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhelgaas@google.com, david.e.box@linux.intel.com, mario.limonciello@amd.com, 
	rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux@endlessos.org, Jian-Hong Pan <jhp@endlessos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 11:26=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+to Rafael]
>
> On Wed, Feb 28, 2024 at 08:53:16AM +0100, Daniel Drake wrote:
> > This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which
> > was originally put in place to work around a s2idle failure on this
> > platform where the NVMe device was inaccessible upon resume.
> >
> > After extended testing, we found that the firmware's implementation of
> > S3 is buggy and intermittently fails to wake up the system. We need
> > to revert to s2idle mode.
> >
> > The NVMe issue has now been solved more precisely in the commit titled
> > "PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742
> > Acked-by: Jian-Hong Pan <jhp@endlessos.org>
> > Signed-off-by: Daniel Drake <drake@endlessos.org>
>
> Rafael, if you're OK with this, I can queue both patches for v6.9.

Yes, please!

Feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org

to both.

Thanks!

