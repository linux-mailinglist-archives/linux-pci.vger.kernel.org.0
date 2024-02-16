Return-Path: <linux-pci+bounces-3621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57E858535
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 19:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A998FB24AC5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 18:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4A1353E2;
	Fri, 16 Feb 2024 18:29:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F62132C1E;
	Fri, 16 Feb 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108167; cv=none; b=e7ek9fxfkDD3osz3Ypcij2mksM6ozVqIWdVT0KShmk81AZJwZUhfL2QUSseVGDE0QfAYurh2CvqBruZob/0ukMxbtWQ2YEy8KdAvnATYtM0vYj1lV+2f4uomUMOD2mtJhszYhMLXE5v7Y3ds3Mah6tzZxQpMFd8UljzWNSf42kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108167; c=relaxed/simple;
	bh=Ne8xg4QKO8vlkGfaVlGWtJwENf4akY4EeRwI1yGSafI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZE2h3LvIJDg2fwFxEnblRt/60fU2z5SnPotkJgI4wENhAzudbbGqwtDtjUtcIntNY9iTPfeuh2jkbVAstHTST5BqLXiJJ72ty88Y406tMB8cMPcLhkG4qsua7JxXmGpyMY2IQAzkXJvsp10GMfbBZV8VwbBoW6wNyNtLORXLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2f6c7e623so255931a34.1;
        Fri, 16 Feb 2024 10:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108165; x=1708712965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xevg9rwR53zY/upqk61QtAld9IftUGoKfcejbCC75vc=;
        b=hQ6oCSkmtz7T/os6fWpS0WO4lm2b/c1BdGPCNTY0qRtV9pCCxkgTHKw8F5krItP+08
         LMugQeShnGI1Cl5NAJC6W4tDsFFvf9WuVqzUEfSUV1h/CsPQ2vnYprIhc4JqVBeT0X1V
         OZtpGhj51dfBJotYSqd0PwyTCPVGzpX7TF9Xvlr6YD+0j9hLRZ3x5+SoVoAbtKg13nW+
         Vu0pcNYpByDmo6CQGEEGGTp1bRDePN5lqgzDjNWdbQXcRbO8fL3yajCpEoqeSG/0HNrU
         cnErIyTxOcuTWxsIfOKUffah+fID1QruTdcVCMoPX0RF9hVI5SrziYcH1/JRCoxZQID0
         dCmw==
X-Forwarded-Encrypted: i=1; AJvYcCWCT6hgWES8rpBsOtYR+CZi0PWiDS1I0cTdUwZwSS88RTNCpA741d/ZiHtknpVy4GafsD/Vd/Uvc77yERcy7hrQScBYKartQWkZg6GF3Ho7ZO+KLca0nJGuL9uLyFnld/91/z/oTR6lYZDNl5CMTHU+5oUwBOKv3I1Y0PixoLIPH3cr8lyxtiZov9PfsvTcizEhzxYEE8twhCFVuHlG
X-Gm-Message-State: AOJu0YwXoVEwQlIlrUECTYZ56mnSSLMKrtdc+BdqQ+PTx6RRUPJ8jUIL
	7IUll0fsf1N8UqWGFbvYO97naAKFbRgCeWo8aMEd9C7Rn/8K0QNCebX6VoGq6bwmSSWXc5wdfh4
	5xo/PJsT3/IEJIIOUMM1ZhBDYGqw=
X-Google-Smtp-Source: AGHT+IGM/WZWmSVFsRu3sWU2hnItSwF4jUO+khGBGlZgVbdsDBhRjTBzXoZc5e8qhAHjFj/i7ZeDRh3n1JoBl2SaK8s=
X-Received: by 2002:a05:6820:1f8d:b0:59c:d8cd:ecee with SMTP id
 eq13-20020a0568201f8d00b0059cd8cdeceemr2830708oob.1.1708108165273; Fri, 16
 Feb 2024 10:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213074416.2169929-1-onkarnath.1@samsung.com>
 <CGME20240213074430epcas5p4c520bf2cce121cf5fa970eed429231a8@epcms5p3>
 <CAJZ5v0gBrc0FctEswQj_JMcZRqoswRgXvBRzT++tseUWBgYJWA@mail.gmail.com> <20240216054540epcms5p3b0b3f97fe4ec4a8126549a579e596910@epcms5p3>
In-Reply-To: <20240216054540epcms5p3b0b3f97fe4ec4a8126549a579e596910@epcms5p3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Feb 2024 19:29:14 +0100
Message-ID: <CAJZ5v0h7Ed2VWPdsa_=m-PDfgOj2rCSUF=FEbpTEBg1Y9+PZ1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: use %pe for better readability of errors
 while printing
To: onkarnath.1@samsung.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"bristot@redhat.com" <bristot@redhat.com>, "vschneid@redhat.com" <vschneid@redhat.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Rohit Thapliyal <r.thapliyal@samsung.com>, 
	Maninder Singh <maninder1.s@samsung.com>, "helgaas@kernel.org" <helgaas@kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 6:54=E2=80=AFAM Onkarnath <onkarnath.1@samsung.com>=
 wrote:
>
> >On Tue, Feb 13, 2024 at 9:20=E2=80=AFAM Onkarnarth <onkarnath.1@samsung.=
com> wrote:
> >>
> >> From: Onkarnath <onkarnath.1@samsung.com>
> >>
> >> As %pe is already introduced, it's better to use it in place of (%ld) =
for
> >> printing errors in logs. It would enhance readability of logs.
> >>
> >> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> >
> >What exactly is the role of this S-o-b?  Has the person helped you to
> >develop the patch or something else?
> >
>
> Yes It was meant for Co-developed tag, Because We are working collectivel=
y for making errors more readable for our product kernel.(5.4)
> And some part of this patch was made by him.
>
> Then we checked that it is also suggested by open source to have %pe for =
printing errors:
> https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mo=
untain/
>
> So I prepared same changes for open source kernel, and because of smaller=
 patch I kept it as normal signed-off tag only.
> If it is needed I can resend with Co-developed tag.

No need, I can add it for you.  Thanks for the explanation!

