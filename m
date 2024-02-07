Return-Path: <linux-pci+bounces-3193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF3684C8A7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 11:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D77B25069
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2B314266;
	Wed,  7 Feb 2024 10:30:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52148802;
	Wed,  7 Feb 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301813; cv=none; b=CFx4o/B+cK+d/+qQ2avOr2QMmXbEiWelwYeTOBGODb5qDcmrNbigpLzDcJ/snnahbypPyVgxwla2akdrOSdDDYZ+F4y+MmAeRhV3cOKuQ/u4U7udHN24kSVE+ytYngd+KPzMjzSTh7xyAtrV5d8xFm9A1iB635uXEThEpogAjiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301813; c=relaxed/simple;
	bh=GwEJ9oyxbx9mr+/VCOBMPM5kJ2HpN/1sW2GbMEbIYIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbS0BF99OWdls5OH6Jkqm73Snpz+mcKiQUudpOfxBLBGZbXEHbrJZqNbJfrqwhmQ9q7sT0WMsChth8KkYFtOg1iclj3U/6jITKdGkNMWZxlFZ+AY6t4T2vrdfmwo2KZdtQb61rc5Y7unqr7O4s5x/5Sx57xqCWU8UileUhoh1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59584f41f1eso184009eaf.1;
        Wed, 07 Feb 2024 02:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301810; x=1707906610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaYs/0OBSn9a9M48gFnsjQUey6x4AH+ip/nGvUcn8J0=;
        b=bP2wHTchBkB98TWRiXvUO4q4FK/UJJEMUi5MgnqGF9Z+2RenQu0H93KLoQ5wbe+Pi1
         0SyLaJBn3YF+1q9YdugY5pohMhiR+/8C/ylbwyWEr0IUJsMLfPLmq+q0HkVGz32s+NwE
         hpihg5QKrUOuSYPBN90GbUDCDsRXZ/YI3DY4vCjiiePl9zo4B3sfrcjz8QMoeTcq9qmp
         A1QtGM86pFbn9QCamai0TLDyxUGch8S6dhOGRE8hkbv4C5OQ7NTe4ikOUZfDNHVjeow9
         3s6x41wtUUmoZhCoqZKJIT0VHyXxbD7lIhU9MJ1eDVxwXw0R83gF1mlW0EZC3iUC/W3R
         MNfA==
X-Forwarded-Encrypted: i=1; AJvYcCVtKAAlJWWQc3YIp3zFpBdcLVNlYg+V6hM/IG7+gYyKtIijUiaBJWDOpvys8QonZI182atadBhr1RLVKFdCLRMrJIcu7MlOV2PTMlVEDz3teL4QB6tKkOv+qOQXNk5+LRyVuXHEMMzmVGghdaH05Z+w2uC+vf/q1/W2wiTbkyu29zr/8A==
X-Gm-Message-State: AOJu0YzuRmfsf4YUsKxOvJ2cD8LHW94H7XXfvSoYWly1A6LlJLRLOYea
	vwyTEGzZ3nkikgfAgRTWQLVQFbc0rH83eil8xt8WXNtDHJnffCmxmr4xmsf5Y5xmZvis8jwKfMr
	Awoc4ogcRzt8+dqmUSFg9p+0z9gs=
X-Google-Smtp-Source: AGHT+IEZxeEmw8De5mcKtWQJEUZooNnQq9vhZEXf9W7OnNSsUBsGt70iBjLGluAEfu9O4CRDr1S1Bk7qXSdlamnS4KI=
X-Received: by 2002:a05:6820:82b:b0:59c:eb7b:c04e with SMTP id
 bg43-20020a056820082b00b0059ceb7bc04emr4451074oob.1.1707301810143; Wed, 07
 Feb 2024 02:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207084452.9597-2-drake@endlessos.org>
 <CAPpJ_edoG0dD4aHZiZShcFMoD2JLQhbh7nuUPzgMT_ZMySJ=VQ@mail.gmail.com>
In-Reply-To: <CAPpJ_edoG0dD4aHZiZShcFMoD2JLQhbh7nuUPzgMT_ZMySJ=VQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Feb 2024 11:29:57 +0100
Message-ID: <CAJZ5v0ikxjoJz7FDQ4dpCuY70w3LvAT5Tjitfzm9MDLdNyPF1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from
 suspend to idle by default"
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Daniel Drake <drake@endlessos.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, rafael@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:09=E2=80=AFAM Jian-Hong Pan <jhp@endlessos.org> w=
rote:
>
> Daniel Drake <drake@endlessos.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:45=E5=AF=AB=E9=81=93=EF=BC=9A
> >
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
> > Signed-off-by: Daniel Drake <drake@endlessos.org>
>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

What is this tag supposed to mean?

In a reply to a patch, you can give Acked-by, Reviewed-by or
Tested-by.  Which one do you mean?

> > ---
> >  drivers/acpi/sleep.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index 808484d112097..728acfeb774d8 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_ta=
ble[] __initconst =3D {
> >                 DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
> >                 },
> >         },
> > -       /*
> > -        * ASUS B1400CEAE hangs on resume from suspend (see
> > -        * https://bugzilla.kernel.org/show_bug.cgi?id=3D215742).
> > -        */
> > -       {
> > -       .callback =3D init_default_s3,
> > -       .ident =3D "ASUS B1400CEAE",
> > -       .matches =3D {
> > -               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > -               DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"=
),
> > -               },
> > -       },
> >         {},
> >  };
> >
> > --

