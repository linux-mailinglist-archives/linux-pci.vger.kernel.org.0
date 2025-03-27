Return-Path: <linux-pci+bounces-24894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32DAA74122
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 23:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717F7189255B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 22:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1842D1C6FED;
	Thu, 27 Mar 2025 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHKMPCzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACBF1B6D08
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115767; cv=none; b=rqRdpDDdh8BXFdDMkRf/54uukEZD/ovckxCm32e6qNJ3kZOtnHYyaQCvzqL68V4qzVBqGMqqqTaRK3oJX38QWCZIpJAkbdTRTl5yHV1b4sdbz6amhovb9sryMGX+5DsDs1EzVbehwYA7fyk8kQio5iyudvexpLQq6k6Tjo8IS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115767; c=relaxed/simple;
	bh=GqgiUgQzTuachwpE83erEBD5APQu6MQKKAcYqIQFXlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vk27G5LGN+mohY2jQ07n82xZWumAYqh3m6q4tq34DC2boGUJtC9PRCNgfkkF85cdEu0Uwqi4hfa9QLptCQ+LUgtgQX1BYtl3Dp0ePMtbnxnLarzskyoIrt7kMaCgzG5odCtktIez7NKS4rcQD+15L844i0pKHhShAn5/qq07wx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dHKMPCzN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so2707451a12.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743115763; x=1743720563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko96aC2XhNp3VJtoDCX6aRTYa+8MPfXvreAUPSIkGKU=;
        b=dHKMPCzNZzSRAKXCOfKkRcU467UcBCrZlHqfL+90uvQNQpLo9SQFBLkiYLbVCPH8KB
         /MpMB7kqvQbuJAK2giY7ZqwGxAuVToAuTM1st82o+1F1n0iEl0RD3AfY6OvztRETD16l
         M99Bo16194SJYmUzWlM8DM+aVNraQZDJVIkGZcjU6rorue0LJiwMUJSyJEiGxXYBA9Q2
         soDHKEtxTzAfH7o6av3I8hXr7VE7TpmUzV1nLRwRy6jIGe1GOWiQJ4FnFtW8sRj0z09Y
         dh5Bpalup+ubis16vtB7kJAG8tNl+w/kuDPfmldQ2XNXFdipRW7zYrKHeEETSyoeHxwZ
         L9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115763; x=1743720563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko96aC2XhNp3VJtoDCX6aRTYa+8MPfXvreAUPSIkGKU=;
        b=u5ioQ50XvY4Q4BH/kwsb4ZIZGm+lwin3xM+d+hHKUYPsdC8qE1utfXimGNX1WIakje
         Bo5eo/+EoexyJrbBOUTdaMpOeaADbmnVGgeO+ntbgXy6op2ejCzyGwMsY5Uiwpx7eqeH
         M+nvVpFBEPW6peSCIjXyVDRMlLSjRgWskObIa6OaGZ9AGdMfzHKNDyPltdIWlvO30sHk
         VR0jPT6FzxgwUYjl8JafJIm5BM7ZpZ/xOH+mWiM61+M8B3jQl99N7aLr4bfo3mTNU1lc
         SROPRSipMxeuT1coih9YSKeP+XFzuxQE7nzDFMSuh+s4OAl3nQOuNgIzpnN58YKXb6z3
         eTQg==
X-Forwarded-Encrypted: i=1; AJvYcCWLyXia65wCZi4qbSmtVOGTicIolyLG52DUWoZG8RY55ADWpa+dJ4b50nsUCUxPtUSsLFAh71fS1qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv372Il0wWZX/4RUhNrndrGQApRJyti+DOiYRrnrbmQRnRgW5E
	v7demfeZdobwloxfriPpRj9mcn6L0Y7oM0ski3tZAbmlNgcsF2+fCHnLsLVJkAgm2ABi1q+K0HT
	wvFCQ8Y1QpRB60JXuZ6qbjOLNZhrlK1Gttr9q
X-Gm-Gg: ASbGncv0MlhXW9XTBAFYjmYr5gpMYs0xS854Nbr/AwEbS8FQVA910CgSFTrVXyeEu/c
	DFMSG3EcGEUWbLcdzDXJFs1JCoEDpDLl7gR+u8Rcbpb5IXBuKULIElR+ctSgaVjblEHFjIt6tL3
	Tn0/wG1z3naz/GfE06AYlaavycVRf7NfmD0nXmP3bHjQdLOPW16uCB8Jip
X-Google-Smtp-Source: AGHT+IGGKipq49dbbFdsOX7HsBG2FTRBgE5W/r/BShtFy/x8Lij5Epzt2jZRXjgbqUdoInsNeqsqVGBUcWZwMS2KU5A=
X-Received: by 2002:a05:6402:278e:b0:5ec:9513:1eaa with SMTP id
 4fb4d7f45d1cf-5ed8ec1c0d3mr4670974a12.23.1743115763183; Thu, 27 Mar 2025
 15:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com> <20250321015806.954866-7-pandoh@google.com>
 <614abb3f-fd4f-40e1-8e22-3c58bc2314b0@paulmck-laptop>
In-Reply-To: <614abb3f-fd4f-40e1-8e22-3c58bc2314b0@paulmck-laptop>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 27 Mar 2025 15:49:12 -0700
X-Gm-Features: AQ5f1JpP2IjeV9NuRBqVrcp5w5q9OMnbZBgHlxQSbcX40YS3yaFBF2tCqCSl_U0
Message-ID: <CAMC_AXUNNCDVqUufwWHrXZU8URz3VzZL4ifwQaHf23e0BCTB0Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
To: paulmck@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 10:17=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(str=
uct pci_dev *dev)
> >
> >  struct aer_err_info {
> >       struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
> > +     bool ratelimited[AER_MAX_MULTI_ERR_DEVICES];
>
> In my stop-the-bleeding patch, I pass this as an argument to the function=
s
> needing it, but this works fine too.  Yes, this approach does consume
> a bit more storage, but I doubt that it is enough to matter.

The reason for the boolean array is that we want to eval/use the same
ratelimit for two log functions (aer_print_rp_info() and
aer_print_error()). In past versions[1], I removed aer_print_rp_info()
which simplified the ratelimit eval (i.e. directly eval within
aer_print_error()). However, others found it helpful to keep the root
port logs as it directly showed the linkage from interrupt on root
port -> error source device(s).

> The main concern is that either all information for a given error is
> printed or none of it is, to avoid confusion.  (There will of course be
> the possibility of partial drops due to buffer overruns further down
> the console-log pipeline, but no need for additional opportunities
> for confusion.)
>
> For this boolean array to provide this property, the error path for a
> given device must be single threaded, for example, only one interrupt
> handler at a time.  Is this the case?

I believe so. AER uses threaded irq where interrupt processing is done
by storing/reading info from a FIFO (i.e. serializes handling).

> > @@ -722,21 +750,31 @@ void aer_print_error(struct pci_dev *dev, struct =
aer_err_info *info,
> >  out:
> >       if (info->id && info->error_dev_num > 1 && info->id =3D=3D id)
> >               pci_err(dev, "  Error of this Agent is reported first\n")=
;
> > -
> > -     trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask)=
,
> > -                     info->severity, info->tlp_header_valid, &info->tl=
p);
> >  }
> >
> >  static void aer_print_rp_info(struct pci_dev *rp, struct aer_err_info =
*info)
> >  {
> >       u8 bus =3D info->id >> 8;
> >       u8 devfn =3D info->id & 0xff;
> > +     struct pci_dev *dev;
> > +     bool ratelimited =3D false;
> > +     int i;
> >
> > -     pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\=
n",
> > -              info->multi_error_valid ? "Multiple " : "",
> > -              aer_error_severity_string[info->severity],
> > -              pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
> > -              PCI_FUNC(devfn));
> > +     /* extract endpoint device ratelimit */
> > +     for (i =3D 0; i < info->error_dev_num; i++) {
> > +             dev =3D info->dev[i];
> > +             if (info->id =3D=3D pci_dev_id(dev)) {
> > +                     ratelimited =3D info->ratelimited[i];
> > +                     break;
> > +             }
> > +     }
>
> I cannot resist noting that passing a "ratelimited" argument to this
> function would make it unnecessary to search this array.  This would
> require doing rate-limiting checks in aer_isr_one_error(), which looks
> like it should work.  Then again, I do not claim to be familiar with
> this AER code.
>
> The "ratelimited" arguments would need to be added to
> aer_print_port_info(), aer_process_err_devices(), and aer_print_error().
> Maybe some that I have missed.  Or is there some handoff to
> softirq or workqueues that I missed?

We are not ratelimiting the root port, but the source device that
generated the interrupt on the root port. Thus, we have to search the
array at some point. We could bake this into the topology traversal
(link PCI ID with pci_dev) as another param to aer_error_info, but the
array is <=3D 8 (i.e. small).

The root port itself can generate AER notifications. Ratelimiting by
both its own errors as well as downstream devices will most likely
mask its own errors.

[1] https://lore.kernel.org/linux-pci/20250214023543.992372-2-pandoh@google=
.com/

Thanks,
Jon

