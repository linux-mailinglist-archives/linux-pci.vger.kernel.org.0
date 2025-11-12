Return-Path: <linux-pci+bounces-41027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41536C54A38
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 22:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0500F3AC472
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46C2E1C63;
	Wed, 12 Nov 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYDbErJu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB122DC338
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983506; cv=none; b=JJ6z4ta6gzL2rPlXV7vgRNZGOp/7txk4HTcxCW95JMMTQD7Yzs8h3QW4hwZk+W+B5vGVfMkWK6D9Z3IDuUQbyb6bIgVQ1AHItLVnWLWrJdglv5HJnJ2nkkvjN7JPIiTlNKpxHBmeSX1zQ7p1QKIehQcT6OVGDz6IpLHRABpECiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983506; c=relaxed/simple;
	bh=kJuIkLvSHwWWhGY0rIDCqACoepGxKTwg++6iKoxpkgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb3rHJrt1AIG5i+NkMthqzmysu04dB3k9XxeuSCIYYJ7njwCxpnzx+bzxhc9OUexUIDboH/LAcxUFK7UrOn/QQ9iDHjAwZAH0iOSDfVRW8PD87EPH6PuWsLZpNP1KLnattyESanGV+Xr1nE8RB0WTMsofJPb477XvbsLPhQo+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYDbErJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9EFC16AAE
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762983506;
	bh=kJuIkLvSHwWWhGY0rIDCqACoepGxKTwg++6iKoxpkgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UYDbErJunvhgKNYY4o6XrtmDW27UFy6msl6Ltd+gtUoyfxw5ENzkxV/hPuYvj+VCv
	 E8sRox/M1T4+xe/ZHKSZfI+asyylw86McNk3XXUFNK2LskzXYS+AR2vqDGgsA0W5i1
	 82VlsCYrqJZXGWN71TzHbPqL/QM7BsGbWgvlmcEFh6HRzA7mdW4V8o09O+QgdSeYGI
	 L+yC9q1T2hyWFbNkkMNIuCD9u6VtXPYF4Eoz7SQxDLbW4zUKSBd9wCRUNSHtWOI2j9
	 edGWBJ6405I3LJyFpCnmUtKbkRGOce2OPX40Hq4kSu1N9s7NSnvm3Re7HRPLxGOhF0
	 mtb45TXqe93GQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45085a4ab72so44565b6e.1
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 13:38:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpRQ824bUacKECh0qOnYOUy2PmKYm+VPtXXBLr3euzKbiyXtr1O7tB7UaC39w8It5ArFwWXLytKTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67GtriAz3175RQObOLc8/aor747NykBRKSCVOZgeKMWla+Umr
	olwMlqEqZqjnWOOQVKW2izyfZixRV9kPSDDPR/Hh5bD7o8vGQcv1tu/wiLjNW3p8w3IhWOnWW8V
	LEqHS/cc/3B9kQH8LIwSHyNQwFkfCp0A=
X-Google-Smtp-Source: AGHT+IFr8y7vuGeeebfdU2FLfgfK72tZdHVnb7ogJwqZqUj0ziPfYWjBqjf3ijtTyjxZTHoh/HIfqSk5hx82HnviRxs=
X-Received: by 2002:a05:6808:650a:b0:43f:b94a:14f2 with SMTP id
 5614622812f47-4507445ca4emr2233847b6e.16.1762983505781; Wed, 12 Nov 2025
 13:38:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13883374.uLZWGnKmhe@rafael.j.wysocki> <20251112063941.kbg44srt5f7rfkjb@lcpd911>
 <5068916.31r3eYUQgx@rafael.j.wysocki> <6914fbb5a6ce_1d911001b@dwillia2-mobl4.notmuch>
In-Reply-To: <6914fbb5a6ce_1d911001b@dwillia2-mobl4.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 22:38:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i0U=BYFH+QmeVjSpcyrVhVR0zjke3Vve3wxnpNzcDcoQ@mail.gmail.com>
X-Gm-Features: AWmQ_bn6YDvmk2NX9_6zpWQoI1iGQ5XBQQj83W27xBkXn5nlh_3iGLtRjukhi6U
Message-ID: <CAJZ5v0i0U=BYFH+QmeVjSpcyrVhVR0zjke3Vve3wxnpNzcDcoQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] PM: runtime: Wrapper macros for usage counter guards
To: dan.j.williams@intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dhruva Gole <d-gole@ti.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Frank Li <Frank.Li@nxp.com>, 
	Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, 
	Zhang Qilong <zhangqilong3@huawei.com>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:27=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Rafael J. Wysocki wrote:
> > On Wednesday, November 12, 2025 7:39:41 AM CET Dhruva Gole wrote:
> > > On Nov 07, 2025 at 19:35:09 +0100, Rafael J. Wysocki wrote:
> > > > Hi All,
> > > >
> > > > The runtime PM usage counter guards introduced recently:
> > > >
> > > > https://lore.kernel.org/linux-pm/6196611.lOV4Wx5bFT@rafael.j.wysock=
i/
> > > >
> > > > and then fixed:
> > > >
> > > > https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wysock=
i/
> > > >
> > > > should generally work, but using them feels sort of arcane and cryp=
tic
> > > > even though the underlying concept is relatively straightforward.
> > > >
> > > > For this reason, runtime PM wrapper macros around ACQUIRE() and
> > > > ACQUIRE_ERR() involving the new guards are introduced in this serie=
s
> > > > (patch [1/3]) and then used in the code already using the guards (p=
atches
> > > > [2/3] and [3/3]) to make it look more straightforward.
> > >
> > > The patches look okay to me,
> > > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> >
> > Thank you and Jonathan for the tags, but since Frank is not convinced, =
let me
> > bounce one more idea off all of you.
> >
> > Namely, I think that Frank has a point when he wonders if PM_RUNTIME_AC=
QUIRE_ERR
> > hides too much information and I agree with Jonathan that may be misund=
erstood,
> > so what about defining the wrapper macros so they don't hide the guard =
variable
> > name, like in the patch below?
>
> I had been reluctant about offering an enthusiastic tag on this series
> given that information hiding, but with this change:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks!

> However, I prefer that the scope variable declaration vs usage
> (reference) cases should maintain visual separation with an operator,
> i.e.:
>
>         PM_RUNTIME_ACQUIRE(dev, pm);
>         if (PM_RUNTIME_ACQUIRE_ERR(&pm))
>                 return -ENXIO;
>
> Otherwise we have a case of different flavors of *_ACQUIRE_ERR
> implementing various styles. I initially looked at hiding the '&':
>
> http://lore.kernel.org/681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch
>
> ...but it grew on me precisely because it provides a clue about how this
> magic operates.

Fair enough.

I'll resend the series with this change then.

Thank you!

